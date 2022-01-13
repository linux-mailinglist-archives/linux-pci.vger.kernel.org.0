Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0C4248D5D4
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jan 2022 11:35:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbiAMKf2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jan 2022 05:35:28 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:49082 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbiAMKf1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Jan 2022 05:35:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C03D61C22;
        Thu, 13 Jan 2022 10:35:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63F35C36AE3;
        Thu, 13 Jan 2022 10:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642070126;
        bh=QDMrVNPg2KIzF3PgrdItUahPo6vyE5QcAuk75W6xmFw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JJcZ2G8it9sh0VZckhQSMHllghDZjkkhutHnNnrAXdEZ6mgm/RkzqaggMhUrl8yRh
         Vq9UlOkmKYpRwapcY0LcNHogAwXC4uf3p0qDcfdzt6+EacRXq+3iUCP63e925l+/t+
         gyA0Pw5CMLkfzhZwAIb93n2Q1ONB82tSj12/wzlvCsMhm+nzkIo+MrV+xGzVVv6lmi
         aTCIZXMGU1tksyprbHTWRCO7WCkseV/PUIpNVf0P+EcD+lSe637DSMrBwbIipzTkm9
         YKZeBMyycpN0AzLusfsRZdJh17uE6/+z8BBKOUyjbl0O8Bb0NBN410OG50hDzicasM
         TMj1NLojcGakw==
Received: by pali.im (Postfix)
        id 95B8C732; Thu, 13 Jan 2022 11:35:23 +0100 (CET)
Date:   Thu, 13 Jan 2022 11:35:23 +0100
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
Message-ID: <20220113103523.5usmja7bp44f7ju7@pali>
References: <20220107234658.oav7oofcbwa7o6sz@pali>
 <20220113001921.GA286275@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220113001921.GA286275@bhelgaas>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wednesday 12 January 2022 18:19:21 Bjorn Helgaas wrote:
