require 'spec_helper'
describe 'hp_operationsagent' do

  context 'with defaults for all parameters' do
    it { should contain_class('hp_operationsagent') }
  end
end
