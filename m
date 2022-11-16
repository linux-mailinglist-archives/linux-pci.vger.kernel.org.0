Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFA5362C3BF
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 17:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbiKPQQj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 11:16:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233672AbiKPQQi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 11:16:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D0BD135;
        Wed, 16 Nov 2022 08:16:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F0A29B81DD9;
        Wed, 16 Nov 2022 16:16:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 710E8C433D7;
        Wed, 16 Nov 2022 16:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668615393;
        bh=HKxr8zLYChmpKmEgFK/DS1349l9alJF5Gnf+RtqbRKw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=O/1bOW6slARzGBe4GQp+TzNVY6L56EyLiI0ViADp2jaoacrXpxpkmK8BvSkc6a6DD
         komJ5b5YgoHY+8w27O/8+kHsHbZ0CYCkKs5ObR0fwjL8KPPCFl5Mtf3ARaV+FA8cIw
         C1ntKsyZbajZglguIu6z4RHwyHdBfRoRNzJSjN+4aCmuqPl3BVklSR2V7CxoebxHr4
         yvJ4GlAgtNM7OCtUo3gbdPpreYYY2NA/oBmoJX4VxYvGLqepn2gINYz2+ekvu+b/pI
         S5qu5deYE0FW5MSqBwzhv5eY/qPzf9oXdY83wugY8PVBFFNoNr10qaTbwe2fJ8j5XS
         fXsfH9fcXqkCg==
