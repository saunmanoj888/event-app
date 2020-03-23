module ApplicationHelper

	def conditional_link(args)
    if !args[:disabled]
      return link_to args[:string], args[:url], class: args[:klass]
    else 
      return args[:string]
    end
  end
end
