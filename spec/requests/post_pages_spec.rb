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
				expect { click_link "delete" }.to_not change(Post, :count).by(-1)
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


end
