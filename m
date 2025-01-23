Return-Path: <linux-pci+bounces-20302-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE60A1AA0F
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jan 2025 20:11:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C6E03AF0CA
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jan 2025 19:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37BBF1ADC6B;
	Thu, 23 Jan 2025 19:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WohXPFKF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3421154C07;
	Thu, 23 Jan 2025 19:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737659343; cv=none; b=dy2vITCkmUmMAIMd2NVY2lxXqF16cRgnufLw6eYIivsdmMbsrrPJJgjuzH6YdvcyV5yylJ7/HmwDSfnMfZJ98FqHuJJp9RZRyHcsW6kibDEhlmtw+aR7rsBmnq+VPS/YLl1jqMnS6dtGmC3s/Wk0zWVXwdktHbsYX/L9Tm6Nm3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737659343; c=relaxed/simple;
	bh=WH2DJ4BEBlNLbA2coNb0HddUVvUqYcHSB/3fhwSTX9k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=osMOovWzW6OFScOSl2wu/+ioKKhuPDmLFNt0U7rohuLjV+Au6S+V0YihuIKQ/38QXpaE5SGV0sx7MmOJ5Ptg20oEGV/I0ctxZ1w/O33oQ+ENJrmYncJEEZ4oAoEImXDARGxpDLPww3w/KsR8XN+3C95h7jakZxt7Eb3lDwD3Duo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WohXPFKF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C741C4CED3;
	Thu, 23 Jan 2025 19:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737659342;
	bh=WH2DJ4BEBlNLbA2coNb0HddUVvUqYcHSB/3fhwSTX9k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=WohXPFKFQexpckktRb67WILJ64m0tz1f0kGEFTGTuY5/ekMHI2ifgaNaTyH+4KH7d
	 KhJI/qsm/pERvKGrcPT51PGvDl1rdo+fwW+8Jo7QKXc7rRJAEizgGmODdIhqr7wf9H
	 BDs4s4U9nLK5wCVrsinpMqtg8jGZTDVZaxqkLJmzZ8ORtvYOErx6Ik1JoFNKWasum8
	 rbokLW5afWomcKiXCqE/OPi8Q3zd/Jg5G+AYienXDjehuiBGnSJrxjbYPm3Vak8IHO
	 Fbghr1ZUj8I7kDIaR6O88p39DAeEPVLtnUmKfEaQWm0bLVRs78fXCxJWG8ZgrOB5FH
	 T7nAFTxP1cxcA==
Date: Thu, 23 Jan 2025 13:09:00 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev
Subject: Re: [PATCH v8 2/7] PCI: dwc: Use devicetree 'ranges' property to get
 rid of cpu_addr_fixup() callback
Message-ID: <20250123190900.GA650360@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z4p6bekWQ7t7ZDS8@lizhi-Precision-Tower-5810>

On Fri, Jan 17, 2025 at 10:42:37AM -0500, Frank Li wrote:
> On Thu, Jan 16, 2025 at 05:29:16PM -0600, Bjorn Helgaas wrote:
> > On Thu, Jan 16, 2025 at 05:14:00PM -0600, Bjorn Helgaas wrote:
> > > On Tue, Nov 19, 2024 at 02:44:20PM -0500, Frank Li wrote:
> > > > parent_bus_addr in struct of_range can indicate address information just
> > > > ahead of PCIe controller. Most system's bus fabric use 1:1 map between
> > > > input and output address. but some hardware like i.MX8QXP doesn't use 1:1
> > > > map. See below diagram:
> > > >
> > > >             ┌─────────┐                    ┌────────────┐
> > > >  ┌─────┐    │         │ IA: 0x8ff8_0000    │            │
> > > >  │ CPU ├───►│   ┌────►├─────────────────┐  │ PCI        │
> > > >  └─────┘    │   │     │ IA: 0x8ff0_0000 │  │            │
> > > >   CPU Addr  │   │  ┌─►├─────────────┐   │  │ Controller │
> > > > 0x7ff8_0000─┼───┘  │  │             │   │  │            │
> > > >             │      │  │             │   │  │            │   PCI Addr
> > > > 0x7ff0_0000─┼──────┘  │             │   └──► IOSpace   ─┼────────────►
> > > >             │         │             │      │            │    0
> > > > 0x7000_0000─┼────────►├─────────┐   │      │            │
> > > >             └─────────┘         │   └──────► CfgSpace  ─┼────────────►
> > > >              BUS Fabric         │          │            │    0
> > > >                                 │          │            │
> > > >                                 └──────────► MemSpace  ─┼────────────►
> > > >                         IA: 0x8000_0000    │            │  0x8000_0000
> > > >                                            └────────────┘
> > > >
> > > > bus@5f000000 {
> > > > 	compatible = "simple-bus";
> > > > 	#address-cells = <1>;
> > > > 	#size-cells = <1>;
> > > > 	ranges = <0x80000000 0x0 0x70000000 0x10000000>;
> > > >
> > > > 	pcie@5f010000 {
> > > > 		compatible = "fsl,imx8q-pcie";
> > > > 		reg = <0x5f010000 0x10000>, <0x8ff00000 0x80000>;
> > > > 		reg-names = "dbi", "config";
> > > > 		#address-cells = <3>;
> > > > 		#size-cells = <2>;
> > > > 		device_type = "pci";
> > > > 		bus-range = <0x00 0xff>;
> > > > 		ranges = <0x81000000 0 0x00000000 0x8ff80000 0 0x00010000>,
> > > > 			 <0x82000000 0 0x80000000 0x80000000 0 0x0ff00000>;
> > > > 	...
> > > > 	};
> > > > };
> > > >
> > > > Term internal address (IA) here means the address just before PCIe
> > > > controller. After ATU use this IA instead CPU address, cpu_addr_fixup() can
> > > > be removed.
> > >
> > > > @@ -730,9 +779,15 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
> > > >
> > > >  		atu.index = i;
> > > >  		atu.type = PCIE_ATU_TYPE_MEM;
> > > > -		atu.cpu_addr = entry->res->start;
> > > > +		parent_bus_addr = entry->res->start;
> > > >  		atu.pci_addr = entry->res->start - entry->offset;
> > > >
> > > > +		ret = dw_pcie_get_parent_addr(pci, entry->res->start, &parent_bus_addr);
> > > > +		if (ret)
> > > > +			return ret;
> > > > +
> > > > +		atu.cpu_addr = parent_bus_addr;
> > >
> > > Here you set atu.cpu_addr to the intermediate bus address instead
> > > of the CPU physical address before calling
> > > dw_pcie_prog_outbound_atu().
> > >
> > > But what about other callers of dw_pcie_prog_outbound_atu()?  Don't
> > > all of them need to use the intermediate bus address?
> 
> All should use "intermediate bus address", RC side only call it here. EP
> side is here
> https://lore.kernel.org/imx/Z4p0fUAK1ONNjLst@lizhi-Precision-Tower-5810/T/#t

