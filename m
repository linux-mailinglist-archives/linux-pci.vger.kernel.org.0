Return-Path: <linux-pci+bounces-38161-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C57BDD2F5
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 09:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D77341891533
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 07:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E32E304BC8;
	Wed, 15 Oct 2025 07:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rZb4uENY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303A72C0296;
	Wed, 15 Oct 2025 07:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760514367; cv=none; b=RPXZmlOWZmDXg0jtoS3ih+0cd4JhhZFd1smAFeXOX0dxn749UvzfrTX184Z4TaqPmj1Uy7a+EZZgeTjb8N1jvNZkPHdzgAcE2v6evXwurNXfMmsZHHzgg6eN2USVNISkKnr1STC70Nf+AZgFiHlbwzlHE5gDXc7FDeMvl9dpOc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760514367; c=relaxed/simple;
	bh=FXxCGMHSbseazrQCYcPIDrNhWuFK4U8Cv/qXKnF+kwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rSUlWbILvLsAbN9R813xI1Z3IhinaB/3BbXOAQPjbjAEqsjymEnVqnA41ujwRylItvYi1v6XVtyZogeRgI2mcPrteM1bC69DjpxtungnHrcCp7SMvUw2j7aTt0dv52hbWMXW6F4/xWFmZxgvbb7NcXzesBaqKV5sk8TFi/H6r9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rZb4uENY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CA96C4CEF8;
	Wed, 15 Oct 2025 07:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760514366;
	bh=FXxCGMHSbseazrQCYcPIDrNhWuFK4U8Cv/qXKnF+kwY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rZb4uENYfMPKz6ON8rBY5Mda5+j+JTjC63EEdgH4BjNQI0935J1WgvTHUtezuqSWl
	 b2clk0q7u48bcqZ7XWfIoJ2tTVpbzuZThWfeOJ9IExTlsNuQVhBHjiYUPjGFxK3zXg
	 cMbbXtM8aZFQCoMmEtTZfAZVTvSU9gp3oX/6TO7+pejkW0wvLdhhOmrWw6HZWqxn54
	 IlTwJMcxk6GOg5zS60bEneYLmBHUtQgw8DWxDR+GIFeDwSa8H9cUP6Ba3KzXZnbLLy
	 3yudmXwirei0ZQX9UnEpP6U7c6BAL0pBijnk4oRYlbuwCttvJf8fdbJ8N+N5GXtXAf
	 rV0vmhJQwZPAw==
Date: Wed, 15 Oct 2025 09:46:00 +0200
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
	Sascha Bischoff <sascha.bischoff@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Frank Li <Frank.Li@nxp.com>, Scott Branden <sbranden@broadcom.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Ray Jui <rjui@broadcom.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Subject: Re: [PATCH v2 4/4] irqchip/gic-its: Rework platform MSI deviceID
 detection
Message-ID: <aO9ROPBGC6zF1B+i@lpieralisi>
References: <20251014095845.1310624-1-lpieralisi@kernel.org>
 <20251014095845.1310624-5-lpieralisi@kernel.org>
 <87ecr5xv9w.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ecr5xv9w.wl-maz@kernel.org>

On Tue, Oct 14, 2025 at 06:12:11PM +0100, Marc Zyngier wrote:
> On Tue, 14 Oct 2025 10:58:45 +0100,
> Lorenzo Pieralisi <lpieralisi@kernel.org> wrote:
> > 
> > Current code retrieving platform devices MSI devID in the GIC ITS MSI
> > parent helpers suffers from some minor issues:
> > 
> > - It leaks a struct device_node reference
> > - It triggers an excessive WARN_ON on wrong of_phandle_args count detection
> 
> Well, if your DT is that rotten, maybe you actually deserve some
> console spamming, don't you think?

Yes from that standpoint it would make sense to leave the WARN_ON there,
I can add it back.

