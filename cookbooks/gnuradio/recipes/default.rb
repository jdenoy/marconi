include_recipe 'gnuradio::packages'

directory node[:workingdir] do
  owner 'vagrant'
  group 'vagrant'
  mode '0755'
  action :create
end

git 'Checkout gnuradio' do
    repository node[:repos][:gnuradio]
    reference 'master'
    action :checkout
    destination node[:workingdir] + '/gnuradio'
    user 'vagrant'
    group 'vagrant'
end

git 'Checkout rtl-sdr' do
    repository node[:repos][:rtlsdr]
    reference 'master'
    action :checkout
    destination node[:workingdir] + '/rtl-sdr'
    user 'vagrant'
    group 'vagrant'
end

git 'Checkout gr-osmosdr' do
    repository node[:repos][:gr_osmosdr]
    reference 'master'
    action :checkout
    destination node[:workingdir] + '/gr-osmosdr'
    user 'vagrant'
    group 'vagrant'
end

bash 'Compile rtl-sdr' do
    user 'vagrant'
    group 'vagrant'
    cwd node[:workingdir] + '/rtl-sdr'
    code <<-EOH
        cmake . -DINSTALL_UDEV_RULES=ON
        make clean
        make
    EOH
end

bash 'Install rtl-sdr' do
    cwd node[:workingdir] + '/rtl-sdr'
    code <<-EOH
        make install
        ldconfig
    EOH
end

bash 'Compile GNU Radio' do
    user 'vagrant'
    group 'vagrant'
    cwd node[:workingdir] + '/gnuradio'
    code <<-EOH
        export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig
        mkdir build && cd build
        make clean
        cmake -DENABLE_BAD_BOOST=ON ../
        make clean
        make
    EOH
end

bash 'Install GNU Radio' do
    cwd node[:workingdir] + '/gnuradio'
    code <<-EOH
        cd build
        make install
        ldconfig
    EOH
end

bash 'Compile gr-osmosdr' do
    user 'vagrant'
    group 'vagrant'
    cwd node[:workingdir] + '/gr-osmosdr'
    code <<-EOH
        cmake .
        make clean
        make
    EOH
end

bash 'Install gr-osmosdr' do
    cwd node[:workingdir] + '/gr-osmosdr'
    code <<-EOH
        make install
        ldconfig
    EOH
end
