Return-Path: <linux-pci+bounces-31000-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A188AEC767
	for <lists+linux-pci@lfdr.de>; Sat, 28 Jun 2025 15:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 728D77A8E29
	for <lists+linux-pci@lfdr.de>; Sat, 28 Jun 2025 13:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3BB246764;
	Sat, 28 Jun 2025 13:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EMcL2y48"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE7A17ADF8;
	Sat, 28 Jun 2025 13:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751117301; cv=none; b=cy44Du+66PpWB0q1K8inlElb/KP7AONTphrBC+2NT9Hi5IMzVzklAQ3LzcA82oQa9/DIY1od3CvHRFSCtn0ZfIf1iXu3Bqvu0uFnwmkp47XiO36gTe0VCr9ucqJsKzhPj7CafqC4HSoL47KF/CKgmflCWyspUuW0Cn53Gj5R2GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751117301; c=relaxed/simple;
	bh=ji99GoMmZ+BmHWew9GGKVVTMG5BQGwO4X4vVoTM8jUo=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=aIAkMpPLP+S8e+8vHPOYU9mM04PpGzlm0SbRbky88xs/M5r7n+2QpLOu3/Zm6kM7yW+LHDR54yemE8gZ1XGyAGkDZcekMYaYdKp01T1KVIy6HZs0zPWi407nFq5v+Hv0+aEBoDsjr6UjfDqpZffOJP5dLU/X83UGbngqrd0dieM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EMcL2y48; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751117299; x=1782653299;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ji99GoMmZ+BmHWew9GGKVVTMG5BQGwO4X4vVoTM8jUo=;
  b=EMcL2y48MMB373FJqh6fkImgU0EqrUKbUmGUPMCONEUqM8NLdATJ3lPx
   G/+jeI1w1pxzk/NrpEYpZYdoDWnp8CfvsUgTCmPkFkBVKDFXMOJyuzMTY
   unMsceGKxbLKT4YbgLcQaxh/NxDtF77sugqzWZjG1kWssTwTfF+tOjx8X
   qHZSfO1g7xRXClXtNEmGNFqRk8eRvAhmQSHxhcm2P/3ZJU2SyhxGrVJNg
   VlGH0BA+XPyHcOXbvAYOWrRkkUx0QUGEmSWv6svusS9YzU4HxNgxb7LP3
   1e/ALFBMPeJ9srjq1hGvHWtm+rMKWyptENI86SCVz3POX7MLzygKA0S/g
   Q==;
X-CSE-ConnectionGUID: qc0frzKQSOKbRrut9Kr6tA==
X-CSE-MsgGUID: y3u5RsUoR5W6mCcFWPXoxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11478"; a="64007910"
X-IronPort-AV: E=Sophos;i="6.16,273,1744095600"; 
   d="scan'208";a="64007910"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2025 06:28:18 -0700
X-CSE-ConnectionGUID: cBHHD+OYSt65z/yA9QfR9A==
X-CSE-MsgGUID: I3WJoKQDT661nA0lRsItyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,273,1744095600"; 
   d="scan'208";a="158533135"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.243.252]) ([10.124.243.252])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2025 06:28:15 -0700
Message-ID: <e505c970-e519-44c6-a316-e5d186f216ca@linux.intel.com>
Date: Sat, 28 Jun 2025 21:28:12 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-pci@vger.kernel.org, patches@lists.linux.dev, pjaroszynski@nvidia.com,
 vsethi@nvidia.com, helgaas@kernel.org
Subject: Re: [PATCH RFC v2 3/4] iommu: Introduce iommu_dev_reset_prepare() and
 iommu_dev_reset_done()
To: Nicolin Chen <nicolinc@nvidia.com>, jgg@nvidia.com, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com, rafael@kernel.org, lenb@kernel.org,
 bhelgaas@google.com
References: <cover.1751096303.git.nicolinc@nvidia.com>
 <9042270b6c2d15a53e66d22d29b87c1c59e60669.1751096303.git.nicolinc@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <9042270b6c2d15a53e66d22d29b87c1c59e60669.1751096303.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/28/2025 3:42 PM, Nicolin Chen wrote:
