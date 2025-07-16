Return-Path: <linux-pci+bounces-32283-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86092B07A64
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 17:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E42037BD426
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 15:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5CB828CF5E;
	Wed, 16 Jul 2025 15:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c0oZpu+3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C335718C31
	for <linux-pci@vger.kernel.org>; Wed, 16 Jul 2025 15:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752680996; cv=none; b=aPeADLcxCqqKHA+kV/AcZp2Ag/qSNbmynrImVuLD+zeWZfjOQ6lSvcmZv2p3SPhsRW7lS83hbt6kNZVuXmqATElyVmu3o2zoufbakWysveWBSL6N4lMd4NhJLK9TPgXX/YSkY//CSIcN6eCzzihvzGhcGTQ7EY05fCb5coUUgqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752680996; c=relaxed/simple;
	bh=d8bIZEoOc3jrJGXwR2ME/KuxgYazpLRM9/EKo+NWMC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oJWYwwub7tarx/kVcSUsihm8kh3bz5HgbAaSg6MUS03gg/rtDhlN4fAXX6V5QhO8EJ16WGocLlOmpN7CJt26CeJrY2ZBb4UP3dUbpCeBg3TqDdLqlkvfDOyxO+e81SupH84MEtdh26fnMEty4QUgnU1xjzBZ9kEFoUGWjqjbg3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c0oZpu+3; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752680995; x=1784216995;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=d8bIZEoOc3jrJGXwR2ME/KuxgYazpLRM9/EKo+NWMC4=;
  b=c0oZpu+3BNu+nOQfRGljC4lyAs5O0z1Xkp2989DO8FrwOwl2qNZFJOE7
   dUWymrrDcFsaAwKxlVjsoVL3exArY+AsvsjF0Uw67K28kHjG2apZnn6r3
   WlyQidERhwIJHWwa6CqJqS0iEweFwnGgCy0a4WIcoOIZpYQz/mFRRBhce
   TE8o5Wl0ZHJWybi8VKQXw+gb2KYkgvG145bDJcPT+KQq3/M64HwEz5va5
   46R38BfEyP1hYEoCXpD3iLvSu6R+WKMjkfwUMZZS7zkua0Ei+7j38Jjmd
   CFminsjc0HKYwIOlG1bao6tj56/3LDBIP0PpKF7QPjXRZLRq7OP2qmNh1
   w==;
X-CSE-ConnectionGUID: ANtBkQ8DSmmZE/yBVY7EYA==
X-CSE-MsgGUID: +tMpOVSYRfq6x8BTQsmLbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="54807198"
X-IronPort-AV: E=Sophos;i="6.16,316,1744095600"; 
   d="scan'208";a="54807198"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 08:49:54 -0700
X-CSE-ConnectionGUID: Cgjm5PMzTFek6bbg55HZSA==
X-CSE-MsgGUID: q1AYjqN5T1OKd2CXUBNxxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,316,1744095600"; 
   d="scan'208";a="157895131"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa009.fm.intel.com with ESMTP; 16 Jul 2025 08:49:51 -0700
Date: Wed, 16 Jul 2025 23:41:12 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org, gregkh@linuxfoundation.org,
	lukas@wunner.de, suzuki.poulose@arm.com, sameo@rivosinc.com,
	zhiw@nvidia.com
Subject: Re: [RFC PATCH 3/3] iommufd/tsm: Add tsm_bind/unbind iommufd ioctls
Message-ID: <aHfIGJzqv+4XiO7f@yilunxu-OptiPlex-7050>
References: <yq5a5xhj5yng.fsf@kernel.org>
 <20250529133757.462088-1-aneesh.kumar@kernel.org>
 <20250529133757.462088-3-aneesh.kumar@kernel.org>
 <aHYtj/jyfXD4XhZy@yilunxu-OptiPlex-7050>
 <20250715130949.GM2067380@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715130949.GM2067380@nvidia.com>

