require_relative 'test_helper'

describe Spinach do
  before do
    @feature_steps1 = OpenStruct.new(feature_name: 'User authentication')
    @feature_steps2 = OpenStruct.new(feature_name: 'Slip management')
    @feature_steps3 = OpenStruct.new(feature_name: 'File attachments')
    @feature_steps4 = OpenStruct.new(name: 'UserSendsAMessage')
    [@feature_steps1, @feature_steps2,
      @feature_steps3, @feature_steps4].each do |feature|
      Spinach.feature_steps << feature
    end
  end

  describe '#features' do
    it 'returns all the loaded features' do
      Spinach.feature_steps.must_include @feature_steps1
      Spinach.feature_steps.must_include @feature_steps2
      Spinach.feature_steps.must_include @feature_steps3
    end
  end

  describe '#reset_features' do
    it 'resets the features to a pristine state' do
      Spinach.reset_feature_steps
      [@feature_steps1, @feature_steps3, @feature_steps3].each do |feature|
        Spinach.feature_steps.wont_include feature
      end
    end
  end

  describe '#find_feature_steps' do
    it 'finds a feature by name' do
      Spinach.find_feature_steps('User authentication').must_equal @feature_steps1
      Spinach.find_feature_steps('Slip management').must_equal @feature_steps2
      Spinach.find_feature_steps('File attachments').must_equal @feature_steps3
    end

    describe 'when a feature class does no set a feature_name' do
      it 'guesses the feature class from the feature name' do
        Spinach.find_feature_steps('User sends a message').must_equal @feature_steps4
      end

      it 'returns nil when it cannot find the class' do
        Spinach.find_feature_steps('This feature does not exist').must_equal nil
      end
    end
  end
end
