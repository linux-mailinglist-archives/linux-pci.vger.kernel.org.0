Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 531B062CA64
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 21:14:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233544AbiKPUOu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 15:14:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233338AbiKPUOt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 15:14:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B55FD6034D;
        Wed, 16 Nov 2022 12:14:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4832761F84;
        Wed, 16 Nov 2022 20:14:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78296C433D6;
        Wed, 16 Nov 2022 20:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668629687;
        bh=QGWrdJswRZ+5yrZUTsW86QO3FLTDR896BaBKEwMzyfE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=eZv46jQjH1drJUPxSx+ts6emAU55lOseF/oQBf5a+110lN0j5TBWw6MlDW8SfVWAA
         kLvtbqjSaCXjVrLsnLO7IrO/RAUVHBgDZWzeakG26qvQPrCticWGd5JnfUSlvYL6KU
         aqFgMUqWpCTg0oEXCV4xgQM9rbEwQ551G91fwKHRxseUbeDDEimN9mPNMlIgBsPqfS
         BcWGjatlMDe8bIlYXVeGvtONLVzHTMbbz0v2US4QND4G4BWv9FRigg4KQgOTcbP0l7
         rFNDZVSzFq0rokENyCSPty6Y4mMGX/Bcg3CEA/u0HAjzOxnFW48bpsQKXn0dnjMKOx
         nZFpJ6Qgi29dA==
Date:   Wed, 16 Nov 2022 14:14:46 -0600
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
Subject: Re: [patch 29/33] PCI/MSI: Provide pci_ims_alloc/free_irq()
Message-ID: <20221116201446.GA1133708@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111135206.912428659@linutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 11, 2022 at 02:58:57PM +0100, Thomas Gleixner wrote:
> Single vector allocation which allocates the next free index in the IMS
> space. The free function releases.
> 
> All allocated vectors are released also via pci_free_vectors() which is
> also releasing MSI/MSI-X vectors.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

I would probably capitalize "ID" in the function comment below, but
either way.

> ---
>  drivers/pci/msi/api.c |   50 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/pci.h   |    3 +++
>  2 files changed, 53 insertions(+)
> 
> --- a/drivers/pci/msi/api.c
> +++ b/drivers/pci/msi/api.c
> @@ -361,6 +361,56 @@ const struct cpumask *pci_irq_get_affini
>  EXPORT_SYMBOL(pci_irq_get_affinity);
>  
>  /**
> + * pci_ims_alloc_irq - Allocate an interrupt on a PCI/IMS interrupt domain
> + * @dev:	The PCI device to operate on
> + * @cookie:	Pointer to an IMS implementation specific device cookie
> + *		(PASID, queue id, pointer...). The cookie content is stored
> + *		in the MSI descriptor for the interrupt chip callbacks or
> + *		domain specific setup functions
> + * @affdesc:	Optional pointer to an interrupt affinity descriptor
> + *
> + * Return: A struct msi_map
> + *
> + *	On success msi_map::index contains the allocated index (>= 0) and
> + *	msi_map::virq the allocated Linux interrupt number (> 0).
> + *
> + *	On fail msi_map::index contains the error code and msi_map::virq
> + *	is set to 0.
> + *
> + * Note: There is no index for IMS allocations as IMS is an implementation
> + *	 specific storage and does not have any direct associations between
> + *	 index, which might be a pure software construct, and device
> + *	 functionality. This association is established by the driver either
> + *	 via the index - if there is a hardware table - or in case of purely
> + *	 software managed IMS implementation the association happens via
> + *	 the irq_write_msi_msg() callback of the implementation specific
> + *	 interrupt chip, which utilizes the provided @cookie to store the MSI
> + *	 message in the appropriate place.
> + */
> +struct msi_map pci_ims_alloc_irq(struct pci_dev *dev, union msi_dev_cookie *cookie,
> +				 const struct irq_affinity_desc *affdesc)
> +{
> +	return msi_domain_alloc_irq_at(&dev->dev, MSI_SECONDARY_DOMAIN, MSI_ANY_INDEX,
> +				       affdesc, cookie);
> +}
> +EXPORT_SYMBOL_GPL(pci_ims_alloc_irq);
> +
> +/**
> + * pci_ims_free_irq - Allocate an interrupt on a PCI/IMS interrupt domain
> + *		      which was allocated via pci_ims_alloc_irq()
> + * @dev:	The PCI device to operate on
> + * @map:	A struct msi_map describing the interrupt to free as
> + *		returned from pci_ims_alloc_irq()
> + */
> +void pci_ims_free_irq(struct pci_dev *dev, struct msi_map map)
> +{
> +	if (WARN_ON_ONCE(map.index < 0 || !map.virq))
> +		return;
> +	msi_domain_free_irqs_range(&dev->dev, MSI_SECONDARY_DOMAIN, map.index, map.index);
> +}
> +EXPORT_SYMBOL_GPL(pci_ims_free_irq);
> +
> +/**
>   * pci_free_irq_vectors() - Free previously allocated IRQs for a device
>   * @dev: the PCI device to operate on
>   *
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -2485,6 +2485,9 @@ struct msi_domain_template;
>  
>  bool pci_create_ims_domain(struct pci_dev *pdev, const struct msi_domain_template *template,
>  			   unsigned int hwsize, void *data);
> +struct msi_map pci_ims_alloc_irq(struct pci_dev *pdev, union msi_dev_cookie *cookie,
> +				 const struct irq_affinity_desc *affdesc);
> +void pci_ims_free_irq(struct pci_dev *pdev, struct msi_map map);
>  
>  #include <linux/dma-mapping.h>
>  
> 
