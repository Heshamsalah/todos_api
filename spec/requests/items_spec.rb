require 'rails_helper'
require 'byebug'

RSpec.describe "Items API", type: :request do
    # Initialize Data
    let!(:todo) { create(:todo) }
    let!(:items) { create_list(:item, 20, todo_id: todo.id) }
    let(:todo_id) { todo.id }
    let(:item_id) { items.first.id }

    describe "GET /todos/:todo_id/items" do
        before { get "/todos/#{todo_id}/items" }

        context "records found" do
            it "return status code 200" do
                expect(response).to have_http_status(200)
            end

            it "return items" do
                expect(json).to_not be_empty
                expect(json.size).to eq(20)
            end
        end

        context "records not found" do
            let(:todo_id) { 200 }

            it "return status code 404" do
                expect(response).to have_http_status(404)
            end

            it "return a not found message" do
                expect(response.body).to match(/Couldn't find Todo/)
            end
        end
    end

    describe "GET /todos/:todo_id/items/:item_id" do
        before { get "/todos/#{todo_id}/items/#{item_id}" }

        context "record found" do
            it "return status code 200" do
                expect(response).to have_http_status(200)
            end

            it "return the item" do
                expect(json['id']).to eq(item_id)
            end
        end

        context "record not found" do
            let(:item_id) { 0 }

            it "return status code 404" do
                expect(response).to have_http_status(404)
            end

            it "return a not found message" do
                expect(response.body).to match(/Couldn't find Item/)
            end
        end
    end

    describe "POST /todos/:todo_id/items" do
        let(:attributes) { { name: "Finish Task", done: false } }
        before { post "/todos/#{todo_id}/items", params: attributes }

        context "record found" do
            it "return status code 201" do
                expect(response).to have_http_status(201)
            end
        end

        context "record not found" do
            let(:attributes) { { done: false } }

            it "return status code 422" do
                expect(response).to have_http_status(422)
            end

            it "return a not found message" do
                expect(response.body).to match(/Validation failed: Name can't be blank/)
            end
        end
    end

    describe "PUT /todos/:todo_id/items/:item_id" do
        let(:attributes) { { name: "Lorem Ipsum", done: true } }
        before { put "/todos/#{todo_id}/items/#{item_id}", params: attributes }

        context "record found" do
            it "return status code 204" do
                expect(response).to have_http_status(204)
            end

            it "update item" do
                updated_item = Item.find item_id
                expect(updated_item.id).to eq(item_id)
            end
        end

        context "record not found" do
            let(:item_id) { 100 }

            it "return status code 404" do
                expect(response).to have_http_status(404)
            end

            it 'returns a not found message' do
                expect(response.body).to match(/Couldn't find Item/)
            end
        end
    end

    describe "DELETE /todos/:todo_id/items/:item_id" do
        before { delete "/todos/#{todo_id}/items/#{item_id}" }

        context "record found" do
            it "return status code 204" do
                expect(response).to have_http_status(204)
            end
        end

        context "record not found" do
            let(:item_id) {0}

            it "return status code 404" do
                expect(response).to have_http_status(404)
            end

            it 'returns a not found message' do
                expect(response.body).to match(/Couldn't find Item/)
            end
        end
    end
end
