module TasksHelper
  def link_or_image(object)
    if (object.file.content_type.split('/')[0] == 'image')
      image_tag object.file.url
    else
      link_to object.file_identifier, object.file.url
    end
  end
end
