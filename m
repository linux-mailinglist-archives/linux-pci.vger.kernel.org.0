Return-Path: <linux-pci+bounces-44844-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D74D21151
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 20:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 317633076773
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 19:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E1734EEE5;
	Wed, 14 Jan 2026 19:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BQF5AyXN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E5225F78F;
	Wed, 14 Jan 2026 19:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768419904; cv=none; b=sGY1tkVPwOHN7xhDCAXQVmVWy9M8L34Iin4nPnz5T4c83n1eajGIxhRq/X1VU1X2vwHhMEkStGZ/QLZmkKtnGQbQ3mAEisjzHLLMUPbXhr+x5ayfLMlqjqbmAAtGRbxXJFvF5jMKVn0ay4XWWUoW9Tm7FrOLEp8+lk/B0KZea7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768419904; c=relaxed/simple;
	bh=f3xEivVIwLxDIlJ/bpdrPzwjjucUNmE0+GsD3w7IpE4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qRxmriQwNz6k63emc4eiYN3V72jorFMt8TO5otQjkCut4UKuVvkO8x72fdE3Sf/1HwJY04htQQJS3e1jq3kUt5uEDC3z+yvfKgZVpcQa2Kvq1srGBPiUpLMtnMvaxqmg3JRNJ2IR310aaxC7a0XuoGjfKk33ql9TwYdnsJG94pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BQF5AyXN; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768419903; x=1799955903;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=f3xEivVIwLxDIlJ/bpdrPzwjjucUNmE0+GsD3w7IpE4=;
  b=BQF5AyXNSU+GvvBmn8lLKciQqgKh3/26u25yAS25LeaHwQ3bdA6Q9Iq4
   FgQKLo84AEhULyzfcjJeEuI3fNS1yXZh/aeRjkih/H/QkxTJ2PQJ4ymlq
   VHB/eeg54IbgwK+iW5WO93xjRVC9Nl4zY6fVyA1AfelYAcBb8RAEAXrjG
   5RpJVu8R5g28/Gg/hqmRKGKrocOn01mnf+cfDqvJFqp7zwxmRnbx6cuzC
   c5g4Q3FETJt7pErWLqnt60JZYB2ZfdJ6pE3z1IBRSqV2p8NMA8OXjAKnj
   QyTCsDZCY6Upbwl5koLY5+RfEj6cJtDCKspF3zHEN/86KrHU2Gpq0Adet
   g==;
X-CSE-ConnectionGUID: BWr4CKG9QemlPTOZq//eOw==
X-CSE-MsgGUID: PzYZkeAVQHitCKnhhyvqNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="80837444"
X-IronPort-AV: E=Sophos;i="6.21,226,1763452800"; 
   d="scan'208";a="80837444"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 11:45:03 -0800
X-CSE-ConnectionGUID: RspG+dGMQBCwlaRgd2FwWw==
X-CSE-MsgGUID: JfMLco7ZTtW+JNQ8QN+LIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,226,1763452800"; 
   d="scan'208";a="209228370"
Received: from soc-pf446t5c.clients.intel.com (HELO [10.24.81.126]) ([10.24.81.126])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 11:45:01 -0800
Message-ID: <58b8333c-ec96-4866-b2c3-8d037f94280d@linux.intel.com>
Date: Wed, 14 Jan 2026 11:45:01 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 27/34] PCI/ERR: Introduce PCI_ERS_RESULT_PANIC
To: "Bowman, Terry" <terry.bowman@amd.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, dan.j.williams@intel.com, bhelgaas@google.com,
 shiju.jose@huawei.com, ming.li@zohomail.com,
 Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
 dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
 lukas@wunner.de, Benjamin.Cheatham@amd.com, linux-cxl@vger.kernel.org,
 vishal.l.verma@intel.com, alucerop@amd.com, ira.weiny@intel.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20260114182055.46029-1-terry.bowman@amd.com>
 <20260114182055.46029-28-terry.bowman@amd.com>
 <9e0d3c5a-bc80-4d19-bf7b-fbf55d140b8c@linux.intel.com>
 <d1f0f269-96f0-4739-97f5-f695137f922a@amd.com>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <d1f0f269-96f0-4739-97f5-f695137f922a@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 1/14/2026 11:20 AM, Bowman, Terry wrote:
