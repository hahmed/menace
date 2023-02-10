# Menace

POC for Active Storage blob authentication that's real simple to set up.

Credit https://github.com/rails/rails/pull/41505#issuecomment-782782926

## Usage

First define the `Menace::Current.resource` a Current attribute, inside your controller. This object is passed into the authorize_blob to authenticate the resource.

Setup your active storage model, for example:

```ruby
class User < ApplicationRecord
  has_one_attached :avatar
  has_one_attached :cover_photo
  has_many_attached :documents
end
```

Then define your authorization for the entire User class or for each attachment.

```ruby
class User < ApplicationRecord
  has_one_attached :avatar
  has_one_attached :cover_photo
  has_many_attached :documents

  def authorize_blob?(accessor)
    # your logic here or return true
    true
  end
end
```

When a blob of any of the types (avatar, cover_photo of documents) is accessed, it will be authorized.

To setup different authorization for different attachment types:


```ruby
class User < ApplicationRecord
  has_one_attached :avatar
  has_one_attached :cover_photo
  has_many_attached :documents

  def authorize_blob_avatar?(accessor)
    true
  end
end
```

Or mix and match, note the fallback method is `authorize_blob?` which is used in case a specific attachment method is not defined.


```ruby
class User < ApplicationRecord
  has_one_attached :avatar
  has_one_attached :cover_photo
  has_many_attached :documents

  def authorize_blob_avatar?(accessor)
    true
  end

  def authorize_blob_documents?(accessor)
    false
  end

  def authorize_blob?(accessor)
    true
  end
end
```

## Installation
Add this line to your application's Gemfile:

```ruby
gem "menace"
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install menace
```

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
