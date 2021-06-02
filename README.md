## Simple Mail Validator

### Install Steps

1. Clone the repo
2. Install the gems using `bundle install`
3. Install the packages using `yarn install`
4. Set up the DB schema using `rails db:migrate`
5. Enable the app caching using `rails dev:cache`
6. Copy .env.example to .env file using `cp .env.example .env`
7. Set the access key value in `.env` file

### Run the App
You can now run the application using `rails s`.
The app could be accessed from the browser on port `3000`.

### Considerations
MailboxLayer's API usage limit is sensitive.
There are 4 measures to optimize the app for this limitation:
1. Low-level caching on email-basis. Assumption is that an email's existence usually doesn't change within a day. Or even if it does, not much harm done.
2. Search the list of already collected email addresses before starting the lookup.
3. Pre-filtering of invalid name or url input.
4. Delay 1s before initiating a request. Several requests within 1s usually gets rate-limitation error from the API.

*These measures are temporary because of the free plan of MailboxLayer*
