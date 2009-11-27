require File.join(File.dirname(__FILE__), 'spec_helper')

describe Acts::Moonstone do
  
  it "should include the ActiveRecord object's attributes in the indexables list" do
    company = Company.new    
    [:name, :address, :city, :state, :zip].each do |field|
      company.indexables.include?(field).should be_true
    end
  end
  it "should not include any of the ActiveRecord object's attributes that are included in the :exclude options" do
    contact = Contact.new
    contact.indexables.include?(:company_id).should be_false
  end
  it "should include any additional methods specified in the :include options" do
    contact = Contact.new
    [:full_name, :company_name].each do |method|
      contact.indexables.include?(method).should be_true
    end
  end
  
end