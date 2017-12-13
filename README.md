# Jekyll::StickyPosts

*Version 1.0.0*

*StickyPosts* is a plugin for [Jekyll](https://jekyllrb.com/) that sticks/pins posts marked `sticky: true` to the top, i.e. it moves them  before all others. Optionally, the posts could also appear where they normally would.

### Why do this?

1. You want to keep important announcements, etc. at the top of your home page

## Installation

Add the gem to your application's Gemfile:

```ruby
group :jekyll_plugins do
  # other plugins here
  gem 'jekyll-stickyposts'
end
```

And then execute:

    $ bundle

Or install it yourself:

    $ gem install jekyll-stickyposts

## Configuration

No configuration is required to run *StickyPosts*. If you want to tweak its behavior, you may set the following options in `_config.yml`:

```yaml
stickyposts:
  #enabled: false   # Enable StickyPosts; default: true
  debug: true       # Show additional info; default: false
  sort: "blah"      # Optional sort field; default: "date", use "none" to avoid sorting
  reverse: true     # Ascending order, default: false
  retain: true      # Also show sticky posts in their original positions; default: false
```

> Note: if you set `sort` to `"none"` and don't sort as described in the next section, Jekyll will re-sort the documents by date. This may move the sticky posts out of position.

## Usage

If you're not using a paginator, use something like:

```html
{% assign sorted = site.posts | sort: "stickiness" %}
{% for post in sorted %}
...etc...
{% endfor %}
```

If you're using a paginator that allows sorting on fields, e.g. [jekyll-paginate-v2](https://github.com/sverrirs/jekyll-paginate-v2/), you need to edit your `_config.yml` a bit:

```yaml
pagination:
  # ...
  sort_field: "stickiness"
  reverse: false
  # ...

# ...etc...

stickyposts:
  #sort: "date"   # or your original pagination sort_field
  #reverse: true  # ditto for the pagination reverse
  # ...etc...
```

No changes will be required in your pagination setup:

```html
{% for post in paginator.posts %}
...etc...
{% endfor %}
```
## Additional configuration

You may want to mark sticky posts with e.g. a pin from [FontAwesome](http://fontawesome.io/):

```html
{% if post.sticky %}
  <span class="sticky"><i class="fa fa-thumb-tack" aria-hidden="true"></i></span>
{% endif %}
```

## Demo

See the [author's blog](https://ibrado.org/) for a (possible) demo.

## Contributing

1. Fork this project: [https://github.com/ibrado/jekyll-stickyposts/fork](https://github.com/ibrado/jekyll-stickyposts/fork)
1. Clone it (`git clone git://github.com/your_user_name/jekyll-stickyposts.git`)
1. `cd jekyll-stickyposts`
1. Create a new branch (e.g. `git checkout -b my-bug-fix`)
1. Make your changes
1. Commit your changes (`git commit -m "Bug fix"`)
1. Build it (`gem build jekyll-stickyposts.gemspec`)
1. Install and test it (`gem install ./jekyll-stickyposts-*.gem`)
1. Repeat from step 3 as necessary
1. Push the branch (`git push -u origin my-bug-fix`)
1. Create a Pull Request, making sure to select the proper branch, e.g. `my-bug-fix` (via https://github.com/*your_user_name*/jekyll-stickyposts)

Bug reports and pull requests are welcome on GitHub at [https://github.com/ibrado/jekyll-stickyposts](https://github.com/ibrado/jekyll-stickyposts). This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct
Everyone interacting in the Jekyll::StickyPosts project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/jekyll-stickyposts/blob/master/CODE_OF_CONDUCT.md).
