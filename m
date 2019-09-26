Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19ECBBFB27
	for <lists+linux-pci@lfdr.de>; Thu, 26 Sep 2019 23:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbfIZVuJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Sep 2019 17:50:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:37764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727195AbfIZVuJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 26 Sep 2019 17:50:09 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 401CA20835;
        Thu, 26 Sep 2019 21:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569534607;
        bh=K3tFRaZim/0rzD7B00rdwa//YJV1bFLBpNRwD33w/BA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=eXFxwI8GglXUXi4gpjImbh3uLS66B9q4laYrmQWiorm76tZIPdS1Bj37qmbVOI1K3
         pAwHROBvKe4bQqQEn9ex3Na9oMDvRIvtWcnNSycYTIh9KFpWhQdUhcAHp4m1TviCS9
         hkEOpkRI+9sfHnwQJH/d6SQovJqdbs66A68EfNvs=
Date:   Thu, 26 Sep 2019 16:50:05 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Megha Dey <megha.dey@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-pci@vger.kernel.org, maz@kernel.org, rafael@kernel.org,
        gregkh@linuxfoundation.org, tglx@linutronix.de, hpa@zytor.com,
        alex.williamson@redhat.com, jgg@mellanox.com, ashok.raj@intel.com,
        megha.dey@intel.com, jacob.jun.pan@intel.com
Subject: Re: [RFC V1 1/7] genirq/msi: Differentiate between various MSI based
 interrupts
Message-ID: <20190926215005.GA198183@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1568338328-22458-2-git-send-email-megha.dey@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 12, 2019 at 06:32:02PM -0700, Megha Dey wrote:
> Since a device can support both MSI-X and IMS interrupts simultaneously,
> do away with is_msix and introduce a new enum msi_desc_tag to
> differentiate between the various types of msi_descs.
> 
> Signed-off-by: Megha Dey <megha.dey@linux.intel.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>	# for drivers/pci/msi.c

