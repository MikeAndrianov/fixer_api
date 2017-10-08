RSpec.describe FixerApi::Request do
  let(:request) { described_class.new('2020-08-20', {}) }
  let(:response) { parsed_response.to_json }

  before { allow(request).to receive(:make_request).and_return(response) }

  describe '#perform' do
    let(:date) { Date.new(2020, 8, 20) }

    context 'with successfull response' do
      let(:parsed_response) do
        {
          'base' => 'EUR',
          'date' => '2020-08-20',
          'rates' => { 'AUD' => 1.506, 'USD' => 1.1707 }
        }
      end

      it 'returns parsed json' do
        expect(request.perform).to eq(parsed_response)
      end
    end

    context 'with response without rates' do
      let(:parsed_response) { { 'base' => 'EUR' } }

      it 'raises response error' do
        expect { request.perform }.to raise_error(FixerApi::ResponseError)
      end
    end
  end
end
