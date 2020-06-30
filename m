Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C92C320EFB0
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jun 2020 09:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731073AbgF3HkL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Jun 2020 03:40:11 -0400
Received: from mga11.intel.com ([192.55.52.93]:16930 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731033AbgF3HkK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 30 Jun 2020 03:40:10 -0400
IronPort-SDR: no0lj3IEF6D1fSeULMtyqr2fP25Sk/GLzWKSO3cBbqYQOGmZ4HFF7Ki6qaZgkMtC+ZZFWnptJo
 1FKLVY3pERLg==
X-IronPort-AV: E=McAfee;i="6000,8403,9666"; a="144354013"
X-IronPort-AV: E=Sophos;i="5.75,296,1589266800"; 
   d="scan'208";a="144354013"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2020 00:40:08 -0700
IronPort-SDR: gohgJPDOkuKiTboKbRI8vJ63IWD6n3MN8GGNONoKo4aj2OcQ4D9BtTNJeCGRjeTEl7ddmeHyds
 P/aqD8WUW0tQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,296,1589266800"; 
   d="scan'208";a="266410313"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.249.173.186]) ([10.249.173.186])
  by fmsmga008.fm.intel.com with ESMTP; 30 Jun 2020 00:39:42 -0700
Cc:     baolu.lu@linux.intel.com
Subject: Re: [PATCH v2 6/7] PCI: Move pci_dev->untrusted logic to use device
 location instead
To:     Rajat Jain <rajatja@google.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, Raj Ashok <ashok.raj@intel.com>,
        lalithambika.krishnakumar@intel.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Prashant Malani <pmalani@google.com>,
        Benson Leung <bleung@google.com>,
        Todd Broch <tbroch@google.com>,
        Alex Levin <levinale@google.com>,
        Mattias Nissler <mnissler@google.com>,
        Rajat Jain <rajatxjain@gmail.com>,
        Bernie Keany <bernie.keany@intel.com>,
        Aaron Durbin <adurbin@google.com>,
        Diego Rivas <diegorivas@google.com>,
        Duncan Laurie <dlaurie@google.com>,
        Furquan Shaikh <furquan@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Christian Kellner <christian@kellner.me>,
        Alex Williamson <alex.williamson@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        oohall@gmail.com, Saravana Kannan <saravanak@google.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
References: <20200630044943.3425049-1-rajatja@google.com>
 <20200630044943.3425049-7-rajatja@google.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <74181d77-ea1a-2289-1a42-5257ea820364@linux.intel.com>
Date:   Tue, 30 Jun 2020 15:39:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200630044943.3425049-7-rajatja@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2020/6/30 12:49, Rajat Jain wrote:
> The firmware was provinding "ExternalFacing" attribute on PCI root ports,
> to allow the kernel to mark devices behind it as external. Note that the
> firmware provides an immutable, read-only property, i.e. the location of
> the device.
> 
> The use of (external) device location as hint for (dis)trust, is a
> decision that IOMMU drivers have taken, so we should call it out
> explicitly.
> 
> This patch removes the pci_dev->untrusted and changes the users of it to
> use device core provided device location instead. This location is
> populated by PCI using the same "ExternalFacing" firmware info. Any
> device not behind the "ExternalFacing" bridges are marked internal and
> the ones behind such bridges are markes external.
> 
> Signed-off-by: Rajat Jain <rajatja@google.com>

For changes in Intel VT-d driver,

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu

