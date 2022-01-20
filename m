Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34D29495499
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jan 2022 20:08:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377393AbiATTId (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jan 2022 14:08:33 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:40022 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346936AbiATTIc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Jan 2022 14:08:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 21913B81E2D;
        Thu, 20 Jan 2022 19:08:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81313C340E0;
        Thu, 20 Jan 2022 19:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642705709;
        bh=SSw+nMmX8JglpTPwJ3g4vpCvPSa5IL311wRyPrz7B1o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OGuw1qX0yKUNnipHwSs+tFlxWSk85V4sr77ePA6GSKZOqjYNNCMoHH3d3+OdmZg0X
         udvA0J+ZDZCGi0gv3/cTEO6BDRu11d891nFh9rBeQGH7+fut7w1BLxJ5w2fQfrY0G6
         aEIS9EyCILn/AcjIWRF0eS3LyqAPm+rR5lN5Y6yB9YLvMnkfzM5MmiBDKpDTnu5p/g
         N1erb8R4uzZ/uUoLeWCb+iTiWhRQ4Gen+QKaSV2vuewuLiWqII2WL33uxZ5KyCpDJ0
         cWSBEXlmHEfM0uY/2jmnPYKSsnooD6AF9fEv3dEFpuzChd0/tYI+RQ9voiXFrY8aLH
         p+XBpgaAINkhw==
Received: by pali.im (Postfix)
        id D266A791; Thu, 20 Jan 2022 20:08:26 +0100 (CET)
Date:   Thu, 20 Jan 2022 20:08:26 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/15] PCI: mvebu: Propagate errors when updating
 PCI_IO_BASE and PCI_MEM_BASE registers
Message-ID: <20220120190826.wkhkcx53lmafq2yp@pali>
References: <20220113103523.5usmja7bp44f7ju7@pali>
 <20220120175047.GA1050722@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220120175047.GA1050722@bhelgaas>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thursday 20 January 2022 11:50:47 Bjorn Helgaas wrote:
