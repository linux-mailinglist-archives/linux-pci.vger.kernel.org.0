Return-Path: <linux-pci+bounces-923-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50154812520
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 03:16:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C2A52823DC
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 02:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9044C642;
	Thu, 14 Dec 2023 02:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CfGH+pXB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 597E9E3;
	Wed, 13 Dec 2023 18:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702520198; x=1734056198;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fEz3jDQ/xk9byD6ipVMs16iK9GZAZqzLksjBqt8qPrA=;
  b=CfGH+pXBR1lwOwkU3xiUMDseHblZR+IjZYsjbDPEENFE4HbOMu1Cj5GI
   tLZvkZNWr8VFgDHfY/hU2boW28fdaVYC6gcBawVwdzDAYcmmL/tfT7HAq
   eVZPVKPAJhgn9mR2a6/gMSJybYpeN0yEf9/8iTnZ9hVPyyLk7Pb6MTJYJ
   1850JxkzHQ53kMlMiRnxO+LfXc4elmIxFxOwyoFWuwRZmevxGku7DuSFK
   jGGKmE856G37TBoOEgf91mHtNKV5qREoijRInOV72Ud9uXb2nAOQ62bRo
   OIn6a7VoLTXfEZwTMH0lXpwb9a393MicaMhQ0joHNXzEj4KtuuphHpHxW
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="16607959"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="16607959"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 18:16:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="723891359"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="723891359"
Received: from zhaohaif-mobl.ccr.corp.intel.com (HELO [10.254.210.186]) ([10.254.210.186])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 18:16:34 -0800
Message-ID: <7f756fc6-e8ea-4fea-ad8b-30066f41037e@linux.intel.com>
Date: Thu, 14 Dec 2023 10:16:31 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iommu/vt-d: don's issue devTLB flush request when
 device is disconnected
To: Lukas Wunner <lukas@wunner.de>
Cc: bhelgaas@google.com, baolu.lu@linux.intel.com, dwmw2@infradead.org,
 will@kernel.org, robin.murphy@arm.com, linux-pci@vger.kernel.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 Haorong Ye <yehaorong@bytedance.com>
References: <20231213034637.2603013-1-haifeng.zhao@linux.intel.com>
 <20231213034637.2603013-3-haifeng.zhao@linux.intel.com>
 <20231213104417.GA31964@wunner.de>
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
In-Reply-To: <20231213104417.GA31964@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 12/13/2023 6:44 PM, Lukas Wunner wrote:
> On Tue, Dec 12, 2023 at 10:46:37PM -0500, Ethan Zhao wrote:
>> For those endpoint devices connect to system via hotplug capable ports,
>> users could request a warm reset to the device by flapping device's link
>> through setting the slot's link control register,
> Well, users could just *unplug* the device, right?  Why is it relevant
> that thay could fiddle with registers in config space?
>
Yes, if the device and it's slot are hotplug capable, users could just

'unplug' the device.

But this case reported, users try to do a warm reset with a tool

command like:

   mlxfwreset -d <busid> -y reset

Actually, it will access configuration space  just as

  setpci -s 0000:17:01.0 0x78.L=0x21050010

Well, we couldn't say don't fiddle PCIe config space registers like

that.

>> as pciehpt_ist() DLLSC
>> interrupt sequence response, pciehp will unload the device driver and
>> then power it off. thus cause an IOMMU devTLB flush request for device to
>> be sent and a long time completion/timeout waiting in interrupt context.
> A completion timeout should be on the order of usecs or msecs, why does it
> cause a hard lockup?  The dmesg excerpt you've provided shows a 12 *second*
> delay between hot removal and watchdog reaction.
>
In my understanding, the devTLB flush request sent to ATS capable devcie

is non-posted request, if the ATS transaction is broken by endpoint link

-down, power-off event, the timeout will take up to 60 seconds+-30,

see "Invalidate Completion Timeout " part of

chapter 10.3.1 Invalidate Request

In PCIe spec 6.1

"

IMPLEMENTATION NOTE:

INVALIDATE COMPLETION TIMEOUT

Devices should respond to Invalidate Requests within 1 minute (+50% 
-0%).Having a bounded time

permits an ATPT to implement Invalidate Completion Timeouts and reuse 
the associated ITag values.

ATPT designs are implementation specific. As such, Invalidate Completion 
Timeouts and their

associated error handling are outside the scope of this specification

"

>> Fix it by checking the device's error_state in
>> devtlb_invalidation_with_pasid() to avoid sending meaningless devTLB flush
>> request to link down device that is set to pci_channel_io_perm_failure and
>> then powered off in
> This doesn't seem to be a proper fix.  It will work most of the time
> but not always.  A user might bring down the slot via sysfs, then yank
> the card from the slot just when the iommu flush occurs such that the
> pci_dev_is_disconnected(pdev) check returns false but the card is
> physically gone immediately afterwards.  In other words, you've shrunk
> the time window during which the issue may occur, but haven't eliminated
> it completely.

If you mean disable the slot via sysfs, that's SAFE_REMOVAL, right ?

that would issse devTLB invalidation first, power off device later, it

wouldn't trigger the hard lockup, though the

pci_dev_is_disconnected() return false. this fix works such case.


Thanks,

Ethan



>
> Thanks,
>
> Lukas

