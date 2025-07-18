Return-Path: <linux-pci+bounces-32515-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D218B09F78
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 11:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7FB7A8657B
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 09:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3093298269;
	Fri, 18 Jul 2025 09:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UHoCnv1M"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CBA29824E
	for <linux-pci@vger.kernel.org>; Fri, 18 Jul 2025 09:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752830671; cv=none; b=nboU7OhpuwHEQTXFciUI7wUzFT8KVPs4ZcEg9JJxk+RPysgho3b6T69BLsYLHJN6D0IZV8gzItqqFNSTrTMLrvB12ARumJV2Ry+SpMVRHcC22IJwX/Hkv4Tqoiw++6jluZY3XGMLBs829U+iBkoR3Qh0/7A1+OuMvBhlUTHDgBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752830671; c=relaxed/simple;
	bh=PZMsdOrpqKKv1q53yu5dQtVH2dzWmq1v9dtg/pYbEc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A3BkcNuhSdPyX10FgcCZtLe0btTyPe/oMzDY5FEBqfJtKhTKSaWZiSdiVIlwS9e+3ZraSoVypRuDDwfzOek9FSTzfjo1vqgZCSBBbFFiwDKnM9VYtljJliARShfe/nRjVlKrKpvU3IoYUz9hlksM9ghV9MZiOPUYSrePRSJSCCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UHoCnv1M; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752830670; x=1784366670;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PZMsdOrpqKKv1q53yu5dQtVH2dzWmq1v9dtg/pYbEc4=;
  b=UHoCnv1MkY6na2KtN6cxCtPArKgUQceZIsHZYOwTW8Efa33bhAfzLHsa
   pRSTD4A/0SXKDFRDS9Y5zGd9RSqM8YCIYk8e2cL4RQ6e7ptMo9z1fhywU
   AdAoZR2W2b4QrGNAE4icggat2evbupWlIChBV1xOslNyDXPnfiqbeXtQB
   KV29t0WdkJ086uhgFSFGw/cg0DkTae0309lapoYB7JuDPlzrOhEtJ4P0N
   wib7kYkxlOZwg/M+TTEjziKp2sWZZmhbV0CfO/AFvKGNc/i1h+7JNhmu0
   yWwMuf4NqitdSMemZDK64Zb5Vi7Yo/27wkAF5JZx+1TwJz/R1RDHUpgFP
   Q==;
X-CSE-ConnectionGUID: 3K1tG+hmSJOkwePQqzwuMg==
X-CSE-MsgGUID: NO+xf/XFRr6hoMA2JvjEgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11495"; a="55062359"
X-IronPort-AV: E=Sophos;i="6.16,321,1744095600"; 
   d="scan'208";a="55062359"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2025 02:24:29 -0700
X-CSE-ConnectionGUID: AVkak5PVQ26/buTMPFH19Q==
X-CSE-MsgGUID: szjSVkFVTDaNFmeeaAyBxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,321,1744095600"; 
   d="scan'208";a="157400103"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa010.jf.intel.com with ESMTP; 18 Jul 2025 02:24:26 -0700
Date: Fri, 18 Jul 2025 17:15:42 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org, gregkh@linuxfoundation.org,
	lukas@wunner.de, suzuki.poulose@arm.com, sameo@rivosinc.com,
	zhiw@nvidia.com
Subject: Re: [RFC PATCH 3/3] iommufd/tsm: Add tsm_bind/unbind iommufd ioctls
Message-ID: <aHoQvkK6NOSRfTyx@yilunxu-OptiPlex-7050>
References: <yq5a5xhj5yng.fsf@kernel.org>
 <20250529133757.462088-1-aneesh.kumar@kernel.org>
 <20250529133757.462088-3-aneesh.kumar@kernel.org>
 <aHYtj/jyfXD4XhZy@yilunxu-OptiPlex-7050>
 <20250715130949.GM2067380@nvidia.com>
 <aHfIGJzqv+4XiO7f@yilunxu-OptiPlex-7050>
 <20250716163134.GA2177622@nvidia.com>
 <aHi0HxV1Y1TsauxF@yilunxu-OptiPlex-7050>
 <20250717124333.GF2177622@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717124333.GF2177622@nvidia.com>

