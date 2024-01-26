describe port(80) do
  it { is_expected.to be_listening }
end

describe systemd_service('nginx') do
  it { is_expected.to be_running }
end