> ---
> v2: (Initial version)
> 
>   drivers/iommu/intel/iommu.c | 31 +++++++++++++++++++++----------
>   drivers/pci/ats.c           |  2 +-
>   drivers/pci/pci-driver.c    |  1 +
>   drivers/pci/pci.c           |  2 +-
>   drivers/pci/probe.c         | 18 ++++++++++++------
>   drivers/pci/quirks.c        |  2 +-
>   include/linux/pci.h         | 10 +---------
>   7 files changed, 38 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 1ccb224f82496..ca66a196f5e97 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -168,6 +168,22 @@ static inline unsigned long virt_to_dma_pfn(void *p)
>   	return page_to_dma_pfn(virt_to_page(p));
>   }
>   
> +static inline bool untrusted_dev(struct device *dev)
> +{
> +	/*
> +	 * Treat all external PCI devices as untrusted devices. These are the
> +	 * devices behing marked behind external-facing bridges as marked by
> +	 * the firmware. The untrusted devices are the ones that can potentially
> +	 * execute DMA attacks and similar. They are typically connected through
> +	 * external thunderbolt ports. When an IOMMU is enabled they should be
> +	 * getting full mappings to ensure they cannot access arbitrary memory.
> +	 */
> +	if (dev_is_pci(dev) && dev_is_external(dev))
> +		return true;
> +
> +	return false;
> +}
> +
>   /* global iommu list, set NULL for ignored DMAR units */
>   static struct intel_iommu **g_iommus;
>   
> @@ -383,8 +399,7 @@ struct device_domain_info *get_domain_info(struct device *dev)
>   DEFINE_SPINLOCK(device_domain_lock);
>   static LIST_HEAD(device_domain_list);
>   
> -#define device_needs_bounce(d) (!intel_no_bounce && dev_is_pci(d) &&	\
> -				to_pci_dev(d)->untrusted)
> +#define device_needs_bounce(d) (!intel_no_bounce && untrusted_dev(d))
>   
>   /*
>    * Iterate over elements in device_domain_list and call the specified
> @@ -2830,7 +2845,7 @@ static int device_def_domain_type(struct device *dev)
>   		 * Prevent any device marked as untrusted from getting
>   		 * placed into the statically identity mapping domain.
>   		 */
> -		if (pdev->untrusted)
> +		if (untrusted_dev(dev))
>   			return IOMMU_DOMAIN_DMA;
>   
>   		if ((iommu_identity_mapping & IDENTMAP_AZALIA) && IS_AZALIA(pdev))
> @@ -3464,7 +3479,6 @@ static void intel_unmap(struct device *dev, dma_addr_t dev_addr, size_t size)
>   	unsigned long iova_pfn;
>   	struct intel_iommu *iommu;
>   	struct page *freelist;
> -	struct pci_dev *pdev = NULL;
>   
>   	domain = find_domain(dev);
>   	BUG_ON(!domain);
> @@ -3477,11 +3491,8 @@ static void intel_unmap(struct device *dev, dma_addr_t dev_addr, size_t size)
>   	start_pfn = mm_to_dma_pfn(iova_pfn);
>   	last_pfn = start_pfn + nrpages - 1;
>   
> -	if (dev_is_pci(dev))
> -		pdev = to_pci_dev(dev);
> -
>   	freelist = domain_unmap(domain, start_pfn, last_pfn);
> -	if (intel_iommu_strict || (pdev && pdev->untrusted) ||
> +	if (intel_iommu_strict || untrusted_dev(dev) ||
>   			!has_iova_flush_queue(&domain->iovad)) {
>   		iommu_flush_iotlb_psi(iommu, domain, start_pfn,
>   				      nrpages, !freelist, 0);
> @@ -4743,7 +4754,7 @@ static inline bool has_untrusted_dev(void)
>   	struct pci_dev *pdev = NULL;
>   
>   	for_each_pci_dev(pdev)
> -		if (pdev->untrusted || pdev->external_facing)
> +		if (pdev->external_facing || untrusted_dev(&pdev->dev))
>   			return true;
>   
>   	return false;
> @@ -6036,7 +6047,7 @@ intel_iommu_domain_set_attr(struct iommu_domain *domain,
>    */
>   static bool risky_device(struct pci_dev *pdev)
>   {
> -	if (pdev->untrusted) {
> +	if (untrusted_dev(&pdev->dev)) {
>   		pci_info(pdev,
>   			 "Skipping IOMMU quirk for dev [%04X:%04X] on untrusted PCI link\n",
>   			 pdev->vendor, pdev->device);
> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> index b761c1f72f672..ebd370f4d5b06 100644
> --- a/drivers/pci/ats.c
> +++ b/drivers/pci/ats.c
> @@ -42,7 +42,7 @@ bool pci_ats_supported(struct pci_dev *dev)
>   	if (!dev->ats_cap)
>   		return false;
>   
> -	return (dev->untrusted == 0);
> +	return (!dev_is_external(&dev->dev));
>   }
>   EXPORT_SYMBOL_GPL(pci_ats_supported);
>   
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index da6510af12214..9608053a8a62c 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -1630,6 +1630,7 @@ struct bus_type pci_bus_type = {
>   	.pm		= PCI_PM_OPS_PTR,
>   	.num_vf		= pci_bus_num_vf,
>   	.dma_configure	= pci_dma_configure,
> +	.supports_site	= true,
>   };
>   EXPORT_SYMBOL(pci_bus_type);
>   
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 79853b52658a2..35f25ac39167b 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3330,7 +3330,7 @@ static void pci_std_enable_acs(struct pci_dev *dev)
>   	/* Upstream Forwarding */
>   	ctrl |= (cap & PCI_ACS_UF);
>   
> -	if (dev->external_facing || dev->untrusted)
> +	if (dev->external_facing || dev_is_external(&dev->dev))
>   		/* Translation Blocking */
>   		ctrl |= (cap & PCI_ACS_TB);
>   
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 8c40c00413e74..1609329cc5b4e 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1543,17 +1543,23 @@ static void set_pcie_thunderbolt(struct pci_dev *dev)
>   	}
>   }
>   
> -static void set_pcie_untrusted(struct pci_dev *dev)
> +static void set_pcie_dev_site(struct pci_dev *dev)
>   {
>   	struct pci_dev *parent;
>   
>   	/*
> -	 * If the upstream bridge is untrusted we treat this device
> -	 * untrusted as well.
> +	 * All devices are considered internal by default, unless behind an
> +	 * external-facing bridge, as marked by the firmware.
> +	 */
> +	dev_set_site(&dev->dev, SITE_INTERNAL);
> +
> +	/*
> +	 * If the upstream bridge is external or external-facing, this device
> +	 * is also external.
>   	 */
>   	parent = pci_upstream_bridge(dev);
> -	if (parent && (parent->untrusted || parent->external_facing))
> -		dev->untrusted = true;
> +	if (parent && (parent->external_facing || dev_is_external(&parent->dev)))
> +		dev_set_site(&dev->dev, SITE_EXTERNAL);
>   }
>   
>   /**
> @@ -1814,7 +1820,7 @@ int pci_setup_device(struct pci_dev *dev)
>   	/* Need to have dev->cfg_size ready */
>   	set_pcie_thunderbolt(dev);
>   
> -	set_pcie_untrusted(dev);
> +	set_pcie_dev_site(dev);
>   
>   	/* "Unknown power state" */
>   	dev->current_state = PCI_UNKNOWN;
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 6294adeac4049..65d0b8745c915 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4980,7 +4980,7 @@ static int pci_quirk_enable_intel_spt_pch_acs(struct pci_dev *dev)
>   	ctrl |= (cap & PCI_ACS_CR);
>   	ctrl |= (cap & PCI_ACS_UF);
>   
> -	if (dev->external_facing || dev->untrusted)
> +	if (dev->external_facing || dev_is_external(&dev->dev))
>   		/* Translation Blocking */
>   		ctrl |= (cap & PCI_ACS_TB);
>   
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index fe1bc603fda40..8bb5065e5aed2 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -424,20 +424,12 @@ struct pci_dev {
>   	unsigned int	is_hotplug_bridge:1;
>   	unsigned int	shpc_managed:1;		/* SHPC owned by shpchp */
>   	unsigned int	is_thunderbolt:1;	/* Thunderbolt controller */
> -	/*
> -	 * Devices marked being untrusted are the ones that can potentially
> -	 * execute DMA attacks and similar. They are typically connected
> -	 * through external ports such as Thunderbolt but not limited to
> -	 * that. When an IOMMU is enabled they should be getting full
> -	 * mappings to make sure they cannot access arbitrary memory.
> -	 */
> -	unsigned int	untrusted:1;
>   	/*
>   	 * Devices are marked as external-facing using info from platform
>   	 * (ACPI / devicetree). An external-facing device is still an internal
>   	 * trusted device, but it faces external untrusted devices. Thus any
>   	 * devices enumerated downstream an external-facing device is marked
> -	 * as untrusted.
> +	 * as external device.
>   	 */
>   	unsigned int	external_facing:1;
>   	unsigned int	broken_intx_masking:1;	/* INTx masking can't be used */
> 
