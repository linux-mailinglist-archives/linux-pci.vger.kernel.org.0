Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7536862C3F0
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 17:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbiKPQUO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 11:20:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiKPQUN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 11:20:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0206027F;
        Wed, 16 Nov 2022 08:20:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 72AE661EB3;
        Wed, 16 Nov 2022 16:20:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91D5EC433D6;
        Wed, 16 Nov 2022 16:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668615611;
        bh=X2C68F6q+wNuxGuKjgaLTWW+7T0jqD6TQBHmxJHvCls=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=mpKmZmtb694pYOb3OIpj770lfq9Syc2gJH9Fq9VGYEi9b0ro695T1OtPaujdLCDyc
         U9DVRo3n7QcdLtaqqHCo0c+tMMj9V8bGs7Gun02LNGwzjZuI09Jr4Nn2muenuWQ0pc
         uPX5MKjE6ujs+AKWS1FfMDVvYRjD4chlTJc3NhjRzlOBbfHtMpvcTdKjNyfWYjae/y
         BgJDfjvlr4kDY1rs+rlKejlnZ5WJPr+XmyXhG1FEZ49J1Wyj7jk1vzgpXf+xcP9Zd/
         mnHjvNAgyI7QPRrx5yGiD8owvqpx5B+CCHXKZLIp1xM42kwoX+pWoEmLrOT9PykCyA
         8NX7uGQFq+qfg==
