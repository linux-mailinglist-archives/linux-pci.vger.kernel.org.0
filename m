Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0701144E1F5
	for <lists+linux-pci@lfdr.de>; Fri, 12 Nov 2021 07:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbhKLGhe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Nov 2021 01:37:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbhKLGhe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Nov 2021 01:37:34 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB9AC061766;
        Thu, 11 Nov 2021 22:34:43 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id r8so8195733qkp.4;
        Thu, 11 Nov 2021 22:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=t81RR2KynCOWAbPwWs/FqY8akht3T8JBpK3Z0wQ6/40=;
        b=JzlZ7smDZHNz7XDF6p2XUUKdV7iw/LNglKK8UyAgXxZPFrLCswLJ0EJc60uoVZI1sD
         Oq1FjtDMPLFiPm3Au0tw38IPFiMJ0C0vqYWODFbp0na5QjLnO5UtK/y9Ogj6NUWJirIg
         /F4GTDr5eILCPGQMwoXk1MUf7UHhAQajcYFzDfWwwBqAcqgd5mjLxkNOMXLoRr8FTm7H
         6A5dBCfiKYmy04fozubhZiy1RbESfXNpGYZhOQRMcNxTv6vqt3tcwfOeLO8TB3ZQHT3g
         yhg8+CPbCFfxHf7SjFid/cOKnTGtqFmMAqPiiRHjgA6yWlnwyJFvTem439vAiedlNmi7
         zWpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=t81RR2KynCOWAbPwWs/FqY8akht3T8JBpK3Z0wQ6/40=;
        b=a0V+V/nGwxGC9W2pMZG8cKDvcXYIFR5PSJV3jtsLG5fUS/0MswBiGV27J3n65AQN1s
         V3vNIN8ATet+PZDvGNjfn5EonUcR6n1Y9Gxz8ze7NFRUk70w80yY6LovekZbdiIeyWMQ
         H0AtumV6JSWotq+xXutNUDSb3v+EwTWGQFlF9zxKUmJw9l36/POT7pSwMDV6L7Ff2q3R
         Q6S1vGGs+ke3EAVkENr2dvReqZ429SAxBjWPls6x+474T826CydKqjcWPgXhxB6EFjJW
         +OIF8ratCmA+eyvSVBZkTRJA5sg8fUNbjXPIi1+F2naIPUYm3pV/ep6XYCBqhQNt96Zk
         jZ8g==
X-Gm-Message-State: AOAM531ZbCtN7K0mu9/5YpB2xGKkCzawoKj8UamXE8WHU/hSA0GqQadn
        iStcn+2iAC4iWGX3FiMy8pZUf1LqRGBvAN/sG60=
X-Google-Smtp-Source: ABdhPJxL77YR2yiPvtTSJayLXPMpsnVqXagf1CWrnMEXqp7f4MCPJT4LZFWaf8unVC1WtrlRgy91NA1WVegHFBMFr1k=
X-Received: by 2002:a37:c404:: with SMTP id d4mr10283611qki.120.1636698882952;
 Thu, 11 Nov 2021 22:34:42 -0800 (PST)
MIME-Version: 1.0
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Fri, 12 Nov 2021 11:34:32 +0500
Message-ID: <CABXGCsMFn2mTDmf0Jvw7UWasdrSLTe4JC-hi2BbsgGt-mJ_vkA@mail.gmail.com>
Subject: [Bug][5.16-rc0] Between commits 7ddb58cb0eca and d2f38a3c6507, the
 kernel stops loading on my devices.
To:     u.kleine-koenig@pengutronix.de, bhelgaas@google.com,
        linux-pci@vger.kernel.org, helgaas@kernel.org,
        kernel@pengutronix.de,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi!
Between commits 7ddb58cb0eca and d2f38a3c6507, the kernel stops
loading on my devices.
Which means when I select the problem kernel in the grub menu the
computer stops showing signs of life.
So today there will be no kernel logs, but only bisect log:

