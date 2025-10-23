Return-Path: <linux-pci+bounces-39165-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A710C02434
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 17:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 32D2C4E8A59
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 15:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F910246762;
	Thu, 23 Oct 2025 15:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nv6vZYDI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713A223CF12;
	Thu, 23 Oct 2025 15:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761234915; cv=none; b=p+EFQs4O86fykYmF6kIrXdSlzI5WA3JqIfoK9dWo4XBjDGCZBLvZefSMO6bvzeZdoQt3+ssiwpPKVaq/OjsLeqq1qPhFuMmocc8yOx/aql37tpmX4juO/s8OcTwFZCZ7u7YOCWPQV/YC7tRxUdnmosaIeFDPmhrc0KQAvMV1ivs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761234915; c=relaxed/simple;
	bh=1QpoQFpPQ94aZbwr72YQxHT323Coj8A+g67bYc56XnI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=EU53Vjba8tun13ayIUMqjJ6759Yq7LzBi2Dfq55dctPdP+NCA4EGdObDtsBMtTzUe/pBwqHNYglFWYCMDjS9YEyPtAxKzLB9vSKtUHtdzfbY8WM+Zbr7muMPCzEy5yUWxSHpFWK/kTGGDC5rkifqI6BrjoCu+fhRr2KmBxHcaLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nv6vZYDI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA69EC4CEE7;
	Thu, 23 Oct 2025 15:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761234914;
	bh=1QpoQFpPQ94aZbwr72YQxHT323Coj8A+g67bYc56XnI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=nv6vZYDIq4am/DtLED1qWXVAd2mLG+N0czCN9jA1x9/ayvMuLkUTjlElJaRnzJLDw
	 UQH6d8lBkhDAVuswDv9zAPnGQkloIBAAkB/6LDzgYKOV0bX290FLLvIRbqdKiLDZFe
	 Gl7OqgIWM9Ode8EkIGfu1ABY127HikycA/qKBnJLiwFeYH3R8paBUlK6taUvhjAn2z
	 6/OjnBAwkxM1pO+Cdkpew56iPnH/MZyWqW1nRnKGCYSSgR+M7g1XBASKosE/6todZf
	 RzDMnjS2StUDsoaQ+8U9xvG1zBiyWu1SuUoSQuCQbfhkqgEzeqLGXxNJjJmE+Er1D6
	 IaA8F+Mhiuk5g==
Date: Thu, 23 Oct 2025 10:55:13 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	robh@kernel.org, bhelgaas@google.com, krzk+dt@kernel.org,
	conor+dt@kernel.org, geert+renesas@glider.be, magnus.damm@gmail.com,
	p.zabel@pengutronix.de, linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: Re: [PATCH v5 2/6] PCI: rzg3s-host: Add Renesas RZ/G3S SoC host
 driver
Message-ID: <20251023155513.GA1292722@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51af454f-6322-47c3-9e93-4fc07efc2b8d@tuxon.dev>

On Thu, Oct 23, 2025 at 08:11:17AM +0300, Claudiu Beznea wrote:
> On 10/22/25 22:49, Bjorn Helgaas wrote:
> > On Tue, Oct 07, 2025 at 04:36:53PM +0300, Claudiu wrote:
> >> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >>
> >> The Renesas RZ/G3S features a PCIe IP that complies with the PCI Express
> >> Base Specification 4.0 and supports speeds of up to 5 GT/s. It functions
> >> only as a root complex, with a single-lane (x1) configuration. The
> >> controller includes Type 1 configuration registers, as well as IP
> >> specific registers (called AXI registers) required for various adjustments.

> >> +++ b/drivers/pci/controller/pcie-rzg3s-host.c
> > 
> >> +#define RZG3S_PCI_MSIRCVWMSKL			0x108
> >> +#define RZG3S_PCI_MSIRCVWMSKL_MASK		GENMASK(31, 2)
> > 
> > Unfortunate to have to add _MASK here when none of the other GENMASKs
> > need it.  Can't think of a better name though.
> 
> Most of the register offsets and fields defines tried to use the naming
> from the HW manual. ...

It's OK as-is.

