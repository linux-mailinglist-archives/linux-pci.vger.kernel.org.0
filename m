Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 059D949538C
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jan 2022 18:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232935AbiATRuw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jan 2022 12:50:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232919AbiATRuv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Jan 2022 12:50:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A63C061574;
        Thu, 20 Jan 2022 09:50:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4AF67B81E07;
        Thu, 20 Jan 2022 17:50:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA54AC340E3;
        Thu, 20 Jan 2022 17:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642701049;
        bh=uBykbVzlL0QHjj61BeaN5GB/Yt4BmjF6DthwNMIs+5k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=gKKJPjxJLU1n3xGX872rev9h3ycUznKmbpB7SsTyPdmBErLp+UFjJ8WHAWdJASd1N
         kjB1d+ad2nH3zL+vimfZkcCowv/0c68QW00SBU4MfaSkwIoQENBjsXvzQ5xWJO44uU
         ozDDUnUfJECaqCl/GLbwKVGNvOKfr0r9H3mv59/SOjOT6ZrEqDVtQ+XBHSwU+79Ppt
         L+NuS7/dedzSAQEekO/rARzN5HZbZUnqpvIK/oStULbAOaTaNQ6H2rGaqUALdDMHT0
         bJLB7sq13ro30hT/OamEA67dnDDZlEMiq95QBfbwEyqYLmO/kQ5G9AA4w1dA4W/WiC
         RO0HEWDgMJ0Mw==
Date:   Thu, 20 Jan 2022 11:50:47 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/15] PCI: mvebu: Propagate errors when updating
 PCI_IO_BASE and PCI_MEM_BASE registers
Message-ID: <20220120175047.GA1050722@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220113103523.5usmja7bp44f7ju7@pali>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 13, 2022 at 11:35:23AM +0100, Pali Rohár wrote:
> On Wednesday 12 January 2022 18:19:21 Bjorn Helgaas wrote:
> > On Sat, Jan 08, 2022 at 12:46:58AM +0100, Pali Rohár wrote:
> > > On Friday 07 January 2022 17:16:17 Bjorn Helgaas wrote:
> > > > On Fri, Jan 07, 2022 at 11:28:26PM +0100, Pali Rohár wrote:
> > > > > On Friday 07 January 2022 15:55:04 Bjorn Helgaas wrote:
> > > > > > On Thu, Nov 25, 2021 at 01:45:58PM +0100, Pali Rohár wrote:
> > > > > > > Properly propagate failure from mvebu_pcie_add_windows()
> > > > > > > function back to the caller
> > > > > > > mvebu_pci_bridge_emul_base_conf_write() and correctly
> > > > > > > updates PCI_IO_BASE, PCI_MEM_BASE and
> > > > > > > PCI_IO_BASE_UPPER16 registers on error.  On error set
> > > > > > > base value higher than limit value which indicates that
> > > > > > > address range is disabled. 
> > > > > > 
> > > > > > Does the spec say that if software programs something
> > > > > > invalid, hardware should proactively set the base and
> > > > > > limit registers to disable the window?
> > > > > 
> > > > > No. But this patch address something totally different.
> > > > > Software can do fully valid operation, e.g. try to set
> > > > > forwarding memory window as large as possible. But because
> > > > > this driver "emulates" pci bridge by calling software/kernel
> > > > > function (mvebu_pcie_add_windows), some operations which in
> > > > > real HW cannot happen, are possible in software.
> > > > > 
> > > > > For example there are limitations in sizes of forwarding
> > > > > memory windows, because it is done by mvebu-mbus driver,
> > > > > which is responsible for configuring mapping and forwarding
> > > > > of PCIe I/O and MEM windows. And due to Marvell HW, there
> > > > > are restrictions which are not in PCIe HW.
> > > > > 
> > > > > Currently if such error happens, obviously kernel is not
> > > > > able to set PCIe windows and it just print warnings to
> > > > > dmesg. Trying to access these windows would result in the
> > > > > worst case in crashes.
> > > > > 
> > > > > With this change when mvebu_pcie_add_windows() function
> > > > > fails then into emulated config space is put information
> > > > > that particular forwarding window is disabled. I think that
> > > > > it is better to indicate it in config space what is the
> > > > > current "reality" of hardware configuration. If window is
> > > > > disabled in real-HW (meaning in mvebu-mbus driver) then show
> > > > > it also in emulated config space of pci bridge.
> > > > > 
> > > > > Do you have better idea what should emulated pci bridge do,
> > > > > if software try to set fully valid configuration of
> > > > > forwarding window, but it is not possible to achieve it
> > > > > (even compliant PCI bridge must be able to do it)?
> > > > 
> > > > On an ACPI system, the host bridge window sizes are
> > > > constrained by the host bridge _CRS method.  I assume there's
> > > > a similar constraint in DT.
> > > > 
> > > > Is the fact that mvebu_pcie_add_windows() can fail a symptom
> > > > of a DT that describes more available space than mvebu-bus can
> > > > map?
> > > 
> > > Memory maps for mvebu are more complicated. There is no explicit
> > > size in DT ranges property as it is dynamically allocated by
> > > mvebu-mbus:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/armada-385.dtsi?h=v5.15#n47
> > 
> > I wish I knew how to really interpret those "ranges" properties.
> > (Is there a good description in Documentation/ somewhere?  All
> > I've found so far is https://elinux.org/Device_Tree_Usage, which
> > is good, but doesn't match this example completely.)
> > 
> > I see:
> > 
> >   pciec: pcie {
> >     ranges = <...>;
> >     pcie1: pcie@1,0 {
> >       ranges = <0x82000000 0 0 0x82000000 0x1 0 1 0
> > 	        0x81000000 0 0 0x81000000 0x1 0 1 0>;
> >     };
> >     pcie2: pcie@2,0 {
> >       ranges = <0x82000000 0 0 0x82000000 0x2 0 1 0
> > 	        0x81000000 0 0 0x81000000 0x2 0 1 0>;
> >     };
> >     pcie3: pcie@3,0 {
> >       ranges = <0x82000000 0 0 0x82000000 0x3 0 1 0
> > 	        0x81000000 0 0 0x81000000 0x3 0 1 0>;
> >     };
> >     pcie4: pcie@4,0 {
> >       ranges = <0x82000000 0 0 0x82000000 0x4 0 1 0
> > 	        0x81000000 0 0 0x81000000 0x4 0 1 0>;
> >     };
> >   };
> > 
> > What does this look like in dmesg, i.e., what CPU address ranges are
> > mapped to what PCI bus addresses?
> 
> These explicit ranges in DT are probably ignored as they are invalid.
> You can see them (0xffffffffffffffff) in dmesg. 

Are you saying that this DT ranges and the dmesg line are connected?

  ranges = <0x82000000 0 0 0x82000000 0x1 0 1 0
            0x81000000 0 0 0x81000000 0x1 0 1 0>;

  mvebu-pcie soc:pcie: MEM 0xffffffffffffffff..0x00fffffffe -> 0x0100000000

1) It would be nice if there were a hint somewhere in Documentation/
that would allow mere mortals to see the connection there.

