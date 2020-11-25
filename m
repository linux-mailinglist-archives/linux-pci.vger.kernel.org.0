Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB37F2C4956
	for <lists+linux-pci@lfdr.de>; Wed, 25 Nov 2020 21:52:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730384AbgKYUub (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Nov 2020 15:50:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:39650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729826AbgKYUua (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 25 Nov 2020 15:50:30 -0500
Received: from localhost (129.sub-72-107-112.myvzw.com [72.107.112.129])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BABE206F9;
        Wed, 25 Nov 2020 20:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606337430;
        bh=5l1FeLkZJdwH1QPiZKXdyCL7G2w+EaBDfxGPhOyo+0s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=HoGgaYgz1Ikf+/S41EjmERZvhGw+gImaPliYdSMlGcvzIfFSaePa8og9hhicv58pT
         6Ks33/EwQ27IkqSYLNiBGBldEzbRaEghhGr2grzeDjCHjPobOZI2P9pTu1RPjvkG53
         JlKL7mglLxLGK74Nou3cwFbvHi0u0ZEsk8al739Y=
Date:   Wed, 25 Nov 2020 14:50:28 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ashok.raj@intel.com,
        knsathya@kernel.org
Subject: Re: [PATCH v11 3/5] ACPI/PCI: Ignore _OSC DPC negotiation result if
 pcie_ports_dpc_native is set.
Message-ID: <20201125205028.GA677519@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ec11f2b7470070768886a138f2a755620725a06.1603766889.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 26, 2020 at 07:57:06PM -0700, Kuppuswamy Sathyanarayanan wrote:
> pcie_ports_dpc_native is set only if user requests native handling
> of PCIe DPC capability via pcie_port_setup command line option.
> User input takes precedence over _OSC based control negotiation
> result. So consider the _OSC negotiated result for DPC ownership
> only if pcie_ports_dpc_native is unset.
> 
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>  drivers/acpi/pci_root.c         | 8 ++++++--
>  drivers/pci/pcie/dpc.c          | 3 ++-
>  drivers/pci/pcie/portdrv.h      | 2 --
>  drivers/pci/pcie/portdrv_core.c | 2 +-
>  include/linux/pci.h             | 2 ++
>  5 files changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index a9e6b782622d..2e2bc80c42fe 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -933,8 +933,12 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
>  			  host_bridge->native_pme);
>  		OSC_OWNER(ctrl, OSC_PCI_EXPRESS_LTR_CONTROL,
>  			  host_bridge->native_ltr);
> -		OSC_OWNER(ctrl, OSC_PCI_EXPRESS_DPC_CONTROL,
> -			  host_bridge->native_dpc);
> +		if (pcie_ports_dpc_native)
> +			dev_warn(&bus->dev, "OS forcibly taking over DPC\n");
> +		else
> +			OSC_OWNER(ctrl, OSC_PCI_EXPRESS_DPC_CONTROL,
> +				  host_bridge->native_dpc);
> +
>  	}
>  
>  	if (!(root->osc_control_set & OSC_PCI_SHPC_NATIVE_HP_CONTROL))
> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index e05aba86a317..21f77420632b 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -283,11 +283,12 @@ void pci_dpc_init(struct pci_dev *pdev)
>  static int dpc_probe(struct pcie_device *dev)
>  {
>  	struct pci_dev *pdev = dev->port;
> +	struct pci_host_bridge *host = pci_find_host_bridge(pdev->bus);
>  	struct device *device = &dev->device;
>  	int status;
>  	u16 ctl, cap;
>  
> -	if (!pcie_aer_is_native(pdev) && !pcie_ports_dpc_native)
> +	if (!pcie_aer_is_native(pdev) && !host->native_dpc)
>  		return -ENOTSUPP;

Wow, I don't even know what those negations mean and I don't want to
take ten minutes to figure it out.  Not your fault, obviously; it was
that way before.

"If AER is not native and DPC is not native, return -ENOTSUPP"?
In other words, "if not (AER is native OR DPC is native), return
-ENOTSUPP"?  Or "if (AER is native OR DPC is native), keep going"?

I guess this is tied up with 35a0b2378c19 ("PCI/DPC: Add
"pcie_ports=dpc-native" to allow DPC without AER control")

But we still ought to be able to consolidate some of this testing in
acpi_pci_root_create() so we only have to look at host->native_dpc
here (and maybe dev->aer_cap).

>  	status = devm_request_threaded_irq(device, dev->irq, dpc_irq,
> diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
> index af7cf237432a..0ac20feef24e 100644
> --- a/drivers/pci/pcie/portdrv.h
> +++ b/drivers/pci/pcie/portdrv.h
> @@ -25,8 +25,6 @@
>  
>  #define PCIE_PORT_DEVICE_MAXSERVICES   5
>  
> -extern bool pcie_ports_dpc_native;
> -
>  #ifdef CONFIG_PCIEAER
>  int pcie_aer_init(void);
>  int pcie_aer_is_native(struct pci_dev *dev);
> diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
> index ccd5e0ce5605..2c0278f0fdcc 100644
> --- a/drivers/pci/pcie/portdrv_core.c
> +++ b/drivers/pci/pcie/portdrv_core.c
> @@ -253,7 +253,7 @@ static int get_port_device_capability(struct pci_dev *dev)
>  	 */
>  	if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC) &&
>  	    pci_aer_available() &&
> -	    (pcie_ports_dpc_native || (services & PCIE_PORT_SERVICE_AER)))
> +	    (host->native_dpc || (services & PCIE_PORT_SERVICE_AER)))
>  		services |= PCIE_PORT_SERVICE_DPC;
>  
>  	if (pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM ||
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 22207a79762c..388121ec88b5 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1559,9 +1559,11 @@ static inline int pci_irqd_intx_xlate(struct irq_domain *d,
>  #ifdef CONFIG_PCIEPORTBUS
>  extern bool pcie_ports_disabled;
>  extern bool pcie_ports_native;
> +extern bool pcie_ports_dpc_native;
>  #else
>  #define pcie_ports_disabled	true
>  #define pcie_ports_native	false
> +#define pcie_ports_dpc_native	false
>  #endif
>  
>  #define PCIE_LINK_STATE_L0S		BIT(0)
> -- 
> 2.17.1
> 
