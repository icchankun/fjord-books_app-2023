# frozen_string_literal: true

module BooksHelper
  def book_attribute(name)
    Book.human_attribute_name(name)
  end
end
