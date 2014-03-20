require 'spec_helper'

describe TodoItem do
  it {should validate_presence_of(:comment)}
  it {should validate_presence_of(:content)}
  it {should validate_presence_of(:name)}
  it {should validate_presence_of(:deadline)}
  it {should belong_to(:user)}
end