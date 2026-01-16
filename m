Return-Path: <linux-pci+bounces-45066-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5DED33773
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 17:22:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 30D04300F68D
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 16:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3856134107D;
	Fri, 16 Jan 2026 16:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fi6vQTUa"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15F9340D86;
	Fri, 16 Jan 2026 16:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768580553; cv=none; b=Xr7jcweU65GK15Cc6FN9ZUOhn4njdcViB023D5roCEnVLQf4mRp4eWcIRqcSYNfMog1yK9CmYtoDWr+WKVpXvWVsJc5JZI9yCBHQmQol9B85DcAEW9vFCGv3FbTVD8rj0V+MVKwUVCQ3ccWXR1xAXKwWVJVySv42U7BwfELwZYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768580553; c=relaxed/simple;
	bh=INXBfVWa3zdklBincbUKOUp1rTQgNVhl7QErsgsXMtA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rQiOvcDobyU7IeaDqQrSj2H8274lK+oIbYId9/TA62aTLWjY/cBhBJf4UflXzFhqccEnc9PfC+oxYMkIrbftDaAd/rRYhROk2tDK0ILaVryuiikQ+Csoh5ssoyjfjBUDcB+GmzCcx8B2x4trb4yqZkwgRfjdaRtK+dG7hkEII68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fi6vQTUa; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768580550; x=1800116550;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=INXBfVWa3zdklBincbUKOUp1rTQgNVhl7QErsgsXMtA=;
  b=Fi6vQTUa9ZLtsjBNJdJLWKwLkaB2vCMQhWhGPUvSN4W/QxCMXpe0zAPh
   gqMbBLPSLPvZz8JfifvxXDkynByl2sOQivGKBcFvhVUREvyiV9WTtyICf
   9rSWwBTJeG0ILiKKaK11d7aTIlz5fzr/P8AxlUHdFRV0aE1NS98lGynVn
   BU4Frzqb4CFdwV+t/V9IaI6gXhCEkvdVV0MPTjYCBQzdSTG5R0u4mX/dJ
   G3GLv1G3C7soIOYxIz101geKZ5N1f7mhTNI3Qttmaq/vGvGvuZ+O6ENGS
   315sgR6DpdevlPW9HPYE21PLUKq9bhgqycNSn2+6sH5rhctqtdYFt5dYx
   g==;
X-CSE-ConnectionGUID: 4uIaxVnrQs2GvCoM856hkQ==
X-CSE-MsgGUID: qMSEzGJRTVeFmnQxBluXjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11673"; a="69792350"
X-IronPort-AV: E=Sophos;i="6.21,231,1763452800"; 
   d="scan'208";a="69792350"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2026 08:22:30 -0800
X-CSE-ConnectionGUID: wQqoxJMTQJ2lYlqlPc4sgw==
X-CSE-MsgGUID: 7DNvIqw1SquXFLyL3aFiCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,231,1763452800"; 
   d="scan'208";a="209760903"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.111.140]) ([10.125.111.140])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2026 08:22:28 -0800
Message-ID: <5cfa8f16-7d20-483b-856c-0c65129acf22@intel.com>
Date: Fri, 16 Jan 2026 09:22:26 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 16/34] cxl/mem: Clarify @host for
 devm_cxl_add_nvdimm()
To: dan.j.williams@intel.com, Terry Bowman <terry.bowman@amd.com>,
 dave@stgolabs.net, jonathan.cameron@huawei.com, alison.schofield@intel.com,
 bhelgaas@google.com, shiju.jose@huawei.com, ming.li@zohomail.com,
 Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
 dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
 lukas@wunner.de, Benjamin.Cheatham@amd.com,
 sathyanarayanan.kuppuswamy@linux.intel.com, linux-cxl@vger.kernel.org,
 vishal.l.verma@intel.com, alucerop@amd.com, ira.weiny@intel.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20260114182055.46029-1-terry.bowman@amd.com>
 <20260114182055.46029-17-terry.bowman@amd.com>
 <7a02a650-cbd6-46a8-a6b1-b0d816dd6376@intel.com>
 <6969ab82253a5_34d2a10048@dwillia2-mobl4.notmuch>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <6969ab82253a5_34d2a10048@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/15/26 8:07 PM, dan.j.williams@intel.com wrote:
> Dave Jiang wrote:
>>
>>
>> On 1/14/26 11:20 AM, Terry Bowman wrote:
>>> From: Dan Williams <dan.j.williams@intel.com>
>>>
>>> The convention for devm_ helpers in the CXL driver is that the first
>>> argument is the @host for the operation (locked driver::probe() context).
>>>
>>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>>> Reviewed-by: Terry Bowman <terry.bowman@amd.com>
>>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>>
>> A nit below
>>
>>>
>>> ---
>>>
>>> Changes in v13 -> v14:
>>> - New patch
>>> ---
>>>  drivers/cxl/core/pmem.c | 13 +++++++------
>>>  drivers/cxl/cxl.h       |  3 ++-
>>>  drivers/cxl/mem.c       |  2 +-
>>>  3 files changed, 10 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/cxl/core/pmem.c b/drivers/cxl/core/pmem.c
>>> index 8853415c106a..e7b1e6fa0ea0 100644
>>> --- a/drivers/cxl/core/pmem.c
>>> +++ b/drivers/cxl/core/pmem.c
>>> @@ -237,12 +237,13 @@ static void cxlmd_release_nvdimm(void *_cxlmd)
>>>  
>>>  /**
>>>   * devm_cxl_add_nvdimm() - add a bridge between a cxl_memdev and an nvdimm
>>> - * @parent_port: parent port for the (to be added) @cxlmd endpoint port
>>> - * @cxlmd: cxl_memdev instance that will perform LIBNVDIMM operations
>>> + * @host: host device for devm operations
>>> + * @port: any port in the CXL topology to find the nvdimm-bridge device
>>> + * @cxlmd: parent of the to be created cxl_nvdimm device
>>>   *
>>>   * Return: 0 on success negative error code on failure.
>>>   */
>>> -int devm_cxl_add_nvdimm(struct cxl_port *parent_port,
>>> +int devm_cxl_add_nvdimm(struct device *host, struct cxl_port *port,
>>
>> s/port/parent_port/ to maintain clarity of the port
> 
> ...but it is not used as a "parent" port in this function. Any port in
> the topology will do. The reason a port argument is needed is
> disambiguate when there are multiple CXL root devices. That currently
> only happens when cxl_test is loaded.
> 
> However, after writing that, it may make more sense to make that
> semantic explicit and just have the caller responsible for passing in an
> @cxl_root argument.
> 
> A change for not this series.

I'll make a note in the backlog.