> On Sat, Jan 08, 2022 at 12:46:58AM +0100, Pali Rohár wrote:
> > On Friday 07 January 2022 17:16:17 Bjorn Helgaas wrote:
> > > On Fri, Jan 07, 2022 at 11:28:26PM +0100, Pali Rohár wrote:
> > > > On Friday 07 January 2022 15:55:04 Bjorn Helgaas wrote:
> > > > > On Thu, Nov 25, 2021 at 01:45:58PM +0100, Pali Rohár wrote:
> > > > > > Properly propagate failure from mvebu_pcie_add_windows() function back to
> > > > > > the caller mvebu_pci_bridge_emul_base_conf_write() and correctly updates
> > > > > > PCI_IO_BASE, PCI_MEM_BASE and PCI_IO_BASE_UPPER16 registers on error.
> > > > > > On error set base value higher than limit value which indicates that
> > > > > > address range is disabled. 
> > > > > 
> > > > > Does the spec say that if software programs something invalid,
> > > > > hardware should proactively set the base and limit registers to
> > > > > disable the window?
> > > > 
> > > > No. But this patch address something totally different. Software can do
> > > > fully valid operation, e.g. try to set forwarding memory window as large
> > > > as possible. But because this driver "emulates" pci bridge by calling
> > > > software/kernel function (mvebu_pcie_add_windows), some operations which
> > > > in real HW cannot happen, are possible in software.
> > > > 
> > > > For example there are limitations in sizes of forwarding memory windows,
> > > > because it is done by mvebu-mbus driver, which is responsible for
> > > > configuring mapping and forwarding of PCIe I/O and MEM windows. And due
> > > > to Marvell HW, there are restrictions which are not in PCIe HW.
> > > > 
> > > > Currently if such error happens, obviously kernel is not able to set
> > > > PCIe windows and it just print warnings to dmesg. Trying to access these
> > > > windows would result in the worst case in crashes.
> > > > 
> > > > With this change when mvebu_pcie_add_windows() function fails then into
> > > > emulated config space is put information that particular forwarding
> > > > window is disabled. I think that it is better to indicate it in config
> > > > space what is the current "reality" of hardware configuration. If window
> > > > is disabled in real-HW (meaning in mvebu-mbus driver) then show it also
> > > > in emulated config space of pci bridge.
> > > > 
> > > > Do you have better idea what should emulated pci bridge do, if software
> > > > try to set fully valid configuration of forwarding window, but it is not
> > > > possible to achieve it (even compliant PCI bridge must be able to do
> > > > it)?
> > > 
> > > On an ACPI system, the host bridge window sizes are constrained by the
> > > host bridge _CRS method.  I assume there's a similar constraint in DT.
> > > 
> > > Is the fact that mvebu_pcie_add_windows() can fail a symptom of a DT
> > > that describes more available space than mvebu-bus can map?
> > 
> > Memory maps for mvebu are more complicated. There is no explicit size in
> > DT ranges property as it is dynamically allocated by mvebu-mbus:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/armada-385.dtsi?h=v5.15#n47
> 
> I wish I knew how to really interpret those "ranges" properties.  (Is
> there a good description in Documentation/ somewhere?  All I've found
> so far is https://elinux.org/Device_Tree_Usage, which is good, but
> doesn't match this example completely.)
> 
> I see:
> 
>   pciec: pcie {
>     ranges = <...>;
>     pcie1: pcie@1,0 {
>       ranges = <0x82000000 0 0 0x82000000 0x1 0 1 0
> 	        0x81000000 0 0 0x81000000 0x1 0 1 0>;
>     };
>     pcie2: pcie@2,0 {
>       ranges = <0x82000000 0 0 0x82000000 0x2 0 1 0
> 	        0x81000000 0 0 0x81000000 0x2 0 1 0>;
>     };
>     pcie3: pcie@3,0 {
>       ranges = <0x82000000 0 0 0x82000000 0x3 0 1 0
> 	        0x81000000 0 0 0x81000000 0x3 0 1 0>;
>     };
>     pcie4: pcie@4,0 {
>       ranges = <0x82000000 0 0 0x82000000 0x4 0 1 0
> 	        0x81000000 0 0 0x81000000 0x4 0 1 0>;
>     };
>   };
> 
> What does this look like in dmesg, i.e., what CPU address ranges are
> mapped to what PCI bus addresses?

These explicit ranges in DT are probably ignored as they are invalid.
You can see them (0xffffffffffffffff) in dmesg. MEM and I/O resources
are parsed in pci-mvebu.c driver in mvebu_pcie_parse_request_resources()
function.

Here is relevant dmesg output:

[    0.671607] mvebu-pcie soc:pcie: host bridge /soc/pcie ranges:
[    0.677474] mvebu-pcie soc:pcie:      MEM 0x00f1080000..0x00f1081fff -> 0x0000080000
[    0.685245] mvebu-pcie soc:pcie:      MEM 0x00f1040000..0x00f1041fff -> 0x0000040000
[    0.693017] mvebu-pcie soc:pcie:      MEM 0x00f1044000..0x00f1045fff -> 0x0000044000
[    0.700788] mvebu-pcie soc:pcie:      MEM 0x00f1048000..0x00f1049fff -> 0x0000048000
[    0.708562] mvebu-pcie soc:pcie:      MEM 0xffffffffffffffff..0x00fffffffe -> 0x0100000000
[    0.716856] mvebu-pcie soc:pcie:       IO 0xffffffffffffffff..0x00fffffffe -> 0x0100000000
[    0.725146] mvebu-pcie soc:pcie:      MEM 0xffffffffffffffff..0x00fffffffe -> 0x0200000000
[    0.733438] mvebu-pcie soc:pcie:       IO 0xffffffffffffffff..0x00fffffffe -> 0x0200000000
[    0.741730] mvebu-pcie soc:pcie:      MEM 0xffffffffffffffff..0x00fffffffe -> 0x0300000000
[    0.750022] mvebu-pcie soc:pcie:       IO 0xffffffffffffffff..0x00fffffffe -> 0x0300000000
[    0.758314] mvebu-pcie soc:pcie:      MEM 0xffffffffffffffff..0x00fffffffe -> 0x0400000000
[    0.766606] mvebu-pcie soc:pcie:       IO 0xffffffffffffffff..0x00fffffffe -> 0x0400000000
[    0.907763] mvebu-pcie soc:pcie: PCI host bridge to bus 0000:00
[    0.913698] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.919203] pci_bus 0000:00: root bus resource [mem 0xf1080000-0xf1081fff] (bus address [0x00080000-0x00081fff])
[    0.929406] pci_bus 0000:00: root bus resource [mem 0xf1040000-0xf1041fff] (bus address [0x00040000-0x00041fff])
[    0.939608] pci_bus 0000:00: root bus resource [mem 0xf1044000-0xf1045fff] (bus address [0x00044000-0x00045fff])
[    0.949812] pci_bus 0000:00: root bus resource [mem 0xf1048000-0xf1049fff] (bus address [0x00048000-0x00049fff])
[    0.960014] pci_bus 0000:00: root bus resource [mem 0xe0000000-0xe7ffffff]
[    0.966908] pci_bus 0000:00: root bus resource [io  0x1000-0xeffff]
[    0.973261] pci 0000:00:01.0: [11ab:6820] type 01 class 0x060400
[    0.979458] pci 0000:00:02.0: [11ab:6820] type 01 class 0x060400
[    0.985643] pci 0000:00:03.0: [11ab:6820] type 01 class 0x060400
[    0.992482] PCI: bus0: Fast back to back transfers disabled
[    0.998075] pci 0000:00:01.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[    1.006108] pci 0000:00:02.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[    1.014134] pci 0000:00:03.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[    1.022242] pci 0000:01:00.0: [1e0f:0001] type 00 class 0x010802
[    1.028289] pci 0000:01:00.0: reg 0x10: [mem 0xc0000000-0xc0003fff 64bit]
[    1.035233] pci 0000:01:00.0: PME# supported from D0 D3hot
[    1.040787] pci 0000:01:00.0: 2.000 Gb/s available PCIe bandwidth, limited by 2.5 GT/s PCIe x1 link at 0000:00:01.0 (capable of 31.504 Gb/s with 8.0 GT/s PCIe x4 link)
[    1.056630] PCI: bus1: Fast back to back transfers disabled
[    1.062217] pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
[    1.068935] pci 0000:02:00.0: [168c:003c] type 00 class 0x028000
[    1.074975] pci 0000:02:00.0: reg 0x10: [mem 0xc8000000-0xc81fffff 64bit]
[    1.081817] pci 0000:02:00.0: reg 0x30: [mem 0xc8200000-0xc820ffff pref]
[    1.088611] pci 0000:02:00.0: supports D1 D2
[    1.093765] PCI: bus2: Fast back to back transfers disabled
[    1.099356] pci_bus 0000:02: busn_res: [bus 02-ff] end is updated to 02
[    1.106070] pci 0000:03:00.0: [168c:002e] type 00 class 0x028000
[    1.112110] pci 0000:03:00.0: reg 0x10: [mem 0xd0000000-0xd000ffff 64bit]
[    1.119031] pci 0000:03:00.0: supports D1
[    1.123049] pci 0000:03:00.0: PME# supported from D0 D1 D3hot
[    1.129688] PCI: bus3: Fast back to back transfers disabled
[    1.135274] pci_bus 0000:03: busn_res: [bus 03-ff] end is updated to 03
[    1.141926] pci 0000:00:01.0: BAR 8: assigned [mem 0xe0000000-0xe00fffff]
[    1.148738] pci 0000:00:02.0: BAR 8: assigned [mem 0xe0200000-0xe04fffff]
[    1.155544] pci 0000:00:03.0: BAR 8: assigned [mem 0xe0100000-0xe01fffff]
[    1.162357] pci 0000:01:00.0: BAR 0: assigned [mem 0xe0000000-0xe0003fff 64bit]
[    1.169696] pci 0000:00:01.0: PCI bridge to [bus 01]
[    1.174674] pci 0000:00:01.0:   bridge window [mem 0xe0000000-0xe00fffff]
[    1.181490] pci 0000:02:00.0: BAR 0: assigned [mem 0xe0200000-0xe03fffff 64bit]
[    1.188830] pci 0000:02:00.0: BAR 6: assigned [mem 0xe0400000-0xe040ffff pref]
[    1.196074] pci 0000:00:02.0: PCI bridge to [bus 02]
[    1.201050] pci 0000:00:02.0:   bridge window [mem 0xe0200000-0xe04fffff]
[    1.207867] pci 0000:03:00.0: BAR 0: assigned [mem 0xe0100000-0xe010ffff 64bit]
[    1.215200] pci 0000:00:03.0: PCI bridge to [bus 03]
[    1.220179] pci 0000:00:03.0:   bridge window [mem 0xe0100000-0xe01fffff]
[    1.227028] pcieport 0000:00:01.0: enabling device (0140 -> 0142)
[    1.233186] pcieport 0000:00:02.0: enabling device (0140 -> 0142)
[    1.239339] pcieport 0000:00:03.0: enabling device (0140 -> 0142)

