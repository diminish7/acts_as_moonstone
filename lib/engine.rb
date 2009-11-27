module Acts
  module Moonstone
    class Engine < ::Moonstone::Engine
      
      #Creates a Lucene document from an ActiveRecord object
      def doc_from(record)
        raise "Can't index an unsaved record" if record.new_record?
        raise "Can't index a record that does not act as moonstone" unless record.respond_to?(:indexables)
        doc = Lucene::Document::Doc.new
        record.indexables.each do |indexable|
          value = record.send(indexable)
          puts "#{indexable} (#{indexable.class}) --> #{value} (#{value.class})"
          doc.add_field(indexable.to_s, value.to_s) unless value.nil?
        end
        doc.add_field("class", record.class.to_s)
        doc
      end
      
    end
  end
end