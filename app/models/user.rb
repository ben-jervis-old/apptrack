class User < ApplicationRecord
	attr_accessor :remember_token, :activation_token, :reset_token

	belongs_to :company, optional: true

	has_secure_password

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	validates :first_name, 	presence: true, length: { maximum: 50 }
	validates :last_name, 	presence: true, length: { maximum: 50 }
	validates :email, 			presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
	validate 	:level_must_be_valid
	validates :password, length: { minimum: 8 }, on: [:create, :update_password]
	validates :password_confirmation, presence: true, on: [:create, :update_password]

	before_save :check_level
	before_save { self.email = email.downcase }
	before_create :create_activation_digest

	def name
		"#{self.first_name} #{self.last_name}"
	end

	def is_admin?
		self.level == 'admin'
	end

	def remember
		self.remember_token = User.new_token
		update_attribute(:remember_digest, User.digest(remember_token))
	end

	def authenticated?(attribute, token)
		digest = send("#{attribute}_digest")
		return false if digest.nil?
		BCrypt::Password.new(digest).is_password?(token)
	end

	def forget
		update_attribute(:remember_digest, nil)
	end

	def User.digest(string)
		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
		BCrypt::Password.create(string, cost: cost)
	end

	def User.new_token
		SecureRandom.urlsafe_base64
	end

	def activate
		user.update_attribute(:activated, true)
		user.update_attribute(:activated_at, Time.zone.now)
	end

	def send_activation_email
		UserMailer.account_activation(self).deliver_now
	end

	def create_reset_digest
		self.reset_token = User.new_token
		update_attribute(:reset_digest, User.digest(reset_token))
		update_attribute(:reset_sent_at, Time.zone.now)
	end

	def send_password_reset_email
		UserMailer.password_reset(self).deliver_now
	end

	def password_reset_expired?
		reset_sent_at < 2.hours.ago
	end

	private
		def check_level
			self.level.downcase!
		end

		def check_birthdate
		end

		def level_must_be_valid
			if self.level.nil?
				errors.add(:level, "can't be blank")
			elsif !(%w(staff admin).include?(self.level.downcase))
				errors.add(:level, "must be either a staff or admin")
			end
		end

		def create_activation_digest
			self.activation_token = User.new_token
			self.activation_digest = User.digest(activation_token)
		end
end
