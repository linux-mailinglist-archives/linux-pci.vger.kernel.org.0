Return-Path: <linux-pci+bounces-32597-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 472B7B0B33B
	for <lists+linux-pci@lfdr.de>; Sun, 20 Jul 2025 04:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B7167AB942
	for <lists+linux-pci@lfdr.de>; Sun, 20 Jul 2025 02:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9CB2AE90;
	Sun, 20 Jul 2025 02:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YNZ8DNZA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19F817741
	for <linux-pci@vger.kernel.org>; Sun, 20 Jul 2025 02:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752979557; cv=none; b=ZtbGo+oIsK6L9TKRxnDpKBvRHUzo+NeAsXZ+1WSJBJebPPVU3Co77j6XAAvdy5Dp1uOnADn2fwhA6R7R9xOD4t7z3D+/BtSdk/LbbWi4KgFIXOHWieW/QYVPeHBLVbCh72m6aVhIo4L9LouLi+zMCxYVIvZcy77HfAMvjYWc09k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752979557; c=relaxed/simple;
	bh=fBuEzZT35RHz0npdNmgtuCBtC1upPwB5eIkUOXpKEjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RoFfGvTYQB8oc8wJehrkrvPqsyap9gtAUlgRgB/v019v2c9Wf8OqCBJjAdJBZFc0fLrsNIFoA9QScsNgW+M58j+issoL3E8WsJKuU3OQcv5aSW6N3UFF+TFn/MSHTtZrkhP4J7K7i82BYj66upCXCRr8UfO5BDciAXYH9BR/oGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YNZ8DNZA; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752979556; x=1784515556;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fBuEzZT35RHz0npdNmgtuCBtC1upPwB5eIkUOXpKEjE=;
  b=YNZ8DNZARxnYS1f+YxERIId4ZXMGvO1FQIqkrN9hksEkj3zi/fGL1S8X
   jJFstnUADVqTDhA3lyKtOxolQ5Eau/zReE3bRuSQqVSyMrlaEkXdIuFCQ
   uh1EdPlpipq6zhHbeZeTxl22Jm1v8FJ5H0FzeY+orEbxJ4WEH9o3mAbFR
   MTPI2Uz+lKvW/876D/7BkXJsZYCfpCryh6WvOpK98Db2xOMVx3wW0xQOH
   qNrVfkxnTDBcZ0rIap17QqH3AdX75Is3zDGdiP/vpk1e4S9C8kerAc41J
   9f2XqjoYBfQDxekW8XM4ES8ycf+7+h22uq6kvKPwismzt7m+Csr2MW4D4
   w==;
X-CSE-ConnectionGUID: UDmjt+vZSTmP1DAij/T5Pg==
X-CSE-MsgGUID: CcHsb7zaRiiJuPMe1I/CCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11497"; a="66673308"
X-IronPort-AV: E=Sophos;i="6.16,325,1744095600"; 
   d="scan'208";a="66673308"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2025 19:45:56 -0700
X-CSE-ConnectionGUID: Jw6DyhHyRUyh6q2C0oZEvw==
X-CSE-MsgGUID: o9S8BVBpRUG21GMoZm+NmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,325,1744095600"; 
   d="scan'208";a="189489250"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa001.fm.intel.com with ESMTP; 19 Jul 2025 19:45:53 -0700
Date: Sun, 20 Jul 2025 10:37:04 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org, gregkh@linuxfoundation.org,
	lukas@wunner.de, suzuki.poulose@arm.com, sameo@rivosinc.com,
	zhiw@nvidia.com
