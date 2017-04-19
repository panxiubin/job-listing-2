class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  def admin?
    is_admin
  end

  has_many :resumes

  has_many :job_relationships
  has_many :applied_jobs, :through => :job_relationships, :source => :job
  has_many :participated_jobs, :through => :job_relationships, :source => :job

  def has_applied?(job)
    applied_jobs.include?(job)
  end

  def apply!(job)
    applied_jobs << job
  end

  def is_member_of?(job)
    participated_jobs.include?(job)
  end
end
