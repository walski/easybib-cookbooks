require_relative 'spec_helper'

describe 'easybib_deploy_manager' do

  let(:cookbook_paths) do
    [
      File.expand_path("#{File.dirname(__FILE__)}/../../"),
      File.expand_path("#{File.dirname(__FILE__)}/")
    ]
  end

  let(:runner) do
    ChefSpec::Runner.new(
      :cookbook_path => cookbook_paths,
      :log_level => :debug,
      :step_into => %w(
        easybib_deploy_manager
        easybib_deploy
        easybib_nginx)
    )
  end

  let(:node) { runner.node }
  let(:fixture) { 'fixtures::easybib_deploy_manager_broken_apps' }

  context 'no deployments' do
    before do
      node.set['deploy'] = {}
    end

    it 'logs when no applications are configured' do
      # @chef_run = runner.converge(fixture)
      # expect(Chef::Log).to receive(:info).with('easybib_deploy_manager: No apps configured')
      # expect(@chef_run).to deploy_easybib_deploy_manager('fixtures')
      pending 'need to explore how to assert on Chef::Log in a LWRP'
    end

    context 'apps but no deploy' do
      before do
        node.set['fixtures']['applications'] = {
          :app_number_one => {},
          :app_number_two => {}
        }
      end

      it 'does not call easybib_deploy' do
        @chef_run = runner.converge(fixture)

        %w(app_number_one app_number_two).each do |application|
          expect(@chef_run).not_to deploy_easybib_deploy(application)
          expect(@chef_run).not_to setup_easybib_nginx(application)
        end
      end
    end
  end

  context 'deployments' do
    before do
      node.set['deploy'] = {
        :app_number_one => {
          :deploy_to => '/var/www/app1',
          :document_root => 'www',
          :domains => %w( example.org )
        },
        :app_number_two => {
          :deploy_to => '/var/www/app2',
          :document_root => 'htdocs',
          :domains => %w( app2.example.org example2.org )
        }
      }

      node.set['fixtures']['applications'] = {
        :app_number_one => {
          :layer => 'app-server',
          :nginx => 'silex.erb.conf'
        },
        :app_number_two => {
          :layer => 'app-server',
          :nginx => 'silex.erb.conf'
        }
      }

      node.set['opsworks'] = {
        :instance => {
          :layers => ['app-server']
        },
        :stack => {
          :name => 'chefspec'
        }
      }

      @chef_run = runner.converge('fixtures::easybib_deploy_manager')
    end

    it 'deploys an app' do
      expect(@chef_run).to deploy_easybib_deploy_manager('fixtures')

      deploy_manager = @chef_run.easybib_deploy_manager('fixtures')
      expect(deploy_manager).to notify('execute[foo]').to(:run).delayed

      %w( app_number_one app_number_two).each do |application|
        expect(@chef_run).to deploy_easybib_deploy(application)
        expect(@chef_run).to setup_easybib_nginx(application)
      end
    end
  end
end
