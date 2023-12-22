Return-Path: <linux-pci+bounces-1277-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EBF781C2EA
	for <lists+linux-pci@lfdr.de>; Fri, 22 Dec 2023 02:56:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA2901F24775
	for <lists+linux-pci@lfdr.de>; Fri, 22 Dec 2023 01:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7480FA41;
	Fri, 22 Dec 2023 01:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RlJSVYfY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39994688;
	Fri, 22 Dec 2023 01:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703210205; x=1734746205;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0rhcRfvWg5UrQEbPHucJhsFj1NsVbHwrRqxha30a1n4=;
  b=RlJSVYfYdFl/nUTCG9XatkY/9+IgmC7ABkK/QVd/EyNxv31noPCsP5vj
   /LFzQmyQ9SfOmwHdfDLUlUiArA5LDE3ecP+67uGtX12Nmm3KSzTXI0ogM
   PHJ49rCVP9ebEplzBzgUAHWKDgu02xT/HsMTvtiXLdCWRg1Qn1j3OkUdN
   j6Is50HlV5mQwranHr09/sN/ZzFUuCCcrQYTIgohF8WDjLemuzNRBJupG
   0YjWwQ0b458PYRFZ4Vn9AUp0DYaoZJC1eP4Pb4DJsz5If9NdA9EA3YjGO
   XJmoIMcBL7oLa0TpkBNpSMlwvMwrOn+wE972XWq/wZ9s6YwJOPaJkDcWK
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="17623821"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="17623821"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 17:56:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="18552064"
Received: from zhaohaif-mobl.ccr.corp.intel.com (HELO [10.93.26.36]) ([10.93.26.36])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 17:56:42 -0800
Message-ID: <94b08bab-6488-4c4a-9742-30a69972ba50@linux.intel.com>
Date: Fri, 22 Dec 2023 09:56:39 +0800
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
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20231220005153.3984502-1-haifeng.zhao@linux.intel.com>
 <20231220005153.3984502-3-haifeng.zhao@linux.intel.com>
 <20231221103940.GA12714@wunner.de>
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
In-Reply-To: <20231221103940.GA12714@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 12/21/2023 6:39 PM, Lukas Wunner wrote:
> On Tue, Dec 19, 2023 at 07:51:53PM -0500, Ethan Zhao wrote:
>> For those endpoint devices connect to system via hotplug capable ports,
>> users could request a warm reset to the device by flapping device's link
>> through setting the slot's link control register, as pciehpt_ist() DLLSC
>> interrupt sequence response, pciehp will unload the device driver and
>> then power it off. thus cause an IOMMU devTLB flush request for device to
>> be sent and a long time completion/timeout waiting in interrupt context.
> I think the problem is in the "waiting in interrupt context".
>
> Can you change qi_submit_sync() to *sleep* until the queue is done?
> Instead of busy-waiting in atomic context?

If you read that function carefully, you wouldn't say "sleep" there....

that is 'sync'ed.

>
> Is the hardware capable of sending an interrupt once the queue is done?
> If it is not capable, would it be viable to poll with exponential backoff
> and sleep in-between polling once the polling delay increases beyond, say,
> 10 usec?

I don't know if the polling along sleeping for completion of meanningless

devTLB invalidation request blindly sent to (removed/powered down/link down)

device makes sense or not.

But according to PCIe spec  6.1  10.3.1

"Software ensures no invalidations are issued to a Function when its

  ATS capability is disabled. "

>
> Again, the proposed patch is not a proper solution.  It will paper over
> the issue most of the time but every once in a while someone will still
> get a hard lockup splat and it will then be more difficult to reproduce
> and fix if the proposed patch is accepted.

Could you point out why is not proper ? Is there any other window

the hard lockup still could happen with the ATS capable devcie

supprise_removal case if we checked the connection state first ?

Please help to elaberate it.

>
>
>> [ 4223.822622] CPU: 144 PID: 1422 Comm: irq/57-pciehp Kdump: loaded Tainted: G S
>>           OE    kernel version xxxx
> I don't see any reason to hide the kernel version.
> This isn't Intel Confidential information.
>
Yes, this is the old kernel stack trace, but customer also tried lasted 
6.7rc4

(doesn't work) and the patched 6.7rc4 (fixed).


Thanks,

Ethan

>> [ 4223.822628] Call Trace:
>> [ 4223.822628]  qi_flush_dev_iotlb+0xb1/0xd0
>> [ 4223.822628]  __dmar_remove_one_dev_info+0x224/0x250
>> [ 4223.822629]  dmar_remove_one_dev_info+0x3e/0x50
> __dmar_remove_one_dev_info() was removed by db75c9573b08 in v6.0
> one and a half years ago, so the stack trace appears to be from
> an older kernel version.
>
> Thanks,
>
> Lukas

