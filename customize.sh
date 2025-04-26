##########################################################################################
# Installation variables and functions for the Magisk module "MagiskHide Props Config"
# Copyright (c) 2018-2021 Didgeridoohan @ XDA Developers.
# Licence: MIT
##########################################################################################

# Load functions and variables
INSTFN=true
. $MODPATH/common/util_functions.sh

sdk_ver=$(getprop ro.build.version.sdk)

sdk_cek_30(){
  if [ $sdk_ver = 30 ]; then
  rm -rf "${MODPATH}"/common/prints.sh
  cp -f "${MODPATH}"/list_fp/A11.sh $MODPATH/common/prints.sh
  ui_print "- Terdeteksi Android 11"
  ui_print "- Install props Android 11"
  
  fi
}

sdk_cek_31(){
  if [ $sdk_ver = 31 ]; then
  rm -rf "${MODPATH}"/common/prints.sh
  cp -f "${MODPATH}"/list_fp/A12.sh $MODPATH/common/prints.sh
  ui_print "- Terdeteksi Android 12"
  ui_print "- Install props Android 12"
  
  fi
}

sdk_cek_32(){
  if [ $sdk_ver = 32 ]; then
  rm -rf "${MODPATH}"/common/prints.sh
  cp -f "${MODPATH}"/list_fp/A12L.sh $MODPATH/common/prints.sh
  ui_print "- Terdeteksi Android 12L"
  ui_print "- Install props Android 12L"
  
  fi
}

sdk_cek_33(){
  if [ $sdk_ver = 33 ]; then
  rm -rf "${MODPATH}"/common/prints.sh
  cp -f "${MODPATH}"/list_fp/A13.sh $MODPATH/common/prints.sh
  ui_print "- Terdeteksi Android 13"
  ui_print "- Install props Android 13"
  
  fi
}

sdk_cek_34(){
  if [ $sdk_ver = 34 ]; then
  rm -rf "${MODPATH}"/common/prints.sh
  cp -f "${MODPATH}"/list_fp/A14.sh $MODPATH/common/prints.sh
  ui_print "- Terdeteksi Android 14"
  ui_print "- Install props Android 14"
  
  fi
}

sdk_cek(){
  sdk_cek_30
  sdk_cek_31
  sdk_cek_32
  sdk_cek_33
  sdk_cek_34
}

# Print module info
ui_print ""
ui_print "************************"
ui_print " Installing $MODVERSION "
ui_print "************************"
ui_print ""

# Remove module directory if it exists on a fresh install
if [ ! -d "$MODULESPATH/MagiskHidePropsConf" ] && [ -d "$MHPCPATH" ]; then
  rm -rf $MHPCPATH
fi

# Create module directory
mkdir -pv $MHPCPATH

# Start module installation log
echo "***************************************************" > $LOGFILE 2>&1
echo "********* MagiskHide Props Config $MODVERSION ********" >> $LOGFILE 2>&1
echo "***************** By Didgeridoohan ***************" >> $LOGFILE 2>&1
echo "***************************************************" >> $LOGFILE 2>&1
log_print "- Starting module installation script"

# Rudimentary tamper check
log_handler "Checking module files MD5 checksum."
unzip -o "$ZIPFILE" 'META-INF/*' -d $MODPATH >> $LOGFILE 2>&1
cd $MODPATH
if [ "$(md5sum -c module.md5 | grep FAILED)" ]; then
  ui_print ""
  ui_print "!"
  log_print "! MD5 checksum mismatch!"
  ui_print "!"
  ui_print ""
  ui_print "The module files have been tampered with."
  ui_print "Only download from official sources."
  ui_print "See the module documentation for details."
  ui_print ""
  abort "! Aborting install!"
else
  ui_print "- Cek Android SDK"
  sleep 2
  ui_print "- Otomatis memilih props"
  sleep 1
  sdk_cek
  sleep 2

  # Module script installation
  script_install

  # Permission
  log_print "- Setting permissions"
  set_perm $MODPATH/system/$BIN/props 0 0 0755
  set_perm $MODPATH/system/$BIN/0wipe 0 0 0755
  set_perm $MODPATH/system/$BIN/jos 0 0 0755

  # Cleanup
  rm -rf $MODPATH/META-INF
  rm -f $MODPATH/module.md5

  log_print "- Module installation complete."
fi
