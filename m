Return-Path: <linux-pci+bounces-22894-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC89A4EC18
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 19:43:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 210C28C1C0D
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 18:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE331297503;
	Tue,  4 Mar 2025 17:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z7CoSsFn"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9F4285408;
	Tue,  4 Mar 2025 17:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741110612; cv=none; b=igP4rAR3rKPk04yiryVZDIheldZc/IwohHLgzfAJN2pMtxwrK4+bdpG+i79okkTh6L0Gbf17DKKJpG8SHq4MWvJ0AOzUySp+7cWtXJMGufDftLasTWX2KIt8zBl6TbS6eJ7YAUdT/tOD6/dTk/zHiJFENJ9x9obS3YCt3SORfEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741110612; c=relaxed/simple;
	bh=RUs05QEUeWMhEa3TyZUPqxN1hhHry9gVbabsRe4U85o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=fS+VLNfXK4dMsiMHdPW1Fru/c8wpxJbOrLgO/D58m0nO8IdmEaWlYscgnU4YN/M5TQk1U3Wr5YJGlNzXuL1tKCJuYw48qXy4+sl93V2cc3gv/51oV+o8LwEdPGkVUmCMS0LwZ6CnBunj642pNsCbpRH3IRM4LQgOgd77EAoh2Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z7CoSsFn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E40C3C4CEE5;
	Tue,  4 Mar 2025 17:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741110612;
	bh=RUs05QEUeWMhEa3TyZUPqxN1hhHry9gVbabsRe4U85o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Z7CoSsFnye2QUmquT+Qifh2gocwU2GPjYNg5Tgh6EdKsBGvQ5RQTnQIAchaiVa9dj
	 ClX9B2KV7SqTuvlGUw5XXYBnXhhZz7vVHJDy1pmTewZwQCUa4cEAGu/94MPtoJ56qN
	 0J3uuDxf4fZ/mICYiUitpINUlxPbXpoIuPqErDJJOy6z1nZSrrV50t5eerukfzD6A2
	 wiBck3nT0zFnRrBfc8GT3osydTQpJ5GGL1M4mBLTN4O/gbklcuPV0x0GUKuU6TGn2H
	 +M1QOtI30Q0la1lQeSSJry6DOlV0Q4n+ox9faV5rOyQdLYRzn9c4axUCOARXB19TeD
	 iYUVDhZ0z1rNg==
Date: Tue, 4 Mar 2025 11:50:10 -0600
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
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v9 3/7] PCI: Add parent_bus_offset to resource_entry
Message-ID: <20250304175010.GA207565@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8YlySM6Xtr0beo1@lizhi-Precision-Tower-5810>

On Mon, Mar 03, 2025 at 04:57:29PM -0500, Frank Li wrote:
> On Wed, Feb 26, 2025 at 06:23:26PM -0600, Bjorn Helgaas wrote:
> > On Tue, Jan 28, 2025 at 05:07:36PM -0500, Frank Li wrote:
> > > Introduce `parent_bus_offset` in `resource_entry` and a new API,
> > > `pci_add_resource_parent_bus_offset()`, to provide necessary information
> > > for PCI controllers with address translation units.
> > >
> > > Typical PCI data flow involves:
> > >   CPU (CPU address) -> Bus Fabric (Intermediate address) ->
> > >   PCI Controller (PCI bus address) -> PCI Bus.
> > >
> > > While most bus fabrics preserve address consistency, some modify addresses
> > > to intermediate values. The `parent_bus_offset` enables PCI controllers to
> > > translate these intermediate addresses correctly to PCI bus addresses.
> > >
> > > Pave the road to remove hardcoded cpu_addr_fixup() and similar patterns in
> > > PCI controller drivers.
> > > ...
> >
> > > +++ b/drivers/pci/of.c
> > > @@ -402,7 +402,17 @@ static int devm_of_pci_get_host_bridge_resources(struct device *dev,
> > >  			res->flags &= ~IORESOURCE_MEM_64;
> > >  		}
> > >
> > > -		pci_add_resource_offset(resources, res,	res->start - range.pci_addr);
> > > +		/*
> > > +		 * IORESOURCE_IO res->start is io space start address.
> > > +		 * IORESOURCE_MEM res->start is cpu start address, which is the
> > > +		 * same as range.cpu_addr.
> > > +		 *
> > > +		 * Use (range.cpu_addr - range.parent_bus_addr) to align both
> > > +		 * IO and MEM's parent_bus_offset always offset to cpu address.
> > > +		 */
> > > +
> > > +		pci_add_resource_parent_bus_offset(resources, res, res->start - range.pci_addr,
> > > +						   range.cpu_addr - range.parent_bus_addr);
> >
> > I don't know exactly where it needs to go, but I think we can call
> > .cpu_addr_fixup() once at startup on the base of the region.  This
> > will tell us the offset that applies to the entire region, i.e.,
> > parent_bus_offset.
> >
> > Then we can remove all the .cpu_addr_fixup() calls in
> > cdns_pcie_host_init_address_translation(),
> > cdns_pcie_set_outbound_region(), and dw_pcie_prog_outbound_atu().
> >
> > Until we can get rid of all the .cpu_addr_fixup() implementations,
> > We'll still have that single call at startup (I guess once for cadence
> > and another for designware), but it should simplify the current
> > callers quite a bit.
> 
> I don't think it can simple code. cdns_pcie_set_outbound_region() and
> dw_pcie_prog_outbound_atu() are called by EP functions, which have not use
> "resource" to manage outbound windows. 

Let's ignore cadence for now.  I don't think we need to solve that
until later.

dw_pcie_prog_outbound_atu() is called by:

  - dw_pcie_other_conf_map_bus(): atu.parent_bus_addr = pp->cfg0_base

    I think dw_pcie_host_init() can set pp->cfg0_base with the correct
    intermediate address, either via the the of_property_read_reg() or
    .cpu_addr_fixup().

    If dw_pcie_host_init() does this, then we don't need
    .cpu_addr_fixup() in dw_pcie_prog_outbound_atu().

  - dw_pcie_rd_other_conf(): atu.parent_bus_addr = pp->io_base

    Similarly, dw_pcie_host_init() should be able to set pp->io_base
    to the intermediate address, so we don't need .cpu_addr_fixup() in
    dw_pcie_prog_outbound_atu().

  - dw_pcie_iatu_setup(): atu.parent_bus_addr = entry->res->start

    Here "entry" iterates through bridge->windows, and we should be
    able to set entry->parent_bus_offset at init-time, using
    .cpu_addr_fixup() if necessary, so we can apply that offset
    unconditionally, regardless of use_parent_dt_ranges, and we won't
    need .cpu_addr_fixup() in dw_pcie_prog_outbound_atu().

  - dw_pcie_pme_turn_off:
    atu.parent_bus_addr = pci->pp.msg_res->start - pci->pp.msg_parent_bus_offset

    This should be the same as dw_pcie_iatu_setup() since
    msg_parent_bus_offset comes from the window iteration in
    dw_pcie_host_request_msg_tlp_res().  As long as the windows have
    the correct parent_bus_offset at init-time, we should be all set.

