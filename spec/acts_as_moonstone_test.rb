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
  
  describe "Access to the index" do
    
    before :each do
      clean_index
      Contact.delete_all
      Company.delete_all
      @company = Company.new(:name => "Awesome, Inc")
      @company.save.should be_true
      @contact = Contact.new(:first_name => "Jason", :last_name => "Rush", :company => @company)
      @contact.save.should be_true
    end
    
    it "should add a record to the index" do
      @contact.add_to_index
      Acts::Moonstone::ENGINE.doc_count.should == 1
      q = Lucene::Search::TermQuery.new("first_name", "jason")
      docs = Acts::Moonstone::ENGINE.search(q)
      docs.length.should == 1
      docs.first["first_name"].should == "Jason"
    end
    
    it "should remove a record from the index" do
      @contact.add_to_index
      Acts::Moonstone::ENGINE.doc_count.should == 1
      q = Lucene::Search::TermQuery.new("first_name", "jason")
      docs = Acts::Moonstone::ENGINE.search(q)
      docs.length.should == 1
      @contact.remove_from_index
      docs = Acts::Moonstone::ENGINE.search(q)
      docs.length.should == 0
    end
    
    it "should update a record in the index" do
      @contact.add_to_index
      Acts::Moonstone::ENGINE.doc_count.should == 1
      q = Lucene::Search::TermQuery.new("first_name", "jason")
      docs = Acts::Moonstone::ENGINE.search(q)
      docs.length.should == 1
      @contact.update_attribute(:first_name, "Shannon")
      @contact.update_in_index
      Acts::Moonstone::ENGINE.doc_count.should == 1
      docs = Acts::Moonstone::ENGINE.search(q)
      docs.length.should == 0
      q = Lucene::Search::TermQuery.new("first_name", "shannon")
      docs = Acts::Moonstone::ENGINE.search(q)
      docs.length.should == 1
      docs.first["first_name"].should == "Shannon"
    end
    
  end
  
  describe "#index()" do
    before :each do
      clean_index
      Contact.delete_all
      Company.delete_all
      @company = Company.create(:name => "Awesome, Inc")
      @contact = Contact.create(:first_name => "A", :last_name => "Person", :company => @company)
      @contact2 = Contact.create(:first_name => "Some", :last_name => "Body", :company => @company)
      @contact3 = Contact.create(:first_name => "Someone", :last_name => "Else", :company => @company)
      @contact4 = Contact.create(:first_name => "OneMore", :last_name => "Person", :company => @company)
    end
    
    it "should create an index and add all records to the index" do
      Contact.count.should == 4
      Contact.index
      Acts::Moonstone::ENGINE.doc_count.should == 4
    end
  
    it "should use an existing index and replace all records in the index" do
      Contact.count.should == 4
      Contact.index
      Acts::Moonstone::ENGINE.doc_count.should == 4
      Contact.index
      Acts::Moonstone::ENGINE.doc_count.should == 4
    end
  end
  
end