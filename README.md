This is just a toy, please don't try to use it for anything.

I thoroughly enjoy the [new expect syntax](http://myronmars.to/n/dev-blog/2012/06/rspecs-new-expectation-syntax) in [rspec](http://rspec.info/), and I have been leaning toward a tendancy to do all my setup in `let`s or the `before` block of nested contexts, and skip the description on the actual specs, like so:

    describe Array do
      describe '#pop' do
        let(:array) { [] }
        it { expect(array.pop).to be_nil }
      end
    end

I was [challenged](https://twitter.com/rtlechow/status/420635815912296449) to get rid of the awkward `it` and this is me trying to figure it out from scratch.
