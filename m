Return-Path: <linux-pci+bounces-927-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09EFC81255D
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 03:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B25CF2819E5
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 02:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97D2393;
	Thu, 14 Dec 2023 02:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b+l8MaT0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F1DF4;
	Wed, 13 Dec 2023 18:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702521627; x=1734057627;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=i/fgG2eXBpzB7OoPlqAkRyGnSbZuRbwRmN6gEwObCHw=;
  b=b+l8MaT0Jh9AbtRWeimEImC7Ipr07QKr/D4+0jFdXsdQEkfoBb7aA4fK
   YVvasQD7D/LAROE7XUfY3/KjJNiNiNh1sl80HEp8RcvOEyMHfcAgOE1GC
   HmUL0wf5LOY/X5Qpfyi4r3Jxb+b1ZweUtr/RcstG5aedyGJrpSsSIrynR
   isbaHREUvrbitcQ4srvzzIJW3G6bfHuhMkNK6JkeYM9Svhhc4FELJQEFQ
   T3XbSTWOY/KJklSEBdHndHPGZ7PoYXpN4ipkIxSgTnPGUAAlPHX7AiVTt
   WmyyrXWm67THU0RFhvC5XX/eyRR6Ii+ytVwJ4qFJifxcIyWTD01MxFeCu
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="2142499"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="2142499"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 18:40:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="767457647"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="767457647"
Received: from zhaohaif-mobl.ccr.corp.intel.com (HELO [10.254.210.186]) ([10.254.210.186])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 18:40:23 -0800
Message-ID: <b257704b-ca41-41f1-a694-b0a98ebfba64@linux.intel.com>
Date: Thu, 14 Dec 2023 10:40:20 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iommu/vt-d: don's issue devTLB flush request when
 device is disconnected
To: Robin Murphy <robin.murphy@arm.com>, Lukas Wunner <lukas@wunner.de>
Cc: bhelgaas@google.com, baolu.lu@linux.intel.com, dwmw2@infradead.org,
 will@kernel.org, linux-pci@vger.kernel.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, Haorong Ye <yehaorong@bytedance.com>
References: <20231213034637.2603013-1-haifeng.zhao@linux.intel.com>
 <20231213034637.2603013-3-haifeng.zhao@linux.intel.com>
 <20231213104417.GA31964@wunner.de>
 <3b7742c4-bbae-4a78-a5a6-30df936a17d4@arm.com>
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
In-Reply-To: <3b7742c4-bbae-4a78-a5a6-30df936a17d4@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 12/13/2023 7:54 PM, Robin Murphy wrote:
> On 13/12/2023 10:44 am, Lukas Wunner wrote:
>> On Tue, Dec 12, 2023 at 10:46:37PM -0500, Ethan Zhao wrote:
>>> For those endpoint devices connect to system via hotplug capable ports,
>>> users could request a warm reset to the device by flapping device's 
>>> link
>>> through setting the slot's link control register,
>>
>> Well, users could just *unplug* the device, right?  Why is it relevant
>> that thay could fiddle with registers in config space?
>>
>>
>>> as pciehpt_ist() DLLSC
>>> interrupt sequence response, pciehp will unload the device driver and
>>> then power it off. thus cause an IOMMU devTLB flush request for 
>>> device to
>>> be sent and a long time completion/timeout waiting in interrupt 
>>> context.
>>
>> A completion timeout should be on the order of usecs or msecs, why 
>> does it
>> cause a hard lockup?  The dmesg excerpt you've provided shows a 12 
>> *second*
>> delay between hot removal and watchdog reaction.
>
> The PCIe spec only requires an endpoint to respond to an ATS 
> invalidate within a rather hilarious 90 seconds, so it's primarily a 
> question of how patient the root complex and bridges in between are 
> prepared to be.

The issue reported only reproduce with endpoint device connects to 
system via PCIe switch (only has read tracking feature), those switchses 
seem not be aware of ATS transaction. while root port is aware of ATS

while the ATS transaction is broken. (invalidation sent, but link down, 
device removed etc). but I didn't find any public spec about that.

>
>>> Fix it by checking the device's error_state in
>>> devtlb_invalidation_with_pasid() to avoid sending meaningless devTLB 
>>> flush
>>> request to link down device that is set to 
>>> pci_channel_io_perm_failure and
>>> then powered off in
>>
>> This doesn't seem to be a proper fix.  It will work most of the time
>> but not always.  A user might bring down the slot via sysfs, then yank
>> the card from the slot just when the iommu flush occurs such that the
>> pci_dev_is_disconnected(pdev) check returns false but the card is
>> physically gone immediately afterwards.  In other words, you've shrunk
>> the time window during which the issue may occur, but haven't eliminated
>> it completely.
>
> Yeah, I think we have a subtle but fundamental issue here in that the 
> iommu_release_device() callback is hooked to 
> BUS_NOTIFY_REMOVED_DEVICE, so in general probably shouldn't be 
> assuming it's safe to do anything with the device itself *after* it's 
> already been removed from its bus - this step is primarily about 
> cleaning up any of the IOMMU's own state relating to the given device.
>
> I think if we want to ensure ATCs are invalidated on hot-unplug we 
> need an additional pre-removal notifier to take care of that, and that 
> step would then want to distinguish between an orderly removal where 
> cleaning up is somewhat meaningful, and a surprise removal where it 
> definitely isn't.

So, at least, we should check device state before issue devTLB invaliation.


Thanks,

Ethan

>
>
> Thanks,
> Robin.

