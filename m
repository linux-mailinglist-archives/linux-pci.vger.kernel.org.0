Return-Path: <linux-pci+bounces-1363-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB8981DD79
	for <lists+linux-pci@lfdr.de>; Mon, 25 Dec 2023 02:56:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CC3A1C210D1
	for <lists+linux-pci@lfdr.de>; Mon, 25 Dec 2023 01:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095C67E8;
	Mon, 25 Dec 2023 01:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UsVRw5ph"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C197A654;
	Mon, 25 Dec 2023 01:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703469385; x=1735005385;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lJKBmsKSaf98v268MnuzYweQaXuBoMMN5q9WBA7B5FA=;
  b=UsVRw5phpGbz5AtiqAZpdovaKYWADSoPiLE6PshFWeJ5XkX8AxAw4K/B
   0Bs21TLfpDPuCvuRNkFxx9xKETonZLKMJUrWvuGnaUnEvejqh8DfGFbqQ
   vrZq9pd6xeNk5j6pNG3cEOS3mR2zP05v5elNtdjdNDuhUJDv0mFhBo3Wp
   UAAk2PRogWvu0zw4Qz9ivgfQuVpSmQQHli0zUcs6KfaIxdspnLS6bOtRY
   mYoaE8+LFW+Ix3AuHtUx7G3rIKPAlWA3Iun+bGCJGRiuHFyBkW2XapdsY
   uYM0db4TMyHdOxrcegqeoTg//96akU4QsV5ku5L/ARkhi2m4TPV8TcK7W
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="3074620"
X-IronPort-AV: E=Sophos;i="6.04,302,1695711600"; 
   d="scan'208";a="3074620"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2023 17:56:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="950875903"
X-IronPort-AV: E=Sophos;i="6.04,302,1695711600"; 
   d="scan'208";a="950875903"
Received: from zhaohaif-mobl.ccr.corp.intel.com (HELO [10.93.26.36]) ([10.93.26.36])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2023 17:56:21 -0800
Message-ID: <ad68bfe2-15e5-4d82-a7f4-ce78399fecd7@linux.intel.com>
Date: Mon, 25 Dec 2023 09:56:18 +0800
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
Content-Transfer-Encoding: 7bit


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

this is enough for purely surprise_removal or safe_removal,

it is better to not send "ATS invalidation request" than sent,

then check device state later.


Thanks,

Ethan

> Thanks,
>
> Lukas
>

