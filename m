Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA2A811DF9F
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2019 09:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725945AbfLMIms (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Dec 2019 03:42:48 -0500
Received: from mx2.mailbox.org ([80.241.60.215]:19227 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725928AbfLMImr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 13 Dec 2019 03:42:47 -0500
X-Greylist: delayed 437 seconds by postgrey-1.27 at vger.kernel.org; Fri, 13 Dec 2019 03:42:47 EST
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id D252AA38D5;
        Fri, 13 Dec 2019 09:35:28 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter05.heinlein-hosting.de (spamfilter05.heinlein-hosting.de [80.241.56.123]) (amavisd-new, port 10030)
        with ESMTP id cLyfdgu-vYIO; Fri, 13 Dec 2019 09:35:21 +0100 (CET)
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Sergey Miroshnichenko <s.miroshnichenko@yadro.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
From:   Stefan Roese <sr@denx.de>
Subject: PCIe hotplug resource issues with PEX switch (NVMe disks) on AMD Epyc
 system
Message-ID: <4fc407f8-2a24-4a04-20fb-5d07d5c24be4@denx.de>
Date:   Fri, 13 Dec 2019 09:35:19 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi!

I am facing an issue with PCIe-Hotplug on an AMD Epyc based system.
Our system is equipped with an HBA for NVMe SSDs incl. PCIe switch
(Supermicro AOC-SLG3-4E2P) [1] and we would like to be able to hotplug
NVMe disks.

Currently, I'm testing with v5.5.0-rc1 and series [2] applied. Here
a few tests and results that I did so far. All tests were done with
one Intel NVMe SSD connected to one of the 4 NVMe ports of the HBA
and the other 3 ports (currently) left unconnected:

a) Kernel Parameter "pci=pcie_bus_safe"
The resources of the 3 unused PCIe slots of the PEX switch are not
assigned in this test.

b) Kernel Parameter "pci=pcie_bus_safe,hpmemsize=0,hpiosize=0,hpmmiosize=1M,hpmmioprefsize=0"
With this test I restricted the resources of the HP slots to the
minimum. Still this results in unassigned resourced for the unused
PCIe slots of the PEX switch.

c) Kernel Parameter "pci=realloc,pcie_bus_safe,hpmemsize=0,hpiosize=0,hpmmiosize=1M,hpmmioprefsize=0"
Again, not all resources are assigned.

d) Kernel Parameter "pci=nocrs,realloc,pcie_bus_safe,hpmemsize=0,hpiosize=0,hpmmiosize=1M,hpmmioprefsize=0"
Now all requested resources are available for the HP PCIe slots of the
PEX switch. But the NVMe driver fails while probing. Debugging has
shown, that reading from the BAR of the NVMe disk returns 0xffffffff.
Also reading from the PLX PEX switch registers returns 0xfffffff in this
case (this works of course without nocrs, when the BARs are mapped at
a different address).

Does anybody have a clue on why the access to the PEX switch and / or
the NVMe BAR does not work in the "nocrs" case? The BARs are located in
the same window that is provided by the BIOS in the ACPI list (but is
"ignored" in this case) [3].

Or if it is possible to get the HP resource mapping done correctly without
setting "nocrs" for our setup with the PCIe/NVMe switch?

I can provide all sorts of logs (dmegs, lspci etc) if needed - just let
me know.

Many thanks in advance,
Stefan

[1] https://www.supermicro.com/en/products/accessories/addon/AOC-SLG3-4E2P.php
[2] https://lkml.org/lkml/2019/12/9/388
[3]
[    0.701932] acpi PNP0A08:00: host bridge window [io  0x0cf8-0x0cff] (ignored)
[    0.701934] acpi PNP0A08:00: host bridge window [io  0x0000-0x02ff window] (ignored)
[    0.701935] acpi PNP0A08:00: host bridge window [io  0x0300-0x03af window] (ignored)
[    0.701936] acpi PNP0A08:00: host bridge window [io  0x03e0-0x0cf7 window] (ignored)
[    0.701937] acpi PNP0A08:00: host bridge window [io  0x03b0-0x03df window] (ignored)
[    0.701938] acpi PNP0A08:00: host bridge window [io  0x0d00-0x3fff window] (ignored)
[    0.701939] acpi PNP0A08:00: host bridge window [mem 0x000a0000-0x000bffff window] (ignored)
[    0.701939] acpi PNP0A08:00: host bridge window [mem 0x000c0000-0x000dffff window] (ignored)
[    0.701940] acpi PNP0A08:00: host bridge window [mem 0xec000000-0xefffffff window] (ignored)
[    0.701941] acpi PNP0A08:00: host bridge window [mem 0x182c8000000-0x1ffffffffff window] (ignored)
...
41:00.0 PCI bridge: PLX Technology, Inc. PEX 9733 33-lane, 9-port PCI Express Gen 3 (8.0 GT/s) Switch (rev b0) (prog-if 00 [Normal decode])
         Flags: bus master, fast devsel, latency 0, IRQ 47, NUMA node 2
         Memory at ec400000 (32-bit, non-prefetchable) [size=256K]
         Bus: primary=41, secondary=42, subordinate=47, sec-latency=0
         I/O behind bridge: None
         Memory behind bridge: ec000000-ec3fffff [size=4M]
         Prefetchable memory behind bridge: None
         Capabilities: <access denied>
         Kernel driver in use: pcieport
epyc@epyc-Super-Server:~/stefan$ sudo ./memtool md 0xec400000+0x10
ec400000: ffffffff ffffffff ffffffff ffffffff                ................
