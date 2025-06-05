Return-Path: <linux-pci+bounces-29008-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DB9ACE82F
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jun 2025 04:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 789D47A6777
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jun 2025 02:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748DC1F463C;
	Thu,  5 Jun 2025 02:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rvu9d4Da"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35A61F1315
	for <linux-pci@vger.kernel.org>; Thu,  5 Jun 2025 02:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749089091; cv=none; b=E5mJsyFaLwb8yX9W4IKjLrvSvhLzATtvy8TaMCj82DtrsSaFZSfXAS40l14Dqm7iAUXR4JlxpfTALc7dPa5JpuMIB/hN/R9CPOvEZ09TGvb0y04jv1tZkgkxw3TsxTXB/s0B/V3FwmSd6oEL1K+ChSGfa0QKV8xCI5Hu9DBEFFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749089091; c=relaxed/simple;
	bh=5xQjQm64eBMsdAVzVvc7nw4U+cKpKvwXYISqgbmgNrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ePTFMQ3ahh/sbeXXg0ROv0fphCUtux7OsVCpJo/dk2EHT/xiGEksmzZgRzFXIhRn4qFEX4iXWQWXdPP9BFaSqpZHrVGODhNKkmnyFkmU7HGId2uCWtVqPqDAAhSW2Bip9uUj6FRSru9TOdd2VGFFs2VO/Id/jj3JG1pdr9aCQZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rvu9d4Da; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749089090; x=1780625090;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5xQjQm64eBMsdAVzVvc7nw4U+cKpKvwXYISqgbmgNrU=;
  b=Rvu9d4Da7u2DfX2jnOGO2AMre9UGlbwKbeas5w9pe0CgxeMGhdTxIPYJ
   wqZkW+JEOv8gMKpge3HMMof3PLuz1lqhjXjzYA9cHCIOxF9aLSIGN1TOt
   O17D31cerHV24cbtemVZ5ilt1QoB7k4KQqly0Uo6ayqYGe6fo05mAGwI0
   yhmHBEreZsI9u1YmMZDUIkUSZsDIrvw2IcpXwQDEfQjftx9mxE+5u0KmW
   J9fwrQBtEk/1Wdxom77KDsYzJCK6Uzg48mumfDzwCqREP2sYPa7Jew6dE
   zt063GarKvRex++f2MxKEBD4y4Ap/oMzbikSitkaxzf3XqGjQ680vzSZt
   A==;
X-CSE-ConnectionGUID: dr+oB5VzS5qKPk1X5CXiUw==
X-CSE-MsgGUID: 801i0sMdT0KmHhZMQ09pww==
X-IronPort-AV: E=McAfee;i="6800,10657,11454"; a="51338646"
X-IronPort-AV: E=Sophos;i="6.16,210,1744095600"; 
   d="scan'208";a="51338646"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 19:04:49 -0700
X-CSE-ConnectionGUID: QgI2aEPVSc+A+QviE1QO1g==
X-CSE-MsgGUID: w8xCxDJoQgadgioYyrISjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,210,1744095600"; 
   d="scan'208";a="150233038"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa005.fm.intel.com with ESMTP; 04 Jun 2025 19:03:28 -0700
Date: Thu, 5 Jun 2025 09:56:51 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org, gregkh@linuxfoundation.org,
	lukas@wunner.de, suzuki.poulose@arm.com, sameo@rivosinc.com,
	zhiw@nvidia.com
Subject: Re: [RFC PATCH 3/3] iommufd/tsm: Add tsm_bind/unbind iommufd ioctls
Message-ID: <aED5Y4ndEj3MIYqk@yilunxu-OptiPlex-7050>
References: <yq5a5xhj5yng.fsf@kernel.org>
 <20250529133757.462088-1-aneesh.kumar@kernel.org>
 <20250529133757.462088-3-aneesh.kumar@kernel.org>
 <aDsta4UX76GaExrO@yilunxu-OptiPlex-7050>
 <20250602124718.GY233377@nvidia.com>
 <aD5wVXINV1QJnMbO@yilunxu-OptiPlex-7050>
 <20250603120810.GD376789@nvidia.com>
 <aD/qF/6vjxjJEXcM@yilunxu-OptiPlex-7050>
 <20250604123900.GH5028@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250604123900.GH5028@nvidia.com>

On Wed, Jun 04, 2025 at 09:39:00AM -0300, Jason Gunthorpe wrote:
> On Wed, Jun 04, 2025 at 02:39:19PM +0800, Xu Yilun wrote:
> > On Tue, Jun 03, 2025 at 09:08:10AM -0300, Jason Gunthorpe wrote:
> > > On Tue, Jun 03, 2025 at 11:47:33AM +0800, Xu Yilun wrote:
> > > 
> > > > VFIO doesn't have enough information, but VFIO needs to know about
> > > > bound state. So comes the suggestion [1] that the VFIO uAPI, then VFIO
> > > > reach into iommufd for real bind.
> > > > 
> > > > And my implementation [2] is:
> > > > 
> > > > ioctl(vfio_cdev_fd, VFIO_DEVICE_TSM_BIND)
> > > > -> vfio_iommufd_tsm_bind()
> > > >    -> iommufd_device_tsm_bind()
> > > >       -> iommufd_vdevice_tsm_bind()
> > > >          -> pci_tsm_bind()
> > > 
> > > This doesn't work, logically you are binding the vdevice, not the
> > > idevice, the uapi should provide the vdevice id, which VFIO doesn't
> > > have.
> > 
> > Yes. Sorry I just too lazy to provide the full API format.
> > 
> > The original suggestion [1] is to provide vdevice_id in VFIO uAPI.
> > 
> > [1] https://lore.kernel.org/all/20250515175658.GR382960@nvidia.com/
> > 
> > And here is a piece of the implementation in [2]:
> > 
> > +struct vfio_pci_tsm_bind {
> > +	__u32	argsz;
> > +	__u32	flags;
> > +	__u32	vdevice_id;
> > +	__u32	pad;
> > +};
> > +
> > +#define VFIO_DEVICE_TSM_BIND		_IO(VFIO_TYPE, VFIO_BASE + 22)
> 
> I don't want to pass iommufd IDs through vfio as much as possibile, it
> makes no logical sense.

OK.

Thanks,
Yilun

