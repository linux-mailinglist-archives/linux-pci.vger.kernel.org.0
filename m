Return-Path: <linux-pci+bounces-29519-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67659AD6785
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 07:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 025B4189B8EB
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 05:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1889D2AE6D;
	Thu, 12 Jun 2025 05:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FuVybg2A"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5755B1EF394
	for <linux-pci@vger.kernel.org>; Thu, 12 Jun 2025 05:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749707486; cv=none; b=TzIKnoF4hUkWR3rmYz5y/9nTOyMHhP9XwBZT2rXhKfikH41j8dVVxPd11TfOWN04wT/YlQIYh++vRj9wDiPXzD5wxYaNTblSuwmqf/VAPXOnYh3qjnIGXvxHnwG7OCPrgqIs/KSr7pWszFqxuWhzYSo3m3fi+4ryHPXpS1216G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749707486; c=relaxed/simple;
	bh=urUwsAon5fRFQ5sS9HdZlWSmga2hGGL48QQcV2/RZzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AGYFdNcew7Y62Yu40Ex31ALYUVR1C03MsEjS8WLqgInwfpYA0VfHu6LdRsycF/TmwW7wPSfGPXKcmvtz0j3PVa63btmtxacFfqf+7+NIVcGykS6y7YdhCVk8tKfxevsVysdPBoeRiSOfaxq0JhtTHsOYf6OixIe5eio/Cf/pcpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FuVybg2A; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749707484; x=1781243484;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=urUwsAon5fRFQ5sS9HdZlWSmga2hGGL48QQcV2/RZzU=;
  b=FuVybg2AEYYWtmgbX/48VfODzTNkOLSPzkJBK/EBnherUN65KTyEtbb1
   HtHGYJxMNK3nBKRxEIaXh0+FwTeRAORzwjPt7H7NELcpoxq3yT+dIM2Y9
   D5Hh0C6Oqz6uTaA0lzpU6lsTAMsJyRPM4OXAzIw1CpXQWBgPGX+iDbANF
   PYYH/l3RM+EbIdBwOqbLldzzwXGP9jiZuJ/t+9zQX/f/2hUR6uSxNLHwG
   M8tbX439rXCylflK3G02SRdUf7V4q+vA08qr/PrwaUReYNhuxExK3Iaa7
   sWYju2b7e0bYBCQuPEDOQXuYOZAXNln7ARYDEBcGj9iM3xQM6JXyqm+Cv
   A==;
X-CSE-ConnectionGUID: koRIcr7QRgSyTSuTLoQhMA==
X-CSE-MsgGUID: lNXPrc91Tfi4i7BKXsUSMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="51955111"
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; 
   d="scan'208";a="51955111"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 22:51:24 -0700
X-CSE-ConnectionGUID: 28wxkEgqQD29vgYWjEUN6A==
X-CSE-MsgGUID: yjPY9bsSQcqSAdnsZRulYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; 
   d="scan'208";a="147771501"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa008.fm.intel.com with ESMTP; 11 Jun 2025 22:51:21 -0700
Date: Thu, 12 Jun 2025 13:44:23 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org, gregkh@linuxfoundation.org,
	lukas@wunner.de, suzuki.poulose@arm.com, sameo@rivosinc.com,
	zhiw@nvidia.com
Subject: Re: [RFC PATCH 3/3] iommufd/tsm: Add tsm_bind/unbind iommufd ioctls
Message-ID: <aEppN++Z7j4ZJJVk@yilunxu-OptiPlex-7050>
References: <20250529133757.462088-1-aneesh.kumar@kernel.org>
 <20250529133757.462088-3-aneesh.kumar@kernel.org>
 <aDsta4UX76GaExrO@yilunxu-OptiPlex-7050>
 <yq5azfeqjt9i.fsf@kernel.org>
 <aD3QcQxtjoYXrglM@yilunxu-OptiPlex-7050>
 <yq5ao6v5ju6p.fsf@kernel.org>
 <aD7TZRnFualizeXk@yilunxu-OptiPlex-7050>
 <20250603121456.GF376789@nvidia.com>
 <aD/aOk9jHryygiRG@yilunxu-OptiPlex-7050>
 <bccd4693-775f-401d-a2fc-237510066366@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bccd4693-775f-401d-a2fc-237510066366@amd.com>

On Tue, Jun 10, 2025 at 05:31:41PM +1000, Alexey Kardashevskiy wrote:
> 
> 
> On 4/6/25 15:31, Xu Yilun wrote:
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
> > 
> > > 
> > > I think all you want is to trigger VFIO to invalidate its MMIOs when
> > > bind/unbind happens.
> > 
> > Trigger VFIO to passively invalidate MMIOs during unbind is a TDX
> > specific requirement.
> > 
> > 
> > Another more general requirement is, VFIO needs to trigger unbind when
> > VFIO wants to actively invalidate MMIOs. e.g. before VFIO resets device.
> > That is the dynamic unbind thing.
> > 
> > The reason is the secure DMA silent drop issue.  Intel, and seems
> > AMD (Alexey please confirm) both implemented some policy in FW/HW to block
> > this issue. But the consequences are fatal to OS, so better we avoid
> > this.
> 
> Why does it have to be fatal to any OS? A device which suddenly stops working is not something unheard of, not a good reason to kill an OS. Blocking MMIO or DMA seems like an adequate response.

It is fatal before any recovery solution is already in the OS. There are
plenty of BUG_ON()s in kernel but from HW's POV they may not be the end
of world. If recovery is more complex than prevention from SW's POV,
let's prevent it and bail out if we failed to prevent.

AMD's ASID fence (and Intel & ARM's DMA Silent Drop protection) are the
ways to ensure security, but let's try best not to trigger them.

Thanks,
Yilun

> 
> 
> > [1]: https://lore.kernel.org/all/aDnXxk46kwrOcl0i@yilunxu-OptiPlex-7050/
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

