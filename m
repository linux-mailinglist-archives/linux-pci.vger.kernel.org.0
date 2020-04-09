Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 984DB1A37E8
	for <lists+linux-pci@lfdr.de>; Thu,  9 Apr 2020 18:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbgDIQYA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Apr 2020 12:24:00 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:54224 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbgDIQX7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Apr 2020 12:23:59 -0400
Received: by mail-pj1-f65.google.com with SMTP id l36so1504345pjb.3;
        Thu, 09 Apr 2020 09:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=JROCv1VfPLd1odjKDnskzuNHX5oCwEYs1LL7ATNETzc=;
        b=T+dMZPrOo0Bnai5TiTAKGVFbZmoisrsNHpJU+8GF/FUHbYec48n29GMthCgm6kZ3ir
         X6uMUjz2errQx6lYrjDC4tafXGCGs3AJ2gncu3EUFMiz/lKt9/R+yFF8L32lDZdBn1Yn
         F8hgPozIAiavIxcuTkD/kZ42lKBXBvKpFxmwj10nH5NiQFe2/wHWQk93W6F1TB1EzqD5
         YJi/7TApWT9AbskFyBEz9UaGPO8ZAgm4mk3bm675kffKlj9h4Pv29ofSWmMJbjcjDVUO
         nrJRLK490JdlyyXg4JbZdWtNay0qxv+pYy7DD4HEsgIgXh29gnFbmySFyz6fQo9gwb1Y
         Js3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=JROCv1VfPLd1odjKDnskzuNHX5oCwEYs1LL7ATNETzc=;
        b=oe0w0D+SZuOtI9tftL5M5LEjNPOxXHpLjED9HNdJIlvy4E7ouYm4ZNlc0Q+u+WMKEb
         v9AI9AkgYM3NtnbUgRsTlnIPYgyXxhMhBbH2w9AZMkWufQUkAM9DB0XbS2JqVLobBVCg
         o+lMByOEb8iZWKiRf29CUAiHUHEtEOZlvrFmkQltG1pH+VqJNRH/j/tL93l0R8lSrKUT
         iXXED8cRiPBX+p8MHIJNSJdPojDh4NKdeMDe7feX5dsgtuFIek23+o92m4wfSQbhU2uH
         Oqz5WO8X58T6i7M4mAUBch0np6s4fKGlEcumt1rzJV8w1nmyrfqezGHc0VOALUXBnSYb
         rBDA==
X-Gm-Message-State: AGi0PuanJFnvxMiq65EvAJDydPVyYBNSSGlOINaehRJD7VklaVpqE/8h
        YR4e5+PQiigsupRXsqQLvTXf1EIIRM9ZE2ekXil4tFMw
X-Google-Smtp-Source: APiQypL4XpYUKklRSEDPo3CTAeY6ZB8DbNNbgvIEcMj7mo92ulge20/G3wvT79LblMEOg1xS/zuefzw2Mq3+LyETpXg=
X-Received: by 2002:a17:902:8e8b:: with SMTP id bg11mr318620plb.139.1586449437628;
 Thu, 09 Apr 2020 09:23:57 -0700 (PDT)
MIME-Version: 1.0
From:   Damien Riegel <damien.riegel@gmail.com>
Date:   Thu, 9 Apr 2020 12:23:46 -0400
Message-ID: <CAL4iiOe0NEMTRRQcUvy3-r8KXC3eFB7GozTGsNHKDiG6vmcKGA@mail.gmail.com>
Subject: double-freed irq when suspending with Thinkpad Thunderbolt Dock attached
To:     linux-usb@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,


I have a setup with a Thinkpad X1 Carbon Gen 6 with a Thinkpad
Thunderbolt 3 Dock attached to it. The issue is not exhibited when the
dock is not attached to the laptop.

Most of the time, it fails to resume from a suspend-to-disk. The system
hangs and logs are not flushed to disk so I don't have more details.

But sometimes (maybe 1 out of 20 times), it manages to resume and there
are double-freed irq errors, as shown in the following logs. As far as I
am concerned, the laptop is running fine on resume, but maybe this can
give a hint to where the issue causing the hang is.

I'm Ccing linux-usb and linux-pci as I couldn't tell which subsystem is
responsible.


