# ios-sdk-watson-speaks
An example application using the Text to Speech service from the Watson
Developer Cloud iOS SDK.


### Documentation and Git Access

You can find most information concerning the development of ios sdk for watson
at the source repository available via Git; look here for details:

https://github.com/watson-developer-cloud/ios-sdk

New code releases, bug fixes, and general information about the iOS Watson sdk
can be found at the above site.

# Setup

Clone this repo and add your credentials given by the Text to Speech Watson
services into `Credentials.swift`.

Run ```carthage update --platform iOS```

# Getting Started

1. Log in to Bluemix at [https://bluemix.net](https://bluemix.net) to create a
service by clicking on Catalog in the website header. (Select "Watson" under
Services on the left hand sidebar to narrow down the list.)

<img src="http://i.imgur.com/tmlSKCE.png" width="500">

2. Select 'Speech to Text'
    1. Choose which space you want to store the service in.
    2. Choose the option 'Leave unbound' if you have no application you want to
      use the service with.

    <img src="http://i.imgur.com/Dpa4oXt.png" width="500">

3. On the new page that loads upon clicking 'Create Service,' select 'Service
Credentials'
4. Copy your service credentials and save the `username` and `password`into
`Credentials.swift`.

### Usage

All calls to the SDK are in `ToSpeech.swift` for clarity.
