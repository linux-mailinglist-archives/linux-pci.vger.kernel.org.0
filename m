Return-Path: <linux-pci+bounces-3871-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7773685F8E7
	for <lists+linux-pci@lfdr.de>; Thu, 22 Feb 2024 13:55:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 275AB1F266B5
	for <lists+linux-pci@lfdr.de>; Thu, 22 Feb 2024 12:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A1E12E1D3;
	Thu, 22 Feb 2024 12:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VGdiXxTn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2A760B90;
	Thu, 22 Feb 2024 12:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708606502; cv=none; b=B33UlLxPdDI/+x9V1ykFfrV7mM5GL+iIDLfYho/MDwR3esR4DqHhGeLDvMp5JVG+8CHljfRiNPAzOSwsuyQq4D89C00Ljfj3nhnByykNVblH1ihS0k28GIRMviq4a014XBr9lyd6ELvnJZobZ+4E4JomZaLcm/0NXr3kIif3L94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708606502; c=relaxed/simple;
	bh=cVfB0yeCoQ1d3ZYvhoeMYL94HZ5I4I0dl5HnrRLOySE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YCs7DTvv53BFh3ave0Qj76p6zjSV/Qmq5uvH4pmqjNrs4IFpfe7ga1XrscMOpVsnaxOZQFkICxW4WL2aeRMV+grBbNeJ/mM4mmrGooSdrEIMGXlmfNregNqoeJiiFeWXMm88cPh9BqLVoWnVKJmOTv/Nj7ZFFLI6Ng2zvopH9bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VGdiXxTn; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708606501; x=1740142501;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cVfB0yeCoQ1d3ZYvhoeMYL94HZ5I4I0dl5HnrRLOySE=;
  b=VGdiXxTn6I6vgnNbzzpMG0q/OYAbWf9qTb0sJwQrzXPB/ZJFuSHXlS8Y
   N9QpQJ1+30n8pmlgVCSPxVuZ6LSZM+qS/tIco8fvkbVXxW2JJXTCaFH9J
   k5QJyX0xVJnrK7rOzJWZ/UuwgJh6dxzNVU2kVdJ90komTU1nRTB9En8pQ
   n9FDzPe6khrlCUlUIRO2w5MyA65DC4ymB0/HE7wMCgUGqxnA5Ea3fVCr7
   3G72892XXsL9K9g0oO4O74OCMYUt0WIaNIe2v3iszFA9SvJ4XDrLIA1jq
   uJWJaOsGZE8NMgO8F0xk7wdEicU6M+pDjVnoMd3PAjS2dFd4/+GUWMptR
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="14243689"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="14243689"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 04:55:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="913518859"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="913518859"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.249.171.222]) ([10.249.171.222])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 04:54:56 -0800
Message-ID: <9c4637d5-6496-4c68-b2db-4be1e56ca746@linux.intel.com>
Date: Thu, 22 Feb 2024 20:54:54 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, kevin.tian@intel.com, dwmw2@infradead.org,
 will@kernel.org, lukas@wunner.de, yi.l.liu@intel.com,
 dan.carpenter@linaro.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 Haorong Ye <yehaorong@bytedance.com>
Subject: Re: [PATCH v13 1/3] PCI: make pci_dev_is_disconnected() helper public
 for other drivers
Content-Language: en-US
To: Ethan Zhao <haifeng.zhao@linux.intel.com>, bhelgaas@google.com,
 robin.murphy@arm.com, jgg@ziepe.ca
References: <20240222090251.2849702-1-haifeng.zhao@linux.intel.com>
 <20240222090251.2849702-2-haifeng.zhao@linux.intel.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240222090251.2849702-2-haifeng.zhao@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/2/22 17:02, Ethan Zhao wrote:
> Make pci_dev_is_disconnected() public so that it can be called from
> Intel VT-d driver to quickly fix/workaround the surprise removal
> unplug hang issue for those ATS capable devices on PCIe switch downstream
> hotplug capable ports.
> 
> Beside pci_device_is_present() function, this one has no config space
> space access, so is light enough to optimize the normal pure surprise
> removal and safe removal flow.
> 
> Tested-by: Haorong Ye<yehaorong@bytedance.com>
> Signed-off-by: Ethan Zhao<haifeng.zhao@linux.intel.com>
> ---
>   drivers/pci/pci.h   | 5 -----
>   include/linux/pci.h | 5 +++++
>   2 files changed, 5 insertions(+), 5 deletions(-)

Hi PCI subsystem maintainers,

The iommu drivers (including, but not limited to, the Intel VT-d driver)
require a helper to check the physical presence of a PCI device in two
scenarios:

- During the iommu_release_device() path: This ensures the device is
   physically present before sending device TLB invalidation to device.

- During the device driver lifecycle when a device TLB invalidation
   timeout event is generated by the IOMMU hardware: This helps handle
   situations where the device might have been hot-removed.

While there may be some adjustments needed in patch 3/3, I'd like to
confirm with you whether it's feasible to expose this helper for general
use within the iommu subsystem.

If you agree with this change, I can route this patch to Linus through
the iommu tree with an "acked-by" or "reviewed-by" tag from you.

Best regards,
baolu

