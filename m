Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F212044EE0D
	for <lists+linux-pci@lfdr.de>; Fri, 12 Nov 2021 21:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235678AbhKLUps (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Nov 2021 15:45:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:53056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235682AbhKLUpl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Nov 2021 15:45:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C026C6113B;
        Fri, 12 Nov 2021 20:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636749766;
        bh=vg6aRlO21SvWqmu+iKyshDe6G2sLUD7qO6CsfAXhiHM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Q1NC4L7FtTBi7Lb6EJEKxbiZSJZj0lKwRwcO6+wQ8tpqOqvodE/iGS05qgLjkYeZl
         cubKjIX4sFOsCUOvJ48TGHeysgpByiOm32fX22T1iOyLlcRHD2sX+BmVGtBf3OGEv+
         7EJj1bIqXb6FlGsb2qxniYyjo2IYqGTWkie5Vy2XlvC1IQJ4H0V17LzlbrQaBK3PrQ
         bXv5gumegS3DRhOKbpiKcG3NTfcofqiRVmZ0PxJQsc79ckUTDeqICN1prejNOZttX5
         dv9mKdCZg1ry+xg4Msb8RxX6a2KHGMX/LBSc5kOkVGS1zJLdcBe4dAbxXUDcJHmHFT
         yQKLlq5tVY64A==
Date:   Fri, 12 Nov 2021 14:42:44 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc:     u.kleine-koenig@pengutronix.de, bhelgaas@google.com,
        linux-pci@vger.kernel.org, kernel@pengutronix.de,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: [Bug][5.16-rc0] Between commits 7ddb58cb0eca and d2f38a3c6507,
 the kernel stops loading on my devices.
Message-ID: <20211112204244.GA1415948@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABXGCsMFn2mTDmf0Jvw7UWasdrSLTe4JC-hi2BbsgGt-mJ_vkA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 12, 2021 at 11:34:32AM +0500, Mikhail Gavrilov wrote:
> Hi!
> Between commits 7ddb58cb0eca and d2f38a3c6507, the kernel stops
> loading on my devices.
> Which means when I select the problem kernel in the grub menu the
> computer stops showing signs of life.
> So today there will be no kernel logs, but only bisect log:
> ...

> # first bad commit: [2a4d9408c9e8b6f6fc150c66f3fef755c9e20d4a] PCI:
> Use to_pci_driver() instead of pci_dev->driver
> 
> My config:
> $ inxi -F
> System:    Host: primary-ws Kernel:
> 5.15.0-rc2-11-d98d53331b727838122bc80e1898c4e1fc201fb0+ x86_64 bits:
> 64
>            Desktop: GNOME 41.0 Distro: Fedora release 36 (Rawhide)
> Machine:   Type: Desktop Mobo: ASUSTeK model: ROG STRIX X570-I GAMING
> v: Rev X.0x serial: <superuser required>
>            UEFI: American Megatrends v: 4021 date: 08/09/2021
> Battery:   ID-1: hidpp_battery_0 charge: 95% condition: N/A
> CPU:       Info: 16-Core (2-Die) model: AMD Ryzen 9 3950X bits: 64
> type: MT MCP MCM cache: L2: 8 MiB
>            Speed: 2200 MHz min/max: 2200/3500 MHz Core speeds (MHz):
> 1: 2200 2: 2200 3: 2143 4: 2194 5: 3553 6: 2200 7: 2200
>            8: 2200 9: 2200 10: 2200 11: 2200 12: 2200 13: 2200 14:
> 2568 15: 2149 16: 1900 17: 2022 18: 2199 19: 3656 20: 2085
>            21: 2198 22: 2200 23: 2200 24: 2200 25: 2200 26: 2200 27:
> 2127 28: 2467 29: 2181 30: 2200 31: 2200 32: 2200
> Graphics:  Device-1: Advanced Micro Devices [AMD/ATI] Navi 21 [Radeon
> RX 6800/6800 XT / 6900 XT] driver: amdgpu v: kernel
>            Device-2: AVerMedia Live Gamer Ultra-Video type: USB
> driver: hid-generic,snd-usb-audio,usbhid,uvcvideo
>            Device-3: AVerMedia Live Streamer CAM 513 type: USB driver:
> hid-generic,usbhid,uvcvideo
>            Display: wayland server: X.Org 1.21.1.3 driver: loaded:
> amdgpu,ati unloaded: fbdev,modesetting,radeon,vesa
>            resolution: 3840x2160~60Hz
>            OpenGL: renderer: AMD Radeon RX 6900 XT (sienna_cichlid
> LLVM 13.0.0 DRM 3.42
>            5.15.0-rc2-11-d98d53331b727838122bc80e1898c4e1fc201fb0+)
>            v: 4.6 Mesa 22.0.0-devel
> Audio:     Device-1: AMD Navi 21 HDMI Audio [Radeon RX 6800/6800 XT /
> 6900 XT] driver: snd_hda_intel
>            Device-2: Advanced Micro Devices [AMD] Starship/Matisse HD
> Audio driver: snd_hda_intel
>            Device-3: miniDSP IL-DSP type: USB driver:
> hid-generic,snd-usb-audio,usbhid
>            Device-4: Audio-Technica AT2020USB+ type: USB driver:
> hid-generic,snd-usb-audio,usbhid
>            Device-5: AVerMedia Live Gamer Ultra-Video type: USB
> driver: hid-generic,snd-usb-audio,usbhid,uvcvideo
>            Device-6: AVerMedia Live Streamer CAM 513 type: USB driver:
> hid-generic,snd-usb-audio,usbhid
>            Sound Server-1: ALSA v:
> k5.15.0-rc2-11-d98d53331b727838122bc80e1898c4e1fc201fb0+ running: yes
>            Sound Server-2: PipeWire v: 0.3.39 running: yes
> Network:   Device-1: Intel Wi-Fi 6 AX200 driver: iwlwifi
>            IF: wlp4s0 state: down mac: 76:6f:11:75:c8:9c
>            Device-2: Intel I211 Gigabit Network driver: igb
>            IF: enp5s0 state: up speed: 1000 Mbps duplex: full mac:
> a8:5e:45:50:a6:9e
>            IF-ID-1: vpn0 state: up speed: 10 Mbps duplex: full mac: N/A
> Bluetooth: Device-1: Intel AX200 Bluetooth type: USB driver: btusb
>            Report: rfkill ID: hci0 state: up address: see --recommends
> Drives:    Local Storage: total: 16.81 TiB used: 12.87 TiB (76.6%)
>            ID-1: /dev/nvme0n1 vendor: Intel model: SSDPE21D480GA size:
> 447.13 GiB
>            ID-2: /dev/sda vendor: Western Digital model:
> WUH721818ALE6L4 size: 16.37 TiB
> Partition: ID-1: / size: 175.13 GiB used: 85.87 GiB (49.0%) fs: ext4
> dev: /dev/nvme0n1p2
>            ID-2: /boot/efi size: 511 MiB used: 13.9 MiB (2.7%) fs:
> vfat dev: /dev/nvme0n1p1
>            ID-3: /home size: 16.3 TiB used: 12.79 TiB (78.4%) fs: ext4
> dev: /dev/sda1
> Swap:      ID-1: swap-1 type: partition size: 64 GiB used: 0 KiB
> (0.0%) dev: /dev/nvme0n1p3
>            ID-2: swap-2 type: zram size: 8 GiB used: 0 KiB (0.0%) dev:
> /dev/zram0
> Sensors:   Message: No sensor data found. Is lm-sensors configured?
> Info:      Processes: 610 Uptime: 20m Memory: 62.62 GiB used: 20.42
> GiB (32.6%) Shell: Bash inxi: 3.3.06
> 
> Can anyone help fix this problem, please?

Sorry about the problem, and thank you very much for bisecting it!  I
know that's a lot of hassle.

As Uwe said, this will almost certainly be fixed by 
https://git.kernel.org/linus/5833291ab6de.

I am interested in which driver tripped over this, though, because
when we revisit this, we'll want to make sure not to break it.  We
first saw this problem with i2c_designware_pci, but you have found
another case.  Can you share your full "lspci -v" output?

Bjorn
