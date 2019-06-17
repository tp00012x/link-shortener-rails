# Link Shortener

So let's make a link shortener. Let's make it with rails. Let's use Postgres.

## Features

1. Root should render a form in which you can drop a URL. When you do,
   you'll get redirected to a page with its shortened URL and an admin URL.
1. When you go to a shortened URL, you should be redirected to the
   original URL that was submitted, as long as the URL is active. Also
   count the usage.
1. When you go to the Admin URL, you should be given the ability to
   expire the shortened link and see how many times your link has been used.
   When a link has been expired, render an empty 404.

## Other thoughts

1. Your solution should be scalable but not insanely so. If we handed this
   to our marketing people and they made 1k urls a day each getting hit 20k
   times a day, would it fall over? Will we talk about scaling to
   higher numbers in person?
1. It doesn't have to be pretty. Render HTML on the backend or the
   frontend, whatever is easier for you. This should be a 2-3 hour
   project.
1. Don't just use a link shortener gem. ಠ_ಠ
1. What is a link shortener? You should be able to shorten a long URL like
   `https://www.example.com/really/long/path?with=query_params` to something
   much shorter. Shortened URL would be something like `http://localhost/s/xYz123`. Think [goo.gl](https://goo.gl/) or [TinyUrl](http://tinyurl.com/).
1. The URL for the link admin page should be obfuscated. Think [craigslist](https://www.craigslist.org/about/help/free-edit).
