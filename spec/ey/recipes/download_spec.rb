require 'spec_helper'

describe "ey recipes download" do
  given "integration"

  after(:each) do
    FileUtils.rm_rf('cookbooks')
  end

  def command_to_run(opts)
    cmd = "recipes download"
    cmd << " --environment #{opts[:env]}" if opts[:env]
    cmd
  end

  def verify_ran(scenario)
    @out.should =~ /Recipes downloaded successfully for #{scenario[:environment]}/
    File.read('cookbooks/README').should == "Remove this file to clone an upstream git repository of cookbooks\n"
  end

  it_should_behave_like "it takes an environment name"

  it "fails when cookbooks/ already exists" do
    api_scenario "one app, one environment"
    Dir.mkdir("cookbooks")
    ey "recipes download", :expect_failure => true
    @err.should match(/cookbooks.*already exists/i)
  end
end
