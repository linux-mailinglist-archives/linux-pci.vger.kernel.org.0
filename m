Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6406D23F8D2
	for <lists+linux-pci@lfdr.de>; Sat,  8 Aug 2020 22:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbgHHUxs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 8 Aug 2020 16:53:48 -0400
Received: from magic.merlins.org ([209.81.13.136]:42620 "EHLO
        mail1.merlins.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbgHHUxs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 8 Aug 2020 16:53:48 -0400
X-Greylist: delayed 1807 seconds by postgrey-1.27 at vger.kernel.org; Sat, 08 Aug 2020 16:53:48 EDT
Received: from c-24-5-124-255.hsd1.ca.comcast.net ([24.5.124.255]:59730 helo=sauron.svh.merlins.org)
        by mail1.merlins.org with esmtpsa 
        (Cipher TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92 #3)
        id 1k4VLv-0003Fm-AN by authid <merlins.org> with srv_auth_plain; Sat, 08 Aug 2020 13:22:03 -0700
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.92)
        (envelope-from <marc@merlins.org>)
        id 1k4VLu-0007rN-Vf; Sat, 08 Aug 2020 13:22:02 -0700
Date:   Sat, 8 Aug 2020 13:22:02 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Matthias Andree <matthias.andree@gmx.de>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] PCI: Introduce pcie_wait_for_link_delay()
Message-ID: <20200808202202.GA12007@merlins.org>
References: <20191004123947.11087-1-mika.westerberg@linux.intel.com>
 <20191004123947.11087-2-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191004123947.11087-2-mika.westerberg@linux.intel.com>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
X-SA-Exim-Connect-IP: 24.5.124.255
X-SA-Exim-Mail-From: marc@merlins.org
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 04, 2019 at 03:39:46PM +0300, Mika Westerberg wrote:
> This is otherwise similar to pcie_wait_for_link() but allows passing
> custom activation delay in milliseconds.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  drivers/pci/pci.c | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index e7982af9a5d8..bfd92e018925 100644

Hi Mika,

So, I have a thinkpad P73 with thunderbolt, and while I don't boot
often, my last boots have been unreliable at best (was only able to boot
5.7 once, and 5.8 did not succeed either).

5.6 was working for a while, but couldn't boot it either this morning,
so I had to go back to 5.5. This does not mean 5.5 does not have the
problem, just that it booted this morning, while 5.6 didn't when I
tried.
Once the kernel is booted, the problem does not seem to occur much, or
at all.

Basically, I'm getting the same thing than this person with a P53 (which
is a mostly identical lenovo thinkpad, to mine)
kernel: pcieport 0000:00:01.0: PME: Spurious native interrupt!
kernel: pcieport 0000:00:01.0: PME: Spurious native interrupt!
kernel: pcieport 0000:00:01.0: PME: Spurious native interrupt!
kernel: pcieport 0000:00:01.0: PME: Spurious native interrupt!
kernel: pcieport 0000:00:01.0: PME: Spurious native interrupt!
https://bbs.archlinux.org/viewtopic.php?id=250658

The kernel boots eventually, but it takes minutes, and everything is so
super slow, that I just can't reasonably use the machine.

This shows similar issues with 5.3, 5.4.
https://forum.proxmox.com/threads/pme-spurious-native-interrupt-kernel-meldungen.62850/

Another report here with 5.6:
https://bugzilla.redhat.com/show_bug.cgi?id=1831899

My current kernel is running your patch above, and I haven't done a lot
of research yet to confirm whether going back to a kernel before it was
merged, fixes the problem. Unfortunately the problem is not consistent,
so it makes things harder to test/debug, especially on my main laptop
that I do all my work on :)

I noticed this older patch of yours:
http://patchwork.ozlabs.org/project/linux-pci/patch/0113014581dbe2d1f938813f1783905bd81b79db.1560079442.git.lukas@wunner.de/
This patch is not in my kernel, is it worth adding?

Can I get you more info to help debug this?

