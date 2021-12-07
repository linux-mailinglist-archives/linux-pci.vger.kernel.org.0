Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BED946C62F
	for <lists+linux-pci@lfdr.de>; Tue,  7 Dec 2021 22:07:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233581AbhLGVK4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Dec 2021 16:10:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbhLGVK4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Dec 2021 16:10:56 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2999FC061574;
        Tue,  7 Dec 2021 13:07:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 74346CE1E74;
        Tue,  7 Dec 2021 21:07:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45E93C341C3;
        Tue,  7 Dec 2021 21:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638911241;
        bh=l5RPFEn3H/CaaJ67i6H8YMThxBmmtmmB2cHmVmneNBQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Utdeatg9didfUmqmKbQWqCgWNFRnv9ULV295ubYUU37CiRN6LQmpeSPvQ+fA9ofXf
         7xU7VjbJh0hVseoGqsAAEdVr7FtmfGLuyC6d3J91d66UvJi+5ywsoix9xKyqVQXpsj
         Hk49O5IVU5tQAt8YTlT1z7CgXtrZSpTeSeovf1NLbsRXlfzahprnhslYYc4RG/beP/
         vsJe18CxJhHnptlD7IKsQHUXUUCi6UQBk/wooP5HxG8d0U4heYUNqAYnYK7XmCn/JL
         kMLY/l+6z/rLBuQe+sJRQVlBJFGeeITIj2d4brxSfR8i2kYY9etkJhBEVHkV1Cvnbu
         IvAWZaQlkBo2w==
Date:   Tue, 7 Dec 2021 15:07:20 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        Cedric Le Goater <clg@kaod.org>,
        xen-devel@lists.xenproject.org, Juergen Gross <jgross@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com
