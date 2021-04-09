# ChanCrawlerGem

This gem scowers 4chan (or any chan copy theoretically) searching for threads that
contains key words specified by you on boards specified by you and downloads
all the images, gifs and webms to a specified folder

## Installation


```ruby
gem 'chanCrawlerGem'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install chanCrawlerGem

## Usage

Set up a .env following the pattern described in the .env_template and then run ChanCrawlerGem.give_me_the_documents
as shown in the example.rb file. In facut, simply running the example.rb file after creating the .env will work just fine

So just to be clear here's a step by step:
### Step 1 Create .env file

For this step use the .env_template provided and fill in the desired values

### Step 2 Create a downloads directory

Create the directory and put it's path in the DEST_FOLDER variable

### Step 3 Create the script

Create a simple script that requires the gem and runs the "give_me_the_documents" method like so

```ruby
require 'chanCrawlerGem'

ChanCrawlerGem.give_me_the_documents
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the ChanCrawlerGem project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/chanCrawlerGem/blob/master/CODE_OF_CONDUCT.md).
