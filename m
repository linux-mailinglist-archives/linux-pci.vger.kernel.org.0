Return-Path: <linux-pci+bounces-29517-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D242DAD66BA
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 06:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 916EA174414
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 04:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F091A0BC9;
	Thu, 12 Jun 2025 04:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hUsNXttg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B722218EFD1
	for <linux-pci@vger.kernel.org>; Thu, 12 Jun 2025 04:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749702182; cv=none; b=QkLn//RAjMKsADNfGcAAys6IZCnvp84r0tKCIE+95jN7lZJKm9OAYQpkYrofv0i1uUeSaz8ttdoEOjTog7/reMD/sbA0BnDjXr3mlGqaUABOfLAsb27hWlOnoYUONXXQGkCxV3Vio3Q3crhuabXBAsPzU2KPbVYeWszw80zaIBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749702182; c=relaxed/simple;
	bh=Q675ubLGDkPFFcmY86fkaTZZ+3+l2H6GNmWgJZ8fMao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CP8YPA4cG+DuqnczeOvt1ZcwVFnUvQO+5DmGDP5zyBW9dDhgpouqQCDIGSmyoMl1EsY9Gnh7LPtt6RWswwXwDamURgprGAQh8czZszxTB63bnDb8LJ4ZpHKQ3UpHOBUmbyYuuVtaOT3sdSuIhmFph8qklePDYC217C8RnpclpQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hUsNXttg; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749702181; x=1781238181;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Q675ubLGDkPFFcmY86fkaTZZ+3+l2H6GNmWgJZ8fMao=;
  b=hUsNXttgzQkPa+ANXVbu6oHQPrF5eDxIwJaAHrK9wbkDEQA2e/XTseXK
   EYDpvXNWeBALtaF75wwSjxxN7RORS7qvut9avRWGdiyRH35kTxbp+v+Td
   iIIp8OEF6gfxPK+rKN9hn3Trb1dkzHLAH/hsQ+UHaQoY4t3w4StIeudRy
   xLd5lZj8zxU4swKHUiNbMdzMlbNQtIXOEXapVoWSBDZZwuxeeiebC+aOI
   Td+J6iT0gc52lXbaLo8h2+yaONUrw+t1ZjDoygdUaOjFLZyIieEmCl+3e
   BS9LbNJdHmqe4++H1TB3AcPYg0P5+LBPEcclE2+h9BHCha0OG/00S1vgc
   Q==;
X-CSE-ConnectionGUID: vaoDjb8VT1y+RnS5/gyaXQ==
X-CSE-MsgGUID: mixLXYwHTROD4vDI9QIYgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="51741319"
X-IronPort-AV: E=Sophos;i="6.16,229,1744095600"; 
   d="scan'208";a="51741319"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 21:23:00 -0700
X-CSE-ConnectionGUID: mVQ5fdJbRR2qZs5mdtGp+g==
X-CSE-MsgGUID: ZiOcNuL9QbG79FPkQbFKaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,229,1744095600"; 
   d="scan'208";a="147386747"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa009.jf.intel.com with ESMTP; 11 Jun 2025 21:22:57 -0700
Date: Thu, 12 Jun 2025 12:15:59 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org, gregkh@linuxfoundation.org,
	lukas@wunner.de, suzuki.poulose@arm.com, sameo@rivosinc.com,
	zhiw@nvidia.com
Subject: Re: [RFC PATCH 3/3] iommufd/tsm: Add tsm_bind/unbind iommufd ioctls
Message-ID: <aEpUf0/P5PZ+apBg@yilunxu-OptiPlex-7050>
References: <yq5a5xhj5yng.fsf@kernel.org>
 <20250529133757.462088-1-aneesh.kumar@kernel.org>
 <20250529133757.462088-3-aneesh.kumar@kernel.org>
 <aDsta4UX76GaExrO@yilunxu-OptiPlex-7050>
 <yq5azfeqjt9i.fsf@kernel.org>
 <aD3QcQxtjoYXrglM@yilunxu-OptiPlex-7050>
 <20250602164857.GE233377@nvidia.com>
 <aD50lpgJ+9XMJE/4@yilunxu-OptiPlex-7050>
 <efd630b0-d08d-46a6-a5ef-8a448eb19993@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <efd630b0-d08d-46a6-a5ef-8a448eb19993@amd.com>

On Tue, Jun 10, 2025 at 02:47:32PM +1000, Alexey Kardashevskiy wrote:
> 
> 
> On 3/6/25 14:05, Xu Yilun wrote:
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
> Is not it the TDX fw which manages _S_-EPT?

TDX fw writes the S-EPT entries, but to "manage" S-EPT, there are more
works for VMM.

The S-EPT related TDX fwcalls are verbose, it is not a fwcall like
"TDX_SEPT_MAP/UNMAP(gfn_range, pfn_range)" then the tree is there.

I wanna briefly describe the S-EPT fwcalls

 - A SEPT_ADD fwcall links a page-table page to a specifc S-EPT non-leaf entry.
 - A PAGE_AUG fwcall links a guest memory page to a specific leaf entry.
 - The MEM_TRACK fwcall tracks if VMM kicks all VCPUs out of guest mode, to
   ensure TLB for S-EPT are flushed/synced for every VCPU.
 - A PAGE_REMOVE fwcall clears a specific leaf entry, only when TLB
   flush are all done.

So it is KVM's job to orchestrate what a S-EPT tree should look like,
and request TDX fw to add/remove each S-EPT node one by one. TDX fw is
responsible for the security check for each adding/removing request, if
the check passed, TDX fw writes the actual S-EPT entry.

These TDX base implementations are already in linux-next.

> And the TDX host driver (what is it called btw? Intel's "CCP") registers itself as TSM in the TSM core so it is somewhere near S-EPT logic? Thanks,

Currently kvm_intel is near S-EPT for private memory, just as kvm_amd is
near RMP for private memory.

I see in AMD's solution, CCP TSM driver could directly operate RMP for
MMIO. I was trying to figure out if TDX TSM driver could also operate
MMIO part of S-EPT, but I didn't see the chance. Kicking VCPUs is not
what TSM driver could do.  Another thing is the existing KVM mirror
page table mechenism (allow me to keep simple).

Thanks,
Yilun

> 
> > 
> > Similarly IOMMUFD/IOMMU driver manages IOMMUPT. When p2p is
> > involved, still need to unbind the TDI first then unmap the BAR for
> > IOMMUPT.
> > 
> > Thanks,
> > Yilun
> > 
> > > 
> > > Jason
> 
> -- 
> Alexey
> 

