module Admin
end
class Admin::BaseController < ApplicationController
  cattr_accessor :look_for_migrations
  @@look_for_migrations = true
  layout 'administration'
  before_filter :login_required, :except => [ :login, :signup ]
  before_filter :look_for_needed_db_updates, :except => [:login, :signup, :update_database, :migrate]

  def create_fck_editor
    current_user.editor = 2
    current_user.save!
    render :partial => "fckeditor"
  end
  
  def create_simple_editor
    current_user.editor = 0
    current_user.save!
    render :partial => "simple_editor"
  end
  
  private
  def look_for_needed_db_updates
    if Migrator.offer_migration_when_available
      redirect_to :controller => '/admin/settings', :action => 'update_database' if Migrator.current_schema_version != Migrator.max_schema_version
    end
  end

  def sweep_cache
    PageCache.sweep_all  
  end
end
