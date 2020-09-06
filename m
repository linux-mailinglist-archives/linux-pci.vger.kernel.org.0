Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D188B25EFE5
	for <lists+linux-pci@lfdr.de>; Sun,  6 Sep 2020 20:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725931AbgIFSzx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 6 Sep 2020 14:55:53 -0400
Received: from magic.merlins.org ([209.81.13.136]:53832 "EHLO
        mail1.merlins.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729185AbgIFSzQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 6 Sep 2020 14:55:16 -0400
X-Greylist: delayed 1970 seconds by postgrey-1.27 at vger.kernel.org; Sun, 06 Sep 2020 14:55:16 EDT
Received: from c-24-5-124-255.hsd1.ca.comcast.net ([24.5.124.255]:43138 helo=sauron.svh.merlins.org)
        by mail1.merlins.org with esmtpsa 
        (Cipher TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92 #3)
        id 1kEzFc-0002sa-Dl by authid <merlins.org> with srv_auth_plain; Sun, 06 Sep 2020 11:19:45 -0700
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.92)
        (envelope-from <marc_nouveau@merlins.org>)
        id 1kEzFc-0002XU-60; Sun, 06 Sep 2020 11:18:52 -0700
Date:   Sun, 6 Sep 2020 11:18:52 -0700
From:   Marc MERLIN <marc_nouveau@merlins.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, nouveau@lists.freedesktop.org,
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
Subject: Re: pcieport 0000:00:01.0: PME: Spurious native interrupt (nvidia
 with nouveau and thunderbolt on thinkpad P73)
Message-ID: <20200906181852.GC13955@merlins.org>
References: <20191004123947.11087-1-mika.westerberg@linux.intel.com>
 <20191004123947.11087-2-mika.westerberg@linux.intel.com>
 <20200808202202.GA12007@merlins.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200808202202.GA12007@merlins.org>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
X-SA-Exim-Connect-IP: 24.5.124.255
X-SA-Exim-Mail-From: marc_nouveau@merlins.org
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Ok, I have an update to this problem. I added the nouveau list because
I can't quite tell if the issue is:
- the PCIe changes that went in 5.6 I think (or 5.5?), referenced below

- a new issue with thunderbold on thinkpad P73, that seems to be
  triggered if I have a USB-C yubikey in the port. With 5.7, my issues
  went away if I removed the USB key during boot, showing an interaction
  between nouveau and thunderbolt

- changes in the nouveau driver. Mika told me the PCIe regression
  "pcieport 0000:00:01.0: PME: Spurious native interrupt!" is supposed
  to be fixed in 5.8, but I still get a 4mn hang or so during boot and
  with 5.8, removing the USB key, didn't help make the boot faster

I don't otherwise use the nvidia chip I so wish I didn't have, I only
use intel graphics on that laptop, but I must apparently use the nouveau
driver to manage the nouveau chip so that it's turned off and not
burning 60W doing nothing.

lspci is in the quoted message below, I won't copy it here again, but
here's the nvidia bit:
01:00.0 VGA compatible controller: NVIDIA Corporation TU104GLM [Quadro RTX 4000 Mobile / Max-Q] (rev a1)
01:00.1 Audio device: NVIDIA Corporation TU104 HD Audio Controller (rev a1)
01:00.2 USB controller: NVIDIA Corporation TU104 USB 3.1 Host Controller (rev a1)
01:00.3 Serial bus controller [0c80]: NVIDIA Corporation TU104 USB Type-C UCSI Controller (rev a1)

Here are 5 boots, 4 on 5.8.5:

dmesg.1_hang_but_no_warning.txt https://pastebin.com/Y5NaH08n
Boot hung for quite a while, but no clear output

dmesg.2_pme_spurious.txt https://pastebin.com/dX19aCpj
[    8.185808] nvidia-gpu 0000:01:00.3: runtime IRQ mapping not provided by arch
[    8.185989] nvidia-gpu 0000:01:00.3: enabling device (0000 -> 0002)
[    8.188986] nvidia-gpu 0000:01:00.3: enabling bus mastering
[   11.936507] nvidia-gpu 0000:01:00.3: PME# enabled
[   11.975985] nvidia-gpu 0000:01:00.3: PME# disabled
[   11.976011] pcieport 0000:00:01.0: PME: Spurious native interrupt!

dmesg.3_usb_key_yanked.txt https://pastebin.com/m7QLnCZt
I yanked the USB key during boot, that seemed to help unlock things with
5.7, but did not with 5.8. It's hung on a loop of:
[   11.262854] nvidia-gpu 0000:01:00.3: saving config space at offset 0x0 (reading 0x1ad910de)
[   11.262863] nvidia-gpu 0000:01:00.3: saving config space at offset 0x4 (reading 0x100406)
[   11.262869] nvidia-gpu 0000:01:00.3: saving config space at offset 0x8 (reading 0xc8000a1)
[   11.262874] nvidia-gpu 0000:01:00.3: saving config space at offset 0xc (reading 0x800000)
[   11.262880] nvidia-gpu 0000:01:00.3: saving config space at offset 0x10 (reading 0xce054000)
[   11.262885] nvidia-gpu 0000:01:00.3: saving config space at offset 0x14 (reading 0x0)
[   11.262890] nvidia-gpu 0000:01:00.3: saving config space at offset 0x18 (reading 0x0)
[   11.262895] nvidia-gpu 0000:01:00.3: saving config space at offset 0x1c (reading 0x0)
[   11.262900] nvidia-gpu 0000:01:00.3: saving config space at offset 0x20 (reading 0x0)
[   11.262906] nvidia-gpu 0000:01:00.3: saving config space at offset 0x24 (reading 0x0)
[   11.262911] nvidia-gpu 0000:01:00.3: saving config space at offset 0x28 (reading 0x0)
[   11.262916] nvidia-gpu 0000:01:00.3: saving config space at offset 0x2c (reading 0x229b17aa)
[   11.262921] nvidia-gpu 0000:01:00.3: saving config space at offset 0x30 (reading 0x0)
[   11.262926] nvidia-gpu 0000:01:00.3: saving config space at offset 0x34 (reading 0x68)
[   11.262931] nvidia-gpu 0000:01:00.3: saving config space at offset 0x38 (reading 0x0)
[   11.262937] nvidia-gpu 0000:01:00.3: saving config space at offset 0x3c (reading 0x4ff)
[   11.262985] nvidia-gpu 0000:01:00.3: PME# enabled
[   11.303060] nvidia-gpu 0000:01:00.3: PME# disabled

dmesg.4_5.5_boot_fine.txt https://pastebin.com/WXgQTUYP
reference boot with 4.5, it works fine, no issues

dmesg.5_no_key_still_hang.txt https://pastebin.com/kcT8Ras0
unfortunately, booting without the USB-C key in thunderbolt, did not
allow this boot to be faster, it looks different though:
[    6.723454] pcieport 0000:00:01.0: runtime IRQ mapping not provided by arch
[    6.723598] pcieport 0000:00:01.0: PME: Signaling with IRQ 122
[    6.724011] pcieport 0000:00:01.0: saving config space at offset 0x0 (reading 0x19018086)
[    6.724016] pcieport 0000:00:01.0: saving config space at offset 0x4 (reading 0x100407)
[    6.724021] pcieport 0000:00:01.0: saving config space at offset 0x8 (reading 0x604000d)
[    6.724025] pcieport 0000:00:01.0: saving config space at offset 0xc (reading 0x810000)
[    6.724029] pcieport 0000:00:01.0: saving config space at offset 0x10 (reading 0x0)
[    6.724033] pcieport 0000:00:01.0: saving config space at offset 0x14 (reading 0x0)
[    6.724037] pcieport 0000:00:01.0: saving config space at offset 0x18 (reading 0x10100)
[    6.724041] pcieport 0000:00:01.0: saving config space at offset 0x1c (reading 0x20002020)
[    6.724046] pcieport 0000:00:01.0: saving config space at offset 0x20 (reading 0xce00cd00)
[    6.724050] pcieport 0000:00:01.0: saving config space at offset 0x24 (reading 0xb1f1a001)
[    6.724054] pcieport 0000:00:01.0: saving config space at offset 0x28 (reading 0x0)
[    6.724058] pcieport 0000:00:01.0: saving config space at offset 0x2c (reading 0x0)
[    6.724062] pcieport 0000:00:01.0: saving config space at offset 0x30 (reading 0x0)
[    6.724066] pcieport 0000:00:01.0: saving config space at offset 0x34 (reading 0x88)
[    6.724070] pcieport 0000:00:01.0: saving config space at offset 0x38 (reading 0x0)
[    6.724074] pcieport 0000:00:01.0: saving config space at offset 0x3c (reading 0x201ff)
[    6.724129] pcieport 0000:00:1b.0: runtime IRQ mapping not provided by arch
[    6.724650] pcieport 0000:00:1b.0: PME: Signaling with IRQ 123
[    6.725021] pcieport 0000:00:1b.0: saving config space at offset 0x0 (reading 0xa3408086)
[    6.725026] pcieport 0000:00:1b.0: saving config space at offset 0x4 (reading 0x100407)
[    6.725031] pcieport 0000:00:1b.0: saving config space at offset 0x8 (reading 0x60400f0)
[    6.725035] pcieport 0000:00:1b.0: saving config space at offset 0xc (reading 0x810000)
[    6.725040] pcieport 0000:00:1b.0: saving config space at offset 0x10 (reading 0x0)
[    6.725044] pcieport 0000:00:1b.0: saving config space at offset 0x14 (reading 0x0)
[    6.725049] pcieport 0000:00:1b.0: saving config space at offset 0x18 (reading 0x20200)
[    6.725053] pcieport 0000:00:1b.0: saving config space at offset 0x1c (reading 0x200000f0)
[    6.725058] pcieport 0000:00:1b.0: saving config space at offset 0x20 (reading 0xce30ce30)
[    6.725062] pcieport 0000:00:1b.0: saving config space at offset 0x24 (reading 0x1fff1)
[    6.725067] pcieport 0000:00:1b.0: saving config space at offset 0x28 (reading 0x0)
[    6.725071] pcieport 0000:00:1b.0: saving config space at offset 0x2c (reading 0x0)
[    6.725075] pcieport 0000:00:1b.0: saving config space at offset 0x30 (reading 0x0)
[    6.725080] pcieport 0000:00:1b.0: saving config space at offset 0x34 (reading 0x40)
[    6.725084] pcieport 0000:00:1b.0: saving config space at offset 0x38 (reading 0x0)
[    6.725089] pcieport 0000:00:1b.0: saving config space at offset 0x3c (reading 0x201ff)
[    6.725154] pcieport 0000:00:1c.0: runtime IRQ mapping not provided by arch
[    6.725284] pcieport 0000:00:1c.0: PME: Signaling with IRQ 124
[    6.725580] pcieport 0000:00:1c.0: pciehp: Slot #0 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
[    6.726086] pci_bus 0000:04: dev 00, created physical slot 0

Any idea what's going on?

Thanks,
Marc

On Sat, Aug 08, 2020 at 01:22:02PM -0700, Marc MERLIN wrote:
> On Fri, Oct 04, 2019 at 03:39:46PM +0300, Mika Westerberg wrote:
> > This is otherwise similar to pcie_wait_for_link() but allows passing
> > custom activation delay in milliseconds.
> > 
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > ---
> >  drivers/pci/pci.c | 21 ++++++++++++++++++---
> >  1 file changed, 18 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index e7982af9a5d8..bfd92e018925 100644
> 
> Hi Mika,
> 
> So, I have a thinkpad P73 with thunderbolt, and while I don't boot
> often, my last boots have been unreliable at best (was only able to boot
> 5.7 once, and 5.8 did not succeed either).
> 
> 5.6 was working for a while, but couldn't boot it either this morning,
> so I had to go back to 5.5. This does not mean 5.5 does not have the
> problem, just that it booted this morning, while 5.6 didn't when I
> tried.
> Once the kernel is booted, the problem does not seem to occur much, or
> at all.
> 
> Basically, I'm getting the same thing than this person with a P53 (which
> is a mostly identical lenovo thinkpad, to mine)
> kernel: pcieport 0000:00:01.0: PME: Spurious native interrupt!
> kernel: pcieport 0000:00:01.0: PME: Spurious native interrupt!
> kernel: pcieport 0000:00:01.0: PME: Spurious native interrupt!
> kernel: pcieport 0000:00:01.0: PME: Spurious native interrupt!
> kernel: pcieport 0000:00:01.0: PME: Spurious native interrupt!
> https://bbs.archlinux.org/viewtopic.php?id=250658
> 
> The kernel boots eventually, but it takes minutes, and everything is so
> super slow, that I just can't reasonably use the machine.
> 
> This shows similar issues with 5.3, 5.4.
> https://forum.proxmox.com/threads/pme-spurious-native-interrupt-kernel-meldungen.62850/
> 
> Another report here with 5.6:
> https://bugzilla.redhat.com/show_bug.cgi?id=1831899
> 
> My current kernel is running your patch above, and I haven't done a lot
> of research yet to confirm whether going back to a kernel before it was
> merged, fixes the problem. Unfortunately the problem is not consistent,
> so it makes things harder to test/debug, especially on my main laptop
> that I do all my work on :)
> 
> I noticed this older patch of yours:
> http://patchwork.ozlabs.org/project/linux-pci/patch/0113014581dbe2d1f938813f1783905bd81b79db.1560079442.git.lukas@wunner.de/
> This patch is not in my kernel, is it worth adding?
> 
> Can I get you more info to help debug this?
> 
> If that helps:
> sauron:/usr/src/linux-5.7.11-amd64-preempt-sysrq-20190816/drivers/pci# lspci
> 00:00.0 Host bridge: Intel Corporation Device 3e20 (rev 0d)
> 00:01.0 PCI bridge: Intel Corporation Xeon E3-1200 v5/E3-1500 v5/6th Gen Core Processor PCIe Controller (x16) (rev 0d)
> 00:02.0 VGA compatible controller: Intel Corporation UHD Graphics 630 (Mobile) (rev 02)
> 00:04.0 Signal processing controller: Intel Corporation Xeon E3-1200 v5/E3-1500 v5/6th Gen Core Processor Thermal Subsystem (rev 0d)
> 00:08.0 System peripheral: Intel Corporation Xeon E3-1200 v5/v6 / E3-1500 v5 / 6th/7th/8th Gen Core Processor Gaussian Mixture Model
> 00:12.0 Signal processing controller: Intel Corporation Cannon Lake PCH Thermal Controller (rev 10)
> 00:14.0 USB controller: Intel Corporation Cannon Lake PCH USB 3.1 xHCI Host Controller (rev 10)
> 00:14.2 RAM memory: Intel Corporation Cannon Lake PCH Shared SRAM (rev 10)
> 00:15.0 Serial bus controller [0c80]: Intel Corporation Cannon Lake PCH Serial IO I2C Controller #0 (rev 10)
> 00:15.1 Serial bus controller [0c80]: Intel Corporation Cannon Lake PCH Serial IO I2C Controller #1 (rev 10)
> 00:16.0 Communication controller: Intel Corporation Cannon Lake PCH HECI Controller (rev 10)
> 00:17.0 SATA controller: Intel Corporation Cannon Lake Mobile PCH SATA AHCI Controller (rev 10)
> 00:1b.0 PCI bridge: Intel Corporation Cannon Lake PCH PCI Express Root Port #17 (rev f0)
> 00:1c.0 PCI bridge: Intel Corporation Cannon Lake PCH PCI Express Root Port #1 (rev f0)
> 00:1c.5 PCI bridge: Intel Corporation Cannon Lake PCH PCI Express Root Port #6 (rev f0)
> 00:1c.7 PCI bridge: Intel Corporation Cannon Lake PCH PCI Express Root Port #8 (rev f0)
> 00:1e.0 Communication controller: Intel Corporation Cannon Lake PCH Serial IO UART Host Controller (rev 10)
> 00:1f.0 ISA bridge: Intel Corporation Cannon Lake LPC Controller (rev 10)
> 00:1f.3 Audio device: Intel Corporation Cannon Lake PCH cAVS (rev 10)
> 00:1f.4 SMBus: Intel Corporation Cannon Lake PCH SMBus Controller (rev 10)
> 00:1f.5 Serial bus controller [0c80]: Intel Corporation Cannon Lake PCH SPI Controller (rev 10)
> 00:1f.6 Ethernet controller: Intel Corporation Ethernet Connection (7) I219-LM (rev 10)
> 01:00.0 VGA compatible controller: NVIDIA Corporation TU104GLM [Quadro RTX 4000 Mobile / Max-Q] (rev a1)
> 01:00.1 Audio device: NVIDIA Corporation TU104 HD Audio Controller (rev a1)
> 01:00.2 USB controller: NVIDIA Corporation TU104 USB 3.1 Host Controller (rev a1)
> 01:00.3 Serial bus controller [0c80]: NVIDIA Corporation TU104 USB Type-C UCSI Controller (rev a1)
> 02:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe SSD Controller SM981/PM981/PM983
> 04:00.0 PCI bridge: Intel Corporation JHL7540 Thunderbolt 3 Bridge [Titan Ridge 4C 2018] (rev 06)
> 05:00.0 PCI bridge: Intel Corporation JHL7540 Thunderbolt 3 Bridge [Titan Ridge 4C 2018] (rev 06)
> 05:01.0 PCI bridge: Intel Corporation JHL7540 Thunderbolt 3 Bridge [Titan Ridge 4C 2018] (rev 06)
> 05:02.0 PCI bridge: Intel Corporation JHL7540 Thunderbolt 3 Bridge [Titan Ridge 4C 2018] (rev 06)
> 05:04.0 PCI bridge: Intel Corporation JHL7540 Thunderbolt 3 Bridge [Titan Ridge 4C 2018] (rev 06)
> 06:00.0 System peripheral: Intel Corporation JHL7540 Thunderbolt 3 NHI [Titan Ridge 4C 2018] (rev 06)
> 2c:00.0 USB controller: Intel Corporation JHL7540 Thunderbolt 3 USB Controller [Titan Ridge 4C 2018] (rev 06)
> 52:00.0 Network controller: Intel Corporation Wi-Fi 6 AX200 (rev 1a)
> 54:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd. RTS525A PCI Express Card Reader (rev 01)
> 
> 
> sauron:/usr/src/linux-5.7.11-amd64-preempt-sysrq-20190816/drivers/pci# lsusb -t
> /:  Bus 06.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/2p, 10000M
> /:  Bus 05.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/2p, 480M
> /:  Bus 04.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/4p, 10000M
> /:  Bus 03.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/2p, 480M
> /:  Bus 02.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/10p, 10000M
> /:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/16p, 480M
>     |__ Port 2: Dev 2, If 0, Class=Human Interface Device, Driver=usbhid, 12M
>     |__ Port 8: Dev 3, If 3, Class=Video, Driver=uvcvideo, 480M
>     |__ Port 8: Dev 3, If 1, Class=Video, Driver=uvcvideo, 480M
>     |__ Port 8: Dev 3, If 2, Class=Video, Driver=uvcvideo, 480M
>     |__ Port 8: Dev 3, If 0, Class=Video, Driver=uvcvideo, 480M
>     |__ Port 9: Dev 4, If 0, Class=Vendor Specific Class, Driver=, 12M
>     |__ Port 14: Dev 6, If 0, Class=Wireless, Driver=btusb, 12M
>     |__ Port 14: Dev 6, If 1, Class=Wireless, Driver=btusb, 12M
> 
> Thanks,
> Marc
> -- 
> "A mouse is a device used to point at the xterm you want to type in" - A.S.R.
>  
> Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08

-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
