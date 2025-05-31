Return-Path: <linux-pci+bounces-28768-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E939BAC9BB5
	for <lists+linux-pci@lfdr.de>; Sat, 31 May 2025 18:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33CF93A7642
	for <lists+linux-pci@lfdr.de>; Sat, 31 May 2025 16:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5B23770B;
	Sat, 31 May 2025 16:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MP1Rb79w"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6598A1CA81
	for <linux-pci@vger.kernel.org>; Sat, 31 May 2025 16:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748709105; cv=none; b=nbWnSAfI3Yj8Xtk72mogkB+e72IPPMYH6AdGtW8NYdnWOPbfuxbv4EdCk+phxfF69oxtNrV92kAK/u458v2B/0Qit/iMaxMnTumCEXXq/ckUwClAE20hNe6P1flMnFED4Ykzywh1rpdjjmkyUuh6RARDW4/7Jaee8xU/5+XVAzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748709105; c=relaxed/simple;
	bh=MmHGc5KuKeVnsB/wDtKg5/XJXoYTu39SS1n81SPEjis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C2e9eTI+Q2TebYya/t8AAYJ7CFyb++a3g2q5j49USA0RAFvGVUpftsjFSkyMtsAhtq6YyzQ2pCaOclleccXkvL9gu9Y/Mo7dzsp7gkE/vA7awVShW/1ciAtaHAN74f5+V9bGzlM/4cafKzP2if+0JR6HJPl8ezM3ZTjQwlA7/Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MP1Rb79w; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748709103; x=1780245103;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MmHGc5KuKeVnsB/wDtKg5/XJXoYTu39SS1n81SPEjis=;
  b=MP1Rb79woC8RrHRD3EvlY/Lb+AuQX+312hdzWZlrf0lCRXlNuIB/ltZC
   uROz7RpwzABzLql8Nin4zXyXmOqoIAxh6axM4uHOBKUTVN8AGu3nF78YR
   JPZVw4KieiBjLOJ26SO0OmhWQMqhi4oM6a+1cv9acmmslGOIU9p/gQ/OC
   dDioejwKIq0ckZBEc7OHv9loOX/o+xBzYioCGGS+iZN0h0uYcROHYczFi
   ajNB17RhyyNaGAhOW4FWiJPtHOSh/LPzGwfD/+Jn8PVUIiDkNDmMBaMEj
   3L4ISNypK7kZbeWUc8Fu4wIPQuxHgxTzB6+dKKoX+9T57k4jeh5nEDtJz
   A==;
X-CSE-ConnectionGUID: 5DcEbm6BSYKB0noNktp6QA==
X-CSE-MsgGUID: 67j11FwaTiS9t3/hHa8e3Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11450"; a="50700468"
X-IronPort-AV: E=Sophos;i="6.16,199,1744095600"; 
   d="scan'208";a="50700468"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2025 09:31:43 -0700
X-CSE-ConnectionGUID: kjxpTVQYTjSDWxHfrPFHYg==
X-CSE-MsgGUID: PwkgPEivQua7XL+n2TFiaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,199,1744095600"; 
   d="scan'208";a="149429620"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa005.jf.intel.com with ESMTP; 31 May 2025 09:31:40 -0700
Date: Sun, 1 Jun 2025 00:25:15 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org, gregkh@linuxfoundation.org,
	lukas@wunner.de, suzuki.poulose@arm.com, sameo@rivosinc.com,
	jgg@nvidia.com, zhiw@nvidia.com
Subject: Re: [RFC PATCH 3/3] iommufd/tsm: Add tsm_bind/unbind iommufd ioctls
Message-ID: <aDsta4UX76GaExrO@yilunxu-OptiPlex-7050>
References: <yq5a5xhj5yng.fsf@kernel.org>
 <20250529133757.462088-1-aneesh.kumar@kernel.org>
 <20250529133757.462088-3-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250529133757.462088-3-aneesh.kumar@kernel.org>

> + * struct iommu_vdevice_id - ioctl(IOMMU_VDEVICE_TSM_BIND/UNBIND)
> + * @size: sizeof(struct iommu_vdevice_id)
> + * @vdevice_id: Object handle for the vDevice. Returned from IOMMU_VDEVICE_ALLOC
> + */
> +struct iommu_vdevice_id {
> +	__u32 size;
> +	__u32 vdevice_id;
> +} __packed;
> +#define IOMMU_VDEVICE_TSM_BIND _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VDEVICE_TSM_BIND)
> +#define IOMMU_VDEVICE_TSM_UNBIND _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VDEVICE_TSM_UNBIND)

Hello, I see you are talking about the detailed implementation. But
could we firstly address the confusing whether this TSM Bind/Unbind
should be a VFIO uAPI or IOMMUFD uAPI?

In this thread [1], I was talking about TSM Bind/Unbind affects VFIO
behavior so they cannot be iommufd uAPIs which VFIO is not aware of.
At least TDX Connect cares about this problem now. And the conclusion
seems to be "have a VFIO_DEVICE_BIND(iommufd vdevice id), then have
VFIO reach into iommufd".

And some further findings [2] indicate this problem may also exist on
AMD when p2p is involved.

[1]: https://lore.kernel.org/all/20250515175658.GR382960@nvidia.com/
[2]: https://lore.kernel.org/all/aDnXxk46kwrOcl0i@yilunxu-OptiPlex-7050/

Thanks,
Yilun

> +
> +
>  /**
>   * struct iommufd_vevent_header - Virtual Event Header for a vEVENTQ Status
>   * @flags: Combination of enum iommu_veventq_flag
> -- 
> 2.43.0
> 

