Return-Path: <linux-pci+bounces-32362-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BABDB08803
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 10:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88A38189F916
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 08:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CCF221B8F2;
	Thu, 17 Jul 2025 08:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BtF/MjPL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78531B425C
	for <linux-pci@vger.kernel.org>; Thu, 17 Jul 2025 08:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752741420; cv=none; b=UOlbMJwhRIbWFM9+fx9B0lYSW55Ulx1k1e6tQIg/oZZ4J7YKBD4KygT4Sk2LbutC7ZSPxjd52Fc4PVfAv2OaLDWX3ywTeP/fwhmcDvkCBjJ4ixlBL/YKyaHYNY42g5WV/L9F6bpHrhA8mrYdIf8Y6AFOLzRRWv9/tg2Z31g+hqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752741420; c=relaxed/simple;
	bh=eLux5YewowxnO4MHSGuD8FVqQtkWWx81ulgrQEcDCuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fz1Ara8g3CbIknL8ESVMqFHRq4xadh4qND/wVz0K8/CUNh3eluQB1syDZdRCAas3Ji2b7H4iSWEm5CDnfCVc0TOHEz0e+s1fnixbT8yUz7402PyjVVb3cFid1VeONe8kim/8MjEzFIDERfyHj59US7SVY7SIcXbUn5q2La/ZLbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BtF/MjPL; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752741419; x=1784277419;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eLux5YewowxnO4MHSGuD8FVqQtkWWx81ulgrQEcDCuU=;
  b=BtF/MjPLmOjjEfb4sfNszsxTyLHsfB9MYVEEpTypMJtLSXGzK5vVzn6B
   SRnNHfCMhF079An4FgYbQ0+LIPxzBhnpnizB2I3DOf6uqO+lkkWhYbGJx
   1kHP3cf9xuYK9JE5X/sDa+e82o9Q8zBpKD4bKwhiQBEyGEL5U+DloMT+M
   qn8SXiKksdIt1lDYBTpe5YvjpVEqx/dPt5gLgvBodYXw7lD9pSTcTNYWH
   EeIlg0DDXXIL1P6ieIXtdqslVd1G4AzgjWLLxy4ZFQDwbYJzD/d9rf5wf
   L0wiaLR0hnBAI5HTusz1XSI43tNMDFRiR7yry2NgeLjevXpqMZxW4+61r
   Q==;
X-CSE-ConnectionGUID: eZH4CTOkRwqDlMMHyplIaw==
X-CSE-MsgGUID: cvG3RzFURjGQjwUvnLnqow==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="65267533"
X-IronPort-AV: E=Sophos;i="6.16,318,1744095600"; 
   d="scan'208";a="65267533"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 01:36:58 -0700
X-CSE-ConnectionGUID: hIcmrw7jT5yeZcwgKMkDNw==
X-CSE-MsgGUID: Ynd4aBzHTCejGmGYd8PTqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,318,1744095600"; 
   d="scan'208";a="158201124"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa008.jf.intel.com with ESMTP; 17 Jul 2025 01:36:55 -0700
Date: Thu, 17 Jul 2025 16:28:15 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org, gregkh@linuxfoundation.org,
	lukas@wunner.de, suzuki.poulose@arm.com, sameo@rivosinc.com,
	zhiw@nvidia.com
Subject: Re: [RFC PATCH 3/3] iommufd/tsm: Add tsm_bind/unbind iommufd ioctls
Message-ID: <aHi0HxV1Y1TsauxF@yilunxu-OptiPlex-7050>
References: <yq5a5xhj5yng.fsf@kernel.org>
 <20250529133757.462088-1-aneesh.kumar@kernel.org>
 <20250529133757.462088-3-aneesh.kumar@kernel.org>
 <aHYtj/jyfXD4XhZy@yilunxu-OptiPlex-7050>
 <20250715130949.GM2067380@nvidia.com>
 <aHfIGJzqv+4XiO7f@yilunxu-OptiPlex-7050>
 <20250716163134.GA2177622@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716163134.GA2177622@nvidia.com>

