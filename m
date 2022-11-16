Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CEB062C4DC
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 17:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234030AbiKPQkT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 11:40:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234355AbiKPQjr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 11:39:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B1C606B6;
        Wed, 16 Nov 2022 08:35:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DC7EBB81DFA;
        Wed, 16 Nov 2022 16:35:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 428B7C433C1;
        Wed, 16 Nov 2022 16:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668616519;
        bh=7lFiLHolyMGn6ahDnXfEkllCx/9ERpAkWUrxM/p/G9s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=vKfW/nDmof5x1qGUsktU3mydNWRx1u9bhEjDkmydS/VWh2/xpfykSTgYa0kamGUhs
         bcf4kbzL85OpNgLTrOvOh2UUslQaypX7mNoM45JtDtpIR9zGOMomS1Wbgw/7SKDPN4
         tmmP8HT71SQQ/UEzl1sAGcxs9eJGv6KNlSc2olb8MF1WxILw0MgJgAWcPuFl5kwj+D
         z1yQ/14WNHo/iN+pJsOviHJqamoR8SJpWPJkbpE+qQ1QygN0RcDV4cGduF02vI7YZw
         lK5hdTJWQSFr8k6/I1uRD95isxwVgodYtg33kYJPfe+evfsZclOWu/OCv1fd5mGqma
         E+ENti03HPFZQ==
Date:   Wed, 16 Nov 2022 10:35:17 -0600
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
        Reinette Chatre <reinette.chatre@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [patch 28/39] PCI/MSI: Move pci_irq_get_affinity() to api.c
Message-ID: <20221116163517.GA1116781@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111122015.214792769@linutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 11, 2022 at 02:54:59PM +0100, Thomas Gleixner wrote:
> From: Ahmed S. Darwish <darwi@linutronix.de>
> 
> To distangle the maze in msi.c, all exported device-driver MSI APIs are
> now to be grouped in one file, api.c.
> 
> Move pci_irq_get_affinity() and let its kernel-doc match rest of the
> file.
> 
> Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

One nit below.

> ---
>  drivers/pci/msi/api.c | 43 +++++++++++++++++++++++++++++++++++++++++++
>  drivers/pci/msi/msi.c | 38 --------------------------------------
>  2 files changed, 43 insertions(+), 38 deletions(-)
> ---
> diff --git a/drivers/pci/msi/api.c b/drivers/pci/msi/api.c
> index 653a61868ae6..473df7ba0584 100644
> --- a/drivers/pci/msi/api.c
> +++ b/drivers/pci/msi/api.c
> @@ -9,6 +9,7 @@
>   */
>  
>  #include <linux/export.h>
> +#include <linux/irq.h>
>  
>  #include "msi.h"
>  
> @@ -251,6 +252,48 @@ int pci_irq_vector(struct pci_dev *dev, unsigned int nr)
>  EXPORT_SYMBOL(pci_irq_vector);
>  
>  /**
> + * pci_irq_get_affinity() - Get a device interrupt vector affinity
> + * @dev: the PCI device to operate on
> + * @nr:  device-relative interrupt vector index (0-based); has different
> + *       meanings, depending on interrupt mode
> + *         MSI-X        the index in the MSI-X vector table
> + *         MSI          the index of the enabled MSI vectors
> + *         INTx         must be 0
> + *
> + * Return: MSI/MSI-X vector affinity, NULL if @nr is out of range or if
> + * the MSI(-X) vector was allocated without explicit affinity
> + * requirements (e.g., by pci_enable_msi(), pci_enable_msix_range(), or
> + * pci_alloc_irq_vectors() without the %PCI_IRQ_AFFINITY flag). Return a
> + * generic set of CPU ids representing all possible CPUs available
> + * during system boot if the device is in legacy INTx mode.

s/ids/IDs/

> + */
> +const struct cpumask *pci_irq_get_affinity(struct pci_dev *dev, int nr)
> +{
> +	int idx, irq = pci_irq_vector(dev, nr);
> +	struct msi_desc *desc;
> +
> +	if (WARN_ON_ONCE(irq <= 0))
> +		return NULL;
> +
> +	desc = irq_get_msi_desc(irq);
> +	/* Non-MSI does not have the information handy */
> +	if (!desc)
> +		return cpu_possible_mask;
> +
> +	/* MSI[X] interrupts can be allocated without affinity descriptor */
> +	if (!desc->affinity)
> +		return NULL;
> +
> +	/*
> +	 * MSI has a mask array in the descriptor.
> +	 * MSI-X has a single mask.
> +	 */
> +	idx = dev->msi_enabled ? nr : 0;
> +	return &desc->affinity[idx].mask;
> +}
> +EXPORT_SYMBOL(pci_irq_get_affinity);
> +
> +/**
>   * pci_free_irq_vectors() - Free previously allocated IRQs for a device
>   * @dev: the PCI device to operate on
>   *
> diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
> index 6fa90d07d2e4..d78646d1c116 100644
> --- a/drivers/pci/msi/msi.c
> +++ b/drivers/pci/msi/msi.c
> @@ -854,44 +854,6 @@ int __pci_enable_msix_range(struct pci_dev *dev,
>  	}
>  }
>  
> -/**
> - * pci_irq_get_affinity - return the affinity of a particular MSI vector
> - * @dev:	PCI device to operate on
> - * @nr:		device-relative interrupt vector index (0-based).
> - *
> - * @nr has the following meanings depending on the interrupt mode:
> - *   MSI-X:	The index in the MSI-X vector table
> - *   MSI:	The index of the enabled MSI vectors
> - *   INTx:	Must be 0
> - *
> - * Return: A cpumask pointer or NULL if @nr is out of range
> - */
> -const struct cpumask *pci_irq_get_affinity(struct pci_dev *dev, int nr)
> -{
> -	int idx, irq = pci_irq_vector(dev, nr);
> -	struct msi_desc *desc;
> -
> -	if (WARN_ON_ONCE(irq <= 0))
> -		return NULL;
> -
> -	desc = irq_get_msi_desc(irq);
> -	/* Non-MSI does not have the information handy */
> -	if (!desc)
> -		return cpu_possible_mask;
> -
> -	/* MSI[X] interrupts can be allocated without affinity descriptor */
> -	if (!desc->affinity)
> -		return NULL;
> -
> -	/*
> -	 * MSI has a mask array in the descriptor.
> -	 * MSI-X has a single mask.
> -	 */
> -	idx = dev->msi_enabled ? nr : 0;
> -	return &desc->affinity[idx].mask;
> -}
> -EXPORT_SYMBOL(pci_irq_get_affinity);
> -
>  struct pci_dev *msi_desc_to_pci_dev(struct msi_desc *desc)
>  {
>  	return to_pci_dev(desc->dev);
> 
