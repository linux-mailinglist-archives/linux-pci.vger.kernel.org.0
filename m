Return-Path: <linux-pci+bounces-33152-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D07EB15925
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 08:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F46618A6A0B
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 06:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184481F5823;
	Wed, 30 Jul 2025 06:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A61U6QZB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DDA1F4C92;
	Wed, 30 Jul 2025 06:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753858373; cv=none; b=UCI18G/62CfhdFbeOsj5q7YnBbwjxFshYq7go5aMedSEzkn8JDZeNMyMKUmnXYPPIThOIKIF5cNi+8JDQzLeVrpJXpHDKUzFwmeOCZMeOHWP30dbrhbuNbLbxZKK+FILk9XJVVLnSq1DKp/HSSrTP0TYGngYV68ZpmtWmL3lsXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753858373; c=relaxed/simple;
	bh=7OGyvNg7RATkxbxEUz2W1V8qPCkZTTFRPvx4rkkG0yo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dgvKeRP3DGksxJE7tLJrmiirKmqPZardcxsHdlDNFdwnwwr+CgyJHfTCVogI/HvwPXS6pMGH3thMRQ0VVIT15/XzJTpZ2Lko2GskQ/ea0k5c7b5eD5u+oujUT/nUesbHBRrhUqNRRwWDSauaLSwK+Oi58E0JFdZbRQaTR9Yj1UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A61U6QZB; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753858371; x=1785394371;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7OGyvNg7RATkxbxEUz2W1V8qPCkZTTFRPvx4rkkG0yo=;
  b=A61U6QZBLpsAj81ChF5sPWV7UU9mxS4DNQXInrTl9Zz6mDlJI2y4YWbo
   OzUJD8S3nH3cgACOACTa3cuHSniC+5ERi/9uEh7ztFz1LHFYl8rYUJfi/
   ieJvhxOJT5ROitpan1td2sM5BSzoJO56vtxDP3qXBk95D3gyTx64SmAzT
   yWAU3Md7nneb/ovBaGmWt9dLSFptIFPMrTIRHLWXWlx7oFML4MgMQC8bN
   ppzXdljguomEqDngj7YP+TBj1Qd11NNb9za4m0y42S+sJiLEUiH7L1y2G
   rBPzECFQLz2zCXIIoRQgVNYsQW4uFIJbxlnGxaR0hGJW1qLmMVJE5n7K1
   A==;
X-CSE-ConnectionGUID: KsvrMuzuRJOnG2aB3VaKAw==
X-CSE-MsgGUID: pR+slbxJTuyId3ZFWmmWNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11506"; a="56227438"
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="56227438"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2025 23:52:50 -0700
X-CSE-ConnectionGUID: Hr79EHAhRQqjX7DKPUXkVA==
X-CSE-MsgGUID: efddGYvwS96+x3Wq3Ik7ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; 
   d="scan'208";a="200088693"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa001.jf.intel.com with ESMTP; 29 Jul 2025 23:52:47 -0700
Date: Wed, 30 Jul 2025 14:43:28 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: linux-coco@lists.linux.dev, kvmarm@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	aik@amd.com, lukas@wunner.de, Samuel Ortiz <sameo@rivosinc.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [RFC PATCH v1 06/38] iommufd: Add and option to request for bar
 mapping with IORESOURCE_EXCLUSIVE
Message-ID: <aIm/EFCoGdNmhaou@yilunxu-OptiPlex-7050>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
 <20250728135216.48084-7-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728135216.48084-7-aneesh.kumar@kernel.org>

> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index 6328c3a05bcd..bee3cf3226e9 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -1753,8 +1753,15 @@ int vfio_pci_core_mmap(struct vfio_device *core_vdev, struct vm_area_struct *vma
>  	 * we need to request the region and the barmap tracks that.
>  	 */
>  	if (!vdev->barmap[index]) {
> -		ret = pci_request_selected_regions(pdev,
> +
> +		if (core_vdev->iommufd_device &&
> +		    iommufd_device_need_exclusive_range(core_vdev->iommufd_device))
> +			ret = pci_request_selected_regions_exclusive(pdev,
> +							1 << index, "vfio-pci");
> +		else
> +			ret = pci_request_selected_regions(pdev,
>  						   1 << index, "vfio-pci");
> +
>  		if (ret)
>  			return ret;

I did't get the idea.

The purpose of my original patch [1] is not to make VFIO choose between
pci_request_regions_exclusive() or pci_request_regions(). It is mainly
to prevent userspace mmap/read/write against a vfio_cdev FD. For
example:

  If pci_request_selected_regions() is succesfully executed on mmap(),
  later TSM Bind would fail on its pci_request_regions_exclusive(). It
  means userspace should not mmap otherwise you can't do private
  assignment. Vice versa, if you've done TSM Bind, you cannot mmap
  anymore.

The _exclusive is just a bonus that further prevents "/dev/mem and the
sysfs MMIO access"

[1]: https://lore.kernel.org/all/20250529053513.1592088-20-yilun.xu@linux.intel.com/

Thanks,
Yilun