And some more information from /proc:

$ cat /proc/ioports
00001000-000effff : PCI I/O

$ cat /proc/iomem
...
e0000000-e7ffffff : PCI MEM
  e0000000-e00fffff : PCI Bus 0000:01
    e0000000-e0003fff : 0000:01:00.0
      e0000000-e0003fff : nvme
  e0100000-e01fffff : PCI Bus 0000:03
    e0100000-e010ffff : 0000:03:00.0
      e0100000-e010ffff : ath9k
  e0200000-e04fffff : PCI Bus 0000:02
    e0200000-e03fffff : 0000:02:00.0
      e0200000-e03fffff : ath
    e0400000-e040ffff : 0000:02:00.0
...

> Are pcie1, pcie2, etc Root Ports?  Or are they each separate host
> bridges (they each have "bus-range = <0x00 0xff>")?

From kernel point of view they are root ports. But in reality every of
these root port is on separate bus segment, but kernel pci-mvebu.c
driver merges all these segments/domains into one host bridge and put
all root ports into bus 0.

Here is lspci -tvnn output with topology:

$ lspci -tvnn
-[0000:00]-+-01.0-[01]----00.0  Device [1e0f:0001]
           +-02.0-[02]----00.0  Qualcomm Atheros QCA986x/988x 802.11ac Wireless Network Adapter [168c:003c]
           \-03.0-[03]----00.0  Qualcomm Atheros AR9287 Wireless Network Adapter (PCI-Express) [168c:002e]

