# connect
ActiveRecord::Base.establish_connection :adapter => "jdbcsqlite3", :database => ":memory:"

# create model table
ActiveRecord::Schema.define(:version => 1) do
  create_table :companies do |t|
    t.string :name
    t.string :address
    t.string :city
    t.string :state
    t.string :zip
  end
 
  create_table :contacts do |t|
    t.string :first_name
    t.string :last_name
    t.integer :company_id
  end
end

# create models
class Company < ActiveRecord::Base
  acts_as_moonstone
end

class Contact < ActiveRecord::Base
  belongs_to :company
  acts_as_moonstone :include => [:full_name, :company_name], :exclude => [:company_id]
  
  def full_name
    "#{self.first_name} #{self.last_name}"
  end
  
  def company_name
    self.company.name if self.company
  end
end
  