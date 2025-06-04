Return-Path: <linux-pci+bounces-28940-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 636A0ACD7FE
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 08:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEFA31894991
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 06:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9E21E7C08;
	Wed,  4 Jun 2025 06:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F0kb1ZZ8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F34C2B9A9
	for <linux-pci@vger.kernel.org>; Wed,  4 Jun 2025 06:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749019558; cv=none; b=WpYKWuwtiii+mAseI85zGQK9V76w3y+mgkvaaIR6C+jF5fG7nYW4JPA42Ey3HDBj0RA+KbIaRXkWfUNtYydqUbrXnQO2mJpyJ2bURNupBpQ4jYpVCKIghfZm3Wrj/r6veaDCqs8nl4ZLURraOs+P7Hle314qsDL9vywoB03xgvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749019558; c=relaxed/simple;
	bh=vlIfn92vfsClp02MAwhpS1OjU+Tz3jZdUSzWImzQIYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WZDd/0/LDERpVeM89U6Chnq0ltM/f0RQogiGWC6iNRI1b4pEoZpLSE/BNsFVaPwgAS7BTxdFw03iS2lIV7Nk7bWK3e6J7i64eiTn/68M5LF0NQ8j4yfTuKAq9M9pzDP4hnrus7oHvRJBiXIFt6lUlsPnf8U6JDKsZSz10zaBiyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F0kb1ZZ8; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749019557; x=1780555557;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vlIfn92vfsClp02MAwhpS1OjU+Tz3jZdUSzWImzQIYs=;
  b=F0kb1ZZ8WnK27Zo1sCyKMlo/4Lxm04no1T3sGaB3PqUrKff4oSo3Ng8R
   JiI07b4tBUsTG6ru09u5DuEv3eiwm56jE+E7Zl0kDR4Q18HDWiQIC3zcV
   RuTkxp8uVdWb3SDJvDiDdC5I40dRGrRd5CMAuuV4ADBQyLG7sghxamCUd
   f9oM8etwCXL76mfS3jSiORio6goxGtXBNbKDNFqWQa/UwNFASIx9Rxlnn
   NwCT7bzSniD/+XIcaG9dTlK0Js9hbWYJiQkR9aCmnNHNvxgsE9JydbLK8
   NV/BXBr+dJFjMiN1/VJtMsFuVwK1Mi5XN6Kzr1thyITxOl8ZgoOk3yu1B
   g==;
X-CSE-ConnectionGUID: oYUjTES9T62mMKDcr8uBNA==
X-CSE-MsgGUID: SAwVpd/ETRq8wOBM71t1WQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="54883909"
X-IronPort-AV: E=Sophos;i="6.16,208,1744095600"; 
   d="scan'208";a="54883909"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 23:45:56 -0700
X-CSE-ConnectionGUID: onhMhJt1StKYJ3OFpL9yKg==
X-CSE-MsgGUID: H3KZEm75QvamVrf1N5khlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,208,1744095600"; 
   d="scan'208";a="145048904"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa007.fm.intel.com with ESMTP; 03 Jun 2025 23:45:53 -0700
Date: Wed, 4 Jun 2025 14:39:19 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org, gregkh@linuxfoundation.org,
	lukas@wunner.de, suzuki.poulose@arm.com, sameo@rivosinc.com,
	zhiw@nvidia.com
Subject: Re: [RFC PATCH 3/3] iommufd/tsm: Add tsm_bind/unbind iommufd ioctls
Message-ID: <aD/qF/6vjxjJEXcM@yilunxu-OptiPlex-7050>
References: <yq5a5xhj5yng.fsf@kernel.org>
 <20250529133757.462088-1-aneesh.kumar@kernel.org>
 <20250529133757.462088-3-aneesh.kumar@kernel.org>
 <aDsta4UX76GaExrO@yilunxu-OptiPlex-7050>
 <20250602124718.GY233377@nvidia.com>
 <aD5wVXINV1QJnMbO@yilunxu-OptiPlex-7050>
 <20250603120810.GD376789@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250603120810.GD376789@nvidia.com>

On Tue, Jun 03, 2025 at 09:08:10AM -0300, Jason Gunthorpe wrote:
> On Tue, Jun 03, 2025 at 11:47:33AM +0800, Xu Yilun wrote:
> 
> > VFIO doesn't have enough information, but VFIO needs to know about
> > bound state. So comes the suggestion [1] that the VFIO uAPI, then VFIO
> > reach into iommufd for real bind.
> > 
> > And my implementation [2] is:
> > 
> > ioctl(vfio_cdev_fd, VFIO_DEVICE_TSM_BIND)
> > -> vfio_iommufd_tsm_bind()
> >    -> iommufd_device_tsm_bind()
> >       -> iommufd_vdevice_tsm_bind()
> >          -> pci_tsm_bind()
> 
> This doesn't work, logically you are binding the vdevice, not the
> idevice, the uapi should provide the vdevice id, which VFIO doesn't
> have.

Yes. Sorry I just too lazy to provide the full API format.

The original suggestion [1] is to provide vdevice_id in VFIO uAPI.

[1] https://lore.kernel.org/all/20250515175658.GR382960@nvidia.com/

And here is a piece of the implementation in [2]:

+struct vfio_pci_tsm_bind {
+	__u32	argsz;
+	__u32	flags;
+	__u32	vdevice_id;
+	__u32	pad;
+};
+
+#define VFIO_DEVICE_TSM_BIND		_IO(VFIO_TYPE, VFIO_BASE + 22)

[2] https://lore.kernel.org/all/20250529053513.1592088-20-yilun.xu@linux.intel.com/

> 
> If you really need vfio involvement then you need callbacks, I think.

Only callback is not enough, there are cases that VFIO wants actively
invalidate MMIO, e.g. VFIO_DEVICE_RESET. In that case, VFIO needs
dynamic unbind then invalidate MMIO.

Thanks,
Yilun

> 
> Jason

