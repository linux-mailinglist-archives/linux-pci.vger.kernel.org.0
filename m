Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB6E63211C
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 12:47:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbiKULrH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 06:47:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbiKULqz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 06:46:55 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0FE726C1
        for <linux-pci@vger.kernel.org>; Mon, 21 Nov 2022 03:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669031213; x=1700567213;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=K+TucEnOC4a+YL//KkmZgv0jgf05oC2OMeVlJa8zWD4=;
  b=kGaqdi1nuxKhI/yaMtMnNG3ui98tWFEOLZEW71TnqfW8Hwizqa/lLLDG
   PE7a6mTBL4A92zPcEFhszd+EeQEFtOeg3DZ//4D+ZY4PGjYkEPNGlT0Ki
   FwZcfKvh+2w6FoT8kjYO8fbDr6fA48RTr5W7OhMkv5Nbvx3J7aUxHq6E2
   JYuH478bXvHBI1pQDbruEQtQAJzvCSJzj+vaNgSQ8f7GRTQZ6WNM/fmGd
   BUn4pDoSu6F2IOtiTQ2dOHjqD9d7J2XxsT6tmd+PETCTc5bdezgeBVDoH
   aWzh6blRxL+g6Ws32/RjQmX4g5HpFKpe4tQD/fKfUkB0/23mtdwwMI211
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10537"; a="314685958"
X-IronPort-AV: E=Sophos;i="5.96,181,1665471600"; 
   d="scan'208";a="314685958"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2022 03:46:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10537"; a="746874526"
X-IronPort-AV: E=Sophos;i="5.96,181,1665471600"; 
   d="scan'208";a="746874526"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 21 Nov 2022 03:46:51 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 94D2C10E; Mon, 21 Nov 2022 13:47:16 +0200 (EET)
Date:   Mon, 21 Nov 2022 13:47:16 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lukas Wunner <lukas@wunner.de>,
        Chris Chiu <chris.chiu@canonical.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 1/2] PCI: Take multifunction devices into account when
 distributing resources
Message-ID: <Y3tlRIG99P/amO9Q@black.fi.intel.com>
References: <Y3dI6K8o+j1nE4Lf@black.fi.intel.com>
 <20221118122951.GA1263043@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221118122951.GA1263043@bhelgaas>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Fri, Nov 18, 2022 at 06:29:51AM -0600, Bjorn Helgaas wrote:
> Hi Mika,
> 
> On Fri, Nov 18, 2022 at 10:57:12AM +0200, Mika Westerberg wrote:
> > On Thu, Nov 17, 2022 at 05:10:34PM -0600, Bjorn Helgaas wrote:
> > > On Mon, Nov 14, 2022 at 01:59:52PM +0200, Mika Westerberg wrote:
> > > > PCIe switch upstream port may be one of the functions of a multifunction
> > > > device.
> > > 
> > > I don't think this is specific to PCIe, is it?  Can't we have a
> > > multi-function device where one function is a conventional PCI bridge?
> > > Actually, I don't think "multi-function" is relevant at all -- you
> > > iterate over all the devices on the bus below.  For PCIe, that likely
> > > means multiple functions of the same device, but it could be separate
> > > devices in conventional PCI.
> > 
> > Yes it can be but I was trying to explain the problem we encountered and
> > that's related to PCIe.
> > 
> > I can leave this out if you think it is better that way.
> 
> Not necessarily, I'm just hoping this change is generic enough for all
> PCI and PCIe topologies.

Okay maybe I'll just drop the "multi-function" part of it?

> > > > The resource distribution code does not take this into account
> > > > properly and therefore it expands the upstream port resource windows too
> > > > much, not leaving space for the other functions (in the multifunction
> > > > device)
> > > 
> > > I guess the window expansion here is done by adjust_bridge_window()?
> > 
> > Yes but the resources are distributed in
> > pci_bus_distribute_available_resources().
> 
> Yep, sounds good, I was just confirming my understanding of the code.
> The main point of this patch is to *reduce* the size of the windows to
> leave room for peers of the bridge, so I had to look a bit to figure
> out where they got expanded.

Understood :)

