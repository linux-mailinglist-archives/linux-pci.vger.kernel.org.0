Return-Path: <linux-pci+bounces-1365-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1CFD81DD9C
	for <lists+linux-pci@lfdr.de>; Mon, 25 Dec 2023 03:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CBF91F215EB
	for <lists+linux-pci@lfdr.de>; Mon, 25 Dec 2023 02:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570F6804;
	Mon, 25 Dec 2023 02:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZVP8K1C4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DA9365;
	Mon, 25 Dec 2023 02:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703471756; x=1735007756;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ybwNxvFmpQfMZ05ll/8jq6lKNVzc0abCQPwdZyFKBX0=;
  b=ZVP8K1C4DSqnLfQYffVGONTSCeqTCkSYPdVJhj2HdwyBtO2vPrsvRxqe
   lsUle112+9oFzBAYPlJojeDIzm5Ur6ljt3UrZDaC2Ne6JLrZiQAWDvjfT
   fuVYo7HD/FkKLrVYXw+RidvX4eKYL/XS/whMXCl68J/iQ2NxwbVWufh3T
   O7gifCYIDKGkPFqvWlg8dmTC8WfdpoaYeMwk9hR0eeIDccOLRQxS0wSlr
   ccxcsSD+b/JODr3LgTZNuPwTjUFZHFVKYJA91zyGS5DoKMyDUmkuAzzVR
   RI//A/ah0cpex/6ctmTMA/nSw4hL12G9m+QjYB7TLL0PbnLg4XqwB1OyH
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="381241456"
X-IronPort-AV: E=Sophos;i="6.04,302,1695711600"; 
   d="scan'208";a="381241456"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2023 18:35:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,302,1695711600"; 
   d="scan'208";a="25965097"