Date:   Wed, 16 Nov 2022 10:16:32 -0600
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
Subject: Re: [patch 19/39] PCI/MSI: Move pci_disable_msi() to api.c
Message-ID: <20221116161632.GA1114946@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221111122014.696798036@linutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 11, 2022 at 02:54:45PM +0100, Thomas Gleixner wrote:
> From: Ahmed S. Darwish <darwi@linutronix.de>
> 
> msi.c is a maze of randomly sorted functions which makes the code
> unreadable. As a first step split the driver visible API and the internal
> implementation which also allows proper API documentation via one file.
> 
> Create drivers/pci/msi/api.c to group all exported device-driver PCI/MSI
> APIs in one C file.
> 
> Begin by moving pci_disable_msi() there and add kernel-doc for the function
> as appropriate.
> 
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/msi/Makefile |  3 +--
>  drivers/pci/msi/api.c    | 37 +++++++++++++++++++++++++++++++++++++
>  drivers/pci/msi/msi.c    | 22 +++++-----------------
>  drivers/pci/msi/msi.h    |  4 ++++
>  4 files changed, 47 insertions(+), 19 deletions(-)
>  create mode 100644 drivers/pci/msi/api.c
> ---
> diff --git a/drivers/pci/msi/Makefile b/drivers/pci/msi/Makefile
> index 4e0a7e07965e..839ff72d72a8 100644
> --- a/drivers/pci/msi/Makefile
> +++ b/drivers/pci/msi/Makefile
> @@ -2,6 +2,5 @@
>  #
>  # Makefile for the PCI/MSI
>  obj-$(CONFIG_PCI)			+= pcidev_msi.o
> -obj-$(CONFIG_PCI_MSI)			+= msi.o
> -obj-$(CONFIG_PCI_MSI)			+= irqdomain.o
> +obj-$(CONFIG_PCI_MSI)			+= api.o msi.o irqdomain.o
>  obj-$(CONFIG_PCI_MSI_ARCH_FALLBACKS)	+= legacy.o
> diff --git a/drivers/pci/msi/api.c b/drivers/pci/msi/api.c
> new file mode 100644
> index 000000000000..7485942cbe5d
> --- /dev/null
> +++ b/drivers/pci/msi/api.c
> @@ -0,0 +1,37 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * PCI MSI/MSI-X — Exported APIs for device drivers
> + *
> + * Copyright (C) 2003-2004 Intel
> + * Copyright (C) Tom Long Nguyen (tom.l.nguyen@intel.com)
> + * Copyright (C) 2016 Christoph Hellwig.
> + * Copyright (C) 2022 Linutronix GmbH
> + */
> +
> +#include <linux/export.h>
> +
> +#include "msi.h"
> +
> +/**
> + * pci_disable_msi() - Disable MSI interrupt mode on device
> + * @dev: the PCI device to operate on
> + *
> + * Legacy device driver API to disable MSI interrupt mode on device,
> + * free earlier allocated interrupt vectors, and restore INTx emulation.
> + * The PCI device Linux IRQ (@dev->irq) is restored to its default
> + * pin-assertion IRQ. This is the cleanup pair of pci_enable_msi().
> + *
> + * NOTE: The newer pci_alloc_irq_vectors() / pci_free_irq_vectors() API
> + * pair should, in general, be used instead.
> + */
> +void pci_disable_msi(struct pci_dev *dev)
> +{
> +	if (!pci_msi_enabled() || !dev || !dev->msi_enabled)
> +		return;
> +
> +	msi_lock_descs(&dev->dev);
> +	pci_msi_shutdown(dev);
> +	pci_free_msi_irqs(dev);
> +	msi_unlock_descs(&dev->dev);
> +}
> +EXPORT_SYMBOL(pci_disable_msi);
> diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
> index 5c310df55d0d..4a1300b74518 100644
> --- a/drivers/pci/msi/msi.c
> +++ b/drivers/pci/msi/msi.c
> @@ -163,7 +163,7 @@ void pci_write_msi_msg(unsigned int irq, struct msi_msg *msg)
>  }
>  EXPORT_SYMBOL_GPL(pci_write_msi_msg);
>  
> -static void free_msi_irqs(struct pci_dev *dev)
> +void pci_free_msi_irqs(struct pci_dev *dev)
>  {
>  	pci_msi_teardown_msi_irqs(dev);
>  
> @@ -413,7 +413,7 @@ static int msi_capability_init(struct pci_dev *dev, int nvec,
>  
>  err:
>  	pci_msi_unmask(entry, msi_multi_mask(entry));
> -	free_msi_irqs(dev);
> +	pci_free_msi_irqs(dev);
>  fail:
>  	dev->msi_enabled = 0;
>  unlock:
> @@ -531,7 +531,7 @@ static int msix_setup_interrupts(struct pci_dev *dev, void __iomem *base,
>  	goto out_unlock;
>  
>  out_free:
> -	free_msi_irqs(dev);
> +	pci_free_msi_irqs(dev);
>  out_unlock:
>  	msi_unlock_descs(&dev->dev);
>  	kfree(masks);
> @@ -680,7 +680,7 @@ int pci_msi_vec_count(struct pci_dev *dev)
>  }
>  EXPORT_SYMBOL(pci_msi_vec_count);
>  
> -static void pci_msi_shutdown(struct pci_dev *dev)
> +void pci_msi_shutdown(struct pci_dev *dev)
>  {
>  	struct msi_desc *desc;
>  
> @@ -701,18 +701,6 @@ static void pci_msi_shutdown(struct pci_dev *dev)
>  	pcibios_alloc_irq(dev);
>  }
>  
> -void pci_disable_msi(struct pci_dev *dev)
> -{
> -	if (!pci_msi_enable || !dev || !dev->msi_enabled)
> -		return;
> -
> -	msi_lock_descs(&dev->dev);
> -	pci_msi_shutdown(dev);
> -	free_msi_irqs(dev);
> -	msi_unlock_descs(&dev->dev);
> -}
> -EXPORT_SYMBOL(pci_disable_msi);
> -
>  /**
>   * pci_msix_vec_count - return the number of device's MSI-X table entries
>   * @dev: pointer to the pci_dev data structure of MSI-X device function
> @@ -797,7 +785,7 @@ void pci_disable_msix(struct pci_dev *dev)
>  
>  	msi_lock_descs(&dev->dev);
>  	pci_msix_shutdown(dev);
> -	free_msi_irqs(dev);
> +	pci_free_msi_irqs(dev);
>  	msi_unlock_descs(&dev->dev);
>  }
>  EXPORT_SYMBOL(pci_disable_msix);
> diff --git a/drivers/pci/msi/msi.h b/drivers/pci/msi/msi.h
> index d8f62d911f08..634879277349 100644
> --- a/drivers/pci/msi/msi.h
> +++ b/drivers/pci/msi/msi.h
> @@ -84,6 +84,10 @@ static inline __attribute_const__ u32 msi_multi_mask(struct msi_desc *desc)
>  	return (1 << (1 << desc->pci.msi_attrib.multi_cap)) - 1;
>  }
>  
> +/* MSI internal functions invoked from the public APIs */
> +void pci_msi_shutdown(struct pci_dev *dev);
> +void pci_free_msi_irqs(struct pci_dev *dev);
> +
>  /* Legacy (!IRQDOMAIN) fallbacks */
>  #ifdef CONFIG_PCI_MSI_ARCH_FALLBACKS
>  int pci_msi_legacy_setup_msi_irqs(struct pci_dev *dev, int nvec, int type);
> 
