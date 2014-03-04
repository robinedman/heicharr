class Employee < ActiveRecord::Base
  validates :name, presence: true
  validates :salary, presence: true, numericality: true
  
  def to_s
    department = self.department ? self.department : "no department"
    "#{self.name} (#{department})"
  end
end
