Return-Path: <linux-pci+bounces-2862-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 670FE84368C
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jan 2024 07:21:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99DD41C230BE
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jan 2024 06:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94463E48F;
	Wed, 31 Jan 2024 06:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KaWI4yUS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29293E481;
	Wed, 31 Jan 2024 06:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706682088; cv=none; b=BGpJvapJOsmOSiMIDgaRi9iWliyO7ds8RNFmTLPScnnX7mAOgpMT7JBHOGuB8iih+RHtl1hAHvRdGBGaQ4IS8xGyYwbmq5OTwNsNZXYPngWMeNiJ2XxgMTV0OLOt+5PFwLJUrUp6Ku5qtH2q4jVTtvpw6f/s3E4GU6JX/72DaOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706682088; c=relaxed/simple;
	bh=BFal/c7OdPWIXpcKKVgoT+h8Uly3mTIFcWBHU8qcqPc=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SUSH3/W80CbpfPLwgPPUfGbTLiVjYifl2RwT4B2dAoJ0H6mClaWxz02FVfllVCVzWuHj3ChIIQRH3iivM3VTIInwDSRMw9nOoBQafv7X9EGT3tfw2ElisPWRLQ+WwqjQHZHQYK8JHYPFKxRY4xZzMqiygKlAtPMbPFbMa/OfZNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KaWI4yUS; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706682087; x=1738218087;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BFal/c7OdPWIXpcKKVgoT+h8Uly3mTIFcWBHU8qcqPc=;
  b=KaWI4yUS7aDiFgNzqm2DN3a0d+v0lNWDZSsQ3+qrRR09/EArXmZMCuyL
   O+NSpok14vmV5hFNaijh8A4+ITzVbKrdeF8pS7YTi5WP+3QRo6XPxpTwv
   lZSiyUCNH3w1zXVunAfmKPWyI5RuFw1k+MkNlzxr/spUoGD/uSdTApX50
   C3C65IXDjj5ezhMKxXfN8UwBb3AxgPUlDnxD45b76jBTJTN+knH0zGNjc
   XXfH4Do49iBrLOqsfbQViK6mkrprCa0ysWqdyACpWPKV/O22y6RYaNQ1Q
   IXtYo2wIriXzZCUQq55yOO79fo8AM0WMwSZDwphgWEEXdb/rbDVV/BUvH
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="3347747"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="3347747"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 22:21:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="36759621"
Received: from wwang17-mobl.ccr.corp.intel.com (HELO [10.249.175.9]) ([10.249.175.9])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 22:21:22 -0800
Message-ID: <6a48f023-2701-4f2f-8077-14fe348794dd@linux.intel.com>
Date: Wed, 31 Jan 2024 14:21:20 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, "Tian, Kevin" <kevin.tian@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "bhelgaas@google.com"
 <bhelgaas@google.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>,
 "will@kernel.org" <will@kernel.org>, "lukas@wunner.de" <lukas@wunner.de>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v12 5/5] iommu/vt-d: improve ITE fault handling if target
 device isn't present
To: Jason Gunthorpe <jgg@ziepe.ca>, Ethan Zhao <haifeng.zhao@linux.intel.com>
References: <20240129034924.817005-1-haifeng.zhao@linux.intel.com>
 <20240129034924.817005-6-haifeng.zhao@linux.intel.com>
 <BN9PR11MB52761CC3E5F08D4B7BAD7F918C7E2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <7adec292-9d38-41ab-a982-bd840b24f3ab@intel.com>
 <0aee453c-e98f-4b72-8107-31d4731abcdb@linux.intel.com>
 <BN9PR11MB5276D3372267CE9246170FA78C7D2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <500c4582-ec05-4a9e-9b68-d2ae19aed49b@linux.intel.com>
 <20240130162958.GF50608@ziepe.ca>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240130162958.GF50608@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/1/31 0:29, Jason Gunthorpe wrote:
> On Tue, Jan 30, 2024 at 04:15:33PM +0800, Ethan Zhao wrote:
>> Some tricky situations:
>>
>> 1. The ATS invalidation request is issued from driver driver, while it is
>> in handling, device is removed. this momment, the device instance still
>> exists in the bus list. yes, if searching it by BDF, could get it.
>>
>> 2. The ATS invalidation request is issued from iommu_bus_notifier()
>> for surprise removal reason, as shown in above calltrace, device was
>> already removed from bus list. if searching it by BDF, return NULL.
>>
>> 3. The ATS invlidation request is issued from iommu_bus_notifier()
>> for safe removal, when is in handling, device is removed or link
>> is down. also as #2, device was already removed from bus list.
>> if searching it by BDF. got NULL.
>> ...
>>
>> so, searching device by BDF, only works for the ATS invalidation
>> request is from device driver.
> In the good path, where the hot removal is expected and this is about
> coordinating, the IOMMU driver should do an orderly shutdown of the
> ATS mechanism:
> 
>   1 Write to PCI config space to disable the ATS
>   2 Make the IOMMU respond to ATS requests with UR and set it to BLOCKED
>   3 Issue a flush of the ATC
>   4 Wait for all outstanding ATC flushes to complete
> 
> If it is a bad/surprise path where the device is already gone then:
> 
>   1 should automatically not do anything, possibly timing out
>   2 must succeed
>   3 should time out
>   4 should "complete" in that the ATC flushes are all timed out
> 
> IMHO all you need to do is not crash/lockup while processing the ATC
> timeouts. If this is a surprise path then the ATC timeout might
> already happened before the iommu driver remove notifier event happens.
> 
> If the driver needs to translate from the IOMMU device table index
> into a struct device it is probably best to do that inside the driver.
> 
> eg ARM maintains a rbtree in the iommu dev data. (see
> arm_smmu_insert_master)

An rbtree for IOMMU device data for the VT-d driver would be beneficial.
It also benefits other paths of fault handling, such as the I/O page
fault handling path, where it currently still relies on the PCI
subsystem to convert a RID value into a pci_device structure.

Given that such an rbtree would be helpful for multiple individual
drivers that handle PCI devices, it seems valuable to implement it in
the core?

Best regards,
baolu