2) Why do we have these DT entries if they are invalid and useless?

> MEM and I/O resources are parsed in pci-mvebu.c driver in
> mvebu_pcie_parse_request_resources() function.

So mvebu-mbus.c fills in the static mbus_state from the DT
"pcie-mem-aperture", which seems unconnected to the DT descriptions of
the PCI controllers:

  static struct mvebu_mbus_state mbus_state;

  mvebu_mbus_dt_init
    mvebu_mbus_get_pcie_resources(&mbus_state.pcie_mem_aperture)
      of_property_read_u32_array("pcie-mem-aperture")

  mvebu_pcie_probe
    mvebu_pcie_parse_request_resources
      mvebu_mbus_get_pcie_mem_aperture(&pcie->mem)
	*res = mbus_state.pcie_mem_aperture
      pci_add_resource(&bridge->windows, &pcie->mem)

> Here is relevant dmesg output:
> 
> mvebu-pcie soc:pcie: host bridge /soc/pcie ranges:
> mvebu-pcie soc:pcie:      MEM 0x00f1080000..0x00f1081fff -> 0x0000080000
> mvebu-pcie soc:pcie:      MEM 0x00f1040000..0x00f1041fff -> 0x0000040000
> mvebu-pcie soc:pcie:      MEM 0x00f1044000..0x00f1045fff -> 0x0000044000
> mvebu-pcie soc:pcie:      MEM 0x00f1048000..0x00f1049fff -> 0x0000048000
> mvebu-pcie soc:pcie:      MEM 0xffffffffffffffff..0x00fffffffe -> 0x0100000000
> mvebu-pcie soc:pcie:       IO 0xffffffffffffffff..0x00fffffffe -> 0x0100000000
> mvebu-pcie soc:pcie:      MEM 0xffffffffffffffff..0x00fffffffe -> 0x0200000000
> mvebu-pcie soc:pcie:       IO 0xffffffffffffffff..0x00fffffffe -> 0x0200000000
> mvebu-pcie soc:pcie:      MEM 0xffffffffffffffff..0x00fffffffe -> 0x0300000000
> mvebu-pcie soc:pcie:       IO 0xffffffffffffffff..0x00fffffffe -> 0x0300000000
> mvebu-pcie soc:pcie:      MEM 0xffffffffffffffff..0x00fffffffe -> 0x0400000000
> mvebu-pcie soc:pcie:       IO 0xffffffffffffffff..0x00fffffffe -> 0x0400000000
> mvebu-pcie soc:pcie: PCI host bridge to bus 0000:00
> pci_bus 0000:00: root bus resource [bus 00-ff]
> pci_bus 0000:00: root bus resource [mem 0xf1080000-0xf1081fff] (bus address [0x00080000-0x00081fff])
> pci_bus 0000:00: root bus resource [mem 0xf1040000-0xf1041fff] (bus address [0x00040000-0x00041fff])
> pci_bus 0000:00: root bus resource [mem 0xf1044000-0xf1045fff] (bus address [0x00044000-0x00045fff])
> pci_bus 0000:00: root bus resource [mem 0xf1048000-0xf1049fff] (bus address [0x00048000-0x00049fff])
> pci_bus 0000:00: root bus resource [mem 0xe0000000-0xe7ffffff]

