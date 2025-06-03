Return-Path: <linux-pci+bounces-28852-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34210ACC4BF
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 12:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E764D165E0A
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 10:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE2922B8B0;
	Tue,  3 Jun 2025 10:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MaFwDmo1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBBA22ACF3
	for <linux-pci@vger.kernel.org>; Tue,  3 Jun 2025 10:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748948211; cv=none; b=mLyaWh8+K2gg/PPCihniwTadujS8sUzmKRw1Xi4XUv7YPMRA2++O3vcYjIETPWdN54/YamxCF+XMWfdSgSpGiN5pGQWV5Kyg6kJDprqSRGkIfKLiIxHnOWC6TMOjNhpYYWw26bBkgo7SVxfdlQ4zyQrp9qHUhUex56IWwNYYC34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748948211; c=relaxed/simple;
	bh=l4EVEbozJyY+ughiuK7BCXFZ/p6lHgiVcgDOC1HMZJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N0+YLR0/tmsh0tbx2ON0w0b+VW+Dee9UpmgBRXRh4LYpBLIqg2sj6PVHYICRMEFP/3UCDve6yAPAiwvaDUj9HY3KcSR//rbFaDutvGKgL4FIOmBqLbPLB5xlqTGD+Gn//Oh1Z7o9vamSeNR+B72xYj6RdtVM1ICFFnCfAPUDlh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MaFwDmo1; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748948210; x=1780484210;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=l4EVEbozJyY+ughiuK7BCXFZ/p6lHgiVcgDOC1HMZJA=;
  b=MaFwDmo1ScQnCCIf38XwVafhwrV9mSOlotP6OANsx6CMPeOgfza0BqD2
   pCJrAzM7EroDZWu4dWErU6qN4QH/NurHehS2n3TeMARYBS4nF3Lp1gMwP
   +yA85ezcxptYG/UqKwvPZd70wBQ1wGTJq5YicHe5ZBdJdyxE6PyVMJsW/
   zHguRzYOPnf4iuAd5DzuJjY9HXtWm8Z9iGvKDPbs0Jpv0w7OQ/6mmRbCn
   cBba8cpzJSHzsvpslfkQS8vctc/3drJzl74M95edqbY6D1DBtmBZKJKCP
   JIK3bMU/+61CBGAzHvdU3ldS4Hrl+slveGdrqdEyeu4674gLxHYA2GadR
   g==;
X-CSE-ConnectionGUID: RV+w4UTPTbKb+P8l+NO4sQ==
X-CSE-MsgGUID: Rt5bLNdyTJOjZUmlNnIQ9A==
X-IronPort-AV: E=McAfee;i="6700,10204,11451"; a="61602370"
X-IronPort-AV: E=Sophos;i="6.16,205,1744095600"; 
   d="scan'208";a="61602370"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 03:56:49 -0700
X-CSE-ConnectionGUID: jb8pVdOSTA6RUjtySVLAYw==
X-CSE-MsgGUID: Q8VkzE+mQZCe+dpiaGH8LQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; 
   d="scan'208";a="149596483"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa003.jf.intel.com with ESMTP; 03 Jun 2025 03:56:45 -0700
Date: Tue, 3 Jun 2025 18:50:13 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org, gregkh@linuxfoundation.org,
	lukas@wunner.de, suzuki.poulose@arm.com, sameo@rivosinc.com,
	jgg@nvidia.com, zhiw@nvidia.com
Subject: Re: [RFC PATCH 3/3] iommufd/tsm: Add tsm_bind/unbind iommufd ioctls
Message-ID: <aD7TZRnFualizeXk@yilunxu-OptiPlex-7050>
References: <yq5a5xhj5yng.fsf@kernel.org>
 <20250529133757.462088-1-aneesh.kumar@kernel.org>
 <20250529133757.462088-3-aneesh.kumar@kernel.org>
 <aDsta4UX76GaExrO@yilunxu-OptiPlex-7050>
 <yq5azfeqjt9i.fsf@kernel.org>
 <aD3QcQxtjoYXrglM@yilunxu-OptiPlex-7050>
 <yq5ao6v5ju6p.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yq5ao6v5ju6p.fsf@kernel.org>

