Return-Path: <linux-pci+bounces-8426-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E1B8FF849
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jun 2024 01:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 509A01F23104
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jun 2024 23:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164D013AD30;
	Thu,  6 Jun 2024 23:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ByL86Psd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E157482F6;
	Thu,  6 Jun 2024 23:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717717583; cv=none; b=IZjbtKpoyIMeieoMc54svkORjqBWuxWxpF3ChwPZ7BZ7voVpm9dAzVLAHPatTb8pomSZ/5ALQ1O5hSf9C7LSjjKloNlM1LACYJ4lJtfBPITWQVT7si4KxJDBRWOS5L6IGG70ypDzB6sja5uFxG+tEeX3RykzK2/uKkUNRR9mIJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717717583; c=relaxed/simple;
	bh=d3lVr7y+iFHv8wwedctZB9AFZ1krdSdNt0KrBO603Rc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=KkIlzeI1/kMb36odX50YiiG8ftUPhCM8rBc5sksjQ0he//Lt883bJYrbRRE4pD5VlCSPM7mn63hqNDwGctNCXSzFRg896mn7K/Iv7Z/wZqkQTXne49muyvWW8cQ1FfZcGMCiso0DbRqWZzQ5ux7dy+voezMSc5Z6RVDtFPDzvkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ByL86Psd; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717717582; x=1749253582;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=d3lVr7y+iFHv8wwedctZB9AFZ1krdSdNt0KrBO603Rc=;
  b=ByL86PsdxLABemAqrGsf+o31XahU07dab3oWs3VBVdhSlcEvxBHHRUU7
   OEPvZbYtzi6H2jCMUIhDZUHlGpFUatcFD77+EobOeYAH2g9JBMfdU18k5
   xDK19ydx+A/fSf8DwB9w5IXLuBGStJ3MZ7aWVbYsApuKCv7xpQrsVCsq7
   NL04rKjPIZpZt90XpL9dnqZH5XxQudl+AiuYmfXTFIcwh5O/P2y0jzQDp
   GhV1ZCP8tFyqFugAQysK2zxISNToCDzZcQ0SyoOZ5rtwPoSkNV45q+eB3
   BReLxQlzaWlqLdm42BIrrJ0b/tIWFnh+rLxXv4ZzXVHvPkqO9qmbVgTcF
   g==;
X-CSE-ConnectionGUID: unR5wXaHSNikJfYtMMcPtA==
X-CSE-MsgGUID: FuueyUQlTKqIlfQ/HxPhPg==
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="17351362"
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="17351362"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 16:46:14 -0700
X-CSE-ConnectionGUID: vT73BeJ2Su2LvR8DQ6qrlw==
X-CSE-MsgGUID: NcwCCXvoSiGb/thggIeTFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="38587055"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.125.109.168]) ([10.125.109.168])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 16:46:14 -0700
Message-ID: <2bb3d5e1-c31f-4a34-b925-1309ae20111d@intel.com>
Date: Thu, 6 Jun 2024 16:46:12 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] cxl: Region bandwidth calculation for targets with
 shared upstream link
From: Dave Jiang <dave.jiang@intel.com>
To: Alison Schofield <alison.schofield@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
 dan.j.williams@intel.com, ira.weiny@intel.com, vishal.l.verma@intel.com,
 Jonathan.Cameron@huawei.com, dave@stgolabs.net
References: <20240529214357.1193417-1-dave.jiang@intel.com>
 <ZmCwrk5MGnnHxmKV@aschofie-mobl2>
 <bdbabe95-6a2c-4069-b6af-eafbaa770400@intel.com>
Content-Language: en-US
In-Reply-To: <bdbabe95-6a2c-4069-b6af-eafbaa770400@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/6/24 4:27 PM, Dave Jiang wrote:
> 
> 
> On 6/5/24 11:38 AM, Alison Schofield wrote:
>> On Wed, May 29, 2024 at 02:38:56PM -0700, Dave Jiang wrote:
>>> This series provides recalculation of the CXL region bandwidth when the targets have
>>> shared upstream link by walking the toplogy from bottom up and clamp the bandwdith
>>> as the code trasverses up the tree. An example topology:
>>>
>>>  An example topology from Jonathan:
>>>
>>>                  CFMWS 0
>>>                    |
>>>           _________|_________
>>>          |                   |
>>>    GP0/HB0/ACPI0017-0  GP1/HB1/ACPI0017-1
>>>      |          |        |           |
>>>     RP0        RP1      RP2         RP3
>>>      |          |        |           |
>>>    SW 0       SW 1     SW 2        SW 3
>>>    |   |      |   |    |   |       |   |
>>>   EP0 EP1    EP2 EP3  EP4  EP5    EP6 EP7
>>
>> Are the ACPI0017 labels a typo?
>> Expected host bridges to be labelled as ACPI0016's.
>>
>> That's all, just did a drive-by on the art today.
> 
> It would be something like below in this case:
>         GP0/ACPI0017-0
>         HB0/ACPI0016-0
>            |     |
>           RP0   RP1

Actually it should be:
	ACPI0017-0
    HB0/GP0/ACPI0016-0
	|	|
       RP0     RP1

Generic Port is identified by device handle that is off of ACPI0016 HID. 

> 
> or
> 
>         GP0/ACPI0017-0
> HB0/ACPI0016-0  HB1/ACPI0016-1
>       |               |
>      RP0             RP1
> 
> 
> 
> 
>>
>> -- Alison
> 

