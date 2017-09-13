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

  it "can post a singel item" do
    valid_attributes = { item: { name: "new_name",
                         description: "new_description",
                         image_url: "new_image" } }

    post "/api/v1/items", params: { item: valid_attributes }

    new_item = Item.last
    content = JSON.parse(response.body)
    expect(response.status).to eq(201)

    expect(content["name"]).to eq(valid_attributes[:name])
    expect(content["description"]).to eq(valid_attributes[:description])
    expect(content["image_url"]).to eq(valid_attributes[:image_url])

  end
end
