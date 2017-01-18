# Text to Speech Swift Starter Application

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

1. Create a Bluemix Account

    [Sign up][sign_up] in Bluemix, or use an existing account. Watson Services in Beta are free to use. Create a service by clicking on Catalog in the website header. 

2. On the new page that loads upon clicking 'Create Service,' select 'Service
Credentials'
3. Update the `TextToSpeechUsername` and `TextToSpeechPassword` properties in `Credentials.swift`.
4. Run the following command from the home directory to ignore new changes to the `Credentials.swift` file. 

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

[service_url]: http://www.ibm.com/smarterplanet/us/en/ibmwatson/developercloud/text-to-speech.html
[cloud_foundry]: https://github.com/cloudfoundry/cli
[getting_started]: http://www.ibm.com/smarterplanet/us/en/ibmwatson/developercloud/doc/getting_started/
[sign_up]: https://apps.admin.ibmcloud.com/manage/trial/bluemix.html?cm_mmc=WatsonDeveloperCloud-_-LandingSiteGetStarted-_-x-_-CreateAnAccountOnBluemixCLI