Thanks,
Damien

[ 1231.822959] PM: hibernation: hibernation entry
[ 1231.832486] Filesystems sync: 0.008 seconds
[ 1231.832488] Freezing user space processes ... (elapsed 0.001 seconds) done.
[ 1231.833924] OOM killer disabled.
[ 1231.834010] PM: hibernation: Marking nosave pages: [mem
0x00000000-0x00000fff]
[ 1231.834011] PM: hibernation: Marking nosave pages: [mem
0x00058000-0x00058fff]
[ 1231.834011] PM: hibernation: Marking nosave pages: [mem
0x0009d000-0x000fffff]
[ 1231.834013] PM: hibernation: Marking nosave pages: [mem
0x40000000-0x403fffff]
[ 1231.834024] PM: hibernation: Marking nosave pages: [mem
0x50a61000-0x50a62fff]
[ 1231.834025] PM: hibernation: Marking nosave pages: [mem
0x541e9000-0x542e8fff]
[ 1231.834028] PM: hibernation: Marking nosave pages: [mem
0x5a3c6000-0x5b5fefff]
[ 1231.834075] PM: hibernation: Marking nosave pages: [mem
0x5b600000-0xffffffff]
[ 1231.835924] PM: hibernation: Basic memory bitmaps created
[ 1231.836014] PM: hibernation: Preallocating image memory
[ 1232.197310] PM: hibernation: Allocated 690480 pages for snapshot
[ 1232.197313] PM: hibernation: Allocated 2761920 kbytes in 0.36
seconds (7672.00 MB/s)
[ 1232.197313] Freezing remaining freezable tasks ... (elapsed 0.001
seconds) done.
[ 1232.199066] printk: Suspending console(s) (use no_console_suspend to debug)
[ 1232.200990] wlan0: deauthenticating from ac:84:c9:f6:b1:ae by local
choice (Reason: 3=DEAUTH_LEAVING)
[ 1232.673371] ACPI: EC: interrupt blocked
[ 1232.689725] ACPI: Preparing to enter system sleep state S4
[ 1232.694499] ACPI: EC: event blocked
[ 1232.694499] ACPI: EC: EC stopped
[ 1232.694500] PM: Saving platform NVS memory
[ 1232.695076] Disabling non-boot CPUs ...
[ 1232.696349] smpboot: CPU 1 is now offline
[ 1232.698734] smpboot: CPU 2 is now offline
[ 1232.700999] smpboot: CPU 3 is now offline
[ 1232.703566] smpboot: CPU 4 is now offline
[ 1232.705715] smpboot: CPU 5 is now offline
[ 1232.707940] smpboot: CPU 6 is now offline
[ 1232.710321] smpboot: CPU 7 is now offline
[ 1232.712798] PM: hibernation: Creating image:
[ 1233.059188] PM: hibernation: Need to copy 671712 pages
[ 1233.059191] PM: hibernation: Normal pages needed: 671712 + 1024,
available pages: 3495241
[ 1233.674924] PM: hibernation: free pages cleared after restore
[ 1233.674980] PM: Restoring platform NVS memory
[ 1233.675298] ACPI: EC: EC started
[ 1233.675957] Enabling non-boot CPUs ...
[ 1233.676000] x86: Booting SMP configuration:
[ 1233.676001] smpboot: Booting Node 0 Processor 1 APIC 0x2
[ 1233.676769] CPU1 is up
[ 1233.676796] smpboot: Booting Node 0 Processor 2 APIC 0x4
[ 1233.677575] CPU2 is up
[ 1233.677600] smpboot: Booting Node 0 Processor 3 APIC 0x6
[ 1233.678372] CPU3 is up
[ 1233.678394] smpboot: Booting Node 0 Processor 4 APIC 0x1
[ 1233.679331] CPU4 is up
[ 1233.679358] smpboot: Booting Node 0 Processor 5 APIC 0x3
[ 1233.680079] CPU5 is up
[ 1233.680102] smpboot: Booting Node 0 Processor 6 APIC 0x5
[ 1233.680839] CPU6 is up
[ 1233.680872] smpboot: Booting Node 0 Processor 7 APIC 0x7
[ 1233.681610] CPU7 is up
[ 1233.684446] ACPI: Waking up from system sleep state S4
[ 1233.762127] ACPI: EC: interrupt unblocked
[ 1233.783188] pcieport 0000:08:00.0: can't change power state from
unknown to D0 (config space inaccessible)
[ 1233.785720] pcieport 0000:09:00.0: can't change power state from
unknown to D0 (config space inaccessible)
[ 1233.785721] pcieport 0000:09:01.0: can't change power state from
unknown to D0 (config space inaccessible)
[ 1233.785722] pcieport 0000:09:04.0: can't change power state from
unknown to D0 (config space inaccessible)
[ 1233.785723] pcieport 0000:09:02.0: can't change power state from
unknown to D0 (config space inaccessible)
[ 1233.785724] pcieport 0000:09:03.0: can't change power state from
unknown to D0 (config space inaccessible)
[ 1233.795936] xhci_hcd 0000:0a:00.0: can't change power state from
unknown to D0 (config space inaccessible)
[ 1233.795943] xhci_hcd 0000:0c:00.0: can't change power state from
unknown to D0 (config space inaccessible)
[ 1233.928549] usb usb1: root hub lost power or was reset
[ 1233.928550] usb usb2: root hub lost power or was reset
[ 1233.928556] ACPI: EC: event unblocked
[ 1233.928989] usb usb3: root hub lost power or was reset
[ 1233.928990] usb usb4: root hub lost power or was reset
[ 1233.929475] pcieport 0000:09:04.0: pciehp: pcie_do_write_cmd: no
response from device
[ 1233.929550] usb usb7: root hub lost power or was reset
[ 1233.929552] usb usb5: root hub lost power or was reset
[ 1233.929552] usb usb8: root hub lost power or was reset
[ 1233.929553] usb usb6: root hub lost power or was reset
[ 1233.929558] xhci_hcd 0000:0c:00.0: Host halt failed, -19
[ 1233.929559] xhci_hcd 0000:0a:00.0: Host halt failed, -19
[ 1233.929560] xhci_hcd 0000:0c:00.0: Host not accessible, reset failed.
[ 1233.929562] xhci_hcd 0000:0a:00.0: Host not accessible, reset failed.
[ 1233.929687] pcieport 0000:06:01.0: pciehp: Slot(1): Card not present
[ 1233.929911] xhci_hcd 0000:0a:00.0: No Extended Capability
registers, unable to set up roothub
[ 1233.929924] xhci_hcd 0000:0a:00.0: Host halt failed, -19
[ 1233.929929] xhci_hcd 0000:0a:00.0: Host not accessible, reset failed.
[ 1233.929934] xhci_hcd 0000:0a:00.0: PCI post-resume error -12!
[ 1233.929934] xhci_hcd 0000:0a:00.0: HC died; cleaning up
[ 1233.929944] PM: dpm_run_callback(): pci_pm_restore+0x0/0x80 returns -12
[ 1233.929946] PM: Device 0000:0a:00.0 failed to restore async: error -12
[ 1233.929977] xhci_hcd 0000:0c:00.0: No Extended Capability
registers, unable to set up roothub
[ 1233.929985] xhci_hcd 0000:0c:00.0: Host halt failed, -19
[ 1233.929987] xhci_hcd 0000:0c:00.0: Host not accessible, reset failed.
[ 1233.929991] xhci_hcd 0000:0c:00.0: PCI post-resume error -12!
[ 1233.929992] xhci_hcd 0000:0c:00.0: HC died; cleaning up
[ 1233.929996] PM: dpm_run_callback(): pci_pm_restore+0x0/0x80 returns -12
[ 1233.929998] PM: Device 0000:0c:00.0 failed to restore async: error -12
[ 1233.932899] xhci_hcd 0000:0c:00.0: remove, state 4
[ 1233.932903] usb usb8: USB disconnect, device number 1
[ 1233.932905] usb 8-1: USB disconnect, device number 2
[ 1233.938139] iwlwifi 0000:02:00.0: Applying debug destination EXTERNAL_DRAM
[ 1234.072338] iwlwifi 0000:02:00.0: Applying debug destination EXTERNAL_DRAM
[ 1234.142566] iwlwifi 0000:02:00.0: FW already configured (0) - re-configuring
[ 1234.143830] usb 2-3: Disable of device-initiated U1 failed.
[ 1234.143838] usb 2-3: Disable of device-initiated U2 failed.
[ 1234.146189] nvme nvme0: 8/0/0 default/read/poll queues
[ 1234.177319] xhci_hcd 0000:0c:00.0: USB bus 8 deregistered
[ 1234.177323] xhci_hcd 0000:0c:00.0: remove, state 4
[ 1234.177324] usb usb7: USB disconnect, device number 1
[ 1234.177326] usb 7-2: USB disconnect, device number 2
[ 1234.177720] usb 7-4: USB disconnect, device number 3
[ 1234.178163] xhci_hcd 0000:0c:00.0: Host halt failed, -19
[ 1234.178164] xhci_hcd 0000:0c:00.0: Host not accessible, reset failed.
[ 1234.178165] ------------[ cut here ]------------
[ 1234.178166] Trying to free already-free IRQ 19
[ 1234.178172] WARNING: CPU: 0 PID: 180 at kernel/irq/manage.c:1746
__free_irq+0x1c6/0x330
[ 1234.178173] Modules linked in: fuse cdc_ether usbnet r8152 mii
snd_usb_audio snd_usbmidi_lib snd_rawmidi snd_seq_device hid_generic
usbhid acpi_call(OE) ccm algif_aead typec_displayport des_generic
libdes arc4 algif_skcipher cmac md4 algif_hash af_alg joydev mousedev
btusb uvcvideo btrtl videobuf2_vmalloc btbcm videobuf2_memops btintel
videobuf2_v4l2 videobuf2_common bluetooth videodev mc ecdh_generic ecc
rmi_smbus rmi_core snd_hda_codec_hdmi snd_hda_codec_realtek iTCO_wdt
snd_hda_codec_generic mei_hdcp iTCO_vendor_support intel_rapl_msr
wmi_bmof intel_wmi_thunderbolt snd_soc_skl x86_pkg_temp_thermal
intel_powerclamp coretemp snd_soc_sst_ipc iwlmvm kvm_intel
snd_soc_sst_dsp snd_hda_ext_core snd_soc_acpi_intel_match mac80211
snd_soc_acpi i915 libarc4 kvm snd_soc_core irqbypass intel_cstate
snd_compress ac97_bus snd_pcm_dmaengine snd_hda_intel intel_uncore
snd_intel_dspcfg nls_iso8859_1 nls_cp437 iwlwifi snd_hda_codec
intel_rapl_perf vfat i2c_algo_bit snd_hda_core psmouse fat input_leds
[ 1234.178197]  pcspkr drm_kms_helper e1000e snd_hwdep tpm_crb snd_pcm
cec i2c_i801 snd_timer rc_core mei_me intel_gtt tpm_tis thunderbolt
cfg80211 syscopyarea tpm_tis_core processor_thermal_device sysfillrect
mei intel_pch_thermal intel_rapl_common ucsi_acpi
intel_xhci_usb_role_switch sysimgblt thinkpad_acpi fb_sys_fops
typec_ucsi roles intel_soc_dts_iosf tpm nvram typec ledtrig_audio
rng_core rfkill snd i2c_hid wmi int3403_thermal soundcore battery
int340x_thermal_zone ac hid evdev int3400_thermal acpi_thermal_rel
mac_hid drm pkcs8_key_parser agpgart ip_tables x_tables ext4
crc32c_generic crc16 mbcache jbd2 uas usb_storage dm_crypt dm_mod
crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel
serio_raw atkbd libps2 aesni_intel crypto_simd xhci_pci cryptd
glue_helper xhci_hcd i8042 serio
[ 1234.178218] CPU: 0 PID: 180 Comm: irq/126-pciehp Tainted: G
  OE     5.6.3-arch1-1 #1
