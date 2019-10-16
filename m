Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF80AD986C
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2019 19:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbfJPRZ7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Oct 2019 13:25:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:49176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726731AbfJPRZ7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 16 Oct 2019 13:25:59 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 423C72067D;
        Wed, 16 Oct 2019 17:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571246205;
        bh=EQaAwO54CeP+MQ2eicpsCsrBE1Z5Fn8aOZB1qeu7Apc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=IwkuAZfgf+QsVdFeamrHnOXz8C3YuP7S+QWqx7PHTUnitqmlY8vSkbNqIBZgtB8up
         M9iGFLlABb4mRN2Hps/rz3ml+eXX1vFmht/algIHpFwMbSdq16qMrQWZIeykW/Vs3F
         1LuTMzxJfkATxBdhms9+K/2z9PAVIRDQjAdCjxMw=
Date:   Wed, 16 Oct 2019 12:16:43 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yuri Volchkov <volchkov@amazon.de>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, joro@8bytes.org, dwmw2@infradead.org,
        neugebar@amazon.co.uk
Subject: Re: [PATCH 1/2] iommu/dmar: collect fault statistics
Message-ID: <20191016171643.GA20141@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015151112.17225-2-volchkov@amazon.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Yuri,

On Tue, Oct 15, 2019 at 05:11:11PM +0200, Yuri Volchkov wrote:
> Currently dmar_fault handler only prints a message in the dmesg. This
> commit introduces counters - how many faults have happened, and
> exposes them via sysfs. Each pci device will have an entry
> 'dmar_faults' reading from which will give user 3 lines
>   remap: xxx
>   read: xxx
>   write: xxx

I think you should have three files instead of putting all these in a
single file.  See https://lore.kernel.org/r/20190621072911.GA21600@kroah.com
They should also be documented in Documentation/ABI/

I'm not sure this should be DMAR-specific.  Couldn't we count similar
events for other IOMMUs as well?

