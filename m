Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82AF262C3EC
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 17:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbiKPQTH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 11:19:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234465AbiKPQSn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 11:18:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A11D49B69;
        Wed, 16 Nov 2022 08:18:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B21CA61EB5;
        Wed, 16 Nov 2022 16:18:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D73DAC433D6;
        Wed, 16 Nov 2022 16:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668615521;
        bh=xsQa1DiNL/6zsloEcEu6Ukvgx+aoLHbVelli9P0JdkE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=FlscaLWaTxDQUiFYrKfxiw8Is512INpNfhSwD6LYRM/LnWLISkfHWVCN+HI/HB9Py
         CsOhz4ZFu9t7L185gW+tLdKnqOtA3Vi5HLkuAa1nZI7K6BAv9o39vy1Lv1qTxuBuGQ
         KyiF119c19UlukBK0owCVhyFtkaOtpHJI6YvfTw/wRpXfbq0DchoKF8zCS3SR5PP3q
         ZwhtzlykAPL9KZKn5sXdOJ5n5ZirM7s3EoBn1D84oSCdfUjX2DfIIqirJqJOU53hDC
         R07my9UXS+C1zX0eVsWpoRdG26lfCPZWHT7PBdtjzRHCgNFiNEyVCzm12MEAqnv7fj
         ixetgCl6U1k3g==
Date:   Wed, 16 Nov 2022 10:18:39 -0600
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
Subject: Re: [patch 20/39] PCI/MSI: Move pci_enable_msi() API to api.c
Message-ID: <20221116161839.GA1115061@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111122014.755178149@linutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 11, 2022 at 02:54:46PM +0100, Thomas Gleixner wrote:
> From: Ahmed S. Darwish <darwi@linutronix.de>
> 
> To distangle the maze in msi.c all exported device-driver MSI APIs are now
> to be grouped in one file, api.c.
> 
> Move pci_enable_msi() and make its kernel-doc comprehensive.
> 
> Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Nit: suggest "disentangle" or "untangle" for "distangle" here and in
subsequent patches.

> ---
>  drivers/pci/msi/api.c | 23 +++++++++++++++++++++++
>  drivers/pci/msi/msi.c | 14 ++------------
>  drivers/pci/msi/msi.h |  1 +
>  3 files changed, 26 insertions(+), 12 deletions(-)
> ---
> diff --git a/drivers/pci/msi/api.c b/drivers/pci/msi/api.c
> index 7485942cbe5d..63d7f8f6a284 100644
> --- a/drivers/pci/msi/api.c
> +++ b/drivers/pci/msi/api.c
> @@ -13,6 +13,29 @@
>  #include "msi.h"
>  
>  /**
> + * pci_enable_msi() - Enable MSI interrupt mode on device
> + * @dev: the PCI device to operate on
> + *
> + * Legacy device driver API to enable MSI interrupts mode on device and
> + * allocate a single interrupt vector. On success, the allocated vector
> + * Linux IRQ will be saved at @dev->irq. The driver must invoke
> + * pci_disable_msi() on cleanup.
> + *
> + * NOTE: The newer pci_alloc_irq_vectors() / pci_free_irq_vectors() API
> + * pair should, in general, be used instead.
> + *
> + * Return: 0 on success, errno otherwise
> + */
> +int pci_enable_msi(struct pci_dev *dev)
> +{
> +	int rc = __pci_enable_msi_range(dev, 1, 1, NULL);
> +	if (rc < 0)
> +		return rc;
> +	return 0;
> +}
> +EXPORT_SYMBOL(pci_enable_msi);
> +
> +/**
>   * pci_disable_msi() - Disable MSI interrupt mode on device
>   * @dev: the PCI device to operate on
>   *
> diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
> index 4a1300b74518..98f07ad9af62 100644
> --- a/drivers/pci/msi/msi.c
> +++ b/drivers/pci/msi/msi.c
> @@ -790,8 +790,8 @@ void pci_disable_msix(struct pci_dev *dev)
>  }
>  EXPORT_SYMBOL(pci_disable_msix);
>  
> -static int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec,
> -				  struct irq_affinity *affd)
> +int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec,
> +			   struct irq_affinity *affd)
>  {
>  	int nvec;
>  	int rc;
> @@ -844,16 +844,6 @@ static int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec,
>  	}
>  }
>  
> -/* deprecated, don't use */
> -int pci_enable_msi(struct pci_dev *dev)
> -{
> -	int rc = __pci_enable_msi_range(dev, 1, 1, NULL);
> -	if (rc < 0)
> -		return rc;
> -	return 0;
> -}
> -EXPORT_SYMBOL(pci_enable_msi);
> -
>  static int __pci_enable_msix_range(struct pci_dev *dev,
>  				   struct msix_entry *entries, int minvec,
>  				   int maxvec, struct irq_affinity *affd,
> diff --git a/drivers/pci/msi/msi.h b/drivers/pci/msi/msi.h
> index 634879277349..00bb98d5bb0e 100644
> --- a/drivers/pci/msi/msi.h
> +++ b/drivers/pci/msi/msi.h
> @@ -87,6 +87,7 @@ static inline __attribute_const__ u32 msi_multi_mask(struct msi_desc *desc)
>  /* MSI internal functions invoked from the public APIs */
>  void pci_msi_shutdown(struct pci_dev *dev);
>  void pci_free_msi_irqs(struct pci_dev *dev);
> +int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec, struct irq_affinity *affd);
>  
>  /* Legacy (!IRQDOMAIN) fallbacks */
>  #ifdef CONFIG_PCI_MSI_ARCH_FALLBACKS
> 
