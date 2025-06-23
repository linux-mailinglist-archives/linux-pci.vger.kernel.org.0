Return-Path: <linux-pci+bounces-30356-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E9FAE3A02
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 11:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA1003A2E7B
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 09:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F2023536C;
	Mon, 23 Jun 2025 09:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qw+aUfQS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CEC17996;
	Mon, 23 Jun 2025 09:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750670809; cv=none; b=MwG30LZz3PINL0lgKCQU5V0/D+ri+I7k0Zqyu3pkztQwZL3FnjkbVESXMnBtoJpjPUDe2IqorpH6e8thPNdiicqNY6JmiqOgeZuzy5jikQSLGoX8Z+Ej8pxH+X80bq57iH0qgPnpTJ3ii6PmdzRnJqEboGvueqYZ3kKl5dECN0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750670809; c=relaxed/simple;
	bh=WefXIWazEPskl9B0X1xFtEXjeBSL+nY1ELytivVzN98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DJ+zAqC8CzetOTfF5KGBYyfESC4rRcXZ51gL++SDH1B6VCFBpBwP1HIFz+OEX8KrSzVOfbJtIwffBgQhKcZTjB4Dy6LaisJwDljjmNRHkIz8z5TDCRdM1sWGXdaH6OaPbjUv83c/A0gpba5fxgFq8cATm9TSYlVOYN3QP2/WRFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qw+aUfQS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A007EC4CEEA;
	Mon, 23 Jun 2025 09:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750670808;
	bh=WefXIWazEPskl9B0X1xFtEXjeBSL+nY1ELytivVzN98=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qw+aUfQSuKHEk4enVIrEz606dRtP6XgNppP2YO4INXtXX0fpKl7h4u8sf/OIVdZnD
	 NV0a4MPutrCtYNNsfopZKOvqLp1uChhTnXU/ifibAjQcX5+vHM+wZYC5u2QZdbBUbG
	 hqLK7QSB1BRJ/asx988F/PfQIVQ/RY4GUmm1JFsgN4/Mo8DqYKJQw5At6VHOYn0S0c
	 /UfP5gASQorEsfU+ZD4hXDXpdiSjND8/UoejeEyZYy69Ux4hUolfJth5AbnALTSJow
	 usdestU/sQ5azXOngEas1a3myuz4c299HGo5Yyo31BePXHs+oevsQhp/8PUPfwE+Tz
	 /Jbrjo0uFvWOw==
Date: Mon, 23 Jun 2025 11:26:41 +0200
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Sascha Bischoff <sascha.bischoff@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Timothy Hayes <timothy.hayes@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Peter Maydell <peter.maydell@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v5 24/27] irqchip/gic-v5: Add GICv5 ITS support
Message-ID: <aFkd0cigSKOSqUQI@lpieralisi>
References: <20250618-gicv5-host-v5-0-d9e622ac5539@kernel.org>
 <20250618-gicv5-host-v5-24-d9e622ac5539@kernel.org>
 <87y0tmp6gn.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y0tmp6gn.ffs@tglx>

On Fri, Jun 20, 2025 at 09:18:32PM +0200, Thomas Gleixner wrote:

[...]

> > + * Taken from msi_lib_irq_domain_select(). The only difference is that
> > + * we have to match the fwspec->fwnode parent against the domain->fwnode
> > + * in that in GICv5 the ITS domain is represented by the ITS fwnode but
> > + * the MSI controller (ie the ITS frames) are ITS child nodes.
> > + */
> > +static int gicv5_its_irq_domain_select(struct irq_domain *d, struct irq_fwspec *fwspec,
> > +				       enum irq_domain_bus_token bus_token)
> > +{
> > +	const struct msi_parent_ops *ops = d->msi_parent_ops;
> > +	u32 busmask = BIT(bus_token);
> > +
> > +	if (!ops)
> > +		return 0;
> > +
> > +	if (fwnode_get_parent(fwspec->fwnode) != d->fwnode ||
> > +	    fwspec->param_count != 0)
> > +		return 0;
> 
> Just add a MSI flag and set it in parent_ops::required_flags and extend

I added that but it does not work (not if we use d->flags as below), it works
if I add it as an

IRQ_DOMAIN_FLAG_*

and set it in irq_domain_info in the msi_create_parent_irq_domain()
call in the GICv5 ITS driver when creating the domain.

> the lib with
> 
>         struct fwnode_handle *fwh;
> 
>         fwh = d->flags & MAGIC ? fwnode_get_parent(fwspec->fwnode) : fwspec->fwnode;

Here we are using the domain flags and I think that's what we want.

If I go with parent_ops flag, I believe here we need to use the parent
msi_domain_info::flags - I don't think that's what we want.

It is a property of the IRQ domain so I think that adding an

IRQ_DOMAIN_FLAG_FWNODE_PARENT

is the best option.

Please let me know.

Thanks,
Lorenzo

> 
> No?
> 
> > diff --git a/drivers/irqchip/irq-gic-v5.c b/drivers/irqchip/irq-gic-v5.c
> > index c2e7ba7e38f7..4a0990f46358 100644
> > --- a/drivers/irqchip/irq-gic-v5.c
> > +++ b/drivers/irqchip/irq-gic-v5.c
> > @@ -57,12 +57,12 @@ static void release_lpi(u32 lpi)
> >  	ida_free(&lpi_ida, lpi);
> >  }
> >  
> > -static int gicv5_alloc_lpi(void)
> > +int gicv5_alloc_lpi(void)
> >  {
> >  	return alloc_lpi();
> >  }
> >  
> > -static void gicv5_free_lpi(u32 lpi)
> > +void gicv5_free_lpi(u32 lpi)
> >  {
> >  	release_lpi(lpi);
> >  }
> 
> Just make them global right away when you implement them. No point for
> this kind of churn.
> 
> Thanks,
> 
>         tglx

