require 'rails_helper'

describe "Items API" do
  it "can grab all items" do
    items = create_list(:item, 10)

    get "/api/v1/items"

    expect(response).to be_success

    contents = JSON.parse(response.body)

    expect(contents.count).to eq(10)
    expect(contents.first["name"]).to eq(items.first.name)
  end

  it "can get a single item" do
    item = create(:item)

    get "/api/v1/items/#{item.id}"

    expect(response).to be_success

    content = JSON.parse(response.body)

    expect(content["id"]).to eq(item.id)
    expect(content["name"]).to eq(item.name)
    expect(content["description"]).to eq(item.description)
    expect(content["image_url"]).to eq(item.image_url)
  end

  it "can delete a single item" do
    item = create(:item)

    expect(Item.count).to eq(1)

    delete "/api/v1/items/#{item.id}"

    expect(response).to have_http_status(204)
    expect(Item.count).to eq(0)
    expect{Item.find(item.id)}.to raise_exception(ActiveRecord::RecordNotFound)
  end

end

# When I send a POST request to `/api/v1/items` with a name, description, and image_url
# I receive a 201 JSON  response if the record is successfully created
# And I receive a JSON response containing the id, name, description, and image_url but not the created_at or updated_at
#
# * Verify that your non-GET requests work using Postman or curl. (Hint: `ActionController::API`). Why doesn't the default `ApplicationController` support POST and PUT requests?
