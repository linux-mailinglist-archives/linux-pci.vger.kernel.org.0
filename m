Return-Path: <linux-pci+bounces-2861-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A075843626
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jan 2024 06:42:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BA551C20AA1
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jan 2024 05:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C53E3D982;
	Wed, 31 Jan 2024 05:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h34K48fK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8023DB92;
	Wed, 31 Jan 2024 05:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706679763; cv=none; b=IbdV9dSz9IfseJW4WD7z7cprWm4WcBIlSjAC7a8ma5WJSEmScDfZYyBBvzxSELnjHmxWEvPkxZjw05E5Xj+WOyoaLJLJp55Wy8FvksxRPnlOQJYIz+D+pC1/JCx3WOCG+xuKzFvofZ3qZMlF1rikdYRQ16dHuafdWcUE5w4P0j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706679763; c=relaxed/simple;
	bh=2KCNaKjDztHsR7PieMgniR5qU5EYgWjlyweWqhhAVb0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N9kZXcV+1ZcOU2Jjs8FSGN9AlQv6Otv1ONlYkNu/dV5aS1FeTR5SThxTRdPQvqT+i+Y+YNN6/uUA97GgPoI7EhITd3gn+afIxdCNxtFujQ88RSgxwBdHzSL2Ptb/tQT9pPJvOTHnTmJOPAjznVn04adE9vyeuVTUcl82fkefTBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h34K48fK; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706679761; x=1738215761;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2KCNaKjDztHsR7PieMgniR5qU5EYgWjlyweWqhhAVb0=;
  b=h34K48fKdTl/RiJcSmCmdAQVYdM0nf8ZdMaOxUV2jNv0FjiF9MXKC2Dc
   +2uHBY77Jb3/1HITG4apxwkqzg+LPPEZioUBFTnEXwwfs2fr07FZlP8Fr
   tRYs0DFUzRAtecHAYRQalOsqh1AdBg4++iKRrnU1SjNunL06kh+wzaNsX
   SaaqxBq2AQ00PT+xhdrhn8HnBaL8PovsAT5SeJ+ApAMeQ/iKG3+XEVcEO
   0i01hh/ys0O9+ZR/jsivcvVxdCWr9Zq84Rj4DJHGL20VJPQdJgbmil42s
   Y/c3pUfnjG8oG7krk3hn7xOqoNu6JH4ldeWLW8lWid45mWsqPAaIiHo+A
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="24972093"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="24972093"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 21:42:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="911678156"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="911678156"
Received: from zhaohaif-mobl.ccr.corp.intel.com (HELO [10.254.210.203]) ([10.254.210.203])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 21:42:35 -0800
Message-ID: <f28f9e0c-ea19-456b-9016-9d69fb90048a@linux.intel.com>
Date: Wed, 31 Jan 2024 13:42:33 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 5/5] iommu/vt-d: improve ITE fault handling if target
 device isn't present
To: "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>
Cc: "dwmw2@infradead.org" <dwmw2@infradead.org>,
 "will@kernel.org" <will@kernel.org>, "lukas@wunner.de" <lukas@wunner.de>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <20240129034924.817005-1-haifeng.zhao@linux.intel.com>
 <20240129034924.817005-6-haifeng.zhao@linux.intel.com>
 <BN9PR11MB52761CC3E5F08D4B7BAD7F918C7E2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <7adec292-9d38-41ab-a982-bd840b24f3ab@intel.com>
 <0aee453c-e98f-4b72-8107-31d4731abcdb@linux.intel.com>
 <BN9PR11MB5276D3372267CE9246170FA78C7D2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <500c4582-ec05-4a9e-9b68-d2ae19aed49b@linux.intel.com>
 <BN9PR11MB527674172BBA9BDC49A004D08C7D2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <56a9971e-7015-4584-89c7-80056b7ec547@linux.intel.com>
 <BN9PR11MB5276CDBA6ED200319C8455EE8C7D2@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
