RSpec.describe FixerApi::Client do
  let(:request_instance) { instance_double(FixerApi::Request) }

  before do
    allow(Date).to receive(:today).and_return(Date.new(2020, 8, 23))
    allow(FixerApi::Request).to receive(:new).and_return(request_instance)
    allow(request_instance).to receive(:perform)
  end

  describe '.get_rates_for_day' do
    context 'with date less than or equal today' do
      let(:date) { Date.new(2020, 8, 20) }

      it 'transforms date to string and makes request' do
        described_class.get_rates_for_day(date, {})

        expect(FixerApi::Request).to have_received(:new).with('2020-08-20', {})
        expect(request_instance).to have_received(:perform)
      end

      context 'response failed' do
        before do
          allow(described_class).to receive(:sleep)
          allow(request_instance).to receive(:perform).and_raise(FixerApi::ResponseError)
        end

        it 'waits and retries again 4 times' do
          described_class.get_rates_for_day(date)
          expect(FixerApi::Request).to have_received(:new).with('2020-08-20', {}).exactly(4).times
        end
      end
    end

    context 'with date more than today' do
      let(:date) { Date.new(2020, 8, 25) }

      it 'returns nil' do
        expect(described_class.get_rates_for_day(date, {})).to be_nil
        expect(FixerApi::Request).to_not have_received(:new)
        expect(request_instance).to_not have_received(:perform)
      end
    end
  end

  describe '.get_rates_for_period' do
    let(:date_from) { Date.new(2020, 8, 20) }
    let(:date_to) { Date.new(2020, 8, 23) }

    before { allow(FixerApi::Client).to receive(:get_rates_for_day).and_return(1) }

    it 'makes bunch of requests and returns array with rates for period' do
      result = described_class.get_rates_for_period(date_from, date_to, {})

      expect(described_class).to have_received(:get_rates_for_day).exactly(4).times
      expect(result).to eq([1, 1, 1, 1])
    end
  end
end