Subject: Re: [RFC PATCH 3/3] iommufd/tsm: Add tsm_bind/unbind iommufd ioctls
Message-ID: <aHxWUPJ+OICtbWgy@yilunxu-OptiPlex-7050>
References: <20250529133757.462088-1-aneesh.kumar@kernel.org>
 <20250529133757.462088-3-aneesh.kumar@kernel.org>
 <aHYtj/jyfXD4XhZy@yilunxu-OptiPlex-7050>
 <20250715130949.GM2067380@nvidia.com>
 <aHfIGJzqv+4XiO7f@yilunxu-OptiPlex-7050>
 <20250716163134.GA2177622@nvidia.com>
 <aHi0HxV1Y1TsauxF@yilunxu-OptiPlex-7050>
 <20250717124333.GF2177622@nvidia.com>
 <aHoQvkK6NOSRfTyx@yilunxu-OptiPlex-7050>
 <20250718122646.GB2250220@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718122646.GB2250220@nvidia.com>

On Fri, Jul 18, 2025 at 09:26:46AM -0300, Jason Gunthorpe wrote:
> On Fri, Jul 18, 2025 at 05:15:42PM +0800, Xu Yilun wrote:
> > > I would say this discussion is irrelevant to this case since we are
> > > not doing any kind of in-place conversion.
> > > 
> > > 1) At VM start the VMM gets the shared DMABUF and maps it to IOAS and
> > >    EPT
> > > 2) Bind request comes in, VMM unmaps shared DMABUF from IOAS and EPT
> > >    then closes it.
> > > 3) Bind is done
> > > 4) VMM opens a shared and private DMABUF FD and learns the valid
> > >    ranges in both DMABUFs (ie what PFNS are private/shared)
> > 
> > Who decides the dmabuf be shared or private? I assume you mean
> > userspace, VFIO doesn't know about the shareability of each dmabuf?
> 
> I imagined userspace would put a flag in the ioctl to VFIO to get the
> dmabuf kind it wants. VFIO would have to be told from iommufd what the
> per-pfn shared/private layout is and can use that to manage the
> dmabufs.
> 
> > > 5) VMM maps the shared DMABUF fragments to the EPT and IOAS
> > 
> > Userspace could set a shared only memory slot.
> > 
> > > 6) VMM maps the private DMABUF fragments to the S-EPT
> > 
> > Userspace could set a private only memory slot, but maybe the concern
> > is KVM can't trust userspace about the assertion of private. 
> 
> I imagined kvm can query the dmabuf and learn it is all private from
> VFIO. The whole dmabuf, not per-pfn. Same for #5 it can check it is
> shared memory too.

Yes.

On KVM side, userspace should firstly indicate the slot type in the
ioctl and KVM verifies. Nowadays, KVM accepts 'private slot', which can
be private or shared. And legacy slot, which can only be shared. We
need to introduce a new type 'private only slot', then KVM verifies
against dma-buf.  We will see how KVM folks think about it.

> 
> I sort of imagine using the same mechanism for p2p where we can mark
> memory in the dmabuf with a 'provider' indicating these details. We
> will have to see.

Yes.

> 
> > If VFIO should be aware of the shareability, IOMMUFD to VFIO callback is
> > needed after TSM bind.
> 
> Yes, whever this list of per-PFN shared/private must be shared between
> VFIO and the TSM.
> 
> > It is simpler on kernel side. FYR, may introduce some complexity in
> > userspace, this may result in 3+ dmabufs. There may be shared holes
> > in the BAR, and kvm slot can't be gfn sparse. This may not be a big
> > problem.
> 
> Userspace probably needs to create multiple slots for sparsity
> 
> Again this seems much better if userspace handles it and just uses
> simple mostly existing KVM interfaces.
> 
> Why 3+ dmabufs? Isn't just one shared and one private per BAR?

Sorry, we must have 3+ KVM slots, but can have 2 dmabufs. We can map the
file offset to pfn ranges.

KVM slot can't be for sparse GFNs. If there is a shared hole inside
private space in the same bar, e.g.

0x10000000 - 0x10001fff    private
0x10002000 - 0x10002fff    shared
0x10003000 - 0x101fffff    private

We need 3 slots.

Thanks,
Yilun

> 
> Jason

