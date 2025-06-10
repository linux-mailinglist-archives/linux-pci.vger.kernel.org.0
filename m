Return-Path: <linux-pci+bounces-29271-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A36FAD2C9B
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 06:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D5D51890362
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 04:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733F525DCE5;
	Tue, 10 Jun 2025 04:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hbRUwTGa"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4BC221262;
	Tue, 10 Jun 2025 04:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749529621; cv=none; b=eXkcqkP726uHY1+PZ34W+ZaYHl1sRoczZowXAwJvutUN0XrPRA8G2ZIQXX8UBO1DzvP74DbvXJBlGklD37ixwqcxf34RFQmd4X96c2xBqCPwU8fKEyXHCIP5zqxvef337ZP6m97fvDPVTa7CU67nNu1TLMvmfhGEgFCJEhay0Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749529621; c=relaxed/simple;
	bh=zVMeygUHHn/zTdGqS6H1eKNIBQeFicUMi1Q6FSlCnas=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nE/FXcIw9famf3Z9Qnt+jNn6kpE2UAvco+XWKcJJ8Xo/1Hn82Hu/JUsrb5i2ZHouFdpHR2LxwV4ksQVhJs0zVwIsmGaT4cBm/ZcKBJTkm4IG/P5YP2GxsvO6DRmyz7viq6OvmZjfMWsoKDavL+0VyfZZkxpRPq9z4ZjwK8mTyPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hbRUwTGa; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749529620; x=1781065620;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zVMeygUHHn/zTdGqS6H1eKNIBQeFicUMi1Q6FSlCnas=;
  b=hbRUwTGaX9L2Tm1EZ7acfEORs4R9HtvkXfV2OOxscHoPqxUjYErv+A5L
   16AZhzgcmrPO7RobDc2XxmKRWJ8aGPUR6X3lW3gnPIoxnQUmjjeIVIkg/
   hD2nej90VPf21gS6XcV54VoQ6nV1VkS679HBljbCZ9S3H4BhuxoJGJIQX
   D0eUdWJOs98h+TLO0lBezF2AT5CyVTVgOPyJGIIQTaSEvPfiXVcfFhnty
   Qlep72lIjf90rzY9oul9fEXkuP70X0wazqMlfa2Ul3nwHQrlI07T34SLX
   3ddc1Ak/7XL6TDCPnc37oGjiviJPSi4DVB/TivFQfvXK195ewjx8cB/U+
   Q==;
X-CSE-ConnectionGUID: rliUiK3XTdi2cq5v4dg6lA==
X-CSE-MsgGUID: filo8kIYSv670JM3htNk+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="54253625"
X-IronPort-AV: E=Sophos;i="6.16,224,1744095600"; 
   d="scan'208";a="54253625"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 21:26:59 -0700
X-CSE-ConnectionGUID: eF6I1IteTlKS02iByZITvA==
X-CSE-MsgGUID: hsWPvFVFTMeAr8XXOr8fbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,224,1744095600"; 
   d="scan'208";a="146597798"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 21:26:56 -0700
Message-ID: <183a8466-578c-4305-a16b-924b41b97322@linux.intel.com>
Date: Tue, 10 Jun 2025 12:26:07 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v1 1/2] iommu: Introduce iommu_dev_reset_prepare() and
 iommu_dev_reset_done()
To: Nicolin Chen <nicolinc@nvidia.com>, jgg@nvidia.com, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com, bhelgaas@google.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, patches@lists.linux.dev, pjaroszynski@nvidia.com,
 vsethi@nvidia.com
References: <cover.1749494161.git.nicolinc@nvidia.com>
 <4153fb7131dda901b13a2e90654232fe059c8f09.1749494161.git.nicolinc@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <4153fb7131dda901b13a2e90654232fe059c8f09.1749494161.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/10/25 02:45, Nicolin Chen wrote:
