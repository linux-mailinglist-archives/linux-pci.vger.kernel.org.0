Return-Path: <linux-pci+bounces-2781-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C389841F24
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 10:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E83662938A3
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 09:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C80858ADD;
	Tue, 30 Jan 2024 09:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gbt/b/Wl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643B460241;
	Tue, 30 Jan 2024 09:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706606016; cv=none; b=Az2HceFHfstJh0YQkiPs/UpYhPMqk5OvAfCt/TrUyv/SSFnkUQ5vdiTkXb3fyTd+DJSh5PTQShrdTe47w9egH/iOpDJRSKCfOVMmgpBHV3NcEJMu5YUoPDE3zaRR9oYjyYpJGPUXCZAOnvVZHGLfIKj+S/3AIYpEsKat33qZBm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706606016; c=relaxed/simple;
	bh=Y4nDFYjUZfzurJ80YZ+gps4Y0inJ3LqS/yvK9HXgBPo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CdrHSGp4w5RybjEhaBREThxQ29w4WawOWYR5OyyepH5YrxsFhRjcThpC9BHMN53vuTwEXoCXaU4Eo3YJKzsHmZmaAdzz2Uw0z8+SGmXe1eFz0BmQTQ7jjfWhcUs389ekPCTdmhvPOYzMcS5cpxlPGzkwikd8dXTSOiMp94Nym+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gbt/b/Wl; arc=none smtp.client-ip=192.55.52.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706606015; x=1738142015;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Y4nDFYjUZfzurJ80YZ+gps4Y0inJ3LqS/yvK9HXgBPo=;
  b=gbt/b/WloVmYr9ROvIJHlmxfeeGLge8uZR6emF/tk4s/JJbM49xKk7kx
   /kxoKkmcgD40Tn04tuwLq21dkZM+64wDqNL6Sg3VG59ASdhZXAe+kOnnz
   GcghLZsuqsvb3snh6LpH012HnaICGJDx4SRgjbDrl+f4xD08P0aKhLw5f
   LFTJZvLLmgTrbgoc3oAUKCWlS9i8SMi1MwcSn9QX0w9WxxDIMEvCa+ZvF
   LASI8eLKtacIOdkfAQhLknCAvRMumbO8DlY74BGl+Y5BbS7a+6VKpVdqR
   IFNZaabwQTSRy5Qm087K00xpegnAOXG2w+oZkB798eyFtqsVjBdbl2x0G
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="400356512"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="400356512"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 01:13:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="858412928"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="858412928"
Received: from zhaohaif-mobl.ccr.corp.intel.com (HELO [10.249.174.131]) ([10.249.174.131])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 01:13:31 -0800
Message-ID: <56a9971e-7015-4584-89c7-80056b7ec547@linux.intel.com>
Date: Tue, 30 Jan 2024 17:13:29 +0800
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
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
In-Reply-To: <BN9PR11MB527674172BBA9BDC49A004D08C7D2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 1/30/2024 4:43 PM, Tian, Kevin wrote:
>> From: Ethan Zhao <haifeng.zhao@linux.intel.com>
>> Sent: Tuesday, January 30, 2024 4:16 PM
>>
>> On 1/30/2024 2:22 PM, Tian, Kevin wrote:
>>> Here we need consider two situations.
>>>
>>> One is that the device is not bound to a driver or bound to a driver
>>> which doesn't do active work to the device when it's removed. In
>>> that case one may observe the timeout situation only in the removal
>>> path as the stack dump in your patch02 shows.
>> When iommu_bus_notifier() got called for hotplug removal cases to
>> flush devTLB (ATS invalidation), driver was already unloaded.
>> whatever safe removal or surprise removal. so in theory no active
>> driver working there.
>>
>> pciehp_ist()
>>    pciehp_disable_slot()
>>     remove_board()
>>      pciehp_unconfigure_device()
>>       pci_stop_and_remove_bus_device()
>>        pci_stop_bus_device()--->here unload driver
>>        pci_remove_bus_device()->here qi_flush_dev_iotlb() got called.
> yes, so patch02 can fix this case.
>
>>> patch02 can fix that case by checking whether the device is present
>>> to skip sending the invalidation requests. So the logic being discussed
>>> here doesn't matter.
>>>
>>> The 2nd situation is more tricky. The device might be bound to
>>> a driver which is doing active work to the device with in-fly
>>> ATS invalidation requests. In this case in-fly requests must be aborted
>>> before the driver can be detached from the removed device. Conceptually
>>> a device is removed from the bus only after its driver is detached.
>> Some tricky situations:
>>
>> 1. The ATS invalidation request is issued from driver driver, while it is
>> in handling, device is removed. this momment, the device instance still
>> exists in the bus list. yes, if searching it by BDF, could get it.
> it's searchable between the point where the device is removed and the
> point where the driver is unloaded:
>
>          CPU0                                CPU1
>    (Driver is active)                    (pciehp handler)
>    qi_submit_sync()                      pciehp_ist()
>      ...                                   ...
>      loop for completion() {               pciehp_unconfigure_device()
>        ...                                   pci_dev_set_disconnected()
>        if (ITE) {                            ...
>          //find pci_dev from sid             pci_remove_bus_device()
>          if (pci_dev_is_connected())           device_del()
>            break;                                bus_remove_device()
>        }                                           device_remove_driver()

If the device was hot plugin or re-scanned, the device has a PCI_DEV_ADDED flag,
if so the driver unloading work isn't defered to the tail of device_del(), it
is unloaded before pci_remove_bus_device()->device_del(), in pci_stop_dev

pci_stop_bus_device()
  pci_stop_dev()
  {
   if (pci_dev_is_added(dev)) {
       device_release_driver(&dev->dev);
  }

So the interval the device is searchable, only applied to those devices
not hot plugged, or never be scanned.


Thanks,
Ethan

>        ..                                            //wait for driver unload
>      }
>      ..
>      return;
>
>                                                    BUS_NOTIFY_REMOVED_DEVICE;
>                                                list_del(&dev->bus_list);
>
> (I didn’t draw the full calling stack on the right hand side)

>
>> 2. The ATS invalidation request is issued from iommu_bus_notifier()
>> for surprise removal reason, as shown in above calltrace, device was
>> already removed from bus list. if searching it by BDF, return NULL.
>>
>> 3. The ATS invlidation request is issued from iommu_bus_notifier()
>> for safe removal, when is in handling, device is removed or link
>> is down. also as #2, device was already removed from bus list.
>> if searching it by BDF. got NULL.
>> ...
>>
>> so, searching device by BDF, only works for the ATS invalidation
>> request is from device driver.
>>
> anything related to bus notifier has been fixed by patch02.
>
> the remaining logic is really for fixing the race invalidation from
> device driver.

