# Include hook code here
require 'typo_related_posts_plus'

ActiveRecord::Base.send :include, TypoRelatedPostsPlus
