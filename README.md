# ios-sdk-watson-speaks
An example application using the Text to Speech service from the Watson
Developer Cloud iOS SDK.


# Documentation and Git Access

You can find most information concerning the development of ios sdk for watson
at the source repository available via Git; look here for details:

https://github.com/watson-developer-cloud/ios-sdk

New code releases, bug fixes, and general information about the iOS Watson sdk
can be found at the above site.

# Setup
Clone this repo and add your credentials given by the Text to Speech Watson
services into `Credentials.swift`.

# Getting Started

Log in to Bluemix at [https://bluemix.net](https://bluemix.net)

1. Create a service by clicking on Catalog in the website header.
  1. Select "Watson" under Services on the left hand sidebar to narrow down the list.
![Creating service preview](http://i.imgur.com/tmlSKCE.png)
  2. Select 'Speech to Text'
    1. Choose which space you want to store the service in.
    2. Choose the option 'Leave unbound' if you have no application you want to
      use the service with.
    ![Creating Speech to Text Service](http://i.imgur.com/Dpa4oXt.png)
2. On the new page that loads upon clicking 'Create Service,' select 'Service
Credentials'
3. Copy your service credentials and save the `username` and `password`
