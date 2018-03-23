require "rails_helper"
require "books/presenter"

RSpec.describe BooksController do
  describe "#index" do
    render_views

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end

    it "has a list of books" do
      get :index
      expect(assigns(:books)).to be_an(Array)
    end

    it "wraps the books in a presenter" do
      book = Book.create!(title: "title", filename: "filename.pdf")
      get :index
      expect(assigns(:books).first).to be_a(Books::Presenter)
    end
  end

  describe "#new" do
    it "renders the new template" do
      get :new
      expect(response).to render_template("new")
    end
  end

  describe "#create" do
    render_views

    def create_book(attributes = {})
      post :create, params: {
        book: {
          "title":    "new book",
          "filename": "filename.pdf"
        }.merge(attributes)
      }
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
      expect(Book).to exist
    end

    it "does not create a new book with validation errors" do
      create_book(title: "")
      expect(Book).not_to exist
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
      get :edit, params: { id: book.id }
      expect(response).to render_template("edit")
    end

    it "finds the book to edit" do
      get :edit, params: { id: book.id }
      expect(assigns(:book)).to be_truthy
    end
  end

  describe "#update" do
    render_views

    let(:book) { Book.create!(title: "old title", filename: 'filename.pdf') }

    def update_book(attributes = {})
      patch :update, params: {
        id: book.id,
        book: {
          "title":    "title",
          "filename": "filename"
        }.merge(attributes)
      }
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
      expect(book.reload.title).to eq("updated title")
    end

    it "does not update a book with validation errors" do
      update_book(id: book.id, title: "", filename: "irrelevant")
      expect(book.title).not_to eq("")
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
      get :show, params: { id: book.id }
      expect(response).to render_template("show")
    end

    it "wraps a book in a presenter" do
      get :show, params: { id: book.id }
      expect(assigns(:book)).to be_a(Books::Presenter)
    end
  end

  describe "delete" do
    let(:book) { Book.create!(title: "title", filename: "filename.pdf") }

    it "renders the delete template" do
      get :delete, params: { id: book.id }
      expect(response).to render_template("delete")
    end

    it "wraps book in a presenter" do
      get :delete, params: { id: book.id }
      expect(assigns(:book)).to be_a(Books::Presenter)
    end
  end

  describe "#destroy" do
    let(:book) {Book.create!(title: "title", filename: "filename.pdf")}

    it "redirects to the main page" do
      delete :destroy, params: { id: book.id }
      expect(response).to redirect_to(root_path)
    end

    it "shows a success message" do
      delete :destroy, params: { id: book.id }
      expect(flash[:notice]).to include("title")
    end

    it "shows an error if book does not exist" do
      delete :destroy, params: { id: 0 }
      expect(flash.now[:alert].first).to include("Book doesn't exist")
    end
  end
end