Date:   Wed, 16 Nov 2022 10:20:10 -0600
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
Subject: Re: [patch 21/39] PCI/MSI: Move pci_enable_msix_range() to api.c
Message-ID: <20221116162010.GA1115209@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111122014.813792885@linutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 11, 2022 at 02:54:48PM +0100, Thomas Gleixner wrote:
> From: Ahmed S. Darwish <darwi@linutronix.de>
> 
> To distangle the maze in msi.c, all exported device-driver MSI APIs are
> now to be grouped in one file, api.c.
> 
> Move pci_enable_msix_range() and make its kernel-doc comprehensive.
> 
> Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/msi/api.c | 32 ++++++++++++++++++++++++++++++++
>  drivers/pci/msi/msi.c | 30 ++++--------------------------
>  drivers/pci/msi/msi.h |  3 +++
>  3 files changed, 39 insertions(+), 26 deletions(-)
> ---
> diff --git a/drivers/pci/msi/api.c b/drivers/pci/msi/api.c
> index 63d7f8f6a284..d48050555d55 100644
> --- a/drivers/pci/msi/api.c
> +++ b/drivers/pci/msi/api.c
> @@ -58,3 +58,35 @@ void pci_disable_msi(struct pci_dev *dev)
>  	msi_unlock_descs(&dev->dev);
>  }
>  EXPORT_SYMBOL(pci_disable_msi);
> +
> +/**
> + * pci_enable_msix_range() - Enable MSI-X interrupt mode on device
> + * @dev:     the PCI device to operate on
> + * @entries: input/output parameter, array of MSI-X configuration entries
> + * @minvec:  minimum required number of MSI-X vectors
> + * @maxvec:  maximum desired number of MSI-X vectors
> + *
> + * Legacy device driver API to enable MSI-X interrupt mode on device and
> + * configure its MSI-X capability structure as appropriate.  The passed
> + * @entries array must have each of its members "entry" field set to a
> + * desired (valid) MSI-X vector number, where the range of valid MSI-X
> + * vector numbers can be queried through pci_msix_vec_count().  If
> + * successful, the driver must invoke pci_disable_msix() on cleanup.
> + *
> + * NOTE: The newer pci_alloc_irq_vectors() / pci_free_irq_vectors() API
> + * pair should, in general, be used instead.
> + *
> + * Return: number of MSI-X vectors allocated (which might be smaller
> + * than @maxvecs), where Linux IRQ numbers for such allocated vectors
> + * are saved back in the @entries array elements' "vector" field. Return
> + * -ENOSPC if less than @minvecs interrupt vectors are available.
> + * Return -EINVAL if one of the passed @entries members "entry" field
> + * was invalid or a duplicate, or if plain MSI interrupts mode was
> + * earlier enabled on device. Return other errnos otherwise.
> + */
> +int pci_enable_msix_range(struct pci_dev *dev, struct msix_entry *entries,
> +			  int minvec, int maxvec)
> +{
> +	return __pci_enable_msix_range(dev, entries, minvec, maxvec, NULL, 0);
> +}
> +EXPORT_SYMBOL(pci_enable_msix_range);
> diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
> index 98f07ad9af62..6700ef1c734e 100644
> --- a/drivers/pci/msi/msi.c
> +++ b/drivers/pci/msi/msi.c
> @@ -844,10 +844,10 @@ int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec,
>  	}
>  }
>  
> -static int __pci_enable_msix_range(struct pci_dev *dev,
> -				   struct msix_entry *entries, int minvec,
> -				   int maxvec, struct irq_affinity *affd,
> -				   int flags)
> +int __pci_enable_msix_range(struct pci_dev *dev,
> +			    struct msix_entry *entries, int minvec,
> +			    int maxvec, struct irq_affinity *affd,
> +			    int flags)
>  {
>  	int rc, nvec = maxvec;
>  
> @@ -887,28 +887,6 @@ static int __pci_enable_msix_range(struct pci_dev *dev,
>  }
>  
>  /**
> - * pci_enable_msix_range - configure device's MSI-X capability structure
> - * @dev: pointer to the pci_dev data structure of MSI-X device function
> - * @entries: pointer to an array of MSI-X entries
> - * @minvec: minimum number of MSI-X IRQs requested
> - * @maxvec: maximum number of MSI-X IRQs requested
> - *
> - * Setup the MSI-X capability structure of device function with a maximum
> - * possible number of interrupts in the range between @minvec and @maxvec
> - * upon its software driver call to request for MSI-X mode enabled on its
> - * hardware device function. It returns a negative errno if an error occurs.
> - * If it succeeds, it returns the actual number of interrupts allocated and
> - * indicates the successful configuration of MSI-X capability structure
> - * with new allocated MSI-X interrupts.
> - **/
> -int pci_enable_msix_range(struct pci_dev *dev, struct msix_entry *entries,
> -		int minvec, int maxvec)
> -{
> -	return __pci_enable_msix_range(dev, entries, minvec, maxvec, NULL, 0);
> -}
> -EXPORT_SYMBOL(pci_enable_msix_range);
> -
> -/**
>   * pci_alloc_irq_vectors_affinity - allocate multiple IRQs for a device
>   * @dev:		PCI device to operate on
>   * @min_vecs:		minimum number of vectors required (must be >= 1)
> diff --git a/drivers/pci/msi/msi.h b/drivers/pci/msi/msi.h
> index 00bb98d5bb0e..8c4a5289432d 100644
> --- a/drivers/pci/msi/msi.h
> +++ b/drivers/pci/msi/msi.h
> @@ -88,8 +88,11 @@ static inline __attribute_const__ u32 msi_multi_mask(struct msi_desc *desc)
>  void pci_msi_shutdown(struct pci_dev *dev);
>  void pci_free_msi_irqs(struct pci_dev *dev);
>  int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec, struct irq_affinity *affd);
> +int __pci_enable_msix_range(struct pci_dev *dev, struct msix_entry *entries, int minvec,
> +			    int maxvec,  struct irq_affinity *affd, int flags);
>  
>  /* Legacy (!IRQDOMAIN) fallbacks */
> +
>  #ifdef CONFIG_PCI_MSI_ARCH_FALLBACKS
>  int pci_msi_legacy_setup_msi_irqs(struct pci_dev *dev, int nvec, int type);
>  void pci_msi_legacy_teardown_msi_irqs(struct pci_dev *dev);
> 
