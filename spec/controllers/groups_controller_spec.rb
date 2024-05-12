# frozen_string_literal: true

# spec/controllers/groups_controller_spec.rb

require 'rails_helper'

RSpec.describe GroupsController, type: :controller do
  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'assigns all groups as @groups' do
      group = Group.create(name: 'Test Group')
      get :index
      expect(assigns(:groups)).to eq([group])
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      group = Group.create(name: 'Test Group')
      get :show, params: { id: group.to_param }
      expect(response).to have_http_status(:success)
    end

    it 'assigns the requested group as @group' do
      group = Group.create(name: 'Test Group')
      get :show, params: { id: group.to_param }
      expect(assigns(:group)).to eq(group)
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new
      expect(response).to have_http_status(:success)
    end

    it 'assigns a new group as @group' do
      get :new
      expect(assigns(:group)).to be_a_new(Group)
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new group' do
        expect do
          post :create, params: { group: { name: 'Test Group' } }
        end.to change(Group, :count).by(1)
      end

      it 'redirects to the created group' do
        post :create, params: { group: { name: 'Test Group' } }
        expect(response).to redirect_to(group_path(Group.last))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new group' do
        expect do
          post :create, params: { group: { name: nil } }
        end.not_to change(Group, :count)
      end

      it 'renders the new template' do
        post :create, params: { group: { name: nil } }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid parameters' do
      let(:group) { Group.create(name: 'Test Group') }

      it 'updates the requested group' do
        patch :update, params: { id: group.to_param, group: { name: 'Updated Group' } }
        group.reload
        expect(group.name).to eq('Updated Group')
      end

      it 'redirects to the group' do
        patch :update, params: { id: group.to_param, group: { name: 'Updated Group' } }
        expect(response).to redirect_to(group_path(group))
      end
    end

    context 'with invalid parameters' do
      let(:group) { Group.create(name: 'Test Group') }

      it 'does not update the group' do
        patch :update, params: { id: group.to_param, group: { name: nil } }
        group.reload
        expect(group.name).to eq('Test Group')
      end

      it 'renders the edit template' do
        patch :update, params: { id: group.to_param, group: { name: nil } }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:group) { Group.create(name: 'Test Group') }

    it 'destroys the requested group' do
      expect do
        delete :destroy, params: { id: group.to_param }
      end.to change(Group, :count).by(-1)
    end

    it 'redirects to the groups list' do
      delete :destroy, params: { id: group.to_param }
      expect(response).to redirect_to(groups_url)
    end
  end

  describe 'PATCH #update_user_role' do
    let(:group) { Group.create(name: 'Test Group') }
    let(:user) { User.create(first_name: 'John', last_name: 'Doe') }
    let(:ua) { UserGroupAssociation.create(user:, group:, role: 'participant') }

    it 'updates the user role in the group' do
      ua.reload
      patch :update_user_role, params: { id: group.to_param, user_id: user.to_param, role: 'organizer' }
      user.reload
      expect(group.organizers.pluck(:user_id)).to include(user.id)
    end

    it 'redirects to the group' do
      patch :update_user_role, params: { id: group.to_param, user_id: user.to_param, role: 'organizer' }
      expect(response).to redirect_to(group_path(group))
    end
  end

  describe 'POST #add_user_to_group' do
    let(:group) { Group.create(name: 'Test Group') }
    let(:user) { User.create(first_name: 'Jane', last_name: 'Doe') }

    it 'adds user to the group' do
      post :add_user_to_group, params: { id: group.to_param, user_group_association: { user_id: user.id } }
      group.reload
      expect(group.users).to include(user)
    end

    it 'redirects to the edit group page' do
      post :add_user_to_group, params: { id: group.to_param, user_group_association: { user_id: user.id } }
      expect(response).to redirect_to(edit_group_path(group))
    end

    it 'does not add user if already in the group' do
      group.users << user
      post :add_user_to_group, params: { id: group.to_param, user_group_association: { user_id: user.id } }
      expect(flash[:alert]).to eq('Invalid user or user already in the group.')
    end
  end
end
