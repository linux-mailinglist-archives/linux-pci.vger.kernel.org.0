Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4B1A62C46E
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 17:30:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbiKPQax (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 11:30:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236124AbiKPQ3U (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 11:29:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3166279;
        Wed, 16 Nov 2022 08:23:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4D863B81DE2;
        Wed, 16 Nov 2022 16:23:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B018DC433D6;
        Wed, 16 Nov 2022 16:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668615804;
        bh=2nU4MOObR9A/jOY+gjTU6v5hsEY4DPvkpe3RAEIYrlw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=OCEybreaEgPYv/BqqRQ3ZprA2wF/mVzqFWMumzorrbm9PwwgyP2gavOSf3bXBTbLE
         ePQqu0Hxh+lTVX6IwG1qssPlkUNH0UhWlk2gmyGNirw24RU/a0IUz/57H2ulW1ImpD
         CrAkBgVxk8hU5EJt2bYGJWmJiLaVQNmU0Y6VTWTg8uxTgd4Ah3ryYfAnoqbk7I2QuD
         XHa1mYUrVQkZWcgA4nU8ME8AdPQQNueWAnSJj137wmV1aNju4nKcmF1DS85e6CVYu7
         TA8/Obo8DyRGKKtBELLz9s749ma9CqfVHJ1VvOyWOO5kPua5q5sj4VGjXmvVzskirS
         xnbhC+QUV1wvw==
Date:   Wed, 16 Nov 2022 10:23:22 -0600
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
Subject: Re: [patch 23/39] PCI/MSI: Move pci_alloc_irq_vectors_affinity() to
 api.c
Message-ID: <20221116162322.GA1115421@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111122014.927531290@linutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 11, 2022 at 02:54:51PM +0100, Thomas Gleixner wrote:
> From: Ahmed S. Darwish <darwi@linutronix.de>
> 
> To distangle the maze in msi.c, all exported device-driver MSI APIs are
> now to be grouped in one file, api.c.
> 
> Move pci_alloc_irq_vectors_affinity() and let its kernel-doc reference
> pci_alloc_irq_vectors() documentation added in parent commit.
> 
> Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

One question below.

> ---
>  drivers/pci/msi/api.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++-
>  drivers/pci/msi/msi.c | 65 +----------------------------------------------------
>  2 files changed, 59 insertions(+), 65 deletions(-)
> ---
> diff --git a/drivers/pci/msi/api.c b/drivers/pci/msi/api.c
> index 1714905943fb..8546749afa6e 100644
> --- a/drivers/pci/msi/api.c
> +++ b/drivers/pci/msi/api.c
> @@ -123,3 +123,62 @@ int pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
>  					      flags, NULL);
>  }
>  EXPORT_SYMBOL(pci_alloc_irq_vectors);
> +
> +/**
> + * pci_alloc_irq_vectors_affinity() - Allocate multiple device interrupt
> + *                                    vectors with affinity requirements
> + * @dev:      the PCI device to operate on
> + * @min_vecs: minimum required number of vectors (must be >= 1)
> + * @max_vecs: maximum desired number of vectors
> + * @flags:    allocation flags, as in pci_alloc_irq_vectors()
> + * @affd:     affinity requirements (can be %NULL).
> + *
> + * Same as pci_alloc_irq_vectors(), but with the extra @affd parameter.
> + * Check that function docs, and &struct irq_affinity, for more details.

Is "&struct irq_affinity" some kernel-doc syntax, or is the "&"
superfluous?

> + */
> +int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
> +				   unsigned int max_vecs, unsigned int flags,
> +				   struct irq_affinity *affd)
> +{
> +	struct irq_affinity msi_default_affd = {0};
> +	int nvecs = -ENOSPC;
> +
> +	if (flags & PCI_IRQ_AFFINITY) {
> +		if (!affd)
> +			affd = &msi_default_affd;
> +	} else {
> +		if (WARN_ON(affd))
> +			affd = NULL;
> +	}
> +
> +	if (flags & PCI_IRQ_MSIX) {
> +		nvecs = __pci_enable_msix_range(dev, NULL, min_vecs, max_vecs,
> +						affd, flags);
> +		if (nvecs > 0)
> +			return nvecs;
> +	}
> +
> +	if (flags & PCI_IRQ_MSI) {
> +		nvecs = __pci_enable_msi_range(dev, min_vecs, max_vecs, affd);
> +		if (nvecs > 0)
> +			return nvecs;
> +	}
> +
> +	/* use legacy IRQ if allowed */
> +	if (flags & PCI_IRQ_LEGACY) {
> +		if (min_vecs == 1 && dev->irq) {
> +			/*
> +			 * Invoke the affinity spreading logic to ensure that
> +			 * the device driver can adjust queue configuration
> +			 * for the single interrupt case.
> +			 */
> +			if (affd)
> +				irq_create_affinity_masks(1, affd);
> +			pci_intx(dev, 1);
> +			return 1;
> +		}
> +	}
> +
> +	return nvecs;
> +}
> +EXPORT_SYMBOL(pci_alloc_irq_vectors_affinity);
> diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
> index 6700ef1c734e..a028774f438d 100644
> --- a/drivers/pci/msi/msi.c
> +++ b/drivers/pci/msi/msi.c
> @@ -887,71 +887,6 @@ int __pci_enable_msix_range(struct pci_dev *dev,
>  }
>  
>  /**
> - * pci_alloc_irq_vectors_affinity - allocate multiple IRQs for a device
> - * @dev:		PCI device to operate on
> - * @min_vecs:		minimum number of vectors required (must be >= 1)
> - * @max_vecs:		maximum (desired) number of vectors
> - * @flags:		flags or quirks for the allocation
> - * @affd:		optional description of the affinity requirements
> - *
> - * Allocate up to @max_vecs interrupt vectors for @dev, using MSI-X or MSI
> - * vectors if available, and fall back to a single legacy vector
> - * if neither is available.  Return the number of vectors allocated,
> - * (which might be smaller than @max_vecs) if successful, or a negative
> - * error code on error. If less than @min_vecs interrupt vectors are
> - * available for @dev the function will fail with -ENOSPC.
> - *
> - * To get the Linux IRQ number used for a vector that can be passed to
> - * request_irq() use the pci_irq_vector() helper.
> - */
> -int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
> -				   unsigned int max_vecs, unsigned int flags,
> -				   struct irq_affinity *affd)
> -{
> -	struct irq_affinity msi_default_affd = {0};
> -	int nvecs = -ENOSPC;
> -
> -	if (flags & PCI_IRQ_AFFINITY) {
> -		if (!affd)
> -			affd = &msi_default_affd;
> -	} else {
> -		if (WARN_ON(affd))
> -			affd = NULL;
> -	}
> -
> -	if (flags & PCI_IRQ_MSIX) {
> -		nvecs = __pci_enable_msix_range(dev, NULL, min_vecs, max_vecs,
> -						affd, flags);
> -		if (nvecs > 0)
> -			return nvecs;
> -	}
> -
> -	if (flags & PCI_IRQ_MSI) {
> -		nvecs = __pci_enable_msi_range(dev, min_vecs, max_vecs, affd);
> -		if (nvecs > 0)
> -			return nvecs;
> -	}
> -
> -	/* use legacy IRQ if allowed */
> -	if (flags & PCI_IRQ_LEGACY) {
> -		if (min_vecs == 1 && dev->irq) {
> -			/*
> -			 * Invoke the affinity spreading logic to ensure that
> -			 * the device driver can adjust queue configuration
> -			 * for the single interrupt case.
> -			 */
> -			if (affd)
> -				irq_create_affinity_masks(1, affd);
> -			pci_intx(dev, 1);
> -			return 1;
> -		}
> -	}
> -
> -	return nvecs;
> -}
> -EXPORT_SYMBOL(pci_alloc_irq_vectors_affinity);
> -
> -/**
>   * pci_free_irq_vectors - free previously allocated IRQs for a device
>   * @dev:		PCI device to operate on
>   *
> 
