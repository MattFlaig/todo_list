require 'spec_helper'

describe User do
  it {should validate_presence_of(:email)}
  it {should validate_uniqueness_of(:email)}
  it {should validate_presence_of(:password)}
  it {should validate_presence_of(:username)}
  it {should have_many(:todo_items)}
end