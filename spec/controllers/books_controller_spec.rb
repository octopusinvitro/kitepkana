require "rails_helper"

RSpec.describe BooksController do
  describe "#index" do
    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "#new" do
    it "renders the new template" do
      get :new
      expect(response).to render_template("new")
    end
  end

  describe "#create" do
    def create_book(attributes = {})
      post :create, book: {
        "title":    "new book",
        "filename": "filename.pdf"
      }.merge(attributes)
    end

    it "redirects to book overview" do
      create_book
      expect(response).to redirect_to(root_path)
    end

    it "contains a success message" do
      create_book
      expect(flash[:notice]).to include("created book new book")
    end

    it "creates a new book" do
      create_book
      newest_book = Book.last
      expect(newest_book.title).to eq("new book")
      expect(newest_book.filename).to eq("filename.pdf")
    end

    it "does not create a new book with validation errors" do
      create_book(title: "")
      expect(Book.all).to be_empty
    end

    it "re-renders the form again on errors" do
      create_book(title: "")
      expect(response).to render_template("new")
    end

    it "contains an error message for invalid books" do
      create_book(title: "")
      expect(flash.now[:alert].first).to include("Title")
    end
  end
end
