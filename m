Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9074A356F49
	for <lists+linux-pci@lfdr.de>; Wed,  7 Apr 2021 16:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240777AbhDGOwA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Apr 2021 10:52:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:55190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232041AbhDGOv7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Apr 2021 10:51:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B84806138B;
        Wed,  7 Apr 2021 14:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617807110;
        bh=JMvI0Mp2vrih+uI7KeVSUrQ4+HeSRaEYCfxTEmIoBRc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l41R9o7AIC9m3CB0o75ZDg50S8mu9+1KIoNHoT26PMDjvt4zu2CBLGUhGiBPOceSL
         6uykG64Li+tuYpmY8WvQmFhY22jSzAqN0+Nf8/qrU16M18cfJuXbB0rVEhC85clgKk
         nS5hNOlxEB1quf5Kp8Uw6aILl1T39F+iOb6/yKGJ1ngKX8/bANq0NVnGWOYmO/T0ec
         E1JKOZA1VU346up7WaYNW1pHAlomYfpboBFQmC45xl8zNBrEfXR1pu1fWldSvH8KvS
         z7DEG+S1LbF218z3VRlc4WoIK/1nMoeIjXVxDO60WjvjmhwlXLcK98f9NRklvV1JQG
         76iZrA8G4YjvA==
Received: by pali.im (Postfix)
        id A9187521; Wed,  7 Apr 2021 16:51:47 +0200 (CEST)
Date:   Wed, 7 Apr 2021 16:51:47 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Petr =?utf-8?Q?=C5=A0tetiar?= <ynezz@true.cz>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Yinghai Lu <yinghai@kernel.org>,
        Koen Vandeputte <koen.vandeputte@citymesh.com>
Subject: Re: PCI: Race condition in pci_create_sysfs_dev_files
Message-ID: <20210407145147.bvtubdmz4k6nulf7@pali>
References: <20200909112850.hbtgkvwqy2rlixst@pali>
 <20201006222222.GA3221382@bjorn-Precision-5520>
 <20201007081227.d6f6otfsnmlgvegi@pali>
 <20210407142538.GA12387@meh.true.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210407142538.GA12387@meh.true.cz>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wednesday 07 April 2021 16:25:46 Petr Štetiar wrote:
