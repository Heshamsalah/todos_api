require 'rails_helper'

RSpec.describe "Todos API", type: :request do
    # Initialize test data
    let!(:todos) { create_list(:todo, 10) }
    let(:todo_id) { todos.first.id }

    # GET /todos
    describe "GET /todos" do
        # Make HTTP get request before each example
        before { get "/todos" }

        it 'return status code 200' do
            expect(response).to have_http_status(200)
        end

        it 'returns todos' do
            expect(json).not_to be_empty
            expect(json.size).to eq(10)
        end
    end

    # GET /todos/:id
    describe "GET /todos/:id" do
        before { get "/todos/#{todo_id}" }

        context "record found" do
            it "return status code 200" do
                expect(response).to have_http_status(200)
            end

            it "returns the todo record" do
                expect(json).not_to be_empty
                expect(json['id']).to eq(todo_id)
            end
        end

        context "record not found" do
            # set some none existing id
            let(:todo_id) { 100 }

            it "return status code 404" do
                expect(response).to have_http_status(404)
            end

            it "returns a not found message" do
                expect(response.body).to match(/Couldn't find Todo/)
            end
        end
    end

    # POST /todos
    describe "POST /todos" do
        # create valid payload
        let(:valid_attributes) { { title: "Satoshi Nakamoto", created_by: '1' } }
        let(:invalid_attributes) { { title: "invalid" } }

        context "valid attributes" do
            before { post "/todos", params: valid_attributes }

            it "return status code 201" do
                expect(response).to have_http_status(201)
            end

            it "creates the todo" do
                expect(json['title']).to eq(valid_attributes[:title])
            end
        end

        context "invalid attributes" do
            before { post "/todos", params: invalid_attributes }

            it "return status code 422" do
                expect(response).to have_http_status(422)
            end

            it "return message with the error" do
                expect(response.body).to match(/Validation failed: Created by can't be blank/)
            end
        end
    end

    # PUT /todos/:id
    describe "PUT /todos/:id" do
        let(:valid_attributes) { { title: "Updated title" } }
        before { put "/todos/#{todo_id}", params: valid_attributes }

        context "record found" do
            it "return status code 204" do
                expect(response).to have_http_status(204)
            end

            it "return empty body" do
                expect(response.body).to be_empty
            end
        end

        context "record not found" do
            let(:todo_id) { 500 }

            it "return status code 404" do
                expect(response).to have_http_status(404)
            end
        end
    end

    # DELETE /todos/:id
    describe "DELETE /todos/:id" do
        context "record found" do
            before { delete "/todos/#{todo_id}" }

            it "return status code 204" do
                expect(response).to have_http_status(204)
            end

            it "return empty body" do
                expect(response.body).to be_empty
            end
        end

        context "record not found" do
            let(:todo_id) { 500 }
            before { delete "/todos/#{todo_id}" }

            it "return status code 404" do
                expect(response).to have_http_status(404)
            end
        end
    end
end
