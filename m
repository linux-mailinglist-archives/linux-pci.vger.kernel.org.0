Return-Path: <linux-pci+bounces-28816-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ACC8ACB9A9
	for <lists+linux-pci@lfdr.de>; Mon,  2 Jun 2025 18:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D44A179EC5
	for <lists+linux-pci@lfdr.de>; Mon,  2 Jun 2025 16:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72D91C7008;
	Mon,  2 Jun 2025 16:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nBRF3ThK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5235E522F
	for <linux-pci@vger.kernel.org>; Mon,  2 Jun 2025 16:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748881916; cv=none; b=NrWMJAyUvIJ6hkzfUUMfM+a7FH39mLEeqYDQD3EYduem6+lsGGBE8pAw/luuArdvMfIYKfGgE3k92GVPccsBIzTWP+jeQmchEzneDo/jwFl2R1yCTpN4d6aD10yTLRa2vP0ys+vciNlRg/C6UcEdOg7pjldD33vgnNBfmqp3dQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748881916; c=relaxed/simple;
	bh=ABESuQNba/ISfVxE254p2L8JnPE59Hyu3kS39KIqGqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MpnwOYcxHvgzJXH4hhnisjX0vgVvzeJlVKpS0WVTndF0BLh3QPU9Lk6BFeUX44a3n15rKAkdLlbpbvWssRMHJULGifI5CDKG/41h3GWp0tF5ClvOexoE8zrj1LbukrGprjNICUD/0+d5scUMYxeHA0TfD4JTNOvbiGRz1ngEMJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nBRF3ThK; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748881916; x=1780417916;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ABESuQNba/ISfVxE254p2L8JnPE59Hyu3kS39KIqGqQ=;
  b=nBRF3ThK3WfhxuDY5zkhqwicbitqKQLUh9zSRIGAk1e2ElXzA6uJQ4XZ
   S+uXTkJBPUDj/velUAG2VM9iHZ7qNl9P9iRfewMVOh6vr0sMCpptIRFFS
   ATF2Cwa+MDjVAYR4rxfqV6C9Gp7JoMsi1ARn/c4mixVeqlMO+fRa9Iske
   sVbFgf2tSu9tHvwbKUqxnzs32owaztWt1n1wmkFQcoricnFnlDlpDW/Ww
   Bp3Nl/4IGavP4pRWT0w0ggWbi7DPTBIH+TUzdEV5xE1bqjs9VkBNGHwvt
   x9PIURa0y2Td13kjyGQzpV4uixSFJQtXavw9/PIUqB0YNCoVb/0BW6Xd2
   w==;
X-CSE-ConnectionGUID: hhoFafjPSUuQL+MKQVg5Hg==
X-CSE-MsgGUID: ao8V5kbpQDyC3gVB6RErwQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11451"; a="50768350"
X-IronPort-AV: E=Sophos;i="6.16,203,1744095600"; 
   d="scan'208";a="50768350"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2025 09:31:55 -0700
X-CSE-ConnectionGUID: JhQrP/C/SASMFQjjYNadag==
X-CSE-MsgGUID: gttifzdhQDaggP3Vk4F7KA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,203,1744095600"; 
   d="scan'208";a="144619835"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa009.jf.intel.com with ESMTP; 02 Jun 2025 09:31:52 -0700
Date: Tue, 3 Jun 2025 00:25:21 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org, gregkh@linuxfoundation.org,
	lukas@wunner.de, suzuki.poulose@arm.com, sameo@rivosinc.com,
	jgg@nvidia.com, zhiw@nvidia.com
Subject: Re: [RFC PATCH 3/3] iommufd/tsm: Add tsm_bind/unbind iommufd ioctls
Message-ID: <aD3QcQxtjoYXrglM@yilunxu-OptiPlex-7050>
References: <yq5a5xhj5yng.fsf@kernel.org>
 <20250529133757.462088-1-aneesh.kumar@kernel.org>
 <20250529133757.462088-3-aneesh.kumar@kernel.org>
 <aDsta4UX76GaExrO@yilunxu-OptiPlex-7050>
 <yq5azfeqjt9i.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yq5azfeqjt9i.fsf@kernel.org>

On Mon, Jun 02, 2025 at 04:38:09PM +0530, Aneesh Kumar K.V wrote:
> Xu Yilun <yilun.xu@linux.intel.com> writes:
> 
> >> + * struct iommu_vdevice_id - ioctl(IOMMU_VDEVICE_TSM_BIND/UNBIND)
> >> + * @size: sizeof(struct iommu_vdevice_id)
> >> + * @vdevice_id: Object handle for the vDevice. Returned from IOMMU_VDEVICE_ALLOC
> >> + */
> >> +struct iommu_vdevice_id {
> >> +	__u32 size;
> >> +	__u32 vdevice_id;
> >> +} __packed;
> >> +#define IOMMU_VDEVICE_TSM_BIND _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VDEVICE_TSM_BIND)
> >> +#define IOMMU_VDEVICE_TSM_UNBIND _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VDEVICE_TSM_UNBIND)
> >
> > Hello, I see you are talking about the detailed implementation. But
> > could we firstly address the confusing whether this TSM Bind/Unbind
> > should be a VFIO uAPI or IOMMUFD uAPI?
> >
> > In this thread [1], I was talking about TSM Bind/Unbind affects VFIO
> > behavior so they cannot be iommufd uAPIs which VFIO is not aware of.
> > At least TDX Connect cares about this problem now. And the conclusion
> > seems to be "have a VFIO_DEVICE_BIND(iommufd vdevice id), then have
> > VFIO reach into iommufd".
> >
> > And some further findings [2] indicate this problem may also exist on
> > AMD when p2p is involved.
> >
> > [1]: https://lore.kernel.org/all/20250515175658.GR382960@nvidia.com/
> > [2]: https://lore.kernel.org/all/aDnXxk46kwrOcl0i@yilunxu-OptiPlex-7050/
> >
> 
> Looking at your patch series, I understand the reason you need a vfio
> ioctl is to call pci_request_regions_exclusive—is that correct?

The immediate reason is to unbind the TDI before unmapping the BAR.

> 
> In another thread, I asked whether this might be better handled by
> pci_tsm instead of vfio. I'd be interested in your thoughts on that.
> 
> I also noticed you want to unbind the TDI before unmapping the BAR in
> vfio. From what I understand, this should still be possible if we use an
> iommufd ioctl.

I'm not sure how is that possible.

> Either approach—a vfio or iommufd ioctl—works fine for my
> needs. We can continue that discussion in your patch series thread.

Yeah, let's discuss in that thread.

> 
> -aneesh

