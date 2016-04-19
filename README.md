# Building VLC

```
# note these instructions are as of Dec 28, 2015

# the vlc and vlckit repos are super complex and have thousands of dependencies from everywhere on the internet.
# so, you'll need to mess with things a bit

git clone http://code.videolan.org/videolan/VLCKit.git
cd VLCKit

./buildMobileVLCKit.sh -t

# it might then error after a a few minutes with a live555 build problem.
# fix it by manually downloading the .tar.gz live555 from their website: http://live555.com/liveMedia/public/
# and put it into MobileVLCKit/ImportedSources/vlc/contrib/tarballs/
# and do a 'shasum -a 512' on the tar.gz file and update the SHA in MobileVLCKit/ImportedSources/vlc/contrib/src/live555/SHA512SUMS
# and update MobileVLCKit/ImportedSources/vlc/contrib/src/live555/rules.mak to use this new filename
# and comment out these lines from buildMobileVLCKit.sh:
#   git pull --rebase
#   git reset --hard ${TESTEDHASH}
#   git am ../../patches/*.patch
# then run it again

./buildMobileVLCKit.sh -t

# you'll notice nothing gets built at the end. to make the actual .a files:

xcodebuild -project "MobileVLCKit.xcodeproj" -target "TVVLCKit" -sdk appletvos9.1 -configuration Release ARCHS="arm64" IPHONEOS_DEPLOYMENT_TARGET=9.1 GCC_PREPROCESSOR_DEFINITIONS=""
xcodebuild -project "MobileVLCKit.xcodeproj" -target "TVVLCKit" -sdk appletvsimulator9.1 -configuration Release ARCHS="x86_64" IPHONEOS_DEPLOYMENT_TARGET=9.1 GCC_PREPROCESSOR_DEFINITIONS=""

# then make the .framework file:

cd build
rm -rf TVVLCKit.framework
mkdir TVVLCKit.framework
lipo -create Release-appletvos/libTVVLCKit.a Release-appletvsimulator/libTVVLCKit.a -o TVVLCKit.framework/TVVLCKit
chmod a+x TVVLCKit.framework/TVVLCKit
cp -pr Release-appletvos/TVVLCKit TVVLCKit.framework/Headers

# then copy the TVVLCKit.framework into your project
# then open the SimplePlayback iOS example and import all the same frameworks into your appletv project (a couple might not exist on apple tv, thats ok)
# for swift, add a bridging header and add '#import <TVVLCKit/TVVLCKit.h>' to it

# the code for a simple video to start playing:

# this goes in the class definitions
# let mp = VLCMediaPlayer()

# this goes in the playback method
# mp.drawable = window!
# mp.media = VLCMedia(URL: NSURL(string: "http://streams.videolan.org/streams/mp4/Mr_MrsSmith-h264_aac.mp4"))
# mp.play()

# i have a sample project up (it's big because the libs are huge):
# http://cl.ly/2D3e29113B2O
# note that i have a 4GB/day limit on cloudapp, so you might need to try again tomorrow if im out of bw
```

# VLCKit

VLCKit is a generic library for any audio or video playback needs on OS X, iOS and tvOS. It also supports active streaming and media to file conversations on the Mac. It is open-source software licensed under LGPLv2.1 or later, available in source code and binary form from the [VideoLAN website]. You can also integrate MobileVLCKit easily via [CocoaPods].

## Use-case

When do you need VLCKit? Frankly always when you need to play media not supported by QuickTime / AVFoundation or if you require more flexibility. You want to play something else besides H264/AAC files or HLS streams? You need subtitles beyond QuickTime’s basic support for Closed Captions? Your media source is not your mobile device and not a basic HTTP server either, but perhaps a live stream hailing from some weird media server or even a raw DVB signal broadcasted on a local network? Then, VLCKit is for you.

But this is open-source software right? What does this mean for me and the end-user? And wasn’t MobileVLC removed from the App Store in 2011 for some crazy licensing reason?

First of all, open-source means for you, that you get access to the whole stack. There is no blackbox, all the sources are there at your fingertips. No reverse-engineering needed, no private APIs.

Then again, this must not be the case for your software. The [LGPLv2.1] allows our software to be included in proprietary apps, as long as you follow the license. As a start, make sure to publish any potential changes you do to our software, make sure that the end-user is aware that VLCKit is embedded within your greater work and that s/he is aware of the gained rights. S/he is granted access to our code as well as to your additions to our work. For further details, please read the license and consult your lawyer with any questions you might have.

## Contribute!

As VLCKit is an open-source project hosted by VideoLAN, we happily welcome all kinds of contributions to it. For detailed information on the development process, please read our wiki page on [how to send patches].

## Get in touch!

We happily provide guidance on VLCKit. The [web forum] is always there for you.
If you prefer live interaction, reach out to us via our IRC channel on the [freenode] Network (irc.freenode.org, #videolan). Use the [Freenode Web] interface, if you don't have an IRC client at hand.

## Further reading

You can find more documentation on the [VideoLAN wiki].

   [VideoLAN website]: <http://www.videolan.org/>
   [CocoaPods]: <http://cocoapods.org/>
   [VideoLAN wiki]: <https://wiki.videolan.org/VLCKit/>
   [LGPLv2.1]: <http://opensource.org/licenses/LGPL-2.1>
   [how to send patches]: <https://wiki.videolan.org/Sending_Patches_VLC/>
   [web forum]: <http://forum.videolan.org>
   [freenode]: <http://www.freenode.net/>
   [Freenode Web]: <http://webchat.freenode.net/>