$ git bisect log
git bisect start
# good: [7ddb58cb0ecae8e8b6181d736a87667cc9ab8389] Merge tag
'clk-for-linus' of
git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux
git bisect good 7ddb58cb0ecae8e8b6181d736a87667cc9ab8389
# bad: [d2f38a3c6507b2520101f9a3807ed98f1bdc545a] Merge tag
'backlight-next-5.16' of
git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight
git bisect bad d2f38a3c6507b2520101f9a3807ed98f1bdc545a
# good: [a3f36773802d44d1e50e7c4c09b3e17018581d11] Merge tag
'mips_5.16' of git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux
git bisect good a3f36773802d44d1e50e7c4c09b3e17018581d11
# good: [512b7931ad0561ffe14265f9ff554a3c081b476b] Merge branch 'akpm'
(patches from Andrew)
git bisect good 512b7931ad0561ffe14265f9ff554a3c081b476b
# bad: [1e9ed9360f80d13e41684ca458f01fdf922c7c57] Merge tag
'kbuild-v5.16' of
git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild
git bisect bad 1e9ed9360f80d13e41684ca458f01fdf922c7c57
# bad: [0c5c62ddf88c34bc83b66e4ac9beb2bb0e1887d4] Merge tag
'pci-v5.16-changes' of
git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci
git bisect bad 0c5c62ddf88c34bc83b66e4ac9beb2bb0e1887d4
# bad: [78be29ab548f050fb61065f94f8c129a6cdde5c2] Merge branch 'pci/misc'
git bisect bad 78be29ab548f050fb61065f94f8c129a6cdde5c2
# bad: [4917f7189bd8be326d0910055b029d3cbf50256c] Merge branch 'pci/hotplug'
git bisect bad 4917f7189bd8be326d0910055b029d3cbf50256c
# good: [4141127c44a9b00d941885fc41392697d22a62c3] powerpc/eeh: Use
to_pci_driver() instead of pci_dev->driver
git bisect good 4141127c44a9b00d941885fc41392697d22a62c3
# good: [1cac57a267c1692594413f27913adec85ba3b02a] Merge branch
'pci/enumeration'
git bisect good 1cac57a267c1692594413f27913adec85ba3b02a
# good: [f9a6c8ad4922bf386c366e5ece453d459e628784] PCI/ERR: Reduce
compile time for CONFIG_PCIEAER=n
git bisect good f9a6c8ad4922bf386c366e5ece453d459e628784
# bad: [2a4d9408c9e8b6f6fc150c66f3fef755c9e20d4a] PCI: Use
to_pci_driver() instead of pci_dev->driver
git bisect bad 2a4d9408c9e8b6f6fc150c66f3fef755c9e20d4a
# good: [d98d53331b727838122bc80e1898c4e1fc201fb0] x86/pci/probe_roms:
Use to_pci_driver() instead of pci_dev->driver
git bisect good d98d53331b727838122bc80e1898c4e1fc201fb0
# first bad commit: [2a4d9408c9e8b6f6fc150c66f3fef755c9e20d4a] PCI:
Use to_pci_driver() instead of pci_dev->driver

My config:
$ inxi -F
System:    Host: primary-ws Kernel:
5.15.0-rc2-11-d98d53331b727838122bc80e1898c4e1fc201fb0+ x86_64 bits:
64
           Desktop: GNOME 41.0 Distro: Fedora release 36 (Rawhide)
Machine:   Type: Desktop Mobo: ASUSTeK model: ROG STRIX X570-I GAMING
v: Rev X.0x serial: <superuser required>
           UEFI: American Megatrends v: 4021 date: 08/09/2021
Battery:   ID-1: hidpp_battery_0 charge: 95% condition: N/A
CPU:       Info: 16-Core (2-Die) model: AMD Ryzen 9 3950X bits: 64
type: MT MCP MCM cache: L2: 8 MiB
           Speed: 2200 MHz min/max: 2200/3500 MHz Core speeds (MHz):
1: 2200 2: 2200 3: 2143 4: 2194 5: 3553 6: 2200 7: 2200
           8: 2200 9: 2200 10: 2200 11: 2200 12: 2200 13: 2200 14:
2568 15: 2149 16: 1900 17: 2022 18: 2199 19: 3656 20: 2085
           21: 2198 22: 2200 23: 2200 24: 2200 25: 2200 26: 2200 27:
