Return-Path: <linux-pci+bounces-23177-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A73A5764F
	for <lists+linux-pci@lfdr.de>; Sat,  8 Mar 2025 00:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A29517792A
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 23:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42C120CCFD;
	Fri,  7 Mar 2025 23:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Udfo0dUo"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30191DC99A;
	Fri,  7 Mar 2025 23:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741390893; cv=none; b=EGA+mnxnRiAuhvqzrcZjJzuMpqPKz4FXVUW59ZQlaM4dZhmN5zx16eVYBbjFmVTn43+HaTwON+/gsxUJXI7BtHXJBcP3mjiBM+GU5C7YxXlBKa4KnPYRYblw9Ocay8uJ2vhzsfJADTIJE+awxh4sdZB1hGn578bRtXfiBR0+z0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741390893; c=relaxed/simple;
	bh=yyE7KOWWH/DThx7lyaD0ORCMpjEmY7tHAL2lQSTtrxA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=IM6aipUZKLAuy4zEgxcx396r2CjxduBu2oSbXX55/PjNmP0anSiF0rTBgK1YZrbOztayyuP4D1x2qq9gGZfcHgetYklrAkIo6e5SaOykTbS6LC0LteMkejUT0ZUSvrQFAfQ0NJx1e6hM2HOAaQTuv55mEqNTjD4qnlQ+1QuPTaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Udfo0dUo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEE84C4CED1;
	Fri,  7 Mar 2025 23:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741390893;
	bh=yyE7KOWWH/DThx7lyaD0ORCMpjEmY7tHAL2lQSTtrxA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Udfo0dUo1NqX33GUbGYVRCfE2XukS0+19Lq8BUfwh5a2MSfyFC0FzoFb+JV12kTeB
	 N4VIx3dpaVde/6VorEOKIcGmoej71DV/NyP/+9MitDa7Ih1tlnSnI7yhFK503YOAZZ
	 Nto95q0f4z+O+vPziWEJswiMg4zMIj/PGdjeqlFnNvFKPv/rUILi05vjTQ2d6XyliB
	 TDfAL1SdOjRUbvF7FkV+O7VnEE6hROtjKiATZWC5xSxk0l15uzGP6xdeonUhFwOqTn
	 /agcd7Po8MoZzLUptFMYStBJ7uBuzgc8KBHB8zKUiYUJ7k/ACW+cW1khknah3fly8d
	 BXAI1/rbZExhA==
Date: Fri, 7 Mar 2025 17:41:31 -0600
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
Message-ID: <20250307234131.GA440690@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8sRl1c//SZXKhB+@lizhi-Precision-Tower-5810>

On Fri, Mar 07, 2025 at 10:32:39AM -0500, Frank Li wrote:
> On Tue, Mar 04, 2025 at 05:25:45PM -0500, Frank Li wrote:
> > On Tue, Mar 04, 2025 at 05:11:54PM -0500, Frank Li wrote:
> > > On Tue, Mar 04, 2025 at 11:50:10AM -0600, Bjorn Helgaas wrote:
> > > > On Mon, Mar 03, 2025 at 04:57:29PM -0500, Frank Li wrote:
> > > > > On Wed, Feb 26, 2025 at 06:23:26PM -0600, Bjorn Helgaas wrote:
> > > > > > On Tue, Jan 28, 2025 at 05:07:36PM -0500, Frank Li wrote:
> > > > > > > Introduce `parent_bus_offset` in `resource_entry` and a new API,
> > > > > > > `pci_add_resource_parent_bus_offset()`, to provide necessary information
> > > > > > > for PCI controllers with address translation units.
> > > > > > >
> > > > > > > Typical PCI data flow involves:
> > > > > > >   CPU (CPU address) -> Bus Fabric (Intermediate address) ->
> > > > > > >   PCI Controller (PCI bus address) -> PCI Bus.
> > > > > > >
> > > > > > > While most bus fabrics preserve address consistency, some modify addresses
> > > > > > > to intermediate values. The `parent_bus_offset` enables PCI controllers to
> > > > > > > translate these intermediate addresses correctly to PCI bus addresses.
> > > > > > >
> > > > > > > Pave the road to remove hardcoded cpu_addr_fixup() and similar patterns in
> > > > > > > PCI controller drivers.
> > > > > > > ...
> > > > > >
> > > > > > > +++ b/drivers/pci/of.c
> > > > > > > @@ -402,7 +402,17 @@ static int devm_of_pci_get_host_bridge_resources(struct device *dev,
> > > > > > >  			res->flags &= ~IORESOURCE_MEM_64;
> > > > > > >  		}
> > > > > > >
> > > > > > > -		pci_add_resource_offset(resources, res,	res->start - range.pci_addr);
> > > > > > > +		/*
> > > > > > > +		 * IORESOURCE_IO res->start is io space start address.
> > > > > > > +		 * IORESOURCE_MEM res->start is cpu start address, which is the
> > > > > > > +		 * same as range.cpu_addr.
> > > > > > > +		 *
> > > > > > > +		 * Use (range.cpu_addr - range.parent_bus_addr) to align both
> > > > > > > +		 * IO and MEM's parent_bus_offset always offset to cpu address.
> > > > > > > +		 */
> > > > > > > +
> > > > > > > +		pci_add_resource_parent_bus_offset(resources, res, res->start - range.pci_addr,
> > > > > > > +						   range.cpu_addr - range.parent_bus_addr);
> > > > > >
> > > > > > I don't know exactly where it needs to go, but I think we can call
> > > > > > .cpu_addr_fixup() once at startup on the base of the region.  This
> > > > > > will tell us the offset that applies to the entire region, i.e.,
> > > > > > parent_bus_offset.
> > > > > >
> > > > > > Then we can remove all the .cpu_addr_fixup() calls in
> > > > > > cdns_pcie_host_init_address_translation(),
> > > > > > cdns_pcie_set_outbound_region(), and dw_pcie_prog_outbound_atu().
> > > > > >
> > > > > > Until we can get rid of all the .cpu_addr_fixup() implementations,
> > > > > > We'll still have that single call at startup (I guess once for cadence
> > > > > > and another for designware), but it should simplify the current
> > > > > > callers quite a bit.
> > > > >
> > > > > I don't think it can simple code. cdns_pcie_set_outbound_region() and
> > > > > dw_pcie_prog_outbound_atu() are called by EP functions, which have not use
> > > > > "resource" to manage outbound windows.
> > > >
> > > > Let's ignore cadence for now.  I don't think we need to solve that
> > > > until later.
> > > >
> > > > dw_pcie_prog_outbound_atu() is called by:
> > > >
> > > >   - dw_pcie_other_conf_map_bus(): atu.parent_bus_addr = pp->cfg0_base
> > > >
> > > >     I think dw_pcie_host_init() can set pp->cfg0_base with the correct
> > > >     intermediate address, either via the the of_property_read_reg() or
> > > >     .cpu_addr_fixup().
> >
> > And chicken and egg problem here for artpec6_pcie_cpu_addr_fixup(), which
> > need cfg0_base. But try to use .cpu_addr_fixup() to get cfg0_base's
> > intermediate address.
> 
> Bjorn:
> 	Do you have chance to check my reply? some dwc platform driver
> .cpu_addr_fixup() implement have dependence with old initilize sequency.

Yes, I tried to sketch out what I was thinking to make it more
concrete.  I posted it and sent to you, but just for other readers of
this thread, it's at:

https://lore.kernel.org/linux-pci/20250307233744.440476-1-helgaas@kernel.org/T/#t

Bjorn

