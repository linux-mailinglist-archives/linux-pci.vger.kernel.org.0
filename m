Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F71262C3C5
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 17:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238109AbiKPQRS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 11:17:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234365AbiKPQQN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 11:16:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A8E56EDE;
        Wed, 16 Nov 2022 08:16:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3E4F4B81DE0;
        Wed, 16 Nov 2022 16:16:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A00C0C433D6;
        Wed, 16 Nov 2022 16:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668615367;
        bh=daqN+TaDb/bSmSJCgw2QBCWIjklwZ5qKeZ/7wNq+Inc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=E/p7vvP8Hy/m5lAFkBMaDtEqMRn7aY24wPzTdpLb7atnYOk0BrihJ7tGS7ZKZ1tkD
         Pbf/zb6g3GA/b1U+wmieDkTypbG4oZPoUuP2BSDmbpcsdsIlrYCeyAXtcy6FaOBUxM
         qPVFeo5AvC0raMaTOJ57xs8GCrEyAqUJBG04wCZkEEWy73Ua3/SuZ7uGO2ux5Qm76N
         eOZ5ENS3sh49roWO4yWOgMiPtSaCt0rolXw3Kgj4WcJxEADyZHsdDaUqsi1u9Axvix
         ooR2jxZxI0P2zsnV3pH7+XrzvD2eqDQo5S4DjZcwYR5/ca8VHDNZE/RMZgbd4S1IGo
         NJZATK9b/jpYA==
