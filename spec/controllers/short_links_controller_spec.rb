require 'rails_helper'

RSpec.describe ShortLinksController, type: :controller do
  let(:short_link) {ShortLink.create(original_url: 'www.google.com')}

  describe "GET new page" do
    it "renders new page" do
      get :new

      expect(response.status).to eq(200)
      expect(response).to render_template(:new)
    end
  end

  describe "#create" do
    subject {post :create, params: {short_link: {original_url: 'www.google.com'}}}

    it "redirects to short_url(@short_url)" do
      expect(subject).to redirect_to(short_link_url(assigns(:short_link)))
    end

    it "redirects_to(@short_link)" do
      expect(subject).to redirect_to(assigns(:short_link))
    end

    it "redirects_to /short_links/:id with an encrypted id" do
      expect(subject).to redirect_to("/short_links/#{Obfuscate.encrypt(assigns(:short_link).id)}")
    end
  end

  describe "#redirect_to_original_url" do
    subject {get :redirect_to_original_url, params: {short_url: short_link.id}}

    it 'should redirect to the correct original url' do
      expect(subject).to redirect_to(short_link.original_url)
    end

    it 'should increment the count by 1 when original url is visited' do
      expect {subject}.to change {short_link.reload.view_count}.by(1)
    end

    context 'when short_link is expired' do
      let(:short_link) {ShortLink.create(original_url: 'www.google.com', expired: true)}

      it 'should redirect to 404' do
        expect {subject}.to raise_error(ActionController::RoutingError)
      end
    end
  end

  describe "#admin" do
    subject {get :admin, params: {id: Obfuscate.encrypt(short_link.id)}}

    it "renders the admin page" do
      expect(subject).to render_template(:admin)
    end
  end

  describe "#update" do
    subject {patch :update, params: {id:  Obfuscate.encrypt(short_link.id), commit: 'Expire'}}

    it "renders the show page and should expire short link" do
      expect(subject).to redirect_to("/short_links/#{Obfuscate.encrypt(assigns(:short_link).id)}")
      expect(short_link.reload.expired).to equal(true)
    end
  end
end