On Tue, Jul 15, 2025 at 10:09:49AM -0300, Jason Gunthorpe wrote:
> On Tue, Jul 15, 2025 at 06:29:35PM +0800, Xu Yilun wrote:
> > On Thu, May 29, 2025 at 07:07:56PM +0530, Aneesh Kumar K.V (Arm) wrote:
> > > Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> > > ---
> > >  drivers/iommu/iommufd/iommufd_private.h |  3 +
> > >  drivers/iommu/iommufd/main.c            |  5 ++
> > >  drivers/iommu/iommufd/viommu.c          | 78 +++++++++++++++++++++++++
> > >  include/uapi/linux/iommufd.h            | 15 +++++
> > >  4 files changed, 101 insertions(+)
> > > 
> > > diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
> > > index 80e8c76d25f2..a323e8b18125 100644
> > > --- a/drivers/iommu/iommufd/iommufd_private.h
> > > +++ b/drivers/iommu/iommufd/iommufd_private.h
> > > @@ -606,6 +606,8 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd);
> > >  void iommufd_viommu_destroy(struct iommufd_object *obj);
> > >  int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd);
> > >  void iommufd_vdevice_destroy(struct iommufd_object *obj);
> > > +int iommufd_vdevice_tsm_bind_ioctl(struct iommufd_ucmd *ucmd);
> > > +int iommufd_vdevice_tsm_unbind_ioctl(struct iommufd_ucmd *ucmd);
> > 
> > Hello:
> > 
> > I recently have another concern about the vdevice tsm bind/unbind API.
> > And need your inputs.
> > 
> > According to this:
> > https://lore.kernel.org/all/aC9QPoEUw_nLHhV4@google.com/
> > 
> > Sean illustrates the memory in-place conversion, that the memory
> > owner - gmemfd should own & control the memory shareability) and
> > the conversion. I.e. For in-place conversion,
> > KVM_SET_MEMORY_ATTRIBUTES should be disabled.
> > 
> > Private/shared MMIO must be of in-place conversion, similarly it's
> > the MMIO owner should be responsible for MMIO shareability, maybe adding
> > some new ioctls like MMIO_CONVERT_SHARED/PRIVATE.
> 
> Except it doesn't work like that for MMIO. Shared/private is a TDI
> operation only and effects the whole device. We shouldn't split it
> into two actions.

OK. IIUC you want 1 uAPI, TSM Bind, to finish all secure configuration,
including MMIO sharebility. I think it is possible, the MMIO shareability
is fixed after TSM Bind. iommufd could fetch TDI report to get the
private/shared MMIO ranges and callback to VFIO.

> 
> I also don't think it needs to be strictly 'in-place' as we expect the

When I said "must be in-place", I mean the MMIO resource (hpa) for one gfn is
fixed, can't have 2 copies of backend as the current private/shared
memory does.

> VM to be idle on the MMIO during this change over. Faulting would be OK.

Sorry, I don't get your point about 'strictly in-place' here?

> 
> > From previous discussion, VFIO is the MMIO owner (implement as dmabuf
> > exporter), so manages MMIO shareability. And IOMMUFD vdevice is the TDI
> > state owner for TSM bind/unbind. But MMIO shareability & TDI state are
> > actually correlated, do we really want to manage them in 2 components?
> 
> Yes, we've been over this. There are two components, we have to split
> it somehow. It makes more sense for iommufd to lead the ioctls because
> it has more information about the full system.
> 
> Any case where we need to get back to vfio for something needs to be
> managed with a callback of some kind. We need to get a list of what
> those things are.
> 
> What do all the arches need here?
>  - ARM I suspect has the TDI locking operation install the MMIO in the
>    secure S2, not KVM?
>  - AMD just leaves the MMIO mapped all the time?
>  - x86 presumably needs to carefully map/unmap to KVM and iommu in the
>    right sequence or you get a MCE?

Yeah, for Intel TDX, basically 2 things, zap the mapping on opposite side
page table, mark the correct shareability for correct fault in.

> 
> So what is the plan? You want to wrap this in DMABUF, but will there
> be two DMABUFS, one for secure and one for non-secure? Is userspace

No I don't expect 2 dmabufs. I image shareability could be an physical
attribute of dmabuf and the callback to VFIO changes the shareability.
And VFIO, the dmabuf exporter, could notify KVM/iommufd about the
shareability change. Then KVM/iommufd unmaps their page tables.

Thanks,
Yilun

> expected to map/unmap in the right sequence?
> 
> Something else?
> 
> Jason