> Pali Rohár <pali@kernel.org> [2020-10-07 10:12:27]:
> 
> Hi,
> 
> [adding Koen to Cc:]
> 
> > I'm hitting these race conditions randomly on pci aardvark controller
> > driver- I prepared patch which speed up initialization of this driver,
> > but also increase probability that it hits above race conditions :-(
> 
> it seems, that I'm able to reproduce this race condition on every boot with
> 5.10 on my Freescale i.MX6Q board, see the log excerpt bellow. I don't know if
> this helps, but it's not happening on 5.4 kernel.

Hello! This is same race condition which I described in my original
report. Good to know that other people can reproduce it too!

> [    0.000000] Booting Linux on physical CPU 0x0
> [    0.000000] Linux version 5.10.27 (ynezz@ntbk) (arm-openwrt-linux-muslgnueabi-gcc (OpenWrt GCC 8.4.0 r12719+30-84f4a783c698) 8.4.0, GNU ld (GNU Binutils) 2.34) #0 SMP Wed Apr 7 12:52:23 2021
> [    0.000000] CPU: ARMv7 Processor [412fc09a] revision 10 (ARMv7), cr=10c5387d
> [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
> [    0.000000] OF: fdt: Machine model: Toradex Apalis iMX6Q/D Module on Ixora Carrier Board
> 
> ...
> 
> [    2.239498] pci 0000:00:00.0: BAR 0: assigned [mem 0x01000000-0x010fffff]
> [    2.266430] pci 0000:00:00.0: BAR 6: assigned [mem 0x01100000-0x0110ffff pref]
> ����#���+$HH��.274570] pci 0000:00:00.0: Max Payload Size set to  128/ 128 (was  128), Max Read Rq  128
> 
>  (this serial console hiccup during PCI initialization seems quite strange as well, happens always)

I'm seeing similar garbage on UART output when such thing happen. But I
suspect that this is the issue when doing serialization of more parallel
messages print by kernel. Nothing relevant to PCI.

But running 'dmesg' after full bootup can show also these lost messages.

> [    2.283074] sysfs: cannot create duplicate filename '/devices/platform/soc/1ffc000.pcie/pci0000:00/0000:00:00.0/config'
> [    2.293884] CPU: 1 PID: 47 Comm: kworker/u8:3 Not tainted 5.10.27 #0
> [    2.300165] random: fast init done
> [    2.300249] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
> [    2.310186] Workqueue: events_unbound async_run_entry_fn

And this is important information! Device is registered by some async
workqueue. When I tried to use my (private) patch which speed by
aardvark initialization by putting init code into separate worker then
probability of hitting this race condition increased to about 90%. So
same situation as yours, it was called from async workqueue.

But now with 5.12-rc kernel I'm not able to reproduce it because
something changed in kernel and kernel schedule this "racy" worker long
after race condition may happen.

So it needs perfect timing and seems that one important thing is to call
pci_bus_add_device() function from separate worker.

> [    2.315507] Backtrace:
> [    2.317976] [<8010cc88>] (dump_backtrace) from [<8010d134>] (show_stack+0x20/0x24)
> [    2.325556]  r7:813283d4 r6:60000013 r5:00000000 r4:80ec845c
> [    2.331236] [<8010d114>] (show_stack) from [<805971fc>] (dump_stack+0xa4/0xb8)
> [    2.338480] [<80597158>] (dump_stack) from [<803a7128>] (sysfs_warn_dup+0x68/0x74)
> [    2.346058]  r7:813283d4 r6:80af0dfc r5:812f48f0 r4:81afa000
> [    2.351726] [<803a70c0>] (sysfs_warn_dup) from [<803a6c90>] (sysfs_add_file_mode_ns+0x100/0x1cc)
> [    2.360518]  r7:813283d4 r6:812f48f0 r5:80b4299c r4:ffffffef
> [    2.366187] [<803a6b90>] (sysfs_add_file_mode_ns) from [<803a6fe8>] (sysfs_create_bin_file+0x94/0x9c)
> [    2.375411]  r6:81eb8078 r5:80b4299c r4:00000000
> [    2.380043] [<803a6f54>] (sysfs_create_bin_file) from [<805da848>] (pci_create_sysfs_dev_files+0x58/0x2cc)
> [    2.389701]  r6:81eb8000 r5:81eb8078 r4:81eb8000
> [    2.394341] [<805da7f0>] (pci_create_sysfs_dev_files) from [<805cba98>] (pci_bus_add_device+0x34/0x90)
> [    2.403659]  r10:80b45d88 r9:81818810 r8:81328200 r7:813283d4 r6:8190c000 r5:81eb8078
> [    2.411490]  r4:81eb8000
> [    2.414034] [<805cba64>] (pci_bus_add_device) from [<805cbb30>] (pci_bus_add_devices+0x3c/0x80)
> [    2.421744] random: crng init done
> [    2.422737]  r5:8190c014 r4:81eb8000
> [    2.429720] [<805cbaf4>] (pci_bus_add_devices) from [<805cf898>] (pci_host_probe+0x50/0xa0)
> [    2.438078]  r7:813283d4 r6:8190c000 r5:8190c00c r4:00000000
> [    2.443753] [<805cf848>] (pci_host_probe) from [<805eeb20>] (dw_pcie_host_init+0x1d0/0x414)
> [    2.452111]  r7:813283d4 r6:81328058 r5:00000200 r4:00000000
> [    2.457780] [<805ee950>] (dw_pcie_host_init) from [<805ef5a8>] (imx6_pcie_probe+0x38c/0x69c)
> [    2.466226]  r10:81226180 r9:ef0205c4 r8:81818800 r7:81328040 r6:81328040 r5:81818810
> [    2.474060]  r4:00000020
> [    2.476615] [<805ef21c>] (imx6_pcie_probe) from [<8065e858>] (platform_drv_probe+0x58/0xa8)
> [    2.484977]  r10:80ec9f78 r9:00000000 r8:80f160a8 r7:00000000 r6:80ec9f78 r5:00000000
> [    2.492809]  r4:81818810
> [    2.495357] [<8065e800>] (platform_drv_probe) from [<8065c0a0>] (really_probe+0x128/0x534)
> [    2.503627]  r7:00000000 r6:80f5b8c4 r5:81818810 r4:80f5b8d4
> [    2.509296] [<8065bf78>] (really_probe) from [<8065c700>] (driver_probe_device+0x88/0x200)
> [    2.517570]  r10:00000000 r9:80f0bb60 r8:00000000 r7:80f160a8 r6:80ec9f78 r5:80ec9f78
> [    2.525401]  r4:81818810
> [    2.527946] [<8065c678>] (driver_probe_device) from [<8065c904>] (__driver_attach_async_helper+0x8c/0xb4)
> [    2.537521]  r9:80f0bb60 r8:00000000 r7:8104d000 r6:80ec9f78 r5:80f25010 r4:81818810
> [    2.545273] [<8065c878>] (__driver_attach_async_helper) from [<8015b930>] (async_run_entry_fn+0x58/0x1bc)
> [    2.554843]  r6:819fb480 r5:80f25010 r4:819fb490
> [    2.559479] [<8015b8d8>] (async_run_entry_fn) from [<8015114c>] (process_one_work+0x238/0x5ac)
> [    2.568099]  r8:00000000 r7:8104d000 r6:81048400 r5:8127a080 r4:819fb490
> [    2.574811] [<80150f14>] (process_one_work) from [<8015152c>] (worker_thread+0x6c/0x5c0)
> [    2.582909]  r10:81048400 r9:80e03d00 r8:81048418 r7:00000088 r6:81048400 r5:8127a094
> [    2.590742]  r4:8127a080
> [    2.593290] [<801514c0>] (worker_thread) from [<80158168>] (kthread+0x174/0x178)
> [    2.600694]  r10:8127a080 r9:812e3024 r8:8116fe74 r7:813c0000 r6:00000000 r5:8127b040
> [    2.608527]  r4:812e3000
> [    2.611073] [<80157ff4>] (kthread) from [<80100148>] (ret_from_fork+0x14/0x2c)
> [    2.618302] Exception stack(0x813c1fb0 to 0x813c1ff8)
> [    2.623362] 1fa0:                                     00000000 00000000 00000000 00000000
> [    2.631548] 1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [    2.639731] 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
> [    2.646354]  r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:80157ff4
> [    2.654187]  r4:8127b040
> [    2.657157] pcieport 0000:00:00.0: PME: Signaling with IRQ 316
> [    2.674770] VFS: Mounted root (squashfs filesystem) readonly on device 179:2.
> [    2.686264] Freeing unused kernel memory: 1024K
> 
> Complete serial console log http://sprunge.us/wCe6zs

Could you run 'dmesg' and provide its output? So also missing / garbage
messages would be visible.
