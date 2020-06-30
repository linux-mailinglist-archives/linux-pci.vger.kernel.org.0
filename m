Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD91F20EFAB
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jun 2020 09:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731019AbgF3Hig (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Jun 2020 03:38:36 -0400
Received: from mga06.intel.com ([134.134.136.31]:17194 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731076AbgF3Hig (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 30 Jun 2020 03:38:36 -0400
IronPort-SDR: enRu76Hxh25iw2o1Q91dyrEFSWvF+j1kRBV62xXvele7M3W61auaFMX3YngGbyy74AojjrqYe5
 BD+66PgfV/+g==
X-IronPort-AV: E=McAfee;i="6000,8403,9666"; a="207680650"
X-IronPort-AV: E=Sophos;i="5.75,296,1589266800"; 
   d="scan'208";a="207680650"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2020 00:38:35 -0700
IronPort-SDR: 5Rzu2gh6P8gXyz5LRBr0iXOPG7YJJHK7jjxO44B5I8lrvuOGm6ESOwTF9wOo72MgNhMGd8l1AX
 iEjjH3hNJxNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,296,1589266800"; 
   d="scan'208";a="266410137"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.249.173.186]) ([10.249.173.186])
  by fmsmga008.fm.intel.com with ESMTP; 30 Jun 2020 00:38:28 -0700
Cc:     baolu.lu@linux.intel.com
Subject: Re: [PATCH v2 2/7] PCI: Set "untrusted" flag for truly external
 devices only
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
 <20200630044943.3425049-3-rajatja@google.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <606281b8-f71b-edb2-8e06-9f91a0cacf62@linux.intel.com>
Date:   Tue, 30 Jun 2020 15:38:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200630044943.3425049-3-rajatja@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2020/6/30 12:49, Rajat Jain wrote:
> The "ExternalFacing" devices (root ports) are still internal devices that
> sit on the internal system fabric and thus trusted. Currently they were
> being marked untrusted.
> 
> This patch uses the platform flag to identify the external facing devices
> and then use it to mark any downstream devices as "untrusted". The
> external-facing devices themselves are left as "trusted". This was
> discussed here: https://lkml.org/lkml/2020/6/10/1049
> 
> Signed-off-by: Rajat Jain <rajatja@google.com>

For changes in Intel VT-d driver,

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu

> ---
> v2: cosmetic changes in commit log
> 
>   drivers/iommu/intel/iommu.c |  2 +-
>   drivers/pci/of.c            |  2 +-
>   drivers/pci/pci-acpi.c      | 13 +++++++------
>   drivers/pci/probe.c         |  2 +-
>   include/linux/pci.h         |  8 ++++++++
>   5 files changed, 18 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index d759e7234e982..1ccb224f82496 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -4743,7 +4743,7 @@ static inline bool has_untrusted_dev(void)
>   	struct pci_dev *pdev = NULL;
>   
>   	for_each_pci_dev(pdev)
> -		if (pdev->untrusted)
> +		if (pdev->untrusted || pdev->external_facing)
>   			return true;
>   
>   	return false;
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index 27839cd2459f6..22727fc9558df 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -42,7 +42,7 @@ void pci_set_bus_of_node(struct pci_bus *bus)
>   	} else {
>   		node = of_node_get(bus->self->dev.of_node);
>   		if (node && of_property_read_bool(node, "external-facing"))
> -			bus->self->untrusted = true;
> +			bus->self->external_facing = true;
>   	}
>   
>   	bus->dev.of_node = node;
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index 7224b1e5f2a83..492c07805caf8 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -1213,22 +1213,23 @@ static void pci_acpi_optimize_delay(struct pci_dev *pdev,
>   	ACPI_FREE(obj);
>   }
>   
> -static void pci_acpi_set_untrusted(struct pci_dev *dev)
> +static void pci_acpi_set_external_facing(struct pci_dev *dev)
>   {
>   	u8 val;
>   
> -	if (pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT)
> +	if (pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT &&
> +	    pci_pcie_type(dev) != PCI_EXP_TYPE_DOWNSTREAM)
>   		return;
>   	if (device_property_read_u8(&dev->dev, "ExternalFacingPort", &val))
>   		return;
>   
>   	/*
> -	 * These root ports expose PCIe (including DMA) outside of the
> -	 * system so make sure we treat them and everything behind as
> +	 * These root/down ports expose PCIe (including DMA) outside of the
> +	 * system so make sure we treat everything behind them as
>   	 * untrusted.
>   	 */
>   	if (val)
> -		dev->untrusted = 1;
> +		dev->external_facing = 1;
>   }
>   
>   static void pci_acpi_setup(struct device *dev)
> @@ -1240,7 +1241,7 @@ static void pci_acpi_setup(struct device *dev)
>   		return;
>   
>   	pci_acpi_optimize_delay(pci_dev, adev->handle);
> -	pci_acpi_set_untrusted(pci_dev);
> +	pci_acpi_set_external_facing(pci_dev);
>   	pci_acpi_add_edr_notifier(pci_dev);
>   
>   	pci_acpi_add_pm_notifier(adev, pci_dev);
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 6d87066a5ecc5..8c40c00413e74 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1552,7 +1552,7 @@ static void set_pcie_untrusted(struct pci_dev *dev)
>   	 * untrusted as well.
>   	 */
>   	parent = pci_upstream_bridge(dev);
> -	if (parent && parent->untrusted)
> +	if (parent && (parent->untrusted || parent->external_facing))
>   		dev->untrusted = true;
>   }
>   
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index a26be5332bba6..fe1bc603fda40 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -432,6 +432,14 @@ struct pci_dev {
>   	 * mappings to make sure they cannot access arbitrary memory.
>   	 */
>   	unsigned int	untrusted:1;
> +	/*
> +	 * Devices are marked as external-facing using info from platform
> +	 * (ACPI / devicetree). An external-facing device is still an internal
> +	 * trusted device, but it faces external untrusted devices. Thus any
> +	 * devices enumerated downstream an external-facing device is marked
> +	 * as untrusted.
> +	 */
> +	unsigned int	external_facing:1;
>   	unsigned int	broken_intx_masking:1;	/* INTx masking can't be used */
>   	unsigned int	io_window_1k:1;		/* Intel bridge 1K I/O windows */
>   	unsigned int	irq_managed:1;
> 
