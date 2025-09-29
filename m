Return-Path: <linux-pci+bounces-37219-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A65B1BAA2F9
	for <lists+linux-pci@lfdr.de>; Mon, 29 Sep 2025 19:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC9C71C3A34
	for <lists+linux-pci@lfdr.de>; Mon, 29 Sep 2025 17:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62BCB21D3E4;
	Mon, 29 Sep 2025 17:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SobtUwbv"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3268721D3CD;
	Mon, 29 Sep 2025 17:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759167324; cv=none; b=KwqRApl279puN9JJHleMLA2QYk/k3KfOwBdZ/lcR2zkXKYmgZVFPYWMHOZaTWPQFc0HlHOM7eYLOyZZHa8QycRvImdfSzJgn3t8ZxX+iFIXUNIbu8oriSDumrA5uudvUv0QWR4LKfg6eTlau4+q0WxNN9pYWnQ0otvJ5r3ubUMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759167324; c=relaxed/simple;
	bh=So0FUbuv/OJTG050tDD8NHjMsdi9r0qn/XZ916sS2wU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fwg/yxbusNZ+EZVQNRplFYUk9He0knXeJmI4GoR0jjo3or24duhH7Gj6eyg6wgYMoCByWQLlXFURM8Fj2J+3aMmVgMdyG2BXcLuexgEspLy6KE5/t2aqEIUg3piR7/YUcGEfbivyXD6o/YLG6147UdSNL/j8ixY33Dy3MO1WzmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SobtUwbv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 025DEC4CEF5;
	Mon, 29 Sep 2025 17:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759167323;
	bh=So0FUbuv/OJTG050tDD8NHjMsdi9r0qn/XZ916sS2wU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SobtUwbvHlYnd8c49AbPLOe1066THu8BPfO6tVqlgOjO/Lg3dG7AVKs5dw0KG/uoK
	 n9u+G2WOhL9tp4674GDfTVswxfwUTaC3eGv7nDLXjCbWxwjCDdMWn49JCfGS9tAO8t
	 h+lRBIIsVNQRoarGAtwMszzwPcMfcY3+R3qZ90wRqBeLHPMRSrC7FW9C1UQI+TEG4O
	 g/eVpStfWxcGF4iQYIZEb69r31Om2y5CjrX0m9fnJJJDal8DJKKaPBNewp8RQ3T2Tp
	 P8G+H4jLKpp9Vt36Ye2OHaqoXiumTPHKak+23ldZX7cPJWlaIcpglKvXiRfV/Vu+OI
	 Ap4dGboz+e1dg==
Date: Mon, 29 Sep 2025 23:05:09 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, geert+renesas@glider.be, 
	magnus.damm@gmail.com, p.zabel@pengutronix.de, linux-pci@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: Re: [PATCH v4 2/6] PCI: rzg3s-host: Add Renesas RZ/G3S SoC host
 driver
Message-ID: <yksxyboq33eke57n6rz4ikzlcbfda22uj5t3zsipc6m66fgoqr@ngbjg4abymcs>
References: <20250912122444.3870284-1-claudiu.beznea.uj@bp.renesas.com>
 <20250912122444.3870284-3-claudiu.beznea.uj@bp.renesas.com>
 <pnph54wv3736lemzren64ig4karlulffkvmc3dzgrhgyv2cpwu@2mcgvlqdr6wu>
 <ca1da9cb-5003-49f2-ab8d-70b80a10d8cd@tuxon.dev>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ca1da9cb-5003-49f2-ab8d-70b80a10d8cd@tuxon.dev>

