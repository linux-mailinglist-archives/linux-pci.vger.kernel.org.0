Return-Path: <linux-pci+bounces-36467-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3452B88767
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 10:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8B554E2A84
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 08:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066C8244671;
	Fri, 19 Sep 2025 08:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="biTycpaT"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94FE2940B;
	Fri, 19 Sep 2025 08:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758271536; cv=none; b=p8sCwNl1fSOsmdsRsOBHEkkBsPWZfJB5MjrRenp3SLdCrmDaOqqGQijCyw9BV2vX25ZhoeqRVuPEn2Elj1hjmGCSExzLM4GfPzY1WTaoHj52PaGw0xbD8F61VdiBR/D/3s3+hLhDz+mAUrMLBf+xi9QUlLw/GJSxxmDEqdYfEto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758271536; c=relaxed/simple;
	bh=TG4xpLm+wqO/qlznPAEOg5qb4IsC7ZjYR9NfDGmT3DQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jEzAFGDTO8UhSHu+Bw3qCOuPhDkaxjrVTsZpC1Zza1eSY08e2HiY8PDR86evvT4M6A5zVHChSG6FRL5FP+mpcRGCNf6xCHhZuMcn/lhEkgoHVJ8OQyHA7BbyLzUx26W3Xna5byagWsUO8RzrO+MuWiSJUEb4Xcswd7l9Ds8c/hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=biTycpaT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97E35C4CEF0;
	Fri, 19 Sep 2025 08:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758271536;
	bh=TG4xpLm+wqO/qlznPAEOg5qb4IsC7ZjYR9NfDGmT3DQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=biTycpaT+4hwOMVBbTV8QlgqMirh5e9bScQYCa7MTRyr68L4MFPbrbJpSVlfcI6+s
	 W0pqmxa6VvP0D9h1GGECrYh4wVeWB3W5cWJVfzMr7ZPCpv8EzEZPxPZDDKRQUBdHGo
	 +bEN5/GAkhbVsIj7CWj7dpugUZL2yF5yjZ9kvcJ4VMQA/feFIokFIuX/E2hRVoxj2x
	 Vq/pi7QAEMrSRM97E95i6lfcZ2x6Z5Q0XJl6ODhIwsa2tuyLZcIrvAotM9HxsHDi+3
	 qhuaJDoaGgS9in5roJxIOsJfMIeJeotOmDy84mh0pifj7k8F4fcQps82Ujeo8E2ARi
	 Wn0I8dL0btCrg==
Date: Fri, 19 Sep 2025 14:15:27 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, geert+renesas@glider.be, 
	magnus.damm@gmail.com, p.zabel@pengutronix.de, linux-pci@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: Re: [PATCH v4 2/6] PCI: rzg3s-host: Add Renesas RZ/G3S SoC host
 driver
Message-ID: <pnph54wv3736lemzren64ig4karlulffkvmc3dzgrhgyv2cpwu@2mcgvlqdr6wu>
References: <20250912122444.3870284-1-claudiu.beznea.uj@bp.renesas.com>
 <20250912122444.3870284-3-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250912122444.3870284-3-claudiu.beznea.uj@bp.renesas.com>

On Fri, Sep 12, 2025 at 03:24:40PM +0300, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> The Renesas RZ/G3S features a PCIe IP that complies with the PCI Express
> Base Specification 4.0 and supports speeds of up to 5 GT/s. It functions
> only as a root complex, with a single-lane (x1) configuration. The
> controller includes Type 1 configuration registers, as well as IP
> specific registers (called AXI registers) required for various adjustments.
> 
> Hardware manual can be downloaded from the address in the "Link" section.
> The following steps should be followed to access the manual:
> 1/ Click the "User Manual" button
> 2/ Click "Confirm"; this will start downloading an archive
> 3/ Open the downloaded archive
> 4/ Navigate to r01uh1014ej*-rzg3s-users-manual-hardware -> Deliverables
> 5/ Open the file r01uh1014ej*-rzg3s.pdf
> 
> Link: https://www.renesas.com/en/products/rz-g3s?queryID=695cc067c2d89e3f271d43656ede4d12
> Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
> 

[...]

> +static void rzg3s_pcie_update_bits(void __iomem *base, u32 offset, u32 mask,
> +				   u32 val)
> +{
> +	u32 tmp;
> +
> +	tmp = readl(base + offset);

Unless there is an ordering requirement, you can safely use
{readl/writel}_relaxed variants throughout the driver.

> +	tmp &= ~mask;
> +	tmp |= val & mask;
> +	writel(tmp, base + offset);
> +}
> +

[...]

