Return-Path: <linux-pci+bounces-29196-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC30AD1828
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 06:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E80951888A71
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 04:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC5227FD50;
	Mon,  9 Jun 2025 04:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QnrC7r/f"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3471A27F75C
	for <linux-pci@vger.kernel.org>; Mon,  9 Jun 2025 04:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749444837; cv=none; b=FA1NkRMXv+aQGhOsBk7GVvueLvxttpLqMZ0IbRCssX4bv3IKmn62hf3yav/ljqu8fx8mBsZk6VQikxqMCmWQ+ZrUodk2qF7Xcx/0vbxBOML5/MFK5iCxTzOR2EItZVA5Wz379EP3nfzvus2LRmAUEkEwjkOpHs7zWtPCIDN2zjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749444837; c=relaxed/simple;
	bh=Ff2Bgb/4eaoKrotBTr8PjdJW8R2o12LPFMIYVZ9LZFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AP9bTJl76HiNrKOd45/TDFj/mP+voAbrHd0M3zqul0/xuX65Q2q+AEkW0o3tEU6nuS3LpAfSO6Jj++wnAI2fOUAJ556BNsmqD98nI0ac/pAqoZUTenXDIuUvf526IdIRVQQwxUiGsDVEig/QUk9KHVQvXLl35JHlaPv3iFxjmjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QnrC7r/f; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749444836; x=1780980836;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ff2Bgb/4eaoKrotBTr8PjdJW8R2o12LPFMIYVZ9LZFo=;
  b=QnrC7r/f21NJS69vS7eiDafeZyLzuKvAl1cIZMo7LaqocDWVdN8UOZ/G
   0cZihmo2CTWYbQC0c8ti0xvDIN/WZXBfHsu3b8a6xxYLS+Mi8dG91des5
   b0BnBXOn6HPfcaZrNGQmg/tFpHfD+oIT8Or7VOYCU+/c6gkTD7vJTxfVe
   K7ibpEgKM0Cau3Uf3ak+5vZtv7gCtT+bdX96uDRKWTbAn1VN42OpwtfJA
   8lh0ZfE9AlT/eBuC4yGDeqnkyGAfxpxbm2mH/Lhja+9+7sE8Vhj882Qia
   ffDaC2SeapcBxdQP1xRK0c3qv/UV5cZD4izx9M/5ZL/j8kmReWj/hew1O
   g==;
X-CSE-ConnectionGUID: LrrbxKHXSIKlb0zyOT0Tvg==
X-CSE-MsgGUID: bEhnJMljQXi+7C0mZFeVbw==
X-IronPort-AV: E=McAfee;i="6800,10657,11458"; a="62868353"
X-IronPort-AV: E=Sophos;i="6.16,221,1744095600"; 
   d="scan'208";a="62868353"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2025 21:53:56 -0700
X-CSE-ConnectionGUID: uNw3HGKlTXiE04d/4jWqJw==
X-CSE-MsgGUID: j28t0H3pSxKw4iDAVo7NQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,221,1744095600"; 
   d="scan'208";a="151279140"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa005.fm.intel.com with ESMTP; 08 Jun 2025 21:53:53 -0700
Date: Mon, 9 Jun 2025 12:47:04 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alexey Kardashevskiy <aik@amd.com>,
	"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org, gregkh@linuxfoundation.org,
	lukas@wunner.de, suzuki.poulose@arm.com, sameo@rivosinc.com,
	zhiw@nvidia.com
Subject: Re: [RFC PATCH 3/3] iommufd/tsm: Add tsm_bind/unbind iommufd ioctls
Message-ID: <aEZnSCJ7aMpIv7eK@yilunxu-OptiPlex-7050>
References: <yq5a5xhj5yng.fsf@kernel.org>
 <20250529133757.462088-1-aneesh.kumar@kernel.org>
 <20250529133757.462088-3-aneesh.kumar@kernel.org>
 <aDsta4UX76GaExrO@yilunxu-OptiPlex-7050>
 <668b023e-d299-42e1-87fc-ec83c514374e@amd.com>
 <aD3clPC8QfL1/XYF@yilunxu-OptiPlex-7050>
 <c552a298-0dde-409d-9c2d-149b2e2389bf@amd.com>
 <20250604123747.GG5028@nvidia.com>
 <aEML7kUPSibTaAYk@yilunxu-OptiPlex-7050>
 <20250606163455.GI19710@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250606163455.GI19710@nvidia.com>

On Fri, Jun 06, 2025 at 01:34:55PM -0300, Jason Gunthorpe wrote:
> On Fri, Jun 06, 2025 at 11:40:30PM +0800, Xu Yilun wrote:
> > On Wed, Jun 04, 2025 at 09:37:47AM -0300, Jason Gunthorpe wrote:
> > > On Wed, Jun 04, 2025 at 11:47:14AM +1000, Alexey Kardashevskiy wrote:
> > > 
> > > > If it is the case of killing QEMU - then there is no usespace and
> > > > then it is a matter of what fd is closed first - VFIO-PCI or
> > > > IOMMUFD, we could teach IOMMUFD to hold an VFIO-PCI fd to guarantee
> > > > the order. Thanks,
> > > 
> > > It is the other way around VFIO holds the iommufd and it always
> > > destroys first.
> > > 
> > > We are missing a bit where the vfio destruction of the idevice does
> > > not clean up the vdevice too.
> > 
> > Seems there is still problem, the suggested flow is:
> > 
> > 1. VFIO fops release
> > 2. vfio_pci_core_close_device()
> > 3. vfio_df_iommufd_unbind()
> > 4.   iommufd_device_unbind()
> > 5.     iommufd_device_destroy()
> > 6.       iommufd_vdevice_destroy() (not implemented)
> > 7.         iommufd_vdevice_tsm_unbind()
> > 
> > In step 2, vfio pci does all cleanup, including invalidate MMIO.
> > In step 7 vdevice does tsm unbind, this is not correct. TSM unbind
> > should be done before invalidating MMIO.
> > 
> > TSM unbind should always the first thing to do to release lockdown,
> > then cleanup physical device configuration.
> 
> I think you'd have to re-order things so that vfio_df_iommufd_unbind()
> happens before the mmio invalidate..

That seems an easier solution.

> 
> And if you can succeed in moving the MMIO mapping to bind/unbind then
> the invalidate from vfio won't matter.

It still matters. If VFIO tries to invalidate MMIOs before Unbind, DMA
Silent Drop protection still triggers. Ensuring a correct bind/unbind
operation in IOMMUFD cannot make VFIO agnostic to bind/unbind.


BTW: Let me summarize what I've got about Bind-MMIO interaction.

1. All vendors need TSM Unbind first, then invalidate MMIOs, this is
   to avoid DMA Silent Drop protection which exists on all vendors.
2. TDX Connect additionally requires finer operation sequence during TSM
   Unbind, i.e. invalidate MMIOs after TDI stop and before TDI metadata
   free, this is for TDX firmware internal TDI management logic.

Thanks,
Yilun
> 
> Jason

