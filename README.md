# cocoapods-xcframework

Create XCFramework and install XCFramework.

## Installation
Clone or download this repo.

    $ gem build cocoapods-xcframework.gemspec
    $ gem install cocoapods-xcframework-0.0.1.gem

## Create XCFramework

make sure `pod install` first.
```BASH
$ pod xcframework POD_NAME
```

## Install XCFramework

We have a `Podfile`.

```ruby
target 'Test' do
  use_frameworks!

  pod 'Kingfisher'
end
```

Pod will install sources by default. For use XCFramework:

1. Create `cocoapods-xcframework.json` file in the same directory with `Podfile`.
```json
{
  "Kingfisher": "https://github.com/onevcat/Kingfisher/releases/download/5.14.0/Kingfisher-5.14.0.zip"
}
```
2. just `pod install`!

## TODO
vendored_frameworks is `**/#{spec.root.name}.xcframework`.

zip is a xcframework will not work.
