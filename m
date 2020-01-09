Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 701631363AB
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jan 2020 00:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728533AbgAIXLo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Jan 2020 18:11:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:51414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726299AbgAIXLo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 Jan 2020 18:11:44 -0500
Received: from localhost (mobile-166-170-223-177.mycingular.net [166.170.223.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E04C22073A;
        Thu,  9 Jan 2020 23:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578611503;
        bh=dhPLAlyVcnx4/SDqpz6V/KM2GWr4mIZ3arCcmlZBD14=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=tvWR4qyiWV0MqUDef2PBNapevfkoIbFPg7BPm9xBxDNCP81sqJYBhw+OV2unLD377
         0+ENfwOSwat8qiFfMjRKhcl2smTZuE7b6Ub3cdXDzW/0FdEOMb7Ah3cR85F1wbQQRp
         Mm+HkkztNXtfss+ZexcW3Ib4aPs++lfL7m7iY3iI=
Date:   Thu, 9 Jan 2020 17:11:41 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jon Derrick <jonathan.derrick@intel.com>
Cc:     iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Keith Busch <kbusch@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Christoph Hellwig <hch@lst.de>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v2 3/5] PCI: Introduce direct dma alias
Message-ID: <20200109231141.GA41540@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578580256-3483-4-git-send-email-jonathan.derrick@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In subject:
s/Introduce direct dma alias/Add pci_direct_dma_alias()/

On Thu, Jan 09, 2020 at 07:30:54AM -0700, Jon Derrick wrote:
> The current dma alias implementation requires the aliased device be on
> the same bus as the dma parent. This introduces an arch-specific
> mechanism to point to an arbitrary struct device when doing mapping and
> pci alias search.

"arbitrary struct device" is a little weird since an arbitrary device
doesn't have to be a PCI device, but these mappings and aliases only
make sense in the PCI domain.

Maybe it has something to do with pci_sysdata.vmd_dev being a
"struct device *" rather than a "struct pci_dev *"?  I don't know why
that is, because it looks like every place you use it, you use
to_pci_dev() to get the pci_dev pointer back anyway.  But I assume you
have some good reason for that.

s/dma/DMA/
s/pci/PCI/
(above and also in code comments below)

> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
> ---
>  arch/x86/pci/common.c |  7 +++++++
>  drivers/pci/pci.c     | 17 ++++++++++++++++-
>  drivers/pci/search.c  |  9 +++++++++
>  include/linux/pci.h   |  1 +
>  4 files changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
> index 1e59df0..565cc17 100644
> --- a/arch/x86/pci/common.c
> +++ b/arch/x86/pci/common.c
> @@ -736,3 +736,10 @@ int pci_ext_cfg_avail(void)
>  	else
>  		return 0;
>  }
> +
> +#if IS_ENABLED(CONFIG_VMD)
> +struct device *pci_direct_dma_alias(struct pci_dev *dev)
> +{
> +	return to_pci_sysdata(dev->bus)->vmd_dev;
> +}
> +#endif
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index ad746d9..e4269e9 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -6034,7 +6034,9 @@ bool pci_devs_are_dma_aliases(struct pci_dev *dev1, struct pci_dev *dev2)
>  	return (dev1->dma_alias_mask &&
>  		test_bit(dev2->devfn, dev1->dma_alias_mask)) ||
>  	       (dev2->dma_alias_mask &&
> -		test_bit(dev1->devfn, dev2->dma_alias_mask));
> +		test_bit(dev1->devfn, dev2->dma_alias_mask)) ||
> +	       (pci_direct_dma_alias(dev1) == &dev2->dev) ||
> +	       (pci_direct_dma_alias(dev2) == &dev1->dev);
>  }
>  
>  bool pci_device_is_present(struct pci_dev *pdev)
> @@ -6058,6 +6060,19 @@ void pci_ignore_hotplug(struct pci_dev *dev)
>  }
>  EXPORT_SYMBOL_GPL(pci_ignore_hotplug);
>  
> +/**
> + * pci_direct_dma_alias - Get dma alias for pci device
> + * @dev: the PCI device that may have a dma alias
> + *
> + * Permits the platform to provide architecture-specific functionality to
> + * devices needing to alias dma to another device. This is the default
> + * implementation. Architecture implementations can override this.
> + */
> +struct device __weak *pci_direct_dma_alias(struct pci_dev *dev)
> +{
> +	return NULL;
> +}
> +
>  resource_size_t __weak pcibios_default_alignment(void)
>  {
>  	return 0;
> diff --git a/drivers/pci/search.c b/drivers/pci/search.c
> index bade140..6d61209 100644
> --- a/drivers/pci/search.c
> +++ b/drivers/pci/search.c
> @@ -32,6 +32,15 @@ int pci_for_each_dma_alias(struct pci_dev *pdev,
>  	struct pci_bus *bus;
>  	int ret;
>  
> +	if (unlikely(pci_direct_dma_alias(pdev))) {
> +		struct device *dev = pci_direct_dma_alias(pdev);
> +
> +		if (dev_is_pci(dev))
> +			pdev = to_pci_dev(dev);
> +		return fn(pdev, PCI_DEVID(pdev->bus->number, pdev->devfn),
> +			  data);
> +	}
> +
>  	ret = fn(pdev, pci_dev_id(pdev), data);
>  	if (ret)
>  		return ret;
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index c393dff..82494d3 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1202,6 +1202,7 @@ u32 pcie_bandwidth_available(struct pci_dev *dev, struct pci_dev **limiting_dev,
>  int pci_select_bars(struct pci_dev *dev, unsigned long flags);
>  bool pci_device_is_present(struct pci_dev *pdev);
>  void pci_ignore_hotplug(struct pci_dev *dev);
> +struct device *pci_direct_dma_alias(struct pci_dev *dev);
>  
>  int __printf(6, 7) pci_request_irq(struct pci_dev *dev, unsigned int nr,
>  		irq_handler_t handler, irq_handler_t thread_fn, void *dev_id,
> -- 
> 1.8.3.1
> 
