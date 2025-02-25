Return-Path: <linux-pci+bounces-22356-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B69EA44611
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 17:31:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89A17166BBA
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 16:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5EF818DB3B;
	Tue, 25 Feb 2025 16:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FoIzqW9h"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B035166F3D;
	Tue, 25 Feb 2025 16:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740500898; cv=none; b=aj4h1vxgtmXmyOvhobljeKzmZ7Zc4Halzq9GPpjtZ4TrbhG7AcU73EC247gVrs1rwLO5UBqJZdwX6VJIfO5D5/4b/0XPKUFsbyEmWCo5105GcnCW70jZUZhM0ZUoWPiDkpaPDhcD5JbV0ElCX4UcaRJhUwaAWyYYNDHmuIxbZtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740500898; c=relaxed/simple;
	bh=l7wENykQlVfLGdkLODgJTem6bFw3m55VAShgCDxQoxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ECEeYA4WJTncsEttqqb/8jZQcFPG7aTLb/O5vSZkpBVYBF3bchh/DdDjOI8sa3G/l2GJ4PcJKOGZ79ncv0SgDqcQeymaA/o7eQFTljlAYbuTWO75X96FLro7QZxQqTwbgWcfM+yFnWxwoCIlF44MWE54hp6JlSEO23f46alTl3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FoIzqW9h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D12F0C4CEDD;
	Tue, 25 Feb 2025 16:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740500898;
	bh=l7wENykQlVfLGdkLODgJTem6bFw3m55VAShgCDxQoxQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=FoIzqW9h4xdVbbfhsSOV8QGwe78/ZXy4NWaDHmYCT0joTSTuAeLDb5Qw/jjhbJ4Rl
	 KtxGXJLUGsolDSzr9iZGTbW+yY6HmadSnMnDHLr+906EsSKcxjGRRv7PQQRkXH92Gg
	 zLUoi0CKJTnxYDNSSYDK+tfs5+9XEV/GQaHTk+ZRQMEqpa8YY2L7QmDtXJYv81W1iV
	 r3dUzCS6IAak3nKrF6pmrNBlk31TIRblOokdr59PyRmwv50ch2MSIxKPmd4qM5kT1w
	 2qEuftSkXPN4Zd0ucfyOhW1i8Y/OSnQOLJ0b0ppT8CFxh9Eehgy6fwfLKXz7wJh6eU
	 yd885+8+Dk/TQ==
Date: Tue, 25 Feb 2025 10:28:16 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH] PCI: mvebu: Use devm_request_irq() for registering
 interrupt handler
Message-ID: <20250225162816.GA508551@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220524122817.7199-1-pali@kernel.org>

On Tue, May 24, 2022 at 02:28:17PM +0200, Pali Rohár wrote:
> Same as in commit a3b69dd0ad62 ("Revert "PCI: aardvark: Rewrite IRQ code to
> chained IRQ handler"") for pci-aardvark driver, use devm_request_irq()
> instead of chained IRQ handler in pci-mvebu.c driver.
> 
> This change fixes affinity support and allows to pin interrupts from
> different PCIe controllers to different CPU cores.

Hi Pali,

Coming back for another pass to try to understand this; sorry it's so
much later.

I'm trying to understand the affinity connection here.  I'm assuming
this involves the irq_set_affinity() path, which looks like it
requires some irq_chip that has a .irq_set_affinity() implementation.

But the only irq_chip mentioned in pci-mvebu.c is intx_irq_chip, which
doesn't implement .irq_set_affinity(), so I can't connect the dots
between this patch and a change in affinity support.

Apparently it has something to do with the chained vs non-chained IRQ
handler?  I guess mvebu_pcie_irq_handler() calls
generic_handle_domain_irq(); does that make mvebu_pcie_irq_handler() a
chained IRQ handler?

I guess the loop over all INTx interrupts there means that INTA, INTB,
INTC, and INTD must share the same affinity, because if we enter
mvebu_pcie_irq_handler() on CPU 0 for INTA, we may end up also
handling INTB, INTC, and INTD on CPU 0?  And maybe that means that no
INTx handler with this kind of loop can support independent affinity
for the four INTx interrupts?

How does this work from a user perspective?  Do you write a mask to
/proc/irq/XX/smp_affinity?

And I guess that XX must be something like "INTx", not "INTA", right?
I.e., /proc/interrupts could only have a single line for INTx?

