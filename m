Return-Path: <linux-pci+bounces-1359-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB4281DD61
	for <lists+linux-pci@lfdr.de>; Mon, 25 Dec 2023 02:00:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F7E21F212A0
	for <lists+linux-pci@lfdr.de>; Mon, 25 Dec 2023 01:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281D962A;
	Mon, 25 Dec 2023 01:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hcTwZxd4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1D17E8;
	Mon, 25 Dec 2023 01:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703466013; x=1735002013;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cw8P6jFNr/pX4FwXQvyBKJRYwD9Hbo8sO1lxAhKnHGQ=;
  b=hcTwZxd4dR75NIi039wUawb+gKt+FKOC4VHCWPi0GXi7JY3HoZuEPH5c
   OgCgUMRxNzg9lWfT2wrgaf1Y+Z1N2YfKM9uBSXUFkP8UAHz+q8B3EHHdv
   XTzhRx9OAr8PmMRh0wqlQgGfmUiqzDVZhYG6OMOR8EpXX5RRw8SR/spo2
   ueGk/Gka71daF4MNa4si/C4rZ7xIuZIMim+uPuF9emiNBsKCdBmh9kfoT
   JVdxubg2Gkvb9POT46JIaU8J0aN+c/+W0NGh5QmB48x9rylntQS0V4RZM
   np8UOZcVPjnQu0rWCbAQ58HX16vCWDXovU3GAE5NMmeUKZE1y3zC15QqG
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="375751293"
X-IronPort-AV: E=Sophos;i="6.04,302,1695711600"; 
   d="scan'208";a="375751293"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2023 17:00:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,302,1695711600"; 
   d="scan'208";a="19667125"
Received: from zhaohaif-mobl.ccr.corp.intel.com (HELO [10.93.26.36]) ([10.93.26.36])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2023 17:00:10 -0800
Message-ID: <563d4144-f1ad-4603-ba51-667232be3add@linux.intel.com>
Date: Mon, 25 Dec 2023 09:00:08 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v6 2/4] iommu/vt-d: don's issue devTLB flush request
 when device is disconnected
To: Lukas Wunner <lukas@wunner.de>
Cc: bhelgaas@google.com, baolu.lu@linux.intel.com, dwmw2@infradead.org,
 will@kernel.org, robin.murphy@arm.com, linux-pci@vger.kernel.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20231224050657.182022-1-haifeng.zhao@linux.intel.com>
 <20231224050657.182022-3-haifeng.zhao@linux.intel.com>
 <20231224103225.GA31197@wunner.de>
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
In-Reply-To: <20231224103225.GA31197@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 12/24/2023 6:32 PM, Lukas Wunner wrote:
> On Sun, Dec 24, 2023 at 12:06:55AM -0500, Ethan Zhao wrote:
>> --- a/drivers/iommu/intel/pasid.c
>> +++ b/drivers/iommu/intel/pasid.c
>> @@ -481,6 +481,9 @@ devtlb_invalidation_with_pasid(struct intel_iommu *iommu,
>>   	if (!info || !info->ats_enabled)
>>   		return;
>>   
>> +	if (pci_dev_is_disconnected(to_pci_dev(dev)))
>> +		return;
>> +
>>   	sid = info->bus << 8 | info->devfn;
>>   	qdep = info->ats_qdep;
>>   	pfsid = info->pfsid;
> Do you even need this or is patch [4/4] sufficient?
> Is there a benefit to the hunk above on top of patch [4/4]?

Need this,  I don't want to access config space here, check the

flag here is enough, but patch [4/] needs to know if the device

  is gone by reading device vendor info.


Thanks,

Ethan


> Thanks,
>
> Lukas