Date:   Wed, 16 Nov 2022 10:16:06 -0600
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
Subject: Re: [patch 18/39] PCI/MSI: Move mask and unmask helpers to msi.h
Message-ID: <20221116161606.GA1114894@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111122014.640052354@linutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 11, 2022 at 02:54:43PM +0100, Thomas Gleixner wrote:
> From: Ahmed S. Darwish <darwi@linutronix.de>
> 
> The upcoming support for per device MSI interrupt domains needs to share
> some of the inline helpers with the MSI implementation.
> 
> Move them to the header file.
> 
> Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/msi/msi.c | 61 +--------------------------------------
>  drivers/pci/msi/msi.h | 83 +++++++++++++++++++++++++++++++++++++++++++++-------
>  2 files changed, 74 insertions(+), 70 deletions(-)
> ---
> diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
> index 160af9f01669..5c310df55d0d 100644
> --- a/drivers/pci/msi/msi.c
> +++ b/drivers/pci/msi/msi.c
> @@ -16,7 +16,7 @@
>  static int pci_msi_enable = 1;
>  int pci_msi_ignore_mask;
>  
> -static noinline void pci_msi_update_mask(struct msi_desc *desc, u32 clear, u32 set)
> +void pci_msi_update_mask(struct msi_desc *desc, u32 clear, u32 set)
>  {
>  	raw_spinlock_t *lock = &to_pci_dev(desc->dev)->msi_lock;
>  	unsigned long flags;
> @@ -32,65 +32,6 @@ static noinline void pci_msi_update_mask(struct msi_desc *desc, u32 clear, u32 s
>  	raw_spin_unlock_irqrestore(lock, flags);
>  }
>  
> -static inline void pci_msi_mask(struct msi_desc *desc, u32 mask)
> -{
> -	pci_msi_update_mask(desc, 0, mask);
> -}
> -
> -static inline void pci_msi_unmask(struct msi_desc *desc, u32 mask)
> -{
> -	pci_msi_update_mask(desc, mask, 0);
> -}
> -
> -static inline void __iomem *pci_msix_desc_addr(struct msi_desc *desc)
> -{
> -	return desc->pci.mask_base + desc->msi_index * PCI_MSIX_ENTRY_SIZE;
> -}
> -
> -/*
> - * This internal function does not flush PCI writes to the device.  All
> - * users must ensure that they read from the device before either assuming
> - * that the device state is up to date, or returning out of this file.
> - * It does not affect the msi_desc::msix_ctrl cache either. Use with care!
> - */
> -static void pci_msix_write_vector_ctrl(struct msi_desc *desc, u32 ctrl)
> -{
> -	void __iomem *desc_addr = pci_msix_desc_addr(desc);
> -
> -	if (desc->pci.msi_attrib.can_mask)
> -		writel(ctrl, desc_addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
> -}
> -
> -static inline void pci_msix_mask(struct msi_desc *desc)
> -{
> -	desc->pci.msix_ctrl |= PCI_MSIX_ENTRY_CTRL_MASKBIT;
> -	pci_msix_write_vector_ctrl(desc, desc->pci.msix_ctrl);
> -	/* Flush write to device */
> -	readl(desc->pci.mask_base);
> -}
> -
> -static inline void pci_msix_unmask(struct msi_desc *desc)
> -{
> -	desc->pci.msix_ctrl &= ~PCI_MSIX_ENTRY_CTRL_MASKBIT;
> -	pci_msix_write_vector_ctrl(desc, desc->pci.msix_ctrl);
> -}
> -
> -static void __pci_msi_mask_desc(struct msi_desc *desc, u32 mask)
> -{
> -	if (desc->pci.msi_attrib.is_msix)
> -		pci_msix_mask(desc);
> -	else
> -		pci_msi_mask(desc, mask);
> -}
> -
> -static void __pci_msi_unmask_desc(struct msi_desc *desc, u32 mask)
> -{
> -	if (desc->pci.msi_attrib.is_msix)
> -		pci_msix_unmask(desc);
> -	else
> -		pci_msi_unmask(desc, mask);
> -}
> -
>  /**
>   * pci_msi_mask_irq - Generic IRQ chip callback to mask PCI/MSI interrupts
>   * @data:	pointer to irqdata associated to that interrupt
> diff --git a/drivers/pci/msi/msi.h b/drivers/pci/msi/msi.h
> index fc92603b33e1..d8f62d911f08 100644
> --- a/drivers/pci/msi/msi.h
> +++ b/drivers/pci/msi/msi.h
> @@ -8,21 +8,67 @@
>  int pci_msi_setup_msi_irqs(struct pci_dev *dev, int nvec, int type);
>  void pci_msi_teardown_msi_irqs(struct pci_dev *dev);
>  
> -#ifdef CONFIG_PCI_MSI_ARCH_FALLBACKS
> -int pci_msi_legacy_setup_msi_irqs(struct pci_dev *dev, int nvec, int type);
> -void pci_msi_legacy_teardown_msi_irqs(struct pci_dev *dev);
> -#else
> -static inline int pci_msi_legacy_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
> +/* Mask/unmask helpers */
> +void pci_msi_update_mask(struct msi_desc *desc, u32 clear, u32 set);
> +
> +static inline void pci_msi_mask(struct msi_desc *desc, u32 mask)
>  {
> -	WARN_ON_ONCE(1);
> -	return -ENODEV;
> +	pci_msi_update_mask(desc, 0, mask);
>  }
>  
> -static inline void pci_msi_legacy_teardown_msi_irqs(struct pci_dev *dev)
> +static inline void pci_msi_unmask(struct msi_desc *desc, u32 mask)
>  {
> -	WARN_ON_ONCE(1);
> +	pci_msi_update_mask(desc, mask, 0);
> +}
> +
> +static inline void __iomem *pci_msix_desc_addr(struct msi_desc *desc)
> +{
> +	return desc->pci.mask_base + desc->msi_index * PCI_MSIX_ENTRY_SIZE;
> +}
> +
> +/*
> + * This internal function does not flush PCI writes to the device.  All
> + * users must ensure that they read from the device before either assuming
> + * that the device state is up to date, or returning out of this file.
> + * It does not affect the msi_desc::msix_ctrl cache either. Use with care!
> + */
> +static inline void pci_msix_write_vector_ctrl(struct msi_desc *desc, u32 ctrl)
> +{
> +	void __iomem *desc_addr = pci_msix_desc_addr(desc);
> +
> +	if (desc->pci.msi_attrib.can_mask)
> +		writel(ctrl, desc_addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
> +}
> +
> +static inline void pci_msix_mask(struct msi_desc *desc)
> +{
> +	desc->pci.msix_ctrl |= PCI_MSIX_ENTRY_CTRL_MASKBIT;
> +	pci_msix_write_vector_ctrl(desc, desc->pci.msix_ctrl);
> +	/* Flush write to device */
> +	readl(desc->pci.mask_base);
> +}
> +
> +static inline void pci_msix_unmask(struct msi_desc *desc)
> +{
> +	desc->pci.msix_ctrl &= ~PCI_MSIX_ENTRY_CTRL_MASKBIT;
> +	pci_msix_write_vector_ctrl(desc, desc->pci.msix_ctrl);
> +}
> +
> +static inline void __pci_msi_mask_desc(struct msi_desc *desc, u32 mask)
> +{
> +	if (desc->pci.msi_attrib.is_msix)
> +		pci_msix_mask(desc);
> +	else
> +		pci_msi_mask(desc, mask);
> +}
> +
> +static inline void __pci_msi_unmask_desc(struct msi_desc *desc, u32 mask)
> +{
> +	if (desc->pci.msi_attrib.is_msix)
> +		pci_msix_unmask(desc);
> +	else
> +		pci_msi_unmask(desc, mask);
>  }
> -#endif
>  
>  /*
>   * PCI 2.3 does not specify mask bits for each MSI interrupt.  Attempting to
> @@ -37,3 +83,20 @@ static inline __attribute_const__ u32 msi_multi_mask(struct msi_desc *desc)
>  		return 0xffffffff;
>  	return (1 << (1 << desc->pci.msi_attrib.multi_cap)) - 1;
>  }
> +
> +/* Legacy (!IRQDOMAIN) fallbacks */
> +#ifdef CONFIG_PCI_MSI_ARCH_FALLBACKS
> +int pci_msi_legacy_setup_msi_irqs(struct pci_dev *dev, int nvec, int type);
> +void pci_msi_legacy_teardown_msi_irqs(struct pci_dev *dev);
> +#else
> +static inline int pci_msi_legacy_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
> +{
> +	WARN_ON_ONCE(1);
> +	return -ENODEV;
> +}
> +
> +static inline void pci_msi_legacy_teardown_msi_irqs(struct pci_dev *dev)
> +{
> +	WARN_ON_ONCE(1);
> +}
> +#endif
> 
