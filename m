Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A29D146C623
	for <lists+linux-pci@lfdr.de>; Tue,  7 Dec 2021 22:07:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235081AbhLGVKc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Dec 2021 16:10:32 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:56684 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbhLGVKc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Dec 2021 16:10:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7CCA8B81E7D;
        Tue,  7 Dec 2021 21:07:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD973C341C3;
        Tue,  7 Dec 2021 21:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638911219;
        bh=X0S57AaQEic+pxrlfm8ArcEsuRWnA6Vver2WI6NT7UE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=b+Kx6njakVbzOWyGLsFaYWFiGhvp2DFKTtt4gKBalCRZQLUdqOhNHtJaLRIIJnrTR
         10QAHUN4GHQ/+dGrHvO7jJtRPnKG1+UiTDeIQmjhwyiVBzxaQeM3qsZn0B+2egfXt8
         q8+o+CY70hRpU6Uzmrqmh38XeTf5fNpU6zC3ElRh6wDtWIZFDlkBKtMrx1iM7rQHT+
         z123oSu4IcH4STWWCbdV2J7ma5qv5HWALkdcp0ncVVAoH2dHoGKQC6PNOB4pJv2Yz8
         sERuICmDI2xYtOsRemEYK1pK09KgjArChdAxTHgfl847zqFYRrxXi0STfMD9ZlrWq6
         y+pAX3UihJJ7w==
