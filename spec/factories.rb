Factory.define :user do |user|
  user.name                   "Travis Douce"
  user.email                  "tdouce@example.com"
  user.password               "foobar"
  user.password_confirmation  "foobar"
end

#Creates unique emails, which is required by our app due to
# our validation
Factory.sequence :email do |n|
  "person-#{n}@example.com"
end

# creates content for the micropost and associates the
# content with a user (in the user model)
Factory.define :micropost do |micropost|
  micropost.content "Foo bar"
  micropost.association :user
end
