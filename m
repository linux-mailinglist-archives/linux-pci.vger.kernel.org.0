Return-Path: <linux-pci+bounces-9506-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0CD191DC35
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2024 12:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C9F7B222CB
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2024 10:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C6385934;
	Mon,  1 Jul 2024 10:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E1c6YrYJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D108381D9;
	Mon,  1 Jul 2024 10:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719829123; cv=none; b=ovDNWYKU3oBLRRV3fXbowDR2/cPFuyDaoWWqienDZXiUMxxuKpfPFH9Q6a6hYAc/LJcuxkBbMPOYjM1koBhUz9HcqRS5snrDWjUhVDuOJxUwOsD1JJyWJKCkgiYkQlGpO15VBKayMDxnTPJb/SIpIEMcMgiY0uhIU9jhCBObVBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719829123; c=relaxed/simple;
	bh=ClI/GouLZgq9UgNAOwvIcA2hQFqeT2XM0Y1uG/u+g5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UA2FkQyErAb3iLGpGaUN9is/sHjkV5nDH/88o3BxIMQ1lAUZKeHMbE7GuGzHuctC1zldBmUOLWDhQpr3LIKRMR3KjUaUY0YKTzAQW8BKmIKs7PVEID3qP/dXN53jbvvQ0bBHTAlzGPDuQIX/sMKPz8eDd7VZ3AMbB3KinYP780Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E1c6YrYJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BE07C116B1;
	Mon,  1 Jul 2024 10:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719829122;
	bh=ClI/GouLZgq9UgNAOwvIcA2hQFqeT2XM0Y1uG/u+g5I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E1c6YrYJ5LrQEyQatQV0jlyhxgbpgecIc74o5QU2Avzs+zQ/iQI51dJlqJVJqCD7B
	 2yiuW+mkdEPbbs2nYAN3N+8W1Ml4D1m42/c2XSsABWPcTadtIiz8RREH8W8XvwMsqf
	 R9C4xL/lSVTHJvoDnMOo5wrZ/t8rNbSZV111z2gwcaLE3WrG5ZpLb7L+fnsoqZ71Px
	 CiM1lyR7ms0sgS5xW1n6Q0WdCOszij30OTVzOlPLnf10gEZI71RUcUqLvmXlDg0A3c
	 Y1jI9/Mn8hUuvSJGUYxxA2wz2gwHNmVG4Jhs0kqd9itBgF8kB5Pz3olwtjXK5v1YWF
	 djkFvhsoqXXzQ==
Date: Mon, 1 Jul 2024 12:18:31 +0200
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
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
Subject: Re: [patch V4 02/21] irqchip: Provide irq-msi-lib
Message-ID: <ZoKCd5t5yoMkee0a@lpieralisi>
References: <20240623142137.448898081@linutronix.de>
 <20240623142234.840975799@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240623142234.840975799@linutronix.de>

On Sun, Jun 23, 2024 at 05:18:34PM +0200, Thomas Gleixner wrote:

[...]

