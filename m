Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCCE362C42E
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 17:23:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238704AbiKPQXu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 11:23:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237640AbiKPQWw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 11:22:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C19C157B62;
        Wed, 16 Nov 2022 08:22:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F04561EC4;
        Wed, 16 Nov 2022 16:22:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CB89C43470;
        Wed, 16 Nov 2022 16:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668615731;
        bh=gijm9WgljZaZJl0BwvkKpLhLs5VMOo1VnDWNFADbiCo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=TZn7pEwkK/vcdohvHlBe7c8EAiUHeoEyrLMFW9hHccGUVfCedOkVWDEycBL3kOBqs
         HM2kzidM9PHkiRWOfciHwtMi+N4xzYI0ClgZOTF5intqMrh98KK7CuhW/TzisKiKgR
         KIgGixbytdj4W1ClfrRukH99CmlEOyx6LgthVRIOTBo/802CNUOufEZjVREHBhBmFF
         wSYxoQdmZl1a+3uR/z+xXgxfOm2bN4Ebq4hk9ThOkgp+MNg57h4qCDJ6Mj4jpq0SBI
         qcn8sVsqpUQ/mx/hAsezFPyadLUfE4d31JDEzp57iATUi7NhbNI4upKC/M9r4WSRIu
         AcHEJ99x9lSNg==
Date:   Wed, 16 Nov 2022 10:22:10 -0600
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
Subject: Re: [patch 22/39] PCI/MSI: Move pci_alloc_irq_vectors() to api.c
Message-ID: <20221116162210.GA1115315@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111122014.870888193@linutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 11, 2022 at 02:54:50PM +0100, Thomas Gleixner wrote:
> From: Ahmed S. Darwish <darwi@linutronix.de>
> 
> To distangle the maze in msi.c, all exported device-driver MSI APIs are
> now to be grouped in one file, api.c.
> 
> Make pci_alloc_irq_vectors() a real function instead of wrapper and add
> proper kernel doc to it.
> 
> Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Two nits below.

> ---
>  drivers/pci/msi/api.c | 33 +++++++++++++++++++++++++++++++++
>  include/linux/pci.h   | 17 +++++++++--------
>  2 files changed, 42 insertions(+), 8 deletions(-)
> ---
> diff --git a/drivers/pci/msi/api.c b/drivers/pci/msi/api.c
> index d48050555d55..1714905943fb 100644
> --- a/drivers/pci/msi/api.c
> +++ b/drivers/pci/msi/api.c
> @@ -90,3 +90,36 @@ int pci_enable_msix_range(struct pci_dev *dev, struct msix_entry *entries,
>  	return __pci_enable_msix_range(dev, entries, minvec, maxvec, NULL, 0);
>  }
>  EXPORT_SYMBOL(pci_enable_msix_range);
> +
> +/**
> + * pci_alloc_irq_vectors() - Allocate multiple device interrupt vectors
> + * @dev:      the PCI device to operate on
> + * @min_vecs: minimum required number of vectors (must be >= 1)
> + * @max_vecs: maximum desired number of vectors
> + * @flags:    One or more of:
> + *            %PCI_IRQ_MSIX      Allow trying MSI-X vector allocations
> + *            %PCI_IRQ_MSI       Allow trying MSI vector allocations
> + *            %PCI_IRQ_LEGACY    Allow trying legacy INTx interrupts, if
> + *                               and only if @min_vecs == 1
> + *            %PCI_IRQ_AFFINITY  Auto-manage IRQs affinity by spreading
> + *                               the vectors around available CPUs
> + *
> + * Allocate up to @max_vecs interrupt vectors on device. MSI-X irq

s/irq/IRQ/

> + * vector allocation has a higher precedence over plain MSI, which has a
> + * higher precedence over legacy INTx emulation.
> + *
> + * Upon a successful allocation, the caller should use pci_irq_vector()
> + * to get the Linux IRQ number to be passed to request_threaded_irq().
> + * The driver must call pci_free_irq_vectors() on cleanup.
> + *
> + * Return: number of allocated vectors (which might be smaller than
> + * @max_vecs), -ENOSPC if less than @min_vecs interrupt vectors are

s/less/fewer/ (also in some previous patches, IIRC)

> + * available, other errnos otherwise.
> + */
> +int pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
> +			  unsigned int max_vecs, unsigned int flags)
> +{
> +	return pci_alloc_irq_vectors_affinity(dev, min_vecs, max_vecs,
> +					      flags, NULL);
> +}
> +EXPORT_SYMBOL(pci_alloc_irq_vectors);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 2bda4a4e47e8..6a356a39ba94 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1553,6 +1553,8 @@ static inline int pci_enable_msix_exact(struct pci_dev *dev,
>  		return rc;
>  	return 0;
>  }
> +int pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
> +			  unsigned int max_vecs, unsigned int flags);
>  int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
>  				   unsigned int max_vecs, unsigned int flags,
>  				   struct irq_affinity *affd);
> @@ -1586,6 +1588,13 @@ pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
>  		return 1;
>  	return -ENOSPC;
>  }
> +static inline int
> +pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
> +		      unsigned int max_vecs, unsigned int flags)
> +{
> +	return pci_alloc_irq_vectors_affinity(dev, min_vecs, max_vecs,
> +					      flags, NULL);
> +}
>  
>  static inline void pci_free_irq_vectors(struct pci_dev *dev)
>  {
> @@ -1900,14 +1909,6 @@ pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
>  }
>  #endif /* CONFIG_PCI */
>  
> -static inline int
> -pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
> -		      unsigned int max_vecs, unsigned int flags)
> -{
> -	return pci_alloc_irq_vectors_affinity(dev, min_vecs, max_vecs, flags,
> -					      NULL);
> -}
> -
>  /* Include architecture-dependent settings and functions */
>  
>  #include <asm/pci.h>
> 
