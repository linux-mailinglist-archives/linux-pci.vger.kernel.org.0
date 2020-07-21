Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3F7C228C35
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jul 2020 00:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbgGUWuJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Jul 2020 18:50:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:40726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726148AbgGUWuJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 21 Jul 2020 18:50:09 -0400
Received: from localhost (mobile-166-175-191-139.mycingular.net [166.175.191.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8436E2073A;
        Tue, 21 Jul 2020 22:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595371808;
        bh=yWjyHl/+Jkepl7ur2pQs9fqUJrabWlVAD+P0xfkZ8Kw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=frZ/aCsGdwx2O0J6NiYCjmBnlCneYGd7++gMRCAzkGm0qIJiLxl8nrxh6lIuzD5WQ
         pas5ZRYD0TGP+7oJo/QcrGE8Vl82oas9D/71bE4w7dEM8wcfwsQoBtcJlyzCfKqYNJ
         HQdzsRQQaTfH9aTS6JsFq2dxZ/7UsgBFk+Vh2MTM=
Date:   Tue, 21 Jul 2020 17:50:07 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jon Derrick <jonathan.derrick@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] irqdomain/treewide: Free firmware node after domain
 removal
Message-ID: <20200721225007.GA1167473@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595363169-7157-1-git-send-email-jonathan.derrick@intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 21, 2020 at 02:26:09PM -0600, Jon Derrick wrote:
> Change 711419e504eb ("irqdomain: Add the missing assignment of
> domain->fwnode for named fwnode") unintentionally caused a dangling
> pointer page fault issue on firmware nodes that were freed after IRQ
> domain allocation. Change e3beca48a45b fixed that dangling pointer issue
> by only freeing the firmware node after an IRQ domain allocation
> failure. That fix no longer frees the firmware node immediately, but
> leaves the firmware node allocated after the domain is removed.
> 
> We need to keep the firmware node through irq_domain_remove, but should
> free it afterwards. This patch saves the handle and adds the freeing of
> firmware node after domain removal where appropriate.
> 
> Fixes: e3beca48a45b ("irqdomain/treewide: Keep firmware node unconditionally allocated")
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
> Cc: stable@vger.kernel.org

Acked-by: Bjorn Helgaas <bhelgaas@google.com>	# drivers/pci

> ---
>  arch/mips/pci/pci-xtalk-bridge.c    | 3 +++
>  arch/x86/kernel/apic/io_apic.c      | 5 +++++
>  drivers/iommu/intel/irq_remapping.c | 8 ++++++++
>  drivers/mfd/ioc3.c                  | 6 ++++++
>  drivers/pci/controller/vmd.c        | 3 +++
>  5 files changed, 25 insertions(+)
> 
> diff --git a/arch/mips/pci/pci-xtalk-bridge.c b/arch/mips/pci/pci-xtalk-bridge.c
> index 5958217..9b3cc77 100644
> --- a/arch/mips/pci/pci-xtalk-bridge.c
> +++ b/arch/mips/pci/pci-xtalk-bridge.c
> @@ -728,6 +728,7 @@ static int bridge_probe(struct platform_device *pdev)
>  	pci_free_resource_list(&host->windows);
>  err_remove_domain:
>  	irq_domain_remove(domain);
> +	irq_domain_free_fwnode(fn);
>  	return err;
>  }
>  
> @@ -735,8 +736,10 @@ static int bridge_remove(struct platform_device *pdev)
>  {
>  	struct pci_bus *bus = platform_get_drvdata(pdev);
>  	struct bridge_controller *bc = BRIDGE_CONTROLLER(bus);
> +	struct fwnode_handle *fn = bc->domain->fwnode;
>  
>  	irq_domain_remove(bc->domain);
> +	irq_domain_free_fwnode(fn);
>  	pci_lock_rescan_remove();
>  	pci_stop_root_bus(bus);
>  	pci_remove_root_bus(bus);
> diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
> index 81ffcfb..21325a4a 100644
> --- a/arch/x86/kernel/apic/io_apic.c
> +++ b/arch/x86/kernel/apic/io_apic.c
> @@ -2335,8 +2335,13 @@ static int mp_irqdomain_create(int ioapic)
>  
>  static void ioapic_destroy_irqdomain(int idx)
>  {
> +	struct ioapic_domain_cfg *cfg = &ioapics[idx].irqdomain_cfg;
> +	struct fwnode_handle *fn = ioapics[idx].irqdomain->fwnode;
> +
>  	if (ioapics[idx].irqdomain) {
>  		irq_domain_remove(ioapics[idx].irqdomain);
> +		if (!cfg->dev)
> +			irq_domain_free_fwnode(fn);
>  		ioapics[idx].irqdomain = NULL;
>  	}
>  }
> diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
> index 9564d23..aa096b3 100644
> --- a/drivers/iommu/intel/irq_remapping.c
> +++ b/drivers/iommu/intel/irq_remapping.c
> @@ -628,13 +628,21 @@ static int intel_setup_irq_remapping(struct intel_iommu *iommu)
>  
>  static void intel_teardown_irq_remapping(struct intel_iommu *iommu)
>  {
> +	struct fwnode_handle *fn;
> +
>  	if (iommu && iommu->ir_table) {
>  		if (iommu->ir_msi_domain) {
> +			fn = iommu->ir_msi_domain->fwnode;
> +
>  			irq_domain_remove(iommu->ir_msi_domain);
> +			irq_domain_free_fwnode(fn);
>  			iommu->ir_msi_domain = NULL;
>  		}
>  		if (iommu->ir_domain) {
> +			fn = iommu->ir_domain->fwnode;
> +
>  			irq_domain_remove(iommu->ir_domain);
> +			irq_domain_free_fwnode(fn);
>  			iommu->ir_domain = NULL;
>  		}
>  		free_pages((unsigned long)iommu->ir_table->base,
> diff --git a/drivers/mfd/ioc3.c b/drivers/mfd/ioc3.c
> index 74cee7c..d939ccc 100644
> --- a/drivers/mfd/ioc3.c
> +++ b/drivers/mfd/ioc3.c
> @@ -616,7 +616,10 @@ static int ioc3_mfd_probe(struct pci_dev *pdev,
>  		/* Remove all already added MFD devices */
>  		mfd_remove_devices(&ipd->pdev->dev);
>  		if (ipd->domain) {
> +			struct fwnode_handle *fn = ipd->domain->fwnode;
> +
>  			irq_domain_remove(ipd->domain);
> +			irq_domain_free_fwnode(fn);
>  			free_irq(ipd->domain_irq, (void *)ipd);
>  		}
>  		pci_iounmap(pdev, regs);
> @@ -643,7 +646,10 @@ static void ioc3_mfd_remove(struct pci_dev *pdev)
>  	/* Release resources */
>  	mfd_remove_devices(&ipd->pdev->dev);
>  	if (ipd->domain) {
> +		struct fwnode_handle *fn = ipd->domain->fwnode;
> +
>  		irq_domain_remove(ipd->domain);
> +		irq_domain_free_fwnode(fn);
>  		free_irq(ipd->domain_irq, (void *)ipd);
>  	}
>  	pci_iounmap(pdev, ipd->regs);
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index f078114..91eb769 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -560,6 +560,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>  	if (!vmd->bus) {
>  		pci_free_resource_list(&resources);
>  		irq_domain_remove(vmd->irq_domain);
> +		irq_domain_free_fwnode(fn);
>  		return -ENODEV;
>  	}
>  
> @@ -673,6 +674,7 @@ static void vmd_cleanup_srcu(struct vmd_dev *vmd)
>  static void vmd_remove(struct pci_dev *dev)
>  {
>  	struct vmd_dev *vmd = pci_get_drvdata(dev);
> +	struct fwnode_handle *fn = vmd->irq_domain->fwnode;
>  
>  	sysfs_remove_link(&vmd->dev->dev.kobj, "domain");
>  	pci_stop_root_bus(vmd->bus);
> @@ -680,6 +682,7 @@ static void vmd_remove(struct pci_dev *dev)
>  	vmd_cleanup_srcu(vmd);
>  	vmd_detach_resources(vmd);
>  	irq_domain_remove(vmd->irq_domain);
> +	irq_domain_free_fwnode(fn);
>  }
>  
>  #ifdef CONFIG_PM_SLEEP
> -- 
> 1.8.3.1
> 