> diff --git a/drivers/irqchip/irq-msi-lib.c b/drivers/irqchip/irq-msi-lib.c
> new file mode 100644
> index 000000000000..acbccf8f7f5b
> --- /dev/null
> +++ b/drivers/irqchip/irq-msi-lib.c
> @@ -0,0 +1,112 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +// Copyright (C) 2022 Linutronix GmbH
> +// Copyright (C) 2022 Intel
> +
> +#include <linux/export.h>
> +
> +#include "irq-msi-lib.h"
> +
> +/**
> + * msi_lib_init_dev_msi_info - Domain info setup for MSI domains
> + * @dev:		The device for which the domain is created for
> + * @domain:		The domain providing this callback
> + * @real_parent:	The real parent domain of the domain to be initialized
> + *			which might be a domain built on top of @domain or
> + *			@domain itself
> + * @info:		The domain info for the domain to be initialize
> + *
> + * This function is to be used for all types of MSI domains above the root
> + * parent domain and any intermediates. The topmost parent domain specific
> + * functionality is determined via @real_parent.
> + *
> + * All intermediate domains between the root and the device domain must
> + * have either msi_parent_ops.init_dev_msi_info = msi_parent_init_dev_msi_info
> + * or invoke it down the line.
> + */
> +bool msi_lib_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
> +			       struct irq_domain *real_parent,
> +			       struct msi_domain_info *info)
> +{
> +	const struct msi_parent_ops *pops = real_parent->msi_parent_ops;
> +
> +	/*
> +	 * MSI parent domain specific settings. For now there is only the
> +	 * root parent domain, e.g. NEXUS, acting as a MSI parent, but it is
> +	 * possible to stack MSI parents. See x86 vector -> irq remapping
> +	 */
> +	if (domain->bus_token == pops->bus_select_token) {
> +		if (WARN_ON_ONCE(domain != real_parent))
> +			return false;
> +	} else {
> +		WARN_ON_ONCE(1);
> +		return false;
> +	}
> +
> +	/* Parent ops available? */
> +	if (WARN_ON_ONCE(!pops))

We have already dereferenced pops above, we should move this warning
before we dereference it (ie checked devmsi-arm-v4-2 too - branch same
comment applies there too).

Thanks
Lorenzo

> +		return false;
> +
> +	/* Is the target domain bus token supported? */
> +	switch(info->bus_token) {
> +	default:
> +		/*
> +		 * This should never be reached. See
> +		 * msi_lib_irq_domain_select()
> +		 */
> +		WARN_ON_ONCE(1);
> +		return false;
> +	}
> +
> +	/*
> +	 * Mask out the domain specific MSI feature flags which are not
> +	 * supported by the real parent.
> +	 */
> +	info->flags			&= pops->supported_flags;
> +	/* Enforce the required flags */
> +	info->flags			|= pops->required_flags;
> +
> +	/* Chip updates for all child bus types */
> +	if (!info->chip->irq_eoi)
> +		info->chip->irq_eoi	= irq_chip_eoi_parent;
> +
> +	/*
> +	 * The device MSI domain can never have a set affinity callback. It
> +	 * always has to rely on the parent domain to handle affinity
> +	 * settings. The device MSI domain just has to write the resulting
> +	 * MSI message into the hardware which is the whole purpose of the
> +	 * device MSI domain aside of mask/unmask which is provided e.g. by
> +	 * PCI/MSI device domains.
> +	 */
> +	info->chip->irq_set_affinity	= msi_domain_set_affinity;
> +	return true;
> +}
> +EXPORT_SYMBOL_GPL(msi_lib_init_dev_msi_info);
> +
> +/**
> + * msi_lib_irq_domain_select - Shared select function for NEXUS domains
> + * @d:		Pointer to the irq domain on which select is invoked
> + * @fwspec:	Firmware spec describing what is searched
> + * @bus_token:	The bus token for which a matching irq domain is looked up
> + *
> + * Returns:	%0 if @d is not what is being looked for
> + *
> + *		%1 if @d is either the domain which is directly searched for or
> + *		   if @d is providing the parent MSI domain for the functionality
> + *			 requested with @bus_token.
> + */
> +int msi_lib_irq_domain_select(struct irq_domain *d, struct irq_fwspec *fwspec,
> +			      enum irq_domain_bus_token bus_token)
> +{
> +	const struct msi_parent_ops *ops = d->msi_parent_ops;
> +	u32 busmask = BIT(bus_token);
> +
> +	if (fwspec->fwnode != d->fwnode || fwspec->param_count != 0)
> +		return 0;
> +
> +	/* Handle pure domain searches */
> +	if (bus_token == ops->bus_select_token)
> +		return 1;
> +
> +	return ops && !!(ops->bus_select_mask & busmask);
> +}
> +EXPORT_SYMBOL_GPL(msi_lib_irq_domain_select);
> diff --git a/drivers/irqchip/irq-msi-lib.h b/drivers/irqchip/irq-msi-lib.h
> new file mode 100644
> index 000000000000..f0706cc28264
> --- /dev/null
> +++ b/drivers/irqchip/irq-msi-lib.h
> @@ -0,0 +1,19 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +// Copyright (C) 2022 Linutronix GmbH
> +// Copyright (C) 2022 Intel
> +
> +#ifndef _DRIVERS_IRQCHIP_IRQ_MSI_LIB_H
> +#define _DRIVERS_IRQCHIP_IRQ_MSI_LIB_H
> +
> +#include <linux/bits.h>
> +#include <linux/irqdomain.h>
> +#include <linux/msi.h>
> +
> +int msi_lib_irq_domain_select(struct irq_domain *d, struct irq_fwspec *fwspec,
> +			      enum irq_domain_bus_token bus_token);
> +
> +bool msi_lib_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
> +			       struct irq_domain *real_parent,
> +			       struct msi_domain_info *info);
> +
> +#endif /* _DRIVERS_IRQCHIP_IRQ_MSI_LIB_H */
> -- 
> 2.34.1
> 
> 

