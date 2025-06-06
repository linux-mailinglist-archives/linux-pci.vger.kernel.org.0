Return-Path: <linux-pci+bounces-29119-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B63AD09FF
	for <lists+linux-pci@lfdr.de>; Sat,  7 Jun 2025 00:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 050BF179B8F
	for <lists+linux-pci@lfdr.de>; Fri,  6 Jun 2025 22:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66609230BF1;
	Fri,  6 Jun 2025 22:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P6oRJOVq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE2E218ACC;
	Fri,  6 Jun 2025 22:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749249491; cv=none; b=pL/kIXIUYqw19s+Fsn8NP0gd5FSTQ515dA9XmW+45sFZqorkB0ZqNFc8W8Jn6FaMaqTkOqe23XZEH8Cef6iuitcp4BhZ7Vxfd8hAzQmyLnLFf6/6Oc/sqhea//lrz7a00g/38MHDg0Z4tACcqAgKkPBw5lpRS7ghfw0cMm4Q1dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749249491; c=relaxed/simple;
	bh=MiAlGzDCGdtNRx+aS6Sqk/MyysYaqJ7V1HeWmUHq96E=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dQmTlq1+ADf/YQQmLkkTEd/fhdpbA1T8Wnlp42Lm+4pjuKnSlnQnf8GIW7cLSMczM2MmGoI3gUltLFI/p1DPPWWBMUNNsmKGuWKQgvL9F4pcmDlu9hzW7RCOFQJ7DWR2pJ9Cd8mfyJaxQ4Rdts3KubdtFkY33uiJjdLH3tG/VQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P6oRJOVq; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749249489; x=1780785489;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=MiAlGzDCGdtNRx+aS6Sqk/MyysYaqJ7V1HeWmUHq96E=;
  b=P6oRJOVqYfC+o/7vS5Vf8a3jzEkHfMHhPhkzXiVQvsjhamjXO9NHpJKf
   VR4Mx5fAvDFbDV6OYS17bqPuncuAGfRSnyJcQn5Gslc/dEkgg6dGnXc2A
   U1MoIAItZ2SJiOjWc+7G0Jtd2lQ8sgILUz/DtGwKR+hoYo0Hp2SSP/HkU
   8rrzHFteDI0ZahL38tzHl7iCjxUzZHnL9I+oxewcTlBPE5yg/2XF/7HcT
   HQZJBLw+gH06M2vbeuzkJZabm5ciSInsdjFc+A+bpT6XjlzBf9k2L+twi
   6aJCs73ReWBpkCymHqO+RWxaGI28kww2j3ZzVFGp6Y+LOTyhBawhVHXhn
   Q==;
X-CSE-ConnectionGUID: 2fMNygCSTKmxpM9uInaleA==
X-CSE-MsgGUID: Dc9C33M5T3OtLEDL0dAaIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11456"; a="68967579"
X-IronPort-AV: E=Sophos;i="6.16,216,1744095600"; 
   d="scan'208";a="68967579"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2025 15:38:08 -0700
X-CSE-ConnectionGUID: RLeOCq6SRsS+gqZU3VHp3g==
X-CSE-MsgGUID: wDcPHGCUTPG5XIj1gU1iow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,216,1744095600"; 
   d="scan'208";a="149773191"
Received: from spandruv-desk1.amr.corp.intel.com (HELO [10.125.111.33]) ([10.125.111.33])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2025 15:38:04 -0700
Message-ID: <c09c31bd-aa4f-4ea0-b35b-3dc4abac871a@intel.com>
Date: Fri, 6 Jun 2025 15:38:00 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 11/16] cxl/pci: Update __cxl_handle_cor_ras() to return
 early if no RAS errors
To: "Bowman, Terry" <terry.bowman@amd.com>,
 PradeepVineshReddy.Kodamati@amd.com, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 bhelgaas@google.com, bp@alien8.de, ming.li@zohomail.com,
 shiju.jose@huawei.com, dan.carpenter@linaro.org,
 Smita.KoralahalliChannabasappa@amd.com, kobayashi.da-06@fujitsu.com,
 yanfei.xu@intel.com, rrichter@amd.com, peterz@infradead.org, colyli@suse.de,
 uaisheng.ye@intel.com, fabio.m.de.francesco@linux.intel.com,
 ilpo.jarvinen@linux.intel.com, yazen.ghannam@amd.com,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20250603172239.159260-1-terry.bowman@amd.com>
 <20250603172239.159260-12-terry.bowman@amd.com>
 <e2d30ea5-1b9a-4e11-9065-3b30582de09a@intel.com>
 <e633dcd9-2208-4eb0-aeed-61af0206f6d1@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <e633dcd9-2208-4eb0-aeed-61af0206f6d1@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/6/25 1:55 PM, Bowman, Terry wrote:
> 
> 
> On 6/6/2025 3:30 PM, Dave Jiang wrote:
>>
>> On 6/3/25 10:22 AM, Terry Bowman wrote:
>>> __cxl_handle_cor_ras() is missing logic to leave the function early in the
>>> case there is no RAS error. Update __cxl_handle_cor_ras() to exit early in
>>> the case there is no RAS errors detected after applying the mask.
>> This change is small enough that I would just fold it into the patch that introduces this function.
>>
>> DJ
> I agree. The problem is it was already present before this series. This is a 'fix'. I had this change in:
> [PATCH v9 09/16] cxl/pci: Log message if RAS registers are unmapped
> but was asked to move out because it appeared as an unrelated miscellaneous patch.

Ok. Then

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> 
> Terry
>>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>>> ---
>>>  drivers/cxl/core/pci.c | 9 +++++----
>>>  1 file changed, 5 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>>> index 0f4c07fd64a5..f5f87c2c3fd5 100644
>>> --- a/drivers/cxl/core/pci.c
>>> +++ b/drivers/cxl/core/pci.c
>>> @@ -677,10 +677,11 @@ static void __cxl_handle_cor_ras(struct device *dev, u64 serial,
>>>  
>>>  	addr = ras_base + CXL_RAS_CORRECTABLE_STATUS_OFFSET;
>>>  	status = readl(addr);
>>> -	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
>>> -		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
>>> -		trace_cxl_aer_correctable_error(dev, serial, status);
>>> -	}
>>> +	if (!(status & CXL_RAS_CORRECTABLE_STATUS_MASK))
>>> +		return;
>>> +	writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
>>> +
>>> +	trace_cxl_aer_correctable_error(dev, serial, status);
>>>  }
>>>  
>>>  static void cxl_handle_endpoint_cor_ras(struct cxl_dev_state *cxlds)
> 


