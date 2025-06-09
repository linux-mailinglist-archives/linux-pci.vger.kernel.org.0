Return-Path: <linux-pci+bounces-29198-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF86AD1888
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 08:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C4EC188B037
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 06:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00100155A4E;
	Mon,  9 Jun 2025 06:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mCrZhoDu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A50018B495
	for <linux-pci@vger.kernel.org>; Mon,  9 Jun 2025 06:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749449858; cv=none; b=SXku7Sa553XPxM395Bod6HcFPMaZ9fbVxxZQHPN3okNpF55JtjKa6qo4h4u0ZC2Y/Sdg1tf49BFv0tX9oz/Hb+ZmhjIrwrVckHZs+y6fd24x5ZtqH5o/S6n57T9L7eYwitYQTb9iuelVUocr5mPglg2W4vONFQawaSAf2/XfNI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749449858; c=relaxed/simple;
	bh=YieKM4rQF0b2eI7WnPYtU5FUWwd2QLpyB286sYPLip8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r+jgpX5LCn8Lw0LL7ByBg2uVE8YFrytZy6AMo1+ix2YUiqQbOzSmYOFaKwadtBougHUXWyS45i4SVSAjjOpCFtlppfT4lYKzhTgUxZY+/8B7ZAANxvUGW7qQyW9SZbLQwb5hiHfdD7G5aPP1ljFGi8N5VipI6PH/oZtwfFWpqUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mCrZhoDu; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749449857; x=1780985857;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YieKM4rQF0b2eI7WnPYtU5FUWwd2QLpyB286sYPLip8=;
  b=mCrZhoDuOfCazsO+s/zPF56MTuHOGBink427phwIQTadolTvRgXXvBfl
   a3/09ORXRvEASO978hq5wEpgd/ZFsiRWDFEusn+OLdi98EDEUeN1GHpNu
   tBbUPLe/jWqGISvfKj/XmRu4CZdZh9+NvwC/UOSadlGmscH5cVMqFVmRK
   Z97+/oQoFBT+p+57jwsWEGh1ggPH4Yx84C0dT4bv8X0+Of2r1JJFTzKHM
   TAkcXQlKe2aW5sEvnmSO4TiZEmN93a5NB7nSWs8ofH4Qy24TErR8pS2K1
   eFly0AnxF83/KBnlUVT7Nhkr2/UBav32HjVDknvnQZVmPRAjM2PMpjpFw
   g==;
X-CSE-ConnectionGUID: yC8wu3l9TA+65/MpdFT/ig==
X-CSE-MsgGUID: oaCpnRVOSaGkZaoKBy+hPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11458"; a="55305784"
X-IronPort-AV: E=Sophos;i="6.16,221,1744095600"; 
   d="scan'208";a="55305784"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2025 23:17:36 -0700
X-CSE-ConnectionGUID: c5yapTmBSRKRDPZcWGkzag==
X-CSE-MsgGUID: B6HFq3e/QYC8vORPKDhH0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,221,1744095600"; 
   d="scan'208";a="146336473"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa007.fm.intel.com with ESMTP; 08 Jun 2025 23:17:33 -0700
Date: Mon, 9 Jun 2025 14:10:44 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org, gregkh@linuxfoundation.org,
	lukas@wunner.de, suzuki.poulose@arm.com, sameo@rivosinc.com,
	zhiw@nvidia.com
Subject: Re: [RFC PATCH 3/3] iommufd/tsm: Add tsm_bind/unbind iommufd ioctls
Message-ID: <aEZ65MtawOTjGZ9R@yilunxu-OptiPlex-7050>
References: <aDsta4UX76GaExrO@yilunxu-OptiPlex-7050>
 <yq5azfeqjt9i.fsf@kernel.org>
 <aD3QcQxtjoYXrglM@yilunxu-OptiPlex-7050>
 <yq5ao6v5ju6p.fsf@kernel.org>
 <aD7TZRnFualizeXk@yilunxu-OptiPlex-7050>
 <20250603121456.GF376789@nvidia.com>
 <aD/aOk9jHryygiRG@yilunxu-OptiPlex-7050>
 <20250604123118.GE5028@nvidia.com>
 <aEEOKXxTuUifYxJY@yilunxu-OptiPlex-7050>
 <20250605145435.GA19710@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250605145435.GA19710@nvidia.com>

On Thu, Jun 05, 2025 at 11:54:35AM -0300, Jason Gunthorpe wrote:
> On Thu, Jun 05, 2025 at 11:25:29AM +0800, Xu Yilun wrote:
> 
> > That's good point, thanks. S-EPT is controlled by TSM, but the fact is,
> > unlike RMP it needs too much help from VMM side, and now KVM is the
> > helper. I will continue to investigate if TDX TSM driver could opt in to
> > become another helper and how to coordinate with KVM.
> 
> I think it would be quite a simplification if the iommufd operation
> would also cause the TSM to setup the secure MMIO directly from the
> pPCI device and remove hypervisor access to it.
> 
> Then you don't need DMABUF to KVM at all.

I thought about this for sometime. It may be possible to trigger KVM
to populate/zap the S-EPT but cannot let TSM direct setup/remove S-EPT.
RMP could be updated by a single instruction, but S-EPT update involves
generic KVM MMU flow like Page Table Page management, TLB invalidation,
even mirror EPT management (specific to x86 KVM MMU).

To make KVM populate S-EPT, we need KVM memory slots and in turn need
DMABUF.

Thanks,
Yilun

> 
> The create vPCI call would have to specify the base virtual addresses
> of all the BARs from userspace, which is probably OK as I suspose you
> also cannot disable or relocate the MMIO BAR while in T=1 mode.
> 
> Jason

