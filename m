Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1C2F145D88
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jan 2020 22:13:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbgAVVNC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Jan 2020 16:13:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:58178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727590AbgAVVNC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 22 Jan 2020 16:13:02 -0500
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62EC52465B;
        Wed, 22 Jan 2020 21:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579727581;
        bh=fFweYeenFvs4HkuADNdVlhMAmdzgO7l02edUze2SN3M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=hr15TIgenBSUenmaLItA1B+GdJ/AEhGWjr6P+Sgz4A9BmG6msd+dAgWMMi0bablaF
         qQ1XQE8RAWxBNy9t89QA0PGBgOppc6DhSiqxQNVVsJjUGoJMK7MDVTK5BNg3W68hmS
         a94emKuOhZI2Me8cFNwwFUbeLsSBMfMHUZdg+mAI=
Date:   Wed, 22 Jan 2020 15:12:59 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jon Derrick <jonathan.derrick@intel.com>
Cc:     linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        iommu@lists.linux-foundation.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v5 3/7] PCI: Introduce pci_real_dma_dev()
Message-ID: <20200122211259.GA19172@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1579613871-301529-4-git-send-email-jonathan.derrick@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 21, 2020 at 06:37:47AM -0700, Jon Derrick wrote:
> The current DMA alias implementation requires the aliased device be on
> the same PCI bus as the requester ID. This introduces an arch-specific
> mechanism to point to another PCI device when doing mapping and
> PCI DMA alias search. The default case returns the actual device.
> 
> CC: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Looks like a nice cleanup to me.

Lorenzo, let me know if you want me to take this.

> ---
>  arch/x86/pci/common.c | 10 ++++++++++
>  drivers/pci/pci.c     | 19 ++++++++++++++++++-
>  drivers/pci/search.c  |  6 ++++++
>  include/linux/pci.h   |  1 +
>  4 files changed, 35 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
> index 1e59df0..fe21a5c 100644
> --- a/arch/x86/pci/common.c
> +++ b/arch/x86/pci/common.c
> @@ -736,3 +736,13 @@ int pci_ext_cfg_avail(void)
>  	else
>  		return 0;
>  }
> +
> +#if IS_ENABLED(CONFIG_VMD)
> +struct pci_dev *pci_real_dma_dev(struct pci_dev *dev)
> +{
> +	if (is_vmd(dev->bus))
> +		return to_pci_sysdata(dev->bus)->vmd_dev;
> +
> +	return dev;
> +}
> +#endif
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 581b177..36d24f2 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -6048,7 +6048,9 @@ bool pci_devs_are_dma_aliases(struct pci_dev *dev1, struct pci_dev *dev2)
>  	return (dev1->dma_alias_mask &&
>  		test_bit(dev2->devfn, dev1->dma_alias_mask)) ||
>  	       (dev2->dma_alias_mask &&
> -		test_bit(dev1->devfn, dev2->dma_alias_mask));
> +		test_bit(dev1->devfn, dev2->dma_alias_mask)) ||
> +	       pci_real_dma_dev(dev1) == dev2 ||
> +	       pci_real_dma_dev(dev2) == dev1;
>  }
>  
>  bool pci_device_is_present(struct pci_dev *pdev)
> @@ -6072,6 +6074,21 @@ void pci_ignore_hotplug(struct pci_dev *dev)
>  }
>  EXPORT_SYMBOL_GPL(pci_ignore_hotplug);
>  
> +/**
> + * pci_real_dma_dev - Get PCI DMA device for PCI device
> + * @dev: the PCI device that may have a PCI DMA alias
> + *
> + * Permits the platform to provide architecture-specific functionality to
> + * devices needing to alias DMA to another PCI device on another PCI bus. If
> + * the PCI device is on the same bus, it is recommended to use
> + * pci_add_dma_alias(). This is the default implementation. Architecture
> + * implementations can override this.
> + */
> +struct pci_dev __weak *pci_real_dma_dev(struct pci_dev *dev)
> +{
> +	return dev;
> +}
> +
>  resource_size_t __weak pcibios_default_alignment(void)
>  {
>  	return 0;
> diff --git a/drivers/pci/search.c b/drivers/pci/search.c
> index e4dbdef..2061672 100644
> --- a/drivers/pci/search.c
> +++ b/drivers/pci/search.c
> @@ -32,6 +32,12 @@ int pci_for_each_dma_alias(struct pci_dev *pdev,
>  	struct pci_bus *bus;
>  	int ret;
>  
> +	/*
> +	 * The device may have an explicit alias requester ID for DMA where the
> +	 * requester is on another PCI bus.
> +	 */
> +	pdev = pci_real_dma_dev(pdev);
>  	ret = fn(pdev, pci_dev_id(pdev), data);
>  	if (ret)
>  		return ret;
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 930fab2..3840a54 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1202,6 +1202,7 @@ u32 pcie_bandwidth_available(struct pci_dev *dev, struct pci_dev **limiting_dev,
>  int pci_select_bars(struct pci_dev *dev, unsigned long flags);
>  bool pci_device_is_present(struct pci_dev *pdev);
>  void pci_ignore_hotplug(struct pci_dev *dev);
> +struct pci_dev *pci_real_dma_dev(struct pci_dev *dev);
>  
>  int __printf(6, 7) pci_request_irq(struct pci_dev *dev, unsigned int nr,
>  		irq_handler_t handler, irq_handler_t thread_fn, void *dev_id,
> -- 
> 1.8.3.1
> 
