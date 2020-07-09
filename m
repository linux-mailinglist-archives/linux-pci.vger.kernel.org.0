Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CAB521AB3B
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jul 2020 01:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgGIXHU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Jul 2020 19:07:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:39222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726222AbgGIXHU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 Jul 2020 19:07:20 -0400
Received: from localhost (mobile-166-175-191-139.mycingular.net [166.175.191.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 513802070E;
        Thu,  9 Jul 2020 23:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594336038;
        bh=pG0hyJgy3HfHmmTIp7+CAj4hzgrKbxBJXzWFRVXMh2M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=NXQjvGGmtO6et9wR19CUrKLO845nLiIq3bmlehsbNBo78+GFJ+5lpXWlWACXcuT0U
         0UiHXPbg906rZhejqB283nyCnnyG8ZjqiJEOsv5uuOBJCPACUwx+9LjMQUJN6SxNZE
         nSJRIz+0g49K6izzsrtQ1P2N7Supc/bAcqOd8KmE=
Date:   Thu, 9 Jul 2020 18:07:16 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     sathyanarayanan.kuppuswamy@linux.intel.com
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ashok.raj@intel.com
Subject: Re: [PATCH v6 1/4] ACPI/PCI: Ignore _OSC negotiation result if
 pcie_ports_native is set.
Message-ID: <20200709230716.GA23972@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80eae2d1cf4e593da7a83a00ad59915ec398f748.1593195899.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 26, 2020 at 11:32:33AM -0700, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
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
>  drivers/acpi/pci_root.c           | 26 ++++++++++++++------------
>  drivers/pci/hotplug/pciehp_core.c |  2 +-
>  drivers/pci/pci-acpi.c            |  3 ---
>  drivers/pci/pcie/aer.c            |  2 +-
>  drivers/pci/pcie/portdrv_core.c   |  9 +++------
>  drivers/pci/probe.c               |  5 +++--
>  6 files changed, 22 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index f90e841c59f5..02fab8b0118e 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -914,18 +914,20 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
>  		goto out_release_info;
>  
>  	host_bridge = to_pci_host_bridge(bus->bridge);
> -	if (!(root->osc_control_set & OSC_PCI_EXPRESS_NATIVE_HP_CONTROL))
> -		host_bridge->native_pcie_hotplug = 0;
> -	if (!(root->osc_control_set & OSC_PCI_SHPC_NATIVE_HP_CONTROL))
> -		host_bridge->native_shpc_hotplug = 0;
> -	if (!(root->osc_control_set & OSC_PCI_EXPRESS_AER_CONTROL))
> -		host_bridge->native_aer = 0;
> -	if (!(root->osc_control_set & OSC_PCI_EXPRESS_PME_CONTROL))
> -		host_bridge->native_pme = 0;
> -	if (!(root->osc_control_set & OSC_PCI_EXPRESS_LTR_CONTROL))
> -		host_bridge->native_ltr = 0;
> -	if (!(root->osc_control_set & OSC_PCI_EXPRESS_DPC_CONTROL))
> -		host_bridge->native_dpc = 0;
> +	if (!pcie_ports_native) {
> +		if (!(root->osc_control_set & OSC_PCI_EXPRESS_NATIVE_HP_CONTROL))
> +			host_bridge->native_pcie_hotplug = 0;
> +		if (!(root->osc_control_set & OSC_PCI_SHPC_NATIVE_HP_CONTROL))
> +			host_bridge->native_shpc_hotplug = 0;
> +		if (!(root->osc_control_set & OSC_PCI_EXPRESS_AER_CONTROL))
> +			host_bridge->native_aer = 0;
> +		if (!(root->osc_control_set & OSC_PCI_EXPRESS_PME_CONTROL))
> +			host_bridge->native_pme = 0;
> +		if (!(root->osc_control_set & OSC_PCI_EXPRESS_LTR_CONTROL))
> +			host_bridge->native_ltr = 0;
> +		if (!(root->osc_control_set & OSC_PCI_EXPRESS_DPC_CONTROL))
> +			host_bridge->native_dpc = 0;
> +	}

When the user boots with "pcie_ports=native", should we evaluate _OSC
at all?  It seems confusing to say "OK, Mr. Firmware, here are the
features we want to use", and then turn around and use them all
regardless of what the platform said.  Why not just ignore the
firmware completely and go ahead and use everything?

I can't remember if there's a reason we need to call
negotiate_os_control() so early and then hang on to the results until
we get here:

  acpi_pci_root_add
    negotiate_os_control                      <--- eval _OSC
    pci_acpi_scan_root
      acpi_pci_root_create
        pci_create_root_bus
        if (!(root->osc_control_set & ...))   <--- use results
          host_bridge->native_... = 0;

I think it would be a lot simpler if we could do the _OSC negotiation
right here where we need most of the results.  It would be even better
if we could update the host_bridge->native_... items directly inside
negotiate_os_control() so we wouldn't have to hang onto the
osc_control_set mask.

>  	/*
>  	 * Evaluate the "PCI Boot Configuration" _DSM Function.  If it
> diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
> index bf779f291f15..5fc999bf6f1b 100644
> --- a/drivers/pci/hotplug/pciehp_core.c
> +++ b/drivers/pci/hotplug/pciehp_core.c
> @@ -255,7 +255,7 @@ static bool pme_is_native(struct pcie_device *dev)
>  	const struct pci_host_bridge *host;
>  
>  	host = pci_find_host_bridge(dev->port->bus);
> -	return pcie_ports_native || host->native_pme;
> +	return host->native_pme;
>  }
>  
>  static void pciehp_disable_interrupt(struct pcie_device *dev)
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index 7224b1e5f2a8..e09589571a9d 100644
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
> index 3acf56683915..d663bd9c7257 100644
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

I *love* that you removed pcie_ports_native from all these places.

>  		/*
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 2f66988cea25..5fb90bb9b4e3 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -588,13 +588,14 @@ static void pci_init_host_bridge(struct pci_host_bridge *bridge)
>  	 * may implement its own AER handling and use _OSC to prevent the
>  	 * OS from interfering.
>  	 */
> +#ifdef CONFIG_PCIEPORTBUS
>  	bridge->native_aer = 1;
>  	bridge->native_pcie_hotplug = 1;
> -	bridge->native_shpc_hotplug = 1;
>  	bridge->native_pme = 1;
>  	bridge->native_ltr = 1;
>  	bridge->native_dpc = 1;
> -
> +#endif
> +	bridge->native_shpc_hotplug = 1;

This looks like a bugfix that should be its own patch.

>  	device_initialize(&bridge->dev);
>  }
>  
> -- 
> 2.17.1
> 
