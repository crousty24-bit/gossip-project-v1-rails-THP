class PrivateMessage < ApplicationRecord
  belongs_to :recipient, class_name: "User" #set sender&recipient as ALIAS of User
  belongs_to :sender, class_name: "User"
end
