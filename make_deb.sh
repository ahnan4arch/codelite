################################################################################
## This file is part of CodeLite IDE and is released
## under the terms of the GNU General Public License as published by
##    the Free Software Foundation; either version 2 of the License, or
##    (at your option) any later version.
################################################################################

#!/bin/sh


## Copy files to the fakeroot directory structure
cur_rev=`svn info | grep Revision | awk '{print $2;}'`
arch=`uname -m`

if [ "${arch}" = "i686" ]; then
    arch="i386"
elif [ "${arch}" = "x86_64" ]; then
    arch="amd64"
fi

## Parse command line argument for getting install prefix
parseCommandLine()
{
    case $1 in
        "-d")   PREFIX="/usr";;

        "-u")   PREFIX="/usr/local"
                cur_rev="${cur_rev}-ubuntu0";;

        "--help" | "-h")    usage
                            exit 0;;
        *   )   usage
                exit 1;;
    esac
}

## Show help
usage()
{
    cat <<EOF
Usage:
  `basename $0` [options]

Options:
  -h | --help   this help screen
  -d            make deb-package for Debian
  -u            make deb-package for Ubuntu

EOF
}

## Making control file
generateControlFile()
{
    rm -fr fakeroot/DEBIAN/control
    echo "Package: codelite" >> fakeroot/DEBIAN/control
    echo "Version: 1.0.${cur_rev}" >> fakeroot/DEBIAN/control
    echo "Section: devel " >> fakeroot/DEBIAN/control
    echo "Priority: optional " >> fakeroot/DEBIAN/control
    echo "Architecture: ${arch} " >> fakeroot/DEBIAN/control
    echo "Essential: no" >> fakeroot/DEBIAN/control
    echo "Depends: libwxgtk2.8-0, libgtk2.0-0" >> fakeroot/DEBIAN/control
    echo "Installed-Size: ${inst_size} " >> fakeroot/DEBIAN/control
    echo "Maintainer: Eran Ifrah [eran.ifrah@gmail.com]" >> fakeroot/DEBIAN/control
    echo "Description: CodeLite is a powerful open-source, cross platform code editor for the C/C++ programming languages (regularly tested on Windows XP sp2, Ubuntu 8.04 Hardy Heron, Fedora Core 9 and Debian lenny/sid). " >> fakeroot/DEBIAN/control
    echo "		 CodeLite is distributed under the terms of the GPL license." >> fakeroot/DEBIAN/control
    echo "		 CodeLite uses a sophisticated, yet intuitive interface which allows user easily to " >> fakeroot/DEBIAN/control
    echo "		 create and build complex projects. " >> fakeroot/DEBIAN/control
    echo ""  >> fakeroot/DEBIAN/control
}

## Making destop file
generateDesktopFile()
{
    rm -fr fakeroot/usr/share/applications/codelite.desktop
    echo "[Desktop Entry] " >> fakeroot/usr/share/applications/codelite.desktop
    echo "Name=codelite " >> fakeroot/usr/share/applications/codelite.desktop
    echo "Comment=An Open Source IDE for C/C++ " >> fakeroot/usr/share/applications/codelite.desktop
    echo "TryExec=codelite " >> fakeroot/usr/share/applications/codelite.desktop
    echo "Exec=codelite %f " >> fakeroot/usr/share/applications/codelite.desktop
    echo "Icon=${PREFIX}/share/codelite/images/cubes.png " >> fakeroot/usr/share/applications/codelite.desktop
    echo "Terminal=false " >> fakeroot/usr/share/applications/codelite.desktop
    echo "X-MultipleArgs=false " >> fakeroot/usr/share/applications/codelite.desktop
    echo "Type=Application " >> fakeroot/usr/share/applications/codelite.desktop
    echo "Categories=Development; " >> fakeroot/usr/share/applications/codelite.desktop
    echo "StartupNotify=true " >> fakeroot/usr/share/applications/codelite.desktop
    echo "" >> fakeroot/usr/share/applications/codelite.desktop
}

## Making menu entry for WMs
generateMenuFile()
{
    rm -fr fakeroot/usr/share/menu/codelite
    echo "?package(codelite):needs=\"x11\" section=\"Apps/Programming\" \ " >> fakeroot/usr/share/menu/codelite
    echo "        title=\"codelite\" command=\"${PREFIX}/bin/codelite\" \ " >> fakeroot/usr/share/menu/codelite
    echo "        icon=\"${PREFIX}/share/codelite/images/cubes.png\" " >> fakeroot/usr/share/menu/codelite
    echo "" >> fakeroot/usr/share/menu/codelite
}


## clear previous packaged files
\rm -fr fakeroot/usr/

## Parse command line options
parseCommandLine $1

