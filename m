Return-Path: <linux-pci+bounces-28826-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8888ACBEFA
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 05:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 738083A1F78
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 03:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA382C3272;
	Tue,  3 Jun 2025 03:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IJe1NkhV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD04F4A35
	for <linux-pci@vger.kernel.org>; Tue,  3 Jun 2025 03:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748922850; cv=none; b=JHCmZ7cT2IGGfS6wq2tcDiP0coxcZZXSO01goT4BQWKZosN+uix7uANkejl/dOHDCOHx72j5KJRN6C/kF59iC1Cnq/g0qSpEjFQk4BIlJvQXtYMJHfNUkRNFi/uWkE+B/DCoMassj6jcnCJZgd5AjcnvQ3f0gFmpCNZFtU9oyyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748922850; c=relaxed/simple;
	bh=wmmFFw7r9mJQxkXAdoG0HWfpleB3rtUXQJSQn706EiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p0VUHjLfppKUBXAsCLdRtoYzse77GN70ySuYz6mjCYA/vxh5P2relrjmpqFtFUk884LEh2oV+kipyrTLz50T5L2ct2kkKMhCC3BFkqsobtS48WSh720A8QR35ZyjVJdyXiRQjy+g7H7dWD3TqNiz5kzgC+9P1fB42nBP9uZAWRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IJe1NkhV; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748922849; x=1780458849;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wmmFFw7r9mJQxkXAdoG0HWfpleB3rtUXQJSQn706EiY=;
  b=IJe1NkhVvUqYqnKIO5hKJjYrGpJ2scEGvyN9DKZDcsW13um5q+KM7kFD
   GpS/9hrMzO+XW5ar+Xsq0zeATDAD93NNjHiNtPvtxrLzGUNYoloxZSIkB
   +7cTZc9hkwkdtCSDpg7fK0H8Y+ze4+y6+4FxJXciW6l56hUIG6Yb/yyBy
   hisN5lA5lgk7HdBHrCehEhUGUzMilsFEZGHO5c6zh8C2z6xZvM/nPGF/K
   evLW183pb2iBVF8Ul/2Xs8etjZ9on/Ir7ju5lIk1WFtCael5pP9CklKKp
   kPRTapOT6MV/8ahsLe/N04Wrl6Ffm2u/ui20WVyKACYGT9BrDtmn+D1/y
   A==;
X-CSE-ConnectionGUID: 8yCm6aQCRlm4qSYXMDSS+g==
X-CSE-MsgGUID: No+Y8U1BRdSM/1lCeCM22A==
X-IronPort-AV: E=McAfee;i="6700,10204,11451"; a="53576454"
X-IronPort-AV: E=Sophos;i="6.16,205,1744095600"; 
   d="scan'208";a="53576454"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2025 20:54:08 -0700
X-CSE-ConnectionGUID: 1g8QF+nnQE+YaTe+IXtwlg==
X-CSE-MsgGUID: ++SWRb+uScyHjnrxYDsVSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,205,1744095600"; 
   d="scan'208";a="144707859"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa010.jf.intel.com with ESMTP; 02 Jun 2025 20:54:06 -0700
Date: Tue, 3 Jun 2025 11:47:33 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org, gregkh@linuxfoundation.org,
	lukas@wunner.de, suzuki.poulose@arm.com, sameo@rivosinc.com,
	zhiw@nvidia.com
Subject: Re: [RFC PATCH 3/3] iommufd/tsm: Add tsm_bind/unbind iommufd ioctls
Message-ID: <aD5wVXINV1QJnMbO@yilunxu-OptiPlex-7050>
References: <yq5a5xhj5yng.fsf@kernel.org>
 <20250529133757.462088-1-aneesh.kumar@kernel.org>
 <20250529133757.462088-3-aneesh.kumar@kernel.org>
 <aDsta4UX76GaExrO@yilunxu-OptiPlex-7050>
 <20250602124718.GY233377@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250602124718.GY233377@nvidia.com>

On Mon, Jun 02, 2025 at 09:47:18AM -0300, Jason Gunthorpe wrote:
> On Sun, Jun 01, 2025 at 12:25:15AM +0800, Xu Yilun wrote:
> > > + * struct iommu_vdevice_id - ioctl(IOMMU_VDEVICE_TSM_BIND/UNBIND)
> > > + * @size: sizeof(struct iommu_vdevice_id)
> > > + * @vdevice_id: Object handle for the vDevice. Returned from IOMMU_VDEVICE_ALLOC
> > > + */
> > > +struct iommu_vdevice_id {
> > > +	__u32 size;
> > > +	__u32 vdevice_id;
> > > +} __packed;
> > > +#define IOMMU_VDEVICE_TSM_BIND _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VDEVICE_TSM_BIND)
> > > +#define IOMMU_VDEVICE_TSM_UNBIND _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VDEVICE_TSM_UNBIND)
> > 
> > Hello, I see you are talking about the detailed implementation. But
> > could we firstly address the confusing whether this TSM Bind/Unbind
> > should be a VFIO uAPI or IOMMUFD uAPI?
> 
> I thought you guys had moved past that?

Not yet.

> VFIO doesn't have enough
> information so iommufd would be a better place to make the call?

VFIO doesn't have enough information, but VFIO needs to know about
bound state. So comes the suggestion [1] that the VFIO uAPI, then VFIO
reach into iommufd for real bind.

And my implementation [2] is:

ioctl(vfio_cdev_fd, VFIO_DEVICE_TSM_BIND)
-> vfio_iommufd_tsm_bind()
   -> iommufd_device_tsm_bind()
      -> iommufd_vdevice_tsm_bind()
         -> pci_tsm_bind()

[2]: https://lore.kernel.org/all/20250529053513.1592088-1-yilun.xu@linux.intel.com/


> In this thread [1], I was talking about TSM Bind/Unbind affects VFIO
> behavior so they cannot be iommufd uAPIs which VFIO is not aware of.
> At least TDX Connect cares about this problem now. And the conclusion
> seems to be "have a VFIO_DEVICE_BIND(iommufd vdevice id), then have
> VFIO reach into iommufd".
>
> And some further findings [2] indicate this problem may also exist on
> AMD when p2p is involved.
>
> [1]: https://lore.kernel.org/all/20250515175658.GR382960@nvidia.com/


> 
> Jason