> > > >  	if (hotplug_bridges + normal_bridges == 1) {
> > > > -		dev = list_first_entry(&bus->devices, struct pci_dev, bus_list);
> > > > -		if (dev->subordinate)
> > > > -			pci_bus_distribute_available_resources(dev->subordinate,
> > > > -				add_list, io, mmio, mmio_pref);
> > > > +		/* Upstream port must be the first */
> > > > +		bridge = list_first_entry(&bus->devices, struct pci_dev, bus_list);
> > > > +		if (!bridge->subordinate)
> > > > +			return;
> > > > +
> > > > +		/*
> > > > +		 * It is possible to have switch upstream port as a part of a
> > > > +		 * multifunction device. For this reason reduce the space
> > > > +		 * available for distribution by the amount required by the
> > > > +		 * peers of the upstream port.
> > > > +		 */
> > > > +		list_for_each_entry(dev, &bus->devices, bus_list) {
> > > 
> > > It seems like maybe we ought to do this regardless of how many bridges
> > > there are on the bus.  Don't we always want to assign space to devices
> > > on this bus before distributing the leftovers to downstream buses?
> > 
> > Yes we do.
> > 
> > > E.g., maybe this should be done before the adjust_bridge_window()
> > > calls?
> > 
> > With the current code it is clear that we deal with the upstream port.
> > At least in PCIe it is not allowed to have anything else than downstream
> > ports on that internal bus so the only case we would need to do this is
> > the switch upstream port.
> > 
> > Let me know if you still want me to move this before adjust_bridge_window()
> > I can do that in v3. Probably needs a comment too.
> 
> Hmm, I don't know exactly how to do this, but I don't think this code
> should be PCIe-specific, which I think means it shouldn't depend on
> how many bridges are on the bus.
> 
> I guess the existing assumption that a bridge must be the first device
> on the bus is a hidden assumption that this is PCIe.  That might be a
> mistake from the past.
> 
> I haven't tried it, but I wonder if we could reproduce the same
> problem in a conventional PCI topology with qemu.

I'm not an expert in QEMU but I think I was able to create such topology
with the following command line (parts copied from Jonathan's):

qemu-system-aarch64                                                             \
        -M virt,nvdimm=on,gic-version=3 -m 4g,maxmem=8G,slots=8 -cpu max -smp 4 \
        -bios /usr/share/qemu-efi-aarch64/QEMU_EFI.fd                           \
        -nographic -no-reboot                                                   \
        -kernel Image                          					\
        -initrd rootfs.cpio.bz2              					\
        -device pcie-pci-bridge,id=br1                                          \
        -device pci-bridge,chassis_nr=1,bus=br1,id=br2,shpc=on,addr=2           \
        -device e1000,bus=br1,addr=3                                            \
        -device e1000,bus=br1,addr=4                                            \
        -device e1000,bus=br2,addr=5

However, the problem does not reproduce with or without the patch. The
below is 'lspci -v' without this patch and 5632e2beaf9d5dda694c0572684dea783d8a9492 reverted:

00:02.0 PCI bridge: Red Hat, Inc. Device 000e (prog-if 00 [Normal decode])
        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 47
        Memory at 8000004000 (64-bit, non-prefetchable) [size=256]
        Bus: primary=00, secondary=01, subordinate=02, sec-latency=0
        I/O behind bridge: 1000-2fff [size=8K] [16-bit]
        Memory behind bridge: 10000000-102fffff [size=3M] [32-bit]
        Prefetchable memory behind bridge: [disabled] [64-bit]
        Capabilities: [8c] MSI: Enable- Count=1/1 Maskable+ 64bit+
        Capabilities: [84] Power Management version 3
        Capabilities: [48] Express PCI-Express to PCI/PCI-X Bridge, MSI 00
        Capabilities: [40] Hot-plug capable
        Capabilities: [100] Advanced Error Reporting

01:02.0 PCI bridge: Red Hat, Inc. QEMU PCI-PCI bridge (prog-if 00 [Normal decode])
        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 45
        Memory at 10240000 (64-bit, non-prefetchable) [size=256]
        Bus: primary=01, secondary=02, subordinate=02, sec-latency=0
        I/O behind bridge: 1000-1fff [size=4K] [16-bit]
        Memory behind bridge: 10000000-100fffff [size=1M] [32-bit]
        Prefetchable memory behind bridge: [disabled] [64-bit]
        Capabilities: [4c] MSI: Enable- Count=1/1 Maskable+ 64bit+
        Capabilities: [48] Slot ID: 0 slots, First+, chassis 01
        Capabilities: [40] Hot-plug capable

01:03.0 Ethernet controller: Intel Corporation 82540EM Gigabit Ethernet Controller (rev 03)
        Subsystem: Red Hat, Inc. QEMU Virtual Machine
        Flags: bus master, fast devsel, latency 0, IRQ 46
        Memory at 10200000 (32-bit, non-prefetchable) [size=128K]
        I/O ports at 2000 [size=64]
        Expansion ROM at 10100000 [disabled] [size=512K]
        Kernel driver in use: e1000

01:04.0 Ethernet controller: Intel Corporation 82540EM Gigabit Ethernet Controller (rev 03)
        Subsystem: Red Hat, Inc. QEMU Virtual Machine
        Flags: bus master, fast devsel, latency 0, IRQ 47
        Memory at 10220000 (32-bit, non-prefetchable) [size=128K]
        I/O ports at 2040 [size=64]
        Expansion ROM at 10180000 [disabled] [size=512K]
        Kernel driver in use: e1000

02:05.0 Ethernet controller: Intel Corporation 82540EM Gigabit Ethernet Controller (rev 03)
        Subsystem: Red Hat, Inc. QEMU Virtual Machine
        Flags: bus master, fast devsel, latency 0, IRQ 46
        Memory at 10080000 (32-bit, non-prefetchable) [size=128K]
        I/O ports at 1000 [size=64]
        Expansion ROM at 10000000 [disabled] [size=512K]
        Kernel driver in use: e1000

And with this patch (5632e2beaf9d5dda694c0572684dea783d8a9492 still reverted):

00:02.0 PCI bridge: Red Hat, Inc. Device 000e (prog-if 00 [Normal decode])
        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 47
        Memory at 8000004000 (64-bit, non-prefetchable) [size=256]
        Bus: primary=00, secondary=01, subordinate=02, sec-latency=0
        I/O behind bridge: 1000-2fff [size=8K] [16-bit]
        Memory behind bridge: 10000000-102fffff [size=3M] [32-bit]
        Prefetchable memory behind bridge: [disabled] [64-bit]
        Capabilities: [8c] MSI: Enable- Count=1/1 Maskable+ 64bit+
        Capabilities: [84] Power Management version 3
        Capabilities: [48] Express PCI-Express to PCI/PCI-X Bridge, MSI 00
        Capabilities: [40] Hot-plug capable
        Capabilities: [100] Advanced Error Reporting

01:02.0 PCI bridge: Red Hat, Inc. QEMU PCI-PCI bridge (prog-if 00 [Normal decode])
        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 45
        Memory at 10240000 (64-bit, non-prefetchable) [size=256]
        Bus: primary=01, secondary=02, subordinate=02, sec-latency=0
        I/O behind bridge: 1000-1fff [size=4K] [16-bit]
        Memory behind bridge: 10000000-100fffff [size=1M] [32-bit]
        Prefetchable memory behind bridge: [disabled] [64-bit]
        Capabilities: [4c] MSI: Enable- Count=1/1 Maskable+ 64bit+
        Capabilities: [48] Slot ID: 0 slots, First+, chassis 01
        Capabilities: [40] Hot-plug capable

01:03.0 Ethernet controller: Intel Corporation 82540EM Gigabit Ethernet Controller (rev 03)
        Subsystem: Red Hat, Inc. QEMU Virtual Machine
        Flags: bus master, fast devsel, latency 0, IRQ 46
        Memory at 10200000 (32-bit, non-prefetchable) [size=128K]
        I/O ports at 2000 [size=64]
        Expansion ROM at 10100000 [disabled] [size=512K]
        Kernel driver in use: e1000

01:04.0 Ethernet controller: Intel Corporation 82540EM Gigabit Ethernet Controller (rev 03)
        Subsystem: Red Hat, Inc. QEMU Virtual Machine
        Flags: bus master, fast devsel, latency 0, IRQ 47
        Memory at 10220000 (32-bit, non-prefetchable) [size=128K]
        I/O ports at 2040 [size=64]
        Expansion ROM at 10180000 [disabled] [size=512K]
        Kernel driver in use: e1000

02:05.0 Ethernet controller: Intel Corporation 82540EM Gigabit Ethernet Controller (rev 03)
        Subsystem: Red Hat, Inc. QEMU Virtual Machine
        Flags: bus master, fast devsel, latency 0, IRQ 46
        Memory at 10080000 (32-bit, non-prefetchable) [size=128K]
        I/O ports at 1000 [size=64]
        Expansion ROM at 10000000 [disabled] [size=512K]
        Kernel driver in use: e1000
