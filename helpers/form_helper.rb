require 'sinatra/reloader'

module Sinatra
	module FormHelper

		def form_open(record, options={})
			# form_open(party, {method: "patch"})
			if options[:method]
				method = options[:method]
				#form_open(Party.new)
			else
				method = record.persisted? ? 'get' : 'post'
			end
			action = resource_index_path(record.class.to_s.downcase)
			open_form_tag(action, method, record)
		end

		def open_form_tag(action, method, record)
			full_action = [action, record.id].compact.join("/")
			str = ""
			if ["delete", "patch", "put"].include?(method)
				str << "<form action='#{full_action}' method='post'>"
				str << "<input type='hidden' name='_method' value='#{method}' />"
			else
				str << "<form action='#{full_action}' method='#{method}'>"
			end
		end

		def input_tag(options={})
      type = options[:type]
      resource = options[:resource]
      name = options[:name] #name='party[num_guests]'
      value = options[:value]
      if value.class == String 
      	value.gsub!("'") {""}
      end
      placeholder = options[:placeholder]
      if @food == nil && type == 'submit'
      	value = 'Create'
      elsif @food != nil && type == 'submit'
      	value = 'Edit'
      else
      end
      "<input type='#{type}' name='#{resource}[#{name}]' value='#{value}'' placeholder='#{placeholder}'/>"
    end

		def form_close()
			"</form>"
		end

	end
	helpers FormHelper
end