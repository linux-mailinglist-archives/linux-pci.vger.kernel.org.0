Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3C3C13FC05
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2020 23:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389859AbgAPWKF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Jan 2020 17:10:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:42686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388979AbgAPWKF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 16 Jan 2020 17:10:05 -0500
Received: from localhost (mobile-166-170-223-177.mycingular.net [166.170.223.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 255D22073A;
        Thu, 16 Jan 2020 22:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579212604;
        bh=j1j3M27vbKz8clF1SBs8s3ip/nmQhDsJXA241gtfI4M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=fwfuPhaCYiP50auIhrK8Iwl/YJQ8ugSVpH9rj/0698Vrr43aMLzT7av3geY7J5ftp
         viDZDXebp2VRaSX9IjODh+rmt3qIDJBzmpCAt9S+JsSMrqgR/+ibxWNwTyBU+hK/o0
         +uX/4XWji+Vm/GqW+ejB1W+GVMDHNrncwL/7+RBg=
Date:   Thu, 16 Jan 2020 16:10:02 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     sathyanarayanan.kuppuswamy@linux.intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Keith Busch <keith.busch@intel.com>,
        Huong Nguyen <huong.nguyen@dell.com>,
        Austin Bolen <Austin.Bolen@dell.com>
Subject: Re: [PATCH v12 8/8] PCI/ACPI: Enable EDR support
Message-ID: <20200116221002.GA191067@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a15c5467ab8d52ede096b598e14c1beae1ce8e48.1578682741.git.sathyanarayanan.kuppuswamy@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Jan 12, 2020 at 02:44:02PM -0800, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> As per PCI firmware specification r3.2 Downstream Port Containment
> Related Enhancements ECN, sec 4.5.1, OS must implement following steps
> to enable/use EDR feature.
> 
> 1. OS can use bit 7 of _OSC Control Field to negotiate control over
> Downstream Port Containment (DPC) configuration of PCIe port. After _OSC
> negotiation, firmware will Set this bit to grant OS control over PCIe
> DPC configuration and Clear it if this feature was requested and denied,
> or was not requested.
> 
> 2. Also, if OS supports EDR, it should expose its support to BIOS by
> setting bit 7 of _OSC Support Field. And if OS sets bit 7 of _OSC
> Control Field it must also expose support for EDR by setting bit 7 of
> _OSC Support Field.
> 
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Len Brown <lenb@kernel.org>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Acked-by: Keith Busch <keith.busch@intel.com>
> Tested-by: Huong Nguyen <huong.nguyen@dell.com>
> Tested-by: Austin Bolen <Austin.Bolen@dell.com>
> ---
>  drivers/acpi/pci_root.c         | 9 +++++++++
>  drivers/pci/pcie/portdrv_core.c | 7 +++++--
>  drivers/pci/probe.c             | 1 +
>  include/linux/acpi.h            | 6 ++++--
>  include/linux/pci.h             | 3 ++-
>  5 files changed, 21 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index d1e666ef3fcc..134e20474dfd 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -131,6 +131,7 @@ static struct pci_osc_bit_struct pci_osc_support_bit[] = {
>  	{ OSC_PCI_CLOCK_PM_SUPPORT, "ClockPM" },
>  	{ OSC_PCI_SEGMENT_GROUPS_SUPPORT, "Segments" },
>  	{ OSC_PCI_MSI_SUPPORT, "MSI" },
> +	{ OSC_PCI_EDR_SUPPORT, "EDR" },
>  	{ OSC_PCI_HPX_TYPE_3_SUPPORT, "HPX-Type3" },
>  };
>  
> @@ -141,6 +142,7 @@ static struct pci_osc_bit_struct pci_osc_control_bit[] = {
>  	{ OSC_PCI_EXPRESS_AER_CONTROL, "AER" },
>  	{ OSC_PCI_EXPRESS_CAPABILITY_CONTROL, "PCIeCapability" },
>  	{ OSC_PCI_EXPRESS_LTR_CONTROL, "LTR" },
> +	{ OSC_PCI_EXPRESS_DPC_CONTROL, "DPC" },
>  };
>  
>  static void decode_osc_bits(struct acpi_pci_root *root, char *msg, u32 word,
> @@ -440,6 +442,8 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
>  		support |= OSC_PCI_ASPM_SUPPORT | OSC_PCI_CLOCK_PM_SUPPORT;
>  	if (pci_msi_enabled())
>  		support |= OSC_PCI_MSI_SUPPORT;
> +	if (IS_ENABLED(CONFIG_PCIE_EDR))
> +		support |= OSC_PCI_EDR_SUPPORT;
>  
>  	decode_osc_support(root, "OS supports", support);
>  	status = acpi_pci_osc_support(root, support);
> @@ -487,6 +491,9 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
>  			control |= OSC_PCI_EXPRESS_AER_CONTROL;
>  	}
>  
> +	if (IS_ENABLED(CONFIG_PCIE_DPC))
> +		control |= OSC_PCI_EXPRESS_DPC_CONTROL;

The ECN [1] says:

  If this bit is set by the OS, this indicates that it supports both
  native OS control and firmware ownership models (i.e. Error
  Disconnect Recover notification) of Downstream Port Containment.

But if CONFIG_PCIE_DPC=y and CONFIG_PCIE_EDR is not set, we will set
OSC_PCI_EXPRESS_DPC_CONTROL even though we don't support EDR.  That
doesn't seem to match what the spec says.

I think this needs to be something like:

  if (IS_ENABLED(CONFIG_PCIE_DPC) && IS_ENABLED(CONFIG_PCIE_EDR))
    control |= OSC_PCI_EXPRESS_DPC_CONTROL;

[1] Downstream Port Containment related Enhancements, PCI ECN, Jan 28,
2019, Section 4.5.1, Table 4-5.

>  	requested = control;
>  	status = acpi_pci_osc_control_set(handle, &control,
>  					  OSC_PCI_EXPRESS_CAPABILITY_CONTROL);
> @@ -916,6 +923,8 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
>  		host_bridge->native_pme = 0;
>  	if (!(root->osc_control_set & OSC_PCI_EXPRESS_LTR_CONTROL))
>  		host_bridge->native_ltr = 0;
> +	if (!(root->osc_control_set & OSC_PCI_EXPRESS_DPC_CONTROL))
> +		host_bridge->native_dpc = 0;
>  
>  	/*
>  	 * Evaluate the "PCI Boot Configuration" _DSM Function.  If it
> diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
> index 5075cb9e850c..009742c865d6 100644
> --- a/drivers/pci/pcie/portdrv_core.c
> +++ b/drivers/pci/pcie/portdrv_core.c
> @@ -253,10 +253,13 @@ static int get_port_device_capability(struct pci_dev *dev)
>  	/*
>  	 * With dpc-native, allow Linux to use DPC even if it doesn't have
>  	 * permission to use AER.
> +	 * If EDR support is enabled in OS, then even if AER is not handled in
> +	 * OS, DPC service can be enabled.
>  	 */
>  	if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC) &&
> -	    pci_aer_available() &&
> -	    (pcie_ports_dpc_native || (services & PCIE_PORT_SERVICE_AER)))
> +	    ((IS_ENABLED(CONFIG_PCIE_EDR) && !host->native_dpc) ||
> +	    (pci_aer_available() &&
> +	    (pcie_ports_dpc_native || (services & PCIE_PORT_SERVICE_AER)))))
>  		services |= PCIE_PORT_SERVICE_DPC;
>  
>  	if (pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM ||
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 512cb4312ddd..c9a9c5b42e72 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -598,6 +598,7 @@ static void pci_init_host_bridge(struct pci_host_bridge *bridge)
>  	bridge->native_shpc_hotplug = 1;
>  	bridge->native_pme = 1;
>  	bridge->native_ltr = 1;
> +	bridge->native_dpc = 1;
>  }
>  
>  struct pci_host_bridge *pci_alloc_host_bridge(size_t priv)
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 0f37a7d5fa77..0a7aaa452a98 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -515,8 +515,9 @@ extern bool osc_pc_lpi_support_confirmed;
>  #define OSC_PCI_CLOCK_PM_SUPPORT		0x00000004
>  #define OSC_PCI_SEGMENT_GROUPS_SUPPORT		0x00000008
>  #define OSC_PCI_MSI_SUPPORT			0x00000010
> +#define OSC_PCI_EDR_SUPPORT			0x00000080
>  #define OSC_PCI_HPX_TYPE_3_SUPPORT		0x00000100
> -#define OSC_PCI_SUPPORT_MASKS			0x0000011f
> +#define OSC_PCI_SUPPORT_MASKS			0x0000019f
>  
>  /* PCI Host Bridge _OSC: Capabilities DWORD 3: Control Field */
>  #define OSC_PCI_EXPRESS_NATIVE_HP_CONTROL	0x00000001
> @@ -525,7 +526,8 @@ extern bool osc_pc_lpi_support_confirmed;
>  #define OSC_PCI_EXPRESS_AER_CONTROL		0x00000008
>  #define OSC_PCI_EXPRESS_CAPABILITY_CONTROL	0x00000010
>  #define OSC_PCI_EXPRESS_LTR_CONTROL		0x00000020
> -#define OSC_PCI_CONTROL_MASKS			0x0000003f
> +#define OSC_PCI_EXPRESS_DPC_CONTROL		0x00000080
> +#define OSC_PCI_CONTROL_MASKS			0x000000bf
>  
>  #define ACPI_GSB_ACCESS_ATTRIB_QUICK		0x00000002
>  #define ACPI_GSB_ACCESS_ATTRIB_SEND_RCV         0x00000004
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index c393dff2d66f..0b7c63c7888d 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -510,8 +510,9 @@ struct pci_host_bridge {
>  	unsigned int	native_shpc_hotplug:1;	/* OS may use SHPC hotplug */
>  	unsigned int	native_pme:1;		/* OS may use PCIe PME */
>  	unsigned int	native_ltr:1;		/* OS may use PCIe LTR */
> -	unsigned int	preserve_config:1;	/* Preserve FW resource setup */
> +	unsigned int	native_dpc:1;		/* OS may use PCIe DPC */
>  
> +	unsigned int	preserve_config:1;	/* Preserve FW resource setup */

The blank line should stay after the bitfields.  Then this will look
like the simple insertion of native_dpc, as it should.

>  	/* Resource alignment requirements */
>  	resource_size_t (*align_resource)(struct pci_dev *dev,
>  			const struct resource *res,
> -- 
> 2.21.0
> 