If that helps:
sauron:/usr/src/linux-5.7.11-amd64-preempt-sysrq-20190816/drivers/pci# lspci
00:00.0 Host bridge: Intel Corporation Device 3e20 (rev 0d)
00:01.0 PCI bridge: Intel Corporation Xeon E3-1200 v5/E3-1500 v5/6th Gen Core Processor PCIe Controller (x16) (rev 0d)
00:02.0 VGA compatible controller: Intel Corporation UHD Graphics 630 (Mobile) (rev 02)
00:04.0 Signal processing controller: Intel Corporation Xeon E3-1200 v5/E3-1500 v5/6th Gen Core Processor Thermal Subsystem (rev 0d)
00:08.0 System peripheral: Intel Corporation Xeon E3-1200 v5/v6 / E3-1500 v5 / 6th/7th/8th Gen Core Processor Gaussian Mixture Model
00:12.0 Signal processing controller: Intel Corporation Cannon Lake PCH Thermal Controller (rev 10)
00:14.0 USB controller: Intel Corporation Cannon Lake PCH USB 3.1 xHCI Host Controller (rev 10)
00:14.2 RAM memory: Intel Corporation Cannon Lake PCH Shared SRAM (rev 10)
00:15.0 Serial bus controller [0c80]: Intel Corporation Cannon Lake PCH Serial IO I2C Controller #0 (rev 10)
00:15.1 Serial bus controller [0c80]: Intel Corporation Cannon Lake PCH Serial IO I2C Controller #1 (rev 10)
00:16.0 Communication controller: Intel Corporation Cannon Lake PCH HECI Controller (rev 10)
00:17.0 SATA controller: Intel Corporation Cannon Lake Mobile PCH SATA AHCI Controller (rev 10)
00:1b.0 PCI bridge: Intel Corporation Cannon Lake PCH PCI Express Root Port #17 (rev f0)
00:1c.0 PCI bridge: Intel Corporation Cannon Lake PCH PCI Express Root Port #1 (rev f0)
00:1c.5 PCI bridge: Intel Corporation Cannon Lake PCH PCI Express Root Port #6 (rev f0)
00:1c.7 PCI bridge: Intel Corporation Cannon Lake PCH PCI Express Root Port #8 (rev f0)
00:1e.0 Communication controller: Intel Corporation Cannon Lake PCH Serial IO UART Host Controller (rev 10)
00:1f.0 ISA bridge: Intel Corporation Cannon Lake LPC Controller (rev 10)
00:1f.3 Audio device: Intel Corporation Cannon Lake PCH cAVS (rev 10)
00:1f.4 SMBus: Intel Corporation Cannon Lake PCH SMBus Controller (rev 10)
00:1f.5 Serial bus controller [0c80]: Intel Corporation Cannon Lake PCH SPI Controller (rev 10)
00:1f.6 Ethernet controller: Intel Corporation Ethernet Connection (7) I219-LM (rev 10)
01:00.0 VGA compatible controller: NVIDIA Corporation TU104GLM [Quadro RTX 4000 Mobile / Max-Q] (rev a1)
01:00.1 Audio device: NVIDIA Corporation TU104 HD Audio Controller (rev a1)
01:00.2 USB controller: NVIDIA Corporation TU104 USB 3.1 Host Controller (rev a1)
01:00.3 Serial bus controller [0c80]: NVIDIA Corporation TU104 USB Type-C UCSI Controller (rev a1)
02:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe SSD Controller SM981/PM981/PM983
04:00.0 PCI bridge: Intel Corporation JHL7540 Thunderbolt 3 Bridge [Titan Ridge 4C 2018] (rev 06)
05:00.0 PCI bridge: Intel Corporation JHL7540 Thunderbolt 3 Bridge [Titan Ridge 4C 2018] (rev 06)
05:01.0 PCI bridge: Intel Corporation JHL7540 Thunderbolt 3 Bridge [Titan Ridge 4C 2018] (rev 06)
05:02.0 PCI bridge: Intel Corporation JHL7540 Thunderbolt 3 Bridge [Titan Ridge 4C 2018] (rev 06)
05:04.0 PCI bridge: Intel Corporation JHL7540 Thunderbolt 3 Bridge [Titan Ridge 4C 2018] (rev 06)
06:00.0 System peripheral: Intel Corporation JHL7540 Thunderbolt 3 NHI [Titan Ridge 4C 2018] (rev 06)
2c:00.0 USB controller: Intel Corporation JHL7540 Thunderbolt 3 USB Controller [Titan Ridge 4C 2018] (rev 06)
52:00.0 Network controller: Intel Corporation Wi-Fi 6 AX200 (rev 1a)
54:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd. RTS525A PCI Express Card Reader (rev 01)


sauron:/usr/src/linux-5.7.11-amd64-preempt-sysrq-20190816/drivers/pci# lsusb -t
/:  Bus 06.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/2p, 10000M
/:  Bus 05.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/2p, 480M
/:  Bus 04.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/4p, 10000M
/:  Bus 03.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/2p, 480M
/:  Bus 02.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/10p, 10000M
/:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/16p, 480M
    |__ Port 2: Dev 2, If 0, Class=Human Interface Device, Driver=usbhid, 12M
    |__ Port 8: Dev 3, If 3, Class=Video, Driver=uvcvideo, 480M
    |__ Port 8: Dev 3, If 1, Class=Video, Driver=uvcvideo, 480M
    |__ Port 8: Dev 3, If 2, Class=Video, Driver=uvcvideo, 480M
    |__ Port 8: Dev 3, If 0, Class=Video, Driver=uvcvideo, 480M
    |__ Port 9: Dev 4, If 0, Class=Vendor Specific Class, Driver=, 12M
    |__ Port 14: Dev 6, If 0, Class=Wireless, Driver=btusb, 12M
    |__ Port 14: Dev 6, If 1, Class=Wireless, Driver=btusb, 12M

Thanks,
Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