And without topology:

$ lspci -nn
00:01.0 PCI bridge [0604]: Marvell Technology Group Ltd. Device [11ab:6820] (rev 04)
00:02.0 PCI bridge [0604]: Marvell Technology Group Ltd. Device [11ab:6820] (rev 04)
00:03.0 PCI bridge [0604]: Marvell Technology Group Ltd. Device [11ab:6820] (rev 04)
01:00.0 Non-Volatile memory controller [0108]: Device [1e0f:0001]
02:00.0 Network controller [0280]: Qualcomm Atheros QCA986x/988x 802.11ac Wireless Network Adapter [168c:003c]
03:00.0 Network controller [0280]: Qualcomm Atheros AR9287 Wireless Network Adapter (PCI-Express) [168c:002e] (rev 01)

Buses 1, 2 and 3 represents mPCIe cards, all of them are in reality in
separate bus segments and on different HW host bridges. So they do *not*
share access to config space, do *not* share INTx interrupts, etc...

> Is space from pciec dynamically assigned to pcie1, pcie2, etc?  If so,
> I assume there are more restrictions on the size and alignment than on
> PCI bridge windows, which allow size/alignment down to 1MB?

Yes, exactly. I do not know now all restrictions. At least there are
fixed number of memory slots and each has to be of size 2^N. They are
dynamically assigned by kernel mbus driver at time when somebody updates
BASE/LIMIT registers. And that kernel mbus driver takes care to split
non-aligned window size to more slots of size 2^N. And resources are
shared from pool with other HW parts (e.g. DMA), so other drivers loaded
in kernel can "eat" available slots before pci-mvebu and then there does
not have to be nothing to allocate for PCI.

But most Armada boards do not have exported all peripherals from SoC,
unconnected are disabled in DT and therefore exhaustion should not
happen.

> I'm trying to see how this could be described in ACPI because that's a
> fairly general model that accommodates most machines.  Possibly
> describing mvebu in ACPI would involve losing some flexibility.
> 
> Bjorn

I do not understand APCI model very well and I'm in impression that it
is impossible to represent mvebu in ACPI.
