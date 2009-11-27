require File.join(File.dirname(__FILE__), 'spec_helper')

describe Acts::Moonstone::Engine do
  
  it "should create a Lucene Document from an ActiveRecord object" do
    engine = Acts::Moonstone::Engine.new
    company = Company.new(:name => "Awesome, Inc")
    company.save.should be_true
    contact = Contact.new(:first_name => "Jason", :last_name => "Rush", :company => company)
    contact.save.should be_true
    doc = engine.doc_from(contact)
    doc["id"].should == contact.id.to_s
    doc["first_name"].should == "Jason"
    doc["last_name"].should == "Rush"
    doc["full_name"].should == "Jason Rush"
    doc["company_name"].should == "Awesome, Inc"
    doc["class"].should == "Contact"
  end
  
end