On Tue, Jun 03, 2025 at 10:30:30AM +0530, Aneesh Kumar K.V wrote:
> Xu Yilun <yilun.xu@linux.intel.com> writes:
> 
> > On Mon, Jun 02, 2025 at 04:38:09PM +0530, Aneesh Kumar K.V wrote:
> >> Xu Yilun <yilun.xu@linux.intel.com> writes:
> >> 
> >> >> + * struct iommu_vdevice_id - ioctl(IOMMU_VDEVICE_TSM_BIND/UNBIND)
> >> >> + * @size: sizeof(struct iommu_vdevice_id)
> >> >> + * @vdevice_id: Object handle for the vDevice. Returned from IOMMU_VDEVICE_ALLOC
> >> >> + */
> >> >> +struct iommu_vdevice_id {
> >> >> +	__u32 size;
> >> >> +	__u32 vdevice_id;
> >> >> +} __packed;
> >> >> +#define IOMMU_VDEVICE_TSM_BIND _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VDEVICE_TSM_BIND)
> >> >> +#define IOMMU_VDEVICE_TSM_UNBIND _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VDEVICE_TSM_UNBIND)
> >> >
> >> > Hello, I see you are talking about the detailed implementation. But
> >> > could we firstly address the confusing whether this TSM Bind/Unbind
> >> > should be a VFIO uAPI or IOMMUFD uAPI?
> >> >
> >> > In this thread [1], I was talking about TSM Bind/Unbind affects VFIO
> >> > behavior so they cannot be iommufd uAPIs which VFIO is not aware of.
> >> > At least TDX Connect cares about this problem now. And the conclusion
> >> > seems to be "have a VFIO_DEVICE_BIND(iommufd vdevice id), then have
> >> > VFIO reach into iommufd".
> >> >
> >> > And some further findings [2] indicate this problem may also exist on
> >> > AMD when p2p is involved.
> >> >
> >> > [1]: https://lore.kernel.org/all/20250515175658.GR382960@nvidia.com/
> >> > [2]: https://lore.kernel.org/all/aDnXxk46kwrOcl0i@yilunxu-OptiPlex-7050/
> >> >
> >> 
> >> Looking at your patch series, I understand the reason you need a vfio
> >> ioctl is to call pci_request_regions_exclusive—is that correct?
> >
> > The immediate reason is to unbind the TDI before unmapping the BAR.
> >
> >> 
> >> In another thread, I asked whether this might be better handled by
> >> pci_tsm instead of vfio. I'd be interested in your thoughts on that.
> >> 
> >> I also noticed you want to unbind the TDI before unmapping the BAR in
> >> vfio. From what I understand, this should still be possible if we use an
> >> iommufd ioctl.
> >
> > I'm not sure how is that possible.
> >
> 
> IIUC, what you need is the below interface
> int iommufd_device_tsm_unbind(struct iommufd_device *idev) so that vfio
> can use vfio_iommufd_tsm_unbind() -> 	iommufd_device_tsm_unbind(vdev->iommufd_device);

I see. But I'm not sure if it can be a better story than ioctl(VFIO_TSM_BIND).
You want VFIO unaware of TSM bind, e.g. try to hide pci_request/release_region(),
but make VFIO aware of TSM unbind, which seems odd ...

Thanks,
Yilun

