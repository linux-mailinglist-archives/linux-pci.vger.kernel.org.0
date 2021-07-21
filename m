Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C83653D19A1
	for <lists+linux-pci@lfdr.de>; Thu, 22 Jul 2021 00:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbhGUVnG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Jul 2021 17:43:06 -0400
Received: from mga02.intel.com ([134.134.136.20]:6577 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229936AbhGUVnF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 21 Jul 2021 17:43:05 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10052"; a="198729567"
X-IronPort-AV: E=Sophos;i="5.84,258,1620716400"; 
   d="scan'208";a="198729567"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2021 15:23:41 -0700
X-IronPort-AV: E=Sophos;i="5.84,258,1620716400"; 
   d="scan'208";a="501465185"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.36])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2021 15:23:41 -0700
Date:   Wed, 21 Jul 2021 15:23:13 -0700
From:   "Raj, Ashok" <ashok.raj@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Kevin Tian <kevin.tian@intel.com>,
        Marc Zyngier <maz@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, Ashok Raj <ashok.raj@intel.com>
Subject: Re: [patch 2/8] PCI/MSI: Mask all unused MSI-X entries
Message-ID: <20210721222313.GC676232@otc-nc-03>
References: <20210721191126.274946280@linutronix.de>
 <20210721192650.268814107@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210721192650.268814107@linutronix.de>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Thomas

On Wed, Jul 21, 2021 at 09:11:28PM +0200, Thomas Gleixner wrote:

[snip]

> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -691,6 +691,7 @@ static int msix_setup_entries(struct pci
>  {
>  	struct irq_affinity_desc *curmsk, *masks = NULL;
>  	struct msi_desc *entry;
> +	void __iomem *addr;
>  	int ret, i;
>  	int vec_count = pci_msix_vec_count(dev);
>  
> @@ -711,6 +712,7 @@ static int msix_setup_entries(struct pci
>  
>  		entry->msi_attrib.is_msix	= 1;
>  		entry->msi_attrib.is_64		= 1;
> +
>  		if (entries)
>  			entry->msi_attrib.entry_nr = entries[i].entry;
>  		else
> @@ -722,6 +724,10 @@ static int msix_setup_entries(struct pci
>  		entry->msi_attrib.default_irq	= dev->irq;
>  		entry->mask_base		= base;
>  
> +		addr = pci_msix_desc_addr(entry);
> +		if (addr)
> +			entry->masked = readl(addr + PCI_MSIX_ENTRY_VECTOR_CTRL);

Silly question:
Do we have to read what the HW has to set this entry->masked? Shouldn't
this be all masked before we start the setup?

> +
>  		list_add_tail(&entry->list, dev_to_msi_list(&dev->dev));
>  		if (masks)
>  			curmsk++;
> @@ -732,26 +738,25 @@ static int msix_setup_entries(struct pci
>  	return ret;
>  }
>  
> -static void msix_program_entries(struct pci_dev *dev,
> -				 struct msix_entry *entries)
> +static void msix_update_entries(struct pci_dev *dev, struct msix_entry *entries)
>  {
>  	struct msi_desc *entry;
> -	int i = 0;
> -	void __iomem *desc_addr;
>  
>  	for_each_pci_msi_entry(entry, dev) {
> -		if (entries)
> -			entries[i++].vector = entry->irq;
> +		if (entries) {
> +			entries->vector = entry->irq;
> +			entries++;
> +		}
> +	}
> +}
>  
> -		desc_addr = pci_msix_desc_addr(entry);
> -		if (desc_addr)
> -			entry->masked = readl(desc_addr +
> -					      PCI_MSIX_ENTRY_VECTOR_CTRL);
> -		else
> -			entry->masked = 0;
> +static void msix_mask_all(void __iomem *base, int tsize)
> +{
> +	u32 ctrl = PCI_MSIX_ENTRY_CTRL_MASKBIT;
> +	int i;
>  
> -		msix_mask_irq(entry, 1);
> -	}
> +	for (i = 0; i < tsize; i++, base += PCI_MSIX_ENTRY_SIZE)
> +		writel(ctrl, base + PCI_MSIX_ENTRY_VECTOR_CTRL);

shouldn't we initialize entry->masked here?

>  }
>  
>  /**
> @@ -768,9 +773,9 @@ static void msix_program_entries(struct
>  static int msix_capability_init(struct pci_dev *dev, struct msix_entry *entries,
>  				int nvec, struct irq_affinity *affd)
>  {
> -	int ret;
> -	u16 control;
>  	void __iomem *base;
> +	int ret, tsize;
> +	u16 control;
>  
>  	/*
>  	 * Some devices require MSI-X to be enabled before the MSI-X
> @@ -782,12 +787,16 @@ static int msix_capability_init(struct p
>  
>  	pci_read_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS, &control);
>  	/* Request & Map MSI-X table region */
> -	base = msix_map_region(dev, msix_table_size(control));
> +	tsize = msix_table_size(control);
> +	base = msix_map_region(dev, tsize);
>  	if (!base) {
>  		ret = -ENOMEM;
>  		goto out_disable;
>  	}
>  
> +	/* Ensure that all table entries are masked. */
> +	msix_mask_all(base, tsize);
> +
>  	ret = msix_setup_entries(dev, base, entries, nvec, affd);
>  	if (ret)
>  		goto out_disable;
> @@ -801,7 +810,7 @@ static int msix_capability_init(struct p
>  	if (ret)
>  		goto out_free;
>  
> -	msix_program_entries(dev, entries);
> +	msix_update_entries(dev, entries);
>  
>  	ret = populate_msi_sysfs(dev);
>  	if (ret)
> 

-- 
Cheers,
Ashok

[Forgiveness is the attribute of the STRONG - Gandhi]
