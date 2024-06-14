Return-Path: <linux-pci+bounces-8845-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C1E908FB6
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 18:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E780C1F2322D
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 16:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9595A16B751;
	Fri, 14 Jun 2024 16:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GCAnvxS1"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF9BD512;
	Fri, 14 Jun 2024 16:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718381384; cv=none; b=J5HTkjUCwn58L5CSSujvQDNZSbPqiWlFJ3acJvla1g/z2qOpsKdaUymuHj9vYvnzUvtA+lfZW877fkdWr249z79B9uI/OwqqWW2x3seK8gaFgcpX3ax77TTIq7uowVCLGNPm9lfkOr/nk9FAXNnmLUjlLh63mWlLSe/7BF1jXtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718381384; c=relaxed/simple;
	bh=i6G4moCMnqhzFyyBB6tQeSxoa8cndGODhPD7vUB4a4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Pnd5xVdikUb8LKcJ6vBhcP8zkTuaxUmaDe5m4mY8g8ZEl9GrNAN8NTEymyqm6yWeT8Anshm3ruMK/1mTWXmOlw6CEM5CcBoDg+CJ5nDemcnfpJ2IS64fbkVysO2r//rTKnZptqFfGMKnkl6NrdRg6Ea6+lbzO5uihwvx2xg1PCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GCAnvxS1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD8B3C2BD10;
	Fri, 14 Jun 2024 16:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718381384;
	bh=i6G4moCMnqhzFyyBB6tQeSxoa8cndGODhPD7vUB4a4Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=GCAnvxS16+wFmkgOlsKpHUFr0GxQY+1IH7051TFHP+y8chtyCdRQ6URBbZTj4GRMp
	 TiLUDs+dq0ihSVDDozhG6Q43TtwjOVIZ0kvyDrns5Wh4wO2NXOriUpKZw8WueFBQaG
	 4m6/3bKGGhWuh51mQxiq/q+y6LazAKFyJC2hLpBMaWTZ/72yB2gMjGG0Jwr12wXzke
	 Hvw/h18FfHXppTfW4KkX+OWwzY9JaD/mpbjZQutYJt+sd3OVFuS7QnLwlQ3g+bsA+M
	 vghRkD9ubmqFr7wc1Onm7x6r+NpUCEIzRMXo55H2YceUqHnuNWuo4scooIiAdCfyfY
	 xuTd8/yy6slYw==
Date: Fri, 14 Jun 2024 11:09:42 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org, maz@kernel.org, tglx@linutronix.de,
	anna-maria@linutronix.de, shawnguo@kernel.org,
	s.hauer@pengutronix.de, festevam@gmail.com, bhelgaas@google.com,
	rdunlap@infradead.org, vidyas@nvidia.com,
	ilpo.jarvinen@linux.intel.com, apatel@ventanamicro.com,
	kevin.tian@intel.com, nipun.gupta@amd.com, den@valinux.co.jp,
	andrew@lunn.ch, gregory.clement@bootlin.com,
	sebastian.hesselbarth@gmail.com, gregkh@linuxfoundation.org,
	rafael@kernel.org, alex.williamson@redhat.com, will@kernel.org,
	lorenzo.pieralisi@arm.com, jgg@mellanox.com,
	ammarfaizi2@gnuweeb.org, robin.murphy@arm.com,
	lpieralisi@kernel.org, nm@ti.com, kristo@kernel.org,
	vkoul@kernel.org, okaya@kernel.org, agross@kernel.org,
	andersson@kernel.org, mark.rutland@arm.com,
	shameerali.kolothum.thodi@huawei.com, yuzenghui@huawei.com
Subject: Re: [PATCH v3 03/24] PCI/MSI: Provide MSI_FLAG_PCI_MSI_MASK_PARENT
Message-ID: <20240614160942.GA1114672@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240614102403.13610-4-shivamurthy.shastri@linutronix.de>

On Fri, Jun 14, 2024 at 12:23:42PM +0200, Shivamurthy Shastri wrote:
> Most ARM(64) PCI/MSI domains mask and unmask in the parent domain after or
> before the PCI mask/unmask operation takes place. So there are more than a
> dozen of the same wrapper implementation all over the place.

