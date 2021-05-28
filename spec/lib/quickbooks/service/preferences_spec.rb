describe "Quickbooks::Service::Preferences" do
  before(:all) do
    construct_service :preferences
  end

  it "can query for preferences" do
    xml = fixture("preferences_query.xml")
    model = Quickbooks::Model::Preferences

    stub_http_request(:get, @service.url_for_query, ["200", "OK"], xml)
    preferences_query = @service.query
    expect(preferences_query.entries.count).to eq(1)

    preferences = preferences_query.entries.first
    expect(preferences.accounting_info.customer_terminology).to eq("Customers")
  end

  it "cannot sparse update a preference" do

    # stub_http_request(:get, @service.url_for_query, ["200", "OK"], xml)
    # preferences_query = @service.query
    # expect(preferences_query.entries.count).to eq(1)
    # binding.pry
    # preferences = preferences_query.entries.first
    # binding.pry

    xml = fixture("preferences.xml")
    pref = Quickbooks::Model::Preferences.from_xml(xml)
    # pref.sales_forms.allow_shipping=true

    service = Quickbooks::Service::Preferences.new

    response = @service.update(pref, :sparse => false)
    expect(response.sales_forms.allow_shipping?).to eq true
    # update_response = @service.update(preferences, :sparse => true)
    # expect(preferences.accounting_info.customer_terminology).to eq("Customers")

    # pref = Quickbooks::Model::Preferences.new
    # expect(pref.valid_for_update?).to eq false
  end

end
