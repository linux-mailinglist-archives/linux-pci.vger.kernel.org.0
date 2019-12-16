Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED0F7121F06
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2019 00:38:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbfLPXiD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Dec 2019 18:38:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:55014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726655AbfLPXiC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 16 Dec 2019 18:38:02 -0500
Received: from localhost (mobile-166-170-223-177.mycingular.net [166.170.223.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E35DB20CC7;
        Mon, 16 Dec 2019 23:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576539481;
        bh=s9gl0giOruLASVmdKMvYU7MYCgH5lhFyCFU+3l6IRFM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=sIlGVYc/KAYVV6PcMl1+gNr/oeEE6EL4q0+Grca1sm/nM7mOOMHr18GEsvkCAPpk9
         CRIGc8BQyNxx86U2FudDGygkK3IsHyhQEOKnKuDga8/4tuoz3LEknkuT+uFGHNfEvB
         9XY4tlygh0VIpyYdaHuHQQmNjO8XyKUrqbWKmBOk=
Date:   Mon, 16 Dec 2019 17:37:59 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Stefan Roese <sr@denx.de>
Cc:     linux-pci@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Sergey Miroshnichenko <s.miroshnichenko@yadro.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Keith Busch <kbusch@kernel.org>
Subject: Re: PCIe hotplug resource issues with PEX switch (NVMe disks) on AMD
 Epyc system
Message-ID: <20191216233759.GA249123@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4fc407f8-2a24-4a04-20fb-5d07d5c24be4@denx.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Keith]

On Fri, Dec 13, 2019 at 09:35:19AM +0100, Stefan Roese wrote:
> Hi!
> 
> I am facing an issue with PCIe-Hotplug on an AMD Epyc based system.
> Our system is equipped with an HBA for NVMe SSDs incl. PCIe switch
> (Supermicro AOC-SLG3-4E2P) [1] and we would like to be able to hotplug
> NVMe disks.

Your system has several host bridges.  The address space routed to
each host bridge is determined by firmware, and Linux has no support
for changing it.  Here's the space routed to the hierarchy containing
the NVMe devices:

  ACPI: PCI Root Bridge [S0D2] (domain 0000 [bus 40-5f])
  pci_bus 0000:40: root bus resource [mem 0xeb000000-0xeb5fffff window] 6MB
  pci_bus 0000:40: root bus resource [mem 0x7fc8000000-0xfcffffffff window] 501GB+
  pci_bus 0000:40: root bus resource [bus 40-5f]

Since you have several host bridges, using "pci=nocrs" is pretty much
guaranteed to fail if Linux changes any PCI address assignments.  It
makes Linux *ignore* the routing information from firmware, but it
doesn't *change* any of the routing.  That's why experiment (d) fails:
we assigned this space:

  pci 0000:44:00.0: BAR 0: assigned [mem 0xec000000-0xec003fff 64bit]

but according to the BIOS, the [mem 0xec000000-0xefffffff window] area
is routed to bus 00, not bus 40, so when we try to access that BAR, it
goes to bus 00 where nothing responds.

There are three devices on bus 40 that consume memory address space:

  40:03.1 Root Port to [bus 41-47]  [mem 0xeb400000-0xeb5fffff] 2MB
  40:07.1 Root Port to [bus 48]     [mem 0xeb200000-0xeb3fffff] 2MB
  40:08.1 Root Port to [bus 49]     [mem 0xeb000000-0xeb1fffff] 2MB

Bridges (including Root Ports and Switch Ports) consume memory address
space in 1MB chunks.  The devices on buses 48 and 49 need a little
over 1MB, so 40:07.1 and 40:08.1 need at least 2MB each.  There's only
6MB available, so that leaves 2MB for 40:03.1, which leads to the PLX
switch.

That 2MB of memory space is routed to the PLX Switch Upstream Port,
which has a BAR of its own that requires 256K, which leaves 1MB for it
to send to its Downstream Ports.

The Intel NVMe device only needs 16KB of memory space, but since the
Switch Port windows are a minimum of 1MB, only one port gets memory
space.

So with this configuration, I think you're stuck.  The only things I
can think of are:

  - Put the PLX switch in a different slot to see if BIOS will assign
    more space to it (the other host bridges have more space
    available).

  - Boot with all four PLX slots occupied by NVMe devices.  The BIOS
    may assign space to accommodate them all.  If it does, you should
    be able to hot-remove and add devices after boot.

  - Change Linux to use prefetchable space.  The Intel NVMe wants
    *non-prefetchable* space, but there's an implementation note in
    the spec (PCIe r5.0, sec 7.5.1.2.1) that says it should be safe to
    put it in prefetchable space in certain cases (entire path is
    PCIe, no PCI/PCI-X devices to peer-to-peer reads, host bridge does
    no byte merging, etc).  The main problem is that we don't have a
    good way to identify these cases.

> Currently, I'm testing with v5.5.0-rc1 and series [2] applied. Here
> a few tests and results that I did so far. All tests were done with
> one Intel NVMe SSD connected to one of the 4 NVMe ports of the HBA
> and the other 3 ports (currently) left unconnected:
> 
> a) Kernel Parameter "pci=pcie_bus_safe"
> The resources of the 3 unused PCIe slots of the PEX switch are not
> assigned in this test.
> 
> b) Kernel Parameter "pci=pcie_bus_safe,hpmemsize=0,hpiosize=0,hpmmiosize=1M,hpmmioprefsize=0"
> With this test I restricted the resources of the HP slots to the
> minimum. Still this results in unassigned resourced for the unused
> PCIe slots of the PEX switch.
> 
> c) Kernel Parameter "pci=realloc,pcie_bus_safe,hpmemsize=0,hpiosize=0,hpmmiosize=1M,hpmmioprefsize=0"
> Again, not all resources are assigned.
> 
> d) Kernel Parameter "pci=nocrs,realloc,pcie_bus_safe,hpmemsize=0,hpiosize=0,hpmmiosize=1M,hpmmioprefsize=0"
> Now all requested resources are available for the HP PCIe slots of the
> PEX switch. But the NVMe driver fails while probing. Debugging has
> shown, that reading from the BAR of the NVMe disk returns 0xffffffff.
> Also reading from the PLX PEX switch registers returns 0xfffffff in this
> case (this works of course without nocrs, when the BARs are mapped at
> a different address).
> 
> Does anybody have a clue on why the access to the PEX switch and / or
> the NVMe BAR does not work in the "nocrs" case? The BARs are located in
> the same window that is provided by the BIOS in the ACPI list (but is
> "ignored" in this case) [3].
>
> Or if it is possible to get the HP resource mapping done correctly without
> setting "nocrs" for our setup with the PCIe/NVMe switch?
>
> [1] https://www.supermicro.com/en/products/accessories/addon/AOC-SLG3-4E2P.php
> [2] https://lkml.org/lkml/2019/12/9/388
> [3]
> [    0.701932] acpi PNP0A08:00: host bridge window [io  0x0cf8-0x0cff] (ignored)
> [    0.701934] acpi PNP0A08:00: host bridge window [io  0x0000-0x02ff window] (ignored)
> [    0.701935] acpi PNP0A08:00: host bridge window [io  0x0300-0x03af window] (ignored)
> [    0.701936] acpi PNP0A08:00: host bridge window [io  0x03e0-0x0cf7 window] (ignored)
> [    0.701937] acpi PNP0A08:00: host bridge window [io  0x03b0-0x03df window] (ignored)
> [    0.701938] acpi PNP0A08:00: host bridge window [io  0x0d00-0x3fff window] (ignored)
> [    0.701939] acpi PNP0A08:00: host bridge window [mem 0x000a0000-0x000bffff window] (ignored)
> [    0.701939] acpi PNP0A08:00: host bridge window [mem 0x000c0000-0x000dffff window] (ignored)
> [    0.701940] acpi PNP0A08:00: host bridge window [mem 0xec000000-0xefffffff window] (ignored)
> [    0.701941] acpi PNP0A08:00: host bridge window [mem 0x182c8000000-0x1ffffffffff window] (ignored)
> ...
> 41:00.0 PCI bridge: PLX Technology, Inc. PEX 9733 33-lane, 9-port PCI Express Gen 3 (8.0 GT/s) Switch (rev b0) (prog-if 00 [Normal decode])
>         Flags: bus master, fast devsel, latency 0, IRQ 47, NUMA node 2
>         Memory at ec400000 (32-bit, non-prefetchable) [size=256K]
>         Bus: primary=41, secondary=42, subordinate=47, sec-latency=0
>         I/O behind bridge: None
>         Memory behind bridge: ec000000-ec3fffff [size=4M]
>         Prefetchable memory behind bridge: None
>         Capabilities: <access denied>
>         Kernel driver in use: pcieport
> epyc@epyc-Super-Server:~/stefan$ sudo ./memtool md 0xec400000+0x10
> ec400000: ffffffff ffffffff ffffffff ffffffff                ................
