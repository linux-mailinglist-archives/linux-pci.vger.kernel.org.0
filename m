Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B46D8487F8F
	for <lists+linux-pci@lfdr.de>; Sat,  8 Jan 2022 00:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbiAGXrC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Jan 2022 18:47:02 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:60618 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231633AbiAGXrC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Jan 2022 18:47:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 38DE262048;
        Fri,  7 Jan 2022 23:47:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D548C36AE5;
        Fri,  7 Jan 2022 23:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641599221;
        bh=8yzH1eGlGAjz6zbFUbD+y6NOn31nJQ7Ps9uc6DFXW1Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aO+p91zr0MTNP07nAth5LJgil1dBypuuw71aPYH5o2lMYugTZlq5TKlw5M+xSioYT
         HGs4g0y4SoCqZgay1LXNDgMEf41vaAuoOjK6Zn06CGj7FrGJhnauB5j8nyolJ77qV6
         mTXND0AI5BxPNYDXzXuQ0NFAKNg2fr7XaTyAfQI4UTBjWPy8uzEytGwe8hQO4+5WN+
         CU8poLMe13vLj5hwRVdJorZriYW8scz2+pnIlflflk4f9BqeQkeoEyYJpMV22PSV5l
         Bx6gOj9YuAqzuA1RH27tgn9Muhw16Q6AzbAi15yIkgj32XxLOdWd2zoW8g6YxazlDr
         hlZ5afBK5Z1BA==
Received: by pali.im (Postfix)
        id C062DB22; Sat,  8 Jan 2022 00:46:58 +0100 (CET)
Date:   Sat, 8 Jan 2022 00:46:58 +0100
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
Message-ID: <20220107234658.oav7oofcbwa7o6sz@pali>
References: <20220107222826.cv2bzywwayjwzy3c@pali>
 <20220107231617.GA425878@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220107231617.GA425878@bhelgaas>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Friday 07 January 2022 17:16:17 Bjorn Helgaas wrote:
> On Fri, Jan 07, 2022 at 11:28:26PM +0100, Pali Rohár wrote:
> > On Friday 07 January 2022 15:55:04 Bjorn Helgaas wrote:
> > > On Thu, Nov 25, 2021 at 01:45:58PM +0100, Pali Rohár wrote:
> > > > Properly propagate failure from mvebu_pcie_add_windows() function back to
> > > > the caller mvebu_pci_bridge_emul_base_conf_write() and correctly updates
> > > > PCI_IO_BASE, PCI_MEM_BASE and PCI_IO_BASE_UPPER16 registers on error.
> > > > On error set base value higher than limit value which indicates that
> > > > address range is disabled. 
> > > 
> > > Does the spec say that if software programs something invalid,
> > > hardware should proactively set the base and limit registers to
> > > disable the window?
> > 
> > No. But this patch address something totally different. Software can do
> > fully valid operation, e.g. try to set forwarding memory window as large
> > as possible. But because this driver "emulates" pci bridge by calling
> > software/kernel function (mvebu_pcie_add_windows), some operations which
> > in real HW cannot happen, are possible in software.
> > 
> > For example there are limitations in sizes of forwarding memory windows,
> > because it is done by mvebu-mbus driver, which is responsible for
> > configuring mapping and forwarding of PCIe I/O and MEM windows. And due
> > to Marvell HW, there are restrictions which are not in PCIe HW.
> > 
> > Currently if such error happens, obviously kernel is not able to set
> > PCIe windows and it just print warnings to dmesg. Trying to access these
> > windows would result in the worst case in crashes.
> > 
> > With this change when mvebu_pcie_add_windows() function fails then into
> > emulated config space is put information that particular forwarding
> > window is disabled. I think that it is better to indicate it in config
> > space what is the current "reality" of hardware configuration. If window
> > is disabled in real-HW (meaning in mvebu-mbus driver) then show it also
> > in emulated config space of pci bridge.
> > 
> > Do you have better idea what should emulated pci bridge do, if software
> > try to set fully valid configuration of forwarding window, but it is not
> > possible to achieve it (even compliant PCI bridge must be able to do
> > it)?
> 
> On an ACPI system, the host bridge window sizes are constrained by the
> host bridge _CRS method.  I assume there's a similar constraint in DT.
> 
> Is the fact that mvebu_pcie_add_windows() can fail a symptom of a DT
> that describes more available space than mvebu-bus can map?

Memory maps for mvebu are more complicated. There is no explicit size in
DT ranges property as it is dynamically allocated by mvebu-mbus:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/armada-385.dtsi?h=v5.15#n47

On some Armada platform (I think it is AXP) there is lot of SerDeses
with PCIe functionality (I think six or seven?) but "shared memory pool"
which mvebu-mbus allocates to consumers is not big enough to allow e.g.
256 MB + 64 kB for every PCIe port.

There is upper limit of mvebu memory slots in HW and each slot has size
restrictions. So mvebu-mbus has to deal with splitting requested
PCIe window to more mvebu memory slots... So even if there is available
memory for assigning then there does not have to be a free slot.

Due to nature of plugable PCIe expansion cards, you are basically free
to put any PCIe card which you like into any PCIe slot. So it would be
up to the user to choose combination of such cards which pass all those
mvebu windows and slots restrictions... Otherwise kernel just say that
cannot satisfy card's BAR assignment because it is not possible to set
forwarding windows correctly.

Moreover it is possible to bind / unbind pci mvebu device dynamically at
runtime (also by rmmod), so whole resource allocation in mvebu-bus is
dynamic even during system runtime. So theoretically user can unbind one
driver to free some memory and then can bind another (which needs more
memory).

I think that this pci-mvebu driver and HW is very unusual in both
resource assignment and supported features and requirements from SW.

> > > I'm not sure I've seen hardware that does this, and it seems ... maybe
> > > a little aggressive.
> > > 
> > > What happens if software writes the base and limit in the wrong order,
> > > so the window is invalid after the first write but valid after the
> > > second?  That actually sounds like it could be a sensible strategy to
> > > prevent a partially-configured window from being active.
> > 
> > Invalid window (limit < base) means that window is disabled. And
> > pci-mvebu.c in its callbacks from pci-bridge-emul.c should correctly
> > handle it and propagates information about disablement to mvebu-mbus
> > driver.
> > 
> > After window is valid again (limit > base) then pci-mvebu.c call
> > mvebu-mbus to setup new mapping.
> 
> Not sure I'm understanding the code correctly.  Here's the sort of
> thing I'm worried about, but maybe this is actually impossible:
> 
> Let's say software writes (0x00, 0xff) to the I/O (base, limit), which
> describes the [io 0x0000-0xffff] window.  If mvebu-mbus can't handle
> that, it looks like you set the (base, limit) to (0xf0, 0x0f), which
> would describe [io 0xf000-0x0fff], which is invalid.
> 
> The software writes 0x40 to the limit, so now we have (0xf0, 0x40), or
> [io 0xf000-0x40ff].  That's still invalid, but software thinks the
> 0x00 it wrote to the base is still there.
> 
> Bjorn

I see. In this situation it does not work correctly.

But is not kernel itself "privileged" to setup forwarding windows?
Because currently kernel does not do it and therefore do we need to care
for it?

Or do you have idea how to handle this kind of situation? Or how to
handle these kinds of errors?