> ---
>  arch/mips/pci/msi-xlp.c    |  2 +-
>  arch/s390/pci/pci_irq.c    |  2 +-
>  arch/x86/kernel/apic/msi.c |  2 +-
>  arch/x86/pci/xen.c         |  2 +-
>  drivers/pci/msi.c          | 19 ++++++++++---------
>  include/linux/msi.h        | 11 ++++++++++-
>  kernel/irq/msi.c           |  2 +-
>  7 files changed, 25 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/mips/pci/msi-xlp.c b/arch/mips/pci/msi-xlp.c
> index bb14335..0f06ad1 100644
> --- a/arch/mips/pci/msi-xlp.c
> +++ b/arch/mips/pci/msi-xlp.c
> @@ -457,7 +457,7 @@ int arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)
>  	node = slot / 8;
>  	lnkbase = nlm_get_pcie_base(node, link);
>  
> -	if (desc->msi_attrib.is_msix)
> +	if (desc->tag == IRQ_MSI_TAG_MSIX)
>  		return xlp_setup_msix(lnkbase, node, link, desc);
>  	else
>  		return xlp_setup_msi(lnkbase, node, link, desc);
> diff --git a/arch/s390/pci/pci_irq.c b/arch/s390/pci/pci_irq.c
> index d80616a..1938582 100644
> --- a/arch/s390/pci/pci_irq.c
> +++ b/arch/s390/pci/pci_irq.c
> @@ -332,7 +332,7 @@ void arch_teardown_msi_irqs(struct pci_dev *pdev)
>  	for_each_pci_msi_entry(msi, pdev) {
>  		if (!msi->irq)
>  			continue;
> -		if (msi->msi_attrib.is_msix)
> +		if (msi->tag == IRQ_MSI_TAG_MSIX)
>  			__pci_msix_desc_mask_irq(msi, 1);
>  		else
>  			__pci_msi_desc_mask_irq(msi, 1, 1);
> diff --git a/arch/x86/kernel/apic/msi.c b/arch/x86/kernel/apic/msi.c
> index 7f75334..435bcda 100644
> --- a/arch/x86/kernel/apic/msi.c
> +++ b/arch/x86/kernel/apic/msi.c
> @@ -98,7 +98,7 @@ int pci_msi_prepare(struct irq_domain *domain, struct device *dev, int nvec,
>  
>  	init_irq_alloc_info(arg, NULL);
>  	arg->msi_dev = pdev;
> -	if (desc->msi_attrib.is_msix) {
> +	if (desc->tag == IRQ_MSI_TAG_MSIX) {
>  		arg->type = X86_IRQ_ALLOC_TYPE_MSIX;
>  	} else {
>  		arg->type = X86_IRQ_ALLOC_TYPE_MSI;
> diff --git a/arch/x86/pci/xen.c b/arch/x86/pci/xen.c
> index 91220cc..5e850b8 100644
> --- a/arch/x86/pci/xen.c
> +++ b/arch/x86/pci/xen.c
> @@ -382,7 +382,7 @@ static void xen_teardown_msi_irqs(struct pci_dev *dev)
>  	struct msi_desc *msidesc;
>  
>  	msidesc = first_pci_msi_entry(dev);
> -	if (msidesc->msi_attrib.is_msix)
> +	if (msidesc->tag == IRQ_MSI_TAG_MSIX)
>  		xen_pci_frontend_disable_msix(dev);
>  	else
>  		xen_pci_frontend_disable_msi(dev);
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index 0884bed..8a05416 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -235,7 +235,7 @@ static void msi_set_mask_bit(struct irq_data *data, u32 flag)
>  {
>  	struct msi_desc *desc = irq_data_get_msi_desc(data);
>  
> -	if (desc->msi_attrib.is_msix) {
> +	if (desc->tag == IRQ_MSI_TAG_MSIX) {
>  		msix_mask_irq(desc, flag);
>  		readl(desc->mask_base);		/* Flush write to device */
>  	} else {
> @@ -278,7 +278,7 @@ void __pci_read_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
>  
>  	BUG_ON(dev->current_state != PCI_D0);
>  
> -	if (entry->msi_attrib.is_msix) {
> +	if (entry->tag == IRQ_MSI_TAG_MSIX) {
>  		void __iomem *base = pci_msix_desc_addr(entry);
>  
>  		if (!base) {
> @@ -313,7 +313,7 @@ void __pci_write_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
>  
>  	if (dev->current_state != PCI_D0 || pci_dev_is_disconnected(dev)) {
>  		/* Don't touch the hardware now */
> -	} else if (entry->msi_attrib.is_msix) {
> +	} else if (entry->tag == IRQ_MSI_TAG_MSIX) {
>  		void __iomem *base = pci_msix_desc_addr(entry);
>  
>  		if (!base)
> @@ -376,7 +376,7 @@ static void free_msi_irqs(struct pci_dev *dev)
>  	pci_msi_teardown_msi_irqs(dev);
>  
>  	list_for_each_entry_safe(entry, tmp, msi_list, list) {
> -		if (entry->msi_attrib.is_msix) {
> +		if (entry->tag == IRQ_MSI_TAG_MSIX) {
>  			if (list_is_last(&entry->list, msi_list))
>  				iounmap(entry->mask_base);
>  		}
> @@ -471,7 +471,7 @@ static ssize_t msi_mode_show(struct device *dev, struct device_attribute *attr,
>  	entry = irq_get_msi_desc(irq);
>  	if (entry)
>  		return sprintf(buf, "%s\n",
> -				entry->msi_attrib.is_msix ? "msix" : "msi");
> +			(entry->tag == IRQ_MSI_TAG_MSIX) ? "msix" : "msi");
>  
>  	return -ENODEV;
>  }
> @@ -570,7 +570,7 @@ msi_setup_entry(struct pci_dev *dev, int nvec, struct irq_affinity *affd)
>  
>  	pci_read_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, &control);
>  
> -	entry->msi_attrib.is_msix	= 0;
> +	entry->tag			= IRQ_MSI_TAG_MSI;
>  	entry->msi_attrib.is_64		= !!(control & PCI_MSI_FLAGS_64BIT);
>  	entry->msi_attrib.is_virtual    = 0;
>  	entry->msi_attrib.entry_nr	= 0;
> @@ -714,7 +714,7 @@ static int msix_setup_entries(struct pci_dev *dev, void __iomem *base,
>  			goto out;
>  		}
>  
> -		entry->msi_attrib.is_msix	= 1;
> +		entry->tag			= IRQ_MSI_TAG_MSIX;
>  		entry->msi_attrib.is_64		= 1;
>  		if (entries)
>  			entry->msi_attrib.entry_nr = entries[i].entry;
> @@ -1380,7 +1380,7 @@ irq_hw_number_t pci_msi_domain_calc_hwirq(struct pci_dev *dev,
>  
>  static inline bool pci_msi_desc_is_multi_msi(struct msi_desc *desc)
>  {
> -	return !desc->msi_attrib.is_msix && desc->nvec_used > 1;
> +	return (desc->tag == IRQ_MSI_TAG_MSI) && desc->nvec_used > 1;
>  }
>  
>  /**
> @@ -1404,7 +1404,8 @@ int pci_msi_domain_check_cap(struct irq_domain *domain,
>  	if (pci_msi_desc_is_multi_msi(desc) &&
>  	    !(info->flags & MSI_FLAG_MULTI_PCI_MSI))
>  		return 1;
> -	else if (desc->msi_attrib.is_msix && !(info->flags & MSI_FLAG_PCI_MSIX))
> +	else if ((desc->tag == IRQ_MSI_TAG_MSIX) &&
> +					!(info->flags & MSI_FLAG_PCI_MSIX))
>  		return -ENOTSUPP;
>  
>  	return 0;
> diff --git a/include/linux/msi.h b/include/linux/msi.h
> index 8ad679e..22591b6 100644
> --- a/include/linux/msi.h
> +++ b/include/linux/msi.h
> @@ -55,6 +55,15 @@ struct ti_sci_inta_msi_desc {
>  	u16	dev_index;
>  };
>  
> +enum msi_desc_tags {
> +	IRQ_MSI_TAG_MSI,
> +	IRQ_MSI_TAG_MSIX,
> +	IRQ_MSI_TAG_IMS,
> +	IRQ_MSI_TAG_PLAT,
> +	IRQ_MSI_TAG_FSL,
> +	IRQ_MSI_TAG_SCI,
> +};
> +
>  /**
>   * struct msi_desc - Descriptor structure for MSI based interrupts
>   * @list:	List head for management
> @@ -90,6 +99,7 @@ struct msi_desc {
>  	struct device			*dev;
>  	struct msi_msg			msg;
>  	struct irq_affinity_desc	*affinity;
> +	enum msi_desc_tags		tag;
>  #ifdef CONFIG_IRQ_MSI_IOMMU
>  	const void			*iommu_cookie;
>  #endif
> @@ -102,7 +112,6 @@ struct msi_desc {
>  		struct {
>  			u32 masked;
>  			struct {
> -				u8	is_msix		: 1;
>  				u8	multiple	: 3;
>  				u8	multi_cap	: 3;
>  				u8	maskbit		: 1;
> diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
> index ad26fbc..0819395 100644
> --- a/kernel/irq/msi.c
> +++ b/kernel/irq/msi.c
> @@ -384,7 +384,7 @@ static bool msi_check_reservation_mode(struct irq_domain *domain,
>  	 * masking and MSI does so when the maskbit is set.
>  	 */
>  	desc = first_msi_entry(dev);
> -	return desc->msi_attrib.is_msix || desc->msi_attrib.maskbit;
> +	return (desc->tag == IRQ_MSI_TAG_MSIX) || desc->msi_attrib.maskbit;
>  }
>  
>  /**
> -- 
> 2.7.4
> 
