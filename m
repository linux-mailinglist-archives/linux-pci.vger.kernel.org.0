Return-Path: <linux-pci+bounces-29010-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F0EACE89F
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jun 2025 05:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3A791770CC
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jun 2025 03:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FEF31CD0C;
	Thu,  5 Jun 2025 03:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ch1dPMSt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE29F9EC
	for <linux-pci@vger.kernel.org>; Thu,  5 Jun 2025 03:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749094331; cv=none; b=gt+2RoxGP8o/ZOhSOCE6l0AXm7aDZdDuddvxkpUTanx4OKtvniVAGdoL7+lQI/JRaM0h3gLVkXp/LjYuRpvjOm/gR6pvnUudFdnYDBHhCEHkJgY/LueqnJ2epZzjgHwi4ifJy7uWRJ4qqDFzk2xhlDzA++1viWrQP6QEbOdOmME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749094331; c=relaxed/simple;
	bh=NTzExKa8fqEYOeus71pd5GRU/DgCO0gufM9JYFooOZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EB675aH2BfndSILPfdw1x0Pkft/DfExbOi6L62vNWR3dQAil0yD/0fzcd8qE3jGAEZwLfPemAYrGvVIdCSU0rhlQK33x0ZnoD9EVouwxXPJHboESafzc4p6A+ndYdjIdDXAEWFfEmWNSsGhOOKuc1IxFgLqWFLFDfuj+wtJOVGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ch1dPMSt; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749094330; x=1780630330;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NTzExKa8fqEYOeus71pd5GRU/DgCO0gufM9JYFooOZ0=;
  b=ch1dPMStXOUFR1rfq9ZfIvELpyee4oMjnaFzJ5G/5ASA38fJxKai6swU
   e8UcVTaoZGBuiHUr16drkNwE7wKGuCgUmwAfpMJPdYgURk5RAkKJQOWg2
   PmhdP3c1Qk+1OrbIdA/P+DhWChbkgf6iRvsXoiqor/aN7zvkbKkym15Fa
   FHqdzCV0nrgGGB+STCX2wvTNoBvhfRKVcBr+pyaC+2wDYrHP+cGzfww+W
   AgFlZT2AUK/I4BboE+fWj7U5F/vIOIjAXRvdAKmFaJKwmzevWvlE9f7Tz
   a/NcqmSbbdGFXRdtxTPPJBekTI162cVrGu0k8lx8U6/8wNQblH3kLFrVh
   A==;
X-CSE-ConnectionGUID: KX7tEHFKSzeiYWshHSrAKg==
X-CSE-MsgGUID: vRwfr4juTHCw5J9jR74BAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11454"; a="51292047"
X-IronPort-AV: E=Sophos;i="6.16,211,1744095600"; 
   d="scan'208";a="51292047"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 20:32:09 -0700
X-CSE-ConnectionGUID: 3QcT0micRqWNOasLI6en1g==
X-CSE-MsgGUID: FFU8mQQdQ8624jTIOoe2Ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,211,1744095600"; 
   d="scan'208";a="145413620"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa009.jf.intel.com with ESMTP; 04 Jun 2025 20:32:06 -0700
Date: Thu, 5 Jun 2025 11:25:29 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org, gregkh@linuxfoundation.org,
	lukas@wunner.de, suzuki.poulose@arm.com, sameo@rivosinc.com,
	zhiw@nvidia.com
Subject: Re: [RFC PATCH 3/3] iommufd/tsm: Add tsm_bind/unbind iommufd ioctls
Message-ID: <aEEOKXxTuUifYxJY@yilunxu-OptiPlex-7050>
References: <20250529133757.462088-1-aneesh.kumar@kernel.org>
 <20250529133757.462088-3-aneesh.kumar@kernel.org>
 <aDsta4UX76GaExrO@yilunxu-OptiPlex-7050>
 <yq5azfeqjt9i.fsf@kernel.org>
 <aD3QcQxtjoYXrglM@yilunxu-OptiPlex-7050>
 <yq5ao6v5ju6p.fsf@kernel.org>
 <aD7TZRnFualizeXk@yilunxu-OptiPlex-7050>
 <20250603121456.GF376789@nvidia.com>
 <aD/aOk9jHryygiRG@yilunxu-OptiPlex-7050>
 <20250604123118.GE5028@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250604123118.GE5028@nvidia.com>

On Wed, Jun 04, 2025 at 09:31:18AM -0300, Jason Gunthorpe wrote:
> On Wed, Jun 04, 2025 at 01:31:38PM +0800, Xu Yilun wrote:
> > On Tue, Jun 03, 2025 at 09:14:56AM -0300, Jason Gunthorpe wrote:
> > > On Tue, Jun 03, 2025 at 06:50:13PM +0800, Xu Yilun wrote:
> > > 
> > > > I see. But I'm not sure if it can be a better story than ioctl(VFIO_TSM_BIND).
> > > > You want VFIO unaware of TSM bind, e.g. try to hide pci_request/release_region(),
> > > > but make VFIO aware of TSM unbind, which seems odd ...
> > > 
> > > request_region does not need to be done dynamically. It should be done
> > > once when the VFIO cdev is opened. If you need some new ioctl to put
> > > VFIO in a CC compatible mode then it should do all this stuff once. It
> > > doesn't need to be dynamic.
> > 
> > But the unbind needs to be dynamic.
> 
> That has nothing to do with request_region.
> 
> > > I think all you want is to trigger VFIO to invalidate its MMIOs when
> > > bind/unbind happens.
> >
> > Trigger VFIO to passively invalidate MMIOs during unbind is a TDX
> > specific requirement.
> 
> I still think TDX is making this too hard, the S-EPT is controled by
> the TSM right? Why doesn't it do the map/unmap of the MMIO as part of
> the bind/unbind instead of this weird thing where the vPCI function
> creation is split up between KVM and iommufd?

That's good point, thanks. S-EPT is controlled by TSM, but the fact is,
unlike RMP it needs too much help from VMM side, and now KVM is the
helper. I will continue to investigate if TDX TSM driver could opt in to
become another helper and how to coordinate with KVM.

> 
> > Another more general requirement is, VFIO needs to trigger unbind when
> > VFIO wants to actively invalidate MMIOs. e.g. before VFIO resets device.
> > That is the dynamic unbind thing.
> 
> Alexey is right here, this is a userspace problem. VFIO should block
> FLR on an bound device.

That means VFIO should know the bound state. if VFIO cannot receive the
initial bind/unbind request from userspace, VFIO needs a callback from
IOMMUFD. I think that's what you recently suggest.

Thanks,
Yilun

> Userspace has to unbind as part of its FLR flow.
> 
> Jason

