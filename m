Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E79924C46F
	for <lists+linux-pci@lfdr.de>; Thu, 20 Aug 2020 19:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730529AbgHTRYk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Aug 2020 13:24:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:35260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730489AbgHTRYe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Aug 2020 13:24:34 -0400
Received: from localhost (104.sub-72-107-126.myvzw.com [72.107.126.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2ADB620724;
        Thu, 20 Aug 2020 17:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597944273;
        bh=PbAS4aeO0zd58lvXTmAoGZtS2G3ppxv2EpTV5wCK05w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=K0WpCJS/sR3eYPfF27ufor6aZXVKXbDk1rnF3qMrncCMZ8N/Zv6STMJE6QBJ6qvqz
         OxHRCsd2S1NBWIzaVAOxA3nG9pM/PmVlHJE4Z7ZtWUacZRDMKMZziummgNSPj5OGIK
         25cLFK5Z5ehktoYaQxVLyZtUB+B7d+4uQHJdXQ1s=
Date:   Thu, 20 Aug 2020 12:24:31 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-usb@vger.kernel.org, Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Rajmohan Mani <rajmohan.mani@intel.com>,
        Dana Alkattan <dana.alkattan@intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 16/19] PCI / thunderbolt: Switch to use device links
 instead of PCI quirk
Message-ID: <20200820172431.GA1550503@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200819115905.59834-17-mika.westerberg@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 19, 2020 at 02:59:02PM +0300, Mika Westerberg wrote:
> On older Apple systems there is currently a PCI quirk in place to block
> resume of tunneled PCIe ports until NHI (Thunderbolt controller) is
> resumed. This makes sure the PCIe tunnels are re-established before PCI
> core notices it.
> 
> With device links the same thing can be done without quirks. The driver
> core will make sure the supplier (NHI) is resumed before consumers (PCIe
> downstream ports).
> 
> For this reason switch the Thunderbolt driver to use device links and
> remove the PCI quirk.
> 
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/quirks.c      | 57 ---------------------------------
>  drivers/thunderbolt/nhi.c | 66 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 66 insertions(+), 57 deletions(-)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index bdf9b52567e0..a25471436523 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3673,63 +3673,6 @@ static void quirk_apple_poweroff_thunderbolt(struct pci_dev *dev)
>  DECLARE_PCI_FIXUP_SUSPEND_LATE(PCI_VENDOR_ID_INTEL,
>  			       PCI_DEVICE_ID_INTEL_CACTUS_RIDGE_4C,
>  			       quirk_apple_poweroff_thunderbolt);
> -
> -/*
> - * Apple: Wait for the Thunderbolt controller to reestablish PCI tunnels
> - *
> - * During suspend the Thunderbolt controller is reset and all PCI
> - * tunnels are lost. The NHI driver will try to reestablish all tunnels
> - * during resume. We have to manually wait for the NHI since there is
> - * no parent child relationship between the NHI and the tunneled
> - * bridges.
> - */
> -static void quirk_apple_wait_for_thunderbolt(struct pci_dev *dev)
> -{
> -	struct pci_dev *sibling = NULL;
> -	struct pci_dev *nhi = NULL;
> -
> -	if (!x86_apple_machine)
> -		return;
> -	if (pci_pcie_type(dev) != PCI_EXP_TYPE_DOWNSTREAM)
> -		return;
> -
> -	/*
> -	 * Find the NHI and confirm that we are a bridge on the Thunderbolt
> -	 * host controller and not on a Thunderbolt endpoint.
> -	 */
> -	sibling = pci_get_slot(dev->bus, 0x0);
> -	if (sibling == dev)
> -		goto out; /* we are the downstream bridge to the NHI */
> -	if (!sibling || !sibling->subordinate)
> -		goto out;
> -	nhi = pci_get_slot(sibling->subordinate, 0x0);
> -	if (!nhi)
> -		goto out;
> -	if (nhi->vendor != PCI_VENDOR_ID_INTEL
> -		    || (nhi->device != PCI_DEVICE_ID_INTEL_LIGHT_RIDGE &&
> -			nhi->device != PCI_DEVICE_ID_INTEL_CACTUS_RIDGE_4C &&
> -			nhi->device != PCI_DEVICE_ID_INTEL_FALCON_RIDGE_2C_NHI &&
> -			nhi->device != PCI_DEVICE_ID_INTEL_FALCON_RIDGE_4C_NHI)
> -		    || nhi->class != PCI_CLASS_SYSTEM_OTHER << 8)
> -		goto out;
> -	pci_info(dev, "quirk: waiting for Thunderbolt to reestablish PCI tunnels...\n");
> -	device_pm_wait_for_dev(&dev->dev, &nhi->dev);
> -out:
> -	pci_dev_put(nhi);
> -	pci_dev_put(sibling);
> -}
> -DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_INTEL,
> -			       PCI_DEVICE_ID_INTEL_LIGHT_RIDGE,
> -			       quirk_apple_wait_for_thunderbolt);
> -DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_INTEL,
> -			       PCI_DEVICE_ID_INTEL_CACTUS_RIDGE_4C,
> -			       quirk_apple_wait_for_thunderbolt);
> -DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_INTEL,
> -			       PCI_DEVICE_ID_INTEL_FALCON_RIDGE_2C_BRIDGE,
> -			       quirk_apple_wait_for_thunderbolt);
> -DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_INTEL,
> -			       PCI_DEVICE_ID_INTEL_FALCON_RIDGE_4C_BRIDGE,
> -			       quirk_apple_wait_for_thunderbolt);
>  #endif
>  
>  /*
> diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
> index 24d2b7eff59b..e499fe78756b 100644
> --- a/drivers/thunderbolt/nhi.c
> +++ b/drivers/thunderbolt/nhi.c
> @@ -17,6 +17,7 @@
>  #include <linux/module.h>
>  #include <linux/delay.h>
>  #include <linux/property.h>
> +#include <linux/platform_data/x86/apple.h>
>  
>  #include "nhi.h"
>  #include "nhi_regs.h"
> @@ -1069,6 +1070,69 @@ static bool nhi_imr_valid(struct pci_dev *pdev)
>  	return true;
>  }
>  
> +/*
> + * During suspend the Thunderbolt controller is reset and all PCIe
> + * tunnels are lost. The NHI driver will try to reestablish all tunnels
> + * during resume. This adds device links between the tunneled PCIe
> + * downstream ports and the NHI so that the device core will make sure
> + * NHI is resumed first before the rest.
> + */
> +static void tb_apple_add_links(struct tb_nhi *nhi)
> +{
> +	struct pci_dev *upstream, *pdev;
> +
> +	if (!x86_apple_machine)
> +		return;
> +
> +	switch (nhi->pdev->device) {
> +	case PCI_DEVICE_ID_INTEL_LIGHT_RIDGE:
> +	case PCI_DEVICE_ID_INTEL_CACTUS_RIDGE_4C:
> +	case PCI_DEVICE_ID_INTEL_FALCON_RIDGE_2C_NHI:
> +	case PCI_DEVICE_ID_INTEL_FALCON_RIDGE_4C_NHI:
> +		break;
> +	default:
> +		return;
> +	}
> +
> +	upstream = pci_upstream_bridge(nhi->pdev);
> +	while (upstream) {
> +		if (!pci_is_pcie(upstream))
> +			return;
> +		if (pci_pcie_type(upstream) == PCI_EXP_TYPE_UPSTREAM)
> +			break;
> +		upstream = pci_upstream_bridge(upstream);
> +	}
> +
> +	if (!upstream)
> +		return;
> +
> +	/*
> +	 * For each hotplug downstream port, create add device link
> +	 * back to NHI so that PCIe tunnels can be re-established after
> +	 * sleep.
> +	 */
> +	for_each_pci_bridge(pdev, upstream->subordinate) {
> +		const struct device_link *link;
> +
> +		if (!pci_is_pcie(pdev))
> +			continue;
> +		if (pci_pcie_type(pdev) != PCI_EXP_TYPE_DOWNSTREAM ||
> +		    !pdev->is_hotplug_bridge)
> +			continue;
> +
> +		link = device_link_add(&pdev->dev, &nhi->pdev->dev,
> +				       DL_FLAG_AUTOREMOVE_SUPPLIER |
> +				       DL_FLAG_PM_RUNTIME);
> +		if (link) {
> +			dev_dbg(&nhi->pdev->dev, "created link from %s\n",
> +				dev_name(&pdev->dev));
> +		} else {
> +			dev_warn(&nhi->pdev->dev, "device link creation from %s failed\n",
> +				 dev_name(&pdev->dev));
> +		}
> +	}
> +}
> +
>  static int nhi_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  {
>  	struct tb_nhi *nhi;
> @@ -1134,6 +1198,8 @@ static int nhi_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  			return res;
>  	}
>  
> +	tb_apple_add_links(nhi);
> +
>  	tb = icm_probe(nhi);
>  	if (!tb)
>  		tb = tb_probe(nhi);
> -- 
> 2.28.0
> 
