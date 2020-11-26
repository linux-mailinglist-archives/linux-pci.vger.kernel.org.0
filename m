Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DDEB2C4DBC
	for <lists+linux-pci@lfdr.de>; Thu, 26 Nov 2020 04:21:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387404AbgKZDU7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Nov 2020 22:20:59 -0500
Received: from mga06.intel.com ([134.134.136.31]:3826 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733213AbgKZDU7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 25 Nov 2020 22:20:59 -0500
IronPort-SDR: Hq/S3XjklneIBjyMYiVXgrnMD30Juhequ8RGkwyKExValS2JwCzLcT6xATxanESdNFzDIsgOZ1
 Mrrg71X6JR2w==
X-IronPort-AV: E=McAfee;i="6000,8403,9816"; a="233836712"
X-IronPort-AV: E=Sophos;i="5.78,370,1599548400"; 
   d="scan'208";a="233836712"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2020 19:20:57 -0800
IronPort-SDR: xRgQNBN6QMGNf3R7kIqBZNtQUU1pxrZR/TucTZfFzkaihBsMmbJ7rrHn1bADioSwKD07bzOBWZ
 vU93fmL2otWw==
X-IronPort-AV: E=Sophos;i="5.78,370,1599548400"; 
   d="scan'208";a="333240193"
Received: from jjbeatty-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.209.150.216])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2020 19:20:55 -0800
Subject: Re: [PATCH 4/5] PCI/ACPI: Centralize pcie_ports_native checking
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     ashok.raj@intel.com, knsathya@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20201126011816.711106-1-helgaas@kernel.org>
 <20201126011816.711106-5-helgaas@kernel.org>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <0c7eb524-ff3a-d3ec-f9e6-7656e75b3437@linux.intel.com>
