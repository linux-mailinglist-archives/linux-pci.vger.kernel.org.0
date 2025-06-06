Return-Path: <linux-pci+bounces-29103-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D371CAD0618
	for <lists+linux-pci@lfdr.de>; Fri,  6 Jun 2025 17:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82C1C7AB56F
	for <lists+linux-pci@lfdr.de>; Fri,  6 Jun 2025 15:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414B0289E31;
	Fri,  6 Jun 2025 15:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FSJwTZa1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F95289E1D
	for <linux-pci@vger.kernel.org>; Fri,  6 Jun 2025 15:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749224841; cv=none; b=EZfsy7lq8PcKietF3uqaqGvbwN4owwJuJnn27uXSwd4JSxoY4vuZhU9JMNMugOLdzFFCNK9lgwRGoaKDHfjdCidrkDEHy8vdx6uDIv0WdaN84Aan4yEM21pGSQuqiWtrfHg60cZFH0bdfCULKOLjn7c7B8TTCvFjukgX9Ms6ffo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749224841; c=relaxed/simple;
	bh=Ssjur6v5ZfsWvWethIVQ02vvKvhPdOyOY166FKsWMpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IdB2bPORw6E1piVXOqFrBpKVTr7Id5QBiQVqPEducht2QBs3TKTEogGhReDhrRhW+Z2aH2YL7bW6My8IklaMJj1VIMlBUgYeh14KofW9NP0kOBpO8H8kRYux3i3VbcoHZW2rIvNwgIVBm8V+7ejCokPlHhf4ImOnvzSykGElwXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FSJwTZa1; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749224840; x=1780760840;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ssjur6v5ZfsWvWethIVQ02vvKvhPdOyOY166FKsWMpA=;
  b=FSJwTZa1OTeChn81C1L9t/JE03MA0pgZcOtI5k8qd3Skd7JkculBBnQK
   5IfYDJA7ieeUEzcesF5lqYUHMyReKY5GWXi2L7VNlLF/k7DaDqYWUzRBf
   oB/WtEE61eOSbWQoY+SyX00R9BzZl/CPcO+7MZEwwUWhhLWW+TlQEwXxU
   CCV6pNgc3p84+9zj13ZjOoxEeGiKYAmnH4zIR1OmC842MS7qOob2Ki4u8
   /zNtv2bZOZjbQOfHaaLeIu2HueItHNxVwITiFH+X3OJ2RVUPALt+mDB1B
   nyyVHuEuW5nQrDxmxwRD2YMsyTH+woaZsNdWKAhSTqtfgWZtm8MFhRudI
   Q==;
X-CSE-ConnectionGUID: XWu+m5IxSb+GEQxHDaI83A==
X-CSE-MsgGUID: ugO+F1vYSrOxFrPOpyVv5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11456"; a="51082669"
X-IronPort-AV: E=Sophos;i="6.16,215,1744095600"; 
   d="scan'208";a="51082669"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2025 08:47:15 -0700
X-CSE-ConnectionGUID: Cp2C8RRoQjyNz3n0NtV3vw==
X-CSE-MsgGUID: L1vfuxLbQzWacV9JsclMFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,215,1744095600"; 
   d="scan'208";a="151115771"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa005.jf.intel.com with ESMTP; 06 Jun 2025 08:47:12 -0700
Date: Fri, 6 Jun 2025 23:40:30 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alexey Kardashevskiy <aik@amd.com>,
	"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org, gregkh@linuxfoundation.org,
	lukas@wunner.de, suzuki.poulose@arm.com, sameo@rivosinc.com,
	zhiw@nvidia.com
Subject: Re: [RFC PATCH 3/3] iommufd/tsm: Add tsm_bind/unbind iommufd ioctls
Message-ID: <aEML7kUPSibTaAYk@yilunxu-OptiPlex-7050>
References: <yq5a5xhj5yng.fsf@kernel.org>
 <20250529133757.462088-1-aneesh.kumar@kernel.org>
 <20250529133757.462088-3-aneesh.kumar@kernel.org>
 <aDsta4UX76GaExrO@yilunxu-OptiPlex-7050>
 <668b023e-d299-42e1-87fc-ec83c514374e@amd.com>
 <aD3clPC8QfL1/XYF@yilunxu-OptiPlex-7050>
 <c552a298-0dde-409d-9c2d-149b2e2389bf@amd.com>
 <20250604123747.GG5028@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250604123747.GG5028@nvidia.com>

On Wed, Jun 04, 2025 at 09:37:47AM -0300, Jason Gunthorpe wrote:
> On Wed, Jun 04, 2025 at 11:47:14AM +1000, Alexey Kardashevskiy wrote:
> 
> > If it is the case of killing QEMU - then there is no usespace and
> > then it is a matter of what fd is closed first - VFIO-PCI or
> > IOMMUFD, we could teach IOMMUFD to hold an VFIO-PCI fd to guarantee
> > the order. Thanks,
> 
> It is the other way around VFIO holds the iommufd and it always
> destroys first.
> 
> We are missing a bit where the vfio destruction of the idevice does
> not clean up the vdevice too.

Seems there is still problem, the suggested flow is:

1. VFIO fops release
2. vfio_pci_core_close_device()
3. vfio_df_iommufd_unbind()
4.   iommufd_device_unbind()
5.     iommufd_device_destroy()
6.       iommufd_vdevice_destroy() (not implemented)
7.         iommufd_vdevice_tsm_unbind()

In step 2, vfio pci does all cleanup, including invalidate MMIO.
In step 7 vdevice does tsm unbind, this is not correct. TSM unbind
should be done before invalidating MMIO.

TSM unbind should always the first thing to do to release lockdown,
then cleanup physical device configuration.

Thanks,
Yilun

> 
> Jason

