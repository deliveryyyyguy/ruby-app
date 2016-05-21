require 'test_helper'

class CategoryTest < ActiveSupport::TestCase

	def setup
		#runs before everyone of your tests
		@category = Category.new(name: "discount")
		
	end

	test "category should be valid" do
		#active record assertion for testing
		#Check if valid
		assert @category.valid?
	
	end

	test "name should be present" do
		@category.name = " "
		assert_not @category.valid?

	end

	test "name should be unique" do
		@category.save
		category2 = Category.new(name: "discount")
		assert_not category2.valid?

	end

	test "name should not be too long" do
		@category.name = "a" * 26
		assert_not @category.valid?
	end

	test "name should not be too short" do
		@category.name = "aa"
		assert_not @category.valid?
	end

end