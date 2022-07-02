Vagrant.configure("2") do |config|
  # Will not check for box updates during every startup.
  config.vm.box_check_update = false

  config.vm.define "controller" do |master|
     master.vm.hostname = "ansible-controller"
     master.vm.network "private_network", ip: "192.168.10.2"
     master.vm.box = "bento/ubuntu-18.04"

     master.vm.provider "virtualbox" do |v|
       v.memory = 2048
       v.cpus = 2
     end

     master.vm.provision "shell" do |sh|
       sh.path = "main.sh"
     end
     master.vm.provision "file", source: "ansible_books/docker-install.yml", destination: "/home/vagrant/ansible_books/"
     master.vm.provision "file", source: "key_generate.sh", destination: "/home/vagrant/"
   end

  [3, 4].each do |i|
    config.vm.define "managed-#{i}" do |worker|
      worker.vm.hostname = "ansible-managed-#{i}"
      worker.vm.network "private_network", ip:"192.168.10.#{i}"
      worker.vm.box = "bento/ubuntu-18.04"
	
      worker.vm.provider "virtualbox" do |v|
        v.memory = 2048
        v.cpus = 1
      end	
	
      worker.vm.provision "shell" do |sh|
        sh.path = "main.sh"
      end
    end
  end
end
