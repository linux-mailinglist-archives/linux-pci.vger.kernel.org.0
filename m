Return-Path: <linux-pci+bounces-1498-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5511581F8C7
	for <lists+linux-pci@lfdr.de>; Thu, 28 Dec 2023 14:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 104C3284A5C
	for <lists+linux-pci@lfdr.de>; Thu, 28 Dec 2023 13:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CFEA8466;
	Thu, 28 Dec 2023 13:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="azbnPFA9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF0779E2;
	Thu, 28 Dec 2023 13:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703769641; x=1735305641;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=l3y/rOXTcNM/KMjrfFxiHVoiCGwjaWFGIo5EQtn4TYA=;
  b=azbnPFA9iKLjRwZMhagY4BuGCHMWBj9/MJkb4noRbrltgUXPvAP2q7Gj
   EfVmWk3mIj8hG3+JqPyUj1V3PXFTi26/0BCE6Xku7rheQeBolNGtrzc7+
   4p0H76SXP+OaJ1NIuomJE/tyBwpYsfHUNbiLvDSQYvM+mR0w1JhJwagH/
   Im7Z4w6tTG/4Q/Dj+P4w8HOtTjt+hzTRLhYtsksyyRBoUkgjiEa9QAIQx
   Fa/Db4SfxWKgp+5xtb+icLT/YLyzteazlx7qVpqi+k0JK3BaKL2GLAYQo
   1GA3g4fhzV6x2PjGy0VrRoptDMHrMpF05zeWrgtcH/+ogkGyF9FAb+13g
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="400355127"
X-IronPort-AV: E=Sophos;i="6.04,312,1695711600"; 
   d="scan'208";a="400355127"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2023 05:20:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="782039401"
X-IronPort-AV: E=Sophos;i="6.04,312,1695711600"; 
   d="scan'208";a="782039401"
Received: from zhaohaif-mobl.ccr.corp.intel.com (HELO [10.249.169.62]) ([10.249.169.62])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2023 05:20:37 -0800
Message-ID: <160a7f08-1e73-4468-80d8-6ac5974d81d3@linux.intel.com>
Date: Thu, 28 Dec 2023 21:20:35 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v9 1/5] iommu/vt-d: add flush_target_dev member to
 struct intel_iommu and pass device info to all ATS Invalidation functions
To: "Tian, Kevin" <kevin.tian@intel.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>,
 "will@kernel.org" <will@kernel.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "lukas@wunner.de" <lukas@wunner.de>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20231228001646.587653-1-haifeng.zhao@linux.intel.com>
 <20231228001646.587653-2-haifeng.zhao@linux.intel.com>
 <BN9PR11MB5276126B3D950AA2F23520898C9EA@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
In-Reply-To: <BN9PR11MB5276126B3D950AA2F23520898C9EA@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 12/28/2023 4:10 PM, Tian, Kevin wrote:
>> From: Ethan Zhao <haifeng.zhao@linux.intel.com>
>> Sent: Thursday, December 28, 2023 8:17 AM
>>
>> @@ -181,6 +181,7 @@ static void __flush_svm_range_dev(struct intel_svm
>> *svm,
>>
>>   	qi_flush_piotlb(sdev->iommu, sdev->did, svm->pasid, address, pages,
>> ih);
>>   	if (info->ats_enabled) {
>> +		info->iommu->flush_target_dev = info->dev;
>>   		qi_flush_dev_iotlb_pasid(sdev->iommu, sdev->sid, info-
>>> pfsid,
>>   					 svm->pasid, sdev->qdep, address,
>>   					 order_base_2(pages));
> this is wrong both in concept and function.
Yes, wrong.
>
> an iommu instance can be shared by many devices which may all have
> ongoing ATS invalidation requests to handle. Using a per-iommu field
> to store the flush target is limiting (and there is no lock protection at all).
>
> if there is a real need of passing dev pointer to qi helpers, just change
> the helper to accept an explicit parameter.

seems the only way is to add parameter and refactor all affected

functions.


Thanks,

Ethan