Subject: Re: [patch V2 08/31] PCI/MSI: Use msi_add_msi_desc()
Message-ID: <20211207210720.GA78195@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206210748.035348646@linutronix.de>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Dec 06, 2021 at 11:51:15PM +0100, Thomas Gleixner wrote:
> Simplify the allocation of MSI descriptors by using msi_add_msi_desc()
> which moves the storage handling to core code and prepares for dynamic
> extension of the MSI-X vector space.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/msi/msi.c |  122 ++++++++++++++++++++++++--------------------------
>  1 file changed, 59 insertions(+), 63 deletions(-)
> 
> --- a/drivers/pci/msi/msi.c
> +++ b/drivers/pci/msi/msi.c
> @@ -340,45 +340,51 @@ void pci_restore_msi_state(struct pci_de
>  }
>  EXPORT_SYMBOL_GPL(pci_restore_msi_state);
>  
> -static struct msi_desc *
> -msi_setup_entry(struct pci_dev *dev, int nvec, struct irq_affinity_desc *masks)
> +static int msi_setup_msi_desc(struct pci_dev *dev, int nvec,
> +			      struct irq_affinity_desc *masks)
>  {
> -	struct msi_desc *entry;
> +	struct msi_desc desc;
>  	unsigned long prop;
>  	u16 control;
> +	int ret;
>  
>  	/* MSI Entry Initialization */
> -	entry = alloc_msi_entry(&dev->dev, nvec, masks);
> -	if (!entry)
> -		return NULL;
> +	memset(&desc, 0, sizeof(desc));
>  
>  	pci_read_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, &control);
>  	/* Lies, damned lies, and MSIs */
>  	if (dev->dev_flags & PCI_DEV_FLAGS_HAS_MSI_MASKING)
>  		control |= PCI_MSI_FLAGS_MASKBIT;
> +	/* Respect XEN's mask disabling */
> +	if (pci_msi_ignore_mask)
> +		control &= ~PCI_MSI_FLAGS_MASKBIT;
>  
> -	entry->pci.msi_attrib.is_64	= !!(control & PCI_MSI_FLAGS_64BIT);
> -	entry->pci.msi_attrib.can_mask	= !pci_msi_ignore_mask &&
> -					  !!(control & PCI_MSI_FLAGS_MASKBIT);
> -	entry->pci.msi_attrib.default_irq = dev->irq;
> -	entry->pci.msi_attrib.multi_cap	= (control & PCI_MSI_FLAGS_QMASK) >> 1;
> -	entry->pci.msi_attrib.multiple	= ilog2(__roundup_pow_of_two(nvec));
> +	desc.nvec_used			= nvec;
> +	desc.pci.msi_attrib.is_64	= !!(control & PCI_MSI_FLAGS_64BIT);
> +	desc.pci.msi_attrib.can_mask	= !!(control & PCI_MSI_FLAGS_MASKBIT);
> +	desc.pci.msi_attrib.default_irq	= dev->irq;
> +	desc.pci.msi_attrib.multi_cap	= (control & PCI_MSI_FLAGS_QMASK) >> 1;
> +	desc.pci.msi_attrib.multiple	= ilog2(__roundup_pow_of_two(nvec));
> +	desc.affinity			= masks;
>  
>  	if (control & PCI_MSI_FLAGS_64BIT)
> -		entry->pci.mask_pos = dev->msi_cap + PCI_MSI_MASK_64;
> +		desc.pci.mask_pos = dev->msi_cap + PCI_MSI_MASK_64;
>  	else
> -		entry->pci.mask_pos = dev->msi_cap + PCI_MSI_MASK_32;
> +		desc.pci.mask_pos = dev->msi_cap + PCI_MSI_MASK_32;
>  
>  	/* Save the initial mask status */
> -	if (entry->pci.msi_attrib.can_mask)
> -		pci_read_config_dword(dev, entry->pci.mask_pos, &entry->pci.msi_mask);
> +	if (desc.pci.msi_attrib.can_mask)
> +		pci_read_config_dword(dev, desc.pci.mask_pos, &desc.pci.msi_mask);
>  
> -	prop = MSI_PROP_PCI_MSI;
> -	if (entry->pci.msi_attrib.is_64)
> -		prop |= MSI_PROP_64BIT;
> -	msi_device_set_properties(&dev->dev, prop);
> +	ret = msi_add_msi_desc(&dev->dev, &desc);
> +	if (!ret) {
> +		prop = MSI_PROP_PCI_MSI;
> +		if (desc.pci.msi_attrib.is_64)
> +			prop |= MSI_PROP_64BIT;
> +		msi_device_set_properties(&dev->dev, prop);
> +	}
>  
> -	return entry;
> +	return ret;
>  }
>  
>  static int msi_verify_entries(struct pci_dev *dev)
> @@ -423,17 +429,14 @@ static int msi_capability_init(struct pc
>  		masks = irq_create_affinity_masks(nvec, affd);
>  
>  	msi_lock_descs(&dev->dev);
> -	entry = msi_setup_entry(dev, nvec, masks);
> -	if (!entry) {
> -		ret = -ENOMEM;
> +	ret = msi_setup_msi_desc(dev, nvec, masks);
> +	if (ret)
>  		goto unlock;
> -	}
>  
>  	/* All MSIs are unmasked by default; mask them all */
> +	entry = first_pci_msi_entry(dev);
>  	pci_msi_mask(entry, msi_multi_mask(entry));
>  
> -	list_add_tail(&entry->list, dev_to_msi_list(&dev->dev));
> -
>  	/* Configure MSI capability structure */
>  	ret = pci_msi_setup_msi_irqs(dev, nvec, PCI_CAP_ID_MSI);
>  	if (ret)
> @@ -482,49 +485,40 @@ static void __iomem *msix_map_region(str
>  	return ioremap(phys_addr, nr_entries * PCI_MSIX_ENTRY_SIZE);
>  }
>  
> -static int msix_setup_entries(struct pci_dev *dev, void __iomem *base,
> -			      struct msix_entry *entries, int nvec,
> -			      struct irq_affinity_desc *masks)
> +static int msix_setup_msi_descs(struct pci_dev *dev, void __iomem *base,
> +				struct msix_entry *entries, int nvec,
> +				struct irq_affinity_desc *masks)
>  {
> -	int i, vec_count = pci_msix_vec_count(dev);
> +	int ret = 0, i, vec_count = pci_msix_vec_count(dev);
>  	struct irq_affinity_desc *curmsk;
> -	struct msi_desc *entry;
> +	struct msi_desc desc;
>  	void __iomem *addr;
>  
> -	for (i = 0, curmsk = masks; i < nvec; i++) {
> -		entry = alloc_msi_entry(&dev->dev, 1, curmsk);
> -		if (!entry) {
> -			/* No enough memory. Don't try again */
> -			return -ENOMEM;
> -		}
> -
> -		entry->pci.msi_attrib.is_msix	= 1;
> -		entry->pci.msi_attrib.is_64	= 1;
> -
> -		if (entries)
> -			entry->msi_index = entries[i].entry;
> -		else
> -			entry->msi_index = i;
> -
> -		entry->pci.msi_attrib.is_virtual = entry->msi_index >= vec_count;
> -
> -		entry->pci.msi_attrib.can_mask	= !pci_msi_ignore_mask &&
> -						  !entry->pci.msi_attrib.is_virtual;
> -
> -		entry->pci.msi_attrib.default_irq	= dev->irq;
> -		entry->pci.mask_base			= base;
> +	memset(&desc, 0, sizeof(desc));
>  
> -		if (entry->pci.msi_attrib.can_mask) {
> -			addr = pci_msix_desc_addr(entry);
> -			entry->pci.msix_ctrl = readl(addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
> +	desc.nvec_used			= 1;
> +	desc.pci.msi_attrib.is_msix	= 1;
> +	desc.pci.msi_attrib.is_64	= 1;
> +	desc.pci.msi_attrib.default_irq	= dev->irq;
> +	desc.pci.mask_base		= base;
> +
> +	for (i = 0, curmsk = masks; i < nvec; i++, curmsk++) {
> +		desc.msi_index = entries ? entries[i].entry : i;
> +		desc.affinity = masks ? curmsk : NULL;
> +		desc.pci.msi_attrib.is_virtual = desc.msi_index >= vec_count;
> +		desc.pci.msi_attrib.can_mask = !pci_msi_ignore_mask &&
> +					       !desc.pci.msi_attrib.is_virtual;
> +
> +		if (!desc.pci.msi_attrib.can_mask) {
> +			addr = pci_msix_desc_addr(&desc);
> +			desc.pci.msix_ctrl = readl(addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
>  		}
>  
> -		list_add_tail(&entry->list, dev_to_msi_list(&dev->dev));
> -		if (masks)
> -			curmsk++;
> +		ret = msi_add_msi_desc(&dev->dev, &desc);
> +		if (ret)
> +			break;
>  	}
> -	msi_device_set_properties(&dev->dev, MSI_PROP_PCI_MSIX | MSI_PROP_64BIT);
> -	return 0;
> +	return ret;
>  }
>  
>  static void msix_update_entries(struct pci_dev *dev, struct msix_entry *entries)
> @@ -562,10 +556,12 @@ static int msix_setup_interrupts(struct
>  		masks = irq_create_affinity_masks(nvec, affd);
>  
>  	msi_lock_descs(&dev->dev);
> -	ret = msix_setup_entries(dev, base, entries, nvec, masks);
> +	ret = msix_setup_msi_descs(dev, base, entries, nvec, masks);
>  	if (ret)
>  		goto out_free;
>  
> +	msi_device_set_properties(&dev->dev, MSI_PROP_PCI_MSIX | MSI_PROP_64BIT);
> +
>  	ret = pci_msi_setup_msi_irqs(dev, nvec, PCI_CAP_ID_MSIX);
>  	if (ret)
>  		goto out_free;
> 
