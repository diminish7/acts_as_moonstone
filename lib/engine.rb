module Acts
  module Moonstone
    class Engine < ::Moonstone::Engine
      
      #Creates a Lucene document from an ActiveRecord object
      def doc_from(record)
        if record.respond_to?(:indexables)
          doc = Lucene::Document::Doc.new
          record.indexables.each do |indexable|
            doc.add_field(indexable.to_s, record.send(indexable))
          end
          doc
        end
      end
      
    end
  end
end