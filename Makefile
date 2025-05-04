export ARCH=x86_64

target: AppDir/AppRun AppDir/usr/bin/nvimunity
	appimagetool AppDir NvimUnity-x86_64.AppImage
	mv NvimUnity-x86_64.AppImage ~/.local/bin/nvimunity
