Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 748F562CABE
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 21:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234045AbiKPUXH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 15:23:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233981AbiKPUW7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 15:22:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4CDD65854;
        Wed, 16 Nov 2022 12:22:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 40FB961F97;
        Wed, 16 Nov 2022 20:22:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57270C433C1;
        Wed, 16 Nov 2022 20:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668630176;
        bh=c8IWBcWcsW+/p7OLoIl2GAm0ZyvoePBcmnk8daUmZRA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=FPewUu/ROqVcodVOqofo0nXID/TpOIF5FW6B1aH9fBGedC3T9CyMYjlBBwyDlY3qJ
         i2GDAXUsqXLY4atXkGFIPRKNTBLlqHawl8uWbfEgJMUAESXjsWysAuPazkRPNcBBzs
         ppMI9405i5xZft0dxsT56JIfzoia4e7/8Yh9So8EIej7pZiQOqi3iTR18kCqH3lm01
         j75T5pJmCRaxQqlorZ56y3IH9PFIoI4BKu+v2I0jAMr5WpvAhoXaiijyNF4ciDGFMK
         XnpKB9Bf5DX22u3XlMLCzN3L2d6YOg3m3+lRBCEWw7IASpN9EIenA47l/cJHxbweoa
         oS8ROQlxT9iAw==
Date:   Wed, 16 Nov 2022 14:22:54 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ashok Raj <ashok.raj@intel.com>, Jon Mason <jdmason@kudzu.us>,
        Allen Hubbe <allenbh@gmail.com>,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: Re: [patch 12/33] PCI/MSI: Add support for per device MSI[X] domains
Message-ID: <20221116202254.GA1134096@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111135205.951710169@linutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Comment below uses [-X] (not [X]).

On Fri, Nov 11, 2022 at 02:58:30PM +0100, Thomas Gleixner wrote:
> Provide a template and the necessary callbacks to create PCI/MSI and
> PCI/MSI-X domains.
> 
> The domains are created when MSI or MSI-X is enabled. The domains lifetime

domain's

> is either the device life time or in case that e.g. MSI-X was tried first

lifetime (as used above)

> and failed, then the MSI-X domain is removed and a MSI domain is created as
> both are mutually exclusive and reside in the default domain id slot of the
> per device domain pointer array.

ID?

> Also expand pci_msi_domain_supports() to handle feature checks correctly
> even in the case that the per device domain was not yet created by checking
> the features supported by the MSI parent.
> 
> Add the necessary setup calls into the MSI and MSI-X enable code path.
> These setup calls are backwards compatible. They return success when there
> is no parent domain found, which means the existing global domains or the
> legacy allocation path keep just working.
> 
> Co-developed-by: Ahmed S. Darwish <darwi@linutronix.de>
> Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

A couple typos below.