> >> +static int rzg3s_pcie_msi_enable(struct rzg3s_pcie_host *host)
> >> +{
> >> +	struct platform_device *pdev = to_platform_device(host->dev);
> >> +	struct rzg3s_pcie_msi *msi = &host->msi;
> >> +	struct device *dev = host->dev;
> >> +	const char *devname;
> >> +	int irq, ret;
> >> +
> >> +	ret = devm_mutex_init(dev, &msi->map_lock);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	msi->irq = platform_get_irq_byname(pdev, "msi");
> >> +	if (msi->irq < 0)
> >> +		return dev_err_probe(dev, irq ? irq : -EINVAL,
> >> +				     "Failed to get MSI IRQ!\n");
> >> +
> >> +	devname = devm_kasprintf(dev, GFP_KERNEL, "%s-msi", dev_name(dev));
> >> +	if (!devname)
> >> +		return -ENOMEM;
> >> +
> >> +	ret = rzg3s_pcie_msi_allocate_domains(msi);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	ret = request_irq(msi->irq, rzg3s_pcie_msi_irq, 0, devname, host);
> > 
> > Should this be devm_request_irq()?  Most drivers use it, although
> > pci-tegra.c and pcie-apple.c do not.  Maybe there's some special
> > rule about using request_irq() even though the driver uses devm in
> > general?  I dunno.
> 
> In general is not good to mix devm cleanups with driver specific
> one.
> 
> As it was requested to drop the devm cleanups from this driver
> (especially devm_pm_runtime_enable() which enables the also the
> clocks) I switched the initial devm_request_irq() to request_irq()
> to avoid keeping the interrupt requested on error path, after
> driver's probed was executed, until devm cleanups are called, and
> potentially having it firing w/o hardware resourced being enabled
> (e.g. clocks), and potentially reading HW registers.

I couldn't find that request to drop devm, and I don't see where
devm_pm_runtime_enable() enables clocks.

> E.g., accessing the HW registers while clocks are disabled on the
> SoC I'm working with leads to synchronous aborts.
> 
> So, I only kept the devm helpers for memory allocations, resets
> assert/de-assert and the mutex initialization.

I'm OK with request_irq() here since you have a good reason.  This
problem of accessing registers while clocks are disabled sounds
familiar, so I think other hardware has a similar issue.  It would be
nice if everybody handled it the same way.

I don't know enough to identify other similar hardware and see how
they handled it (or identify drivers that *don't* handle it).  It
might be worth a one-line comment here to help future code readers.

> >> +static int rzg3s_pcie_intx_setup(struct rzg3s_pcie_host *host)
> >> +{
> >> +	struct device *dev = host->dev;
> >> +
> >> +	for (int i = 0; i < PCI_NUM_INTX; i++) {
> >> +		struct platform_device *pdev = to_platform_device(dev);
> > 
> > Looks like this should be outside the loop.
> 
> OK, I kept it here as it is used only inside this block.

Ah, I see the motivation.  I suppose the compiler is smarter than I am
and hoists it out of the loop anyway, but I think it is easier for
humans to read if the loop only contains things that change for each
iteration.

> >> +		char irq_name[5] = {0};
> >> +		int irq;
> >> +
> >> +		scnprintf(irq_name, ARRAY_SIZE(irq_name), "int%c", 'a' + i);
> >> +
> >> +		irq = platform_get_irq_byname(pdev, irq_name);
> >> +		if (irq < 0)
> >> +			return dev_err_probe(dev, -EINVAL,
> >> +					     "Failed to parse and map INT%c IRQ\n",
> >> +					     'A' + i);
> >> +
> >> +		host->intx_irqs[i] = irq;
> >> +		irq_set_chained_handler_and_data(irq,
> >> +						 rzg3s_pcie_intx_irq_handler,
> >> +						 host);
> >> +	}

> +     host->intx_domain = irq_domain_create_linear(of_fwnode_handle(dev->of_node),
> +                                                  PCI_NUM_INTX,
> +                                                  &rzg3s_pcie_intx_domain_ops,
> +                                                  host);
> ...
> +     irq_domain_update_bus_token(host->intx_domain, DOMAIN_BUS_WIRED);
> +

Can we use dev_fwnode(dev) here instead of of_fwnode_handle() so it
matches the one in rzg3s_pcie_msi_allocate_domains()?

I think irq_domain_update_bus_token() is needed here because
host->intx_domain and msi->domain are identified by the same fwnode,
and this will be easier to see if we get the fwnode the same way.

(See 61d0a000b774 ("genirq/irqdomain: Add irq_domain_update_bus_token
helper").  I wish irq_domain_update_bus_token() had a function comment
to this effect.  Maybe even a mention in Documentation/.)

It would also help code readers if we could use function names similar
to other drivers.  For instance, rzg3s_pcie_intx_setup() creates the
INTx IRQ domain, but no other driver uses a name like *_intx_setup().
The general consensus seems to be *_pcie_init_irq_domain().

Bjorn

