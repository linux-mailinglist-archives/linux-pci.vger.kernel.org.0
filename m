Return-Path: <linux-pci+bounces-33410-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1160AB1AC6F
	for <lists+linux-pci@lfdr.de>; Tue,  5 Aug 2025 04:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E1D274E1F40
	for <lists+linux-pci@lfdr.de>; Tue,  5 Aug 2025 02:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B758D18FC92;
	Tue,  5 Aug 2025 02:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Faez5goL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119D0A927;
	Tue,  5 Aug 2025 02:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754361347; cv=none; b=HtcdpRnmJgWTPQjIho/ArSeE8oEGAYsz9FyAoRTSn+lul8fJ3KCmnAEYjVzvmrP86vWlxVBCQNnnA7BLLt6Zy0QHol/r8ldyPQE2jXgHyoOpnsvhNkMpD0qtCSXfCosJj621ogFFLxv9vis61VNn28EhvEzhIniIs3gMatGrkKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754361347; c=relaxed/simple;
	bh=WNJEOW8KWqBdbtvoj3VmjtsdImT7zj15PWKPLcsJXAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nTXg0yXzU+lxtOKg/KjT62p6rlQ5Z3H31LPyEyS4q6DLAeseQ9kgC5J5gPh9imWmVNRKqofH50Mxbqq0Z3GI22UASHxDgQBlqR/arI+I9vf0EfGOO3rY++gtXKKtBTGgVFRmTup7CHBqGwmhJOFwtQ7KEnlQyjlGwuVWgKKTKKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Faez5goL; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754361346; x=1785897346;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WNJEOW8KWqBdbtvoj3VmjtsdImT7zj15PWKPLcsJXAk=;
  b=Faez5goLHe5vYZal0pqC6idZYpJDHE3Nlz51S5j0wvi69IVDkog1LKZ4
   QVzk5k0bg4rZCjbbNpAziC+wHPgx19PVa5foLfhfVxLwAgg36nXw3tC3V
   m1myaAHlmYWhdsl5b0Gt0EiEZhzrEAyVHLhwRMtdJubavSs7S0whQfskj
   B0wNuc0mNi7t0979AWVoKPLVdbJnXNjIRCsNZvUHwhQHfENcdjIMIQfex
   NhAQj4uNQWxiNOtqHJLWzjakKkyFYRhsodkJ1Nf/xUtlYm3I4rPIRRmup
   xds5mwgnFnKaapZQxK44IPLRcmMb4xocGSwO74QzUghLlp0OBbziFCLDI
   Q==;
X-CSE-ConnectionGUID: xZJNLWbdR82Rx0u3NPg/bg==
X-CSE-MsgGUID: Wga05cSgQ5iWJtdD34VVew==
X-IronPort-AV: E=McAfee;i="6800,10657,11512"; a="67217352"
X-IronPort-AV: E=Sophos;i="6.17,265,1747724400"; 
   d="scan'208";a="67217352"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2025 19:35:45 -0700
X-CSE-ConnectionGUID: /YnWTCSyTmu5PHjREof3iQ==
X-CSE-MsgGUID: JeLk3g5WR5mXt7k4FP7kmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,265,1747724400"; 
   d="scan'208";a="163577182"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa006.jf.intel.com with ESMTP; 04 Aug 2025 19:35:42 -0700
Date: Tue, 5 Aug 2025 10:26:06 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	linux-coco@lists.linux.dev, kvmarm@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	aik@amd.com, lukas@wunner.de, Samuel Ortiz <sameo@rivosinc.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [RFC PATCH v1 06/38] iommufd: Add and option to request for bar
 mapping with IORESOURCE_EXCLUSIVE
Message-ID: <aJFrvsURkhpTJgh8@yilunxu-OptiPlex-7050>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
 <20250728135216.48084-7-aneesh.kumar@kernel.org>
 <20250728140841.GA26511@ziepe.ca>
 <yq5a34afbdtl.fsf@kernel.org>
 <20250729142917.GF26511@ziepe.ca>
 <aInBxnVIu+lnkzlV@yilunxu-OptiPlex-7050>
 <20250731122217.GR26511@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250731122217.GR26511@ziepe.ca>

On Thu, Jul 31, 2025 at 09:22:17AM -0300, Jason Gunthorpe wrote:
> On Wed, Jul 30, 2025 at 02:55:02PM +0800, Xu Yilun wrote:
> > On Tue, Jul 29, 2025 at 11:29:17AM -0300, Jason Gunthorpe wrote:
> > > On Tue, Jul 29, 2025 at 01:58:54PM +0530, Aneesh Kumar K.V wrote:
> > > > Jason Gunthorpe <jgg@ziepe.ca> writes:
> > > > 
> > > > > On Mon, Jul 28, 2025 at 07:21:43PM +0530, Aneesh Kumar K.V (Arm) wrote:
> > > > >> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> > > > >
> > > > > Why would we need this?
> > > > >
> > > > > I can sort of understand why Intel would need it due to their issues
> > > > > with MCE, but ARM shouldn't care either way, should it?
> > > > >
> > > > > But also why is it an iommufd option? That doesn't seem right..
> > > > >
> > > > > Jason
> > > > 
> > > > This is based on our previous discussion https://lore.kernel.org/all/20250606120919.GH19710@nvidia.com
> > > 
> > > I suggested a global option, this is a per-device option, and that
> > > especially seems wrong for iommufd. If it is per-device that is vfio,
> > 
> > I think this should be per-device.
> 
> IMHO there is no use case for that, it should arguably be global to
> the whole kernel.

I think there are 2 topics here:

1. Prevent VFIO mmap
2. Prevent /sys/../resource, /dev/mem users

I assume you are refering to the 2nd, then I agree.

> 
> > The original purpose of this pci_region_request_*() is to prevent
> > further mmap/read/write against a vfio_cdev FD which would be used
> 
> No way, the VFIO internal mmap should be controled by VFIO not by

I assume your point is never to use more than one request region in the
same driver to achieve some mutual exclusion. I'm good to it. We could
switch to some bound flag.

> request region. If you want to block that it should be blocked by
> iommufd telling VFIO that the device is bound which revokes the
> mmaps/dmabufs/etc and prevents opening new ones.

Agree.

> 
> The only thing request region should do is prevent /sys/../resource,
> /dev/mem users and so on, which is why it can and should be
> global. Arguably VFIO should always block those things but
> historically hasn't..

Agree. So seems no need a global option?

Thanks,
Yilun

> 
> There should only be one request region call in VFIO, it should
> ideally happen when the VFIO driver probes the device.
> 
> Jason

