# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def remove_child_link(name, f)
    f.hidden_field(:_delete) + link_to_function(name, "remove_fields(this)")
  end
  
  def remove_child_button(name, f)
    f.hidden_field(:_delete) + button_to_function(name, "remove_fields(this)")
  end
  
  def add_child_link(name, f, method)
    fields = new_child_fields(f, method)
    link_to_function(name, h("insert_fields(this, \"#{method}\", \"#{escape_javascript(fields)}\")"))
  end
  
  def new_child_fields(form_builder, method, options = {})
    options[:object] ||= form_builder.object.class.reflect_on_association(method).klass.new
    options[:partial] ||= method.to_s.singularize
    options[:form_builder_local] ||= :f
    form_builder.fields_for(method, options[:object], :child_index => "new_#{method}") do |f|
      render(:partial => options[:partial], :locals => { options[:form_builder_local] => f })
    end
  end
  
  def add_child_button(name, f, method)
    fields = new_child_fields(f, method)
    button_to_function(name, h("insert_fields(this, \"#{method}\", \"#{escape_javascript(fields)}\")"))
  end
  
  def add_child_iWebKit_button(name,f,method, options = {})
    fields = new_child_fields(f, method, options)
    basic_button = button_to_function(name, h("insert_fields($('#{name.sub(" ","_")}_ul'), \"#{method}\", \"#{escape_javascript(fields)}\")"))
    button = "<ul class=\"pageitem\" id=\"#{name.sub(" ","_")}_ul\"><li class=\"button\">#{basic_button}</li></ul>"
  end
end
