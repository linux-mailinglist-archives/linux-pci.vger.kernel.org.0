Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79F232C48DE
	for <lists+linux-pci@lfdr.de>; Wed, 25 Nov 2020 21:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727690AbgKYUMT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Nov 2020 15:12:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:50632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726009AbgKYUMT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 25 Nov 2020 15:12:19 -0500
Received: from localhost (129.sub-72-107-112.myvzw.com [72.107.112.129])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 129A8206C0;
        Wed, 25 Nov 2020 20:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606335137;
        bh=j2R/4pA5Knalus7Wh9g9NQPdMfZrK8tI1rIKeV34iSk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=EQsIYrs90gV2m/wHMkLGsvYx/AzLrY8fdKGkfvlSfKq4pGSmygdUHW/QfBudrbR73
         nKqBSsk8E7kd3Mkzv8ykBYes/i1dz/6348tDez8YcxNjl+IZ3K7l6LtY+BVb4vdJjV
         ED6dfW1GPFM/pRKp8az1nhouQJdXynIlM8qluCZM=
Date:   Wed, 25 Nov 2020 14:12:15 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ashok.raj@intel.com,
        knsathya@kernel.org
Subject: Re: [PATCH v11 2/5] ACPI/PCI: Ignore _OSC negotiation result if
 pcie_ports_native is set.