2127 28: 2467 29: 2181 30: 2200 31: 2200 32: 2200
Graphics:  Device-1: Advanced Micro Devices [AMD/ATI] Navi 21 [Radeon
RX 6800/6800 XT / 6900 XT] driver: amdgpu v: kernel
           Device-2: AVerMedia Live Gamer Ultra-Video type: USB
driver: hid-generic,snd-usb-audio,usbhid,uvcvideo
           Device-3: AVerMedia Live Streamer CAM 513 type: USB driver:
hid-generic,usbhid,uvcvideo
           Display: wayland server: X.Org 1.21.1.3 driver: loaded:
amdgpu,ati unloaded: fbdev,modesetting,radeon,vesa
           resolution: 3840x2160~60Hz
           OpenGL: renderer: AMD Radeon RX 6900 XT (sienna_cichlid
LLVM 13.0.0 DRM 3.42
           5.15.0-rc2-11-d98d53331b727838122bc80e1898c4e1fc201fb0+)
           v: 4.6 Mesa 22.0.0-devel
Audio:     Device-1: AMD Navi 21 HDMI Audio [Radeon RX 6800/6800 XT /
6900 XT] driver: snd_hda_intel
           Device-2: Advanced Micro Devices [AMD] Starship/Matisse HD
Audio driver: snd_hda_intel
           Device-3: miniDSP IL-DSP type: USB driver:
hid-generic,snd-usb-audio,usbhid
           Device-4: Audio-Technica AT2020USB+ type: USB driver:
hid-generic,snd-usb-audio,usbhid
           Device-5: AVerMedia Live Gamer Ultra-Video type: USB
driver: hid-generic,snd-usb-audio,usbhid,uvcvideo
           Device-6: AVerMedia Live Streamer CAM 513 type: USB driver:
hid-generic,snd-usb-audio,usbhid
           Sound Server-1: ALSA v:
k5.15.0-rc2-11-d98d53331b727838122bc80e1898c4e1fc201fb0+ running: yes
           Sound Server-2: PipeWire v: 0.3.39 running: yes
Network:   Device-1: Intel Wi-Fi 6 AX200 driver: iwlwifi
           IF: wlp4s0 state: down mac: 76:6f:11:75:c8:9c
           Device-2: Intel I211 Gigabit Network driver: igb
           IF: enp5s0 state: up speed: 1000 Mbps duplex: full mac:
a8:5e:45:50:a6:9e
           IF-ID-1: vpn0 state: up speed: 10 Mbps duplex: full mac: N/A
Bluetooth: Device-1: Intel AX200 Bluetooth type: USB driver: btusb
           Report: rfkill ID: hci0 state: up address: see --recommends
Drives:    Local Storage: total: 16.81 TiB used: 12.87 TiB (76.6%)
           ID-1: /dev/nvme0n1 vendor: Intel model: SSDPE21D480GA size:
447.13 GiB
           ID-2: /dev/sda vendor: Western Digital model:
WUH721818ALE6L4 size: 16.37 TiB
Partition: ID-1: / size: 175.13 GiB used: 85.87 GiB (49.0%) fs: ext4
dev: /dev/nvme0n1p2
           ID-2: /boot/efi size: 511 MiB used: 13.9 MiB (2.7%) fs:
vfat dev: /dev/nvme0n1p1
           ID-3: /home size: 16.3 TiB used: 12.79 TiB (78.4%) fs: ext4
dev: /dev/sda1
Swap:      ID-1: swap-1 type: partition size: 64 GiB used: 0 KiB
(0.0%) dev: /dev/nvme0n1p3
           ID-2: swap-2 type: zram size: 8 GiB used: 0 KiB (0.0%) dev:
/dev/zram0
Sensors:   Message: No sensor data found. Is lm-sensors configured?
Info:      Processes: 610 Uptime: 20m Memory: 62.62 GiB used: 20.42
GiB (32.6%) Shell: Bash inxi: 3.3.06

Can anyone help fix this problem, please?

--
Best Regards,
Mike Gavrilov.
