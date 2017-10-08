RSpec.describe FixerApi::Client do
  let(:request_instance) { instance_double(FixerApi::Request) }

  before do
    allow(FixerApi::Request).to receive(:new).and_return(request_instance)
    allow(request_instance).to receive(:perform)
  end

  describe '.get_rates_for_day' do
    let(:date) { Date.new(2020, 8, 20) }

    it 'transforms date to string and makes request' do
      described_class.get_rates_for_day(date, {})

      expect(FixerApi::Request).to have_received(:new).with('2020-08-20', {})
      expect(request_instance).to have_received(:perform)
    end
  end
end