[ 1234.178219] Hardware name: LENOVO 20KHCTO1WW/20KHCTO1WW, BIOS
N23ET71W (1.46 ) 02/20/2020
[ 1234.178220] RIP: 0010:__free_irq+0x1c6/0x330
[ 1234.178221] Code: 8b bb e8 01 00 00 e8 49 8d 03 00 49 8b 7c 24 30
e8 9f c6 18 00 eb 42 44 89 f6 48 c7 c7 20 2b f3 b4 4c 89 04 24 e8 dc
94 f8 ff <0f> 0b 4c 8b 04 24 48 89 ef 4c 89 c6 e8 f9 4a 8a 00 48 8b 83
80 00
[ 1234.178221] RSP: 0018:ffffad590038bc30 EFLAGS: 00010086
[ 1234.178222] RAX: 0000000000000000 RBX: ffff91400799aa00 RCX: 0000000000000000
[ 1234.178222] RDX: 0000000000000002 RSI: 0000000000000086 RDI: 00000000ffffffff
[ 1234.178223] RBP: ffff91400799aae4 R08: 0000011f5ac04eb9 R09: ffffffffb5903ad4
[ 1234.178223] R10: 00000000000005ca R11: 000000000001e73c R12: ffff91400ce46260
[ 1234.178224] R13: ffff91400799abc0 R14: 0000000000000013 R15: ffff91400ce46000
[ 1234.178224] FS:  0000000000000000(0000) GS:ffff91400f400000(0000)
knlGS:0000000000000000
[ 1234.178225] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1234.178225] CR2: 00007ff016de70a8 CR3: 00000003d3e0a004 CR4: 00000000003606f0
[ 1234.178226] Call Trace:
[ 1234.178230]  free_irq+0x33/0x70
[ 1234.178237]  xhci_cleanup_msix+0x98/0xb0 [xhci_hcd]
[ 1234.178239]  ? irq_forced_thread_fn+0x80/0x80
[ 1234.178241]  xhci_stop+0x87/0x1a0 [xhci_hcd]
[ 1234.178244]  usb_remove_hcd+0x104/0x1bc
[ 1234.178246]  usb_hcd_pci_remove+0x69/0xd0
[ 1234.178249]  pci_device_remove+0x3b/0xa0
[ 1234.178252]  device_release_driver_internal+0xe4/0x1c0
[ 1234.178253]  pci_stop_bus_device+0x68/0x90
[ 1234.178255]  pci_stop_bus_device+0x2c/0x90
[ 1234.178255]  pci_stop_bus_device+0x3d/0x90
[ 1234.178256]  pci_stop_and_remove_bus_device+0xe/0x20
[ 1234.178258]  pciehp_unconfigure_device+0x83/0x136
[ 1234.178259]  pciehp_disable_slot+0x6b/0x100
[ 1234.178260]  pciehp_handle_presence_or_link_change+0xd8/0x2a0
[ 1234.178261]  pciehp_ist+0x123/0x130
[ 1234.178262]  irq_thread_fn+0x20/0x60
[ 1234.178263]  irq_thread+0xee/0x180
[ 1234.178264]  ? wake_threads_waitq+0x30/0x30
[ 1234.178266]  kthread+0xfb/0x130
[ 1234.178267]  ? irq_thread_check_affinity+0xd0/0xd0
[ 1234.178268]  ? kthread_park+0x90/0x90
[ 1234.178270]  ret_from_fork+0x35/0x40
[ 1234.178272] ---[ end trace 2783610e0ff6da31 ]---
[ 1234.178277] xhci_hcd 0000:0c:00.0: USB bus 7 deregistered
[ 1234.178417] xhci_hcd 0000:0a:00.0: remove, state 4
[ 1234.178419] usb usb6: USB disconnect, device number 1
[ 1234.178536] xhci_hcd 0000:0a:00.0: USB bus 6 deregistered
[ 1234.178538] xhci_hcd 0000:0a:00.0: remove, state 4
[ 1234.178539] usb usb5: USB disconnect, device number 1
[ 1234.178540] usb 5-1: USB disconnect, device number 2
[ 1234.178843] usb 5-4: USB disconnect, device number 3
[ 1234.179057] xhci_hcd 0000:0a:00.0: Host halt failed, -19
[ 1234.179058] xhci_hcd 0000:0a:00.0: Host not accessible, reset failed.
[ 1234.179059] ------------[ cut here ]------------
[ 1234.179059] Trying to free already-free IRQ 17
[ 1234.179062] WARNING: CPU: 0 PID: 180 at kernel/irq/manage.c:1746
__free_irq+0x1c6/0x330
[ 1234.179062] Modules linked in: fuse cdc_ether usbnet r8152 mii
snd_usb_audio snd_usbmidi_lib snd_rawmidi snd_seq_device hid_generic
usbhid acpi_call(OE) ccm algif_aead typec_displayport des_generic
libdes arc4 algif_skcipher cmac md4 algif_hash af_alg joydev mousedev
btusb uvcvideo btrtl videobuf2_vmalloc btbcm videobuf2_memops btintel
videobuf2_v4l2 videobuf2_common bluetooth videodev mc ecdh_generic ecc
rmi_smbus rmi_core snd_hda_codec_hdmi snd_hda_codec_realtek iTCO_wdt
snd_hda_codec_generic mei_hdcp iTCO_vendor_support intel_rapl_msr
wmi_bmof intel_wmi_thunderbolt snd_soc_skl x86_pkg_temp_thermal
intel_powerclamp coretemp snd_soc_sst_ipc iwlmvm kvm_intel
snd_soc_sst_dsp snd_hda_ext_core snd_soc_acpi_intel_match mac80211
snd_soc_acpi i915 libarc4 kvm snd_soc_core irqbypass intel_cstate
snd_compress ac97_bus snd_pcm_dmaengine snd_hda_intel intel_uncore
snd_intel_dspcfg nls_iso8859_1 nls_cp437 iwlwifi snd_hda_codec
intel_rapl_perf vfat i2c_algo_bit snd_hda_core psmouse fat input_leds
[ 1234.179074]  pcspkr drm_kms_helper e1000e snd_hwdep tpm_crb snd_pcm
cec i2c_i801 snd_timer rc_core mei_me intel_gtt tpm_tis thunderbolt
cfg80211 syscopyarea tpm_tis_core processor_thermal_device sysfillrect
mei intel_pch_thermal intel_rapl_common ucsi_acpi
intel_xhci_usb_role_switch sysimgblt thinkpad_acpi fb_sys_fops
typec_ucsi roles intel_soc_dts_iosf tpm nvram typec ledtrig_audio
rng_core rfkill snd i2c_hid wmi int3403_thermal soundcore battery
int340x_thermal_zone ac hid evdev int3400_thermal acpi_thermal_rel
mac_hid drm pkcs8_key_parser agpgart ip_tables x_tables ext4
crc32c_generic crc16 mbcache jbd2 uas usb_storage dm_crypt dm_mod
crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel
serio_raw atkbd libps2 aesni_intel crypto_simd xhci_pci cryptd
glue_helper xhci_hcd i8042 serio
[ 1234.179085] CPU: 0 PID: 180 Comm: irq/126-pciehp Tainted: G
W  OE     5.6.3-arch1-1 #1
[ 1234.179085] Hardware name: LENOVO 20KHCTO1WW/20KHCTO1WW, BIOS
N23ET71W (1.46 ) 02/20/2020
[ 1234.179086] RIP: 0010:__free_irq+0x1c6/0x330
[ 1234.179087] Code: 8b bb e8 01 00 00 e8 49 8d 03 00 49 8b 7c 24 30
e8 9f c6 18 00 eb 42 44 89 f6 48 c7 c7 20 2b f3 b4 4c 89 04 24 e8 dc
94 f8 ff <0f> 0b 4c 8b 04 24 48 89 ef 4c 89 c6 e8 f9 4a 8a 00 48 8b 83
80 00
[ 1234.179087] RSP: 0018:ffffad590038bc30 EFLAGS: 00010086
[ 1234.179088] RAX: 0000000000000000 RBX: ffff914007a0fe00 RCX: 0000000000000000
[ 1234.179089] RDX: 0000000000000002 RSI: 0000000000000086 RDI: 00000000ffffffff
[ 1234.179089] RBP: ffff914007a0fee4 R08: 0000011f5acdf112 R09: ffffffffb5903ad4
[ 1234.179089] R10: 00000000000005ff R11: 000000000001d270 R12: ffff91400ce44260
[ 1234.179090] R13: ffff914007a0ffc0 R14: 0000000000000011 R15: ffff91400ce44000
[ 1234.179090] FS:  0000000000000000(0000) GS:ffff91400f400000(0000)
knlGS:0000000000000000
[ 1234.179091] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1234.179091] CR2: 00007ff016de70a8 CR3: 00000003d3e0a004 CR4: 00000000003606f0
[ 1234.179092] Call Trace:
[ 1234.179094]  free_irq+0x33/0x70
[ 1234.179097]  xhci_cleanup_msix+0x98/0xb0 [xhci_hcd]
[ 1234.179098]  ? irq_forced_thread_fn+0x80/0x80
[ 1234.179101]  xhci_stop+0x87/0x1a0 [xhci_hcd]
[ 1234.179102]  usb_remove_hcd+0x104/0x1bc
[ 1234.179103]  usb_hcd_pci_remove+0x69/0xd0
[ 1234.179104]  pci_device_remove+0x3b/0xa0
[ 1234.179106]  device_release_driver_internal+0xe4/0x1c0
[ 1234.179107]  pci_stop_bus_device+0x68/0x90
[ 1234.179108]  pci_stop_bus_device+0x2c/0x90
[ 1234.179109]  pci_stop_bus_device+0x3d/0x90
[ 1234.179110]  pci_stop_and_remove_bus_device+0xe/0x20
[ 1234.179111]  pciehp_unconfigure_device+0x83/0x136
[ 1234.179112]  pciehp_disable_slot+0x6b/0x100
[ 1234.179113]  pciehp_handle_presence_or_link_change+0xd8/0x2a0
[ 1234.179114]  pciehp_ist+0x123/0x130
[ 1234.179115]  irq_thread_fn+0x20/0x60
[ 1234.179116]  irq_thread+0xee/0x180
[ 1234.179116]  ? wake_threads_waitq+0x30/0x30
[ 1234.179117]  kthread+0xfb/0x130
[ 1234.179118]  ? irq_thread_check_affinity+0xd0/0xd0
[ 1234.179119]  ? kthread_park+0x90/0x90
[ 1234.179120]  ret_from_fork+0x35/0x40
[ 1234.179122] ---[ end trace 2783610e0ff6da32 ]---
[ 1234.179126] xhci_hcd 0000:0a:00.0: USB bus 5 deregistered
[ 1234.179293] pci_bus 0000:0a: busn_res: [bus 0a] is released
[ 1234.179321] pci_bus 0000:0b: busn_res: [bus 0b] is released
[ 1234.179406] pci_bus 0000:0c: busn_res: [bus 0c] is released
[ 1234.179430] pci_bus 0000:0d: busn_res: [bus 0d] is released
[ 1234.179453] pci_bus 0000:0e: busn_res: [bus 0e-3a] is released
[ 1234.179475] pci_bus 0000:09: busn_res: [bus 09-3a] is released
[ 1234.267448] usb 1-7: reset full-speed USB device number 2 using xhci_hcd
[ 1234.530803] usb 1-8: reset high-speed USB device number 3 using xhci_hcd
[ 1234.674635] usb 2-3: reset SuperSpeed Gen 1 USB device number 2
using xhci_hcd
[ 1234.817430] usb 1-9: reset full-speed USB device number 4 using xhci_hcd
[ 1236.012056] mei_hdcp
0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound 0000:00:02.0
(ops i915_hdcp_component_ops [i915])
[ 1236.013150] acpi LNXPOWER:01: Turning OFF
[ 1236.013729] Bluetooth: hci0: Bootloader revision 0.0 build 26 week 38 2015
[ 1236.013852] PM: hibernation: Basic memory bitmaps freed
[ 1236.013862] OOM killer enabled.
[ 1236.013863] Restarting tasks ...
[ 1236.014619] Bluetooth: hci0: Device revision is 16
[ 1236.014623] Bluetooth: hci0: Secure boot is enabled
[ 1236.014626] Bluetooth: hci0: OTP lock is enabled
[ 1236.014628] Bluetooth: hci0: API lock is enabled
[ 1236.014631] Bluetooth: hci0: Debug lock is disabled
[ 1236.014635] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
[ 1236.014642] Bluetooth: hci0: Found device firmware: intel/ibt-12-16.sfi
[ 1236.020766] done.
[ 1236.059383] PM: hibernation: hibernation exit
