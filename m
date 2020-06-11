Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 165C81F7055
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jun 2020 00:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbgFKWgZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Jun 2020 18:36:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:50192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726159AbgFKWgY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Jun 2020 18:36:24 -0400
Received: from localhost (mobile-166-170-222-206.mycingular.net [166.170.222.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64B44206D7;
        Thu, 11 Jun 2020 22:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591914981;
        bh=wg9qRiPfmJMZoKz+seOBTJDDyPJHYSqg+FX1DYtwGYM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=RPLDh6VzKQWsB3sRkdIfkLTZGsABKP8miWhvpsGUC1eeSNhT9lIWIo2OqRX6T83O1
         zXUIEqUUjYyLG10dVLzvYVidc6iEPKh0qbluTlLd6HI0TK6ptssTEDpUaMBtO2uWgo
         HnZ2XBV4qB04Ayg7VEBXBUQ+jwOf8bdMJgth2i7Q=
Date:   Thu, 11 Jun 2020 17:36:18 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Aya Levin <ayal@mellanox.com>
Cc:     Ding Tianhong <dingtianhong@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Tal Gilboa <talgi@mellanox.com>, linux-pci@vger.kernel.org
Subject: Re: Adding support for Relaxed ordering on a non-root device
Message-ID: <20200611223618.GA1615826@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <509c6d76-d143-f878-e5e1-dd6df2bd73c6@mellanox.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 08, 2020 at 03:44:04PM +0300, Aya Levin wrote:
> On 6/5/2020 10:08 PM, Bjorn Helgaas wrote:
> > On Thu, Jun 04, 2020 at 03:35:48PM +0300, Aya Levin wrote:
> > > Hi
> > > 
> > > I am writing to you regarding your commits titled:
> > > 1. a99b646afa8a PCI: Disable PCIe Relaxed Ordering if unsupported
> > > 2. 87e09cdec4da PCI: Disable Relaxed Ordering for some Intel processors
> > > 
> > > While adding support to relaxed ordering on Mellanox Ethernet driver I
> > > tried to avoid the Intel's bug with pcie_relaxed_ordering_enabled.
> > > Expecting this to return False on Haswell and Broadwell CPU. I run
> > > this API on: Intel(R) Xeon(R) CPU E5-2650 v3 @ 2.30GHz (I think it is
> > > a Haswell, right?) and the API returned True. What am I missing?
> > 
> > The quirk is based on Vendor/Device ID, which of course is a problem
> > as new devices are released.  What does "lspci -vn" show on your
> > system?
> Please see attached file (output too long)
> > 
> > > In addition, I saw your comment in pci_configure_relaxed_ordering
> > > (pasted below) the non-root ports are not handled since Peer-to-Peer
> > > DMA is another can of warms. Could you elaborate on the complexity?
> > > What is the effort to extend this to non-root ports?
> > 
> > There's some discussion about this here and in other parts of the same
> > thread:
> > 
> >    https://lore.kernel.org/linux-arm-kernel/20170809032503.GB7191@bhelgaas-glaptop.roam.corp.google.com/
> Thanks,
> So I am on the right path just with unexpected return value.

I'm not sure what you mean.  Do you need anything more from me, or is
everything now working as you expect?

> > > ---------------------------------------------------------------------
> > > static void pci_configure_relaxed_ordering(struct pci_dev *dev)
> > > {
> > > 	struct pci_dev *root;
> > > 
> > > 	/* PCI_EXP_DEVICE_RELAX_EN is RsvdP in VFs */
> > > 	if (dev->is_virtfn)
> > > 		return;
> > > 
> > > 	if (!pcie_relaxed_ordering_enabled(dev))
> > > 		return;
> > > 
> > > 	/*
> > > 	 * For now, we only deal with Relaxed Ordering issues with Root
> > > 	 * Ports. Peer-to-Peer DMA is another can of worms.
> > > 	 */
> > > 	root = pci_find_pcie_root_port(dev);
> > > 	if (!root)
> > > 		return;
> > > 
> > > 	if (root->dev_flags & PCI_DEV_FLAGS_NO_RELAXED_ORDERING) {
> > > 		pcie_capability_clear_word(dev, PCI_EXP_DEVCTL,
> > > 					   PCI_EXP_DEVCTL_RELAX_EN);
> > > 		pci_info(dev, "Relaxed Ordering disabled because the Root Port didn't support it\n");
> > > 	}
> > > }
> > > 
> > > 

> 00:00.0 0600: 8086:2f00 (rev 02)
> 	Subsystem: 8086:0000
> 	Flags: fast devsel
> 	Capabilities: [90] Express Root Port (Slot-), MSI 00
> 	Capabilities: [e0] Power Management version 3
> 	Capabilities: [100] Vendor Specific Information: ID=0002 Rev=0 Len=00c <?>
> 	Capabilities: [144] Vendor Specific Information: ID=0004 Rev=1 Len=03c <?>
> 	Capabilities: [1d0] Vendor Specific Information: ID=0003 Rev=1 Len=00a <?>
> 	Capabilities: [280] Vendor Specific Information: ID=0005 Rev=3 Len=018 <?>
> 	Capabilities: [300] Vendor Specific Information: ID=0008 Rev=0 Len=038 <?>
> 
> 00:01.0 0604: 8086:2f02 (rev 02) (prog-if 00 [Normal decode])
> 	Flags: bus master, fast devsel, latency 0
> 	Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
> 	I/O behind bridge: 00002000-00002fff
> 	Memory behind bridge: 93c00000-93dfffff
> 	Capabilities: [40] Subsystem: 8086:0000
> 	Capabilities: [60] MSI: Enable+ Count=1/2 Maskable+ 64bit-
> 	Capabilities: [90] Express Root Port (Slot-), MSI 00
> 	Capabilities: [e0] Power Management version 3
> 	Capabilities: [100] Vendor Specific Information: ID=0002 Rev=0 Len=00c <?>
> 	Capabilities: [110] Access Control Services
> 	Capabilities: [148] Advanced Error Reporting
> 	Capabilities: [1d0] Vendor Specific Information: ID=0003 Rev=1 Len=00a <?>
> 	Capabilities: [250] #19
> 	Capabilities: [280] Vendor Specific Information: ID=0005 Rev=3 Len=018 <?>
> 	Capabilities: [300] Vendor Specific Information: ID=0008 Rev=0 Len=038 <?>
> 	Kernel driver in use: pcieport
> 
> 00:02.0 0604: 8086:2f04 (rev 02) (prog-if 00 [Normal decode])
> 	Flags: bus master, fast devsel, latency 0
> 	Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
> 	Memory behind bridge: 93f00000-947fffff
> 	Prefetchable memory behind bridge: 0000000090000000-0000000091ffffff
> 	Capabilities: [40] Subsystem: 8086:0000
> 	Capabilities: [60] MSI: Enable+ Count=1/2 Maskable+ 64bit-
> 	Capabilities: [90] Express Root Port (Slot+), MSI 00
> 	Capabilities: [e0] Power Management version 3
> 	Capabilities: [100] Vendor Specific Information: ID=0002 Rev=0 Len=00c <?>
> 	Capabilities: [110] Access Control Services
> 	Capabilities: [148] Advanced Error Reporting
> 	Capabilities: [1d0] Vendor Specific Information: ID=0003 Rev=1 Len=00a <?>
> 	Capabilities: [250] #19
> 	Capabilities: [280] Vendor Specific Information: ID=0005 Rev=3 Len=018 <?>
> 	Capabilities: [300] Vendor Specific Information: ID=0008 Rev=0 Len=038 <?>
> 	Kernel driver in use: pcieport
> 
> 00:03.0 0604: 8086:2f08 (rev 02) (prog-if 00 [Normal decode])
> 	Flags: bus master, fast devsel, latency 0
> 	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
> 	Memory behind bridge: 94800000-948fffff
> 	Prefetchable memory behind bridge: 0000000093a00000-0000000093afffff
> 	Capabilities: [40] Subsystem: 8086:0000
> 	Capabilities: [60] MSI: Enable+ Count=1/2 Maskable+ 64bit-
> 	Capabilities: [90] Express Root Port (Slot-), MSI 00
> 	Capabilities: [e0] Power Management version 3
> 	Capabilities: [100] Vendor Specific Information: ID=0002 Rev=0 Len=00c <?>
> 	Capabilities: [110] Access Control Services
> 	Capabilities: [148] Advanced Error Reporting
> 	Capabilities: [1d0] Vendor Specific Information: ID=0003 Rev=1 Len=00a <?>
> 	Capabilities: [250] #19
> 	Capabilities: [280] Vendor Specific Information: ID=0005 Rev=3 Len=018 <?>
> 	Capabilities: [300] Vendor Specific Information: ID=0008 Rev=0 Len=038 <?>
> 	Kernel driver in use: pcieport
> 
> 00:03.1 0604: 8086:2f09 (rev 02) (prog-if 00 [Normal decode])
> 	Flags: bus master, fast devsel, latency 0
> 	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
> 	Memory behind bridge: 94900000-949fffff
> 	Prefetchable memory behind bridge: 0000000093b00000-0000000093bfffff
> 	Capabilities: [40] Subsystem: 8086:0000
> 	Capabilities: [60] MSI: Enable+ Count=1/2 Maskable+ 64bit-
> 	Capabilities: [90] Express Root Port (Slot-), MSI 00
> 	Capabilities: [e0] Power Management version 3
> 	Capabilities: [100] Vendor Specific Information: ID=0002 Rev=0 Len=00c <?>
> 	Capabilities: [110] Access Control Services
> 	Capabilities: [148] Advanced Error Reporting
> 	Capabilities: [1d0] Vendor Specific Information: ID=0003 Rev=1 Len=00a <?>
> 	Capabilities: [250] #19
> 	Capabilities: [280] Vendor Specific Information: ID=0005 Rev=3 Len=018 <?>
> 	Capabilities: [300] Vendor Specific Information: ID=0008 Rev=0 Len=038 <?>
> 	Kernel driver in use: pcieport
> 
> 00:03.2 0604: 8086:2f0a (rev 02) (prog-if 00 [Normal decode])
> 	Flags: bus master, fast devsel, latency 0
> 	Bus: primary=00, secondary=05, subordinate=05, sec-latency=0
> 	Memory behind bridge: 94a00000-95bfffff
> 	Prefetchable memory behind bridge: 0000033ffc000000-0000033fffffffff
> 	Capabilities: [40] Subsystem: 8086:0000
> 	Capabilities: [60] MSI: Enable+ Count=1/2 Maskable+ 64bit-
> 	Capabilities: [90] Express Root Port (Slot+), MSI 00
> 	Capabilities: [e0] Power Management version 3
> 	Capabilities: [100] Vendor Specific Information: ID=0002 Rev=0 Len=00c <?>
> 	Capabilities: [110] Access Control Services
> 	Capabilities: [148] Advanced Error Reporting
> 	Capabilities: [1d0] Vendor Specific Information: ID=0003 Rev=1 Len=00a <?>
> 	Capabilities: [250] #19
> 	Capabilities: [280] Vendor Specific Information: ID=0005 Rev=3 Len=018 <?>
> 	Capabilities: [300] Vendor Specific Information: ID=0008 Rev=0 Len=038 <?>
> 	Kernel driver in use: pcieport
> 
> 00:05.0 0880: 8086:2f28 (rev 02)
> 	Flags: fast devsel
> 	Capabilities: [40] Express Root Complex Integrated Endpoint, MSI 00
> 
> 00:05.1 0880: 8086:2f29 (rev 02)
> 	Flags: fast devsel
> 	Capabilities: [40] Express Root Complex Integrated Endpoint, MSI 00
> 	Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit+
> 	Capabilities: [100] Vendor Specific Information: ID=0006 Rev=1 Len=010 <?>
> 	Capabilities: [110] Vendor Specific Information: ID=0006 Rev=1 Len=010 <?>
> 	Capabilities: [120] Vendor Specific Information: ID=0006 Rev=1 Len=010 <?>
> 	Capabilities: [130] Vendor Specific Information: ID=0006 Rev=1 Len=010 <?>
> 
> 00:05.2 0880: 8086:2f2a (rev 02)
> 	Flags: fast devsel
> 	Capabilities: [40] Express Root Complex Integrated Endpoint, MSI 00
> 
> 00:05.4 0800: 8086:2f2c (rev 02) (prog-if 20 [IO(X)-APIC])
> 	Subsystem: 8086:0000
> 	Flags: bus master, fast devsel, latency 0
> 	Memory at 93e08000 (32-bit, non-prefetchable) [size=4K]
> 	Capabilities: [44] Express Root Complex Integrated Endpoint, MSI 00
> 	Capabilities: [e0] Power Management version 3
> 
> 00:05.6 1101: 8086:2f39 (rev 02)
> 	Flags: fast devsel
> 	Capabilities: [40] Express Root Complex Integrated Endpoint, MSI 00
> 	Kernel driver in use: hswep_uncore
> 
> 00:06.0 0880: 8086:2f10 (rev 02)
> 	Subsystem: 8086:0000
> 	Flags: fast devsel
> 	Capabilities: [40] Express Root Complex Integrated Endpoint, MSI 00
> 	Capabilities: [100] Vendor Specific Information: ID=0001 Rev=0 Len=0b8 <?>
> 
> 00:06.1 0880: 8086:2f11 (rev 02)
> 	Subsystem: 8086:0000
> 	Flags: fast devsel
> 	Capabilities: [40] Express Root Complex Integrated Endpoint, MSI 00
> 	Capabilities: [100] Vendor Specific Information: ID=0001 Rev=0 Len=0b8 <?>
> 
> 00:06.2 0880: 8086:2f12 (rev 02)
> 	Subsystem: 8086:0000
> 	Flags: fast devsel
> 	Capabilities: [40] Express Root Complex Integrated Endpoint, MSI 00
> 
> 00:06.3 0880: 8086:2f13 (rev 02)
> 	Subsystem: 8086:0000
> 	Flags: fast devsel
> 	Capabilities: [40] Express Root Complex Integrated Endpoint, MSI 00
> 	Capabilities: [100] Vendor Specific Information: ID=0001 Rev=0 Len=0b8 <?>
> 
> 00:06.4 0880: 8086:2f14 (rev 02)
> 	Subsystem: 8086:0000
> 	Flags: fast devsel
> 	Capabilities: [40] Express Root Complex Integrated Endpoint, MSI 00
> 
> 00:06.5 0880: 8086:2f15 (rev 02)
> 	Subsystem: 8086:0000
> 	Flags: fast devsel
> 	Capabilities: [40] Express Root Complex Integrated Endpoint, MSI 00
> 
> 00:06.6 0880: 8086:2f16 (rev 02)
> 	Subsystem: 8086:0000
> 	Flags: fast devsel
> 	Capabilities: [40] Express Root Complex Integrated Endpoint, MSI 00
> 
> 00:06.7 0880: 8086:2f17 (rev 02)
> 	Subsystem: 8086:0000
> 	Flags: fast devsel
> 	Capabilities: [40] Express Root Complex Integrated Endpoint, MSI 00
> 
> 00:07.0 0880: 8086:2f18 (rev 02)
> 	Subsystem: 8086:0000
> 	Flags: fast devsel
> 	Capabilities: [40] Express Root Complex Integrated Endpoint, MSI 00
> 	Capabilities: [100] Vendor Specific Information: ID=0001 Rev=0 Len=0b8 <?>
> 
> 00:07.1 0880: 8086:2f19 (rev 02)
> 	Subsystem: 8086:0000
> 	Flags: fast devsel
> 	Capabilities: [40] Express Root Complex Integrated Endpoint, MSI 00
> 
> 00:07.2 0880: 8086:2f1a (rev 02)
> 	Subsystem: 8086:0000
> 	Flags: fast devsel
> 	Capabilities: [40] Express Root Complex Integrated Endpoint, MSI 00
> 
> 00:07.3 0880: 8086:2f1b (rev 02)
> 	Subsystem: 8086:0000
> 	Flags: fast devsel
> 	Capabilities: [40] Express Root Complex Integrated Endpoint, MSI 00
> 
> 00:07.4 0880: 8086:2f1c (rev 02)
> 	Subsystem: 8086:0000
> 	Flags: fast devsel
> 	Capabilities: [40] Express Root Complex Integrated Endpoint, MSI 00
> 
> 00:11.0 ff00: 8086:8d7c (rev 05)
> 	Subsystem: 1028:0600
> 	Flags: bus master, fast devsel, latency 0
> 	Capabilities: [40] Express Root Complex Integrated Endpoint, MSI 00
> 	Capabilities: [80] Power Management version 3
> 
> 00:11.4 0106: 8086:8d62 (rev 05) (prog-if 01 [AHCI 1.0])
> 	Subsystem: 1028:0600
> 	Flags: bus master, 66MHz, medium devsel, latency 0, IRQ 80
> 	I/O ports at 3078 [size=8]
> 	I/O ports at 308c [size=4]
> 	I/O ports at 3070 [size=8]
> 	I/O ports at 3088 [size=4]
> 	I/O ports at 3040 [size=32]
> 	Memory at 93e02000 (32-bit, non-prefetchable) [size=2K]
> 	Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
> 	Capabilities: [70] Power Management version 3
> 	Capabilities: [a8] SATA HBA v1.0
> 	Kernel driver in use: ahci
> 
> 00:16.0 0780: 8086:8d3a (rev 05)
> 	Subsystem: 1028:0600
> 	Flags: bus master, fast devsel, latency 0, IRQ 255
> 	Memory at 93e07000 (64-bit, non-prefetchable) [size=16]
> 	Capabilities: [50] Power Management version 3
> 	Capabilities: [8c] MSI: Enable- Count=1/1 Maskable- 64bit+
> 
> 00:16.1 0780: 8086:8d3b (rev 05)
> 	Subsystem: 1028:0600
> 	Flags: bus master, fast devsel, latency 0, IRQ 255
> 	Memory at 93e06000 (64-bit, non-prefetchable) [size=16]
> 	Capabilities: [50] Power Management version 3
> 	Capabilities: [8c] MSI: Enable- Count=1/1 Maskable- 64bit+
> 
> 00:1a.0 0c03: 8086:8d2d (rev 05) (prog-if 20 [EHCI])
> 	Subsystem: 1028:0600
> 	Flags: bus master, medium devsel, latency 0, IRQ 18
> 	Memory at 93e04000 (32-bit, non-prefetchable) [size=1K]
> 	Capabilities: [50] Power Management version 2
> 	Capabilities: [58] Debug port: BAR=1 offset=00a0
> 	Capabilities: [98] PCI Advanced Features
> 	Kernel driver in use: ehci-pci
> 
> 00:1c.0 0604: 8086:8d10 (rev d5) (prog-if 00 [Normal decode])
> 	Flags: bus master, fast devsel, latency 0
> 	Bus: primary=00, secondary=06, subordinate=06, sec-latency=0
> 	Capabilities: [40] Express Root Port (Slot-), MSI 00
> 	Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
> 	Capabilities: [90] Subsystem: 1028:0600
> 	Capabilities: [a0] Power Management version 3
> 	Kernel driver in use: pcieport
> 
> 00:1c.7 0604: 8086:8d1e (rev d5) (prog-if 00 [Normal decode])
> 	Flags: bus master, fast devsel, latency 0
> 	Bus: primary=00, secondary=07, subordinate=0b, sec-latency=0
> 	Memory behind bridge: 93000000-939fffff
> 	Prefetchable memory behind bridge: 0000000092000000-0000000092ffffff
> 	Capabilities: [40] Express Root Port (Slot+), MSI 00
> 	Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
> 	Capabilities: [90] Subsystem: 1028:0600
> 	Capabilities: [a0] Power Management version 3
> 	Capabilities: [100] Advanced Error Reporting
> 	Kernel driver in use: pcieport
> 
> 00:1d.0 0c03: 8086:8d26 (rev 05) (prog-if 20 [EHCI])
> 	Subsystem: 1028:0600
> 	Flags: bus master, medium devsel, latency 0, IRQ 18
> 	Memory at 93e03000 (32-bit, non-prefetchable) [size=1K]
> 	Capabilities: [50] Power Management version 2
> 	Capabilities: [58] Debug port: BAR=1 offset=00a0
> 	Capabilities: [98] PCI Advanced Features
> 	Kernel driver in use: ehci-pci
> 
> 00:1f.0 0601: 8086:8d44 (rev 05)
> 	Subsystem: 1028:0600
> 	Flags: bus master, medium devsel, latency 0
> 	Capabilities: [e0] Vendor Specific Information: Len=0c <?>
> 	Kernel driver in use: lpc_ich
> 
> 00:1f.2 0106: 8086:8d02 (rev 05) (prog-if 01 [AHCI 1.0])
> 	Subsystem: 1028:0600
> 	Flags: bus master, 66MHz, medium devsel, latency 0, IRQ 81
> 	I/O ports at 3068 [size=8]
> 	I/O ports at 3084 [size=4]
> 	I/O ports at 3060 [size=8]
> 	I/O ports at 3080 [size=4]
> 	I/O ports at 3020 [size=32]
> 	Memory at 93e01000 (32-bit, non-prefetchable) [size=2K]
> 	Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
> 	Capabilities: [70] Power Management version 3
> 	Capabilities: [a8] SATA HBA v1.0
> 	Kernel driver in use: ahci
> 
> 01:00.0 0200: 14e4:165f
> 	Subsystem: 1028:1f5b
> 	Flags: bus master, fast devsel, latency 0, IRQ 82
> 	Memory at 93b30000 (64-bit, prefetchable) [size=64K]
> 	Memory at 93b40000 (64-bit, prefetchable) [size=64K]
> 	Memory at 93b50000 (64-bit, prefetchable) [size=64K]
> 	Expansion ROM at 94900000 [disabled] [size=256K]
> 	Capabilities: [48] Power Management version 3
> 	Capabilities: [50] Vital Product Data
> 	Capabilities: [58] MSI: Enable- Count=1/8 Maskable- 64bit+
> 	Capabilities: [a0] MSI-X: Enable+ Count=17 Masked-
> 	Capabilities: [ac] Express Endpoint, MSI 00
> 	Capabilities: [100] Advanced Error Reporting
> 	Capabilities: [13c] Device Serial Number 00-00-b0-83-fe-cf-d4-05
> 	Capabilities: [150] Power Budgeting <?>
> 	Capabilities: [160] Virtual Channel
> 	Kernel driver in use: tg3
> 
> 01:00.1 0200: 14e4:165f
> 	Subsystem: 1028:1f5b
> 	Flags: bus master, fast devsel, latency 0, IRQ 83
> 	Memory at 93b00000 (64-bit, prefetchable) [size=64K]
> 	Memory at 93b10000 (64-bit, prefetchable) [size=64K]
> 	Memory at 93b20000 (64-bit, prefetchable) [size=64K]
> 	Expansion ROM at 94940000 [disabled] [size=256K]
> 	Capabilities: [48] Power Management version 3
> 	Capabilities: [50] Vital Product Data
> 	Capabilities: [58] MSI: Enable- Count=1/8 Maskable- 64bit+
> 	Capabilities: [a0] MSI-X: Enable- Count=17 Masked-
> 	Capabilities: [ac] Express Endpoint, MSI 00
> 	Capabilities: [100] Advanced Error Reporting
> 	Capabilities: [13c] Device Serial Number 00-00-b0-83-fe-cf-d4-06
> 	Capabilities: [150] Power Budgeting <?>
> 	Capabilities: [160] Virtual Channel
> 	Kernel driver in use: tg3
> 
> 02:00.0 0200: 14e4:165f
> 	Subsystem: 1028:1f5b
> 	Flags: bus master, fast devsel, latency 0, IRQ 84
> 	Memory at 93a30000 (64-bit, prefetchable) [size=64K]
> 	Memory at 93a40000 (64-bit, prefetchable) [size=64K]
> 	Memory at 93a50000 (64-bit, prefetchable) [size=64K]
> 	Expansion ROM at 94800000 [disabled] [size=256K]
> 	Capabilities: [48] Power Management version 3
> 	Capabilities: [50] Vital Product Data
> 	Capabilities: [58] MSI: Enable- Count=1/8 Maskable- 64bit+
> 	Capabilities: [a0] MSI-X: Enable- Count=17 Masked-
> 	Capabilities: [ac] Express Endpoint, MSI 00
> 	Capabilities: [100] Advanced Error Reporting
> 	Capabilities: [13c] Device Serial Number 00-00-b0-83-fe-cf-d4-07
> 	Capabilities: [150] Power Budgeting <?>
> 	Capabilities: [160] Virtual Channel
> 	Kernel driver in use: tg3
> 
> 02:00.1 0200: 14e4:165f
> 	Subsystem: 1028:1f5b
> 	Flags: bus master, fast devsel, latency 0, IRQ 85
> 	Memory at 93a00000 (64-bit, prefetchable) [size=64K]
> 	Memory at 93a10000 (64-bit, prefetchable) [size=64K]
> 	Memory at 93a20000 (64-bit, prefetchable) [size=64K]
> 	Expansion ROM at 94840000 [disabled] [size=256K]
> 	Capabilities: [48] Power Management version 3
> 	Capabilities: [50] Vital Product Data
> 	Capabilities: [58] MSI: Enable- Count=1/8 Maskable- 64bit+
> 	Capabilities: [a0] MSI-X: Enable- Count=17 Masked-
> 	Capabilities: [ac] Express Endpoint, MSI 00
> 	Capabilities: [100] Advanced Error Reporting
> 	Capabilities: [13c] Device Serial Number 00-00-b0-83-fe-cf-d4-08
> 	Capabilities: [150] Power Budgeting <?>
> 	Capabilities: [160] Virtual Channel
> 	Kernel driver in use: tg3
> 
> 03:00.0 0104: 1000:005d (rev 02)
> 	Subsystem: 1028:1f49
> 	Flags: bus master, fast devsel, latency 0, IRQ 37
> 	I/O ports at 2000 [size=256]
> 	Memory at 93d00000 (64-bit, non-prefetchable) [size=64K]
> 	Memory at 93c00000 (64-bit, non-prefetchable) [size=1M]
> 	Expansion ROM at <ignored> [disabled]
> 	Capabilities: [50] Power Management version 3
> 	Capabilities: [68] Express Endpoint, MSI 00
> 	Capabilities: [d0] Vital Product Data
> 	Capabilities: [a8] MSI: Enable- Count=1/1 Maskable+ 64bit+
> 	Capabilities: [c0] MSI-X: Enable+ Count=97 Masked-
> 	Capabilities: [100] Advanced Error Reporting
> 	Capabilities: [1e0] #19
> 	Capabilities: [1c0] Power Budgeting <?>
> 	Capabilities: [190] #16
> 	Capabilities: [148] Alternative Routing-ID Interpretation (ARI)
> 	Kernel driver in use: megaraid_sas
> 
> 04:00.0 0200: 15b3:101d
> 	Subsystem: 15b3:0047
> 	Flags: bus master, fast devsel, latency 0, IRQ 91
> 	Memory at 90000000 (64-bit, prefetchable) [size=32M]
> 	Expansion ROM at 93f00000 [disabled] [size=1M]
> 	Capabilities: [60] Express Endpoint, MSI 00
> 	Capabilities: [48] Vital Product Data
> 	Capabilities: [9c] MSI-X: Enable+ Count=64 Masked-
> 	Capabilities: [c0] Vendor Specific Information: Len=18 <?>
> 	Capabilities: [40] Power Management version 3
> 	Capabilities: [100] Advanced Error Reporting
> 	Capabilities: [150] Alternative Routing-ID Interpretation (ARI)
> 	Capabilities: [180] Single Root I/O Virtualization (SR-IOV)
> 	Capabilities: [1c0] #19
> 	Capabilities: [320] #27
> 	Capabilities: [370] #26
> 	Capabilities: [420] #25
> 	Kernel driver in use: mlx5_core
> 
> 05:00.0 0200: 15b3:1017
> 	Subsystem: 15b3:0020
> 	Flags: bus master, fast devsel, latency 0, IRQ 133
> 	Memory at 33ffe000000 (64-bit, prefetchable) [size=32M]
> 	Expansion ROM at 94a00000 [disabled] [size=1M]
> 	Capabilities: [60] Express Endpoint, MSI 00
> 	Capabilities: [48] Vital Product Data
> 	Capabilities: [9c] MSI-X: Enable+ Count=64 Masked-
> 	Capabilities: [c0] Vendor Specific Information: Len=18 <?>
> 	Capabilities: [40] Power Management version 3
> 	Capabilities: [100] Advanced Error Reporting
> 	Capabilities: [150] Alternative Routing-ID Interpretation (ARI)
> 	Capabilities: [180] Single Root I/O Virtualization (SR-IOV)
> 	Capabilities: [1c0] #19
> 	Capabilities: [230] Access Control Services
> 	Kernel driver in use: mlx5_core
> 
> 05:00.1 0200: 15b3:1017
> 	Subsystem: 15b3:0020
> 	Flags: bus master, fast devsel, latency 0, IRQ 83
> 	Memory at 33ffc000000 (64-bit, prefetchable) [size=32M]
> 	Expansion ROM at 95300000 [disabled] [size=1M]
> 	Capabilities: [60] Express Endpoint, MSI 00
> 	Capabilities: [48] Vital Product Data
> 	Capabilities: [9c] MSI-X: Enable+ Count=64 Masked-
> 	Capabilities: [c0] Vendor Specific Information: Len=18 <?>
> 	Capabilities: [40] Power Management version 3
> 	Capabilities: [100] Advanced Error Reporting
> 	Capabilities: [150] Alternative Routing-ID Interpretation (ARI)
> 	Capabilities: [180] Single Root I/O Virtualization (SR-IOV)
> 	Capabilities: [230] Access Control Services
> 	Kernel driver in use: mlx5_core
> 
> 07:00.0 0604: 1912:001d (prog-if 00 [Normal decode])
> 	Flags: bus master, fast devsel, latency 0
> 	BIST result: 00
> 	Bus: primary=07, secondary=08, subordinate=0b, sec-latency=0
> 	Memory behind bridge: 93000000-939fffff
> 	Prefetchable memory behind bridge: 0000000092000000-0000000092ffffff
> 	Capabilities: [40] Power Management version 3
> 	Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
> 	Capabilities: [70] Express Upstream Port, MSI 00
> 	Capabilities: [b0] Subsystem: 1912:001d
> 	Capabilities: [100] Advanced Error Reporting
> 	Kernel driver in use: pcieport
> 
> 08:00.0 0604: 1912:001d (prog-if 00 [Normal decode])
> 	Flags: bus master, fast devsel, latency 0
> 	BIST result: 00
> 	Bus: primary=08, secondary=09, subordinate=0a, sec-latency=0
> 	Memory behind bridge: 93000000-938fffff
> 	Prefetchable memory behind bridge: 0000000092000000-0000000092ffffff
> 	Capabilities: [40] Power Management version 3
> 	Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
> 	Capabilities: [70] Express Downstream Port (Slot-), MSI 00
> 	Capabilities: [b0] Subsystem: 1912:001d
> 	Capabilities: [100] Advanced Error Reporting
> 	Kernel driver in use: pcieport
> 
> 09:00.0 0604: 1912:001a (prog-if 00 [Normal decode])
> 	Flags: bus master, fast devsel, latency 0
> 	BIST result: 00
> 	Bus: primary=09, secondary=0a, subordinate=0a, sec-latency=0
> 	Memory behind bridge: 93000000-938fffff
> 	Prefetchable memory behind bridge: 0000000092000000-0000000092ffffff
> 	Capabilities: [40] Power Management version 3
> 	Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
> 	Capabilities: [70] Express PCI-Express to PCI/PCI-X Bridge, MSI 00
> 	Capabilities: [b0] Subsystem: 1912:001a
> 	Capabilities: [100] Advanced Error Reporting
> 
> 0a:00.0 0300: 102b:0534 (rev 01) (prog-if 00 [VGA controller])
> 	Subsystem: 1028:0600
> 	Flags: bus master, medium devsel, latency 0, IRQ 19
> 	Memory at 92000000 (32-bit, prefetchable) [size=16M]
> 	Memory at 93800000 (32-bit, non-prefetchable) [size=16K]
> 	Memory at 93000000 (32-bit, non-prefetchable) [size=8M]
> 	Expansion ROM at <unassigned> [disabled]
> 	Capabilities: [dc] Power Management version 1
> 	Kernel driver in use: mgag200
> 
> 7f:08.0 0880: 8086:2f80 (rev 02)
> 	Subsystem: 8086:2f80
> 	Flags: fast devsel
> 
> 7f:08.2 1101: 8086:2f32 (rev 02)
> 	Subsystem: 8086:2f32
> 	Flags: fast devsel
> 	Kernel driver in use: hswep_uncore
> 
> 7f:08.3 0880: 8086:2f83 (rev 02)
> 	Subsystem: 8086:2f83
> 	Flags: fast devsel
> 
> 7f:08.5 0880: 8086:2f85 (rev 02)
> 	Subsystem: 8086:2f85
> 	Flags: fast devsel
> 
> 7f:08.6 0880: 8086:2f86 (rev 02)
> 	Subsystem: 8086:2f86
> 	Flags: fast devsel
> 	Kernel driver in use: hswep_uncore
> 
> 7f:08.7 0880: 8086:2f87 (rev 02)
> 	Subsystem: 8086:2f87
> 	Flags: fast devsel
> 
> 7f:09.0 0880: 8086:2f90 (rev 02)
> 	Subsystem: 8086:2f90
> 	Flags: fast devsel
> 
> 7f:09.2 1101: 8086:2f33 (rev 02)
> 	Subsystem: 8086:2f33
> 	Flags: fast devsel
> 	Kernel driver in use: hswep_uncore
> 
> 7f:09.3 0880: 8086:2f93 (rev 02)
> 	Subsystem: 8086:2f93
> 	Flags: fast devsel
> 
> 7f:09.5 0880: 8086:2f95 (rev 02)
> 	Subsystem: 8086:2f95
> 	Flags: fast devsel
> 
> 7f:09.6 0880: 8086:2f96 (rev 02)
> 	Subsystem: 8086:2f96
> 	Flags: fast devsel
> 	Kernel driver in use: hswep_uncore
> 
> 7f:0b.0 0880: 8086:2f81 (rev 02)
> 	Subsystem: 8086:2f81
> 	Flags: fast devsel
> 
> 7f:0b.1 1101: 8086:2f36 (rev 02)
> 	Subsystem: 8086:2f36
> 	Flags: fast devsel
> 	Kernel driver in use: hswep_uncore
> 
> 7f:0b.2 1101: 8086:2f37 (rev 02)
> 	Subsystem: 8086:2f37
> 	Flags: fast devsel
> 	Kernel driver in use: hswep_uncore
> 
> 7f:0b.4 0880: 8086:2f41 (rev 02)
> 	Subsystem: 8086:2f41
> 	Flags: fast devsel
> 
> 7f:0b.5 1101: 8086:2f3e (rev 02)
> 	Subsystem: 8086:2f3e
> 	Flags: fast devsel
> 	Kernel driver in use: hswep_uncore
> 
> 7f:0b.6 1101: 8086:2f3f (rev 02)
> 	Subsystem: 8086:2f3f
> 	Flags: fast devsel
> 
> 7f:0c.0 0880: 8086:2fe0 (rev 02)
> 	Subsystem: 8086:2fe0
> 	Flags: fast devsel
> 
> 7f:0c.1 0880: 8086:2fe1 (rev 02)
> 	Subsystem: 8086:2fe1
> 	Flags: fast devsel
> 
> 7f:0c.2 0880: 8086:2fe2 (rev 02)
> 	Subsystem: 8086:2fe2
> 	Flags: fast devsel
> 
> 7f:0c.3 0880: 8086:2fe3 (rev 02)
> 	Subsystem: 8086:2fe3
> 	Flags: fast devsel
> 
> 7f:0c.4 0880: 8086:2fe4 (rev 02)
> 	Subsystem: 8086:2fe4
> 	Flags: fast devsel
> 
> 7f:0c.5 0880: 8086:2fe5 (rev 02)
> 	Subsystem: 8086:2fe5
> 	Flags: fast devsel
> 
> 7f:0c.6 0880: 8086:2fe6 (rev 02)
> 	Subsystem: 8086:2fe6
> 	Flags: fast devsel
> 
> 7f:0c.7 0880: 8086:2fe7 (rev 02)
> 	Subsystem: 8086:2fe7
> 	Flags: fast devsel
> 
> 7f:0d.0 0880: 8086:2fe8 (rev 02)
> 	Subsystem: 8086:2fe8
> 	Flags: fast devsel
> 
> 7f:0d.1 0880: 8086:2fe9 (rev 02)
> 	Subsystem: 8086:2fe9
> 	Flags: fast devsel
> 
> 7f:0f.0 0880: 8086:2ff8 (rev 02)
> 	Flags: fast devsel
> 
> 7f:0f.1 0880: 8086:2ff9 (rev 02)
> 	Flags: fast devsel
> 
> 7f:0f.2 0880: 8086:2ffa (rev 02)
> 	Flags: fast devsel
> 
> 7f:0f.3 0880: 8086:2ffb (rev 02)
> 	Flags: fast devsel
> 
> 7f:0f.4 0880: 8086:2ffc (rev 02)
> 	Subsystem: 8086:2fe0
> 	Flags: fast devsel
> 
> 7f:0f.5 0880: 8086:2ffd (rev 02)
> 	Subsystem: 8086:2fe0
> 	Flags: fast devsel
> 
> 7f:0f.6 0880: 8086:2ffe (rev 02)
> 	Subsystem: 8086:2fe0
> 	Flags: fast devsel
> 
> 7f:10.0 0880: 8086:2f1d (rev 02)
> 	Subsystem: 8086:2f1d
> 	Flags: fast devsel
> 
> 7f:10.1 1101: 8086:2f34 (rev 02)
> 	Subsystem: 8086:2f34
> 	Flags: fast devsel
> 	Kernel driver in use: hswep_uncore
> 
> 7f:10.5 0880: 8086:2f1e (rev 02)
> 	Subsystem: 8086:2f1e
> 	Flags: fast devsel
> 
> 7f:10.6 1101: 8086:2f7d (rev 02)
> 	Subsystem: 8086:2f7d
> 	Flags: fast devsel
> 
> 7f:10.7 0880: 8086:2f1f (rev 02)
> 	Subsystem: 8086:2f1f
> 	Flags: fast devsel
> 
> 7f:12.0 0880: 8086:2fa0 (rev 02)
> 	Subsystem: 8086:2fa0
> 	Flags: fast devsel
> 	Kernel driver in use: sbridge_edac
> 
> 7f:12.1 1101: 8086:2f30 (rev 02)
> 	Subsystem: 8086:2f30
> 	Flags: fast devsel
> 	Kernel driver in use: hswep_uncore
> 
> 7f:12.2 0880: 8086:2f70 (rev 02)
> 	Subsystem: 8086:2f70
> 	Flags: fast devsel
> 
> 7f:12.4 0880: 8086:2f60 (rev 02)
> 	Subsystem: 8086:2f60
> 	Flags: fast devsel
> 
> 7f:12.5 1101: 8086:2f38 (rev 02)
> 	Subsystem: 8086:2f38
> 	Flags: fast devsel
> 	Kernel driver in use: hswep_uncore
> 
> 7f:12.6 0880: 8086:2f78 (rev 02)
> 	Subsystem: 8086:2f78
> 	Flags: fast devsel
> 
> 7f:13.0 0880: 8086:2fa8 (rev 02)
> 	Subsystem: 8086:2fa8
> 	Flags: fast devsel
> 
> 7f:13.1 0880: 8086:2f71 (rev 02)
> 	Subsystem: 8086:2f71
> 	Flags: fast devsel
> 
> 7f:13.2 0880: 8086:2faa (rev 02)
> 	Subsystem: 8086:2faa
> 	Flags: fast devsel
> 
> 7f:13.3 0880: 8086:2fab (rev 02)
> 	Subsystem: 8086:2fab
> 	Flags: fast devsel
> 
> 7f:13.4 0880: 8086:2fac (rev 02)
> 	Subsystem: 8086:2fac
> 	Flags: fast devsel
> 
> 7f:13.5 0880: 8086:2fad (rev 02)
> 	Subsystem: 8086:2fad
> 	Flags: fast devsel
> 
> 7f:13.6 0880: 8086:2fae (rev 02)
> 	Flags: fast devsel
> 
> 7f:13.7 0880: 8086:2faf (rev 02)
> 	Flags: fast devsel
> 
> 7f:14.0 0880: 8086:2fb0 (rev 02)
> 	Subsystem: 8086:2fb0
> 	Flags: fast devsel
> 	Kernel driver in use: hswep_uncore
> 
> 7f:14.1 0880: 8086:2fb1 (rev 02)
> 	Subsystem: 8086:2fb1
> 	Flags: fast devsel
> 	Kernel driver in use: hswep_uncore
> 
> 7f:14.2 0880: 8086:2fb2 (rev 02)
> 	Subsystem: 8086:2fb2
> 	Flags: fast devsel
> 
> 7f:14.3 0880: 8086:2fb3 (rev 02)
> 	Subsystem: 8086:2fb3
> 	Flags: fast devsel
> 
> 7f:14.4 0880: 8086:2fbc (rev 02)
> 	Flags: fast devsel
> 
> 7f:14.5 0880: 8086:2fbd (rev 02)
> 	Flags: fast devsel
> 
> 7f:14.6 0880: 8086:2fbe (rev 02)
> 	Flags: fast devsel
> 
> 7f:14.7 0880: 8086:2fbf (rev 02)
> 	Flags: fast devsel
> 
> 7f:15.0 0880: 8086:2fb4 (rev 02)
> 	Subsystem: 8086:2fb4
> 	Flags: fast devsel
> 	Kernel driver in use: hswep_uncore
> 
> 7f:15.1 0880: 8086:2fb5 (rev 02)
> 	Subsystem: 8086:2fb5
> 	Flags: fast devsel
> 	Kernel driver in use: hswep_uncore
> 
> 7f:15.2 0880: 8086:2fb6 (rev 02)
> 	Subsystem: 8086:2fb6
> 	Flags: fast devsel
> 
> 7f:15.3 0880: 8086:2fb7 (rev 02)
> 	Subsystem: 8086:2fb7
> 	Flags: fast devsel
> 
> 7f:16.0 0880: 8086:2f68 (rev 02)
> 	Subsystem: 8086:2f68
> 	Flags: fast devsel
> 
> 7f:16.1 0880: 8086:2f79 (rev 02)
> 	Subsystem: 8086:2f79
> 	Flags: fast devsel
> 
> 7f:16.2 0880: 8086:2f6a (rev 02)
> 	Subsystem: 8086:2f6a
> 	Flags: fast devsel
> 
> 7f:16.3 0880: 8086:2f6b (rev 02)
> 	Subsystem: 8086:2f6b
> 	Flags: fast devsel
> 
> 7f:16.4 0880: 8086:2f6c (rev 02)
> 	Subsystem: 8086:2f6c
> 	Flags: fast devsel
> 
> 7f:16.5 0880: 8086:2f6d (rev 02)
> 	Subsystem: 8086:2f6d
> 	Flags: fast devsel
> 
> 7f:16.6 0880: 8086:2f6e (rev 02)
> 	Flags: fast devsel
> 
> 7f:16.7 0880: 8086:2f6f (rev 02)
> 	Flags: fast devsel
> 
> 7f:17.0 0880: 8086:2fd0 (rev 02)
> 	Subsystem: 8086:2fd0
> 	Flags: fast devsel
> 	Kernel driver in use: hswep_uncore
> 
> 7f:17.1 0880: 8086:2fd1 (rev 02)
> 	Subsystem: 8086:2fd1
> 	Flags: fast devsel
> 	Kernel driver in use: hswep_uncore
> 
> 7f:17.2 0880: 8086:2fd2 (rev 02)
> 	Subsystem: 8086:2fd2
> 	Flags: fast devsel
> 
> 7f:17.3 0880: 8086:2fd3 (rev 02)
> 	Subsystem: 8086:2fd3
> 	Flags: fast devsel
> 
> 7f:17.4 0880: 8086:2fb8 (rev 02)
> 	Flags: fast devsel
> 
> 7f:17.5 0880: 8086:2fb9 (rev 02)
> 	Flags: fast devsel
> 
> 7f:17.6 0880: 8086:2fba (rev 02)
> 	Flags: fast devsel
> 
> 7f:17.7 0880: 8086:2fbb (rev 02)
> 	Flags: fast devsel
> 
> 7f:18.0 0880: 8086:2fd4 (rev 02)
> 	Subsystem: 8086:2fd4
> 	Flags: fast devsel
> 	Kernel driver in use: hswep_uncore
> 
> 7f:18.1 0880: 8086:2fd5 (rev 02)
> 	Subsystem: 8086:2fd5
> 	Flags: fast devsel
> 	Kernel driver in use: hswep_uncore
> 
> 7f:18.2 0880: 8086:2fd6 (rev 02)
> 	Subsystem: 8086:2fd6
> 	Flags: fast devsel
> 
> 7f:18.3 0880: 8086:2fd7 (rev 02)
> 	Subsystem: 8086:2fd7
> 	Flags: fast devsel
> 
> 7f:1e.0 0880: 8086:2f98 (rev 02)
> 	Subsystem: 8086:2f98
> 	Flags: fast devsel
> 
> 7f:1e.1 0880: 8086:2f99 (rev 02)
> 	Subsystem: 8086:2f99
> 	Flags: fast devsel
> 
> 7f:1e.2 0880: 8086:2f9a (rev 02)
> 	Subsystem: 8086:2f9a
> 	Flags: fast devsel
> 
> 7f:1e.3 0880: 8086:2fc0 (rev 02)
> 	Subsystem: 8086:2fc0
> 	Flags: fast devsel
> 	I/O ports at <ignored> [disabled]
> 	Kernel driver in use: hswep_uncore
> 
> 7f:1e.4 0880: 8086:2f9c (rev 02)
> 	Subsystem: 8086:2f9c
> 	Flags: fast devsel
> 
> 7f:1f.0 0880: 8086:2f88 (rev 02)
> 	Flags: fast devsel
> 
> 7f:1f.2 0880: 8086:2f8a (rev 02)
> 	Flags: fast devsel
> 
> 80:01.0 0604: 8086:2f02 (rev 02) (prog-if 00 [Normal decode])
> 	Flags: bus master, fast devsel, latency 0
> 	Bus: primary=80, secondary=81, subordinate=81, sec-latency=0
> 	Capabilities: [40] Subsystem: 8086:0000
> 	Capabilities: [60] MSI: Enable+ Count=1/2 Maskable+ 64bit-
> 	Capabilities: [90] Express Root Port (Slot+), MSI 00
> 	Capabilities: [e0] Power Management version 3
> 	Capabilities: [100] Vendor Specific Information: ID=0002 Rev=0 Len=00c <?>
> 	Capabilities: [110] Access Control Services
> 	Capabilities: [148] Advanced Error Reporting
> 	Capabilities: [1d0] Vendor Specific Information: ID=0003 Rev=1 Len=00a <?>
> 	Capabilities: [250] #19
> 	Capabilities: [280] Vendor Specific Information: ID=0005 Rev=3 Len=018 <?>
> 	Capabilities: [300] Vendor Specific Information: ID=0008 Rev=0 Len=038 <?>
> 	Kernel driver in use: pcieport
> 
> 80:02.0 0604: 8086:2f04 (rev 02) (prog-if 00 [Normal decode])
> 	Flags: bus master, fast devsel, latency 0
> 	Bus: primary=80, secondary=82, subordinate=82, sec-latency=0
> 	Memory behind bridge: c8100000-c90fffff
> 	Prefetchable memory behind bridge: 0000037ffc000000-0000037fffffffff
> 	Capabilities: [40] Subsystem: 8086:0000
> 	Capabilities: [60] MSI: Enable+ Count=1/2 Maskable+ 64bit-
> 	Capabilities: [90] Express Root Port (Slot+), MSI 00
> 	Capabilities: [e0] Power Management version 3
> 	Capabilities: [100] Vendor Specific Information: ID=0002 Rev=0 Len=00c <?>
> 	Capabilities: [110] Access Control Services
> 	Capabilities: [148] Advanced Error Reporting
> 	Capabilities: [1d0] Vendor Specific Information: ID=0003 Rev=1 Len=00a <?>
> 	Capabilities: [250] #19
> 	Capabilities: [280] Vendor Specific Information: ID=0005 Rev=3 Len=018 <?>
> 	Capabilities: [300] Vendor Specific Information: ID=0008 Rev=0 Len=038 <?>
> 	Kernel driver in use: pcieport
> 
> 80:03.0 0604: 8086:2f08 (rev 02) (prog-if 00 [Normal decode])
> 	Flags: bus master, fast devsel, latency 0
> 	Bus: primary=80, secondary=83, subordinate=83, sec-latency=0
> 	Capabilities: [40] Subsystem: 8086:0000
> 	Capabilities: [60] MSI: Enable+ Count=1/2 Maskable+ 64bit-
> 	Capabilities: [90] Express Root Port (Slot+), MSI 00
> 	Capabilities: [e0] Power Management version 3
> 	Capabilities: [100] Vendor Specific Information: ID=0002 Rev=0 Len=00c <?>
> 	Capabilities: [110] Access Control Services
> 	Capabilities: [148] Advanced Error Reporting
> 	Capabilities: [1d0] Vendor Specific Information: ID=0003 Rev=1 Len=00a <?>
> 	Capabilities: [250] #19
> 	Capabilities: [280] Vendor Specific Information: ID=0005 Rev=3 Len=018 <?>
> 	Capabilities: [300] Vendor Specific Information: ID=0008 Rev=0 Len=038 <?>
> 	Kernel driver in use: pcieport
> 
> 80:03.2 0604: 8086:2f0a (rev 02) (prog-if 00 [Normal decode])
> 	Flags: bus master, fast devsel, latency 0
> 	Bus: primary=80, secondary=84, subordinate=84, sec-latency=0
> 	Capabilities: [40] Subsystem: 8086:0000
> 	Capabilities: [60] MSI: Enable+ Count=1/2 Maskable+ 64bit-
> 	Capabilities: [90] Express Root Port (Slot+), MSI 00
> 	Capabilities: [e0] Power Management version 3
> 	Capabilities: [100] Vendor Specific Information: ID=0002 Rev=0 Len=00c <?>
> 	Capabilities: [110] Access Control Services
> 	Capabilities: [148] Advanced Error Reporting
> 	Capabilities: [1d0] Vendor Specific Information: ID=0003 Rev=1 Len=00a <?>
> 	Capabilities: [250] #19
> 	Capabilities: [280] Vendor Specific Information: ID=0005 Rev=3 Len=018 <?>
> 	Capabilities: [300] Vendor Specific Information: ID=0008 Rev=0 Len=038 <?>
> 	Kernel driver in use: pcieport
> 
> 80:05.0 0880: 8086:2f28 (rev 02)
> 	Flags: fast devsel
> 	Capabilities: [40] Express Root Complex Integrated Endpoint, MSI 00
> 
> 80:05.1 0880: 8086:2f29 (rev 02)
> 	Flags: fast devsel
> 	Capabilities: [40] Express Root Complex Integrated Endpoint, MSI 00
> 	Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit+
> 	Capabilities: [100] Vendor Specific Information: ID=0006 Rev=1 Len=010 <?>
> 	Capabilities: [110] Vendor Specific Information: ID=0006 Rev=1 Len=010 <?>
> 	Capabilities: [120] Vendor Specific Information: ID=0006 Rev=1 Len=010 <?>
> 	Capabilities: [130] Vendor Specific Information: ID=0006 Rev=1 Len=010 <?>
> 
> 80:05.2 0880: 8086:2f2a (rev 02)
> 	Flags: fast devsel
> 	Capabilities: [40] Express Root Complex Integrated Endpoint, MSI 00
> 
> 80:05.4 0800: 8086:2f2c (rev 02) (prog-if 20 [IO(X)-APIC])
> 	Subsystem: 8086:0000
> 	Flags: bus master, fast devsel, latency 0
> 	Memory at c8000000 (32-bit, non-prefetchable) [size=4K]
> 	Capabilities: [44] Express Root Complex Integrated Endpoint, MSI 00
> 	Capabilities: [e0] Power Management version 3
> 
> 80:05.6 1101: 8086:2f39 (rev 02)
> 	Flags: fast devsel
> 	Capabilities: [40] Express Root Complex Integrated Endpoint, MSI 00
> 	Kernel driver in use: hswep_uncore
> 
> 80:06.0 0880: 8086:2f10 (rev 02)
> 	Subsystem: 8086:0000
> 	Flags: fast devsel
> 	Capabilities: [40] Express Root Complex Integrated Endpoint, MSI 00
> 	Capabilities: [100] Vendor Specific Information: ID=0001 Rev=0 Len=0b8 <?>
> 
> 80:06.1 0880: 8086:2f11 (rev 02)
> 	Subsystem: 8086:0000
> 	Flags: fast devsel
> 	Capabilities: [40] Express Root Complex Integrated Endpoint, MSI 00
> 	Capabilities: [100] Vendor Specific Information: ID=0001 Rev=0 Len=0b8 <?>
> 
> 80:06.2 0880: 8086:2f12 (rev 02)
> 	Subsystem: 8086:0000
> 	Flags: fast devsel
> 	Capabilities: [40] Express Root Complex Integrated Endpoint, MSI 00
> 
> 80:06.3 0880: 8086:2f13 (rev 02)
> 	Subsystem: 8086:0000
> 	Flags: fast devsel
> 	Capabilities: [40] Express Root Complex Integrated Endpoint, MSI 00
> 	Capabilities: [100] Vendor Specific Information: ID=0001 Rev=0 Len=0b8 <?>
> 
> 80:06.4 0880: 8086:2f14 (rev 02)
> 	Subsystem: 8086:0000
> 	Flags: fast devsel
> 	Capabilities: [40] Express Root Complex Integrated Endpoint, MSI 00
> 
> 80:06.5 0880: 8086:2f15 (rev 02)
> 	Subsystem: 8086:0000
> 	Flags: fast devsel
> 	Capabilities: [40] Express Root Complex Integrated Endpoint, MSI 00
> 
> 80:06.6 0880: 8086:2f16 (rev 02)
> 	Subsystem: 8086:0000
> 	Flags: fast devsel
> 	Capabilities: [40] Express Root Complex Integrated Endpoint, MSI 00
> 
> 80:06.7 0880: 8086:2f17 (rev 02)
> 	Subsystem: 8086:0000
> 	Flags: fast devsel
> 	Capabilities: [40] Express Root Complex Integrated Endpoint, MSI 00
> 
> 80:07.0 0880: 8086:2f18 (rev 02)
> 	Subsystem: 8086:0000
> 	Flags: fast devsel
> 	Capabilities: [40] Express Root Complex Integrated Endpoint, MSI 00
> 	Capabilities: [100] Vendor Specific Information: ID=0001 Rev=0 Len=0b8 <?>
> 
> 80:07.1 0880: 8086:2f19 (rev 02)
> 	Subsystem: 8086:0000
> 	Flags: fast devsel
> 	Capabilities: [40] Express Root Complex Integrated Endpoint, MSI 00
> 
> 80:07.2 0880: 8086:2f1a (rev 02)
> 	Subsystem: 8086:0000
> 	Flags: fast devsel
> 	Capabilities: [40] Express Root Complex Integrated Endpoint, MSI 00
> 
> 80:07.3 0880: 8086:2f1b (rev 02)
> 	Subsystem: 8086:0000
> 	Flags: fast devsel
> 	Capabilities: [40] Express Root Complex Integrated Endpoint, MSI 00
> 
> 80:07.4 0880: 8086:2f1c (rev 02)
> 	Subsystem: 8086:0000
> 	Flags: fast devsel
> 	Capabilities: [40] Express Root Complex Integrated Endpoint, MSI 00
> 
> 82:00.0 0200: 15b3:101d
> 	Subsystem: 15b3:0043
> 	Flags: bus master, fast devsel, latency 0, IRQ 216
> 	Memory at 37ffe000000 (64-bit, prefetchable) [size=32M]
> 	Capabilities: [60] Express Endpoint, MSI 00
> 	Capabilities: [48] Vital Product Data
> 	Capabilities: [9c] MSI-X: Enable+ Count=64 Masked-
> 	Capabilities: [c0] Vendor Specific Information: Len=18 <?>
> 	Capabilities: [40] Power Management version 3
> 	Capabilities: [100] Advanced Error Reporting
> 	Capabilities: [150] Alternative Routing-ID Interpretation (ARI)
> 	Capabilities: [180] Single Root I/O Virtualization (SR-IOV)
> 	Capabilities: [1c0] #19
> 	Capabilities: [230] Access Control Services
> 	Capabilities: [320] #27
> 	Capabilities: [370] #26
> 	Capabilities: [420] #25
> 	Kernel driver in use: mlx5_core
> 
> 82:00.1 0200: 15b3:101d
> 	Subsystem: 15b3:0043
> 	Flags: bus master, fast devsel, latency 0, IRQ 258
> 	Memory at 37ffc000000 (64-bit, prefetchable) [size=32M]
> 	Capabilities: [60] Express Endpoint, MSI 00
> 	Capabilities: [48] Vital Product Data
> 	Capabilities: [9c] MSI-X: Enable+ Count=64 Masked-
> 	Capabilities: [c0] Vendor Specific Information: Len=18 <?>
> 	Capabilities: [40] Power Management version 3
> 	Capabilities: [100] Advanced Error Reporting
> 	Capabilities: [150] Alternative Routing-ID Interpretation (ARI)
> 	Capabilities: [180] Single Root I/O Virtualization (SR-IOV)
> 	Capabilities: [230] Access Control Services
> 	Capabilities: [420] #25
> 	Kernel driver in use: mlx5_core
> 
> ff:08.0 0880: 8086:2f80 (rev 02)
> 	Subsystem: 8086:2f80
> 	Flags: fast devsel
> 
> ff:08.2 1101: 8086:2f32 (rev 02)
> 	Subsystem: 8086:2f32
> 	Flags: fast devsel
> 	Kernel driver in use: hswep_uncore
> 
> ff:08.3 0880: 8086:2f83 (rev 02)
> 	Subsystem: 8086:2f83
> 	Flags: fast devsel
> 
> ff:08.5 0880: 8086:2f85 (rev 02)
> 	Subsystem: 8086:2f85
> 	Flags: fast devsel
> 
> ff:08.6 0880: 8086:2f86 (rev 02)
> 	Subsystem: 8086:2f86
> 	Flags: fast devsel
> 	Kernel driver in use: hswep_uncore
> 
> ff:08.7 0880: 8086:2f87 (rev 02)
> 	Subsystem: 8086:2f87
> 	Flags: fast devsel
> 
> ff:09.0 0880: 8086:2f90 (rev 02)
> 	Subsystem: 8086:2f90
> 	Flags: fast devsel
> 
> ff:09.2 1101: 8086:2f33 (rev 02)
> 	Subsystem: 8086:2f33
> 	Flags: fast devsel
> 	Kernel driver in use: hswep_uncore
> 
> ff:09.3 0880: 8086:2f93 (rev 02)
> 	Subsystem: 8086:2f93
> 	Flags: fast devsel
> 
> ff:09.5 0880: 8086:2f95 (rev 02)
> 	Subsystem: 8086:2f95
> 	Flags: fast devsel
> 
> ff:09.6 0880: 8086:2f96 (rev 02)
> 	Subsystem: 8086:2f96
> 	Flags: fast devsel
> 	Kernel driver in use: hswep_uncore
> 
> ff:0b.0 0880: 8086:2f81 (rev 02)
> 	Subsystem: 8086:2f81
> 	Flags: fast devsel
> 
> ff:0b.1 1101: 8086:2f36 (rev 02)
> 	Subsystem: 8086:2f36
> 	Flags: fast devsel
> 	Kernel driver in use: hswep_uncore
> 
> ff:0b.2 1101: 8086:2f37 (rev 02)
> 	Subsystem: 8086:2f37
> 	Flags: fast devsel
> 	Kernel driver in use: hswep_uncore
> 
> ff:0b.4 0880: 8086:2f41 (rev 02)
> 	Subsystem: 8086:2f41
> 	Flags: fast devsel
> 
> ff:0b.5 1101: 8086:2f3e (rev 02)
> 	Subsystem: 8086:2f3e
> 	Flags: fast devsel
> 	Kernel driver in use: hswep_uncore
> 
> ff:0b.6 1101: 8086:2f3f (rev 02)
> 	Subsystem: 8086:2f3f
> 	Flags: fast devsel
> 
> ff:0c.0 0880: 8086:2fe0 (rev 02)
> 	Subsystem: 8086:2fe0
> 	Flags: fast devsel
> 
> ff:0c.1 0880: 8086:2fe1 (rev 02)
> 	Subsystem: 8086:2fe1
> 	Flags: fast devsel
> 
> ff:0c.2 0880: 8086:2fe2 (rev 02)
> 	Subsystem: 8086:2fe2
> 	Flags: fast devsel
> 
> ff:0c.3 0880: 8086:2fe3 (rev 02)
> 	Subsystem: 8086:2fe3
> 	Flags: fast devsel
> 
> ff:0c.4 0880: 8086:2fe4 (rev 02)
> 	Subsystem: 8086:2fe4
> 	Flags: fast devsel
> 
> ff:0c.5 0880: 8086:2fe5 (rev 02)
> 	Subsystem: 8086:2fe5
> 	Flags: fast devsel
> 
> ff:0c.6 0880: 8086:2fe6 (rev 02)
> 	Subsystem: 8086:2fe6
> 	Flags: fast devsel
> 
> ff:0c.7 0880: 8086:2fe7 (rev 02)
> 	Subsystem: 8086:2fe7
> 	Flags: fast devsel
> 
> ff:0d.0 0880: 8086:2fe8 (rev 02)
> 	Subsystem: 8086:2fe8
> 	Flags: fast devsel
> 
> ff:0d.1 0880: 8086:2fe9 (rev 02)
> 	Subsystem: 8086:2fe9
> 	Flags: fast devsel
> 
> ff:0f.0 0880: 8086:2ff8 (rev 02)
> 	Flags: fast devsel
> 
> ff:0f.1 0880: 8086:2ff9 (rev 02)
> 	Flags: fast devsel
> 
> ff:0f.2 0880: 8086:2ffa (rev 02)
> 	Flags: fast devsel
> 
> ff:0f.3 0880: 8086:2ffb (rev 02)
> 	Flags: fast devsel
> 
> ff:0f.4 0880: 8086:2ffc (rev 02)
> 	Subsystem: 8086:2fe0
> 	Flags: fast devsel
> 
> ff:0f.5 0880: 8086:2ffd (rev 02)
> 	Subsystem: 8086:2fe0
> 	Flags: fast devsel
> 
> ff:0f.6 0880: 8086:2ffe (rev 02)
> 	Subsystem: 8086:2fe0
> 	Flags: fast devsel
> 
> ff:10.0 0880: 8086:2f1d (rev 02)
> 	Subsystem: 8086:2f1d
> 	Flags: fast devsel
> 
> ff:10.1 1101: 8086:2f34 (rev 02)
> 	Subsystem: 8086:2f34
> 	Flags: fast devsel
> 	Kernel driver in use: hswep_uncore
> 
> ff:10.5 0880: 8086:2f1e (rev 02)
> 	Subsystem: 8086:2f1e
> 	Flags: fast devsel
> 
> ff:10.6 1101: 8086:2f7d (rev 02)
> 	Subsystem: 8086:2f7d
> 	Flags: fast devsel
> 
> ff:10.7 0880: 8086:2f1f (rev 02)
> 	Subsystem: 8086:2f1f
> 	Flags: fast devsel
> 
> ff:12.0 0880: 8086:2fa0 (rev 02)
> 	Subsystem: 8086:2fa0
> 	Flags: fast devsel
> 
> ff:12.1 1101: 8086:2f30 (rev 02)
> 	Subsystem: 8086:2f30
> 	Flags: fast devsel
> 	Kernel driver in use: hswep_uncore
> 
> ff:12.2 0880: 8086:2f70 (rev 02)
> 	Subsystem: 8086:2f70
> 	Flags: fast devsel
> 
> ff:12.4 0880: 8086:2f60 (rev 02)
> 	Subsystem: 8086:2f60
> 	Flags: fast devsel
> 
> ff:12.5 1101: 8086:2f38 (rev 02)
> 	Subsystem: 8086:2f38
> 	Flags: fast devsel
> 	Kernel driver in use: hswep_uncore
> 
> ff:12.6 0880: 8086:2f78 (rev 02)
> 	Subsystem: 8086:2f78
> 	Flags: fast devsel
> 
> ff:13.0 0880: 8086:2fa8 (rev 02)
> 	Subsystem: 8086:2fa8
> 	Flags: fast devsel
> 
> ff:13.1 0880: 8086:2f71 (rev 02)
> 	Subsystem: 8086:2f71
> 	Flags: fast devsel
> 
> ff:13.2 0880: 8086:2faa (rev 02)
> 	Subsystem: 8086:2faa
> 	Flags: fast devsel
> 
> ff:13.3 0880: 8086:2fab (rev 02)
> 	Subsystem: 8086:2fab
> 	Flags: fast devsel
> 
> ff:13.4 0880: 8086:2fac (rev 02)
> 	Subsystem: 8086:2fac
> 	Flags: fast devsel
> 
> ff:13.5 0880: 8086:2fad (rev 02)
> 	Subsystem: 8086:2fad
> 	Flags: fast devsel
> 
> ff:13.6 0880: 8086:2fae (rev 02)
> 	Flags: fast devsel
> 
> ff:13.7 0880: 8086:2faf (rev 02)
> 	Flags: fast devsel
> 
> ff:14.0 0880: 8086:2fb0 (rev 02)
> 	Subsystem: 8086:2fb0
> 	Flags: fast devsel
> 	Kernel driver in use: hswep_uncore
> 
> ff:14.1 0880: 8086:2fb1 (rev 02)
> 	Subsystem: 8086:2fb1
> 	Flags: fast devsel
> 	Kernel driver in use: hswep_uncore
> 
> ff:14.2 0880: 8086:2fb2 (rev 02)
> 	Subsystem: 8086:2fb2
> 	Flags: fast devsel
> 
> ff:14.3 0880: 8086:2fb3 (rev 02)
> 	Subsystem: 8086:2fb3
> 	Flags: fast devsel
> 
> ff:14.4 0880: 8086:2fbc (rev 02)
> 	Flags: fast devsel
> 
> ff:14.5 0880: 8086:2fbd (rev 02)
> 	Flags: fast devsel
> 
> ff:14.6 0880: 8086:2fbe (rev 02)
> 	Flags: fast devsel
> 
> ff:14.7 0880: 8086:2fbf (rev 02)
> 	Flags: fast devsel
> 
> ff:15.0 0880: 8086:2fb4 (rev 02)
> 	Subsystem: 8086:2fb4
> 	Flags: fast devsel
> 	Kernel driver in use: hswep_uncore
> 
> ff:15.1 0880: 8086:2fb5 (rev 02)
> 	Subsystem: 8086:2fb5
> 	Flags: fast devsel
> 	Kernel driver in use: hswep_uncore
> 
> ff:15.2 0880: 8086:2fb6 (rev 02)
> 	Subsystem: 8086:2fb6
> 	Flags: fast devsel
> 
> ff:15.3 0880: 8086:2fb7 (rev 02)
> 	Subsystem: 8086:2fb7
> 	Flags: fast devsel
> 
> ff:16.0 0880: 8086:2f68 (rev 02)
> 	Subsystem: 8086:2f68
> 	Flags: fast devsel
> 
> ff:16.1 0880: 8086:2f79 (rev 02)
> 	Subsystem: 8086:2f79
> 	Flags: fast devsel
> 
> ff:16.2 0880: 8086:2f6a (rev 02)
> 	Subsystem: 8086:2f6a
> 	Flags: fast devsel
> 
> ff:16.3 0880: 8086:2f6b (rev 02)
> 	Subsystem: 8086:2f6b
> 	Flags: fast devsel
> 
> ff:16.4 0880: 8086:2f6c (rev 02)
> 	Subsystem: 8086:2f6c
> 	Flags: fast devsel
> 
> ff:16.5 0880: 8086:2f6d (rev 02)
> 	Subsystem: 8086:2f6d
> 	Flags: fast devsel
> 
> ff:16.6 0880: 8086:2f6e (rev 02)
> 	Flags: fast devsel
> 
> ff:16.7 0880: 8086:2f6f (rev 02)
> 	Flags: fast devsel
> 
> ff:17.0 0880: 8086:2fd0 (rev 02)
> 	Subsystem: 8086:2fd0
> 	Flags: fast devsel
> 	Kernel driver in use: hswep_uncore
> 
> ff:17.1 0880: 8086:2fd1 (rev 02)
> 	Subsystem: 8086:2fd1
> 	Flags: fast devsel
> 	Kernel driver in use: hswep_uncore
> 
> ff:17.2 0880: 8086:2fd2 (rev 02)
> 	Subsystem: 8086:2fd2
> 	Flags: fast devsel
> 
> ff:17.3 0880: 8086:2fd3 (rev 02)
> 	Subsystem: 8086:2fd3
> 	Flags: fast devsel
> 
> ff:17.4 0880: 8086:2fb8 (rev 02)
> 	Flags: fast devsel
> 
> ff:17.5 0880: 8086:2fb9 (rev 02)
> 	Flags: fast devsel
> 
> ff:17.6 0880: 8086:2fba (rev 02)
> 	Flags: fast devsel
> 
> ff:17.7 0880: 8086:2fbb (rev 02)
> 	Flags: fast devsel
> 
> ff:18.0 0880: 8086:2fd4 (rev 02)
> 	Subsystem: 8086:2fd4
> 	Flags: fast devsel
> 	Kernel driver in use: hswep_uncore
> 
> ff:18.1 0880: 8086:2fd5 (rev 02)
> 	Subsystem: 8086:2fd5
> 	Flags: fast devsel
> 	Kernel driver in use: hswep_uncore
> 
> ff:18.2 0880: 8086:2fd6 (rev 02)
> 	Subsystem: 8086:2fd6
> 	Flags: fast devsel
> 
> ff:18.3 0880: 8086:2fd7 (rev 02)
> 	Subsystem: 8086:2fd7
> 	Flags: fast devsel
> 
> ff:1e.0 0880: 8086:2f98 (rev 02)
> 	Subsystem: 8086:2f98
> 	Flags: fast devsel
> 
> ff:1e.1 0880: 8086:2f99 (rev 02)
> 	Subsystem: 8086:2f99
> 	Flags: fast devsel
> 
> ff:1e.2 0880: 8086:2f9a (rev 02)
> 	Subsystem: 8086:2f9a
> 	Flags: fast devsel
> 
> ff:1e.3 0880: 8086:2fc0 (rev 02)
> 	Subsystem: 8086:2fc0
> 	Flags: fast devsel
> 	I/O ports at <ignored> [disabled]
> 	Kernel driver in use: hswep_uncore
> 
> ff:1e.4 0880: 8086:2f9c (rev 02)
> 	Subsystem: 8086:2f9c
> 	Flags: fast devsel
> 
> ff:1f.0 0880: 8086:2f88 (rev 02)
> 	Flags: fast devsel
> 
> ff:1f.2 0880: 8086:2f8a (rev 02)
> 	Flags: fast devsel
> 