> On Thu, Jan 13, 2022 at 11:35:23AM +0100, Pali Rohár wrote:
> > On Wednesday 12 January 2022 18:19:21 Bjorn Helgaas wrote:
> > > On Sat, Jan 08, 2022 at 12:46:58AM +0100, Pali Rohár wrote:
> > > > On Friday 07 January 2022 17:16:17 Bjorn Helgaas wrote:
> > > > > On Fri, Jan 07, 2022 at 11:28:26PM +0100, Pali Rohár wrote:
> > > > > > On Friday 07 January 2022 15:55:04 Bjorn Helgaas wrote:
> > > > > > > On Thu, Nov 25, 2021 at 01:45:58PM +0100, Pali Rohár wrote:
> > > > > > > > Properly propagate failure from mvebu_pcie_add_windows()
> > > > > > > > function back to the caller
> > > > > > > > mvebu_pci_bridge_emul_base_conf_write() and correctly
> > > > > > > > updates PCI_IO_BASE, PCI_MEM_BASE and
> > > > > > > > PCI_IO_BASE_UPPER16 registers on error.  On error set
> > > > > > > > base value higher than limit value which indicates that
> > > > > > > > address range is disabled. 
> > > > > > > 
> > > > > > > Does the spec say that if software programs something
> > > > > > > invalid, hardware should proactively set the base and
> > > > > > > limit registers to disable the window?
> > > > > > 
> > > > > > No. But this patch address something totally different.
> > > > > > Software can do fully valid operation, e.g. try to set
> > > > > > forwarding memory window as large as possible. But because
> > > > > > this driver "emulates" pci bridge by calling software/kernel
> > > > > > function (mvebu_pcie_add_windows), some operations which in
> > > > > > real HW cannot happen, are possible in software.
> > > > > > 
> > > > > > For example there are limitations in sizes of forwarding
> > > > > > memory windows, because it is done by mvebu-mbus driver,
> > > > > > which is responsible for configuring mapping and forwarding
> > > > > > of PCIe I/O and MEM windows. And due to Marvell HW, there
> > > > > > are restrictions which are not in PCIe HW.
> > > > > > 
> > > > > > Currently if such error happens, obviously kernel is not
> > > > > > able to set PCIe windows and it just print warnings to
> > > > > > dmesg. Trying to access these windows would result in the
> > > > > > worst case in crashes.
> > > > > > 
> > > > > > With this change when mvebu_pcie_add_windows() function
> > > > > > fails then into emulated config space is put information
> > > > > > that particular forwarding window is disabled. I think that
> > > > > > it is better to indicate it in config space what is the
> > > > > > current "reality" of hardware configuration. If window is
> > > > > > disabled in real-HW (meaning in mvebu-mbus driver) then show
> > > > > > it also in emulated config space of pci bridge.
> > > > > > 
> > > > > > Do you have better idea what should emulated pci bridge do,
> > > > > > if software try to set fully valid configuration of
> > > > > > forwarding window, but it is not possible to achieve it
> > > > > > (even compliant PCI bridge must be able to do it)?
> > > > > 
> > > > > On an ACPI system, the host bridge window sizes are
> > > > > constrained by the host bridge _CRS method.  I assume there's
> > > > > a similar constraint in DT.
> > > > > 
> > > > > Is the fact that mvebu_pcie_add_windows() can fail a symptom
> > > > > of a DT that describes more available space than mvebu-bus can
> > > > > map?
> > > > 
> > > > Memory maps for mvebu are more complicated. There is no explicit
> > > > size in DT ranges property as it is dynamically allocated by
> > > > mvebu-mbus:
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/armada-385.dtsi?h=v5.15#n47
> > > 
> > > I wish I knew how to really interpret those "ranges" properties.
> > > (Is there a good description in Documentation/ somewhere?  All
> > > I've found so far is https://elinux.org/Device_Tree_Usage, which
> > > is good, but doesn't match this example completely.)
> > > 
> > > I see:
> > > 
> > >   pciec: pcie {
> > >     ranges = <...>;
> > >     pcie1: pcie@1,0 {
> > >       ranges = <0x82000000 0 0 0x82000000 0x1 0 1 0
> > > 	        0x81000000 0 0 0x81000000 0x1 0 1 0>;
> > >     };
> > >     pcie2: pcie@2,0 {
> > >       ranges = <0x82000000 0 0 0x82000000 0x2 0 1 0
> > > 	        0x81000000 0 0 0x81000000 0x2 0 1 0>;
> > >     };
> > >     pcie3: pcie@3,0 {
> > >       ranges = <0x82000000 0 0 0x82000000 0x3 0 1 0
> > > 	        0x81000000 0 0 0x81000000 0x3 0 1 0>;
> > >     };
> > >     pcie4: pcie@4,0 {
> > >       ranges = <0x82000000 0 0 0x82000000 0x4 0 1 0
> > > 	        0x81000000 0 0 0x81000000 0x4 0 1 0>;
> > >     };
> > >   };
> > > 
> > > What does this look like in dmesg, i.e., what CPU address ranges are
> > > mapped to what PCI bus addresses?
> > 
> > These explicit ranges in DT are probably ignored as they are invalid.
> > You can see them (0xffffffffffffffff) in dmesg. 
> 
> Are you saying that this DT ranges and the dmesg line are connected?
> 
>   ranges = <0x82000000 0 0 0x82000000 0x1 0 1 0
>             0x81000000 0 0 0x81000000 0x1 0 1 0>;
> 
>   mvebu-pcie soc:pcie: MEM 0xffffffffffffffff..0x00fffffffe -> 0x0100000000
> 
> 1) It would be nice if there were a hint somewhere in Documentation/
> that would allow mere mortals to see the connection there.

I agree, that there is missing lot of documentation related to Marvell
PCIe controllers, both pci-mvebu.c and pci-aardvark.c. The main problem
now is that it is hard to find information which explain everything...
like mysterious Memory Controller (which is now explained):
https://lore.kernel.org/linux-pci/20211003120944.3lmwxylnhlp2kfj7@pali/

> 2) Why do we have these DT entries if they are invalid and useless?

Sorry, I do not know. I was not involved during introducing of DT files
for this platform. I'm just observing how it works...

