Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2492477D2
	for <lists+linux-pci@lfdr.de>; Mon, 17 Aug 2020 22:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729159AbgHQUBu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Aug 2020 16:01:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:56090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729118AbgHQUBu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 17 Aug 2020 16:01:50 -0400
Received: from localhost (104.sub-72-107-126.myvzw.com [72.107.126.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFBB4204EC;
        Mon, 17 Aug 2020 20:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597694509;
        bh=v/fyguDJgngMm4D7i8RenkD4TNEW+1PlLNlPWyhPCMA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=HgNGlfQuhDucmukwOltDYSq8Cr51/e0tYsvwbQaCFdB4G0jwq8kyxoudqo7kV+erE
         A/ROK83tkaAUJUlxhOby0oA0wkIpLg4i0JGJom9ho0BSX93an/0/JxJYL/ces7lhXx
         XNNOqkKDDT98Jj7RnoFIMnFOzMvpI4Bm3laiUvZQ=
Date:   Mon, 17 Aug 2020 15:01:47 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vaibhav Gupta <vaibhavgupta40@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] PCI: Drop pcibios_pm_ops from the PCI subsystem
Message-ID: <20200817200147.GA1438651@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200730194416.1029509-1-vaibhavgupta40@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 31, 2020 at 01:14:16AM +0530, Vaibhav Gupta wrote:
> The "struct dev_pm_ops pcibios_pm_ops", declared in include/linux/pci.h and
> defined in drivers/pci/pci-driver.c, provided arch-specific hooks when a
> PCI device was doing a hibernate transisiton.
> 
> Although it lost its last usage after
> 394216275c7d ("s390: remove broken hibernate / power management support")
> patch.
> 
> After that, instances of it are found only in drivers/pci/pci-driver.c and
> include/linux/pci.h, which are now unnecessary. Thus it is safe and
> reasonable to remove even that.
> 
> Reported-by: Bjorn Helgaas <helgaas@kernel.org>
> Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>

Applied to pci/pm for v5.10, thanks!

> ---
>  drivers/pci/pci-driver.c | 24 ------------------------
>  include/linux/pci.h      |  4 ----
>  2 files changed, 28 deletions(-)
> 
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index da6510af1221..0bebbdf85be8 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -966,12 +966,6 @@ static int pci_pm_resume(struct device *dev)
>  
>  #ifdef CONFIG_HIBERNATE_CALLBACKS
>  
> -/*
> - * pcibios_pm_ops - provide arch-specific hooks when a PCI device is doing
> - * a hibernate transition
> - */
> -struct dev_pm_ops __weak pcibios_pm_ops;
> -
>  static int pci_pm_freeze(struct device *dev)
>  {
>  	struct pci_dev *pci_dev = to_pci_dev(dev);
> @@ -1030,9 +1024,6 @@ static int pci_pm_freeze_noirq(struct device *dev)
>  
>  	pci_pm_set_unknown_state(pci_dev);
>  
> -	if (pcibios_pm_ops.freeze_noirq)
> -		return pcibios_pm_ops.freeze_noirq(dev);
> -
>  	return 0;
>  }
>  
> @@ -1042,12 +1033,6 @@ static int pci_pm_thaw_noirq(struct device *dev)
>  	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
>  	int error;
>  
> -	if (pcibios_pm_ops.thaw_noirq) {
> -		error = pcibios_pm_ops.thaw_noirq(dev);
> -		if (error)
> -			return error;
> -	}
> -
>  	/*
>  	 * The pm->thaw_noirq() callback assumes the device has been
>  	 * returned to D0 and its config state has been restored.
> @@ -1171,9 +1156,6 @@ static int pci_pm_poweroff_noirq(struct device *dev)
>  
>  	pci_fixup_device(pci_fixup_suspend_late, pci_dev);
>  
> -	if (pcibios_pm_ops.poweroff_noirq)
> -		return pcibios_pm_ops.poweroff_noirq(dev);
> -
>  	return 0;
>  }
>  
> @@ -1183,12 +1165,6 @@ static int pci_pm_restore_noirq(struct device *dev)
>  	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
>  	int error;
>  
> -	if (pcibios_pm_ops.restore_noirq) {
> -		error = pcibios_pm_ops.restore_noirq(dev);
> -		if (error)
> -			return error;
> -	}
> -
>  	pci_pm_default_resume_early(pci_dev);
>  	pci_fixup_device(pci_fixup_resume_early, pci_dev);
>  
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 34c1c4f45288..c4900975041c 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -2034,10 +2034,6 @@ int pcibios_alloc_irq(struct pci_dev *dev);
>  void pcibios_free_irq(struct pci_dev *dev);
>  resource_size_t pcibios_default_alignment(void);
>  
> -#ifdef CONFIG_HIBERNATE_CALLBACKS
> -extern struct dev_pm_ops pcibios_pm_ops;
> -#endif
> -
>  #if defined(CONFIG_PCI_MMCONFIG) || defined(CONFIG_ACPI_MCFG)
>  void __init pci_mmcfg_early_init(void);
>  void __init pci_mmcfg_late_init(void);
> -- 
> 2.27.0
> 