Currently dw_pcie_prog_outbound_atu() uses atu->cpu_addr, calls
ops->cpu_addr_fixup() if defined, and writes cpu_addr to
PCIE_ATU_LOWER_BASE/PCIE_ATU_UPPER_BASE.

The callers of dw_pcie_prog_outbound_atu() I see are:

  dw_pcie_ep_outbound_atu
    atu.cpu_addr came from dw_pcie_ep_map_addr(), so it's a CPU
    address.  Fixed by [1], which reads ep->bus_addr_base from the
    "addr_space" 'reg' property.

  dw_pcie_other_conf_map_bus
    atu.cpu_addr came from pp->cfg0_base, set by dw_pcie_host_init()
    to a CPU address (the "config" resource).  Fixed by [2], which
    overwrites pp->cfg0_base with the address from the "config" 'reg'
    property if 'use_parent_dt_ranges' is set.

  dw_pcie_rd_other_conf
  dw_pcie_wr_other_conf
    dw_pcie_prog_outbound_atu() only called if pp->cfg0_io_shared,
    after an ECAM map via dw_pcie_other_conf_map_bus() and subsequent
    successful access; atu.cpu_addr came from pp->io_base, set by
    dw_pcie_host_init() from pci_pio_to_address(), which I'm pretty
    sure returns a CPU address.

    So this still looks wrong to me.  In addition, I think doing the
    ATU setup in *_map() and restore in *rd/wr_other_conf() is ugly
    and looks unreliable.

  dw_pcie_iatu_setup
    atu.cpu_addr came from the struct resource in pp->bridge->windows,
    so it's a CPU address.  Also fixed by [2], which overwrites
    atu.cpu_addr with the address from dw_pcie_get_parent_addr(), which
    iterates through the PCI controller's 'ranges' property and
    returns the range.parent_bus_addr.

  dw_pcie_pme_turn_off
    atu.cpu_addr came from pp.msg_res, set by
    dw_pcie_host_request_msg_tlp_res() to a CPU address at the end of
    the first MMIO bridge window.  This one also looks wrong to me.

[1] https://lore.kernel.org/r/20241119-pci_fixup_addr-v8-3-c4bfa5193288@nxp.com
[2] https://lore.kernel.org/r/20241119-pci_fixup_addr-v8-2-c4bfa5193288@nxp.com

> > Since dw_pcie_prog_outbound_atu() is the only dwc caller, maybe the
> > parent_bus_addr change should go *there* instead of in the callers?
> 
> I am not sure I understand your means.
> 
> EP and RC parts need call dw_pcie_prog_outbound_atu(). EP and RC use
> difference method to get outbound windows information. So can't move it
> into dw_pcie_prog_outbound_atu().

Yes, I think I see what you mean.  In the Endpoint case, the iATU
input comes from the "addr_space" 'reg' property.  In the Root Complex
case, it comes from the parent bus address of the 'ranges' property.

Bjorn

