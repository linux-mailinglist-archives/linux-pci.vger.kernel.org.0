Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0DA48CF9B
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jan 2022 01:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbiAMATZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Jan 2022 19:19:25 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:44616 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiAMATY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Jan 2022 19:19:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 061FD61B86;
        Thu, 13 Jan 2022 00:19:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DFFBC36AE5;
        Thu, 13 Jan 2022 00:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642033163;
        bh=3kfpqCE7Qm+50A9vsc5KvsoidFP/uN6v2CojK15+/Rc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=QkdkBxP8Ai/Y+QA77IIkt0TIXVFnZ//CpJfCzHWE1bRh40o4Lu33wI9ou/5Zg78s+
         4N2S/u6xFIS5qvihR2y7U7jagW9wU4J01oUxoTM0k8zUtcjCOTnPr08SRWKMWCQvqo
         q8pD2/5gqbqaVNmoxsBtKDubk5UhtSaQGCSbLRKIGGXr7Ftkfrz9dhqEkY4A4CGtFa
         u9CE5X0VB+2GMcewZM7qeUvntHX5hl3NOYc+UL5GsoUSgw81Jv1KrD3cGiXYDaZ6qQ
         bxVriyBuUkJWlG/jlCOaPUFY1Rtnz1bTTDdOnkpuqxMB4T6Piuk6yBNOb+DHZ2jvOq
         ugGxH2+BykPyA==
Date:   Wed, 12 Jan 2022 18:19:21 -0600
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
Message-ID: <20220113001921.GA286275@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220107234658.oav7oofcbwa7o6sz@pali>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Jan 08, 2022 at 12:46:58AM +0100, Pali Rohár wrote:
> On Friday 07 January 2022 17:16:17 Bjorn Helgaas wrote:
> > On Fri, Jan 07, 2022 at 11:28:26PM +0100, Pali Rohár wrote:
> > > On Friday 07 January 2022 15:55:04 Bjorn Helgaas wrote:
> > > > On Thu, Nov 25, 2021 at 01:45:58PM +0100, Pali Rohár wrote:
> > > > > Properly propagate failure from mvebu_pcie_add_windows() function back to
> > > > > the caller mvebu_pci_bridge_emul_base_conf_write() and correctly updates
> > > > > PCI_IO_BASE, PCI_MEM_BASE and PCI_IO_BASE_UPPER16 registers on error.
> > > > > On error set base value higher than limit value which indicates that
> > > > > address range is disabled. 
> > > > 
> > > > Does the spec say that if software programs something invalid,
> > > > hardware should proactively set the base and limit registers to
> > > > disable the window?
> > > 
> > > No. But this patch address something totally different. Software can do
> > > fully valid operation, e.g. try to set forwarding memory window as large
> > > as possible. But because this driver "emulates" pci bridge by calling
> > > software/kernel function (mvebu_pcie_add_windows), some operations which
> > > in real HW cannot happen, are possible in software.
> > > 
> > > For example there are limitations in sizes of forwarding memory windows,
> > > because it is done by mvebu-mbus driver, which is responsible for
> > > configuring mapping and forwarding of PCIe I/O and MEM windows. And due
> > > to Marvell HW, there are restrictions which are not in PCIe HW.
> > > 
> > > Currently if such error happens, obviously kernel is not able to set
> > > PCIe windows and it just print warnings to dmesg. Trying to access these
> > > windows would result in the worst case in crashes.
> > > 
> > > With this change when mvebu_pcie_add_windows() function fails then into
> > > emulated config space is put information that particular forwarding
> > > window is disabled. I think that it is better to indicate it in config
> > > space what is the current "reality" of hardware configuration. If window
> > > is disabled in real-HW (meaning in mvebu-mbus driver) then show it also
> > > in emulated config space of pci bridge.
> > > 
> > > Do you have better idea what should emulated pci bridge do, if software
> > > try to set fully valid configuration of forwarding window, but it is not
> > > possible to achieve it (even compliant PCI bridge must be able to do
> > > it)?
> > 
> > On an ACPI system, the host bridge window sizes are constrained by the
> > host bridge _CRS method.  I assume there's a similar constraint in DT.
> > 
> > Is the fact that mvebu_pcie_add_windows() can fail a symptom of a DT
> > that describes more available space than mvebu-bus can map?
> 
> Memory maps for mvebu are more complicated. There is no explicit size in
> DT ranges property as it is dynamically allocated by mvebu-mbus:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/armada-385.dtsi?h=v5.15#n47

I wish I knew how to really interpret those "ranges" properties.  (Is
there a good description in Documentation/ somewhere?  All I've found
so far is https://elinux.org/Device_Tree_Usage, which is good, but
doesn't match this example completely.)

I see:

  pciec: pcie {
    ranges = <...>;
    pcie1: pcie@1,0 {
      ranges = <0x82000000 0 0 0x82000000 0x1 0 1 0
	        0x81000000 0 0 0x81000000 0x1 0 1 0>;
    };
    pcie2: pcie@2,0 {
      ranges = <0x82000000 0 0 0x82000000 0x2 0 1 0
	        0x81000000 0 0 0x81000000 0x2 0 1 0>;
    };
    pcie3: pcie@3,0 {
      ranges = <0x82000000 0 0 0x82000000 0x3 0 1 0
	        0x81000000 0 0 0x81000000 0x3 0 1 0>;
    };
    pcie4: pcie@4,0 {
      ranges = <0x82000000 0 0 0x82000000 0x4 0 1 0
	        0x81000000 0 0 0x81000000 0x4 0 1 0>;
    };
  };

What does this look like in dmesg, i.e., what CPU address ranges are
mapped to what PCI bus addresses?

Are pcie1, pcie2, etc Root Ports?  Or are they each separate host
bridges (they each have "bus-range = <0x00 0xff>")?

Is space from pciec dynamically assigned to pcie1, pcie2, etc?  If so,
I assume there are more restrictions on the size and alignment than on
PCI bridge windows, which allow size/alignment down to 1MB?

I'm trying to see how this could be described in ACPI because that's a
fairly general model that accommodates most machines.  Possibly
describing mvebu in ACPI would involve losing some flexibility.

Bjorn
