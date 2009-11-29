module Acts
  module Moonstone
    
    module InProcessInstanceMethods
      
      #Adds this ActiveRecord object to the index. Does not check for duplicates
      def add_to_index
        ENGINE.insert_document(self)
      end
      
      #Removes this ActiveRecord object from the index
      def remove_from_index
        terms = [
            { :field => "id", :value => self.id.to_s },
            { :field => "class", :value => self.class.to_s }
          ]
        ENGINE.delete_documents(terms)
      end
      
      #Removes this ActiveRecord object from the index, then readds it, updating the index with the current values
      def update_in_index
        remove_from_index
        add_to_index
      end
      
    end
    
    module InProcessClassMethods
      
      #Reindexes all objects of this class - removes them if they exist, then readds them
      def index(options = {})
        #Remove all docs for this class from the index (if the index exists already)
        ENGINE.delete_document(:field => 'class', :value => self.class.to_s) if Lucene::Index::IndexReader.index_exists(INDEX)
        current_offset = 0
        limit = options[:batch_size] || 500
        #Add each object of this class back into the index
        until (objects = all(:limit => limit, :offset => current_offset)).empty?
          ENGINE.index(objects, false)
          current_offset += limit
        end
        #Optimize the index
        ENGINE.optimize
      end
      
    end
    
  end
end