Message-ID: <20201125201215.GA673882@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc87c9e675118960949043a832bed86bc22becbd.1603766889.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 26, 2020 at 07:57:05PM -0700, Kuppuswamy Sathyanarayanan wrote:
> pcie_ports_native is set only if user requests native handling
> of PCIe capabilities via pcie_port_setup command line option.
> User input takes precedence over _OSC based control negotiation
> result. So consider the _OSC negotiated result only if
> pcie_ports_native is unset.
> 
> Also, since struct pci_host_bridge ->native_* members caches the
> ownership status of various PCIe capabilities, use them instead
> of distributed checks for pcie_ports_native.
> 
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>  drivers/acpi/pci_root.c           | 35 ++++++++++++++++++++++---------
>  drivers/pci/hotplug/pciehp_core.c |  2 +-
>  drivers/pci/pci-acpi.c            |  3 ---
>  drivers/pci/pcie/aer.c            |  2 +-
>  drivers/pci/pcie/portdrv_core.c   |  9 +++-----
>  include/linux/acpi.h              |  2 ++
>  6 files changed, 32 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index c12b5fb3e8fb..a9e6b782622d 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -41,6 +41,12 @@ static int acpi_pci_root_scan_dependent(struct acpi_device *adev)
>  				| OSC_PCI_CLOCK_PM_SUPPORT \
>  				| OSC_PCI_MSI_SUPPORT)
>  
> +#define OSC_OWNER(ctrl, bit, flag) \
> +	do { \
> +		if (!(ctrl & bit)) \
> +			flag = 0;  \
> +	} while (0)
> +
>  static const struct acpi_device_id root_device_ids[] = {
>  	{"PNP0A03", 0},
>  	{"", 0},
> @@ -887,6 +893,7 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
>  	struct pci_bus *bus;
>  	struct pci_host_bridge *host_bridge;
>  	union acpi_object *obj;
> +	u32 ctrl;
>  
>  	info->root = root;
>  	info->bridge = device;
> @@ -912,18 +919,26 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
>  		goto out_release_info;
>  
>  	host_bridge = to_pci_host_bridge(bus->bridge);
> -	if (!(root->osc_control_set & OSC_PCI_EXPRESS_NATIVE_HP_CONTROL))
> -		host_bridge->native_pcie_hotplug = 0;
> +
> +	if (pcie_ports_native) {
> +		decode_osc_control(root, "OS forcibly taking over",
> +				   OSC_PCI_EXPRESS_CONTROL_MASKS);

The only place OSC_PCI_EXPRESS_CONTROL_MASKS is used is right here, so
it's kind of pointless.

I think I'd rather have this:

  dev_info(&root->device->dev, "Ignoring PCIe-related _OSC results because \"pcie_ports=native\" specified\n");

> +	} else {
> +		ctrl = root->osc_control_set;
> +		OSC_OWNER(ctrl, OSC_PCI_EXPRESS_NATIVE_HP_CONTROL,
> +			  host_bridge->native_pcie_hotplug);
> +		OSC_OWNER(ctrl, OSC_PCI_EXPRESS_AER_CONTROL,
> +			  host_bridge->native_aer);
> +		OSC_OWNER(ctrl, OSC_PCI_EXPRESS_PME_CONTROL,
> +			  host_bridge->native_pme);
> +		OSC_OWNER(ctrl, OSC_PCI_EXPRESS_LTR_CONTROL,
> +			  host_bridge->native_ltr);
> +		OSC_OWNER(ctrl, OSC_PCI_EXPRESS_DPC_CONTROL,
> +			  host_bridge->native_dpc);
> +	}
> +
>  	if (!(root->osc_control_set & OSC_PCI_SHPC_NATIVE_HP_CONTROL))
>  		host_bridge->native_shpc_hotplug = 0;
> -	if (!(root->osc_control_set & OSC_PCI_EXPRESS_AER_CONTROL))
> -		host_bridge->native_aer = 0;
> -	if (!(root->osc_control_set & OSC_PCI_EXPRESS_PME_CONTROL))
> -		host_bridge->native_pme = 0;
> -	if (!(root->osc_control_set & OSC_PCI_EXPRESS_LTR_CONTROL))
> -		host_bridge->native_ltr = 0;
> -	if (!(root->osc_control_set & OSC_PCI_EXPRESS_DPC_CONTROL))
> -		host_bridge->native_dpc = 0;

followed by something like this after we're done fiddling with all the
host_bridge->native* bits:

  #define FLAG(x) ((x) ? '+' : '-')

  dev_info(&root->device->dev, "OS native features: SHPCHotplug%c PCIeCapability%c PCIeHotplug%c PME%c AER%c DPC%c LTR%c\n",
           FLAG(host_bridge->native_shpc_hotplug),
	   ?,
           FLAG(host_bridge->native_pcie_hotplug),
	   ...);

But I don't know how to handle OSC_PCI_EXPRESS_CAPABILITY_CONTROL
since we don't track it the same way.  Maybe we'd have to omit it from
this message for now?

>  	/*
>  	 * Evaluate the "PCI Boot Configuration" _DSM Function.  If it
> diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
> index ad3393930ecb..d1831e6bf60a 100644
> --- a/drivers/pci/hotplug/pciehp_core.c
> +++ b/drivers/pci/hotplug/pciehp_core.c
> @@ -256,7 +256,7 @@ static bool pme_is_native(struct pcie_device *dev)
>  	const struct pci_host_bridge *host;
>  
>  	host = pci_find_host_bridge(dev->port->bus);
> -	return pcie_ports_native || host->native_pme;
> +	return host->native_pme;
>  }
>  
>  static void pciehp_disable_interrupt(struct pcie_device *dev)
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index bf03648c2072..a84f75ec6df8 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -800,9 +800,6 @@ bool pciehp_is_native(struct pci_dev *bridge)
>  	if (!(slot_cap & PCI_EXP_SLTCAP_HPC))
>  		return false;
>  
> -	if (pcie_ports_native)
> -		return true;
> -
>  	host = pci_find_host_bridge(bridge->bus);
>  	return host->native_pcie_hotplug;
>  }
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 65dff5f3457a..79bb441139c2 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -219,7 +219,7 @@ int pcie_aer_is_native(struct pci_dev *dev)
>  	if (!dev->aer_cap)
>  		return 0;
>  
> -	return pcie_ports_native || host->native_aer;
> +	return host->native_aer;
>  }
>  
>  int pci_enable_pcie_error_reporting(struct pci_dev *dev)
> diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
> index 50a9522ab07d..ccd5e0ce5605 100644
> --- a/drivers/pci/pcie/portdrv_core.c
> +++ b/drivers/pci/pcie/portdrv_core.c
> @@ -208,8 +208,7 @@ static int get_port_device_capability(struct pci_dev *dev)
>  	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
>  	int services = 0;
>  
> -	if (dev->is_hotplug_bridge &&
> -	    (pcie_ports_native || host->native_pcie_hotplug)) {
> +	if (dev->is_hotplug_bridge && host->native_pcie_hotplug) {
>  		services |= PCIE_PORT_SERVICE_HP;
>  
>  		/*
> @@ -221,8 +220,7 @@ static int get_port_device_capability(struct pci_dev *dev)
>  	}
>  
>  #ifdef CONFIG_PCIEAER
> -	if (dev->aer_cap && pci_aer_available() &&
> -	    (pcie_ports_native || host->native_aer)) {
> +	if (dev->aer_cap && pci_aer_available() && host->native_aer) {
>  		services |= PCIE_PORT_SERVICE_AER;
>  
>  		/*
> @@ -238,8 +236,7 @@ static int get_port_device_capability(struct pci_dev *dev)
>  	 * Event Collectors can also generate PMEs, but we don't handle
>  	 * those yet.
>  	 */
> -	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT &&
> -	    (pcie_ports_native || host->native_pme)) {
> +	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT && host->native_pme) {
>  		services |= PCIE_PORT_SERVICE_PME;
>  
>  		/*
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 39263c6b52e1..35689f4e8e1f 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -569,6 +569,8 @@ extern bool osc_pc_lpi_support_confirmed;
>  #define OSC_PCI_EXPRESS_LTR_CONTROL		0x00000020
>  #define OSC_PCI_EXPRESS_DPC_CONTROL		0x00000080
>  #define OSC_PCI_CONTROL_MASKS			0x000000bf
> +/* Masks specific to PCIe Capabilities */
> +#define OSC_PCI_EXPRESS_CONTROL_MASKS		0x000000bd
>  
>  #define ACPI_GSB_ACCESS_ATTRIB_QUICK		0x00000002
>  #define ACPI_GSB_ACCESS_ATTRIB_SEND_RCV         0x00000004
> -- 
> 2.17.1
> 
