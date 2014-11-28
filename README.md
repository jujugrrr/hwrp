# 2963351-crowdcube_app


## [Changelog](CHANGELOG.md)

See CHANGELOG.md for additional information about changes to this stack over time.

## Supported Platforms

CentOS 6.5

Requirements
------------
#### Cookbooks
* `phpstack` 
* `elkstack` 
* `java`

## Attributes

Please describe any attributes exposed by this stack, and what the default values are. There shouldn't be any attributes without a default value (e.g. no required attributes, sensible defaults).

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['2963351-crowdcube_app']['bacon']</tt></td>
    <td>Boolean</td>
    <td>whether to include bacon</td>
    <td><tt>true</tt></td>
  </tr>
</table>

## Usage

### 2963351-crowdcube_app::default

This is where you should define what the default recipe does, if anything.

### 2963351-crowdcube_app::elkstack

ELK Stack role used to deploy a single node with Elasticsearch, Logstash and Kibana interface for log aggregation.


Data_Bag
----------

This directory contains directories of the various data bags you create for your infrastructure. Each subdirectory corresponds to a data bag on the Chef Server, and contains JSON files of the items that go in the bag

##### Create data bag directory

First, create a directory for the data bag.

`mkdir data_bags/secrets`

Then create the JSON files for items that will go into that bag.

`$EDITOR data_bags/secrets/newrelic.json`

The JSON for the item must contain a key named "id" with a value equal to the item. For example,

```json
{
  "id": "newrelic"
}
```

##### Create encrypted_data_bag_secret  

Create a random encryption key: `Openssl rand -base64 512 | tr -d '\r\n' > encrypted_data_bag_secret`
For your chef clients to be able to decrypt the data bag copy over the secret key to the chef folder on the node

##### Create Data Bag

Use this secret_key to add items to a data bag during a create.  

`knife data bag create --editor /usr/bin/vim --secret-file encrypted_data_bag_secret secrets newrelic`

You may also use it when adding ITEMs from files,  

`knife data bag create secrets`
`knife data bag from file secrets data_bags/secrets/newrelic.json`


Example:

```json
{  
  "id": "newrelic",  
  "license": "000000000000000000000",  
  "apikey": "000000000000000000000"  
}
```


## Contributing

https://github.com/rackspace-cookbooks/contributing/blob/master/CONTRIBUTING.md

## Authors

Author:: Rackspace (devops-chef@rackspace.com)

## License
```
# Copyright 2014, Rackspace Hosting
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
```