I see 0xf1080000-0xf1081fff, 0xf1040000-0xf1041fff, etc mentioned in
the DT info above, but I don't see where [mem 0xe0000000-0xe7ffffff]
came from.

Regardless, this means PCI thinks [mem 0xe0000000-0xe7ffffff] is
available on bus 00 and can be assigned to devices on bus 00 according
to the normal PCI rules (BARs aligned on size, PCI bridge windows
aligned on 1MB and multiple of 1MB in size).  IIUC, mvebu imposes
additional alignment constraints on the bridge windows.

These are the bridge window assignments from your dmesg:

> pci 0000:00:01.0: BAR 8: assigned [mem 0xe0000000-0xe00fffff]
> pci 0000:00:02.0: BAR 8: assigned [mem 0xe0200000-0xe04fffff]
> pci 0000:00:03.0: BAR 8: assigned [mem 0xe0100000-0xe01fffff]

> pci 0000:00:01.0: PCI bridge to [bus 01]
> pci 0000:00:01.0:   bridge window [mem 0xe0000000-0xe00fffff]
> pci 0000:00:02.0: PCI bridge to [bus 02]
> pci 0000:00:02.0:   bridge window [mem 0xe0200000-0xe04fffff]
> pci 0000:00:03.0: PCI bridge to [bus 03]
> pci 0000:00:03.0:   bridge window [mem 0xe0100000-0xe01fffff]

The PCI core knows nothing about the mvebu constraints.  Are we just
lucky here that when PCI assigned these bridge windows, they happen to
be supported on mvebu?  What happens if PCI decides it needs 29MB on
bus 01?

> > Are pcie1, pcie2, etc Root Ports?  Or are they each separate host
> > bridges (they each have "bus-range = <0x00 0xff>")?
> 
> From kernel point of view they are root ports. But in reality every of
> these root port is on separate bus segment, but kernel pci-mvebu.c
> driver merges all these segments/domains into one host bridge and put
> all root ports into bus 0.
> 
> Here is lspci -tvnn output with topology:
> 
> $ lspci -tvnn
> -[0000:00]-+-01.0-[01]----00.0  Device [1e0f:0001]
>            +-02.0-[02]----00.0  Qualcomm Atheros QCA986x/988x 802.11ac Wireless Network Adapter [168c:003c]
>            \-03.0-[03]----00.0  Qualcomm Atheros AR9287 Wireless Network Adapter (PCI-Express) [168c:002e]

> Buses 1, 2 and 3 represents mPCIe cards, all of them are in reality
> in separate bus segments and on different HW host bridges. So they
> do *not* share access to config space, do *not* share INTx
> interrupts, etc...
> 
> > Is space from pciec dynamically assigned to pcie1, pcie2, etc?  If
> > so, I assume there are more restrictions on the size and alignment
> > than on PCI bridge windows, which allow size/alignment down to
> > 1MB?
> 
> Yes, exactly. I do not know now all restrictions. At least there are
> fixed number of memory slots and each has to be of size 2^N. They
> are dynamically assigned by kernel mbus driver at time when somebody
> updates BASE/LIMIT registers. And that kernel mbus driver takes care
> to split non-aligned window size to more slots of size 2^N. And
> resources are shared from pool with other HW parts (e.g. DMA), so
> other drivers loaded in kernel can "eat" available slots before
> pci-mvebu and then there does not have to be nothing to allocate for
> PCI.

So IIUC,

  pcie1 == 00:01.0 Root Port
  pcie2 == 00:02.0 Root Port
  pcie3 == 00:03.0 Root Port

From a software point of view, they're all under a single host bridge,
and Linux assumes everything under a host bridge plays by the PCI
rules.

In this case, the root ports *don't* play by the rules since they have
additional alignment restrictions, so I think these really should be
described as separate host bridges in DT with the address space
carved up statically among them.

It's common on x86 to have multiple host bridges that all appear to
software to be in domain 0000.  The bus number ranges under each are
static, e.g., one bridge has [bus 00-7f] and another has [bus 80-ff].

> But most Armada boards do not have exported all peripherals from SoC,
> unconnected are disabled in DT and therefore exhaustion should not
> happen.
> 
> > I'm trying to see how this could be described in ACPI because that's a
> > fairly general model that accommodates most machines.  Possibly
> > describing mvebu in ACPI would involve losing some flexibility.
> 
> I do not understand APCI model very well and I'm in impression that it
> is impossible to represent mvebu in ACPI.

It could be described as a separate host bridge for every root port.
ACPI uses _CRS (current resource settings) to describe the apertures
to PCI and any address translation.  Currently the _CRS description is
static, but ACPI does allow those resource assignments to be modified
via _PRS (possible resource settings) and _SRS (set resource
settings).

Bjorn
