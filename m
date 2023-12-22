Return-Path: <linux-pci+bounces-1287-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F2881C70F
	for <lists+linux-pci@lfdr.de>; Fri, 22 Dec 2023 10:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08B211C23994
	for <lists+linux-pci@lfdr.de>; Fri, 22 Dec 2023 09:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 052DAD2E7;
	Fri, 22 Dec 2023 09:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FMhRS0O4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80988D2F4;
	Fri, 22 Dec 2023 09:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703235706; x=1734771706;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ws6wMA0is9Epmo9Hqj9O+JqKwLl8kwfSK40ywvuK+T4=;
  b=FMhRS0O46uo7R1MTG4QjW7zcXprALUJT0w1LWFrL29nDYQu+T4v2+IT8
   RtOunI69FP63RZ1AHcq/h8BiYJFxz87FZXf7uavqPp+eFM80I9yGg4jSw
   x/ANEx1vkCoLQDle+cdHbx7Ka8DxhgtztdNBWs8uMxIq6btk8fxO8MQbD
   tqnTCsJKVTCMnrBL90DWbuxlVEtUvOIwF4zbJUIACibPcU1bPjXDDwy+a
   8OW6EaJiELU8r4me33aDVpGo3k3zZ7dap0OqEw/nMryVh9TiPkrIKA9JJ
   bIP56Xc8XGklbUoP4xhiAcf3jhEtj7fEtcNHncDvUnqTLtwhzmQodhjef
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="399916984"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="399916984"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 01:01:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="867587604"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="867587604"
Received: from zhaohaif-mobl.ccr.corp.intel.com (HELO [10.93.26.36]) ([10.93.26.36])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 01:01:42 -0800
Message-ID: <6fed05ee-331e-4a5f-b614-50107f57146a@linux.intel.com>
Date: Fri, 22 Dec 2023 17:01:39 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] iommu/vt-d: don's issue devTLB flush request when
 device is disconnected
To: Lukas Wunner <lukas@wunner.de>
Cc: bhelgaas@google.com, baolu.lu@linux.intel.com, dwmw2@infradead.org,
 will@kernel.org, robin.murphy@arm.com, linux-pci@vger.kernel.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 Haorong Ye <yehaorong@bytedance.com>
References: <20231222081427.GA4134@wunner.de>
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
In-Reply-To: <20231222081427.GA4134@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 12/22/2023 4:14 PM, Lukas Wunner wrote:
> On Fri, Dec 22, 2023 at 09:56:39AM +0800, Ethan Zhao wrote:
>> I don't know if the polling along sleeping for completion of meanningless
>> devTLB invalidation request blindly sent to (removed/powered down/link down)
>> device makes sense or not.
> If you have a way to get to the struct pci_dev * which you're waiting for
> in qi_submit_sync() then I guess you could check for its presence and bail
> out if it's gone, instead of issuing a cpu_relax().
One option to bail out the loop.
>
>>> Again, the proposed patch is not a proper solution.  It will paper over
>>> the issue most of the time but every once in a while someone will still
>>> get a hard lockup splat and it will then be more difficult to reproduce
>>> and fix if the proposed patch is accepted.
>> Could you point out why is not proper ? Is there any other window
>> the hard lockup still could happen with the ATS capable devcie
>> supprise_removal case if we checked the connection state first ?
>> Please help to elaberate it.
> Even though user space may have initiated orderly removal via sysfs,
> the device may be yanked from the slot (surprise removed) while the
> orderly removal is happening.

Yes, just after the wait descripor is submitted and before waiting in loop.

the rare but worst case.

>
>
>> Yes, this is the old kernel stack trace, but customer also tried lasted
>> 6.7rc4
> If you could provide a stacktrace for a contemporary kernel,
> I think that would be preferred.
Customer tried, but they didn't provide me the lastest trace.
>
>
>> (doesn't work) and the patched 6.7rc4 (fixed).
> Why is it fixed in v6.7-rc4?  Is the present patch thus unnecessary?
Not fixed in v6.7rc4, with this patch, they said the unplug works.
>
>>> Finally, it is common to adhere to terms
>>> used in the PCIe Base Spec in commit messages, so "ATC Invalidate Request"
>>> might be preferable to "devTLB flush request".
>> ATS Invalidate Request ? devTLB flush request has the same meaning,
>>
>> I thought all iommu/PCIe guys could understand.
> I'm just pointing out the preferred way to write commit messages
> in the PCI subsystem (as I've perceived it over the years) so that
> you can reduce the number of iterations you have to go through
> due to maintainer feedback.  I'm just trying to be helpful.
>
Understand.
>> How to define the point "some" msec to timeout while software
>> break out the waiting loop ? or polling if the target is gone ?
> I'd say adhere to the 1 min + 50% number provided in the spec.
>
> If you know the device is gone before that then you can break out
> of the loop in qi_submit_sync() of course.

I am trying to find a way to break it out in this qi_submit_sync().

  checking the device state in this loop, but seems not good in this

iommu low level code and need some interfaces to be modified.

That would cost me much more hours to make the rare case work,

to be perfect:

1.  check the pci device state in the loop

2.  modify the invalidation descriptor status in 
pciehp_ist()->intel_iommu_release_device() call.

>
> The question is, does the Intel IOMMU have a timeout at all for
> Invalidate Requests?  I guess we don't really know that because
> in the stack trace you've provided, the watchdog stops the machine
> before a timeout occurs.  So it's at least 12 sec.  Or there's
> no timeout at all.

The calltrace wouldn't tell us there is really timeout of 1min+50%

or not, event there is, meanlingless.

> If the Intel IOMMU doesn't enforce a timeout, you should probably amend
> qi_submit_sync() to break out of the loop once the 1 min + 50% limit
> is exceeded.  And you need to amend the function to sleep instead of
> polling in interrupt context.

Too many paths to call this function, and revise it to non-sync, to much

things impacted.

>
> Can you check with hardware engineers whether there's a timeout?

Combinated with third party PCIe switch chips ?


Thanks,

Ethan

>
> Thanks,
>
> Lukas
>