Date:   Tue, 7 Dec 2021 15:06:57 -0600
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
Subject: Re: [patch V2 07/31] PCI/MSI: Protect MSI operations
Message-ID: <20211207210657.GA78127@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206210747.982292705@linutronix.de>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Dec 06, 2021 at 11:51:13PM +0100, Thomas Gleixner wrote:
> To prepare for dynamic extension of MSI-X vectors, protect the MSI
> operations for MSI and MSI-X. This requires to move the invocation of
> irq_create_affinity_masks() out of the descriptor lock section to avoid
> reverse lock ordering vs. CPU hotplug lock as some callers of the PCI/MSI
> allocation interfaces already hold it.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/msi/irqdomain.c |    4 -
>  drivers/pci/msi/msi.c       |  120 ++++++++++++++++++++++++++------------------
>  2 files changed, 73 insertions(+), 51 deletions(-)
> 
> --- a/drivers/pci/msi/irqdomain.c
> +++ b/drivers/pci/msi/irqdomain.c
> @@ -14,7 +14,7 @@ int pci_msi_setup_msi_irqs(struct pci_de
>  
>  	domain = dev_get_msi_domain(&dev->dev);
>  	if (domain && irq_domain_is_hierarchy(domain))
> -		return msi_domain_alloc_irqs(domain, &dev->dev, nvec);
> +		return msi_domain_alloc_irqs_descs_locked(domain, &dev->dev, nvec);
>  
>  	return pci_msi_legacy_setup_msi_irqs(dev, nvec, type);
>  }
> @@ -25,7 +25,7 @@ void pci_msi_teardown_msi_irqs(struct pc
>  
>  	domain = dev_get_msi_domain(&dev->dev);
>  	if (domain && irq_domain_is_hierarchy(domain))
> -		msi_domain_free_irqs(domain, &dev->dev);
> +		msi_domain_free_irqs_descs_locked(domain, &dev->dev);
>  	else
>  		pci_msi_legacy_teardown_msi_irqs(dev);
>  }
> --- a/drivers/pci/msi/msi.c
> +++ b/drivers/pci/msi/msi.c
> @@ -322,11 +322,13 @@ static void __pci_restore_msix_state(str
>  
>  	write_msg = arch_restore_msi_irqs(dev);
>  
> +	msi_lock_descs(&dev->dev);
>  	for_each_pci_msi_entry(entry, dev) {
>  		if (write_msg)
>  			__pci_write_msi_msg(entry, &entry->msg);
>  		pci_msix_write_vector_ctrl(entry, entry->pci.msix_ctrl);
>  	}
> +	msi_unlock_descs(&dev->dev);
>  
>  	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_MASKALL, 0);
>  }
> @@ -339,20 +341,16 @@ void pci_restore_msi_state(struct pci_de
>  EXPORT_SYMBOL_GPL(pci_restore_msi_state);
>  
>  static struct msi_desc *
> -msi_setup_entry(struct pci_dev *dev, int nvec, struct irq_affinity *affd)
> +msi_setup_entry(struct pci_dev *dev, int nvec, struct irq_affinity_desc *masks)
>  {
> -	struct irq_affinity_desc *masks = NULL;
>  	struct msi_desc *entry;
>  	unsigned long prop;
>  	u16 control;
>  
> -	if (affd)
> -		masks = irq_create_affinity_masks(nvec, affd);
> -
>  	/* MSI Entry Initialization */
>  	entry = alloc_msi_entry(&dev->dev, nvec, masks);
>  	if (!entry)
> -		goto out;
> +		return NULL;
>  
>  	pci_read_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, &control);
>  	/* Lies, damned lies, and MSIs */
> @@ -379,8 +377,7 @@ msi_setup_entry(struct pci_dev *dev, int
>  	if (entry->pci.msi_attrib.is_64)
>  		prop |= MSI_PROP_64BIT;
>  	msi_device_set_properties(&dev->dev, prop);
> -out:
> -	kfree(masks);
> +
>  	return entry;
>  }
>  
> @@ -416,14 +413,21 @@ static int msi_verify_entries(struct pci
>  static int msi_capability_init(struct pci_dev *dev, int nvec,
>  			       struct irq_affinity *affd)
>  {
> +	struct irq_affinity_desc *masks = NULL;
>  	struct msi_desc *entry;
>  	int ret;
>  
>  	pci_msi_set_enable(dev, 0);	/* Disable MSI during set up */
>  
> -	entry = msi_setup_entry(dev, nvec, affd);
> -	if (!entry)
> -		return -ENOMEM;
> +	if (affd)
> +		masks = irq_create_affinity_masks(nvec, affd);
> +
> +	msi_lock_descs(&dev->dev);
> +	entry = msi_setup_entry(dev, nvec, masks);
> +	if (!entry) {
> +		ret = -ENOMEM;
> +		goto unlock;
> +	}
>  
>  	/* All MSIs are unmasked by default; mask them all */
>  	pci_msi_mask(entry, msi_multi_mask(entry));
> @@ -446,11 +450,14 @@ static int msi_capability_init(struct pc
>  
>  	pcibios_free_irq(dev);
>  	dev->irq = entry->irq;
> -	return 0;
> +	goto unlock;
>  
>  err:
>  	pci_msi_unmask(entry, msi_multi_mask(entry));
>  	free_msi_irqs(dev);
> +unlock:
> +	msi_unlock_descs(&dev->dev);
> +	kfree(masks);
>  	return ret;
>  }
>  
> @@ -477,23 +484,18 @@ static void __iomem *msix_map_region(str
>  
>  static int msix_setup_entries(struct pci_dev *dev, void __iomem *base,
>  			      struct msix_entry *entries, int nvec,
> -			      struct irq_affinity *affd)
> +			      struct irq_affinity_desc *masks)
>  {
> -	struct irq_affinity_desc *curmsk, *masks = NULL;
> +	int i, vec_count = pci_msix_vec_count(dev);
> +	struct irq_affinity_desc *curmsk;
>  	struct msi_desc *entry;
>  	void __iomem *addr;
> -	int ret, i;
> -	int vec_count = pci_msix_vec_count(dev);
> -
> -	if (affd)
> -		masks = irq_create_affinity_masks(nvec, affd);
>  
>  	for (i = 0, curmsk = masks; i < nvec; i++) {
>  		entry = alloc_msi_entry(&dev->dev, 1, curmsk);
>  		if (!entry) {
>  			/* No enough memory. Don't try again */
> -			ret = -ENOMEM;
> -			goto out;
> +			return -ENOMEM;
>  		}
>  
>  		entry->pci.msi_attrib.is_msix	= 1;
> @@ -522,10 +524,7 @@ static int msix_setup_entries(struct pci
>  			curmsk++;
>  	}
>  	msi_device_set_properties(&dev->dev, MSI_PROP_PCI_MSIX | MSI_PROP_64BIT);
> -	ret = 0;
> -out:
> -	kfree(masks);
> -	return ret;
> +	return 0;
>  }
>  
>  static void msix_update_entries(struct pci_dev *dev, struct msix_entry *entries)
> @@ -552,6 +551,41 @@ static void msix_mask_all(void __iomem *
>  		writel(ctrl, base + PCI_MSIX_ENTRY_VECTOR_CTRL);
>  }
>  
> +static int msix_setup_interrupts(struct pci_dev *dev, void __iomem *base,
> +				 struct msix_entry *entries, int nvec,
> +				 struct irq_affinity *affd)
> +{
> +	struct irq_affinity_desc *masks = NULL;
> +	int ret;
> +
> +	if (affd)
> +		masks = irq_create_affinity_masks(nvec, affd);
> +
> +	msi_lock_descs(&dev->dev);
> +	ret = msix_setup_entries(dev, base, entries, nvec, masks);
> +	if (ret)
> +		goto out_free;
> +
> +	ret = pci_msi_setup_msi_irqs(dev, nvec, PCI_CAP_ID_MSIX);
> +	if (ret)
> +		goto out_free;
> +
> +	/* Check if all MSI entries honor device restrictions */
> +	ret = msi_verify_entries(dev);
> +	if (ret)
> +		goto out_free;
> +
> +	msix_update_entries(dev, entries);
> +	goto out_unlock;
> +
> +out_free:
> +	free_msi_irqs(dev);
> +out_unlock:
> +	msi_unlock_descs(&dev->dev);
> +	kfree(masks);
> +	return ret;
> +}
> +
>  /**
>   * msix_capability_init - configure device's MSI-X capability
>   * @dev: pointer to the pci_dev data structure of MSI-X device function
> @@ -592,20 +626,9 @@ static int msix_capability_init(struct p
>  	/* Ensure that all table entries are masked. */
>  	msix_mask_all(base, tsize);
>  
> -	ret = msix_setup_entries(dev, base, entries, nvec, affd);
> +	ret = msix_setup_interrupts(dev, base, entries, nvec, affd);
>  	if (ret)
> -		goto out_free;
> -
> -	ret = pci_msi_setup_msi_irqs(dev, nvec, PCI_CAP_ID_MSIX);
> -	if (ret)
> -		goto out_free;
> -
> -	/* Check if all MSI entries honor device restrictions */
> -	ret = msi_verify_entries(dev);
> -	if (ret)
> -		goto out_free;
> -
> -	msix_update_entries(dev, entries);
> +		goto out_disable;
>  
>  	/* Set MSI-X enabled bits and unmask the function */
>  	pci_intx_for_msi(dev, 0);
> @@ -615,12 +638,8 @@ static int msix_capability_init(struct p
>  	pcibios_free_irq(dev);
>  	return 0;
>  
> -out_free:
> -	free_msi_irqs(dev);
> -
>  out_disable:
>  	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_ENABLE, 0);
> -
>  	return ret;
>  }
>  
> @@ -725,8 +744,10 @@ void pci_disable_msi(struct pci_dev *dev
>  	if (!pci_msi_enable || !dev || !dev->msi_enabled)
>  		return;
>  
> +	msi_lock_descs(&dev->dev);
>  	pci_msi_shutdown(dev);
>  	free_msi_irqs(dev);
> +	msi_unlock_descs(&dev->dev);
>  }
>  EXPORT_SYMBOL(pci_disable_msi);
>  
> @@ -812,8 +833,10 @@ void pci_disable_msix(struct pci_dev *de
>  	if (!pci_msi_enable || !dev || !dev->msix_enabled)
>  		return;
>  
> +	msi_lock_descs(&dev->dev);
>  	pci_msix_shutdown(dev);
>  	free_msi_irqs(dev);
> +	msi_unlock_descs(&dev->dev);
>  }
>  EXPORT_SYMBOL(pci_disable_msix);
>  
> @@ -874,7 +897,6 @@ int pci_enable_msi(struct pci_dev *dev)
>  
>  	if (!rc)
>  		rc = __pci_enable_msi_range(dev, 1, 1, NULL);
> -
>  	return rc < 0 ? rc : 0;
>  }
>  EXPORT_SYMBOL(pci_enable_msi);
> @@ -961,11 +983,7 @@ int pci_alloc_irq_vectors_affinity(struc
>  				   struct irq_affinity *affd)
>  {
>  	struct irq_affinity msi_default_affd = {0};
> -	int ret = msi_setup_device_data(&dev->dev);
> -	int nvecs = -ENOSPC;
> -
> -	if (ret)
> -		return ret;
> +	int ret, nvecs;
>  
>  	if (flags & PCI_IRQ_AFFINITY) {
>  		if (!affd)
> @@ -975,6 +993,10 @@ int pci_alloc_irq_vectors_affinity(struc
>  			affd = NULL;
>  	}
>  
> +	ret = msi_setup_device_data(&dev->dev);
> +	if (ret)
> +		return ret;
> +
>  	if (flags & PCI_IRQ_MSIX) {
>  		nvecs = __pci_enable_msix_range(dev, NULL, min_vecs, max_vecs,
>  						affd, flags);
> @@ -1003,7 +1025,7 @@ int pci_alloc_irq_vectors_affinity(struc
>  		}
>  	}
>  
> -	return nvecs;
> +	return -ENOSPC;
>  }
>  EXPORT_SYMBOL(pci_alloc_irq_vectors_affinity);
>  
> 
