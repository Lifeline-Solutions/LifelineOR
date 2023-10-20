
![](https://img.shields.io/badge/Microverse-blueviolet)
# Rails Lifeline

> This is a 2FA Application that uses Ruby on Rails and TailwindCSS
## Link
``
``
## Video link
- [Video link]()
## ERD
![image]()

### Cloning the project

git clone <Your-Build-Directory>
``` 
- cd LifelineOR
```


## Built with
- Ruby 3.1.2 on Rails 7.0.8
- PostgreSQL

## Prerequisites

RubyMine
Setup

## Install
    Ruby
    Rails
    PostgreSql

### Development Database

```
# Sign into posgresql
su - postgres

# Create user
create user 'user_name' with encrypted password 'mypassword'

# Load the schema
rails db:schema:load

#----- If you want prefer this approach
# Create the database
rake db:create

# Create database Migration
rails db:migrate
```

### Set Up the Encryption Salt
- Open Terminal and run the following command
```
 - bin/rails db:encryption:init
```
- Results will be

```angular2html
active_record_encryption:
  primary_key: {secret}
  deterministic_key: {secret}
  key_derivation_salt: {secret}

```
- Copy the above result and paste it on the creditials.
```angular2html
- Windows (For windows Rubymine and VSCode)
    Rubymine = EDITOR="rubymine --wait" ./bin/rails creditials:edit
    VSCode = EDITOR="code --wait" ./bin/rails creditials:edit

- Macbook (You may have to copy the ruby mine path)
    EDITOR="/Applications/RubyMine.app/Contents/MacOS/rubymine --wait" ./bin/rails creditials:edit
        or use vim
    EDITOR="vim" bin/rails credentials:edit

```
### Run

```
bundle install

- ./bin/dev
```

## Run tests
```
bundle install
rspec
```



## Authors

👤 **AbolGer**

- GitHub: [@ger619](https://github.com/ger619)
- Twitter: [@ger_abol](https://twitter.com/ger_abol)
- LinkedIn: [David Ger](https://linkedin.com/in/david-ger-426b4576)


## 🤝 Contributing

Contributions, issues, and feature requests are welcome!

Feel free to check the [issues page](https://github.com/ger619/rails-capstone/issues).

## Design

Original design idea by [Gregoire Vella](https://www.behance.net/gregoirevella) on Behance.
The Creative Commons license of the design requires that you give appropriate credit to the author.
## Show your support

Give a ⭐️ if you like this project!

## 📝 License

This project is [MIT](./MIT.md) licensed.
