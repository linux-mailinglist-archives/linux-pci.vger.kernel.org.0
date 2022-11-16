Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0093762CA9C
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 21:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233325AbiKPUTa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 15:19:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbiKPUT3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 15:19:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C054B43AEA;
        Wed, 16 Nov 2022 12:19:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 51CBD61F8C;
        Wed, 16 Nov 2022 20:19:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71F48C433D6;
        Wed, 16 Nov 2022 20:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668629967;
        bh=xfZns+/CLbhHx47KgSYAUimVfvmMzQKOWas5PrCZtk8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=tc7RNyMIIiBFVo8Q43esoXmfqjwIHFsbBn3K4lvC5/D7N5QXtszqaz5ME1MeY1a6f
         wo4lYTNF0ihqf14R1Y8sc7ypXKQ+HZKa6WHOq6VWE32UAdKTisaHW8DwSVkbMV4KZO
         3xPK/rWEARYIhtBiNHSXKMc0LxZuEsynDSJ7l0FFhtteOeaMUKOIlYhNl6KvOGqcIA
         eiczxoTtV2AizB6FlTem64juQ3MDS3CO6sK/CanMrgRrgmRny90QZVJCIC135h1J5r
         wGuepEj5CPbSmSrjVaMkTBjau4DJc08rwpX8BKeN3teu8/SRfUi75j5kMo+QN/QQQl
         Yw/KwjUmt6dBQ==
Date:   Wed, 16 Nov 2022 14:19:26 -0600
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
Subject: Re: [patch 25/33] PCI/MSI: Provide post-enable dynamic allocation
 interfaces for MSI-X
Message-ID: <20221116201926.GA1133983@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111135206.688367117@linutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 11, 2022 at 02:58:51PM +0100, Thomas Gleixner wrote:
> MSI-X vectors can be allocated after the initial MSI-X enablement, but this
> needs explicit support of the underlying interrupt domains.
> 
> Provide a function to query the ability and functions to allocate/free
> individual vectors post-enable.
> 
> The allocation can either request a specific index in the MSI-X table or
> with the index argument MSI_ANY_INDEX it allocates the next free vector.
> 
> The return value is a struct msi_map which on success contains both index
> and the Linux interrupt number. In case of failure index is negative and
> the Linux interrupt number is 0.
> 
> The allocation function is for a single MSI-X index at a time as that's
> sufficient for the most urgent use case VFIO to get rid of the 'disable
> MSI-X, reallocate, enable-MSI-X' cycle which is prone to lost interrupts
> and redirections to the legacy and obviously unhandled INTx.
> 
> Also for the use cases Jason Gunthorpe pointed a single index allocation
> is sufficient.

Maybe a URL or outline the use cases so this means something in a few
years?  I haven't followed this discussion, so it doesn't even mean
anything to me now :)

> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/msi/api.c       |   67 ++++++++++++++++++++++++++++++++++++++++++++
>  drivers/pci/msi/irqdomain.c |    3 +
>  include/linux/pci.h         |    6 +++
>  3 files changed, 75 insertions(+), 1 deletion(-)
> 
> --- a/drivers/pci/msi/api.c
> +++ b/drivers/pci/msi/api.c
> @@ -113,6 +113,73 @@ int pci_enable_msix_range(struct pci_dev
>  EXPORT_SYMBOL(pci_enable_msix_range);
>  
>  /**
> + * pci_msix_can_alloc_dyn - Query whether dynamic allocation after enabling
> + *			    MSI-X is supported
> + *
> + * @dev:	PCI device to operate on
> + *
> + * Return: True if supported, false otherwise
> + */
> +bool pci_msix_can_alloc_dyn(struct pci_dev *dev)
> +{
> +	if (!dev->msix_cap)
> +		return false;
> +
> +	return pci_msi_domain_supports(dev, MSI_FLAG_PCI_MSIX_ALLOC_DYN, DENY_LEGACY);
> +}
> +EXPORT_SYMBOL_GPL(pci_msix_can_alloc_dyn);
> +
> +/**
> + * pci_msix_alloc_irq_at - Allocate an MSI-X interrupt after enabling MSI-X
> + *			   at a given MSI-X vector index or any free vector index
> + *
> + * @dev:	PCI device to operate on
> + * @index:	Index to allocate. If @index == MSI_ANY_INDEX this allocates
> + *		the next free index in the MSI-X table
> + * @affdesc:	Optional pointer to an affinity descriptor structure. NULL otherwise
> + *
> + * Return: A struct msi_map
> + *
> + *	On success msi_map::index contains the allocated index (>= 0) and
> + *	msi_map::virq the allocated Linux interrupt number (> 0).
> + *
> + *	On fail msi_map::index contains the error code and msi_map::virq
> + *	is set to 0.
> + */
> +struct msi_map pci_msix_alloc_irq_at(struct pci_dev *dev, unsigned int index,
> +				     const struct irq_affinity_desc *affdesc)
> +{
> +	struct msi_map map = { .index = -ENOTSUPP };
> +
> +	if (!dev->msix_enabled)
> +		return map;
> +
> +	if (!pci_msix_can_alloc_dyn(dev))
> +		return map;
> +
> +	return msi_domain_alloc_irq_at(&dev->dev, MSI_DEFAULT_DOMAIN, index, affdesc, NULL);
> +}
> +EXPORT_SYMBOL_GPL(pci_msix_alloc_irq_at);
> +
> +/**
> + * pci_msix_free_irq - Free an interrupt on a PCI/MSIX interrupt domain
> + *		      which was allocated via pci_msix_alloc_irq_at()
> + *
> + * @dev:	The PCI device to operate on
> + * @map:	A struct msi_map describing the interrupt to free
> + *		as returned from the allocation function.
> + */
> +void pci_msix_free_irq(struct pci_dev *dev, struct msi_map map)
> +{
> +	if (WARN_ON_ONCE(map.index < 0 || map.virq <= 0))
> +		return;
> +	if (WARN_ON_ONCE(!pci_msix_can_alloc_dyn(dev)))
> +		return;
> +	msi_domain_free_irqs_range(&dev->dev, MSI_DEFAULT_DOMAIN, map.index, map.index);
> +}
> +EXPORT_SYMBOL_GPL(pci_msix_free_irq);
> +
> +/**
>   * pci_disable_msix() - Disable MSI-X interrupt mode on device
>   * @dev: the PCI device to operate on
>   *
> --- a/drivers/pci/msi/irqdomain.c
> +++ b/drivers/pci/msi/irqdomain.c
> @@ -225,7 +225,8 @@ static struct msi_domain_template pci_ms
>  	},
>  
>  	.info = {
> -		.flags			= MSI_COMMON_FLAGS | MSI_FLAG_PCI_MSIX,
> +		.flags			= MSI_COMMON_FLAGS | MSI_FLAG_PCI_MSIX |
> +					  MSI_FLAG_PCI_MSIX_ALLOC_DYN,
>  		.bus_token		= DOMAIN_BUS_PCI_DEVICE_MSIX,
>  	},
>  };
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -38,6 +38,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/resource_ext.h>
> +#include <linux/msi_api.h>
>  #include <uapi/linux/pci.h>
>  
>  #include <linux/pci_ids.h>
> @@ -1559,6 +1560,11 @@ int pci_alloc_irq_vectors_affinity(struc
>  				   unsigned int max_vecs, unsigned int flags,
>  				   struct irq_affinity *affd);
>  
> +bool pci_msix_can_alloc_dyn(struct pci_dev *dev);
> +struct msi_map pci_msix_alloc_irq_at(struct pci_dev *dev, unsigned int index,
> +				     const struct irq_affinity_desc *affdesc);
> +void pci_msix_free_irq(struct pci_dev *pdev, struct msi_map map);
> +
>  void pci_free_irq_vectors(struct pci_dev *dev);
>  int pci_irq_vector(struct pci_dev *dev, unsigned int nr);
>  const struct cpumask *pci_irq_get_affinity(struct pci_dev *pdev, int vec);
> 
