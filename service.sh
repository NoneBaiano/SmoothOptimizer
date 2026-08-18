#!/system/bin/sh
while [ "$(getprop sys.boot_completed)" != "1" ]; do
  sleep 1
done

settings put global window_animation_scale 0.70
settings put global transition_animation_scale 0.70
settings put global animator_duration_scale 0.70
settings put secure multi_press_timeout 200
settings put secure long_press_timeout 250
settings put system pointer_speed 5
resetprop debug.sf.enable_gl_backpressure 0
resetprop debug.sf.disable_backpressure 0
resetprop debug.sf.enable_hwc_vds 1


if [ -e /sys/block/zram0 ]; then
    swapoff /dev/block/zram0 2>/dev/null
    echo 1 > /sys/block/zram0/reset 2>/dev/null
    echo lz4 > /sys/block/zram0/comp_algorithm 2>/dev/null
    echo 1073741824 > /sys/block/zram0/disksize 2>/dev/null
    mkswap /dev/block/zram0 2>/dev/null
    swapon /dev/block/zram0 -p 10 2>/dev/null
fi

echo 20 > /proc/sys/vm/swappiness
echo 20 > /proc/sys/vm/dirty_ratio
echo 10 > /proc/sys/vm/dirty_background_ratio
echo 0 > /proc/sys/vm/dirty_bytes
echo 0 > /proc/sys/vm/dirty_background_bytes
echo 50 > /proc/sys/vm/vfs_cache_pressure