> > - It is duplicated between GICv3 and GICv5 for no good reason
> > - It does not use the OF phandle iterator code that simplifies
> >   the msi-parent property parsing
> > 
> > Implement a helper function that addresses the full set of issues in one go
> > by consolidating GIC v3 and v5 code and converting the msi-parent parsing
> > loop to the more modern OF phandle iterator API, fixing the
> > struct device_node reference leak in the process.
> > 
> > Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> > Cc: Sascha Bischoff <sascha.bischoff@arm.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Rob Herring <robh@kernel.org>
> > Cc: Frank Li <Frank.Li@nxp.com>
> > Cc: Marc Zyngier <maz@kernel.org>
> > ---
> >  drivers/irqchip/irq-gic-its-msi-parent.c | 98 ++++++++----------------
> >  1 file changed, 33 insertions(+), 65 deletions(-)
> > 
> > diff --git a/drivers/irqchip/irq-gic-its-msi-parent.c b/drivers/irqchip/irq-gic-its-msi-parent.c
> > index eb1473f1448a..a65f762b7dd4 100644
> > --- a/drivers/irqchip/irq-gic-its-msi-parent.c
> > +++ b/drivers/irqchip/irq-gic-its-msi-parent.c
> > @@ -142,83 +142,51 @@ static int its_v5_pci_msi_prepare(struct irq_domain *domain, struct device *dev,
> >  #define its_v5_pci_msi_prepare	NULL
> >  #endif /* !CONFIG_PCI_MSI */
> >  
> > -static int of_pmsi_get_dev_id(struct irq_domain *domain, struct device *dev,
> > -				  u32 *dev_id)
> > +static int __of_pmsi_get_dev_id(struct irq_domain *domain, struct device *dev, u32 *dev_id,
> > +				phys_addr_t *pa, bool is_v5)
> >  {
> > -	int ret, index = 0;
> > +	struct of_phandle_iterator it;
> > +	uint32_t args;
> 
> Use u32, this is not userspace-visible (the OF code will cope). And
> move it to where it matters instead of having such a wide scope.

Ok.

> > +	int ret;
> >  
> >  	/* Suck the DeviceID out of the msi-parent property */
> > -	do {
> > -		struct of_phandle_args args;
> > +	of_for_each_phandle(&it, ret, dev->of_node, "msi-parent", "#msi-cells", -1) {
> > +		/* GICv5 ITS domain matches the MSI controller node parent */
> > +		struct device_node *np __free(device_node) = is_v5 ? of_get_parent(it.node)
> > +							     : of_node_get(it.node);
> >  
> > -		ret = of_parse_phandle_with_args(dev->of_node,
> > -						 "msi-parent", "#msi-cells",
> > -						 index, &args);
> > -		if (args.np == irq_domain_get_of_node(domain)) {
> > -			if (WARN_ON(args.args_count != 1))
> > -				return -EINVAL;
> > -			*dev_id = args.args[0];
> > -			break;
> > +		if (np == irq_domain_get_of_node(domain)) {
> > +			if (of_phandle_iterator_args(&it, &args, 1) != 1) {
> > +				dev_warn(dev, "Bogus msi-parent property\n");
> > +				ret = -EINVAL;
> > +			}
> > +
> > +			if (!ret && is_v5)
> > +				ret = its_translate_frame_address(it.node, pa);
> 
> Why do you need this is_v5 hack, since the only case were you pass a
> pointer to get the translate register address is for v5?

Yep, I thought about this what you are suggesting makes sense - is_v5 is
useless (and terrible).

> > +
> > +			if (!ret)
> > +				*dev_id = args;
> > +
> > +			of_node_put(it.node);
> > +			return ret;
> >  		}
> > -		index++;
> > -	} while (!ret);
> > -
> > -	if (ret) {
> > -		struct device_node *np = NULL;
> > -
> > -		ret = of_map_id(dev->of_node, dev->id, "msi-map", "msi-map-mask", &np, dev_id);
> > -		if (np)
> > -			of_node_put(np);
> >  	}
> >  
> > -	return ret;
> > +	struct device_node *msi_ctrl __free(device_node) = NULL;
> > +
> > +	return of_map_id(dev->of_node, dev->id, "msi-map", "msi-map-mask", &msi_ctrl, dev_id);
> > +}
> > +
> > +static int of_pmsi_get_dev_id(struct irq_domain *domain, struct device *dev,
> > +			      u32 *dev_id)
> > +{
> > +	return __of_pmsi_get_dev_id(domain, dev, dev_id, NULL, false);
> >  }
> 
> At this stage, we really don't need these on-liners, as they only
> obfuscate the logic. Just use the main helper directly. Something like
> the hack below.

That makes sense.

Thanks !
Lorenzo

> 
> 	M.
> 
> diff --git a/drivers/irqchip/irq-gic-its-msi-parent.c b/drivers/irqchip/irq-gic-its-msi-parent.c
> index a65f762b7dd4d..7c82fd152655e 100644
> --- a/drivers/irqchip/irq-gic-its-msi-parent.c
> +++ b/drivers/irqchip/irq-gic-its-msi-parent.c
> @@ -142,26 +142,27 @@ static int its_v5_pci_msi_prepare(struct irq_domain *domain, struct device *dev,
>  #define its_v5_pci_msi_prepare	NULL
>  #endif /* !CONFIG_PCI_MSI */
>  
> -static int __of_pmsi_get_dev_id(struct irq_domain *domain, struct device *dev, u32 *dev_id,
> -				phys_addr_t *pa, bool is_v5)
> +static int of_pmsi_get_msi_info(struct irq_domain *domain, struct device *dev, u32 *dev_id,
> +				phys_addr_t *pa)
>  {
>  	struct of_phandle_iterator it;
> -	uint32_t args;
>  	int ret;
>  
>  	/* Suck the DeviceID out of the msi-parent property */
>  	of_for_each_phandle(&it, ret, dev->of_node, "msi-parent", "#msi-cells", -1) {
>  		/* GICv5 ITS domain matches the MSI controller node parent */
> -		struct device_node *np __free(device_node) = is_v5 ? of_get_parent(it.node)
> +		struct device_node *np __free(device_node) = pa ? of_get_parent(it.node)
>  							     : of_node_get(it.node);
>  
>  		if (np == irq_domain_get_of_node(domain)) {
> +			u32 args;
> +
>  			if (of_phandle_iterator_args(&it, &args, 1) != 1) {
>  				dev_warn(dev, "Bogus msi-parent property\n");
>  				ret = -EINVAL;
>  			}
>  
> -			if (!ret && is_v5)
> +			if (!ret && pa)
>  				ret = its_translate_frame_address(it.node, pa);
>  
>  			if (!ret)
> @@ -177,18 +178,6 @@ static int __of_pmsi_get_dev_id(struct irq_domain *domain, struct device *dev, u
>  	return of_map_id(dev->of_node, dev->id, "msi-map", "msi-map-mask", &msi_ctrl, dev_id);
>  }
>  
> -static int of_pmsi_get_dev_id(struct irq_domain *domain, struct device *dev,
> -			      u32 *dev_id)
> -{
> -	return __of_pmsi_get_dev_id(domain, dev, dev_id, NULL, false);
> -}
> -
> -static int of_v5_pmsi_get_msi_info(struct irq_domain *domain, struct device *dev,
> -				   u32 *dev_id, phys_addr_t *pa)
> -{
> -	return __of_pmsi_get_dev_id(domain, dev, dev_id, pa, true);
> -}
> -
>  int __weak iort_pmsi_get_dev_id(struct device *dev, u32 *dev_id)
>  {
>  	return -1;
> @@ -202,7 +191,7 @@ static int its_pmsi_prepare(struct irq_domain *domain, struct device *dev,
>  	int ret;
>  
>  	if (dev->of_node)
> -		ret = of_pmsi_get_dev_id(domain->parent, dev, &dev_id);
> +		ret = of_pmsi_get_msi_info(domain->parent, dev, &dev_id, NULL);
>  	else
>  		ret = iort_pmsi_get_dev_id(dev, &dev_id);
>  	if (ret)
> @@ -230,7 +219,7 @@ static int its_v5_pmsi_prepare(struct irq_domain *domain, struct device *dev,
>  	if (!dev->of_node)
>  		return -ENODEV;
>  
> -	ret = of_v5_pmsi_get_msi_info(domain->parent, dev, &dev_id, &pa);
> +	ret = of_pmsi_get_msi_info(domain->parent, dev, &dev_id, &pa);
>  	if (ret)
>  		return ret;
>  
> 
> -- 
> Jazz isn't dead. It just smells funny.

