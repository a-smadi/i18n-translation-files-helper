+[![Code Climate](https://codeclimate.com/github/a-smadi/i18n-translation-files-helper.png)](https://codeclimate.com/github/a-smadi/i18n-translation-files-helper)

# i18n-translation-files-helper

rake tasks to make adding translations faster

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

## Limitations

This project was created with support for English and Arabic languages only.
