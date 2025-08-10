ActiveSupport.on_load :turbo_streams_tag_builder do
    def scroll_to(target)
        action :scroll_to, target
    end
end