Sorry for all these ignorant questions, IRQs are pretty much a mystery
to me.

> Fixes: ec075262648f ("PCI: mvebu: Implement support for legacy INTx interrupts")
> Signed-off-by: Pali Rohár <pali@kernel.org>
> ---
> Hello Bjorn! This is basically same issue as for pci-aardvark.c:
> https://lore.kernel.org/linux-pci/20220515125815.30157-1-pali@kernel.org/#t
> 
> I tested this patch with pci=nomsi in cmdline (to force kernel to use
> legacy intx instead of MSI) on A385 and checked that I can set affinity
> via /proc/irq/XX/smp_affinity file for every mvebu pcie controller to
> different CPU and legacy interrupts from different cards/controllers
> were handled by different CPUs.
> 
> I think that this is important on Armada XP platforms which have many
> independent PCIe controllers (IIRC up to 10) and many cores (up to 4).
> ---
>  drivers/pci/controller/pci-mvebu.c | 30 +++++++++++++++++-------------
>  1 file changed, 17 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
> index 8f76d4bda356..de67ea39fea5 100644
> --- a/drivers/pci/controller/pci-mvebu.c
> +++ b/drivers/pci/controller/pci-mvebu.c
> @@ -1017,16 +1017,13 @@ static int mvebu_pcie_init_irq_domain(struct mvebu_pcie_port *port)
>  	return 0;
>  }
>  
> -static void mvebu_pcie_irq_handler(struct irq_desc *desc)
> +static irqreturn_t mvebu_pcie_irq_handler(int irq, void *arg)
>  {
> -	struct mvebu_pcie_port *port = irq_desc_get_handler_data(desc);
> -	struct irq_chip *chip = irq_desc_get_chip(desc);
> +	struct mvebu_pcie_port *port = arg;
>  	struct device *dev = &port->pcie->pdev->dev;
>  	u32 cause, unmask, status;
>  	int i;
>  
> -	chained_irq_enter(chip, desc);
> -
>  	cause = mvebu_readl(port, PCIE_INT_CAUSE_OFF);
>  	unmask = mvebu_readl(port, PCIE_INT_UNMASK_OFF);
>  	status = cause & unmask;
> @@ -1040,7 +1037,7 @@ static void mvebu_pcie_irq_handler(struct irq_desc *desc)
>  			dev_err_ratelimited(dev, "unexpected INT%c IRQ\n", (char)i+'A');
>  	}
>  
> -	chained_irq_exit(chip, desc);
> +	return status ? IRQ_HANDLED : IRQ_NONE;
>  }
>  
>  static int mvebu_pcie_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
> @@ -1490,9 +1487,20 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
>  				mvebu_pcie_powerdown(port);
>  				continue;
>  			}
> -			irq_set_chained_handler_and_data(irq,
> -							 mvebu_pcie_irq_handler,
> -							 port);
> +
> +			ret = devm_request_irq(dev, irq, mvebu_pcie_irq_handler,
> +					       IRQF_SHARED | IRQF_NO_THREAD,
> +					       port->name, port);
> +			if (ret) {
> +				dev_err(dev, "%s: cannot register interrupt handler: %d\n",
> +					port->name, ret);
> +				irq_domain_remove(port->intx_irq_domain);
> +				pci_bridge_emul_cleanup(&port->bridge);
> +				devm_iounmap(dev, port->base);
> +				port->base = NULL;
> +				mvebu_pcie_powerdown(port);
> +				continue;
> +			}
>  		}
>  
>  		/*
> @@ -1599,7 +1607,6 @@ static int mvebu_pcie_remove(struct platform_device *pdev)
>  
>  	for (i = 0; i < pcie->nports; i++) {
>  		struct mvebu_pcie_port *port = &pcie->ports[i];
> -		int irq = port->intx_irq;
>  
>  		if (!port->base)
>  			continue;
> @@ -1615,9 +1622,6 @@ static int mvebu_pcie_remove(struct platform_device *pdev)
>  		/* Clear all interrupt causes. */
>  		mvebu_writel(port, ~PCIE_INT_ALL_MASK, PCIE_INT_CAUSE_OFF);
>  
> -		if (irq > 0)
> -			irq_set_chained_handler_and_data(irq, NULL, NULL);
> -
>  		/* Remove IRQ domains. */
>  		if (port->intx_irq_domain)
>  			irq_domain_remove(port->intx_irq_domain);
> -- 
> 2.20.1
> 

