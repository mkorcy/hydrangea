require "hydra"

# 2011-04-10
#
# My take on what our faculty publication content model is going to look like
# in ActiveFedora
#
# Since we're new to activefedora rather than drive yourself nuts make sure to read
# the rdoc on activefedora: http://rdoc.info/github/mediashelf/active_fedora/master/file/README.textile#
#


class TuftsFacultyPublication < ActiveFedora::Base
  
  include Hydra::ModelMethods

  # I haven't quite worked out how this works or if its relevant for us.
  has_relationship "parts", :is_part_of, :inbound => true
  
  # Uses the Hydra Rights Metadata Schema for tracking access permissions & copyright
  has_metadata :name => "rightsMetadata", :type => Hydra::RightsMetadata 

  # Tufts specific needed metadata streams
  has_metadata :name => "DCA-META", :type => TuftsDcaMeta

  # DCA_admin might be the one that we have started clearing out -- it used to have metadata
  # but it was all wrong, so now we're just putting it in as empty.
  #has_metadata :name => "DCA-ADMIN", :type => ActiveFedora::Datastream


  #MK 2011-04-13 - Are we really going to need to access FILE-META from FILE-META.  I'm guessing
  # not.
  has_metadata :name => "FILE-META", :type => TuftsFileMeta

  #Our Binary streams
  #has_datastream :name=>"Access.xml", :type=>ActiveFedora::Datastream, :controlGroup=>'E'
  #has_datastream :name=>"Archival.pdf", :type=>ActiveFedora::Datastream, :controlGroup=>'E'

  #def initialize()
  ##    super()
  #    ds = ActiveFedora::Datastream.new(:dsid=> "Access.xml", :label => "Access.xml", :controlGroup => "M", :dsLocation => "", :mimeType=> "text/xml")
  ##    add_datastream(ds)
   #   ds = ActiveFedora::Datastream.new(:dsid=> "Archival.pdf", :label => "Archival.pdf", :controlGroup => "M", :dsLocation => "", :mimeType=> "text/xml")
   #   add_datastream(ds)
  #end

  def to_solr(solr_doc=Hash.new,opts={})
    super
    #logger.info("Error encountered trying to output solr_doc details for pid: #{pid}")
    ::Solrizer::Extractor.insert_solr_field_value(solr_doc, "object_type_facet", "Faculty Publication")
   # ::Solrizer::Extractor.insert_solr_field_value(solr_doc, "clean_id_t", "tufts:UA005_036_001_00001")

    return solr_doc
  end

end