> > MEM and I/O resources are parsed in pci-mvebu.c driver in
> > mvebu_pcie_parse_request_resources() function.
> 
> So mvebu-mbus.c fills in the static mbus_state from the DT
> "pcie-mem-aperture", which seems unconnected to the DT descriptions of
> the PCI controllers:
> 
>   static struct mvebu_mbus_state mbus_state;
> 
>   mvebu_mbus_dt_init
>     mvebu_mbus_get_pcie_resources(&mbus_state.pcie_mem_aperture)
>       of_property_read_u32_array("pcie-mem-aperture")
> 
>   mvebu_pcie_probe
>     mvebu_pcie_parse_request_resources
>       mvebu_mbus_get_pcie_mem_aperture(&pcie->mem)
> 	*res = mbus_state.pcie_mem_aperture
>       pci_add_resource(&bridge->windows, &pcie->mem)
> 
> > Here is relevant dmesg output:
> > 
> > mvebu-pcie soc:pcie: host bridge /soc/pcie ranges:
> > mvebu-pcie soc:pcie:      MEM 0x00f1080000..0x00f1081fff -> 0x0000080000
> > mvebu-pcie soc:pcie:      MEM 0x00f1040000..0x00f1041fff -> 0x0000040000
> > mvebu-pcie soc:pcie:      MEM 0x00f1044000..0x00f1045fff -> 0x0000044000
> > mvebu-pcie soc:pcie:      MEM 0x00f1048000..0x00f1049fff -> 0x0000048000
> > mvebu-pcie soc:pcie:      MEM 0xffffffffffffffff..0x00fffffffe -> 0x0100000000
> > mvebu-pcie soc:pcie:       IO 0xffffffffffffffff..0x00fffffffe -> 0x0100000000
> > mvebu-pcie soc:pcie:      MEM 0xffffffffffffffff..0x00fffffffe -> 0x0200000000
> > mvebu-pcie soc:pcie:       IO 0xffffffffffffffff..0x00fffffffe -> 0x0200000000
> > mvebu-pcie soc:pcie:      MEM 0xffffffffffffffff..0x00fffffffe -> 0x0300000000
> > mvebu-pcie soc:pcie:       IO 0xffffffffffffffff..0x00fffffffe -> 0x0300000000
> > mvebu-pcie soc:pcie:      MEM 0xffffffffffffffff..0x00fffffffe -> 0x0400000000
> > mvebu-pcie soc:pcie:       IO 0xffffffffffffffff..0x00fffffffe -> 0x0400000000
> > mvebu-pcie soc:pcie: PCI host bridge to bus 0000:00
> > pci_bus 0000:00: root bus resource [bus 00-ff]
> > pci_bus 0000:00: root bus resource [mem 0xf1080000-0xf1081fff] (bus address [0x00080000-0x00081fff])
> > pci_bus 0000:00: root bus resource [mem 0xf1040000-0xf1041fff] (bus address [0x00040000-0x00041fff])
> > pci_bus 0000:00: root bus resource [mem 0xf1044000-0xf1045fff] (bus address [0x00044000-0x00045fff])
> > pci_bus 0000:00: root bus resource [mem 0xf1048000-0xf1049fff] (bus address [0x00048000-0x00049fff])
> > pci_bus 0000:00: root bus resource [mem 0xe0000000-0xe7ffffff]
> 
> I see 0xf1080000-0xf1081fff, 0xf1040000-0xf1041fff, etc mentioned in
> the DT info above, but I don't see where [mem 0xe0000000-0xe7ffffff]
> came from.

0xe0000000 is defined in above mentioned "pcie-mem-aperture" DT property
and it is in armada-38x.dtsi DTS file included from armada-385.dtsi:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/armada-38x.dtsi?h=v5.15#n42

> Regardless, this means PCI thinks [mem 0xe0000000-0xe7ffffff] is
> available on bus 00 and can be assigned to devices on bus 00 according
> to the normal PCI rules (BARs aligned on size, PCI bridge windows
> aligned on 1MB and multiple of 1MB in size).  IIUC, mvebu imposes
> additional alignment constraints on the bridge windows.
> 
> These are the bridge window assignments from your dmesg:
> 
> > pci 0000:00:01.0: BAR 8: assigned [mem 0xe0000000-0xe00fffff]
> > pci 0000:00:02.0: BAR 8: assigned [mem 0xe0200000-0xe04fffff]
> > pci 0000:00:03.0: BAR 8: assigned [mem 0xe0100000-0xe01fffff]
> 
> > pci 0000:00:01.0: PCI bridge to [bus 01]
> > pci 0000:00:01.0:   bridge window [mem 0xe0000000-0xe00fffff]
> > pci 0000:00:02.0: PCI bridge to [bus 02]
> > pci 0000:00:02.0:   bridge window [mem 0xe0200000-0xe04fffff]
> > pci 0000:00:03.0: PCI bridge to [bus 03]
> > pci 0000:00:03.0:   bridge window [mem 0xe0100000-0xe01fffff]
> 
> The PCI core knows nothing about the mvebu constraints.  Are we just
> lucky here that when PCI assigned these bridge windows, they happen to
> be supported on mvebu?  What happens if PCI decides it needs 29MB on
> bus 01?