> PCIe permits a device to ignore ATS invalidation TLPs, while processing a
> reset. This creates a problem visible to the OS where an ATS invalidation
> command will time out: e.g. an SVA domain will have no coordination with a
> reset event and can racily issue ATS invalidations to a resetting device.
> 
> The OS should do something to mitigate this as we do not want production
> systems to be reporting critical ATS failures, especially in a hypervisor
> environment. Broadly, OS could arrange to ignore the timeouts, block page
> table mutations to prevent invalidations, or disable and block ATS.
> 
> The PCIe spec in sec 10.3.1 IMPLEMENTATION NOTE recommends to disable and
> block ATS before initiating a Function Level Reset. It also mentions that
> other reset methods could have the same vulnerability as well.
> 
> Provide a callback from the PCI subsystem that will enclose the reset and
> have the iommu core temporarily change all the attached domain to BLOCKED.
> After attaching a BLOCKED domain, IOMMU drivers should fence any incoming
> ATS queries, synchronously stop issuing new ATS invalidations, and wait
> for all ATS invalidations to complete. This can avoid any ATS invaliation
> timeouts.
> 
> However, if there is a domain attachment/replacement happening during an
> ongoing reset, the ATS might be re-enabled between the two function calls.
> Introduce a new pending_reset flag in group_device to defer an attachment
> during a reset, allowing iommu core to cache the target domains in the SW
> level but bypassing the driver. The iommu_dev_reset_done() will re-attach
> these soft-attached domains via __iommu_attach_device/set_group_pasid().
> 
> Notes:
>   - This only works for IOMMU drivers that implemented ops->blocked_domain
>     correctly with pci_disable_ats().

Does this mean the IOMMU driver should disable ATS when ops-
 >blocked_domain is used? This might not be feasible because ops-
 >blocked_domain might possibly be attached to a PASID of a device, while
other PASIDs still use ATS for functionality.

>   - This only works for IOMMU drivers that will not issue ATS invalidation
>     requests to the device, after it's docked at ops->blocked_domain.
> Driver should fix itself to align with the aforementioned notes.

My understanding of the requirements for the iommu drivers is: when all
PASIDs are docked in the blocking DMA state, the IOMMU driver should:

- Flush all outstanding ATS invalidation requests;
- Stop issuing any further ATS invalidations;
- Configure the hardware to reject further ATS translation requests.

> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>   include/linux/iommu.h |  12 ++++
>   drivers/iommu/iommu.c | 158 ++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 170 insertions(+)
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
> index bd3deedcd2de..14bfeaa9ac29 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -71,12 +71,29 @@ struct group_device {
>   	struct list_head list;
>   	struct device *dev;
>   	char *name;
> +	bool pending_reset : 1;
>   };
>   
>   /* Iterate over each struct group_device in a struct iommu_group */
>   #define for_each_group_device(group, pos) \
>   	list_for_each_entry(pos, &(group)->devices, list)
>   
> +/* Callers must hold the dev->iommu_group->mutex */
> +static struct group_device *device_to_group_device(struct device *dev)
> +{
> +	struct iommu_group *group = dev->iommu_group;
> +	struct group_device *gdev;
> +
> +	lockdep_assert_held(&group->mutex);
> +
> +	/* gdev must be in the list */
> +	for_each_group_device(group, gdev) {
> +		if (gdev->dev == dev)
> +			break;
> +	}
> +	return gdev;
> +}
> +
>   struct iommu_group_attribute {
>   	struct attribute attr;
>   	ssize_t (*show)(struct iommu_group *group, char *buf);
> @@ -2155,8 +2172,17 @@ int iommu_deferred_attach(struct device *dev, struct iommu_domain *domain)
>   	int ret = 0;
>   
>   	mutex_lock(&group->mutex);
> +
> +	/*
> +	 * There is a racy attach while the device is resetting. Defer it until
> +	 * the iommu_dev_reset_done() that attaches the device to group->domain.
> +	 */
> +	if (device_to_group_device(dev)->pending_reset)
> +		goto unlock;
> +
>   	if (dev->iommu && dev->iommu->attach_deferred)
>   		ret = __iommu_attach_device(domain, dev);
> +unlock:
>   	mutex_unlock(&group->mutex);
>   	return ret;
>   }
> @@ -2295,6 +2321,13 @@ static int __iommu_device_set_domain(struct iommu_group *group,
>   		dev->iommu->attach_deferred = 0;
>   	}
>   
> +	/*
> +	 * There is a racy attach while the device is resetting. Defer it until
> +	 * the iommu_dev_reset_done() that attaches the device to group->domain.
> +	 */
> +	if (gdev->pending_reset)
> +		return 0;
> +
>   	ret = __iommu_attach_device(new_domain, dev);
>   	if (ret) {
>   		/*
> @@ -3378,6 +3411,13 @@ static int __iommu_set_group_pasid(struct iommu_domain *domain,
>   	int ret;
>   
>   	for_each_group_device(group, device) {
> +		/*
> +		 * There is a racy attach while the device is resetting. Defer
> +		 * it until the iommu_dev_reset_done() that attaches the device
> +		 * to group->domain.
> +		 */
> +		if (device->pending_reset)
> +			continue;
>   		if (device->dev->iommu->max_pasids > 0) {
>   			ret = domain->ops->set_dev_pasid(domain, device->dev,
>   							 pasid, old);
> @@ -3799,6 +3839,124 @@ int iommu_replace_group_handle(struct iommu_group *group,
>   }
>   EXPORT_SYMBOL_NS_GPL(iommu_replace_group_handle, "IOMMUFD_INTERNAL");
>   
> +/*
> + * Caller must use iommu_dev_reset_prepare() and iommu_dev_reset_done() together
> + * before/after the core-level reset routine, to unclear the pending_reset flag
> + * and to put the iommu_group reference.
> + *
> + * These two functions are designed to be used by PCI reset functions that would
> + * not invoke any racy iommu_release_device() since PCI sysfs node gets removed
> + * before it notifies with a BUS_NOTIFY_REMOVED_DEVICE. When using them in other
> + * case, callers must ensure there will be no racy iommu_release_device() call,
> + * which otherwise would UAF the dev->iommu_group pointer.
> + */

Use kdoc style comments.

> +int iommu_dev_reset_prepare(struct device *dev)
> +{
> +	const struct iommu_ops *ops;
> +	struct iommu_group *group;
> +	unsigned long pasid;
> +	void *entry;
> +	int ret = 0;
> +
> +	if (!dev_has_iommu(dev))
> +		return 0;
> +
> +	if (dev->iommu->require_direct) {
> +		dev_warn(
> +			dev,
> +			"Firmware has requested this device have a 1:1 IOMMU mapping, rejecting configuring the device without a 1:1 mapping. Contact your platform vendor.\n");
> +		return -EINVAL;
> +	}
> +
> +	/* group will be put in iommu_dev_reset_done() */
> +	group = iommu_group_get(dev);
> +
> +	/* Caller ensures no racy iommu_release_device(), so this won't UAF */
> +	mutex_lock(&group->mutex);
> +
> +	ops = dev_iommu_ops(dev);
> +	if (!ops->blocked_domain) {
> +		dev_warn(dev,
> +			 "IOMMU driver doesn't support IOMMU_DOMAIN_BLOCKED\n");
> +		ret = -EOPNOTSUPP;
> +		goto unlock;
> +	}
> +
> +	device_to_group_device(dev)->pending_reset = true;
> +
> +	/* Device is already attached to the blocked_domain. Nothing to do */
> +	if (group->domain->type == IOMMU_DOMAIN_BLOCKED)
> +		goto unlock;

"group->domain->type == IOMMU_DOMAIN_BLOCKED" means that IOMMU_NO_PASID
is docked in the blocking DMA state, but it doesn't imply that other
PASIDs are also in the blocking DMA state. Therefore, we might still
need the following lines to handle other PASIDs.

On the other hand, perhaps we should use "group->domain == ops-
 >blocked_domain" instead of "group->domain->type ==
IOMMU_DOMAIN_BLOCKED" to make the code consistent with the commit
message.

> +
> +	/* Dock RID domain to blocked_domain while retaining group->domain */
> +	ret = __iommu_attach_device(ops->blocked_domain, dev);
> +	if (ret)
> +		goto unlock;
> +
> +	/* Dock PASID domains to blocked_domain while retaining pasid_array */
> +	xa_lock(&group->pasid_array);
> +	xa_for_each_start(&group->pasid_array, pasid, entry, 1)
> +		iommu_remove_dev_pasid(dev, pasid,
> +				       pasid_array_entry_to_domain(entry));
> +	xa_unlock(&group->pasid_array);
> +
> +unlock:
> +	mutex_unlock(&group->mutex);
> +	if (ret)
> +		iommu_group_put(group);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(iommu_dev_reset_prepare);
> +
> +/*
> + * Pair with a previous iommu_dev_reset_prepare() that was successfully returned
> + *
> + * Note that, although unlikely, there is a risk that re-attaching domains might
> + * fail due to some unexpected happening like OOM.
> + */
> +void iommu_dev_reset_done(struct device *dev)
> +{
> +	struct iommu_group *group = dev->iommu_group;
> +	const struct iommu_ops *ops;
> +	struct group_device *gdev;
> +	unsigned long pasid;
> +	void *entry;
> +
> +	if (!dev_has_iommu(dev))
> +		return;
> +
> +	mutex_lock(&group->mutex);
> +
> +	gdev = device_to_group_device(dev);
> +
> +	ops = dev_iommu_ops(dev);
> +	/* iommu_dev_reset_prepare() was not successfully called */
> +	if (WARN_ON(!ops->blocked_domain || !gdev->pending_reset)) {
> +		mutex_unlock(&group->mutex);
> +		return;
> +	}
> +
> +	if (group->domain->type == IOMMU_DOMAIN_BLOCKED)
> +		goto done;

The same here?

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
> +done:
> +	gdev->pending_reset = false;
> +	mutex_unlock(&group->mutex);
> +	iommu_group_put(group);
> +}
> +EXPORT_SYMBOL_GPL(iommu_dev_reset_done);
> +
>   #if IS_ENABLED(CONFIG_IRQ_MSI_IOMMU)
>   /**
>    * iommu_dma_prepare_msi() - Map the MSI page in the IOMMU domain

Thanks,
baolu

