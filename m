Return-Path: <linux-pci+bounces-28078-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E37ABD2EB
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 11:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A642E8A61B7
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 09:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF14266EFC;
	Tue, 20 May 2025 09:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aL+LzJSU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7849B266B59;
	Tue, 20 May 2025 09:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747732374; cv=none; b=dsXqIVo2fR3ixLixU9Z/xkZLhGL6FSbzJSm/U3fIdnDdOyude0HpETDTD+LsHg7GASUSDplVtKOUZTXDsqeiTtuC1Hdb2yg9LwFbXWgEPF4jYYRP+UqeGWZVfQRvwISALyTmSBb1IL6O0guqQeTSvyjWcHD0l8c6YQAjMgoKhmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747732374; c=relaxed/simple;
	bh=VyNSIUVE3L1AVI9sfU40qgyG3ZplchlZ8Y8Ao5j96PM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LluF4Apjswxq+70q5cVFaF3dwlGCgI4BcGR3FGe5xnreRzMyKjlt63bFfq733LwBPVv5rA2J3gbekXD3nDm0cpWlAYeGvsMAr/TTJnZPbcBmZL6CBFLx4Jz5lEVRIMohNlId3IvTJ7gibpcOueJ+9MD5JlFadtfzXuKNt754+oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aL+LzJSU; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747732372; x=1779268372;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VyNSIUVE3L1AVI9sfU40qgyG3ZplchlZ8Y8Ao5j96PM=;
  b=aL+LzJSUzSnOxPN8rIMqHhaEzbe2jVJkRi4Mb3bKoyV6641ARzYWZzjK
   D2nZv7JBdmo7Yp4kVBwAp+b91rmZlOk7MX1AnCDTg6E1JgtTMQek8UGhd
   PWlQrCJCfLKR3wy07vPtGs+72oySg7L1vQic7XEWlinAN9HQGfTly9GE3
   IVgUddP9KcY3vnICGrhb0p1uWFxHH9/Xqe94Wr/BGxu7B6pxXKFw2lvkn
   fdE35Ahmu4ORFUAMI/y8QiF6XXMN20WHAXa5W4rLV51fQJX8PgFHyUec8
   l+2lEyYgggQPnnvu2HddJNkCo6DjwQmDG4b+VN7TPDWOVP7BCE/qqnnxW
   w==;
X-CSE-ConnectionGUID: GkA0bKEaTQiQwbEKU2RiOQ==
X-CSE-MsgGUID: jhsPU6WzRfO6cGsCoRrRNg==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="49810070"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="49810070"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 02:12:51 -0700
X-CSE-ConnectionGUID: zyRZGchVQy2k9iJkYhgmYg==
X-CSE-MsgGUID: cLs/JexxRjufODmenBzt8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="162938153"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.243.99]) ([10.124.243.99])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 02:12:49 -0700
Message-ID: <b8ab3c01-0602-4980-8c31-0d16c5de2545@linux.intel.com>
Date: Tue, 20 May 2025 17:12:46 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, linux-pci@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v4 rc] iommu: Skip PASID validation for devices without
 PASID capability
To: Tushar Dave <tdave@nvidia.com>, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, kevin.tian@intel.com, jgg@nvidia.com,
 yi.l.liu@intel.com, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250520011937.3230557-1-tdave@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20250520011937.3230557-1-tdave@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/20/2025 9:19 AM, Tushar Dave wrote:
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
> 
> changes in v4:
> - rebase to 6.15-rc7
> 
>   drivers/iommu/iommu.c | 43 ++++++++++++++++++++++++++++---------------
>   1 file changed, 28 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 4f91a740c15f..9d728800a862 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -3366,10 +3366,12 @@ static int __iommu_set_group_pasid(struct iommu_domain *domain,
>   	int ret;
>   
>   	for_each_group_device(group, device) {
> -		ret = domain->ops->set_dev_pasid(domain, device->dev,
> -						 pasid, old);
> -		if (ret)
> -			goto err_revert;
> +		if (device->dev->iommu->max_pasids > 0) {
> +			ret = domain->ops->set_dev_pasid(domain, device->dev,
> +							 pasid, old);
> +			if (ret)
> +				goto err_revert;
> +		}

You can save an indent by making it like this,

for_each_group_device(group, device) {
	if (device->dev->iommu->max_pasids == 0)
		continue;

	ret = domain->ops->set_dev_pasid(domain, device->dev, pasid, old);
	if (ret)
		goto err_revert;
}

Anyway,

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

