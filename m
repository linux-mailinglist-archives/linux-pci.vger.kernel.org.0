Return-Path: <linux-pci+bounces-9241-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77559916AD7
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2024 16:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9656B1C2211F
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2024 14:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E1416D33A;
	Tue, 25 Jun 2024 14:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ioz9bs71"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909E616D335;
	Tue, 25 Jun 2024 14:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719326547; cv=none; b=um0R0wKzBBJI7DVbn3N7irLJz7Ii87+f172CRokn7axInkw80Uwiuh1AcWJDNv06X7JB4BANzZqaF8zurigmGVn/jWjHdhxeuv8AFJqJBX2jqKS1aAG+7hxoP4RUuH+4LZGoPf53D2VXz6W7Nf+f2p6DWKb/kxrAmE53RoJGdSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719326547; c=relaxed/simple;
	bh=oFhoRb8dHMqtN4BhADZtElPNMzCP/jvSv6/NFTI8rNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uEd77dvoo6fD3f62YeE4fOH6JcuHWZKJq6P1Yt+knIxmh5qOzOeUnhCd/TS4hCxHlCa/oSede0Au7svbaLHkaEpfMXI0Oz1EbR5I8P7CMxUqcQHUwycuhrexySc4gMb05mbOXh4EJoLSDg/bpk29+8QIDmnN/brIgeTIucEYWRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ioz9bs71; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE622C32781;
	Tue, 25 Jun 2024 14:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719326547;
	bh=oFhoRb8dHMqtN4BhADZtElPNMzCP/jvSv6/NFTI8rNc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ioz9bs71qsaqECa12AgJiUinorz/UT/ACN8div31KGmR3f66EL5OeA4OataeJmcE9
	 Rlw28Isv9Uu7TYneAfGaFIIOwGMlX5nFVF7jNhVMxCjHSzYBsWzG65/ZQJdHDFCwvP
	 dxSoZBi3FM4FQNVOejphBz894XtTw5lvXmvN55q5AsSc4Sl4vxHN5adwwQPrvZXo3I
	 7Q+sPsxdNjgOPovuE0z5f5nNc4yoQfmkH3eFtP63eHoVZoXh2I8R03OoYV87G4UZE5
	 gvzeQcTt0XdJGmGOz2JFCamVjwcgOniky7gUrgVe1k5RvHGB8/ad4jJLKs1XYndPYX
	 jK2KqckLIrvHw==
Date: Tue, 25 Jun 2024 16:42:12 +0200
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>, guohanjun@huawei.com
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	maz@kernel.org, anna-maria@linutronix.de, shawnguo@kernel.org,
	s.hauer@pengutronix.de, festevam@gmail.com, bhelgaas@google.com,
	rdunlap@infradead.org, vidyas@nvidia.com,
	ilpo.jarvinen@linux.intel.com, apatel@ventanamicro.com,
	kevin.tian@intel.com, nipun.gupta@amd.com, den@valinux.co.jp,
	andrew@lunn.ch, gregory.clement@bootlin.com,
	sebastian.hesselbarth@gmail.com, gregkh@linuxfoundation.org,
	rafael@kernel.org, alex.williamson@redhat.com, will@kernel.org,
	lorenzo.pieralisi@arm.com, jgg@mellanox.com,
	ammarfaizi2@gnuweeb.org, robin.murphy@arm.com, nm@ti.com,
	kristo@kernel.org, vkoul@kernel.org, okaya@kernel.org,
	agross@kernel.org, andersson@kernel.org, mark.rutland@arm.com,
	shameerali.kolothum.thodi@huawei.com, yuzenghui@huawei.com,
	shivamurthy.shastri@linutronix.de
Subject: Re: [patch V4 10/21] irqchip/mbigen: Remove
 platform_msi_create_device_domain() fallback
Message-ID: <ZnrXRLtqrlXhY8oz@lpieralisi>
References: <20240623142137.448898081@linutronix.de>
 <20240623142235.333333826@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240623142235.333333826@linutronix.de>

On Sun, Jun 23, 2024 at 05:18:48PM +0200, Thomas Gleixner wrote:

[+Hanjun]

Hanjun, are you able to test this series (or find someone who can) and
in particular mbigen changes on affected HW and report back here please ?

Thanks,
Lorenzo

> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Now that ITS provides the MSI parent domain, remove the unused fallback
> code.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> Signed-off-by: Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> 
> 
> ---
>  drivers/irqchip/irq-mbigen.c | 74 ++----------------------------------
>  1 file changed, 4 insertions(+), 70 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-mbigen.c b/drivers/irqchip/irq-mbigen.c
> index db0fa80330d9..093fd42893a7 100644
> --- a/drivers/irqchip/irq-mbigen.c
> +++ b/drivers/irqchip/irq-mbigen.c
> @@ -180,64 +180,6 @@ static int mbigen_domain_translate(struct irq_domain *d, struct irq_fwspec *fwsp
>  	return -EINVAL;
>  }
>  
> -/* The following section will go away once ITS provides a MSI parent */
> -
> -static struct irq_chip mbigen_irq_chip = {
> -	.name =			"mbigen-v2",
> -	.irq_mask =		irq_chip_mask_parent,
> -	.irq_unmask =		irq_chip_unmask_parent,
> -	.irq_eoi =		mbigen_eoi_irq,
> -	.irq_set_type =		mbigen_set_type,
> -	.irq_set_affinity =	irq_chip_set_affinity_parent,
> -};
> -
> -static int mbigen_irq_domain_alloc(struct irq_domain *domain,
> -					unsigned int virq,
> -					unsigned int nr_irqs,
> -					void *args)
> -{
> -	struct irq_fwspec *fwspec = args;
> -	irq_hw_number_t hwirq;
> -	unsigned int type;
> -	struct mbigen_device *mgn_chip;
> -	int i, err;
> -
> -	err = mbigen_domain_translate(domain, fwspec, &hwirq, &type);
> -	if (err)
> -		return err;
> -
> -	err = platform_msi_device_domain_alloc(domain, virq, nr_irqs);
> -	if (err)
> -		return err;
> -
> -	mgn_chip = platform_msi_get_host_data(domain);
> -
> -	for (i = 0; i < nr_irqs; i++)
> -		irq_domain_set_hwirq_and_chip(domain, virq + i, hwirq + i,
> -				      &mbigen_irq_chip, mgn_chip->base);
> -
> -	return 0;
> -}
> -
> -static void mbigen_irq_domain_free(struct irq_domain *domain, unsigned int virq,
> -				   unsigned int nr_irqs)
> -{
> -	platform_msi_device_domain_free(domain, virq, nr_irqs);
> -}
> -
> -static const struct irq_domain_ops mbigen_domain_ops = {
> -	.translate	= mbigen_domain_translate,
> -	.alloc		= mbigen_irq_domain_alloc,
> -	.free		= mbigen_irq_domain_free,
> -};
> -
> -static void mbigen_write_msg(struct msi_desc *desc, struct msi_msg *msg)
> -{
> -	mbigen_write_msi_msg(irq_get_irq_data(desc->irq), msg);
> -}
> -
> -/* End of to be removed section */
> -
>  static void mbigen_domain_set_desc(msi_alloc_info_t *arg, struct msi_desc *desc)
>  {
>  	arg->desc = desc;
> @@ -268,20 +210,12 @@ static const struct msi_domain_template mbigen_msi_template = {
>  static bool mbigen_create_device_domain(struct device *dev, unsigned int size,
>  					struct mbigen_device *mgn_chip)
>  {
> -	struct irq_domain *domain = dev->msi.domain;
> -
> -	if (WARN_ON_ONCE(!domain))
> +	if (WARN_ON_ONCE(!dev->msi.domain))
>  		return false;
>  
> -	if (irq_domain_is_msi_parent(domain)) {
> -		return msi_create_device_irq_domain(dev, MSI_DEFAULT_DOMAIN,
> -						    &mbigen_msi_template, size,
> -						    NULL, mgn_chip->base);
> -	}
> -
> -	/* Remove once ITS provides MSI parent */
> -	return !!platform_msi_create_device_domain(dev, size, mbigen_write_msg,
> -						   &mbigen_domain_ops, mgn_chip);
> +	return msi_create_device_irq_domain(dev, MSI_DEFAULT_DOMAIN,
> +					    &mbigen_msi_template, size,
> +					    NULL, mgn_chip->base);
>  }
>  
>  static int mbigen_of_create_domain(struct platform_device *pdev,
> -- 
> 2.34.1
> 
> 