Received: from zhaohaif-mobl.ccr.corp.intel.com (HELO [10.93.26.36]) ([10.93.26.36])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2023 18:35:53 -0800
Message-ID: <7b95bc97-db82-4de4-aee2-6bc7685cee1b@linux.intel.com>
Date: Mon, 25 Dec 2023 10:35:50 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v6 2/4] iommu/vt-d: don's issue devTLB flush request
 when device is disconnected
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, baolu.lu@linux.intel.com, dwmw2@infradead.org,
 will@kernel.org, robin.murphy@arm.com, lukas@wunner.de,
 linux-pci@vger.kernel.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20231225022117.GA1416989@bhelgaas>
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
In-Reply-To: <20231225022117.GA1416989@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 12/25/2023 10:21 AM, Bjorn Helgaas wrote:
> On Mon, Dec 25, 2023 at 09:46:26AM +0800, Ethan Zhao wrote:
>> On 12/25/2023 6:43 AM, Bjorn Helgaas wrote:
>>> On Sun, Dec 24, 2023 at 12:06:55AM -0500, Ethan Zhao wrote:
>>>> ...
>>>> [ 4211.433662] pcieport 0000:17:01.0: pciehp: Slot(108): Link Down
>>>> [ 4211.433664] pcieport 0000:17:01.0: pciehp: Slot(108): Card not present
>>>> [ 4223.822591] NMI watchdog: Watchdog detected hard LOCKUP on cpu 144
>>>> ...
>>>> [ 4223.822647] Kernel Offset: 0x6400000 from 0xffffffff81000000 (relocation
>>>> range: 0xffffffff80000000-0xffffffffbfffffff)
>>> The timestamps don't help understand the problem, so you could remove
>>> them so they aren't a distraction.
>> Lukas said he see the qi_submit_sync takes up to 12 seconds to trigger the
>> watchdog.
> OK, so the timestamps told us how long the watchdog tolerates.  I
> don't know how useful that is.  I suspect that's not a fixed interval
> (probably differs by watchdog and possibly user preference).
>
>>>> Fix it by checking the device's error_state in
>>>> devtlb_invalidation_with_pasid() to avoid sending meaningless devTLB flush
>>>> request to link down device that is set to pci_channel_io_perm_failure and
>>>> then powered off in
>>> A pci_dev_is_disconnected() is racy in this context, so this by itself
>>> doesn't look like a complete "fix".
>> A quick workaround.
> Call it a "quick workaround" then, not a "fix".  I'm personally not
> usually interested in quick workarounds that are not actually fixes,
> but the IOMMU folks would be the ones to decide.
>
> Maybe this is more of an optimization?  If patch 4/4 is a real fix (in
> the sense that if you disable the watchdog, you would get correct
> results after a long timeout), maybe you could reorder the patches so
> 4/4 comes first, and this one becomes an optimization on top of it?  I
Make sense, will reorder them.
> haven't worked though the whole path, so I don't know exactly how
> these patches work.
>
>>>> pciehp_ist()
>>>>      pciehp_handle_presence_or_link_change()
>>>>        pciehp_disable_slot()
>>>>          remove_board()
>>>>            pciehp_unconfigure_device()
>>> There are some interesting steps missing here between
>>> pciehp_unconfigure_device() and devtlb_invalidation_with_pasid().
>>>
>>> devtlb_invalidation_with_pasid() is Intel-specific.  ATS Invalidate
>>> Requests are not Intel-specific, so all IOMMU drivers must have to
>>> deal with the case of an ATS Invalidate Request where we never receive
>>> a corresponding ATS Invalidate Completion.  Do other IOMMUs like AMD
>>> and ARM have a similar issue?
>> So far fix it in Intel vt-d specific path.
> If the other IOMMU drivers are vulnerable, I guess they would like to
> fix this at the same time and in a similar way if possible.
>
>>>> For SAVE_REMOVAL unplug, link is alive when iommu releases devcie and
>>>> issues devTLB invalidate request, wouldn't trigger such issue.
>>>>
>>>> This patch works for all links of SURPPRISE_REMOVAL unplug operations.
>>> It's not completely obvious that a fix that works for the safe removal
>>> case also works for the surprise removal case.  Can you briefly
>>> explain why it does?
>> As I explained to baolu.
>>
>> For safe_removal, device wouldn't  be removed till the whole software
>> handling process done, so without this fix, it wouldn't trigger the lockup
>> issue, and in safe_removal path, device state isn't set to
>> pci_channel_io_perm_failure in pciehp_unconfigure_device() by checking
>> 'presence',  patch calling this pci_dev_is_disconnected() will return false
>> there, wouldn't break the function.  so it works.
>>
>> For suprise_removal, device state is set to pci_channel_io_perm_failure in
>> pciehp_unconfigure_device(), means device already be in power-off/link-down
>> /removed state, callpci_dev_is_disconnected() hrere will return true to
>> break
>>
>> the function not to send ATS invalidation request anymore, thus avoid the
>> further long time waiting trigger the hard lockup.
> s/safe_removal/safe removal/ (they are not a single word)
> s/suprise_removal/surprise removal/ (misspelled, also not a single word)
>
>> Do I make it clear enough ?
> Needs to be in the commit log, of course.

Okay, append to the commit log.


Thanks,

Ethan

>>>> Tested-by: Haorong Ye <yehaorong@bytedance.com>
>>>> Signed-off-by: Ethan Zhao <haifeng.zhao@linux.intel.com>
>>>> ---
>>>>    drivers/iommu/intel/pasid.c | 3 +++
>>>>    1 file changed, 3 insertions(+)
>>>>
>>>> diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
>>>> index 74e8e4c17e81..7dbee9931eb6 100644
>>>> --- a/drivers/iommu/intel/pasid.c
>>>> +++ b/drivers/iommu/intel/pasid.c
>>>> @@ -481,6 +481,9 @@ devtlb_invalidation_with_pasid(struct intel_iommu *iommu,
>>>>    	if (!info || !info->ats_enabled)
>>>>    		return;
>>>> +	if (pci_dev_is_disconnected(to_pci_dev(dev)))
>>>> +		return;
>>>> +
>>>>    	sid = info->bus << 8 | info->devfn;
>>>>    	qdep = info->ats_qdep;
>>>>    	pfsid = info->pfsid;
>>> This goes on to call qi_submit_sync(), which contains a restart: loop.
>>> I don't know the programming model there, but it looks possible that
>>> qi_submit_sync() and qi_check_fault() might not handle the case of an
>>> unreachable device correctly.  There should be a way to exit that
>>> restart: loop in cases where the device doesn't respond at all.
>> Yes, fix it in patch[4/4] to break it out when device is gone.

