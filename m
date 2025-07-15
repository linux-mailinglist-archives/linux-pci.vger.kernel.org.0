Return-Path: <linux-pci+bounces-32144-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB75B057FE
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 12:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DAAA16DA09
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 10:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EDE9274B35;
	Tue, 15 Jul 2025 10:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TyI91Rqt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D747231A55
	for <linux-pci@vger.kernel.org>; Tue, 15 Jul 2025 10:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752575897; cv=none; b=tQg8HyINKsw330r3bckvL2c6Jim6kOOWsc7gZvZ96AH57vvDEQ1/qMhSZYbDv847tloMjMqwkeW/5mUgVmskMAfxkZqFVVQ8DCeE2le1QmnWJn39Ch+pO6OPWG+NyvWU0ET4JCLFlG7a4dLek7rAGFynfWy43WpsiVkBJ0dt8js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752575897; c=relaxed/simple;
	bh=GuOQRpiFUwJLFuIAuZc3FqEERf+Z15BAE2nEQU3m7wg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hJXoC4//6VCFYnkaumsWcD4rlK+SjXC9pY7aSjZXYOa3tdCuSqKuXUq7qvBqhyf21WDsdr6k82wL+T1q1UAEjuHXPzEEtYtTxM+wMGmSgFo1H/C99iZNSIRga/B10jVt9MAAEix5dTGoXyvlB7v8Thn8ZhdWsYWzLXw9XyiCXLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TyI91Rqt; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752575894; x=1784111894;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GuOQRpiFUwJLFuIAuZc3FqEERf+Z15BAE2nEQU3m7wg=;
  b=TyI91RqtJbhNFo6xfSgdWMKc8I2Sq1It9rBmeMjqw+hcSdqgtaPtX170
   AXiSqqDfGt2fp2oPLBxb6Qy391fcPZYIfxJdPA8kpvj04N7c6Ziog4OVM
   S1sOMAQSzMETvLwSQm2rEcjEGQ2uxy2a7LOCS01ZR6sWt448S0wgAHNQs
   lwtDMHLozWVwcnHQiTGacaE4vmhG+ZE3QOiHtNDnkuWHne7HbJwD/brlY
   TpBzx0U5fifUAiCCcbvWnTQP2mUfuJC8tkfkeTZ/q+/l77Gt5cmB3q7ff
   AeXjH/BkaLeEx7f6Ucl/CrAOAK2WtZgK3UX7O6vfv0ElXwGCXpnJb9N/z
   A==;
X-CSE-ConnectionGUID: K0d2Pp1GQnScOYmrCn+Rmw==
X-CSE-MsgGUID: x8zx2rtpTvq4BMpCiOp1BQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="65050878"
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="65050878"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 03:38:14 -0700
X-CSE-ConnectionGUID: sJ3tL2NDR76DI4DvhDehsg==
X-CSE-MsgGUID: bI7I/AH7Q2Swr4OirwzRpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="156597919"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa006.jf.intel.com with ESMTP; 15 Jul 2025 03:38:11 -0700
Date: Tue, 15 Jul 2025 18:29:35 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org, gregkh@linuxfoundation.org,
	lukas@wunner.de, suzuki.poulose@arm.com, sameo@rivosinc.com,
	jgg@nvidia.com, zhiw@nvidia.com
Subject: Re: [RFC PATCH 3/3] iommufd/tsm: Add tsm_bind/unbind iommufd ioctls
Message-ID: <aHYtj/jyfXD4XhZy@yilunxu-OptiPlex-7050>
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

On Thu, May 29, 2025 at 07:07:56PM +0530, Aneesh Kumar K.V (Arm) wrote:
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>  drivers/iommu/iommufd/iommufd_private.h |  3 +
>  drivers/iommu/iommufd/main.c            |  5 ++
>  drivers/iommu/iommufd/viommu.c          | 78 +++++++++++++++++++++++++
>  include/uapi/linux/iommufd.h            | 15 +++++
>  4 files changed, 101 insertions(+)
> 
> diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
> index 80e8c76d25f2..a323e8b18125 100644
> --- a/drivers/iommu/iommufd/iommufd_private.h
> +++ b/drivers/iommu/iommufd/iommufd_private.h
> @@ -606,6 +606,8 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd);
>  void iommufd_viommu_destroy(struct iommufd_object *obj);
>  int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd);
>  void iommufd_vdevice_destroy(struct iommufd_object *obj);
> +int iommufd_vdevice_tsm_bind_ioctl(struct iommufd_ucmd *ucmd);
> +int iommufd_vdevice_tsm_unbind_ioctl(struct iommufd_ucmd *ucmd);

Hello:

I recently have another concern about the vdevice tsm bind/unbind API.
And need your inputs.

According to this:
https://lore.kernel.org/all/aC9QPoEUw_nLHhV4@google.com/

Sean illustrates the memory in-place conversion, that the memory
owner - gmemfd should own & control the memory shareability) and
the conversion. I.e. For in-place conversion,
KVM_SET_MEMORY_ATTRIBUTES should be disabled.

Private/shared MMIO must be of in-place conversion, similarly it's
the MMIO owner should be responsible for MMIO shareability, maybe adding
some new ioctls like MMIO_CONVERT_SHARED/PRIVATE.

From previous discussion, VFIO is the MMIO owner (implement as dmabuf
exporter), so manages MMIO shareability. And IOMMUFD vdevice is the TDI
state owner for TSM bind/unbind. But MMIO shareability & TDI state are
actually correlated, do we really want to manage them in 2 components?

Thanks,
Yilun