On Wed, Jul 16, 2025 at 01:31:34PM -0300, Jason Gunthorpe wrote:
> On Wed, Jul 16, 2025 at 11:41:12PM +0800, Xu Yilun wrote:
> > > Except it doesn't work like that for MMIO. Shared/private is a TDI
> > > operation only and effects the whole device. We shouldn't split it
> > > into two actions.
> > 
> > OK. IIUC you want 1 uAPI, TSM Bind, to finish all secure configuration,
> > including MMIO sharebility. I think it is possible, the MMIO shareability
> > is fixed after TSM Bind. iommufd could fetch TDI report to get the
> > private/shared MMIO ranges and callback to VFIO.
> 
> Am I wrong? Isn't this one action? Once you do bind you MUST have no

You are right and I'm good to this one operation.

> hypervisor mapping or x86 will explode. And once bind completes the
> hypervisor mapping is unusable on all other arches.
> 
> That's one operation as far as I can tell??
> 
> > > I also don't think it needs to be strictly 'in-place' as we expect the
> > 
> > When I said "must be in-place", I mean the MMIO resource (hpa) for one gfn is
> > fixed, can't have 2 copies of backend as the current private/shared
> > memory does.
> 
> Ok, I would not call that in place..
> 
> > > VM to be idle on the MMIO during this change over. Faulting would be OK.
> > 
> > Sorry, I don't get your point about 'strictly in-place' here?
> 
> Here I mean the iommu page table would have to atomically change "in
> place" from shared to private in a way that that is hitless to the
> guest. We don't need this, IMHO.

I agree.

> 
> > > Any case where we need to get back to vfio for something needs to be
> > > managed with a callback of some kind. We need to get a list of what
> > > those things are.
> > > 
> > > What do all the arches need here?
> > >  - ARM I suspect has the TDI locking operation install the MMIO in the
> > >    secure S2, not KVM?
> > >  - AMD just leaves the MMIO mapped all the time?
> > >  - x86 presumably needs to carefully map/unmap to KVM and iommu in the
> > >    right sequence or you get a MCE?
> > 
> > Yeah, for Intel TDX, basically 2 things, zap the mapping on opposite side
> > page table, mark the correct shareability for correct fault in.
> 
> I expect userspace to be doing this, which is why I asked about two DMABUFs..
> 
> > > So what is the plan? You want to wrap this in DMABUF, but will there
> > > be two DMABUFS, one for secure and one for non-secure? Is userspace
> > 
> > No I don't expect 2 dmabufs. I image shareability could be an physical
> > attribute of dmabuf and the callback to VFIO changes the shareability.
> > And VFIO, the dmabuf exporter, could notify KVM/iommufd about the
> > shareability change. Then KVM/iommufd unmaps their page tables.
> 
> How can this work exactly?
> 
> Does Intel put shared/private MMIO at the same guest address when it
> changes around? I understand other arches do not do this.

No, The Shared bit is embedded in GPA, it toggles for shared/private
change.

> 
> Even if you do, the owning page table changes, right? In public mode
> it has to be mapped into an ioas and in private mode there is no ioas
> mapping?

Yes.

> 
> Seems to me that two DMABUFs is easier than trying to teach DMABUf
> about some new attribute..
> 
> Userpsace can unmap all the shared DMABUFs, do a TDI BIND, then map
> private DMABUFs. DMABUFs do not change from private to shared on the
> fly.

But the shareability of each MMIO pfn should still be recorded at the
time of TDI BIND. Shareability is not only about hypervisor can map the
MMIO or not, it is mainly about Guest should access it in a shared or
private manner. According to this KVM map the pfn in EPT or S-EPT.

For MMIO, the shareability layout is the TDI's inherence which can be
get from TDI report. I.e. some MMIOs must still be accessed as shared by
guest even if the device is converted to private. So I think a private
DMABUF without sharebility layout can't support the TDI case.

The existing shareability layout for all guest memory space is recorded
in KVM via KVM_SET_MEMORY_ATTRIBUTES, but now Sean's suggestion is
giving it back to resource owners when in-place conversion makes
guest_memfd fully aware of the shareability layout.

Thanks,
Yilun

> 
> Invalidation is only an error case situation to revoke if userspace
> didn't do the above sequence right.
> 
> Is that reasonable???
> 
> Jason