> +static void __iomem *rzg3s_pcie_child_map_bus(struct pci_bus *bus,
> +					      unsigned int devfn,
> +					      int where)
> +{
> +	struct rzg3s_pcie_host *host = bus->sysdata;
> +	unsigned int dev, func, reg;
> +
> +	dev = PCI_SLOT(devfn);
> +	func = PCI_FUNC(devfn);
> +	reg = where & ~0x3;
> +
> +	/* Set the destination */
> +	writel(FIELD_PREP(RZG3S_PCI_REQADR1_BUS, bus->number) |
> +	       FIELD_PREP(RZG3S_PCI_REQADR1_DEV, dev) |
> +	       FIELD_PREP(RZG3S_PCI_REQADR1_FUNC, func) |
> +	       FIELD_PREP(RZG3S_PCI_REQADR1_REG, reg),
> +	       host->axi + RZG3S_PCI_REQADR1);
> +
> +	/* Set byte enable */
> +	writel(RZG3S_PCI_REQBE_BYTE_EN, host->axi + RZG3S_PCI_REQBE);
> +
> +	/*
> +	 * rzg3s_pcie_child_map_bus() is used to configure the controller before
> +	 * executing requests. It is called only within this driver and not
> +	 * through subsystem calls. Since it does not return an address that
> +	 * needs to be used later, return NULL.
> +	 */

What guarantees that the PCI core will not call this function through
pci_ops::map_bus?

> +	return NULL;
> +}
> +
> +static struct pci_ops rzg3s_pcie_child_ops = {
> +	.read		= rzg3s_pcie_child_read,
> +	.write		= rzg3s_pcie_child_write,
> +	.map_bus	= rzg3s_pcie_child_map_bus,
> +};
> +
> +static void __iomem *rzg3s_pcie_root_map_bus(struct pci_bus *bus,
> +					     unsigned int devfn,
> +					     int where)
> +{
> +	struct rzg3s_pcie_host *host = bus->sysdata;
> +
> +	if (devfn)
> +		return NULL;
> +
> +	return host->pcie + where;
> +}
> +
> +/* Serialization is provided by 'pci_lock' in drivers/pci/access.c */
> +static int rzg3s_pcie_root_write(struct pci_bus *bus, unsigned int devfn,
> +				 int where, int size, u32 val)
> +{
> +	struct rzg3s_pcie_host *host = bus->sysdata;
> +
> +	/* Enable access control to the CFGU */
> +	writel(RZG3S_PCI_PERM_CFG_HWINIT_EN, host->axi + RZG3S_PCI_PERM);
> +

I'm not sure if 'host->axi' written above and the address written below are in
the same domain or not. If they are, then the writes will be serialized and
would be no issues. If they are in different domains, then you would need to do
readl() to make sure the above write reaches the hardware before writing below.

> +	pci_generic_config_write(bus, devfn, where, size, val);
> +
> +	/* Disable access control to the CFGU */
> +	writel(0, host->axi + RZG3S_PCI_PERM);
> +
> +	return PCIBIOS_SUCCESSFUL;
> +}
> +
> +static struct pci_ops rzg3s_pcie_root_ops = {
> +	.read		= pci_generic_config_read,
> +	.write		= rzg3s_pcie_root_write,
> +	.map_bus	= rzg3s_pcie_root_map_bus,
> +};
> +

[...]

> +static int rzg3s_pcie_intx_setup(struct rzg3s_pcie_host *host)
> +{
> +	struct device *dev = host->dev;
> +
> +	for (int i = 0; i < PCI_NUM_INTX; i++) {
> +		struct platform_device *pdev = to_platform_device(dev);
> +		char irq_name[5] = {0};
> +		int irq;
> +
> +		scnprintf(irq_name, ARRAY_SIZE(irq_name), "int%c", 'a' + i);
> +
> +		irq = platform_get_irq_byname(pdev, irq_name);
> +		if (irq < 0)
> +			return dev_err_probe(dev, -EINVAL,
> +					     "Failed to parse and map INT%c IRQ\n",
> +					     'A' + i);
> +
> +		host->intx_irqs[i] = irq;
> +		irq_set_chained_handler_and_data(irq,
> +						 rzg3s_pcie_intx_irq_handler,
> +						 host);
> +	}
> +
> +	host->intx_domain = irq_domain_create_linear(of_fwnode_handle(dev->of_node),
> +						     PCI_NUM_INTX,
> +						     &rzg3s_pcie_intx_domain_ops,
> +						     host);
> +	if (!host->intx_domain)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "Failed to add irq domain for INTx IRQs\n");
> +	irq_domain_update_bus_token(host->intx_domain, DOMAIN_BUS_WIRED);
> +
> +	return devm_add_action_or_reset(dev, rzg3s_pcie_intx_teardown, host);

Didn't I suggest dropping these devm_add_action_or_reset() calls and use error
labels as like other controller drivers?

> +}
> +

[...]

> +static struct platform_driver rzg3s_pcie_driver = {
> +	.driver = {
> +		.name = "rzg3s-pcie-host",
> +		.of_match_table = rzg3s_pcie_of_match,
> +		.pm = pm_ptr(&rzg3s_pcie_pm_ops),
> +		.suppress_bind_attrs = true,
> +	},
> +	.probe = rzg3s_pcie_probe,

You could use '.probe_type = PROBE_PREFER_ASYNCHRONOUS' to allow async probing
of the devices. This will have a big impact in boot time if you have multiple
controllers.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

