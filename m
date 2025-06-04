Return-Path: <linux-pci+bounces-28938-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B91C4ACD7B8
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 08:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60DC33A3613
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 06:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A6123817A;
	Wed,  4 Jun 2025 06:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jqer1241"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBE21C700C
	for <linux-pci@vger.kernel.org>; Wed,  4 Jun 2025 06:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749017134; cv=none; b=eWe79d0/hTWFBL/sGO3O4UMk6mnoEth7rqPMuq7ltA0gykqX3VQ1t+aNAJqwRmMaVnjZyp8n43ySL5ClBnP+Tyt2Q+yTatpLpRMYZccH118qWX5GL7baPaUHuz9I4w9/MRM4UU1q1aVx5/28/kgzl534GcWLsa8cXW5/KVDKj5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749017134; c=relaxed/simple;
	bh=pf+NdBz417t8L4KW9Dwe4kD3rvaFL8QbqIA+on0Ydl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IdgIAO21SSM1in5G4En34ybk7ZwJ9IMhsuJ9n4BRCcJ2RI5pXtaD19pLaZ5IqyqMlIr1dX6ihPPe/CkEMk46PqcrdK3vhAaSQHCh5zy0Q35UTSLLMTjRF8NEaLuDwo3qdNcIWudxJenjLUDQwUnFU19q/7LqiCLDDrmpEg5yrGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jqer1241; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749017133; x=1780553133;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=pf+NdBz417t8L4KW9Dwe4kD3rvaFL8QbqIA+on0Ydl4=;
  b=Jqer1241TvXrFy3yxroWfHvQrfl7jN7+w8VtbRvwcHDOVg18hKlmj9rV
   N75VuqzoaoyFGshMOilwKI8LHZhYir9/HMDa2WpDV/NDZLgKo9c2OINPL
   KRuNr2CYMzFOWGXljblQUPPjn7QqqcV1Kbcaw2qwKaG3lgc8F0FfAbKRm
   x3/CtJJytvp8y3s2I5HpmKWnIgPIiy23uHBmJj+WY0m9WSgKcj7cgzWPF
   /tO0T2VPSJF7jfbR7axcbayaj4Hepo0cFjQthYLPxiBlILn/icvkbs6z3
   RmbgGG00PLuyzTVxQ7Z0ZggGScejTTycV3RVxFmhzbX4tyT+iw8Fx23p8
   A==;
X-CSE-ConnectionGUID: ITv6wjYpRTyIvENB++rWpA==
X-CSE-MsgGUID: p8RoORItRL2YFUE3hRK3YQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="62436777"
X-IronPort-AV: E=Sophos;i="6.16,208,1744095600"; 
   d="scan'208";a="62436777"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 23:05:33 -0700
X-CSE-ConnectionGUID: S7BumPzASWya1TlABzSyHQ==
X-CSE-MsgGUID: PDZe6sgtR7GkmhWeEdQWtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,208,1744095600"; 
   d="scan'208";a="182260555"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa001.jf.intel.com with ESMTP; 03 Jun 2025 23:05:30 -0700
Date: Wed, 4 Jun 2025 13:58:55 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org, gregkh@linuxfoundation.org,
	lukas@wunner.de, suzuki.poulose@arm.com, sameo@rivosinc.com,
	zhiw@nvidia.com
Subject: Re: [RFC PATCH 3/3] iommufd/tsm: Add tsm_bind/unbind iommufd ioctls
Message-ID: <aD/gn2tb+HfZU29D@yilunxu-OptiPlex-7050>
References: <yq5a5xhj5yng.fsf@kernel.org>
 <20250529133757.462088-1-aneesh.kumar@kernel.org>
 <20250529133757.462088-3-aneesh.kumar@kernel.org>
 <aDsta4UX76GaExrO@yilunxu-OptiPlex-7050>
 <yq5azfeqjt9i.fsf@kernel.org>
 <aD3QcQxtjoYXrglM@yilunxu-OptiPlex-7050>
 <20250602164857.GE233377@nvidia.com>
 <aD50lpgJ+9XMJE/4@yilunxu-OptiPlex-7050>
 <20250603121142.GE376789@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250603121142.GE376789@nvidia.com>

On Tue, Jun 03, 2025 at 09:11:42AM -0300, Jason Gunthorpe wrote:
> On Tue, Jun 03, 2025 at 12:05:42PM +0800, Xu Yilun wrote:
> > On Mon, Jun 02, 2025 at 01:48:57PM -0300, Jason Gunthorpe wrote:
> > > On Tue, Jun 03, 2025 at 12:25:21AM +0800, Xu Yilun wrote:
> > > 
> > > > > Looking at your patch series, I understand the reason you need a vfio
> > > > > ioctl is to call pci_request_regions_exclusive—is that correct?
> > > > 
> > > > The immediate reason is to unbind the TDI before unmapping the BAR.
> > > 
> > > Maybe you should just do this directly, require the TSM layer to issue
> > > an unbind if it gets any requests to change the secure EPT?
> > 
> > The TSM layer won't touch S-EPT, KVM manages S-EPT. 
> 
> Why not? This cross layering mess has to live someplace.
> 
> If the actual issue is the KVM S-EPT interacting with TSM bind/unbind
> only on Intel platforms then it would be better to address it there
> and stop trying to dance around the problem in higher levels.
> 
> > Similarly IOMMUFD/IOMMU driver manages IOMMUPT. When p2p is
> > involved, still need to unbind the TDI first then unmap the BAR for
> > IOMMUPT.
> 
> Huh? I thought if the device is in T=1 mode then it's MMIO should not
> be in the non-secure IOMMU page table at all for Intel? Only T=1 P2P
> DMA should reach its MMIO and that goes through the TSM controlled
> IOMMU which uses the S-EPT ???

Correct.

But the p2p case may impact AMD, AMD have legacy IOMMUPT on its secure
DMA path. And if you invalidate MMIO (in turn unmaps IOMMUPT) when
bound, may trigger HW protection mechanism against DMA silent drop.

SEV-TIO Firmware Interface SPEC, Section 2.11

"If a bound TDI sends a request to the root complex, and the IOMMU detects a fault caused by host
configuration, the root complex fences the ASID from all further I/O to or from that guest. A host
fault is either a host page table fault or an RMP check violation. ASID fencing means that the
IOMMU blocks all further I/O from the root complex to the guest that the TDI was bound, and the
root complex blocks all MMIO accesses by the guest. When a guest writes to MMIO, the write is
silently dropped. When a guest reads from MMIO, the guest reads 1s."


BTW: What is ARM's secure DMA path, does it goes through independent
Secure IOPT? So for p2p when VFIO invalidates MMIO, how the Secure IOPT
react? How to avoid DMA slient drop?

Thanks,
Yilun

> 
> Jason

