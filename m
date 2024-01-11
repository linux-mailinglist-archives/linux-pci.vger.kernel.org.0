Return-Path: <linux-pci+bounces-2017-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 901CF82A604
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jan 2024 03:29:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F07AD1F215C8
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jan 2024 02:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5E5814;
	Thu, 11 Jan 2024 02:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DoDGYV8q"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778A0807;
	Thu, 11 Jan 2024 02:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704940170; x=1736476170;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iferbRpdeUhgnRlUu9J8+KBTyosmA5KQK2annn3GVaQ=;
  b=DoDGYV8q4mxmR52ycOM1SlFEF3XBpoel2Pr/tX+QnUjsN+Q7yXmVrsUb
   oDF2VjGePl8D/3Tm6g9S1ujoY01upfwVz1QjXS9LE2JDzLjRlDfINepB4
   kv6fi5Bby5OqMgLftX5vUTU8f6/Rw88aW8aavK0HVYMV2oujuLjEk8W1k
   89YEn/h03i3X56qGvDRpCoAb83WQ8b1dLVp07wXTg+GMzxahJjdqZS0Pd
   mauvjkT36HdffrmFHq+cDxxbAQNRpX16mxtzIIQvyNhbCIVWVzxCZf5vf
   XCpEZTh3kO61fIDAjwFtunG6++loTXjYJK2Fj/OnjyUDtC6I3iXfolYEq
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="12204158"
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; 
   d="scan'208";a="12204158"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 18:29:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; 
   d="scan'208";a="24162309"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa002.jf.intel.com with ESMTP; 10 Jan 2024 18:29:22 -0800
Message-ID: <1be246aa-4813-43df-af77-9a94f493374b@linux.intel.com>
Date: Thu, 11 Jan 2024 10:24:06 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, linux-pci@vger.kernel.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v10 4/5] iommu/vt-d: don't issue ATS Invalidation
 request when device is disconnected
Content-Language: en-US
To: Ethan Zhao <haifeng.zhao@linux.intel.com>, kevin.tian@intel.com,
 bhelgaas@google.com, dwmw2@infradead.org, will@kernel.org,
 robin.murphy@arm.com, lukas@wunner.de
References: <20231228170504.720794-1-haifeng.zhao@linux.intel.com>
 <20231228170504.720794-2-haifeng.zhao@linux.intel.com>
 <8e16ff9b-4dcd-4bec-a78b-61d90205841f@linux.intel.com>
 <b077a691-5790-40a0-8539-0f5294d0fc28@linux.intel.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <b077a691-5790-40a0-8539-0f5294d0fc28@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/10/24 4:37 PM, Ethan Zhao wrote:
> 
> On 1/10/2024 1:24 PM, Baolu Lu wrote:
>> On 12/29/23 1:05 AM, Ethan Zhao wrote:
>>> Except those aggressive hotplug cases - surprise remove a hotplug device
>>> while its safe removal is requested and handled in process by:
>>>
>>> 1. pull it out directly.
>>> 2. turn off its power.
>>> 3. bring the link down.
>>> 4. just died there that moment.
>>>
>>> etc, in a word, 'gone' or 'disconnected'.
>>>
>>> Mostly are regular normal safe removal and surprise removal unplug.
>>> these hot unplug handling process could be optimized for fix the ATS
>>> Invalidation hang issue by calling pci_dev_is_disconnected() in function
>>> devtlb_invalidation_with_pasid() to check target device state to avoid
>>> sending meaningless ATS Invalidation request to iommu when device is 
>>> gone.
>>> (see IMPLEMENTATION NOTE in PCIe spec r6.1 section 10.3.1)
>>>
>>> For safe removal, device wouldn't be removed untill the whole software
>>> handling process is done, it wouldn't trigger the hard lock up issue
>>> caused by too long ATS Invalidation timeout wait. In safe removal path,
>>> device state isn't set to pci_channel_io_perm_failure in
>>> pciehp_unconfigure_device() by checking 'presence' parameter, calling
>>> pci_dev_is_disconnected() in devtlb_invalidation_with_pasid() will 
>>> return
>>> false there, wouldn't break the function.
>>>
>>> For surprise removal, device state is set to 
>>> pci_channel_io_perm_failure in
>>> pciehp_unconfigure_device(), means device is already gone (disconnected)
>>> call pci_dev_is_disconnected() in devtlb_invalidation_with_pasid() will
>>> return true to break the function not to send ATS Invalidation 
>>> request to
>>> the disconnected device blindly, thus avoid the further long time 
>>> waiting
>>> triggers the hard lockup.
>>>
>>> safe removal & surprise removal
>>>
>>> pciehp_ist()
>>>     pciehp_handle_presence_or_link_change()
>>>       pciehp_disable_slot()
>>>         remove_board()
>>>           pciehp_unconfigure_device(presence)
>>>
>>> Tested-by: Haorong Ye <yehaorong@bytedance.com>
>>> Signed-off-by: Ethan Zhao <haifeng.zhao@linux.intel.com>
>>> ---
>>>   drivers/iommu/intel/pasid.c | 2 ++
>>>   1 file changed, 2 insertions(+)
>>>
>>> diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
>>> index 715943531091..3d5ed27f39ef 100644
>>> --- a/drivers/iommu/intel/pasid.c
>>> +++ b/drivers/iommu/intel/pasid.c
>>> @@ -480,6 +480,8 @@ devtlb_invalidation_with_pasid(struct intel_iommu 
>>> *iommu,
>>>       if (!info || !info->ats_enabled)
>>>           return;
>>>   +    if (pci_dev_is_disconnected(to_pci_dev(dev)))
>>> +        return;
>>
>> Why do you need the above after changes in PATCH 2/5? It's unnecessary
>> and not complete. We have other places where device TLB invalidation is
>> issued, right?
> 
> This one could be regarded as optimization, no need to trapped into rabbit
> 
> hole if we could predict the result. because the bad thing is we don't know
> 
> what response to us in the rabbit hole from third party switch (bridges 
> will
> 
> feedback timeout to requester as PCIe spec mentioned if the endpoint is
> 
> gone).

The IOMMU hardware has its own timeout mechanism. This timeout might
happen if:

1) The link to the endpoint is broken, so the invalidation completion
    message is lost on the way.
2) The device has a longer timeout value, so the device is still busy
    with handling the cache invalidation when IOMMU's timeout is
    triggered.

Here, we are doing the following:

For Case 1, we return -ETIMEDOUT directly. For Case 2, we attempt to
retry.

Best regards,
baolu

