Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E90498F6E5
	for <lists+linux-pci@lfdr.de>; Fri, 16 Aug 2019 00:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727601AbfHOWTB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Aug 2019 18:19:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:60566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727119AbfHOWTB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Aug 2019 18:19:01 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA39620644;
        Thu, 15 Aug 2019 22:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565907540;
        bh=dJ9AzVhL+exmRU9v5Eu7wEWN5L9xXtZ3zUhzuoG2Rtw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jIb6MDVBenBY+pcPEyi3IQEygNzZQqEcYkr5VC/KDXU22b5Ru+bcxFPHmO5Nd3NSx
         tzkc2T6JS1E0ME72/fn9tKvBhg3nEgI+GyTnR7W2c0Q0XR+emHk8hJ+gKOfzKTKVAf
         yqAyz1JUU7vvoq+ePn1U6Fb5zfSs5nEjrGN8ALGY=
Date:   Thu, 15 Aug 2019 17:17:23 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     sathyanarayanan.kuppuswamy@linux.intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, keith.busch@intel.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v6 2/9] PCI/ACPI: Add _OSC based negotiation support for
 DPC
Message-ID: <20190815221723.GJ253360@google.com>
References: <cover.1564177080.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <6cd9661f4b7250e0d988eea4b668e2e2f6dae7a8.1564177080.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6cd9661f4b7250e0d988eea4b668e2e2f6dae7a8.1564177080.git.sathyanarayanan.kuppuswamy@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 26, 2019 at 02:43:12PM -0700, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> As per PCI firmware specification r3.2 Downstream Port Containment
> Related Enhancements ECN, sec 4.5.1, table 4-6, OS can use bit 7 of _OSC
> Control Field to negotiate control over Downstream Port Containment
> (DPC) configuration of PCIe port.
> 
> After _OSC negotiation, firmware will Set this bit to grant OS control
> over PCIe DPC configuration and Clear it if this feature was requested
> and denied, or was not requested.
> 
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Len Brown <lenb@kernel.org>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>  drivers/acpi/pci_root.c         | 6 ++++++
>  drivers/pci/pcie/portdrv_core.c | 3 ++-
>  drivers/pci/probe.c             | 1 +
>  include/linux/acpi.h            | 3 ++-
>  include/linux/pci.h             | 2 +-
>  5 files changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index 314a187ed572..73b08f40b0da 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -142,6 +142,7 @@ static struct pci_osc_bit_struct pci_osc_control_bit[] = {
>  	{ OSC_PCI_EXPRESS_AER_CONTROL, "AER" },
>  	{ OSC_PCI_EXPRESS_CAPABILITY_CONTROL, "PCIeCapability" },
>  	{ OSC_PCI_EXPRESS_LTR_CONTROL, "LTR" },
> +	{ OSC_PCI_EXPRESS_DPC_CONTROL, "DPC" },
>  };
>  
>  static void decode_osc_bits(struct acpi_pci_root *root, char *msg, u32 word,
> @@ -488,6 +489,9 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
>  			control |= OSC_PCI_EXPRESS_AER_CONTROL;
>  	}
>  
> +	if (IS_ENABLED(CONFIG_PCIE_DPC))
> +		control |= OSC_PCI_EXPRESS_DPC_CONTROL;

Sec 4.5.2.4 says:

  If the OS sets bit 7 of the Control field, it must set bit 7 of the
  Support field, indicating support for the Error Disconnect Recover
  event.

I see that you do set bit 7 (OSC_PCI_EDR_SUPPORT) in the Support field
in a later patch, but I don't think we should have this intermediate
state where we set OSC_PCI_EXPRESS_DPC_CONTROL in Control but not
OSC_PCI_EDR_SUPPORT in Support.

>  	requested = control;
>  	status = acpi_pci_osc_control_set(handle, &control,
>  					  OSC_PCI_EXPRESS_CAPABILITY_CONTROL);
> @@ -917,6 +921,8 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
>  		host_bridge->native_pme = 0;
>  	if (!(root->osc_control_set & OSC_PCI_EXPRESS_LTR_CONTROL))
>  		host_bridge->native_ltr = 0;
> +	if (!(root->osc_control_set & OSC_PCI_EXPRESS_DPC_CONTROL))
> +		host_bridge->native_dpc = 0;
>  
>  	/*
>  	 * Evaluate the "PCI Boot Configuration" _DSM Function.  If it
> diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
> index 308c3e0c4a34..58c40fe7856f 100644
> --- a/drivers/pci/pcie/portdrv_core.c
> +++ b/drivers/pci/pcie/portdrv_core.c
> @@ -252,7 +252,8 @@ static int get_port_device_capability(struct pci_dev *dev)
>  	}
>  
>  	if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC) &&
> -	    pci_aer_available() && services & PCIE_PORT_SERVICE_AER)
> +	    pci_aer_available() && services & PCIE_PORT_SERVICE_AER &&
> +	    (pcie_ports_native || host->native_dpc))
>  		services |= PCIE_PORT_SERVICE_DPC;
>  
>  	if (pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM ||
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index a3c7338fad86..cf8acdd62089 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -601,6 +601,7 @@ static void pci_init_host_bridge(struct pci_host_bridge *bridge)
>  	bridge->native_shpc_hotplug = 1;
>  	bridge->native_pme = 1;
>  	bridge->native_ltr = 1;
> +	bridge->native_dpc = 1;
>  }
>  
>  struct pci_host_bridge *pci_alloc_host_bridge(size_t priv)
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 9426b9aaed86..8959ed322e15 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -525,7 +525,8 @@ extern bool osc_pc_lpi_support_confirmed;
>  #define OSC_PCI_EXPRESS_AER_CONTROL		0x00000008
>  #define OSC_PCI_EXPRESS_CAPABILITY_CONTROL	0x00000010
>  #define OSC_PCI_EXPRESS_LTR_CONTROL		0x00000020
> -#define OSC_PCI_CONTROL_MASKS			0x0000003f
> +#define OSC_PCI_EXPRESS_DPC_CONTROL		0x00000080
> +#define OSC_PCI_CONTROL_MASKS			0x000000ff

You added 0x80, but 0x3f | 0x80 == 0xbf, not 0xff, so I expected
OSC_PCI_CONTROL_MASKS would change to 0xbf.  Why the difference?

>  #define ACPI_GSB_ACCESS_ATTRIB_QUICK		0x00000002
>  #define ACPI_GSB_ACCESS_ATTRIB_SEND_RCV         0x00000004
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 9e700d9f9f28..9145136ca728 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -510,7 +510,7 @@ struct pci_host_bridge {
>  	unsigned int	native_pme:1;		/* OS may use PCIe PME */
>  	unsigned int	native_ltr:1;		/* OS may use PCIe LTR */
>  	unsigned int	preserve_config:1;	/* Preserve FW resource setup */
> -
> +	unsigned int	native_dpc:1;		/* OS may use PCIe DPC */

Please put this next to the other "native_*" bits and preserve the
blank line.

>  	/* Resource alignment requirements */
>  	resource_size_t (*align_resource)(struct pci_dev *dev,
>  			const struct resource *res,
> -- 
> 2.21.0
> 
