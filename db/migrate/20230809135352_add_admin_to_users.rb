class AddAdminToUsers < ActiveRecord::Migration[7.0]
  def change
    ## Set the default value of `admin` to `false`:
    add_column :users, :admin, :boolean, default: false
  end
end
