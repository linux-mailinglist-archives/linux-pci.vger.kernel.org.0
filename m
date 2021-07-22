Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A48BA3D2F4A
	for <lists+linux-pci@lfdr.de>; Thu, 22 Jul 2021 23:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231816AbhGVVC5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Jul 2021 17:02:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:45714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231799AbhGVVC4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Jul 2021 17:02:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0E5FA60C41;
        Thu, 22 Jul 2021 21:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626990211;
        bh=cYkKEpi8pg6jLA7Craw38Nnh9JOvGJhzKW+632kIk1s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=LgU3jFUDvnSZS7VI0gh1o7IwSm3JrK6lMo7ZgbE7cQzoUOTtxlbir2E5twOUEUxql
         /HAq1/O9Jsso5I/GSXaiktrfwmPxxM3tyYX4dsxWuqDuSa3RiSqtI9Le5PDkR4Puql
         dHk1OWcEP4+gguVvYLWnrrET8YOsWX/yk+nIFYdsYYB+1TlmvLqXIDFTv+IqEXtGTU
         dNPYYvTs5oP7GSQ7QoLrV19EgwdOCL4sTCSW8ZhSTVNzATWKdUqV+j5WPeIcctsmuD
         2/kZPU6NajQfwvU6KyyJ/uEh72CuWbjp0kL3n34atxu8irWYdc5/E3O/v92Y8xoXZt
         YSyLIvwFUlJlg==
Date:   Thu, 22 Jul 2021 16:43:29 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Kevin Tian <kevin.tian@intel.com>,
        Marc Zyngier <maz@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org
Subject: Re: [patch 1/8] PCI/MSI: Enable and mask MSIX early
Message-ID: <20210722214329.GA349464@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210721192650.106154171@linutronix.de>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

s/MSIX/MSI-X/ in subject

On Wed, Jul 21, 2021 at 09:11:27PM +0200, Thomas Gleixner wrote:
> The ordering of MSI-X enable in hardware is disfunctional:

s/disfunctional/dysfunctional/, isn't English wonderful ;)

>  1) MSI-X is disabled in the control register
>  2) Various setup functions
>  3) pci_msi_setup_msi_irqs() is invoked which ends up accessing
>     the MSI-X table entries
>  4) MSI-X is enabled and masked in the control register with the
>     comment that enabling is required for some hardware to access
>     the MSI-X table
> 
> #4 obviously contradicts #3. The history of this is an issue with the NIU

Annoyingly, if you "git rebase" and reword this commit log, it drops
this line and the one a few lines below because they start with "#".
Should be obvious, but took me a few iterations to see what was
happening.

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
