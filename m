Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60ED0215B13
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jul 2020 17:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729348AbgGFPoO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Jul 2020 11:44:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:59434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729486AbgGFPoO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 6 Jul 2020 11:44:14 -0400
Received: from localhost (mobile-166-175-191-139.mycingular.net [166.175.191.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACB442070C;
        Mon,  6 Jul 2020 15:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594050253;
        bh=Vzlq5MNw5vTJeXjkqPm/eFmXRsAsxL6ORXUA4t+6jWI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=qOF+QBX73JdTQfA1j7SpVYpuIlGC7GPIy7EGd6/xc9e7vo8xs1izLGvdjhkswVH4z
         Nb+V7r9FzSJ3J/7hsJxce/jMRXzsKDWFrBtI+bQicbxBGIe3r1dha5bQtjdYaR8v7T
         EfDJCEp4oI4zCxDXcJisrMSiI4JEPvVzqpZI7gAU=
Date:   Mon, 6 Jul 2020 10:44:10 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jon Derrick <jonathan.derrick@intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org,
        Sushma Kalakota <sushmax.kalakota@intel.com>
Subject: Re: [PATCH] PCI: vmd: Keep fwnode allocated through VMD irqdomain
 life
Message-ID: <20200706154410.GA117493@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wo3grcsw.fsf@nanos.tec.linutronix.de>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 06, 2020 at 03:30:23PM +0200, Thomas Gleixner wrote:
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
> > On Mon, Jul 06, 2020 at 12:47:59PM +0200, Thomas Gleixner wrote:
> >> Bjorn Helgaas <helgaas@kernel.org> writes:
> >> > On Tue, Jun 30, 2020 at 12:39:08PM +0300, Andy Shevchenko wrote:
> >> >> The problem here is in the original patch which relies on the
> >> >> knowledge that fwnode is (was) not used anyhow specifically for ACPI
> >> >> case. That said, it makes fwnode a dangling pointer which I
> >> >> personally consider as a mine left for others. That's why the Fixes
> >> >> refers to the initial commit. The latter just has been blasted on
> >> >> that mine.
> >> 
> >> No. The original patch did not create a dangling pointer because fwnode
> >> was not stored for IRQCHIP_FWNODE_NAMED and IRQCHIP_FWNODE_NAMED_ID type
> >> nodes.
> >> 
> >> The fail was introduced in:
> >> 
> >> 711419e504eb ("irqdomain: Add the missing assignment of domain->fwnode for named fwnode")
> >
> > Ah, sorry for missing that and thank you for pointing out.
> 
> So something like the below wants to be applied and marked for stable

Great, thanks for all your help, Thomas!

This looks more like a general IRQ domain thing than a PCI thing, so
maybe it will make the most sense if Marc takes care of it.

> ---
> diff --git a/arch/mips/pci/pci-xtalk-bridge.c b/arch/mips/pci/pci-xtalk-bridge.c
> index 3b2552fb7735..5958217861b8 100644
> --- a/arch/mips/pci/pci-xtalk-bridge.c
> +++ b/arch/mips/pci/pci-xtalk-bridge.c
> @@ -627,9 +627,10 @@ static int bridge_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  	domain = irq_domain_create_hierarchy(parent, 0, 8, fn,
>  					     &bridge_domain_ops, NULL);
> -	irq_domain_free_fwnode(fn);
> -	if (!domain)
> +	if (!domain) {
> +		irq_domain_free_fwnode(fn);
>  		return -ENOMEM;
> +	}
>  
>  	pci_set_flags(PCI_PROBE_ONLY);
>  
> diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
> index ce61e3e7d399..81ffcfbfaef2 100644
> --- a/arch/x86/kernel/apic/io_apic.c
> +++ b/arch/x86/kernel/apic/io_apic.c
> @@ -2316,12 +2316,12 @@ static int mp_irqdomain_create(int ioapic)
>  	ip->irqdomain = irq_domain_create_linear(fn, hwirqs, cfg->ops,
>  						 (void *)(long)ioapic);
>  
> -	/* Release fw handle if it was allocated above */
> -	if (!cfg->dev)
> -		irq_domain_free_fwnode(fn);
> -
> -	if (!ip->irqdomain)
> +	if (!ip->irqdomain) {
> +		/* Release fw handle if it was allocated above */
> +		if (!cfg->dev)
> +			irq_domain_free_fwnode(fn);
>  		return -ENOMEM;
> +	}
>  
>  	ip->irqdomain->parent = parent;
>  
> diff --git a/arch/x86/kernel/apic/msi.c b/arch/x86/kernel/apic/msi.c
> index 5cbaca58af95..c2b2911feeef 100644
> --- a/arch/x86/kernel/apic/msi.c
> +++ b/arch/x86/kernel/apic/msi.c
> @@ -263,12 +263,13 @@ void __init arch_init_msi_domain(struct irq_domain *parent)
>  		msi_default_domain =
>  			pci_msi_create_irq_domain(fn, &pci_msi_domain_info,
>  						  parent);
> -		irq_domain_free_fwnode(fn);
>  	}
> -	if (!msi_default_domain)
> +	if (!msi_default_domain) {
> +		irq_domain_free_fwnode(fn);
>  		pr_warn("failed to initialize irqdomain for MSI/MSI-x.\n");
> -	else
> +	} else {
>  		msi_default_domain->flags |= IRQ_DOMAIN_MSI_NOMASK_QUIRK;
> +	}
>  }
>  
>  #ifdef CONFIG_IRQ_REMAP
> @@ -301,7 +302,8 @@ struct irq_domain *arch_create_remap_msi_irq_domain(struct irq_domain *parent,
>  	if (!fn)
>  		return NULL;
>  	d = pci_msi_create_irq_domain(fn, &pci_msi_ir_domain_info, parent);
> -	irq_domain_free_fwnode(fn);
> +	if (!d)
> +		irq_domain_free_fwnode(fn);
>  	return d;
>  }
>  #endif
> @@ -364,7 +366,8 @@ static struct irq_domain *dmar_get_irq_domain(void)
>  	if (fn) {
>  		dmar_domain = msi_create_irq_domain(fn, &dmar_msi_domain_info,
>  						    x86_vector_domain);
> -		irq_domain_free_fwnode(fn);
> +		if (!dmar_domain)
> +			irq_domain_free_fwnode(fn);
>  	}
>  out:
>  	mutex_unlock(&dmar_lock);
> @@ -489,7 +492,10 @@ struct irq_domain *hpet_create_irq_domain(int hpet_id)
>  	}
>  
>  	d = msi_create_irq_domain(fn, domain_info, parent);
> -	irq_domain_free_fwnode(fn);
> +	if (!d) {
> +		irq_domain_free_fwnode(fn);
> +		kfree(domain_info);
> +	}
>  	return d;
>  }
>  
> diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
> index c48be6e1f676..cc8b16f89dd4 100644
> --- a/arch/x86/kernel/apic/vector.c
> +++ b/arch/x86/kernel/apic/vector.c
> @@ -709,7 +709,6 @@ int __init arch_early_irq_init(void)
>  	x86_vector_domain = irq_domain_create_tree(fn, &x86_vector_domain_ops,
>  						   NULL);
>  	BUG_ON(x86_vector_domain == NULL);
> -	irq_domain_free_fwnode(fn);
>  	irq_set_default_host(x86_vector_domain);
>  
>  	arch_init_msi_domain(x86_vector_domain);
> diff --git a/arch/x86/platform/uv/uv_irq.c b/arch/x86/platform/uv/uv_irq.c
> index fc13cbbb2dce..abb6075397f0 100644
> --- a/arch/x86/platform/uv/uv_irq.c
> +++ b/arch/x86/platform/uv/uv_irq.c
> @@ -167,9 +167,10 @@ static struct irq_domain *uv_get_irq_domain(void)
>  		goto out;
>  
>  	uv_domain = irq_domain_create_tree(fn, &uv_domain_ops, NULL);
> -	irq_domain_free_fwnode(fn);
>  	if (uv_domain)
>  		uv_domain->parent = x86_vector_domain;
> +	else
> +		irq_domain_free_fwnode(fn);
>  out:
>  	mutex_unlock(&uv_lock);
>  
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 74cca1757172..2f22326ee4df 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -3985,9 +3985,10 @@ int amd_iommu_create_irq_domain(struct amd_iommu *iommu)
>  	if (!fn)
>  		return -ENOMEM;
>  	iommu->ir_domain = irq_domain_create_tree(fn, &amd_ir_domain_ops, iommu);
> -	irq_domain_free_fwnode(fn);
> -	if (!iommu->ir_domain)
> +	if (!iommu->ir_domain) {
> +		irq_domain_free_fwnode(fn);
>  		return -ENOMEM;
> +	}
>  
>  	iommu->ir_domain->parent = arch_get_ir_parent_domain();
>  	iommu->msi_domain = arch_create_remap_msi_irq_domain(iommu->ir_domain,
> diff --git a/drivers/iommu/hyperv-iommu.c b/drivers/iommu/hyperv-iommu.c
> index 3c0c67a99c7b..8919c1c70b68 100644
> --- a/drivers/iommu/hyperv-iommu.c
> +++ b/drivers/iommu/hyperv-iommu.c
> @@ -155,7 +155,10 @@ static int __init hyperv_prepare_irq_remapping(void)
>  				0, IOAPIC_REMAPPING_ENTRY, fn,
>  				&hyperv_ir_domain_ops, NULL);
>  
> -	irq_domain_free_fwnode(fn);
> +	if (!ioapic_ir_domain) {
> +		irq_domain_free_fwnode(fn);
> +		return -ENOMEM;
> +	}
>  
>  	/*
>  	 * Hyper-V doesn't provide irq remapping function for
> diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
> index 7f8769800815..9564d23d094f 100644
> --- a/drivers/iommu/intel/irq_remapping.c
> +++ b/drivers/iommu/intel/irq_remapping.c
> @@ -563,8 +563,8 @@ static int intel_setup_irq_remapping(struct intel_iommu *iommu)
>  					    0, INTR_REMAP_TABLE_ENTRIES,
>  					    fn, &intel_ir_domain_ops,
>  					    iommu);
> -	irq_domain_free_fwnode(fn);
>  	if (!iommu->ir_domain) {
> +		irq_domain_free_fwnode(fn);
>  		pr_err("IR%d: failed to allocate irqdomain\n", iommu->seq_id);
>  		goto out_free_bitmap;
>  	}
> diff --git a/drivers/mfd/ioc3.c b/drivers/mfd/ioc3.c
> index 02998d4eb74b..74cee7cb0afc 100644
> --- a/drivers/mfd/ioc3.c
> +++ b/drivers/mfd/ioc3.c
> @@ -142,10 +142,11 @@ static int ioc3_irq_domain_setup(struct ioc3_priv_data *ipd, int irq)
>  		goto err;
>  
>  	domain = irq_domain_create_linear(fn, 24, &ioc3_irq_domain_ops, ipd);
> -	if (!domain)
> +	if (!domain) {
> +		irq_domain_free_fwnode(fn);
>  		goto err;
> +	}
>  
> -	irq_domain_free_fwnode(fn);
>  	ipd->domain = domain;
>  
>  	irq_set_chained_handler_and_data(irq, ioc3_irq_handler, domain);
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index e386d4eac407..9a64cf90c291 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -546,9 +546,10 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>  
>  	vmd->irq_domain = pci_msi_create_irq_domain(fn, &vmd_msi_domain_info,
>  						    x86_vector_domain);
> -	irq_domain_free_fwnode(fn);
> -	if (!vmd->irq_domain)
> +	if (!vmd->irq_domain) {
> +		irq_domain_free_fwnode(fn);
>  		return -ENODEV;
> +	}
>  
>  	pci_add_resource(&resources, &vmd->resources[0]);
>  	pci_add_resource_offset(&resources, &vmd->resources[1], offset[0]);