In this case pci-mvebu.c split 29MB window into continuous ranges of
power of two (16MB + 8MB + 4MB + 1MB) and then register each range to
mbus slot. Code is in function mvebu_pcie_add_windows():
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/controller/pci-mvebu.c?h=v5.15#n300

So at the end there is continuous space of 29MB PCIe window, just it
"eats" 4 mbus slots.

This function may fail (if there is not enough free mbus slots) and this
patch is propagating that failure back to the caller.

> > > Are pcie1, pcie2, etc Root Ports?  Or are they each separate host
> > > bridges (they each have "bus-range = <0x00 0xff>")?
> > 
> > From kernel point of view they are root ports. But in reality every of
> > these root port is on separate bus segment, but kernel pci-mvebu.c
> > driver merges all these segments/domains into one host bridge and put
> > all root ports into bus 0.
> > 
> > Here is lspci -tvnn output with topology:
> > 
> > $ lspci -tvnn
> > -[0000:00]-+-01.0-[01]----00.0  Device [1e0f:0001]
> >            +-02.0-[02]----00.0  Qualcomm Atheros QCA986x/988x 802.11ac Wireless Network Adapter [168c:003c]
> >            \-03.0-[03]----00.0  Qualcomm Atheros AR9287 Wireless Network Adapter (PCI-Express) [168c:002e]
> 
> > Buses 1, 2 and 3 represents mPCIe cards, all of them are in reality
> > in separate bus segments and on different HW host bridges. So they
> > do *not* share access to config space, do *not* share INTx
> > interrupts, etc...
> > 
> > > Is space from pciec dynamically assigned to pcie1, pcie2, etc?  If
> > > so, I assume there are more restrictions on the size and alignment
> > > than on PCI bridge windows, which allow size/alignment down to
> > > 1MB?
> > 
> > Yes, exactly. I do not know now all restrictions. At least there are
> > fixed number of memory slots and each has to be of size 2^N. They
> > are dynamically assigned by kernel mbus driver at time when somebody
> > updates BASE/LIMIT registers. And that kernel mbus driver takes care
> > to split non-aligned window size to more slots of size 2^N. And
> > resources are shared from pool with other HW parts (e.g. DMA), so
> > other drivers loaded in kernel can "eat" available slots before
> > pci-mvebu and then there does not have to be nothing to allocate for
> > PCI.
> 
> So IIUC,
> 
>   pcie1 == 00:01.0 Root Port
>   pcie2 == 00:02.0 Root Port
>   pcie3 == 00:03.0 Root Port
> 
> From a software point of view, they're all under a single host bridge,
> and Linux assumes everything under a host bridge plays by the PCI
> rules.

Yes.

> In this case, the root ports *don't* play by the rules since they have
> additional alignment restrictions, so I think these really should be
> described as separate host bridges in DT with the address space
> carved up statically among them.

I fully agree with you.

But pci-mvebu.c driver and also its DT bindings are written differently.
Changing it probably would not be simple due to backward compatibility
and will take development resources...

> It's common on x86 to have multiple host bridges that all appear to
> software to be in domain 0000.  The bus number ranges under each are
> static, e.g., one bridge has [bus 00-7f] and another has [bus 80-ff].

For mvebu they are dynamic and kernel assigns them at boot. As my above
printed lspci topology is simple, first bridge has assigned [bus 01-01],
second bridge [bus 02-02] and third bridge [bus 03-03].

> > But most Armada boards do not have exported all peripherals from SoC,
> > unconnected are disabled in DT and therefore exhaustion should not
> > happen.
> > 
> > > I'm trying to see how this could be described in ACPI because that's a
> > > fairly general model that accommodates most machines.  Possibly
> > > describing mvebu in ACPI would involve losing some flexibility.
> > 
> > I do not understand APCI model very well and I'm in impression that it
> > is impossible to represent mvebu in ACPI.
> 
> It could be described as a separate host bridge for every root port.
> ACPI uses _CRS (current resource settings) to describe the apertures
> to PCI and any address translation.  Currently the _CRS description is
> static, but ACPI does allow those resource assignments to be modified
> via _PRS (possible resource settings) and _SRS (set resource
> settings).
> 
> Bjorn