Date:   Wed, 25 Nov 2020 19:20:53 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201126011816.711106-5-helgaas@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 11/25/20 5:18 PM, Bjorn Helgaas wrote:
> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> If the user booted with "pcie_ports=native", we take control of the PCIe
> features unconditionally, regardless of what _OSC says.
> 
> Centralize the testing of pcie_ports_native in acpi_pci_root_create(),
> where we interpret the _OSC results, so other places only have to check
> host_bridge->native_X and we don't have to sprinkle tests of
> pcie_ports_native everywhere.
> 
> [bhelgaas: commit log, rework OSC_PCI_EXPRESS_CONTROL_MASKS, logging]
> Link: https://lore.kernel.org/r/bc87c9e675118960949043a832bed86bc22becbd.1603766889.git.sathyanarayanan.kuppuswamy@linux.intel.com
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>   drivers/acpi/pci_root.c           | 19 +++++++++++++++++++
>   drivers/pci/hotplug/pciehp_core.c |  2 +-
>   drivers/pci/pci-acpi.c            |  3 ---
>   drivers/pci/pcie/aer.c            |  2 +-
>   drivers/pci/pcie/portdrv_core.c   |  9 +++------
>   5 files changed, 24 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index 6db071038fd5..36142ed7b8f8 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -882,6 +882,8 @@ static void acpi_pci_root_release_info(struct pci_host_bridge *bridge)
>   			flag = 0;	\
>   	} while (0)
>   
> +#define FLAG(x)		((x) ? '+' : '-')
> +
>   struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
>   				     struct acpi_pci_root_ops *ops,
>   				     struct acpi_pci_root_info *info,
> @@ -930,6 +932,23 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
>   	OSC_OWNER(ctrl, OSC_PCI_EXPRESS_LTR_CONTROL, host_bridge->native_ltr);
>   	OSC_OWNER(ctrl, OSC_PCI_EXPRESS_DPC_CONTROL, host_bridge->native_dpc);
>   
> +	if (pcie_ports_native) {
> +		dev_info(&root->device->dev, "Taking control of PCIe-related features because \"pcie_ports=native\" specified; may conflict with firmware\n");
> +		host_bridge->native_pcie_hotplug = 1;
> +		host_bridge->native_aer = 1;
> +		host_bridge->native_pme = 1;
> +		host_bridge->native_ltr = 1;
> +		host_bridge->native_dpc = 1;
> +	}
Won't it be better if its merged with above OSC_OWNER() calls? If pcie_ports_native
is set, then above OSC_OWNER() calls for PCIe related features are redundant. Let me
know.
> +
> +	dev_info(&root->device->dev, "OS native features: SHPCHotplug%c PCIeHotplug%c PME%c AER%c DPC%c LTR%c\n",
> +		FLAG(host_bridge->native_shpc_hotplug),
> +		FLAG(host_bridge->native_pcie_hotplug),
> +		FLAG(host_bridge->native_pme),
> +		FLAG(host_bridge->native_aer),
> +		FLAG(host_bridge->native_dpc),
> +		FLAG(host_bridge->native_ltr));
> +
>   	/*
>   	 * Evaluate the "PCI Boot Configuration" _DSM Function.  If it
>   	 * exists and returns 0, we must preserve any PCI resource
> diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
> index ad3393930ecb..d1831e6bf60a 100644
> --- a/drivers/pci/hotplug/pciehp_core.c
> +++ b/drivers/pci/hotplug/pciehp_core.c
> @@ -256,7 +256,7 @@ static bool pme_is_native(struct pcie_device *dev)
>   	const struct pci_host_bridge *host;
>   
>   	host = pci_find_host_bridge(dev->port->bus);
> -	return pcie_ports_native || host->native_pme;
> +	return host->native_pme;
>   }
>   
>   static void pciehp_disable_interrupt(struct pcie_device *dev)
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index bf03648c2072..a84f75ec6df8 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -800,9 +800,6 @@ bool pciehp_is_native(struct pci_dev *bridge)
>   	if (!(slot_cap & PCI_EXP_SLTCAP_HPC))
>   		return false;
>   
> -	if (pcie_ports_native)
> -		return true;
> -
>   	host = pci_find_host_bridge(bridge->bus);
>   	return host->native_pcie_hotplug;
>   }
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 65dff5f3457a..79bb441139c2 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -219,7 +219,7 @@ int pcie_aer_is_native(struct pci_dev *dev)
>   	if (!dev->aer_cap)
>   		return 0;
>   
> -	return pcie_ports_native || host->native_aer;
> +	return host->native_aer;
>   }
>   
>   int pci_enable_pcie_error_reporting(struct pci_dev *dev)
> diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
> index 50a9522ab07d..2a1190e8db60 100644
> --- a/drivers/pci/pcie/portdrv_core.c
> +++ b/drivers/pci/pcie/portdrv_core.c
> @@ -208,8 +208,7 @@ static int get_port_device_capability(struct pci_dev *dev)
>   	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
>   	int services = 0;
>   
> -	if (dev->is_hotplug_bridge &&
> -	    (pcie_ports_native || host->native_pcie_hotplug)) {
> +	if (host->native_pcie_hotplug && dev->is_hotplug_bridge) {
May be this reordering can be split into a different patch ?
>   		services |= PCIE_PORT_SERVICE_HP;
>   
>   		/*
> @@ -221,8 +220,7 @@ static int get_port_device_capability(struct pci_dev *dev)
>   	}
>   
>   #ifdef CONFIG_PCIEAER
> -	if (dev->aer_cap && pci_aer_available() &&
> -	    (pcie_ports_native || host->native_aer)) {
> +	if (host->native_aer && dev->aer_cap && pci_aer_available()) {
same as above.
>   		services |= PCIE_PORT_SERVICE_AER;
>   
>   		/*
> @@ -238,8 +236,7 @@ static int get_port_device_capability(struct pci_dev *dev)
>   	 * Event Collectors can also generate PMEs, but we don't handle
>   	 * those yet.
>   	 */
> -	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT &&
> -	    (pcie_ports_native || host->native_pme)) {
> +	if (host->native_pme && pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT) {
>   		services |= PCIE_PORT_SERVICE_PME;
>   
>   		/*
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
