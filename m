Return-Path: <linux-pci+bounces-26645-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C0DA99F9C
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 05:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EBF87AFAAE
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 03:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48331993A3;
	Thu, 24 Apr 2025 03:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vk/l1kK5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D2317B506;
	Thu, 24 Apr 2025 03:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745465488; cv=none; b=GWSlbWcd5jydmhJXyvc8F24xi3Yx51F4pWKbOxdjFO+oe7ve0CvF+mQaRQ84+0xle/NZHQnKT8Lukywmj2znLysKZF8cvBIvuvwcl/KQrW0ricKN7acu11Jqy1v0f5dXCRK/f8qccEYdPCmBKp7EQgHOwqSFYMbUpKNdg696STY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745465488; c=relaxed/simple;
	bh=y2kLle1MrYmSqCGMWABEiUSCyaHfJ+RdhWHi3vtj+AA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KCz95+do8cwU0LK0K0HX1gosQfqc3hWxsTu54gFUe6U5O2/uaGIYUimCl34pns5TRPx0qjUHshr77bX/eLeXaG2oKKLWL+wnvoMptoLk1xdhYDdAfSlBWDy9Y9qi0AT50eWQPRRPOj/fxJx0CJJsdBSuVkPbNltKuj5LYXHH0zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vk/l1kK5; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745465488; x=1777001488;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=y2kLle1MrYmSqCGMWABEiUSCyaHfJ+RdhWHi3vtj+AA=;
  b=Vk/l1kK51qaxm11f7KpvBGIymP2p+f+e3pfWrcTZYmWLu21uR5KR20bF
   1buBtUnuk1zDeKCECFMzhzx8XalwYacuD6fBf+vLZucUSBGhNK6s2thX7
   WFr2roOedZQLIW4xDV5qUczK8q+WmlT6SokYB4Fx+uLWY34H2ObqEKUSw
   7BcCm0081WtHYDAkJLpyZQMKFk30U3Nc+v/ukHd5U0cGXGICKdokq5cqV
   /QYxQo9+pRQdbtDdcWXnfjEBoe8VWnNg8HKl8DJ2Pzyyr2YURF31pkei1
   jtWp0Ffsc3TpTsQn1tM5edmi1lHSskNo7wJyKAUYc/s0XVJuxF17peBLj
   Q==;
X-CSE-ConnectionGUID: W32yidTJStyP1Zd1upp39A==
X-CSE-MsgGUID: 5sZjHLRVQJulK9XO5+GlIA==
X-IronPort-AV: E=McAfee;i="6700,10204,11412"; a="46787544"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="46787544"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 20:31:27 -0700
X-CSE-ConnectionGUID: fEM4eomdQBSmLpVcSi364Q==
X-CSE-MsgGUID: Yl7Nxak5TyKyrZ+wFPh+dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="137488251"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 20:31:24 -0700
Message-ID: <a65d90f2-b6c6-4230-af52-8f676b3605c5@linux.intel.com>
Date: Thu, 24 Apr 2025 11:27:07 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rc] iommu: Skip PASID validation for devices without PASID
 capability
To: Tushar Dave <tdave@nvidia.com>, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, kevin.tian@intel.com, jgg@nvidia.com,
 yi.l.liu@intel.com, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org, stable@vger.kernel.org
References: <20250424020626.945829-1-tdave@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20250424020626.945829-1-tdave@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/24/25 10:06, Tushar Dave wrote:
> Generally PASID support requires ACS settings that usually create
> single device groups, but there are some niche cases where we can get
> multi-device groups and still have working PASID support. The primary
> issue is that PCI switches are not required to treat PASID tagged TLPs
> specially so appropriate ACS settings are required to route all TLPs to
> the host bridge if PASID is going to work properly.
> 
> pci_enable_pasid() does check that each device that will use PASID has
> the proper ACS settings to achieve this routing.
> 
> However, no-PASID devices can be combined with PASID capable devices
> within the same topology using non-uniform ACS settings. In this case
> the no-PASID devices may not have strict route to host ACS flags and
> end up being grouped with the PASID devices.
> 
> This configuration fails to allow use of the PASID within the iommu
> core code which wrongly checks if the no-PASID device supports PASID.
> 
> Fix this by ignoring no-PASID devices during the PASID validation. They
> will never issue a PASID TLP anyhow so they can be ignored.
> 
> Fixes: c404f55c26fc ("iommu: Validate the PASID in iommu_attach_device_pasid()")
> Cc:stable@vger.kernel.org
> Signed-off-by: Tushar Dave<tdave@nvidia.com>
> ---
>   drivers/iommu/iommu.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 4f91a740c15f..e01df4c3e709 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -3440,7 +3440,13 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
>   
>   	mutex_lock(&group->mutex);
>   	for_each_group_device(group, device) {
> -		if (pasid >= device->dev->iommu->max_pasids) {
> +		/*
> +		 * Skip PASID validation for devices without PASID support
> +		 * (max_pasids = 0). These devices cannot issue transactions
> +		 * with PASID, so they don't affect group's PASID usage.
> +		 */
> +		if ((device->dev->iommu->max_pasids > 0) &&
> +		    (pasid >= device->dev->iommu->max_pasids)) {

What the iommu driver should do when set_dev_pasid is called for a non-
PASID device? The iommu driver has no sense of iommu group, hence it has
no knowledge about this device sharing an iommu group with another PASID
capable device.

