require 'spec_helper'

describe "PostPages" do
  	subject { page }

	let(:user) { FactoryGirl.create(:user) }
	before(:each) { sign_in user }

	describe "post destruction" do
		before { FactoryGirl.create(:post, user: user) }

		describe "as correct user" do
			before { visit root_path }

			it "should delete a post" do
				expect { click_link "delete" }.to change(Post, :count).by(-1)
			end
		end
	end
	describe "post update" do
		before { FactoryGirl.create(:post, user: user) }

		describe "as correct user" do
			before do
			  visit root_path
			  click_link "edit" 
			end

			describe "should go to the update page" do
			    it { should have_selector('h1',text: 'Edit post') }
			end
		end
	end
	describe "post creation" do 
		before { visit root_path }

		describe "with invalid information" do
			it "should not create a post" do
				expect { click_button "Post" }.not_to change(Post, :count)
			end

			describe "error messages" do
				before { click_button "Post" }
				it { should have_content('error') }
			end
		end

		describe "with valid information" do
			before {
				fill_in 'post_title', with: "trial post"
				fill_in 'post_body', with: "body of the trial post"
			}
			it "should create a post" do
				expect {click_button "Post" }.to change(Post, :count).by(1)
			end
		end
	end
end