> On 1/14/2026 12:58 PM, Kuppuswamy Sathyanarayanan wrote:
>> Hi,
>>
>> On 1/14/2026 10:20 AM, Terry Bowman wrote:
>>> The CXL driver's error handling for uncorrectable errors (UCE) will be
>>> updated in the future. A required change is for the error handlers to
>>> to force a system panic when a UCE is detected.
>>>
>>> Introduce PCI_ERS_RESULT_PANIC as a 'enum pci_ers_result' type. This will
>>> be used by CXL UCE fatal and non-fatal recovery in future patches. Update
>>> PCIe recovery documentation with details of PCI_ERS_RESULT_PANIC.
>>>
>>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>>> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
>>> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
>>> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
>>>
>>
>> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>
>>> ---
>>>
>>> Changes in v13 -> v14:
>>> - Add review-by for Dan
>>> - Update Title prefix (Bjorn)
>>> - Removed merge_result. Only logging error for device reporting the
>>>   error (Dan)
>>>
>>> Changes in  v12->v13:
>>> - Add Dave Jiang's, Jonathan's, Ben's review-by
>>> - Typo fix (Ben)
>>>
>>> Changes v11 -> v12:
>>> - Documentation requested (Lukas)
>>> ---
>>>  Documentation/PCI/pci-error-recovery.rst | 2 ++
>>>  include/linux/pci.h                      | 3 +++
>>>  2 files changed, 5 insertions(+)
>>>
>>> diff --git a/Documentation/PCI/pci-error-recovery.rst b/Documentation/PCI/pci-error-recovery.rst
>>> index 43bc4e3665b4..82ee2c8c0450 100644
>>> --- a/Documentation/PCI/pci-error-recovery.rst
>>> +++ b/Documentation/PCI/pci-error-recovery.rst
>>> @@ -102,6 +102,8 @@ Possible return values are::
>>>  		PCI_ERS_RESULT_NEED_RESET,  /* Device driver wants slot to be reset. */
>>>  		PCI_ERS_RESULT_DISCONNECT,  /* Device has completely failed, is unrecoverable */
>>>  		PCI_ERS_RESULT_RECOVERED,   /* Device driver is fully recovered and operational */
>>> +		PCI_ERS_RESULT_NO_AER_DRIVER, /* No AER capabilities registered for the driver */
>>> +		PCI_ERS_RESULT_PANIC,       /* System is unstable, panic. Is CXL specific */
>>>  	};
>>
>> I think you also need to update the "Detailed Steps" section of this
>> document to include details on when these new values should be returned
>> and how they affect the recovery flow.
>>
> 
> I had details about PCI_ERS_RESULT_PANIC you mention in v13. Bjorne asked me to remove.

Sorry, I did not check the previous version.

What about PCI_ERS_RESULT_NO_AER_DRIVER? I think it needs to be included part
of STEP 1 details, but likely as a separate patch since it is unrelated to the
CXL changes in this series.

> 
> -Terry
> 
>>>  
>>>  A driver does not have to implement all of these callbacks; however,
>>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>>> index f8e8b3df794d..ee05d5925b13 100644
>>> --- a/include/linux/pci.h
>>> +++ b/include/linux/pci.h
>>> @@ -921,6 +921,9 @@ enum pci_ers_result {
>>>  
>>>  	/* No AER capabilities registered for the driver */
>>>  	PCI_ERS_RESULT_NO_AER_DRIVER = (__force pci_ers_result_t) 6,
>>> +
>>> +	/* System is unstable, panic. Is CXL specific */
>>> +	PCI_ERS_RESULT_PANIC = (__force pci_ers_result_t) 7,
>>>  };
>>>  
>>>  /* PCI bus error event callbacks */
>>
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