> 
> The below iommufd changes can get that
> 
> static struct mutex *vdev_lock(struct iommufd_vdevice *vdev)
> {
> 	if (mutex_lock_interruptible(&vdev->mutex) != 0)
> 		return NULL;
> 	return &vdev->mutex;
> }
> DEFINE_FREE(vdev_unlock, struct mutex *, if (_T) mutex_unlock(_T))
> 
> static struct mutex *idev_lock(struct iommufd_device *idev)
> {
> 	if (mutex_lock_interruptible(&idev->igroup->lock) != 0)
> 		return NULL;
> 	return &idev->igroup->lock;
> }
> DEFINE_FREE(idev_unlock, struct mutex *, if (_T) mutex_unlock(_T))
> 
> int iommufd_vdevice_tsm_bind_ioctl(struct iommufd_ucmd *ucmd)
> {
> 	struct iommu_vdevice_tsm_bind *cmd = ucmd->cmd;
> 	struct iommufd_vdevice *vdev;
> 	struct iommufd_device *idev;
> 	struct mutex *ilock __free(idev_unlock) = NULL;
> 	struct mutex *vlock __free(vdev_unlock) = NULL;
> 	struct kvm *kvm;
> 	int rc = 0;
> 
> 	if (cmd->flags)
> 		return -EOPNOTSUPP;
> 
> 	idev = iommufd_get_device(ucmd, cmd->dev_id);
> 	if (IS_ERR(idev))
> 		return PTR_ERR(idev);
> 
> 	vdev = container_of(iommufd_get_object(ucmd->ictx, cmd->vdevice_id,
> 					       IOMMUFD_OBJ_VDEVICE),
> 			    struct iommufd_vdevice, obj);
> 	if (IS_ERR(vdev)) {
> 		rc = PTR_ERR(vdev);
> 		goto out_put_idev;
> 	}
> 
> 	ilock = idev_lock(idev);
> 	if (!ilock) {
> 		rc = -EINTR;
> 		goto out_put_vdev;
> 	}
> 
> 	if (idev->vdev) {
> 		/* if it is already bound */
> 		rc = -EINVAL;
> 		goto out_put_vdev;
> 	}
> 
> 	vlock = vdev_lock(vdev);
> 	if (!vlock) {
> 		rc = -EINTR;
> 		goto out_put_vdev;
> 	}
> 
> 	if (WARN_ON(vdev->idev)) {
> 		rc = -EINVAL;
> 		goto out_put_vdev;
> 	}
> 
> 	kvm = vdev->viommu->kvm_filp->private_data;
> 	if (kvm) {
> 		/*
> 		 * tsm layer will make take care of parallel calls to tsm_bind/unbind
> 		 */
> 		rc = tsm_bind(vdev->dev, kvm, vdev->id);
> 		if (rc) {
> 			rc = -ENODEV;
> 			goto out_put_vdev;
> 		}
> 	} else {
> 		rc = -ENODEV;
> 		goto out_put_vdev;
> 	}
> 	idev->vdev = vdev;
> 	vdev->idev = idev;
> 	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
> 
> out_put_idev:
> 	iommufd_put_object(ucmd->ictx, &idev->obj);
> out_put_vdev:
> 	iommufd_put_object(ucmd->ictx, &vdev->obj);
> 	return rc;
> }
> 
> static int iommufd_vdevice_tsm_unbind(struct iommufd_vdevice *vdev)
> {
> 	int rc = -EINVAL;
> 	struct mutex *lock __free(vdev_unlock) = vdev_lock(vdev);
> 	if (!lock)
> 		return -EINTR;
> 
> 	if (!vdev->idev) {
> 		tsm_unbind(vdev->dev);
> 		vdev->idev = NULL;
> 		rc = 0;
> 	}
> 	return rc;
> }
> 
> /**
>  * iommufd_device_tsm_unbind - Move a device out of TSM bind state
>  * @idev: device to detach
>  *
>  * Undo iommufd_device_tsm_bind(). This removes all Confidential Computing
>  * configurations, Once this completes the device is unlocked (TDISP
>  * CONFIG_UNLOCKED).
>  */
> int iommufd_device_tsm_unbind(struct iommufd_device *idev)
> {
> 	struct mutex *lock __free(idev_unlock) = idev_lock(idev);
> 	if (!lock)
> 		return -EINTR;
> 
> 	if (!idev->vdev)
> 		return -EINVAL;
> 
> 	iommufd_vdevice_tsm_unbind(idev->vdev);
> 	idev->vdev = NULL;
> 	return 0;
> }
> EXPORT_SYMBOL_NS_GPL(iommufd_device_tsm_unbind, "IOMMUFD");
> 
> int iommufd_vdevice_tsm_unbind_ioctl(struct iommufd_ucmd *ucmd)
> {
> 	struct iommu_vdevice_tsm_unbind *cmd = ucmd->cmd;
> 	struct iommufd_vdevice *vdev;
> 	int rc = 0;
> 
> 	vdev = container_of(iommufd_get_object(ucmd->ictx, cmd->vdevice_id,
> 					       IOMMUFD_OBJ_VDEVICE),
> 			    struct iommufd_vdevice, obj);
> 	if (IS_ERR(vdev))
> 		return PTR_ERR(vdev);
> 
> 	rc = iommufd_device_tsm_unbind(vdev->idev);
> 	if (rc) {
> 		rc = -ENODEV;
> 		goto out_put_vdev;
> 	}
> 	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
> 
> out_put_vdev:
> 	iommufd_put_object(ucmd->ictx, &vdev->obj);
> 	return rc;
> }
> 

