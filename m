Return-Path: <linux-pci+bounces-28935-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E64FACD781
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 07:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A61287A1C86
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 05:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757CB2C3251;
	Wed,  4 Jun 2025 05:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WuChfmIe"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8948A236A8B
	for <linux-pci@vger.kernel.org>; Wed,  4 Jun 2025 05:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749015499; cv=none; b=fK5VhJLSAkPWiPXpARnFKu5hVnaEcq26Oq1O0RbvXOVqDTroov4IJ9hAIwoEMa0uLLx2Mz0rLJ66nCYlx48dRuDwPKDNRqF1jVEoqtu7cTP7shr+NzDGrXr/MZmIlCGRXJk6qlbM9xy2Ls3nwSa9KOQyAO7NPoHgXKnyC823iN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749015499; c=relaxed/simple;
	bh=QSZv0EQayc014nA0EoLvF3M8IG3/6LURCFGFKHKp5nM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZDsJGKIk/km4mdwx2PAEp98o0tZcS13L+f2CzS6AqUThIVhq9e2HtHPrCQvromMYRjSxT5Z6XS/9SDwhFJiJzP07kksWpP4LZtOjDH2Cy926kO9StnWr8JNprr2GImi1N+PiwZUu9ADrs31ydOWJ0+K+fe2MSphNTxptXRbxbok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WuChfmIe; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749015497; x=1780551497;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QSZv0EQayc014nA0EoLvF3M8IG3/6LURCFGFKHKp5nM=;
  b=WuChfmIecRw8t9ibCAF4QVeA89c+6EyKZ2VKTdpGowpXSmVRlxxjQYV+
   SLO2Tfby/QWAaU7B4wWM/cEVRLcH7fahIIMQaKE6BWmrZvV9kjRLNXmvI
   0LsotAUASZRp96tG5BidR9tCWXP+7sSimt2TSGKzNktvMNzIQObQ5eu2g
   jQfRPAPzkJ0IQexg3Gn3ExfGWsaOGSju7qxLSfYU97XS51iJTgk3HD2IT
   UXuJYN6bhL7Y06vHYWPO5YRiNSk9wP4pqAqg3QQAIEJHiMG9tMJalRKxX
   QhItET1hQSB2w/LNOefCbNw3Zer/SuIQ9C5UuFK9Y6yranqKJG7Xp4MnD
   A==;
X-CSE-ConnectionGUID: 11/XuxNoQJq49aBsgwS4yw==
X-CSE-MsgGUID: dVW+z1BGQ8yfJ2/R3xzYkQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="51222751"
X-IronPort-AV: E=Sophos;i="6.16,208,1744095600"; 
   d="scan'208";a="51222751"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 22:38:15 -0700
X-CSE-ConnectionGUID: URuMuUBSRyOGwXLQiDdIBg==
X-CSE-MsgGUID: t9HUkNDpStGEzYmUX4ChzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,208,1744095600"; 
   d="scan'208";a="145685874"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa007.jf.intel.com with ESMTP; 03 Jun 2025 22:38:13 -0700
Date: Wed, 4 Jun 2025 13:31:38 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org, gregkh@linuxfoundation.org,
	lukas@wunner.de, suzuki.poulose@arm.com, sameo@rivosinc.com,
	zhiw@nvidia.com
Subject: Re: [RFC PATCH 3/3] iommufd/tsm: Add tsm_bind/unbind iommufd ioctls
Message-ID: <aD/aOk9jHryygiRG@yilunxu-OptiPlex-7050>
References: <yq5a5xhj5yng.fsf@kernel.org>
 <20250529133757.462088-1-aneesh.kumar@kernel.org>
 <20250529133757.462088-3-aneesh.kumar@kernel.org>
 <aDsta4UX76GaExrO@yilunxu-OptiPlex-7050>
 <yq5azfeqjt9i.fsf@kernel.org>
 <aD3QcQxtjoYXrglM@yilunxu-OptiPlex-7050>
 <yq5ao6v5ju6p.fsf@kernel.org>
 <aD7TZRnFualizeXk@yilunxu-OptiPlex-7050>
 <20250603121456.GF376789@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250603121456.GF376789@nvidia.com>

On Tue, Jun 03, 2025 at 09:14:56AM -0300, Jason Gunthorpe wrote:
> On Tue, Jun 03, 2025 at 06:50:13PM +0800, Xu Yilun wrote:
> 
> > I see. But I'm not sure if it can be a better story than ioctl(VFIO_TSM_BIND).
> > You want VFIO unaware of TSM bind, e.g. try to hide pci_request/release_region(),
> > but make VFIO aware of TSM unbind, which seems odd ...
> 
> request_region does not need to be done dynamically. It should be done
> once when the VFIO cdev is opened. If you need some new ioctl to put
> VFIO in a CC compatible mode then it should do all this stuff once. It
> doesn't need to be dynamic.

But the unbind needs to be dynamic.

> 
> I think all you want is to trigger VFIO to invalidate its MMIOs when
> bind/unbind happens.

Trigger VFIO to passively invalidate MMIOs during unbind is a TDX
specific requirement.


Another more general requirement is, VFIO needs to trigger unbind when
VFIO wants to actively invalidate MMIOs. e.g. before VFIO resets device.
That is the dynamic unbind thing.

The reason is the secure DMA silent drop issue.  Intel, and seems
AMD (Alexey please confirm) both implemented some policy in FW/HW to block
this issue. But the consequences are fatal to OS, so better we avoid
this.

[1]: https://lore.kernel.org/all/aDnXxk46kwrOcl0i@yilunxu-OptiPlex-7050/

Thanks,
Yilun

> 
> Jason