> Per PCIe r6.3, sec 10.3.1 IMPLEMENTATION NOTE, software should disable ATS
> before initiating a Function Level Reset, and then ensure no invalidation
> requests being issued to a device when its ATS capability is disabled.
> 
> Since pci_enable_ats() and pci_disable_ats() are called by an IOMMU driver
> while an unsolicited FLR can happen at any time in the PCI layer, PCI code
> has to notify the IOMMU subsystem about the ongoing FLR. Add a pair of new
> IOMMU APIs that will be called by the PCI reset functions before&after the
> reset routines.
> 
> However, if there is a domain attachment/replacement happening during an
> ongoing reset, the ATS might be re-enabled between the two function calls.
> So the iommu_dev_reset_prepare() has to hold the group mutex to avoid this
> race condition, unitl iommu_dev_reset_done() is finished. Thus, these two
> functions are a strong pair that must be used together.
> 
> Inside the mutex, these two functions will dock all RID and PASID domains
> to an IOMMU_DOMAIN_BLOCKED. This would further disable ATS by two-fold: an
> IOMMU driver should disable ATS in its control bits (e.g. SMMU's STE.EATS)
> and an IOMMU driver should call pci_disable_ats() as well.
> 
> Notes:
>   - This only works for IOMMU drivers that implemented ops->blocked_domain
>     correctly with pci_disable_ats().
>   - This only works for IOMMU drivers that will not issue ATS invalidation
>     requests to the device, after it's docked at ops->blocked_domain.
> Driver should fix itself to align with the aforementioned notes.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>   include/linux/iommu.h |  12 +++++
>   drivers/iommu/iommu.c | 106 ++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 118 insertions(+)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 156732807994..a17161b8625a 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -1123,6 +1123,9 @@ void dev_iommu_priv_set(struct device *dev, void *priv);
>   extern struct mutex iommu_probe_device_lock;
>   int iommu_probe_device(struct device *dev);
>   
> +int iommu_dev_reset_prepare(struct device *dev);
> +void iommu_dev_reset_done(struct device *dev);
> +
>   int iommu_device_use_default_domain(struct device *dev);
>   void iommu_device_unuse_default_domain(struct device *dev);
>   
> @@ -1407,6 +1410,15 @@ static inline int iommu_fwspec_add_ids(struct device *dev, u32 *ids,
>   	return -ENODEV;
>   }
>   
> +static inline int iommu_dev_reset_prepare(struct device *dev)
> +{
> +	return 0;
> +}
> +
> +static inline void iommu_dev_reset_done(struct device *dev)
> +{
> +}
> +
>   static inline struct iommu_fwspec *dev_iommu_fwspec_get(struct device *dev)
>   {
>   	return NULL;
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index a4b606c591da..3c1854c5e55e 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -3795,6 +3795,112 @@ int iommu_replace_group_handle(struct iommu_group *group,
>   }
>   EXPORT_SYMBOL_NS_GPL(iommu_replace_group_handle, "IOMMUFD_INTERNAL");
>   
> +/*
> + * Deadlock Alert
> + *
> + * Caller must use iommu_dev_reset_prepare() and iommu_dev_reset_done() together
> + * before/after the core-level reset routine, as iommu_dev_reset_prepare() holds
> + * the group->mutex that will be only released in iommu_dev_reset_done().
> + */
> +int iommu_dev_reset_prepare(struct device *dev)
> +{
> +	struct iommu_group *group = dev->iommu_group;
> +	const struct iommu_ops *ops;
> +	unsigned long pasid;
> +	void *entry;
> +	int ret;
> +
> +	/* Before locking */
> +	if (!dev_has_iommu(dev))
> +		return 0;
> +
> +	if (dev->iommu->require_direct) {
> +		dev_warn(dev,
> +			 "Firmware has requested this device have a 1:1 IOMMU mapping, rejecting configuring the device without a 1:1 mapping. Contact your platform vendor.\n");
> +		return -EINVAL;
> +	}
> +
> +	ops = dev_iommu_ops(dev);

Should this be protected by group->mutext?

> +	if (!ops->blocked_domain) {
> +		dev_warn(dev,
> +			 "IOMMU driver doesn't support IOMMU_DOMAIN_BLOCKED\n");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	/*
> +	 * group->mutex starts
> +	 *
> +	 * This has to hold the group mutex until the reset is done, to prevent
> +	 * any RID or PASID domain attachment/replacement, which otherwise might
> +	 * re-enable the ATS during the reset cycle.
> +	 */
> +	mutex_lock(&group->mutex);

Is it possible that group has been freed when it reaches here?

> +
> +	/* Device is already attached to the blocked_domain. Nothing to do */
> +	if (group->domain->type == IOMMU_DOMAIN_BLOCKED)
> +		return 0;
> +
> +	/* Dock RID domain to blocked_domain while retaining group->domain */
> +	ret = __iommu_attach_device(ops->blocked_domain, dev);
> +	if (ret)
> +		return ret;
> +
> +	/* Dock PASID domains to blocked_domain while retaining pasid_array */
> +	xa_lock(&group->pasid_array);
> +	xa_for_each_start(&group->pasid_array, pasid, entry, 1)
> +		iommu_remove_dev_pasid(dev, pasid,
> +				       pasid_array_entry_to_domain(entry));
> +	xa_unlock(&group->pasid_array);
> +
> +	/* group->mutex is held. Caller must invoke iommu_dev_reset_done() */
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(iommu_dev_reset_prepare);
> +
> +/*
> + * This is the resume routine of iommu_dev_reset_prepare(). It unlocks the group
> + * mutex at end, after all RID/PASID domains are re-attached.
> + *
> + * Note that, although unlikely, there is a risk that re-attaching domains might
> + * fail due to some unexpected happening like OOM.
> + */
> +void iommu_dev_reset_done(struct device *dev)
> +{
> +	struct iommu_group *group = dev->iommu_group;
> +	const struct iommu_ops *ops;
> +	unsigned long pasid;
> +	void *entry;
> +
> +	/* Previously unlocked */
> +	if (!dev_has_iommu(dev))
> +		return;
> +	ops = dev_iommu_ops(dev);
> +	if (!ops->blocked_domain)
> +		return;

Should it be a WARN_ON()? As proposed, reset_prepare and reset_done must
be paired. So if reset_prepare returns failure, reset_done should not be
called. Or not?

> +
> +	/* group->mutex held in iommu_dev_reset_prepare() continues from here */
> +	WARN_ON(!lockdep_is_held(&group->mutex));

Probably iommu_group_mutex_assert() and move it up?

> +
> +	if (group->domain->type == IOMMU_DOMAIN_BLOCKED)
> +		goto unlock;
> +
> +	/* Shift RID domain back to group->domain */
> +	WARN_ON(__iommu_attach_device(group->domain, dev));
> +
> +	/* Shift PASID domains back to domains retained in pasid_array */
> +	xa_lock(&group->pasid_array);
> +	xa_for_each_start(&group->pasid_array, pasid, entry, 1)
> +		WARN_ON(__iommu_set_group_pasid(
> +			pasid_array_entry_to_domain(entry), group, pasid,
> +			ops->blocked_domain));
> +	xa_unlock(&group->pasid_array);
> +
> +unlock:
> +	mutex_unlock(&group->mutex);
> +}
> +EXPORT_SYMBOL_GPL(iommu_dev_reset_done);
> +
>   #if IS_ENABLED(CONFIG_IRQ_MSI_IOMMU)
>   /**
>    * iommu_dma_prepare_msi() - Map the MSI page in the IOMMU domain

How about combining these two helpers? Something like,

int iommu_dev_block_dma_and_action(struct device *dev,
		int (*action)(struct pci_dev *dev))
{
	prepare();
	action();
	done();
}

?

Thanks,
baolu

