Return-Path: <linux-pci+bounces-28934-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC830ACD773
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 07:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 521901777E4
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 05:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC62266F0A;
	Wed,  4 Jun 2025 05:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V+CgMMa8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35621266B4D
	for <linux-pci@vger.kernel.org>; Wed,  4 Jun 2025 05:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749013758; cv=none; b=MhthWZK3z0krZOPBDt4K2agnFVFgM6F+BdiXaaJEW64rhl1hSEKT+Wmz4C1pdmh+RMlLFN/p7SN5idO6QecNX23MIj1PiDLVwy2diapFacVTHRtxfWpLvytTZ+Xruj2L37kk8cgkdlwj/u/wyeTLo2Y3kFTgckvYnaLIe4XoBUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749013758; c=relaxed/simple;
	bh=zgPO/d+rYjsks1gaWFwARq/0hghlYVlOHFCWZ0+VsF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gWbc+jhq/UYCKgvns8ODpwY266GZ/g+tBS26LX6jX/niHR1GPeEcjobF/0EqeWcp/+pwWIFymQNUXKs792oM/DB1DNGYyFGKSX7qlqIPMwaPRFhVua6yrT2y/ksuZsHTka38FKne8aRq0VOjWUCCCPlw3KCGh6KhknvopqZQzE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V+CgMMa8; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749013758; x=1780549758;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zgPO/d+rYjsks1gaWFwARq/0hghlYVlOHFCWZ0+VsF4=;
  b=V+CgMMa8nkcYIjNjuJ6Sr/7sLKYaJEm3cKBh+UuHUrIUPb3Qva+MMS6o
   Po2lX2zh466ZeWLhGydmql+xQ0N5myzTEF8TXa/5x1wrXIPq1wX14WKUw
   Q+Foypbw0lxR9hv1jI3r3KOlhKfF27/qtOWkXVUPon9vdWDXTZx4MJCpS
   2fDXg0AeE9iKRWwb/9HdiXuvTrRWUVb/yaXgD8Z8HiW9GDRfAPOX8f1wK
   wkf1Df28yhs2Mm4++6F1NS9bKteW8SaX7eiuKg4MRf03WRXgJuhYNR/xQ
   KLZsAN5sp1hIJNVfR8E6kLJEm+MggDGthQuHgFv6PJwSR2/TvCew2RQ5m
   w==;
X-CSE-ConnectionGUID: je40dVmXRzG6JKJRfDYNjg==
X-CSE-MsgGUID: wCh0Mth4RzyI2ZQxGTnCuA==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="62468979"
X-IronPort-AV: E=Sophos;i="6.16,208,1744095600"; 
   d="scan'208";a="62468979"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 22:09:17 -0700
X-CSE-ConnectionGUID: rhhStxjeSZC3lorpLPbo6A==
X-CSE-MsgGUID: JdY90XnDQ86sOkqF1vtI7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,208,1744095600"; 
   d="scan'208";a="146019699"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa009.fm.intel.com with ESMTP; 03 Jun 2025 22:09:13 -0700
Date: Wed, 4 Jun 2025 13:02:39 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org, gregkh@linuxfoundation.org,
	lukas@wunner.de, suzuki.poulose@arm.com, sameo@rivosinc.com,
	jgg@nvidia.com, zhiw@nvidia.com
Subject: Re: [RFC PATCH 3/3] iommufd/tsm: Add tsm_bind/unbind iommufd ioctls
Message-ID: <aD/TbzFiJXnByPxy@yilunxu-OptiPlex-7050>
References: <yq5a5xhj5yng.fsf@kernel.org>
 <20250529133757.462088-1-aneesh.kumar@kernel.org>
 <20250529133757.462088-3-aneesh.kumar@kernel.org>
 <aDsta4UX76GaExrO@yilunxu-OptiPlex-7050>
 <668b023e-d299-42e1-87fc-ec83c514374e@amd.com>
 <aD3clPC8QfL1/XYF@yilunxu-OptiPlex-7050>
 <c552a298-0dde-409d-9c2d-149b2e2389bf@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c552a298-0dde-409d-9c2d-149b2e2389bf@amd.com>

On Wed, Jun 04, 2025 at 11:47:14AM +1000, Alexey Kardashevskiy wrote:
> 
> 
> On 3/6/25 03:17, Xu Yilun wrote:
> > On Mon, Jun 02, 2025 at 02:52:52PM +1000, Alexey Kardashevskiy wrote:
> > > 
> > > 
> > > On 1/6/25 02:25, Xu Yilun wrote:
> > > > > + * struct iommu_vdevice_id - ioctl(IOMMU_VDEVICE_TSM_BIND/UNBIND)
> > > > > + * @size: sizeof(struct iommu_vdevice_id)
> > > > > + * @vdevice_id: Object handle for the vDevice. Returned from IOMMU_VDEVICE_ALLOC
> > > > > + */
> > > > > +struct iommu_vdevice_id {
> > > > > +	__u32 size;
> > > > > +	__u32 vdevice_id;
> > > > > +} __packed;
> > > > > +#define IOMMU_VDEVICE_TSM_BIND _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VDEVICE_TSM_BIND)
> > > > > +#define IOMMU_VDEVICE_TSM_UNBIND _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VDEVICE_TSM_UNBIND)
> > > > 
> > > > Hello, I see you are talking about the detailed implementation. But
> > > > could we firstly address the confusing whether this TSM Bind/Unbind
> > > > should be a VFIO uAPI or IOMMUFD uAPI?
> > > > 
> > > > In this thread [1], I was talking about TSM Bind/Unbind affects VFIO
> > > > behavior so they cannot be iommufd uAPIs which VFIO is not aware of.
> > > 
> > > 
> > > What will the host VFIO-PCI driver do differently? I only remember "stop mmaping to the userspace", is that all?
> > 
> > And do unbind before zapping MMIO.
> 
> > > Or, more to the point, what is that exact thing which cannot be done from QEMU? Thanks,
> > 
> > But kernel don't want incorrect userspace calls crash kernel, e.g. VFIO
> > zaps MMIO on TDI bound then KVM just crashes. So you need to check if
> > zapping MMIOs are allowed in VFIO, that means VFIO still needs to know
> > if device is bound.  Scatter BIND/UNBIND & other device controls in both
> > IOMMUFD & VFIO makes life harder.
> 
> I am confused. What is that userspace call, ioctl(VFIO_DEVICE_RESET)?

Yes, this can be one.

> The userspace (==QEMU) knows it is bound and can unbind first, no?

The userspace can, this is the case of correct userspace call. There are
other cases of incorrect userspace call, e.g. QEMU doesn't unbind first
and just call ioctl(VFIO_DEVICE_RESET).

Thanks,
Yilun

> 
> If it is the case of killing QEMU - then there is no usespace and then it is a matter of what fd is closed first - VFIO-PCI or IOMMUFD, we could teach IOMMUFD to hold an VFIO-PCI fd to guarantee the order. Thanks,
> 
> 
> 
> > 
> > Thanks,
> > Yilun
> 
> -- 
> Alexey
> 
> 

