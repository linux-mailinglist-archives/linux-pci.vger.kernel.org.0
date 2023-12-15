Return-Path: <linux-pci+bounces-1028-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FBCE813EC8
	for <lists+linux-pci@lfdr.de>; Fri, 15 Dec 2023 01:43:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D561DB21EF2
	for <lists+linux-pci@lfdr.de>; Fri, 15 Dec 2023 00:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9791363;
	Fri, 15 Dec 2023 00:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ClUdxwW+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D3A4429;
	Fri, 15 Dec 2023 00:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702601011; x=1734137011;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=Pg9SIwTVnaNf+Azqij38vs/+Y0yhd/7yApmaynqBpBk=;
  b=ClUdxwW+zriPmj01bkD3AWk8AlmbnCc7wf8V1fUhp3r44IMgEFpwa0Rw
   I4H7KpU15lvfOEiKmECM32H38EJefIrklrXMxCH0XZzrv2To6pSaOxFkf
   HBUS0gvOnFwTtstcGyMpj/HmDbxcwMgN0DtecQ4dL1+xoMA/FvQEc8lRK
   bJy1qm/xMYH/1Fzn+JpH6dsIeqCySH4DIjaMkKHyYEuV1gonups/+gFk1
   znXTMHPNCZcaJ2bZtCMynbFuo3zoRjgLs+cr0cvmBEcrFxGA44QpgM0TX
   vrghJYmNs2Egh0FBTrtdr+Yqr8dyDdVKtwgiJOM9fjzWX4RXLZome3uKR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="426342788"
X-IronPort-AV: E=Sophos;i="6.04,277,1695711600"; 
   d="scan'208";a="426342788"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 16:43:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="897945493"
X-IronPort-AV: E=Sophos;i="6.04,277,1695711600"; 
   d="scan'208";a="897945493"
Received: from xueyu-mobl.ccr.corp.intel.com (HELO [10.255.30.96]) ([10.255.30.96])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 16:43:26 -0800
Message-ID: <b270f606-4a34-4477-9795-63cd4f019be3@linux.intel.com>
Date: Fri, 15 Dec 2023 08:43:24 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iommu/vt-d: don's issue devTLB flush request when
 device is disconnected
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: bhelgaas@google.com, baolu.lu@linux.intel.com, dwmw2@infradead.org,
 will@kernel.org, robin.murphy@arm.com, linux-pci@vger.kernel.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 Haorong Ye <yehaorong@bytedance.com>
References: <20231213034637.2603013-1-haifeng.zhao@linux.intel.com>
 <20231213034637.2603013-3-haifeng.zhao@linux.intel.com>
 <20231213104417.GA31964@wunner.de>
 <7f756fc6-e8ea-4fea-ad8b-30066f41037e@linux.intel.com>
In-Reply-To: <7f756fc6-e8ea-4fea-ad8b-30066f41037e@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 12/14/2023 10:16 AM, Ethan Zhao wrote:
>
> On 12/13/2023 6:44 PM, Lukas Wunner wrote:
>> On Tue, Dec 12, 2023 at 10:46:37PM -0500, Ethan Zhao wrote:
>>> For those endpoint devices connect to system via hotplug capable ports,
>>> users could request a warm reset to the device by flapping device's 
>>> link
>>> through setting the slot's link control register,
>> Well, users could just *unplug* the device, right?  Why is it relevant
>> that thay could fiddle with registers in config space?
>>
> Yes, if the device and it's slot are hotplug capable, users could just
>
> 'unplug' the device.
>
> But this case reported, users try to do a warm reset with a tool
>
> command like:
>
>   mlxfwreset -d <busid> -y reset
>
> Actually, it will access configuration space  just as
>
>  setpci -s 0000:17:01.0 0x78.L=0x21050010
>
> Well, we couldn't say don't fiddle PCIe config space registers like
>
> that.
>
>>> as pciehpt_ist() DLLSC
>>> interrupt sequence response, pciehp will unload the device driver and
>>> then power it off. thus cause an IOMMU devTLB flush request for 
>>> device to
>>> be sent and a long time completion/timeout waiting in interrupt 
>>> context.
>> A completion timeout should be on the order of usecs or msecs, why 
>> does it
>> cause a hard lockup?  The dmesg excerpt you've provided shows a 12 
>> *second*
>> delay between hot removal and watchdog reaction.
>>
> In my understanding, the devTLB flush request sent to ATS capable devcie
>
> is non-posted request, if the ATS transaction is broken by endpoint link
>
> -down, power-off event, the timeout will take up to 60 seconds+-30,
>
> see "Invalidate Completion Timeout " part of
>
> chapter 10.3.1 Invalidate Request
>
> In PCIe spec 6.1
>
> "
>
> IMPLEMENTATION NOTE:
>
> INVALIDATE COMPLETION TIMEOUT
>
> Devices should respond to Invalidate Requests within 1 minute (+50% 
> -0%).Having a bounded time
>
> permits an ATPT to implement Invalidate Completion Timeouts and reuse 
> the associated ITag values.
>
> ATPT designs are implementation specific. As such, Invalidate 
> Completion Timeouts and their
>
> associated error handling are outside the scope of this specification
>
> "
>
>>> Fix it by checking the device's error_state in
>>> devtlb_invalidation_with_pasid() to avoid sending meaningless devTLB 
>>> flush
>>> request to link down device that is set to 
>>> pci_channel_io_perm_failure and
>>> then powered off in
>> This doesn't seem to be a proper fix.  It will work most of the time
>> but not always.  A user might bring down the slot via sysfs, then yank
>> the card from the slot just when the iommu flush occurs such that the
>> pci_dev_is_disconnected(pdev) check returns false but the card is
>> physically gone immediately afterwards.  In other words, you've shrunk
>> the time window during which the issue may occur, but haven't eliminated
>> it completely.
>
> If you mean disable the slot via sysfs, that's SAFE_REMOVAL, right ?
>
> that would issse devTLB invalidation first, power off device later, it
>
> wouldn't trigger the hard lockup, though the
>
> pci_dev_is_disconnected() return false. this fix works such case.

Could you help to point out if there are any other window to close ?

Thanks,

Ethan


>
>
> Thanks,
>
> Ethan
>
>
>
>>
>> Thanks,
>>
>> Lukas