> ---
>  drivers/pci/msi/irqdomain.c |  188 +++++++++++++++++++++++++++++++++++++++++++-
>  drivers/pci/msi/msi.c       |   16 +++
>  drivers/pci/msi/msi.h       |    2 
>  3 files changed, 201 insertions(+), 5 deletions(-)
> 
> --- a/drivers/pci/msi/irqdomain.c
> +++ b/drivers/pci/msi/irqdomain.c
> @@ -139,6 +139,170 @@ struct irq_domain *pci_msi_create_irq_do
>  }
>  EXPORT_SYMBOL_GPL(pci_msi_create_irq_domain);
>  
> +/*
> + * Per device MSI[-X] domain functionality
> + */
> +static void pci_device_domain_set_desc(msi_alloc_info_t *arg, struct msi_desc *desc)
> +{
> +	arg->desc = desc;
> +	arg->hwirq = desc->msi_index;
> +}
> +
> +static void pci_mask_msi(struct irq_data *data)
> +{
> +	struct msi_desc *desc = irq_data_get_msi_desc(data);
> +
> +	pci_msi_mask(desc, BIT(data->irq - desc->irq));
> +}
> +
> +static void pci_unmask_msi(struct irq_data *data)
> +{
> +	struct msi_desc *desc = irq_data_get_msi_desc(data);
> +
> +	pci_msi_unmask(desc, BIT(data->irq - desc->irq));
> +}
> +
> +#ifdef CONFIG_GENERIC_IRQ_RESERVATION_MODE
> +# define MSI_REACTIVATE		MSI_FLAG_MUST_REACTIVATE
> +#else
> +# define MSI_REACTIVATE		0
> +#endif
> +
> +#define MSI_COMMON_FLAGS	(MSI_FLAG_FREE_MSI_DESCS |	\
> +				 MSI_FLAG_ACTIVATE_EARLY |	\
> +				 MSI_FLAG_DEV_SYSFS |		\
> +				 MSI_REACTIVATE)
> +
> +static struct msi_domain_template pci_msi_template = {
> +	.chip = {
> +		.name			= "PCI-MSI",
> +		.irq_mask		= pci_mask_msi,
> +		.irq_unmask		= pci_unmask_msi,
> +		.irq_write_msi_msg	= pci_msi_domain_write_msg,
> +		.flags			= IRQCHIP_ONESHOT_SAFE,
> +	},
> +
> +	.ops = {
> +		.set_desc		= pci_device_domain_set_desc,
> +	},
> +
> +	.info = {
> +		.flags			= MSI_COMMON_FLAGS | MSI_FLAG_MULTI_PCI_MSI,
> +		.bus_token		= DOMAIN_BUS_PCI_DEVICE_MSI,
> +	},
> +};
> +
> +static void pci_mask_msix(struct irq_data *data)
> +{
> +	pci_msix_mask(irq_data_get_msi_desc(data));
> +}
> +
> +static void pci_unmask_msix(struct irq_data *data)
> +{
> +	pci_msix_unmask(irq_data_get_msi_desc(data));
> +}
> +
> +static struct msi_domain_template pci_msix_template = {
> +	.chip = {
> +		.name			= "PCI-MSIX",
> +		.irq_mask		= pci_mask_msix,
> +		.irq_unmask		= pci_unmask_msix,
> +		.irq_write_msi_msg	= pci_msi_domain_write_msg,
> +		.flags			= IRQCHIP_ONESHOT_SAFE,
> +	},
> +
> +	.ops = {
> +		.set_desc		= pci_device_domain_set_desc,
> +	},
> +
> +	.info = {
> +		.flags			= MSI_COMMON_FLAGS | MSI_FLAG_PCI_MSIX,
> +		.bus_token		= DOMAIN_BUS_PCI_DEVICE_MSIX,
> +	},
> +};
> +
> +static bool pci_match_device_domain(struct pci_dev *pdev, enum irq_domain_bus_token bus_token)
> +{
> +	return msi_match_device_irq_domain(&pdev->dev, MSI_DEFAULT_DOMAIN, bus_token);
> +}
> +
> +static bool pci_create_device_domain(struct pci_dev *pdev, struct msi_domain_template *tmpl,
> +				     unsigned int hwsize)
> +{
> +	struct irq_domain *domain = dev_get_msi_domain(&pdev->dev);
> +
> +	if (!domain || !irq_domain_is_msi_parent(domain))
> +		return true;
> +
> +	return msi_create_device_irq_domain(&pdev->dev, MSI_DEFAULT_DOMAIN, tmpl,
> +					    hwsize, NULL, NULL);
> +}
> +
> +/**
> + * pci_setup_msi_device_domain - Setup a device MSI interrupt domain
> + * @pdev:	The PCI device to create the domain on
> + *
> + * Return:
> + *  True when:
> + *	- The device does not have a MSI parent irq domain associated,
> + *	  which keeps the legacy architecture specific and the global
> + *	  PCI/MSI domain models working
> + *	- The MSI domain exists already
> + *	- The MSI domain was successfully allocated
> + *  False when:
> + *	- MSI-X is enabled
> + *	- The domain creation fails.
> + *
> + * The created MSI domain is preserved until:
> + *	- The device is removed
> + *	- MSI is disabled and a MSI-X domain is created
> + */
> +bool pci_setup_msi_device_domain(struct pci_dev *pdev)
> +{
> +	if (WARN_ON_ONCE(pdev->msix_enabled))
> +		return false;
> +
> +	if (pci_match_device_domain(pdev, DOMAIN_BUS_PCI_DEVICE_MSI))
> +		return true;
> +	if (pci_match_device_domain(pdev, DOMAIN_BUS_PCI_DEVICE_MSIX))
> +		msi_remove_device_irq_domain(&pdev->dev, MSI_DEFAULT_DOMAIN);
> +
> +	return pci_create_device_domain(pdev, &pci_msi_template, 1);
> +}
> +
> +/**
> + * pci_setup_msix_device_domain - Setup a device MSI-X interrupt domain
> + * @pdev:	The PCI device to create the domain on
> + * @hwsize:	The size of the MSI-X vector table
> + *
> + * Return:
> + *  True when:
> + *	- The device does not have a MSI parent irq domain associated,
> + *	  which keeps the legacy architecture specific and the global
> + *	  PCI/MSI domain models working
> + *	- The MSI-X domain exists already
> + *	- The MSI-X domain was successfully allocated
> + *  False when:
> + *	- MSI is enabled
> + *	- The domain creation fails.
> + *
> + * The created MSI-X domain is preserved until:
> + *	- The device is removed
> + *	- MSI-X is disabled and a MSI domain is created
> + */
> +bool pci_setup_msix_device_domain(struct pci_dev *pdev, unsigned int hwsize)
> +{
> +	if (WARN_ON_ONCE(pdev->msix_enabled))
> +		return false;
> +
> +	if (pci_match_device_domain(pdev, DOMAIN_BUS_PCI_DEVICE_MSIX))
> +		return true;
> +	if (pci_match_device_domain(pdev, DOMAIN_BUS_PCI_DEVICE_MSI))
> +		msi_remove_device_irq_domain(&pdev->dev, MSI_DEFAULT_DOMAIN);
> +
> +	return pci_create_device_domain(pdev, &pci_msix_template, hwsize);
> +}
> +
>  /**
>   * pci_msi_domain_supports - Check for support of a particular feature flag
>   * @pdev:		The PCI device to operate on
> @@ -152,13 +316,33 @@ bool pci_msi_domain_supports(struct pci_
>  {
>  	struct msi_domain_info *info;
>  	struct irq_domain *domain;
> +	unsigned int supported;
>  
>  	domain = dev_get_msi_domain(&pdev->dev);
>  
>  	if (!domain || !irq_domain_is_hierarchy(domain))
>  		return mode == ALLOW_LEGACY;
> -	info = domain->host_data;
> -	return (info->flags & feature_mask) == feature_mask;
> +
> +	if (!irq_domain_is_msi_parent(domain)) {
> +		/*
> +		 * For "global" PCI/MSI interrupt domains the associated
> +		 * msi_domain_info::flags is the authoritive source of

authoritative

> +		 * information.
> +		 */
> +		info = domain->host_data;
> +		supported = info->flags;
> +	} else {
> +		/*
> +		 * For MSI parent domains the supported feature set
> +		 * is avaliable in the parent ops. This makes checks

available

> +		 * possible before actually instantiating the
> +		 * per device domain because the parent is never
> +		 * expanding the PCI/MSI functionality.
> +		 */
> +		supported = domain->msi_parent_ops->supported_flags;
> +	}
> +
> +	return (supported & feature_mask) == feature_mask;
>  }
>  
>  /*
> --- a/drivers/pci/msi/msi.c
> +++ b/drivers/pci/msi/msi.c
> @@ -436,6 +436,9 @@ int __pci_enable_msi_range(struct pci_de
>  	if (rc)
>  		return rc;
>  
> +	if (!pci_setup_msi_device_domain(dev))
> +		return -ENODEV;
> +
>  	for (;;) {
>  		if (affd) {
>  			nvec = irq_calc_affinity_vectors(minvec, nvec, affd);
> @@ -787,9 +790,13 @@ int __pci_enable_msix_range(struct pci_d
>  	if (!pci_msix_validate_entries(dev, entries, nvec, hwsize))
>  		return -EINVAL;
>  
> -	/* PCI_IRQ_VIRTUAL is a horrible hack! */
> -	if (nvec > hwsize && !(flags & PCI_IRQ_VIRTUAL))
> -		nvec = hwsize;
> +	if (hwsize < nvec) {
> +		/* Keep the IRQ virtual hackery working */
> +		if (flags & PCI_IRQ_VIRTUAL)
> +			hwsize = nvec;
> +		else
> +			nvec = hwsize;
> +	}
>  
>  	if (nvec < minvec)
>  		return -ENOSPC;
> @@ -798,6 +805,9 @@ int __pci_enable_msix_range(struct pci_d
>  	if (rc)
>  		return rc;
>  
> +	if (!pci_setup_msix_device_domain(dev, hwsize))
> +		return -ENODEV;
> +
>  	for (;;) {
>  		if (affd) {
>  			nvec = irq_calc_affinity_vectors(minvec, nvec, affd);
> --- a/drivers/pci/msi/msi.h
> +++ b/drivers/pci/msi/msi.h
> @@ -105,6 +105,8 @@ enum support_mode {
>  };
>  
>  bool pci_msi_domain_supports(struct pci_dev *dev, unsigned int feature_mask, enum support_mode mode);
> +bool pci_setup_msi_device_domain(struct pci_dev *pdev);
> +bool pci_setup_msix_device_domain(struct pci_dev *pdev, unsigned int hwsize);
>  
>  /* Legacy (!IRQDOMAIN) fallbacks */
>  
> 
