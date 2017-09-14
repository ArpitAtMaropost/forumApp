class ProjectTopic < Topic
  alias_attribute :project_title, :title
  alias_attribute :project_description, :title
end