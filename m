Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 719382E320A
	for <lists+linux-pci@lfdr.de>; Sun, 27 Dec 2020 18:04:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbgL0RDw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 27 Dec 2020 12:03:52 -0500
Received: from magic.merlins.org ([209.81.13.136]:50010 "EHLO
        mail1.merlins.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbgL0RDv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 27 Dec 2020 12:03:51 -0500
X-Greylist: delayed 1027 seconds by postgrey-1.27 at vger.kernel.org; Sun, 27 Dec 2020 12:03:51 EST
Received: from aaubervilliers-653-1-146-240.w86-218.abo.wanadoo.fr ([86.218.37.240]:57112 helo=sauron.svh.merlins.org)
        by mail1.merlins.org with esmtpsa 
        (Cipher TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92 #3)
        id 1ktZBB-0003a3-I0 by authid <merlins.org> with srv_auth_plain; Sun, 27 Dec 2020 08:46:01 -0800
Received: from merlin by sauron.svh.merlins.org with local (Exim 4.92)
        (envelope-from <marc_nouveau@merlins.org>)
        id 1kt7UX-0001P1-Er; Sat, 26 Dec 2020 03:12:09 -0800
Date:   Sat, 26 Dec 2020 03:12:09 -0800
From:   Marc MERLIN <marc_nouveau@merlins.org>
To:     nouveau@lists.freedesktop.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>
Subject: 5.9.11 still hanging 2mn at each boot and looping on nvidia-gpu
 0000:01:00.3: PME# enabled (Quadro RTX 4000 Mobile)
Message-ID: <20201226111209.GA2498@merlins.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200908002935.GD20064@merlins.org>
 <20200529180315.GA18804@merlins.org>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
X-SA-Exim-Connect-IP: 86.218.37.240
X-SA-Exim-Mail-From: marc_nouveau@merlins.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This started with 5.5 and hasn't gotten better since then, despite some reports
I tried to send.

As per my previous message:
I have a Thinkpad P70 with hybrid graphics.
01:00.0 VGA compatible controller: NVIDIA Corporation GM107GLM [Quadro M600M] (rev a2)
that one works fine, I can use i915 for the main screen, and nouveau to
display on the external ports (external ports are only wired to nvidia
chip, so it's impossible to use them without turning the nvidia chip
on).
 
I now got a newer P73 also with the same hybrid graphics (setup as such
in the bios). It runs fine with i915, and I don't need to use external
display with nouveau for now (it almost works, but I only see the mouse
cursor on the external screen, no window or anything else can get
displayed, very weird).
01:00.0 VGA compatible controller: NVIDIA Corporation TU104GLM [Quadro RTX 4000 Mobile / Max-Q] (rev a1)
 

after boot, when it gets the right trigger (not sure which ones), it
loops on this evern 2 seconds, mostly forever.

I'm not sure if it's nouveau's fault or the kernel's PCI PME's fault, or something else.

Boot hangs look like this:
[   10.659209] Console: switching to colour frame buffer device 240x67
[   10.732353] i915 0000:00:02.0: [drm] fb0: i915drmfb frame buffer device
[   12.101203] nvidia-gpu 0000:01:00.3: saving config space at offset 0x0 (reading 0x1ad910de)
[   12.101212] nvidia-gpu 0000:01:00.3: saving config space at offset 0x4 (reading 0x100406)
[   12.101217] nvidia-gpu 0000:01:00.3: saving config space at offset 0x8 (reading 0xc8000a1)
[   12.101223] nvidia-gpu 0000:01:00.3: saving config space at offset 0xc (reading 0x800000)
[   12.101228] nvidia-gpu 0000:01:00.3: saving config space at offset 0x10 (reading 0xce054000)
[   12.101234] nvidia-gpu 0000:01:00.3: saving config space at offset 0x14 (reading 0x0)
[   12.101239] nvidia-gpu 0000:01:00.3: saving config space at offset 0x18 (reading 0x0)
[   12.101244] nvidia-gpu 0000:01:00.3: saving config space at offset 0x1c (reading 0x0)
[   12.101249] nvidia-gpu 0000:01:00.3: saving config space at offset 0x20 (reading 0x0)
[   12.101254] nvidia-gpu 0000:01:00.3: saving config space at offset 0x24 (reading 0x0)
[   12.101259] nvidia-gpu 0000:01:00.3: saving config space at offset 0x28 (reading 0x0)
[   12.101265] nvidia-gpu 0000:01:00.3: saving config space at offset 0x2c (reading 0x229b17aa)
[   12.101270] nvidia-gpu 0000:01:00.3: saving config space at offset 0x30 (reading 0x0)
[   12.101275] nvidia-gpu 0000:01:00.3: saving config space at offset 0x34 (reading 0x68)
[   12.101280] nvidia-gpu 0000:01:00.3: saving config space at offset 0x38 (reading 0x0)
[   12.101285] nvidia-gpu 0000:01:00.3: saving config space at offset 0x3c (reading 0x4ff)
[   12.101333] nvidia-gpu 0000:01:00.3: PME# enabled
[   25.151246] thunderbolt 0000:06:00.0: saving config space at offset 0x0 (reading 0x15eb8086)
[   25.151260] thunderbolt 0000:06:00.0: saving config space at offset 0x4 (reading 0x100406)
[   25.151265] thunderbolt 0000:06:00.0: saving config space at offset 0x8 (reading 0x8800006)
[   25.151270] thunderbolt 0000:06:00.0: saving config space at offset 0xc (reading 0x20)
[   25.151276] thunderbolt 0000:06:00.0: saving config space at offset 0x10 (reading 0xcc100000)
[   25.151281] thunderbolt 0000:06:00.0: saving config space at offset 0x14 (reading 0xcc140000)
[   25.151286] thunderbolt 0000:06:00.0: saving config space at offset 0x18 (reading 0x0)
[   25.151291] thunderbolt 0000:06:00.0: saving config space at offset 0x1c (reading 0x0)
[   25.151296] thunderbolt 0000:06:00.0: saving config space at offset 0x20 (reading 0x0)
[   25.151301] thunderbolt 0000:06:00.0: saving config space at offset 0x24 (reading 0x0)
[   25.151306] thunderbolt 0000:06:00.0: saving config space at offset 0x28 (reading 0x0)
[   25.151311] thunderbolt 0000:06:00.0: saving config space at offset 0x2c (reading 0x229b17aa)
[   25.151316] thunderbolt 0000:06:00.0: saving config space at offset 0x30 (reading 0x0)
[   25.151322] thunderbolt 0000:06:00.0: saving config space at offset 0x34 (reading 0x80)
[   25.151327] thunderbolt 0000:06:00.0: saving config space at offset 0x38 (reading 0x0)
[   25.151332] thunderbolt 0000:06:00.0: saving config space at offset 0x3c (reading 0x1ff)
[   25.151416] thunderbolt 0000:06:00.0: PME# enabled
[   25.169204] pcieport 0000:05:00.0: saving config space at offset 0x0 (reading 0x15ea8086)
[   25.169214] pcieport 0000:05:00.0: saving config space at offset 0x4 (reading 0x100407)
[   25.169219] pcieport 0000:05:00.0: saving config space at offset 0x8 (reading 0x6040006)
[   25.169224] pcieport 0000:05:00.0: saving config space at offset 0xc (reading 0x10020)
[   25.169229] pcieport 0000:05:00.0: saving config space at offset 0x10 (reading 0x0)
[   25.169233] pcieport 0000:05:00.0: saving config space at offset 0x14 (reading 0x0)
[   25.169238] pcieport 0000:05:00.0: saving config space at offset 0x18 (reading 0x60605)
[   25.169243] pcieport 0000:05:00.0: saving config space at offset 0x1c (reading 0x1f1)
[   25.169248] pcieport 0000:05:00.0: saving config space at offset 0x20 (reading 0xcc10cc10)
[   25.169253] pcieport 0000:05:00.0: saving config space at offset 0x24 (reading 0x1fff1)
[   25.169258] pcieport 0000:05:00.0: saving config space at offset 0x28 (reading 0x0)
[   25.169263] pcieport 0000:05:00.0: saving config space at offset 0x2c (reading 0x0)
[   25.169268] pcieport 0000:05:00.0: saving config space at offset 0x30 (reading 0x0)
[   25.169272] pcieport 0000:05:00.0: saving config space at offset 0x34 (reading 0x80)
[   25.169277] pcieport 0000:05:00.0: saving config space at offset 0x38 (reading 0x0)
[   25.169282] pcieport 0000:05:00.0: saving config space at offset 0x3c (reading 0x201ff)
[   25.169367] pcieport 0000:05:00.0: PME# enabled
[   25.189195] pcieport 0000:04:00.0: saving config space at offset 0x0 (reading 0x15ea8086)
[   25.189206] pcieport 0000:04:00.0: saving config space at offset 0x4 (reading 0x100007)
[   25.189212] pcieport 0000:04:00.0: saving config space at offset 0x8 (reading 0x6040006)
[   25.189216] pcieport 0000:04:00.0: saving config space at offset 0xc (reading 0x10020)
[   25.189221] pcieport 0000:04:00.0: saving config space at offset 0x10 (reading 0x0)
[   25.189226] pcieport 0000:04:00.0: saving config space at offset 0x14 (reading 0x0)
[   25.189231] pcieport 0000:04:00.0: saving config space at offset 0x18 (reading 0x510504)
[   25.189236] pcieport 0000:04:00.0: saving config space at offset 0x1c (reading 0x5141)
[   25.189241] pcieport 0000:04:00.0: saving config space at offset 0x20 (reading 0xcc10b400)
[   25.189246] pcieport 0000:04:00.0: saving config space at offset 0x24 (reading 0x3ff10001)
[   25.189251] pcieport 0000:04:00.0: saving config space at offset 0x28 (reading 0x60)
[   25.189255] pcieport 0000:04:00.0: saving config space at offset 0x2c (reading 0x60)
[   25.189260] pcieport 0000:04:00.0: saving config space at offset 0x30 (reading 0x0)
[   25.189265] pcieport 0000:04:00.0: saving config space at offset 0x34 (reading 0x80)
[   25.189270] pcieport 0000:04:00.0: saving config space at offset 0x38 (reading 0x0)
[   25.189274] pcieport 0000:04:00.0: saving config space at offset 0x3c (reading 0x201ff)
[   25.189358] pcieport 0000:04:00.0: PME# enabled
[   25.209257] pcieport 0000:00:1c.0: saving config space at offset 0x0 (reading 0xa3388086)
[   25.209271] pcieport 0000:00:1c.0: saving config space at offset 0x4 (reading 0x100407)
[   25.209279] pcieport 0000:00:1c.0: saving config space at offset 0x8 (reading 0x60400f0)
[   25.209287] pcieport 0000:00:1c.0: saving config space at offset 0xc (reading 0x810000)
[   25.209291] pcieport 0000:00:1c.0: saving config space at offset 0x10 (reading 0x0)
[   25.209299] pcieport 0000:00:1c.0: saving config space at offset 0x14 (reading 0x0)
[   25.209303] pcieport 0000:00:1c.0: saving config space at offset 0x18 (reading 0x510400)
[   25.209311] pcieport 0000:00:1c.0: saving config space at offset 0x1c (reading 0x20006040)
[   25.209324] pcieport 0000:00:1c.0: saving config space at offset 0x20 (reading 0xcc10b400)
[   25.209329] pcieport 0000:00:1c.0: saving config space at offset 0x24 (reading 0x3ff10001)
[   25.209333] pcieport 0000:00:1c.0: saving config space at offset 0x28 (reading 0x60)
[   25.209338] pcieport 0000:00:1c.0: saving config space at offset 0x2c (reading 0x60)
[   25.209342] pcieport 0000:00:1c.0: saving config space at offset 0x30 (reading 0x0)
[   25.209346] pcieport 0000:00:1c.0: saving config space at offset 0x34 (reading 0x40)
[   25.209351] pcieport 0000:00:1c.0: saving config space at offset 0x38 (reading 0x0)
[   25.209355] pcieport 0000:00:1c.0: saving config space at offset 0x3c (reading 0x201ff)
[   25.209447] pcieport 0000:00:1c.0: PME# enabled
[   26.341460] pcieport 0000:00:1c.0: power state changed by ACPI to D3cold
[  129.257560] async_tx: api initialized (async)
[  129.280335] device-mapper: uevent: version 1.0.3
[  129.280466] device-mapper: ioctl: 4.42.0-ioctl (2020-02-27) initialised: dm-devel@redhat.com
[  129.293087] random: cryptsetup: uninitialized urandom read (4 bytes read)
[  139.346041] random: cryptsetup: uninitialized urandom read (4 bytes read)
[  145.633300] e1000e 0000:00:1f.6 eth0: NIC Link is Down
[  149.384146] random: crng init done
[  161.435256] process '/usr/bin/fstype' started with executable stack
[  171.578236] BTRFS: device label btrfs_boot devid 1 transid 575473 /dev/mapper/cryptroot scanned by btrfs (1069)
[  171.583482] BTRFS: device label btrfs_pool4 devid 1 transid 117379 /dev/sdb4 scanned by btrfs (1069)
[  171.588979] BTRFS: device label btrfs_pool3 devid 1 transid 40487 /dev/sda5 scanned by btrfs (1069)
[  171.594484] BTRFS: device fsid de9694f8-9c0d-4e9d-bd12-57adc4381cd7 devid 1 transid 41 /dev/sda3 scanned by btrfs (1069)
[  171.600437] BTRFS: device fsid 23e1398d-e462-41aa-b85e-f574906ddc03 devid 1 transid 585 /dev/nvme0n1p4 scanned by btrfs (1069)
[  182.799968] PM: Image not found (code -22)
[  189.304662] nouveau 0000:01:00.0: pmu: firmware unavailable
[  189.312455] nouveau 0000:01:00.0: disp: destroy running...
[  189.316552] nouveau 0000:01:00.0: disp: destroy completed in 1us
[  189.320326] nouveau 0000:01:00.0: disp ctor failed, -12
[  189.324214] nouveau: probe of 0000:01:00.0 failed with error -12

At runtime, it later gets into a loop like this, and that murders
battery life if I'm not plugged in:
[2140771.370888] nvidia-gpu 0000:01:00.3: saving config space at offset 0x0 (reading 0x1ad910de)
[2140771.370895] nvidia-gpu 0000:01:00.3: saving config space at offset 0x4 (reading 0x100406)
[2140771.370899] nvidia-gpu 0000:01:00.3: saving config space at offset 0x8 (reading 0xc8000a1)
[2140771.370902] nvidia-gpu 0000:01:00.3: saving config space at offset 0xc (reading 0x800000)
[2140771.370905] nvidia-gpu 0000:01:00.3: saving config space at offset 0x10 (reading 0xce054000)
[2140771.370908] nvidia-gpu 0000:01:00.3: saving config space at offset 0x14 (reading 0x0)
[2140771.370912] nvidia-gpu 0000:01:00.3: saving config space at offset 0x18 (reading 0x0)
[2140771.370915] nvidia-gpu 0000:01:00.3: saving config space at offset 0x1c (reading 0x0)
[2140771.370918] nvidia-gpu 0000:01:00.3: saving config space at offset 0x20 (reading 0x0)
[2140771.370921] nvidia-gpu 0000:01:00.3: saving config space at offset 0x24 (reading 0x0)
[2140771.370924] nvidia-gpu 0000:01:00.3: saving config space at offset 0x28 (reading 0x0)
[2140771.370927] nvidia-gpu 0000:01:00.3: saving config space at offset 0x2c (reading 0x229b17aa)
[2140771.370930] nvidia-gpu 0000:01:00.3: saving config space at offset 0x30 (reading 0x0)
[2140771.370933] nvidia-gpu 0000:01:00.3: saving config space at offset 0x34 (reading 0x68)
[2140771.370936] nvidia-gpu 0000:01:00.3: saving config space at offset 0x38 (reading 0x0)
[2140771.370939] nvidia-gpu 0000:01:00.3: saving config space at offset 0x3c (reading 0x4ff)
[2140771.370970] nvidia-gpu 0000:01:00.3: PME# enabled
[2140771.389882] pci 0000:01:00.0: saving config space at offset 0x0 (reading 0x1eb610de)
[2140771.389891] pci 0000:01:00.0: saving config space at offset 0x4 (reading 0x100403)
[2140771.389896] pci 0000:01:00.0: saving config space at offset 0x8 (reading 0x30000a1)
[2140771.389899] pci 0000:01:00.0: saving config space at offset 0xc (reading 0x800000)
[2140771.389903] pci 0000:01:00.0: saving config space at offset 0x10 (reading 0xcd000000)
[2140771.389907] pci 0000:01:00.0: saving config space at offset 0x14 (reading 0xa000000c)
[2140771.389910] pci 0000:01:00.0: saving config space at offset 0x18 (reading 0x0)
[2140771.389914] pci 0000:01:00.0: saving config space at offset 0x1c (reading 0xb000000c)
[2140771.389918] pci 0000:01:00.0: saving config space at offset 0x20 (reading 0x0)
[2140771.389922] pci 0000:01:00.0: saving config space at offset 0x24 (reading 0x2001)
[2140771.389925] pci 0000:01:00.0: saving config space at offset 0x28 (reading 0x0)
[2140771.389928] pci 0000:01:00.0: saving config space at offset 0x2c (reading 0x229b17aa)
[2140771.389932] pci 0000:01:00.0: saving config space at offset 0x30 (reading 0xfff80000)
[2140771.389935] pci 0000:01:00.0: saving config space at offset 0x34 (reading 0x60)
[2140771.389939] pci 0000:01:00.0: saving config space at offset 0x38 (reading 0x0)
[2140771.389943] pci 0000:01:00.0: saving config space at offset 0x3c (reading 0x1ff)
[2140771.390027] pcieport 0000:00:01.0: saving config space at offset 0x0 (reading 0x19018086)
[2140771.390030] pcieport 0000:00:01.0: saving config space at offset 0x4 (reading 0x100407)
[2140771.390033] pcieport 0000:00:01.0: saving config space at offset 0x8 (reading 0x604000d)
[2140771.390036] pcieport 0000:00:01.0: saving config space at offset 0xc (reading 0x810000)
[2140771.390038] pcieport 0000:00:01.0: saving config space at offset 0x10 (reading 0x0)
[2140771.390041] pcieport 0000:00:01.0: saving config space at offset 0x14 (reading 0x0)
[2140771.390044] pcieport 0000:00:01.0: saving config space at offset 0x18 (reading 0x10100)
[2140771.390046] pcieport 0000:00:01.0: saving config space at offset 0x1c (reading 0x2020)
[2140771.390049] pcieport 0000:00:01.0: saving config space at offset 0x20 (reading 0xce00cd00)
[2140771.390051] pcieport 0000:00:01.0: saving config space at offset 0x24 (reading 0xb1f1a001)
[2140771.390054] pcieport 0000:00:01.0: saving config space at offset 0x28 (reading 0x0)
[2140771.390056] pcieport 0000:00:01.0: saving config space at offset 0x2c (reading 0x0)
[2140771.390059] pcieport 0000:00:01.0: saving config space at offset 0x30 (reading 0x0)
[2140771.390061] pcieport 0000:00:01.0: saving config space at offset 0x34 (reading 0x88)
[2140771.390064] pcieport 0000:00:01.0: saving config space at offset 0x38 (reading 0x0)
[2140771.390067] pcieport 0000:00:01.0: saving config space at offset 0x3c (reading 0x201ff)
[2140771.390125] pcieport 0000:00:01.0: PME# enabled

Thanks for any help
Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
