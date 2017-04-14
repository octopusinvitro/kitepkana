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

  describe "#edit" do
    let(:book) {Book.create!(title: "title", filename: 'filename.pdf')}

    it "renders the edit template" do
      get :edit, id: book.id
      expect(response).to render_template("edit")
    end

    it "finds the book to edit" do
      get :edit, id: book.id
      expect(assigns(:book)).to be_truthy
    end
  end

  describe "#update" do
    let(:book) {Book.create!(title: "old title", filename: 'filename.pdf')}

    def update_book(attributes = {})
      patch :update, id: book.id, book: {
        "title":    "title",
        "filename": "filename"
      }.merge(attributes)
    end

    it "redirects to book overview" do
      update_book(id: book.id)
      expect(response).to redirect_to(root_path)
    end

    it "contains a success message" do
      update_book(id: book.id, title: "new title")
      expect(flash[:notice]).to include("updated book new title")
    end

    it "updates a book" do
      update_book(id: book.id,
                  title: "updated title",
                  filename: "updated-filename.pdf")
      book.reload
      expect(book.title).to eq("updated title")
      expect(book.filename).to eq("updated-filename.pdf")
    end

    it "does not update a book with validation errors" do
      old_title = book.title
      update_book(id: book.id,
                  title: nil,
                  filename: "irrelevant")
      book.reload
      expect(book.title).to eq(old_title)
    end

    it "re-renders the form again on errors" do
      update_book(id: book.id, title: "")
      expect(response).to render_template("edit")
    end

    it "contains an error message for invalid books" do
      update_book(id: book.id, title: "")
      expect(flash.now[:alert].first).to include("Title")
    end
  end

  describe "#show" do
    let(:book) {Book.create!(title: "title", filename: "filename.pdf")}

    it "renders the show template" do
      get :show, id: book.id
      expect(response).to render_template("show")
    end
  end
end
