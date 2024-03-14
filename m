Return-Path: <linux-pci+bounces-4806-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF2A687B80C
	for <lists+linux-pci@lfdr.de>; Thu, 14 Mar 2024 07:49:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E71E282629
	for <lists+linux-pci@lfdr.de>; Thu, 14 Mar 2024 06:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3524A34;
	Thu, 14 Mar 2024 06:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KTzRQJ66"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1174C6B;
	Thu, 14 Mar 2024 06:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710398966; cv=none; b=sQ37DAWG7ZKnD0yO8Rb9+HDDU6do1lrW0inXbSvSl9TE/Evzgrqy3n8Bje+xPAmwZ9+b6cRTxx7/AxxF0KrhfKPtC4MiIocyER5uARppeVhGPZtlXJ0CQSWODOkVCEUAmc8QscISCjPdqzSoyUbkSEz7gOm3jhWKKpu77MWZG5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710398966; c=relaxed/simple;
	bh=8ubDKyYtxzqXNk7nLpS19hpHVjEEsI3x3aQpcL8zxU4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MJL8O709x5zhCucdqKXaNaNthcxdC6MYOIbfIs1OFo2feP+dZXip0q/QTHBEY7VOQVsjvB9HC3i96bCT4rFffpjLq5OheCiPWnWjfkhIjDXrWI9BOKAI26Vjy53K+pwalNSzUZ88aPM9wxo8G8YQte5vVplW/9Q/7qju8asgQg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KTzRQJ66; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710398964; x=1741934964;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8ubDKyYtxzqXNk7nLpS19hpHVjEEsI3x3aQpcL8zxU4=;
  b=KTzRQJ66YMlAwOSvKNQoIB20d1GCIP+CsSFXNkFwnh2W/yuTZP3DYUVk
   RIiSiqrEitUOl+NmEszzB0e4Evn9rsEesbgul/70tSG8XNxfhKIyWWURL
   HYldlpPQ59LoPrsOT/KWoT2UmJxsB9R3j0pCfmk7vviUzkdi+WJD9COE8
   5jT5rQ2lWE6s1ezQhLUXTGuTo5xkj+pt/+sRJeQuh6L6dbYhUSvCo3EAU
   L8HVth10r15AhVH7EVgq+mrHFqId6ETFkKfuhCn357mxFyu/3GfJQRreA
   RKxmd7PmSDTkFcuXq6g6nFMJAyrjdU398f5g8JeByTmhFkdksc76Ntqns
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11012"; a="16598531"
X-IronPort-AV: E=Sophos;i="6.07,124,1708416000"; 
   d="scan'208";a="16598531"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 23:49:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,124,1708416000"; 
   d="scan'208";a="12208283"
Received: from oozturk-mobl3.amr.corp.intel.com (HELO [10.209.75.221]) ([10.209.75.221])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 23:49:23 -0700
Message-ID: <8d076ed4-5c3c-499a-bca0-9bd51d5454cc@linux.intel.com>
Date: Wed, 13 Mar 2024 23:49:22 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH kernel v3] PCI/DOE: Support discovery version 2
Content-Language: en-US
To: Alexey Kardashevskiy <aik@amd.com>,
 Sathyanarayanan Kuppuswamy Natarajan <sathyanarayanan.nkuppuswamy@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Lukas Wunner <lukas@wunner.de>
References: <20240307022006.3657433-1-aik@amd.com>
 <32ac2ee6-26b1-4f37-bd88-db1ef2a31267@linux.intel.com>
 <16120a31-c3d6-48a8-9355-7b063e28d242@amd.com>
 <CAC41dw9x8H2m=YB66+PA-GwiVkpCyT0PobdWvFXLHpAsQOE0ew@mail.gmail.com>
 <8d542410-d8e1-4243-939c-6ce7743a66f1@amd.com>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <8d542410-d8e1-4243-939c-6ce7743a66f1@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 3/13/24 5:59 PM, Alexey Kardashevskiy wrote:
>
>
> On 7/3/24 17:22, Sathyanarayanan Kuppuswamy Natarajan wrote:
>> On Wed, Mar 6, 2024 at 10:09 PM Alexey Kardashevskiy <aik@amd.com> wrote:
>>>
>>>
>>>
>>> On 7/3/24 16:06, Kuppuswamy Sathyanarayanan wrote:
>>>>
>>>> On 3/6/24 6:20 PM, Alexey Kardashevskiy wrote:
>>>>> PCIe r6.1, sec 6.30.1.1 defines a "DOE Discovery Version" field in
>>>>> the DOE Discovery Request Data Object Contents (3rd DW) as:
>>>>>
>>>>> 15:8 DOE Discovery Version – must be 02h if the Capability Version in
>>>>> the Data Object Exchange Extended Capability is 02h or greater.
>>>>
>>>> Does this change fix any functional issue? If yes, please add Fixes:
>>>> tag and probably CC stable?
>>>
>>> The issue is that before this patch the DOE driver was following PCIe
>>> r6.0 and it was not working on a device with DOE cap v2 added in r6.1.
>>> Is it "fixes"?
>>>
>>
>> Since you are enabling support for the newer spec version, I think it will not
>> fall under bug fix. But it might be qualified for the stable branch.
>> It depends on
>> whether you want to support this device in older(stable) kernels.
>
>
> I am going to need lot more stuff (TSM, IDE, TDISP) in addition to this but it is coming much later so there is no point in pushing this alone to older kernels. Thanks,
>
>
Got it.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>


-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


