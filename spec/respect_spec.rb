class ArraySpec < Respect
  describe '#pop' do
    before do
      @array = []
    end
    expect{@array.pop}.to be_nil
  end
end
