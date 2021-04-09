# frozen_string_literal: true

require 'chanCrawlerGem/version'
require 'dotenv/load'
require 'httparty'
require 'pry'
require 'nokogiri'
require 'open-uri'
require 'down'
require 'fileutils'

module ChanCrawlerGem
  class Error < StandardError; end
  Dotenv.require_keys('BASE_URL', 'BOARDS', 'DEST_FOLDER', 'KEY_WORDS')

  class Collector
    attr_reader :boards, :key_words, :relevant_links

    def initialize(boards, key_words)
      @relevant_links = []
      @boards = boards
      @@base_url = ENV['BASE_URL']
      @key_words = key_words
    end

    def board_catalog_urls
      # puts 'Getting catalogs'
      catalogs = {}
      boards.each { |board| catalogs[board] = "http://a.4cdn.org/#{board}/catalog.json" }
      catalogs
    end

    def thread_relevant?(thread)
      return false if thread['com'].nil?

      # puts "Checking thread relevancy for #{thread['com']}"
      @key_words.each do |word|
        return false unless thread['com']
                            .downcase
                            .include?(word.downcase) && thread['images']
                            .positive?
      end
    end

    def analyze_threads(threads, board)
      # puts 'Analyzing thread list'
      threads.each do |thread|
        if thread_relevant?(thread)
          relevant_links.push "#{@@base_url}#{board}/thread/#{thread['no']}"
        end
      end
    end

    def get_relevant_threads
      # puts 'Retrieving relevant threads'
      catalogs = board_catalog_urls
      catalogs.each do |board, catalog|
        catalog_content = JSON.parse(HTTParty.get(catalog).body)
        next if catalog_content.count < 1

        catalog_content.each do |page|
          next unless page['threads'].count.positive?

          analyze_threads(page['threads'], board)
        end
      end
      # puts 'Relevant threads retrieved'
    end
  end

  class DownloadManager
    attr_reader :download_dest

    def initialize(download_destination)
      @download_dest = download_destination
    end

    def get_thread_contents(thread)
      # puts "Parsing #{thread} for content"
      document = Nokogiri::HTML(URI.open(thread))
      results = document.css('.board .fileThumb')
      result_links = results.map { |t| t[:href] }
    end

    def download_thread_contents(urls)
      urls.each do |url|
        download(url) if already_present?(url) == false
      end
    end

    def download(resource_url)
      puts "Downloading #{resource_url}"
      tmpfile = Down.download("http:#{resource_url}")
      FileUtils.mv(tmpfile.path, "#{download_dest}#{tmpfile
                                                      .original_filename}")
      puts 'Downloaded successfully'
    end

    def already_present?(item_name)
      name = item_name.slice(15, item_name.length)
      false unless File.file?("#{download_dest}/#{name}")
    end
  end

  def self.give_me_the_documents
    collector = ChanCrawlerGem::Collector.new(ENV['BOARDS'].split(','),
                                              ENV['KEY_WORDS'].split(','))
    collector.get_relevant_threads
    downloader = ChanCrawlerGem::DownloadManager.new(ENV['DEST_FOLDER'])
    collector.relevant_links.each do |thread|
      downloader.download_thread_contents(downloader
                                            .get_thread_contents(thread))
    end
  end
end
