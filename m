Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC1D1E8BD0
	for <lists+linux-pci@lfdr.de>; Sat, 30 May 2020 01:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgE2XM5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 May 2020 19:12:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:44224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726898AbgE2XM5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 29 May 2020 19:12:57 -0400
Received: from localhost (mobile-166-175-190-200.mycingular.net [166.175.190.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E981C20776;
        Fri, 29 May 2020 23:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590793976;
        bh=U/+u5mALRzqTCsIqgH9bz+AeT3oDozuVHgyv5NbkKF0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=pvyT0IwWRnsdsCYcWAbdmmQLoHZ7ogmIIXfA3eudAoLqX5qe9iKhmZaZGGU/Yyz7N
         vCveZroTKCSPxQ9W8a/vChFSasskGO3ht4NYrCKYq9vl/zd80SR8fDgmWcllEiOUPG
         dTtpDIkg7F+lP+g7rHlCsBmYEPAOueFEpdIU46Jk=
Date:   Fri, 29 May 2020 18:12:54 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     sathyanarayanan.kuppuswamy@linux.intel.com
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ashok.raj@intel.com
Subject: Re: [PATCH v4 3/5] ACPI/PCI: Ignore _OSC negotiation result if
 pcie_ports_native is set.
Message-ID: <20200529231254.GA480133@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <969d4f083f445532bd1cdd98e3ce110574a461b0.1590534843.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 26, 2020 at 04:18:27PM -0700, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> pcie_ports_native is set only if user requests native handling
> of PCIe capabilities via pcie_port_setup command line option.
> User input takes precedence over _OSC based control negotiation
> result. So consider the _OSC negotiated result only if
> pcie_ports_native is unset.
> 
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>  drivers/acpi/pci_root.c | 26 ++++++++++++++------------
>  1 file changed, 14 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index 9e235c1a75ff..e0039ad3480a 100644
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

I like this, but what I had in mind was to *remove* the tests of
pcie_ports_native elsewhere at the same time.

For example, 

  @@ -255,7 +255,7 @@ static bool pme_is_native(struct pcie_device *dev)
	  const struct pci_host_bridge *host;

	  host = pci_find_host_bridge(dev->port->bus);
  -       return pcie_ports_native || host->native_pme;
  +       return host->native_pme;
   }

and

  @@ -221,7 +221,7 @@ int pcie_aer_is_native(struct pci_dev *dev)
	  if (!dev->aer_cap)
		  return 0;

  -       return pcie_ports_native || host->native_aer;
  +       return host->native_aer;
   }

So I deferred these two _OSC-related things for now.  We can work on
this more in the next cycle.

>  	/*
>  	 * Evaluate the "PCI Boot Configuration" _DSM Function.  If it
> -- 
> 2.17.1
> 
