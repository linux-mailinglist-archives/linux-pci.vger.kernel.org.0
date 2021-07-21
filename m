Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54E8B3D194C
	for <lists+linux-pci@lfdr.de>; Wed, 21 Jul 2021 23:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbhGUU6F (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Jul 2021 16:58:05 -0400
Received: from mga17.intel.com ([192.55.52.151]:28297 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229597AbhGUU6F (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 21 Jul 2021 16:58:05 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10052"; a="191796723"
X-IronPort-AV: E=Sophos;i="5.84,258,1620716400"; 
   d="scan'208";a="191796723"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2021 14:38:41 -0700
X-IronPort-AV: E=Sophos;i="5.84,258,1620716400"; 
   d="scan'208";a="501451075"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.36])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2021 14:38:41 -0700
Date:   Wed, 21 Jul 2021 14:38:13 -0700
From:   "Raj, Ashok" <ashok.raj@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Kevin Tian <kevin.tian@intel.com>,
        Marc Zyngier <maz@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, Ashok Raj <ashok.raj@intel.com>
Subject: Re: [patch 1/8] PCI/MSI: Enable and mask MSIX early
Message-ID: <20210721213813.GB676232@otc-nc-03>
References: <20210721191126.274946280@linutronix.de>
 <20210721192650.106154171@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210721192650.106154171@linutronix.de>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 21, 2021 at 09:11:27PM +0200, Thomas Gleixner wrote:
> The ordering of MSI-X enable in hardware is disfunctional:
> 
>  1) MSI-X is disabled in the control register
>  2) Various setup functions
>  3) pci_msi_setup_msi_irqs() is invoked which ends up accessing
>     the MSI-X table entries
>  4) MSI-X is enabled and masked in the control register with the
>     comment that enabling is required for some hardware to access
>     the MSI-X table
> 
> #4 obviously contradicts #3. The history of this is an issue with the NIU
> hardware. When #4 was introduced the table access actually happened in
> msix_program_entries() which was invoked after enabling and masking MSI-X.
> 
> This was changed in commit d71d6432e105 ("PCI/MSI: Kill redundant call of
> irq_set_msi_desc() for MSI-X interrupts") which removed the table write
> from msix_program_entries().
> 
> Interestingly enough nobody noticed and either NIU still works or it did
> not get any testing with a kernel 3.19 or later.
> 
> Nevertheless this is inconsistent and there is no reason why MSI-X can't be
> enabled and masked in the control register early on, i.e. move #4 above to

Does the above comment also apply to legacy MSI when it support per-vector
masking capability? Probably not interesting since without IR, we only give
1 vector to MSI. 

Reviewed-by: Ashok Raj <ashok.raj@intel.com>

> #1. This preserves the NIU workaround and has no side effects on other
> hardware.
> 
> Fixes: d71d6432e105 ("PCI/MSI: Kill redundant call of irq_set_msi_desc() for MSI-X interrupts")
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org
> ---
>  drivers/pci/msi.c |   28 +++++++++++++++-------------
>  1 file changed, 15 insertions(+), 13 deletions(-)
> 
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -772,18 +772,25 @@ static int msix_capability_init(struct p
>  	u16 control;
>  	void __iomem *base;
>  
> -	/* Ensure MSI-X is disabled while it is set up */
> -	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_ENABLE, 0);
> +	/*
> +	 * Some devices require MSI-X to be enabled before the MSI-X
> +	 * registers can be accessed.  Mask all the vectors to prevent
> +	 * interrupts coming in before they're fully set up.
> +	 */
> +	pci_msix_clear_and_set_ctrl(dev, 0, PCI_MSIX_FLAGS_MASKALL |
> +				    PCI_MSIX_FLAGS_ENABLE);
>  
>  	pci_read_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS, &control);
>  	/* Request & Map MSI-X table region */
>  	base = msix_map_region(dev, msix_table_size(control));
> -	if (!base)
> -		return -ENOMEM;
> +	if (!base) {
> +		ret = -ENOMEM;
> +		goto out_disable;
> +	}
>  
>  	ret = msix_setup_entries(dev, base, entries, nvec, affd);
>  	if (ret)
> -		return ret;
> +		goto out_disable;
>  
>  	ret = pci_msi_setup_msi_irqs(dev, nvec, PCI_CAP_ID_MSIX);
>  	if (ret)
> @@ -794,14 +801,6 @@ static int msix_capability_init(struct p
>  	if (ret)
>  		goto out_free;
>  
> -	/*
> -	 * Some devices require MSI-X to be enabled before we can touch the
> -	 * MSI-X registers.  We need to mask all the vectors to prevent
> -	 * interrupts coming in before they're fully set up.
> -	 */
> -	pci_msix_clear_and_set_ctrl(dev, 0,
> -				PCI_MSIX_FLAGS_MASKALL | PCI_MSIX_FLAGS_ENABLE);
> -
>  	msix_program_entries(dev, entries);
>  
>  	ret = populate_msi_sysfs(dev);
> @@ -836,6 +835,9 @@ static int msix_capability_init(struct p
>  out_free:
>  	free_msi_irqs(dev);
>  
> +out_disable:
> +	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_ENABLE, 0);
> +
>  	return ret;
>  }
>  
> 