Is this an opportunity to clean up all these wrappers?  If you could
mention an example or two here, maybe somebody would be motivated to
come back and simplify the existing wrappers to take advantage of this
new flag?

> Don't make the same mistake with the new per device PCI/MSI domains and
> provide a new MSI feature flag, which lets the domain implementation
> enable this sequence in the PCI/MSI code.
> 
> Signed-off-by: Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>

I assume you'll merge this series via some other tree, so:

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
> v3: new patch to replace the global static key - Marc Zyngier
> ---
>  drivers/pci/msi/irqdomain.c | 21 +++++++++++++++++++++
>  include/linux/msi.h         |  2 ++
>  2 files changed, 23 insertions(+)
> 
> diff --git a/drivers/pci/msi/irqdomain.c b/drivers/pci/msi/irqdomain.c
> index 03d2dd25790d..112c2ff3035c 100644
> --- a/drivers/pci/msi/irqdomain.c
> +++ b/drivers/pci/msi/irqdomain.c
> @@ -148,17 +148,35 @@ static void pci_device_domain_set_desc(msi_alloc_info_t *arg, struct msi_desc *d
>  	arg->hwirq = desc->msi_index;
>  }
>  
> +static __always_inline void cond_mask_parent(struct irq_data *data)
> +{
> +	struct msi_domain_info *info = data->domain->host_data;
> +
> +	if (unlikely(info->flags & MSI_FLAG_PCI_MSI_MASK_PARENT))
> +		irq_chip_mask_parent(data);
> +}
> +
> +static __always_inline void cond_unmask_parent(struct irq_data *data)
> +{
> +	struct msi_domain_info *info = data->domain->host_data;
> +
> +	if (unlikely(info->flags & MSI_FLAG_PCI_MSI_MASK_PARENT))
> +		irq_chip_unmask_parent(data);
> +}
> +
>  static void pci_irq_mask_msi(struct irq_data *data)
>  {
>  	struct msi_desc *desc = irq_data_get_msi_desc(data);
>  
>  	pci_msi_mask(desc, BIT(data->irq - desc->irq));
> +	cond_mask_parent(data);
>  }
>  
>  static void pci_irq_unmask_msi(struct irq_data *data)
>  {
>  	struct msi_desc *desc = irq_data_get_msi_desc(data);
>  
> +	cond_unmask_parent(data);
>  	pci_msi_unmask(desc, BIT(data->irq - desc->irq));
>  }
>  
> @@ -170,6 +188,7 @@ static void pci_irq_unmask_msi(struct irq_data *data)
>  
>  #define MSI_COMMON_FLAGS	(MSI_FLAG_FREE_MSI_DESCS |	\
>  				 MSI_FLAG_ACTIVATE_EARLY |	\
> +				 MSI_FLAG_PCI_MSI_MASK_PARENT |	\
>  				 MSI_FLAG_DEV_SYSFS |		\
>  				 MSI_REACTIVATE)
>  
> @@ -195,10 +214,12 @@ static const struct msi_domain_template pci_msi_template = {
>  static void pci_irq_mask_msix(struct irq_data *data)
>  {
>  	pci_msix_mask(irq_data_get_msi_desc(data));
> +	cond_mask_parent(data);
>  }
>  
>  static void pci_irq_unmask_msix(struct irq_data *data)
>  {
> +	cond_unmask_parent(data);
>  	pci_msix_unmask(irq_data_get_msi_desc(data));
>  }
>  
> diff --git a/include/linux/msi.h b/include/linux/msi.h
> index dc27cf3903d5..04f33e7f6f8b 100644
> --- a/include/linux/msi.h
> +++ b/include/linux/msi.h
> @@ -556,6 +556,8 @@ enum {
>  	MSI_FLAG_USE_DEV_FWNODE		= (1 << 7),
>  	/* Set parent->dev into domain->pm_dev on device domain creation */
>  	MSI_FLAG_PARENT_PM_DEV		= (1 << 8),
> +	/* Support for parent mask/unmask */
> +	MSI_FLAG_PCI_MSI_MASK_PARENT	= (1 << 9),
>  
>  	/* Mask for the generic functionality */
>  	MSI_GENERIC_FLAGS_MASK		= GENMASK(15, 0),
> -- 
> 2.34.1
> 

