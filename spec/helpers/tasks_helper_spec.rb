require 'rails_helper'
require 'pp'
require 'carrierwave/test/matchers'

# Specs in this file have access to a helper object that includes
# the TasksHelper. For example:
#
# describe TasksHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe TasksHelper, type: :helper do

  describe '#link_or_image' do
    include CarrierWave::Test::Matchers

    let(:user) { create(:user) }

    it 'return link on document' do
      task = create(:task, user: user,
                    file: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'factories', 'files', 'test_task.pdf')))

      expect(helper.link_or_image(task)).to  have_xpath('//a')
    end

  end

end
