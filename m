Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8C1262C486
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 17:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233530AbiKPQew (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 11:34:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233706AbiKPQee (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 11:34:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA1F682A4;
        Wed, 16 Nov 2022 08:26:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E3C27B81DED;
        Wed, 16 Nov 2022 16:26:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 557FBC433D6;
        Wed, 16 Nov 2022 16:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668615979;
        bh=73LMr939EWHPt+TPzYln4/nGtq+P1TBpXelJNWyyGSw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=epxWFDk7HPFmaZbjDCJ/ydB3mEoQMH2j2yq0y0yM+vh4Ncs5Axxm3vHFp/z0m8QO6
         +h5qF/vT2V3jfzyKyhJErOVm5EzgpAv/iAcbfQEBLr9kpS8GvqamucPk5Ck9uYNS32
         QhA/pgN8B8KBzNYipQnqqdIrni5bENZVQugvGtmj+tanFnlbZqD5t9dxthWSNiI85n
         +OHTEvmWILrt4VKS0LCh4ka9s9FD9PdCar5liUHDakWYHaVQGkspn6xbd2LyoaYD5J
         r2MMCspMk/5CkyNDskzxCPUfhro4JgY3PryiLpoYF8kczw9WLBRxHWI+CbN2aI/3rj
         MGQB7KX2ICXeQ==
Date:   Wed, 16 Nov 2022 10:26:17 -0600
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
Subject: Re: [patch 27/39] PCI/MSI: Move pci_disable_msix() to api.c
Message-ID: <20221116162617.GA1115753@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111122015.156785224@linutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 11, 2022 at 02:54:58PM +0100, Thomas Gleixner wrote:
> From: Ahmed S. Darwish <darwi@linutronix.de>
> 
> To distangle the maze in msi.c, all exported device-driver MSI APIs are
> now to be grouped in one file, api.c.
> 
> Move pci_disable_msix() and make its kernel-doc comprehensive.
> 
> Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Trivial question below.

> ---
>  drivers/pci/msi/api.c | 24 ++++++++++++++++++++++++
>  drivers/pci/msi/msi.c | 14 +-------------
>  drivers/pci/msi/msi.h |  1 +
>  3 files changed, 26 insertions(+), 13 deletions(-)
> ---
> diff --git a/drivers/pci/msi/api.c b/drivers/pci/msi/api.c
> index 83ea38ffa116..653a61868ae6 100644
> --- a/drivers/pci/msi/api.c
> +++ b/drivers/pci/msi/api.c
> @@ -112,6 +112,30 @@ int pci_enable_msix_range(struct pci_dev *dev, struct msix_entry *entries,
>  EXPORT_SYMBOL(pci_enable_msix_range);
>  
>  /**
> + * pci_disable_msix() - Disable MSI-X interrupt mode on device
> + * @dev: the PCI device to operate on
> + *
> + * Legacy device driver API to disable MSI-X interrupt mode on device,
> + * free earlier-allocated interrupt vectors, and restore INTx emulation.

Isn't INTx *emulation* a PCIe implementation detail?  Doesn't seem
relevant to callers that it's emulated.

> + * The PCI device Linux IRQ (@dev->irq) is restored to its default pin
> + * assertion IRQ. This is the cleanup pair of pci_enable_msix_range().
> + *
> + * NOTE: The newer pci_alloc_irq_vectors() / pci_free_irq_vectors() API
> + * pair should, in general, be used instead.
> + */
> +void pci_disable_msix(struct pci_dev *dev)
> +{
> +	if (!pci_msi_enabled() || !dev || !dev->msix_enabled)
> +		return;
> +
> +	msi_lock_descs(&dev->dev);
> +	pci_msix_shutdown(dev);
> +	pci_free_msi_irqs(dev);
> +	msi_unlock_descs(&dev->dev);
> +}
> +EXPORT_SYMBOL(pci_disable_msix);
> +
> +/**
>   * pci_alloc_irq_vectors() - Allocate multiple device interrupt vectors
>   * @dev:      the PCI device to operate on
>   * @min_vecs: minimum required number of vectors (must be >= 1)
> diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
> index 1226d66da992..6fa90d07d2e4 100644
> --- a/drivers/pci/msi/msi.c
> +++ b/drivers/pci/msi/msi.c
> @@ -736,7 +736,7 @@ static int __pci_enable_msix(struct pci_dev *dev, struct msix_entry *entries,
>  	return msix_capability_init(dev, entries, nvec, affd);
>  }
>  
> -static void pci_msix_shutdown(struct pci_dev *dev)
> +void pci_msix_shutdown(struct pci_dev *dev)
>  {
>  	struct msi_desc *desc;
>  
> @@ -758,18 +758,6 @@ static void pci_msix_shutdown(struct pci_dev *dev)
>  	pcibios_alloc_irq(dev);
>  }
>  
> -void pci_disable_msix(struct pci_dev *dev)
> -{
> -	if (!pci_msi_enable || !dev || !dev->msix_enabled)
> -		return;
> -
> -	msi_lock_descs(&dev->dev);
> -	pci_msix_shutdown(dev);
> -	pci_free_msi_irqs(dev);
> -	msi_unlock_descs(&dev->dev);
> -}
> -EXPORT_SYMBOL(pci_disable_msix);
> -
>  int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec,
>  			   struct irq_affinity *affd)
>  {
> diff --git a/drivers/pci/msi/msi.h b/drivers/pci/msi/msi.h
> index 8c4a5289432d..77e2587f7e4f 100644
> --- a/drivers/pci/msi/msi.h
> +++ b/drivers/pci/msi/msi.h
> @@ -86,6 +86,7 @@ static inline __attribute_const__ u32 msi_multi_mask(struct msi_desc *desc)
>  
>  /* MSI internal functions invoked from the public APIs */
>  void pci_msi_shutdown(struct pci_dev *dev);
> +void pci_msix_shutdown(struct pci_dev *dev);
>  void pci_free_msi_irqs(struct pci_dev *dev);
>  int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec, struct irq_affinity *affd);
>  int __pci_enable_msix_range(struct pci_dev *dev, struct msix_entry *entries, int minvec,
> 
