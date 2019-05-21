# Text to Speech Swift Starter Application

## DEPRECATED: this repo is no longer actively maintained. It can still be used as reference, but may contain outdated or unpatched code.

The [Text to Speech][service_url] service uses IBM's speech synthesis capabilities to convert English or Spanish text to an audio signal. The audio is streamed back to the client with minimal delay. The service can be accessed via a REST interface.

Give it a try!


### Documentation and Git Access

You can find most information concerning the development of Swift SDK for Watson
at the source repository available via Git; look at [Swift SDK Repository](https://github.com/watson-developer-cloud/swift-sdk) for details.

New code releases, bug fixes, and general information about the Swift Watson SDK
can be found at the above site.

# Setup

Clone this repo and add your credentials given by the Text to Speech Watson
services into `Credentials.swift`.

Run `carthage update --platform iOS` in the command line.

### Getting Started

1. Log in and create the service:
	1. Go to the [Text to Speech][sign_up] service on Bluemix and either sign up for a free account or log into your Bluemix account.
	2. Give your service a service name, and then click **Create**.
2. On the new page that loads, Select **Service Credentials** and then **View Credentials** to get your authentication information.
3. Update the `TextToSpeechApiKey` property in `Credentials.swift`.
4. Run the following command from the home directory to ignore new changes to the `Credentials.swift` file:

	```sh
	$ git update-index --assume-unchanged Text\ to\ Speech/Credentials.swift
	```

## License

  This sample code is licensed under Apache 2.0. Full license text is available in [LICENSE](LICENSE).
  The sample uses jQuery which is licensed under MIT

## Contributing

  See [CONTRIBUTING](CONTRIBUTING.md).

## Open Source @ IBM

  Find more open source projects on the
  [IBM Github Page](http://ibm.github.io/).

[service_url]: https://www.ibm.com/watson/developercloud/text-to-speech.html
[cloud_foundry]: https://github.com/cloudfoundry/cli
[getting_started]: https://www.ibm.com/watson/developercloud/doc/common/
[sign_up]: https://console.ng.bluemix.net/catalog/services/text-to-speech/