> This functionality is targeted for health monitoring daemons.
> 
> Signed-off-by: Yuri Volchkov <volchkov@amazon.de>
> ---
>  drivers/iommu/dmar.c        | 133 +++++++++++++++++++++++++++++++-----
>  drivers/pci/pci-sysfs.c     |  20 ++++++
>  include/linux/intel-iommu.h |   3 +
>  include/linux/pci.h         |  11 +++
>  4 files changed, 150 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
> index eecd6a421667..0749873e3e41 100644
> --- a/drivers/iommu/dmar.c
> +++ b/drivers/iommu/dmar.c
> @@ -1107,6 +1107,7 @@ static void free_iommu(struct intel_iommu *iommu)
>  	}
>  
>  	if (iommu->irq) {
> +		destroy_workqueue(iommu->fault_wq);
>  		if (iommu->pr_irq) {
>  			free_irq(iommu->pr_irq, iommu);
>  			dmar_free_hwirq(iommu->pr_irq);
> @@ -1672,9 +1673,46 @@ void dmar_msi_read(int irq, struct msi_msg *msg)
>  	raw_spin_unlock_irqrestore(&iommu->register_lock, flag);
>  }
>  
> -static int dmar_fault_do_one(struct intel_iommu *iommu, int type,
> -		u8 fault_reason, int pasid, u16 source_id,
> -		unsigned long long addr)
> +struct dmar_fault_info {
> +	struct work_struct work;
> +	struct intel_iommu *iommu;
> +	int type;
> +	int pasid;
> +	u16 source_id;
> +	unsigned long long addr;
> +	u8 fault_reason;
> +};
> +
> +static struct kmem_cache *dmar_fault_info_cache;
> +int __init dmar_fault_info_cache_init(void)
> +{
> +	int ret = 0;
> +
> +	dmar_fault_info_cache =
> +		kmem_cache_create("dmar_fault_info",
> +				  sizeof(struct dmar_fault_info), 0,
> +				  SLAB_HWCACHE_ALIGN, NULL);
> +	if (!dmar_fault_info_cache) {
> +		pr_err("Couldn't create dmar_fault_info cache\n");
> +		ret = -ENOMEM;
> +	}
> +
> +	return ret;
> +}
> +
> +static inline void *alloc_dmar_fault_info(void)
> +{
> +	return kmem_cache_alloc(dmar_fault_info_cache, GFP_ATOMIC);
> +}
> +
> +static inline void free_dmar_fault_info(void *vaddr)
> +{
> +	kmem_cache_free(dmar_fault_info_cache, vaddr);
> +}
> +
> +static int dmar_fault_dump_one(struct intel_iommu *iommu, int type,
> +			       u8 fault_reason, int pasid, u16 source_id,
> +			       unsigned long long addr)
>  {
>  	const char *reason;
>  	int fault_type;
> @@ -1695,6 +1733,57 @@ static int dmar_fault_do_one(struct intel_iommu *iommu, int type,
>  	return 0;
>  }
>  
> +static int dmar_fault_handle_one(struct dmar_fault_info *info)
> +{
> +	struct pci_dev *pdev;
> +	u8 devfn;
> +	atomic_t *pcnt;
> +
> +	devfn = PCI_DEVFN(PCI_SLOT(info->source_id), PCI_FUNC(info->source_id));
> +	pdev = pci_get_domain_bus_and_slot(info->iommu->segment,
> +					   PCI_BUS_NUM(info->source_id), devfn);

I'm sure you've considered this already, but it's not completely clear
to me whether these counters should be in the pci_dev (as in this
patch) or in something IOMMU-related.

The pci_dev is nice because you automatically have counters for each
PCI device, and most faults can be tied back to a device.

But on the other hand, it's not the PCI device actually detecting and
reporting the error.  It's the IOMMU reporting the fault, and while
it's *likely* there's a pci_dev corresponding to the
bus/device/function info in the IOMMU error registers, there's no
guarantee: the device may have been hot-removed between reading the
IOMMU registers and doing the pci_get_domain_bus_and_slot(), or (I
suspect) faults could be caused by corrupted or malicious TLPs.

Another possible issue is that if the counts are in the pci_dev,
they're lost if the device is removed, which might happen while
diagnosing faulty hardware.

So I tend to think this is really IOMMU error information and the
IOMMU driver should handle it itself, including logging and exposing
it via sysfs.

> +	if (!pdev)
> +		return -ENXIO;
> +
> +	if (info->fault_reason == INTR_REMAP)
> +		pcnt = &pdev->faults_cnt.remap;
> +	else if (info->type)
> +		pcnt = &pdev->faults_cnt.read;
> +	else
> +		pcnt = &pdev->faults_cnt.write;
> +
> +	atomic_inc(pcnt);

pci_get_domain_bus_and_slot() increments pdev's reference count, so
you would need to release it here.

> +	return 0;
> +}
> +
> +static void dmar_fault_handle_work(struct work_struct *work)
> +{
> +	struct dmar_fault_info *info;
> +
> +	info = container_of(work, struct dmar_fault_info, work);
> +
> +	dmar_fault_handle_one(info);
> +	free_dmar_fault_info(info);
> +}
> +
> +static int dmar_fault_schedule_one(struct intel_iommu *iommu, int type,
> +				   u8 fault_reason, int pasid, u16 source_id,
> +				   unsigned long long addr)
> +{
> +	struct dmar_fault_info *info = alloc_dmar_fault_info();
> +
> +	INIT_WORK(&info->work, dmar_fault_handle_work);
> +	info->iommu = iommu;
> +	info->type = type;
> +	info->fault_reason = fault_reason;
> +	info->pasid = pasid;
> +	info->source_id = source_id;
> +	info->addr = addr;
> +
> +	return queue_work(iommu->fault_wq, &info->work);
> +}
> +
>  #define PRIMARY_FAULT_REG_LEN (16)
>  irqreturn_t dmar_fault(int irq, void *dev_id)
>  {
> @@ -1733,20 +1822,18 @@ irqreturn_t dmar_fault(int irq, void *dev_id)
>  		if (!(data & DMA_FRCD_F))
>  			break;
>  
> -		if (!ratelimited) {
> -			fault_reason = dma_frcd_fault_reason(data);
> -			type = dma_frcd_type(data);
> +		fault_reason = dma_frcd_fault_reason(data);
> +		type = dma_frcd_type(data);
>  
> -			pasid = dma_frcd_pasid_value(data);
> -			data = readl(iommu->reg + reg +
> -				     fault_index * PRIMARY_FAULT_REG_LEN + 8);
> -			source_id = dma_frcd_source_id(data);
> +		pasid = dma_frcd_pasid_value(data);
> +		data = readl(iommu->reg + reg +
> +			     fault_index * PRIMARY_FAULT_REG_LEN + 8);
> +		source_id = dma_frcd_source_id(data);
>  
> -			pasid_present = dma_frcd_pasid_present(data);
> -			guest_addr = dmar_readq(iommu->reg + reg +
> +		pasid_present = dma_frcd_pasid_present(data);
> +		guest_addr = dmar_readq(iommu->reg + reg +
>  					fault_index * PRIMARY_FAULT_REG_LEN);
> -			guest_addr = dma_frcd_page_addr(guest_addr);
> -		}
> +		guest_addr = dma_frcd_page_addr(guest_addr);
>  
>  		/* clear the fault */
>  		writel(DMA_FRCD_F, iommu->reg + reg +
> @@ -1756,9 +1843,13 @@ irqreturn_t dmar_fault(int irq, void *dev_id)
>  
>  		if (!ratelimited)
>  			/* Using pasid -1 if pasid is not present */
> -			dmar_fault_do_one(iommu, type, fault_reason,
> -					  pasid_present ? pasid : -1,
> -					  source_id, guest_addr);
> +			dmar_fault_dump_one(iommu, type, fault_reason,
> +					    pasid_present ? pasid : -1,
> +					    source_id, guest_addr);
> +		if (irq != -1)
> +			dmar_fault_schedule_one(iommu, type, fault_reason,
> +						pasid_present ? pasid : -1,
> +						source_id, guest_addr);
>  
>  		fault_index++;
>  		if (fault_index >= cap_num_fault_regs(iommu->cap))
> @@ -1784,6 +1875,10 @@ int dmar_set_interrupt(struct intel_iommu *iommu)
>  	if (iommu->irq)
>  		return 0;
>  
> +	iommu->fault_wq = alloc_ordered_workqueue("fault_%s", 0, iommu->name);
> +	if (!iommu->fault_wq)
> +		return -ENOMEM;
> +
>  	irq = dmar_alloc_hwirq(iommu->seq_id, iommu->node, iommu);
>  	if (irq > 0) {
>  		iommu->irq = irq;
> @@ -1803,6 +1898,9 @@ int __init enable_drhd_fault_handling(void)
>  	struct dmar_drhd_unit *drhd;
>  	struct intel_iommu *iommu;
>  
> +	if (dmar_fault_info_cache_init())
> +		return -1;
> +
>  	/*
>  	 * Enable fault control interrupt.
>  	 */
> @@ -1813,6 +1911,7 @@ int __init enable_drhd_fault_handling(void)
>  		if (ret) {
>  			pr_err("DRHD %Lx: failed to enable fault, interrupt, ret %d\n",
>  			       (unsigned long long)drhd->reg_base_addr, ret);
> +			kmem_cache_destroy(dmar_fault_info_cache);
>  			return -1;
>  		}
>  
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 07bd84c50238..d01514fca6d1 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -263,6 +263,23 @@ static ssize_t ari_enabled_show(struct device *dev,
>  }
>  static DEVICE_ATTR_RO(ari_enabled);
>  
> +#ifdef CONFIG_DMAR_TABLE
> +static ssize_t dmar_faults_show(struct device *dev,
> +				struct device_attribute *attr, char *buf)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	int remap, read, write;
> +
> +	remap = atomic_xchg(&pdev->faults_cnt.remap, 0);
> +	read = atomic_xchg(&pdev->faults_cnt.read, 0);
> +	write = atomic_xchg(&pdev->faults_cnt.write, 0);

Doesn't this clear-on-read approach allow anybody to clear these
counters?  This looks like it's world-readable, and I'm not sure an
unprivileged user should be able to clear the counters.

> +
> +	return sprintf(buf, "remap: %d\nread: %d\nwrite: %d\n", remap, read,
> +		       write);
> +}
> +static DEVICE_ATTR_RO(dmar_faults);
> +#endif
> +
>  static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
>  			     char *buf)
>  {
> @@ -623,6 +640,9 @@ static struct attribute *pci_dev_attrs[] = {
>  #endif
>  	&dev_attr_driver_override.attr,
>  	&dev_attr_ari_enabled.attr,
> +#ifdef CONFIG_DMAR_TABLE
> +	&dev_attr_dmar_faults.attr,
> +#endif
>  	NULL,
>  };
>  
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index ed11ef594378..f8963c833fb0 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -552,6 +552,9 @@ struct intel_iommu {
>  	struct iommu_device iommu;  /* IOMMU core code handle */
>  	int		node;
>  	u32		flags;      /* Software defined flags */
> +#ifdef CONFIG_DMAR_TABLE
> +	struct workqueue_struct *fault_wq; /* Fault handler */
> +#endif
>  };
>  
>  /* PCI domain-device relationship */
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 14efa2586a8c..d9cc94fbf0ee 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -286,6 +286,14 @@ struct pci_vpd;
>  struct pci_sriov;
>  struct pci_p2pdma;
>  
> +#ifdef CONFIG_DMAR_TABLE
> +struct pci_dmar_faults_cnt {
> +	atomic_t read; /* How many read faults occurred */
> +	atomic_t write; /* How many write faults occurred */
> +	atomic_t remap; /* How many remap faults occurred */
> +};
> +#endif
> +
>  /* The pci_dev structure describes PCI devices */
>  struct pci_dev {
>  	struct list_head bus_list;	/* Node in per-bus list */
> @@ -468,6 +476,9 @@ struct pci_dev {
>  	char		*driver_override; /* Driver name to force a match */
>  
>  	unsigned long	priv_flags;	/* Private flags for the PCI driver */
> +#ifdef CONFIG_DMAR_TABLE
> +	struct pci_dmar_faults_cnt faults_cnt; /* Dmar fault statistics */
> +#endif
>  };
>  
>  static inline struct pci_dev *pci_physfn(struct pci_dev *dev)
> -- 
> 2.23.0
> 
> 
> 
> 
> Amazon Development Center Germany GmbH
> Krausenstr. 38
> 10117 Berlin
> Geschaeftsfuehrung: Christian Schlaeger, Ralf Herbrich
> Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
> Sitz: Berlin
> Ust-ID: DE 289 237 879
> 
> 
> 
