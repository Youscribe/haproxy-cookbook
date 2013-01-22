#
# Cookbook Name:: haproxy
# Author:: Guilhem Lettron <guilhem.lettron@youscribe.com>
#
# Copyright 2012, Societe Publica.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe "cpu::affinity"

cpu_affinity "set affinity for haproxy" do
  pid node['haproxy']['pid_file']
  cpu 0
  subscribes :set, resources("service[haproxy]"), :immediately
end

sysctl_multi "haproxy" do
  instructions ({
    "net.ipv4.tcp_tw_reuse" => "1",
    "net.ipv4.ip_local_port_range" => "1024 65023",
    "net.ipv4.tcp_timestamps" => "0",
    "net.core.rmem_max" => "16777216",
    "net.core.wmem_max" => "16777216",
    "net.ipv4.tcp_rmem" => "4096 87380 16777216",
    "net.ipv4.tcp_wmem" => "4096 87380 16777216",
    "net.core.netdev_max_backlog" => "15000",
    "net.ipv4.tcp_max_tw_buckets" => "16777216",
    "net.core.somaxconn" => "262144",
    "net.ipv4.tcp_max_syn_backlog" => "262144"
  })
end
