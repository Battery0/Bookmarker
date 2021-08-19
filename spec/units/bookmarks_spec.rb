require 'bookmarks'
require_relative './database_helpers'

describe Bookmarks do

  let(:bookmarks) { Bookmarks.all }
  let(:bookmark_object) {}

  describe '#self.all' do
    it 'returns all bookmarks' do

      bookmark = Bookmarks.add("http://bbc.co.uk", "BBC")

      bookmarks = Bookmarks.all
      
      expect(bookmarks.length).to eq 4
      expect(bookmarks.first).to be_a Bookmarks
      expect(bookmarks.last.id).to eq bookmark.id
      expect(bookmarks.first.title).to eq 'Makers'
      expect(bookmarks.first.url).to eq 'http://www.makersacademy.com/'
    end
  end

  describe "#self.add" do
    it "should add bookmark to database" do
      bookmark = Bookmarks.add('http://www.facebook.com/', 'Facebook')
      persisted_data = persisted_data(id: bookmark.id)
      
      expect(bookmark).to be_a Bookmarks
      expect(bookmark.id).to eq persisted_data['id']
      expect(bookmark.title).to eq 'Facebook'
      expect(bookmark.url).to eq 'http://www.facebook.com/'
    end
  end
end