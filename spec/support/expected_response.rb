module ExpectedResponse
  def expected_response(file)
    eval(file_fixture(file).read)
  end
end

RSpec.configure do |config|
  config.include ExpectedResponse
end