On Fri, Sep 19, 2025 at 12:28:10PM +0300, Claudiu Beznea wrote:
> 
> 
> On 9/19/25 11:45, Manivannan Sadhasivam wrote:
> > On Fri, Sep 12, 2025 at 03:24:40PM +0300, Claudiu wrote:
> >> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >>
> >> The Renesas RZ/G3S features a PCIe IP that complies with the PCI Express
> >> Base Specification 4.0 and supports speeds of up to 5 GT/s. It functions
> >> only as a root complex, with a single-lane (x1) configuration. The
> >> controller includes Type 1 configuration registers, as well as IP
> >> specific registers (called AXI registers) required for various adjustments.
> >>
> >> Hardware manual can be downloaded from the address in the "Link" section.
> >> The following steps should be followed to access the manual:
> >> 1/ Click the "User Manual" button
> >> 2/ Click "Confirm"; this will start downloading an archive
> >> 3/ Open the downloaded archive
> >> 4/ Navigate to r01uh1014ej*-rzg3s-users-manual-hardware -> Deliverables
> >> 5/ Open the file r01uh1014ej*-rzg3s.pdf
> >>
> >> Link: https://www.renesas.com/en/products/rz-g3s?queryID=695cc067c2d89e3f271d43656ede4d12
> >> Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> >> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >> ---
> >>
> > 
> > [...]
> > 
> >> +static void rzg3s_pcie_update_bits(void __iomem *base, u32 offset, u32 mask,
> >> +				   u32 val)
> >> +{
> >> +	u32 tmp;
> >> +
> >> +	tmp = readl(base + offset);
> > 
> > Unless there is an ordering requirement, you can safely use
> > {readl/writel}_relaxed variants throughout the driver.
> 
> HW manual lists specific steps to follow when issuing requests. These steps
> are listed in chapter "34.4.2.4 Issuing Special Requests" in the manual
> pointed in patch description.
> 

I'm not asking you to change the order of the register config, but just asking
you to use {readl/writel}_relaxed variants as the plain readl/writel accessors
have memory barriers builtin, which will be unnecessary if not needed.

> > 
> >> +	tmp &= ~mask;
> >> +	tmp |= val & mask;
> >> +	writel(tmp, base + offset);
> >> +}
> >> +
> > 
> > [...]
> > 
> >> +static void __iomem *rzg3s_pcie_child_map_bus(struct pci_bus *bus,
> >> +					      unsigned int devfn,
> >> +					      int where)
> >> +{
> >> +	struct rzg3s_pcie_host *host = bus->sysdata;
> >> +	unsigned int dev, func, reg;
> >> +
> >> +	dev = PCI_SLOT(devfn);
> >> +	func = PCI_FUNC(devfn);
> >> +	reg = where & ~0x3;
> >> +
> >> +	/* Set the destination */
> >> +	writel(FIELD_PREP(RZG3S_PCI_REQADR1_BUS, bus->number) |
> >> +	       FIELD_PREP(RZG3S_PCI_REQADR1_DEV, dev) |
> >> +	       FIELD_PREP(RZG3S_PCI_REQADR1_FUNC, func) |
> >> +	       FIELD_PREP(RZG3S_PCI_REQADR1_REG, reg),
> >> +	       host->axi + RZG3S_PCI_REQADR1);
> >> +
> >> +	/* Set byte enable */
> >> +	writel(RZG3S_PCI_REQBE_BYTE_EN, host->axi + RZG3S_PCI_REQBE);
> >> +
> >> +	/*
> >> +	 * rzg3s_pcie_child_map_bus() is used to configure the controller before
> >> +	 * executing requests. It is called only within this driver and not
> >> +	 * through subsystem calls. Since it does not return an address that
> >> +	 * needs to be used later, return NULL.
> >> +	 */
> > 
> > What guarantees that the PCI core will not call this function through
> > pci_ops::map_bus?
> 
> As of my code inspection the pci_ops::map_bus is currently called from:
> pci_generic_config_read()
> pci_generic_config_write()
> pci_generic_config_read32()
> pci_generic_config_write32()
> 
> As of my code inspection, these are currently called from vendor specific
> drivers. I the core behavior will be changed, I can't guarantee the
> statement from the comment. Please let me know if you want me to drop the
> initialization of rzg3s_pcie_child_ops::map_bus and call
> rzg3s_pcie_child_map_bus() explicitly instead of calling it though
> rzg3s_pcie_child_ops::map_bus
> 
> As mentioned in the previous review rounds, this is implemented like this
> as it was suggested in v1 review process.
> 

My concern is, since you are using it as a map_bus() callback implementation,
there is no guarantee that the PCI core will not invoke it. If you do not intend
it, then I would suggest dropping the callback and use it directly.

> > 
> >> +	return NULL;
> >> +}
> >> +
> >> +static struct pci_ops rzg3s_pcie_child_ops = {
> >> +	.read		= rzg3s_pcie_child_read,
> >> +	.write		= rzg3s_pcie_child_write,
> >> +	.map_bus	= rzg3s_pcie_child_map_bus,
> >> +};
> >> +
> >> +static void __iomem *rzg3s_pcie_root_map_bus(struct pci_bus *bus,
> >> +					     unsigned int devfn,
> >> +					     int where)
> >> +{
> >> +	struct rzg3s_pcie_host *host = bus->sysdata;
> >> +
> >> +	if (devfn)
> >> +		return NULL;
> >> +
> >> +	return host->pcie + where;
> >> +}
> >> +
> >> +/* Serialization is provided by 'pci_lock' in drivers/pci/access.c */
> >> +static int rzg3s_pcie_root_write(struct pci_bus *bus, unsigned int devfn,
> >> +				 int where, int size, u32 val)
> >> +{
> >> +	struct rzg3s_pcie_host *host = bus->sysdata;
> >> +
> >> +	/* Enable access control to the CFGU */
> >> +	writel(RZG3S_PCI_PERM_CFG_HWINIT_EN, host->axi + RZG3S_PCI_PERM);
> >> +
> > 
> > I'm not sure if 'host->axi' written above and the address written below are in
> > the same domain or not. 
> 
> host->axi and host->pci are both part of the PCI controller address space.
> I don't have more info on it than this. HW manual don't mention anything
> about this.
> 

Then it should be fine.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