EXE_NAME=codelite
mkdir -p fakeroot/${PREFIX}/bin/
cp ./Runtime/${EXE_NAME} fakeroot/${PREFIX}/bin/codelite
cp Runtime/le_dos2unix.sh fakeroot/${PREFIX}/bin/
cp Runtime/le_killproc.sh fakeroot/${PREFIX}/bin/
cp Runtime/le_exec.sh fakeroot/${PREFIX}/bin/
chmod +x fakeroot/${PREFIX}/bin/le_dos2unix.sh
chmod +x fakeroot/${PREFIX}/bin/le_killproc.sh
chmod +x fakeroot/${PREFIX}/bin/le_exec.sh
cp sdk/ctags/ctags-le fakeroot/${PREFIX}/bin/
mkdir -p fakeroot/${PREFIX}/share/codelite
mkdir -p fakeroot/${PREFIX}/share/codelite/config
mkdir -p fakeroot/${PREFIX}/share/codelite/debuggers
mkdir -p fakeroot/${PREFIX}/share/codelite/templates
mkdir -p fakeroot/${PREFIX}/share/codelite/plugins
mkdir -p fakeroot/${PREFIX}/share/codelite/plugins/resources
mkdir -p fakeroot/${PREFIX}/share/codelite/images
mkdir -p fakeroot/${PREFIX}/share/codelite/rc
mkdir -p fakeroot/${PREFIX}/share/codelite/src
mkdir -p fakeroot/${PREFIX}/share/codelite/lexers

mkdir -p fakeroot/usr/share/applications/
mkdir -p fakeroot/usr/share/menu/

\cp -pr Runtime/config/build_settings.xml.default fakeroot/${PREFIX}/share/codelite/config/build_settings.xml.default
\cp -pr Runtime/config/plugins.xml.default fakeroot/${PREFIX}/share/codelite/config/plugins.xml.default
\cp -pr Runtime/config/debuggers.xml.gtk fakeroot/${PREFIX}/share/codelite/config/debuggers.xml.default
\cp -pr Runtime/config/accelerators.conf.default fakeroot/${PREFIX}/share/codelite/config/accelerators.conf.default
\cp -pr Runtime/config/codelite.xml.default.gtk fakeroot/${PREFIX}/share/codelite/config/codelite.xml.default
\cp -pr Runtime/rc/menu.xrc fakeroot/${PREFIX}/share/codelite/rc/
\cp -pfr Runtime/templates/* fakeroot/${PREFIX}/share/codelite/templates/
\cp -pfr Runtime/lexers/* fakeroot/${PREFIX}/share/codelite/lexers/
\cp -pr static-symbols.tags fakeroot/${PREFIX}/share/codelite/
\cp -pr lib/Debugger.so fakeroot/${PREFIX}/share/codelite/debuggers/
\cp -pr lib/CodeFormatter.so fakeroot/${PREFIX}/share/codelite/plugins/
\cp -pr lib/Copyright.so fakeroot/${PREFIX}/share/codelite/plugins/
\cp -pr lib/Subversion.so fakeroot/${PREFIX}/share/codelite/plugins/
\cp -pr lib/Gizmos.so fakeroot/${PREFIX}/share/codelite/plugins/
\cp -pr lib/cscope.so fakeroot/${PREFIX}/share/codelite/plugins/
\cp -pr lib/UnitTestCPP.so fakeroot/${PREFIX}/share/codelite/plugins/
\cp -pr lib/ExternalTools.so fakeroot/${PREFIX}/share/codelite/plugins/
\cp -pr lib/ContinuousBuild.so fakeroot/${PREFIX}/share/codelite/plugins/
\cp -pr lib/SymbolView.so fakeroot/${PREFIX}/share/codelite/plugins/
\cp -pr lib/SnipWiz.so fakeroot/${PREFIX}/share/codelite/plugins/
\cp -pr lib/wxformbuilder.so fakeroot/${PREFIX}/share/codelite/plugins/
\cp -pr lib/abbreviation.so fakeroot/${PREFIX}/share/codelite/plugins/
\cp -pr Runtime/plugins/resources/*.* fakeroot/${PREFIX}/share/codelite/plugins/resources/
\cp -pr Runtime/*.html fakeroot/${PREFIX}/share/codelite/
\cp -pr Runtime/astyle.sample fakeroot/${PREFIX}/share/codelite/
\cp -pr Runtime/src/* fakeroot/${PREFIX}/share/codelite/src/
\cp -pr Runtime/images/*.png fakeroot/${PREFIX}/share/codelite/images/


## Clean all .svn files
find fakeroot/usr/ -name ".svn" | xargs rm -fr

## Get installed size
inst_size=`du -s fakeroot/usr/ | awk -F" " '{ print $1 }'`

## Make debain control file
generateControlFile

## Make desktop file
generateDesktopFile

## Make menu entry
generateMenuFile

chmod -R 755 fakeroot/${PREFIX}/share/codelite
chmod +x fakeroot/${PREFIX}/bin/codelite

fakeroot dpkg -b fakeroot/ ./