On Thu, Jul 17, 2025 at 09:43:33AM -0300, Jason Gunthorpe wrote:
> On Thu, Jul 17, 2025 at 04:28:15PM +0800, Xu Yilun wrote:
> > > Seems to me that two DMABUFs is easier than trying to teach DMABUf
> > > about some new attribute..
> > > 
> > > Userpsace can unmap all the shared DMABUFs, do a TDI BIND, then map
> > > private DMABUFs. DMABUFs do not change from private to shared on the
> > > fly.
> > 
> > But the shareability of each MMIO pfn should still be recorded at the
> > time of TDI BIND. 
> 
> > Shareability is not only about hypervisor can map the
> > MMIO or not, it is mainly about Guest should access it in a shared or
> > private manner. According to this KVM map the pfn in EPT or S-EPT.
> 
> Yes, which is why having two dmabufs might be nice because you can
> plug the public one into the EPT and the private one into the S-EPT
> and SW can validate the right one is in the right place.
> 
> > For MMIO, the shareability layout is the TDI's inherence which can be
> > get from TDI report. I.e. some MMIOs must still be accessed as shared by
> > guest even if the device is converted to private. So I think a private
> > DMABUF without sharebility layout can't support the TDI case.
> 
> IMHO this even more strongly says two DMABUFs. After binding you'd get
> a new shared DMABUF that was limited to only the actual shared pages
> while the private DMABUF would be limited to only the actual private
> pages.
> 
> It is much simpler considering the current DMABUF APIs than trying to
> convey per-pfn shared/private indication.

I generally think the flow you describe is good for implementation.
But still some details, see below.

> 
> > The existing shareability layout for all guest memory space is recorded
> > in KVM via KVM_SET_MEMORY_ATTRIBUTES, but now Sean's suggestion is
> > giving it back to resource owners when in-place conversion makes
> > guest_memfd fully aware of the shareability layout.
> 
> I would say this discussion is irrelevant to this case since we are
> not doing any kind of in-place conversion.
> 
> 1) At VM start the VMM gets the shared DMABUF and maps it to IOAS and
>    EPT
> 2) Bind request comes in, VMM unmaps shared DMABUF from IOAS and EPT
>    then closes it.
> 3) Bind is done
> 4) VMM opens a shared and private DMABUF FD and learns the valid
>    ranges in both DMABUFs (ie what PFNS are private/shared)

Who decides the dmabuf be shared or private? I assume you mean
userspace, VFIO doesn't know about the shareability of each dmabuf?

> 5) VMM maps the shared DMABUF fragments to the EPT and IOAS

Userspace could set a shared only memory slot.

> 6) VMM maps the private DMABUF fragments to the S-EPT

Userspace could set a private only memory slot, but maybe the concern
is KVM can't trust userspace about the assertion of private. Like for
private memory, KVM now verifies the slot is backed by gmem before
allowing the slot to be private. This is some in-kernel contract.
Without the contract, userspace could assign arbitrary memory to KVM as
private and explode.  If VFIO is not aware of the shareability, KVM - VFIO
can't build the contract.

If VFIO should be aware of the shareability, IOMMUFD to VFIO callback is
needed after TSM bind.

> 7) Unbind request comes in, VMM unmaps both shared and private DMABUFS
> 
> For all error cases the kernel revokes all open DMABUFS and userspace
> is expected to close & reopen them to recover.
> 
> From a KVM perspective when you tell it to map the DMABUF the VMM will
> also tell it the shared/private, which is basically implied by the
> GPA. There is no "conversion", userspace will destroy the memslot and
> create new ones.
> 
> Isn't this pretty simple?

It is simpler on kernel side. FYR, may introduce some complexity in
userspace, this may result in 3+ dmabufs. There may be shared holes
in the BAR, and kvm slot can't be gfn sparse. This may not be a big
problem.

Thanks,
Yilun

> 
> Jason

