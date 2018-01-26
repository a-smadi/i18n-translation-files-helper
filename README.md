[![Maintainability](https://api.codeclimate.com/v1/badges/d0d09bd3a7fca784b038/maintainability)](https://codeclimate.com/github/a-smadi/i18n-translation-files-helper/maintainability)

# i18n-translation-files-helper

rake tasks to better manage i18n translation files within Ruby on Rails projects.

## Installing

as these are rake tasks, installation is pretty straight forward.
Add this directory to `lib/tasks` on your existing Rails project.

## Running the tasks

Currently theres only a single task `add_t` which automatically adds the translation record to the file it reckons suitable, depending on the language detected in the provided value.

The task accepts 2 arguments, a key, value pair for the desired translation to be added.

PS: The key can be in snake_case or CamelCase.

```
rake add_t hello_world "Hello, World!"
```
and
```
rake add_t HelloWorld "Hello, World!"
```
are both acceptable.


Also, adding both translations for the same key at once is possible, as such:

```
rake add_t hello_world "Hello, World!" "مرحبا"
```
PS: precednece of values doesn't have any effect, as long as the key comes first, so
```
rake add_t hello_world "مرحبا" "Hello, World!"
```
is also acceptable.

## Limitations

This project was created with support for English and Arabic languages only.
