# Foreign Travel Content Checker

This is a standard [Ruby on Rails](https://rubyonrails.org/) app that checks to see if a number of desired sections exist - and have content - on the ['Entry requirements'](https://www.gov.uk/foreign-travel-advice/spain/entry-requirements) section of each country of within the [Foreign travel advice](https://www.gov.uk/foreign-travel-advice) country pages.

These pages are maintained within the [Travel Advice Publisher](https://github.com/alphagov/travel-advice-publisher) application by the [Foreign, Commonwealth &amp; Development Office (FCDO)](https://www.gov.uk/government/organisations/foreign-commonwealth-development-office).

The app is intended as a temporary service, so it:

* is intended for use by the GDS Coronavirus team and the FCDO content design team as a means of checking the Foreign Travel Advice 'Entry requirements' section for completeness.
* does not conform to the principles set out in [The GDS Way](https://gds-way.cloudapps.digital/).
* has a deadline of 1st June 2022, beyond this date the application will cease to function.

![Screenshot](/app/assets/images/ui.png)

## Technical documentation

### Installing dependencies

This is a standard Ruby on Rails app. It's only external dependency is a locally running PostgreSQL database instance.

```sh
bundle install
```

### Create the database

```sh
rails db:create
rails db:migrate
```

### Run the app

```sh
rails server
```

The app will then be available at [http://localhost:3000/](http://localhost:3000/)

Initially, the database will be empty. To populate it, click on the `Update` link or run the `db:update` rake task.

Clicking on the `Completed` link will return a sorted list of completed country slugs (i.e. those countries with all of the required `Entry requirements` sections present and containing content).

### Testing the app

```sh
rails test
```

## Licence

[MIT License](/LICENSE.md)
