namespace :db do
  desc 'Erase and fill database with fake data'
  task populate: :environment do
    require 'factory_girl_rails'
    require 'database_cleaner'

    DatabaseCleaner.clean_with(:truncation, :only => %w[tasks users])

    FactoryGirl.create(:user,
      email: 'admin@tskmanager.com',
      password: '12345678',
      password_confirmation: '12345678',
      role: 'admin'
    )

    10.times do
      user = FactoryGirl.create :user
      3.times do
        FactoryGirl.create(:task, user: user)
      end

    end

  end
end