In-Reply-To: <BN9PR11MB5276CDBA6ED200319C8455EE8C7D2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/30/2024 5:24 PM, Tian, Kevin wrote:
>> From: Ethan Zhao <haifeng.zhao@linux.intel.com>
>> Sent: Tuesday, January 30, 2024 5:13 PM
>>
>> On 1/30/2024 4:43 PM, Tian, Kevin wrote:
>>>> From: Ethan Zhao <haifeng.zhao@linux.intel.com>
>>>> Sent: Tuesday, January 30, 2024 4:16 PM
>>>>
>>>> On 1/30/2024 2:22 PM, Tian, Kevin wrote:
>>>>> Here we need consider two situations.
>>>>>
>>>>> One is that the device is not bound to a driver or bound to a driver
>>>>> which doesn't do active work to the device when it's removed. In
>>>>> that case one may observe the timeout situation only in the removal
>>>>> path as the stack dump in your patch02 shows.
>>>> When iommu_bus_notifier() got called for hotplug removal cases to
>>>> flush devTLB (ATS invalidation), driver was already unloaded.
>>>> whatever safe removal or surprise removal. so in theory no active
>>>> driver working there.
>>>>
>>>> pciehp_ist()
>>>>     pciehp_disable_slot()
>>>>      remove_board()
>>>>       pciehp_unconfigure_device()
>>>>        pci_stop_and_remove_bus_device()
>>>>         pci_stop_bus_device()--->here unload driver
>>>>         pci_remove_bus_device()->here qi_flush_dev_iotlb() got called.
>>> yes, so patch02 can fix this case.
>>>
>>>>> patch02 can fix that case by checking whether the device is present
>>>>> to skip sending the invalidation requests. So the logic being discussed
>>>>> here doesn't matter.
>>>>>
>>>>> The 2nd situation is more tricky. The device might be bound to
>>>>> a driver which is doing active work to the device with in-fly
>>>>> ATS invalidation requests. In this case in-fly requests must be aborted
>>>>> before the driver can be detached from the removed device.
>> Conceptually
>>>>> a device is removed from the bus only after its driver is detached.
>>>> Some tricky situations:
>>>>
>>>> 1. The ATS invalidation request is issued from driver driver, while it is
>>>> in handling, device is removed. this momment, the device instance still
>>>> exists in the bus list. yes, if searching it by BDF, could get it.
>>> it's searchable between the point where the device is removed and the
>>> point where the driver is unloaded:
>>>
>>>           CPU0                                CPU1
>>>     (Driver is active)                    (pciehp handler)
>>>     qi_submit_sync()                      pciehp_ist()
>>>       ...                                   ...
>>>       loop for completion() {               pciehp_unconfigure_device()
>>>         ...                                   pci_dev_set_disconnected()
>>>         if (ITE) {                            ...
>>>           //find pci_dev from sid             pci_remove_bus_device()
>>>           if (pci_dev_is_connected())           device_del()
>>>             break;                                bus_remove_device()
>>>         }                                           device_remove_driver()
>> If the device was hot plugin or re-scanned, the device has a PCI_DEV_ADDED
>> flag,
> in this case is pci_dev_is_disconnected() true or false?
>
> how is this patch supposed to work with it?

pci_dev_is_disconnected() is true for safe removal, false for surprise 
removal, but it not called in this patch, is used in patch[2/5], 
explained in its commit log. This patch use the pci_device_is_present() 
to check device present or not. if pci_dev_is_disconnected() returns true, then check its presence by pci vendor
configuration reading (a specific protocal in PCIe spec).

>
>> if so the driver unloading work isn't defered to the tail of device_del(), it
>> is unloaded before pci_remove_bus_device()->device_del(), in pci_stop_dev
>>
>> pci_stop_bus_device()
>>    pci_stop_dev()
>>    {
>>     if (pci_dev_is_added(dev)) {
>>         device_release_driver(&dev->dev);
>>    }
> no matter where driver unload is requested, it needs to wait for aborting
> in-fly request on CPU0.

yes, the progress of driver unloading has complex sync mechanism in
  __device_release_driver() to do that.

>
>> So the interval the device is searchable, only applied to those devices
>> not hot plugged, or never be scanned.
>>
> and in the worst case even if pci_dev is not searchable, isn't it already
> an indicator that the device is absent then qi_submit_sync() should
> just exit upon ITE?

Hmmm, pci_dev is not searchable, but that pci_dev instance is just not in
the bus list or device list, not mean is disconnected or not present that
moment. :)


Thanks,
Ethan


