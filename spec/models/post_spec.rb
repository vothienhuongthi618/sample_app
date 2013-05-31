require 'spec_helper'

describe Post do

  let(:user) { FactoryGirl.create(:user) }
  before do
    @post = user.posts.build(body: "This is the first post.", state: 2, title: "First Post")
  end

  subject { @post }

  it { should respond_to(:body) }
  it { should respond_to(:state) }
  it { should respond_to(:title) }
  it { should respond_to(:user_id) }
  its(:user) { should == user }

  it { should be_valid }

  describe "accessible attributes" do
    it "should not allow access to user_id" do
      expect do
        Post.new(user_id: user.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end    
  end

  describe "when user_id is not present" do
    before { @post.user_id = nil }
    it { should_not be_valid }
  end

  describe "with blank body" do
    before { @post.body = " " }
    it { should_not be_valid }
  end

  describe "with title that is too long" do
    before { @post.title = "a" * 141 }
    it { should_not be_valid }
  end

  describe "with title that is blank" do
    before { @post.title = " " }
    it { should_not be_valid }
  end


end