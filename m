Return-Path: <linux-pci+bounces-3332-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B21C850B0A
	for <lists+linux-pci@lfdr.de>; Sun, 11 Feb 2024 20:15:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27C71281A70
	for <lists+linux-pci@lfdr.de>; Sun, 11 Feb 2024 19:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BACF85D462;
	Sun, 11 Feb 2024 19:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mYEzlpYp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AFA1E860;
	Sun, 11 Feb 2024 19:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707678947; cv=none; b=BRXR9BIZMifUZTCNdkJOu5yr86W2dxMgDg6aKl26BKIGow8vKo6sYbnTImcejvdIZ8tENVUIitBxXUBK0QapDzKXIyvHcv+GLMykJKiqYNluhfWyaLsWGwqd7WYCWsSwZb9A4YXYog73T+avbGVrsHiiMWvhHCQadK0MDKz4jBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707678947; c=relaxed/simple;
	bh=56x/jvIhC05yachM7n0DI39wwW9IIY/gr0UEahLt/j4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PxwpWvY7kWeykyC41m+sweSytlmAZ5fw2pKyQpGwsEOQnpv2weBAL9i8GgiIgGF683KueGS7OoVZBMBCDF0zmIWhZ6bYZm+opxLf67P8oZn2p7/Y3qv1HHvtQt7ABLMVfBTu2mWwOonA0wXnGJMEJfenzfkPUY+lAzRRQxm/QDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mYEzlpYp; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707678946; x=1739214946;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=56x/jvIhC05yachM7n0DI39wwW9IIY/gr0UEahLt/j4=;
  b=mYEzlpYpND8fKcY44g03PgsMQGTRIjXFKYP/h5hy26iURCQ53P4rjnx8
   e+EQbtfRnZzX0Y/8RvidD2HgWc3tb1bdA+u70qajE91ldZaGUS8wXzFvC
   Jkfo7OMwveNGQhQndXzFAez9YF0NT2yHz6a7bR6G0udt6EKCHM6lNCnT6
   mzfTGpk0r3qlOFqPT6Yq2gfd5qaBvLIgjiYsci/mtkRi0/vmvQBC9TBbB
   QAXRdmqsqQX7jHd4li+3jyKJ09Ac79VYNlZjZ3FL7GT+eD6EI9MvWpiJy
   k6GzegLBykwKSPmN2ookLJqLDQJxBPg0gK+zmIjTQpmIsrQA2nvIXJ9zS
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="1797813"
X-IronPort-AV: E=Sophos;i="6.05,261,1701158400"; 
   d="scan'208";a="1797813"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2024 11:15:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,261,1701158400"; 
   d="scan'208";a="39863315"
Received: from ybradsha-mobl1.amr.corp.intel.com (HELO [10.209.92.13]) ([10.209.92.13])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2024 11:15:45 -0800
Message-ID: <fbe4efac-2ce3-443c-9b49-de207e4ba82f@linux.intel.com>
Date: Sun, 11 Feb 2024 11:15:44 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] PCI/IOV: Revert "PCI/IOV: Serialize sysfs
 sriov_numvfs reads vs writes"
Content-Language: en-US
To: Leon Romanovsky <leonro@nvidia.com>
Cc: Jim Harris <jim.harris@samsung.com>, Bjorn Helgaas <bhelgaas@google.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Jason Gunthorpe <jgg@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 "pierre.cregut@orange.com" <pierre.cregut@orange.com>
References: <170752254154.1693615.9176696143128338408.stgit@bgt-140510-bm01.eng.stellus.in>
 <CGME20240209235213uscas1p2e8de2bdf05e6e7cba51bd41ddb42a8e4@uscas1p2.samsung.com>
 <170752273224.1693615.11371097645648272257.stgit@bgt-140510-bm01.eng.stellus.in>
 <10d63412-583b-4647-bb5c-4113a466324e@linux.intel.com>
 <20240211084844.GA805332@unreal>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240211084844.GA805332@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 2/11/24 12:48 AM, Leon Romanovsky wrote:
> On Fri, Feb 09, 2024 at 07:20:28PM -0800, Kuppuswamy Sathyanarayanan wrote:
>> On 2/9/24 3:52 PM, Jim Harris wrote:
>>> If an SR-IOV enabled device is held by vfio, and the device is removed,
>>> vfio will hold device lock and notify userspace of the removal. If
>>> userspace reads the sriov_numvfs sysfs entry, that thread will be blocked
>>> since sriov_numvfs_show() also tries to acquire the device lock. If that
>>> same thread is responsible for releasing the device to vfio, it results in
>>> a deadlock.
>>>
>>> The proper way to detect a change to the num_VFs value is to listen for a
>>> sysfs event, not to add a device_lock() on the attribute _show() in the
>>> kernel.
>> Since you are reverting a commit that synchronizes SysFS read
>> /write, please add some comments about why it is not an
>> issue anymore.
> It was never an issue, the idea that sysfs read and write should be serialized by kernel
> is not correct by definition. 

What:           /sys/bus/pci/devices/.../sriov_numvfs
Date:           November 2012
Contact:        Donald Dutile <ddutile@redhat.com>
Description:
                This file appears when a physical PCIe device supports SR-IOV.
                Userspace applications can read and write to this file to
                determine and control the enablement or disablement of Virtual
                Functions (VFs) on the physical function (PF). A read of this
                file will return the number of VFs that are enabled on this PF.

I am not very clear about the user of this SysFs. But, as per above description,
this sysfs seems to controls the number of VFs. A typical usage is to allow user
to write a value and then read to check the enabled/disabled number of VMs,
right?

If you are not synchronizing, then the value returned may not reflect the actual
number of enabled / disabled VFs. So wont this change affect the existing user
of this SysFS.

>
> Thanks
>
>>> This reverts commit 35ff867b76576e32f34c698ccd11343f7d616204.
>>> Revert had a small conflict, the sprintf() is now changed to sysfs_emit().
>>>
>>> Link: https://lore.kernel.org/linux-pci/ZXJI5+f8bUelVXqu@ubuntu/
>>> Suggested-by: Leon Romanovsky <leonro@nvidia.com>
>>> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
>>> Signed-off-by: Jim Harris <jim.harris@samsung.com>
>>> ---
>>>  drivers/pci/iov.c |    8 +-------
>>>  1 file changed, 1 insertion(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
>>> index aaa33e8dc4c9..0ca20cd518d5 100644
>>> --- a/drivers/pci/iov.c
>>> +++ b/drivers/pci/iov.c
>>> @@ -395,14 +395,8 @@ static ssize_t sriov_numvfs_show(struct device *dev,
>>>  				 char *buf)
>>>  {
>>>  	struct pci_dev *pdev = to_pci_dev(dev);
>>> -	u16 num_vfs;
>>> -
>>> -	/* Serialize vs sriov_numvfs_store() so readers see valid num_VFs */
>>> -	device_lock(&pdev->dev);
>>> -	num_vfs = pdev->sriov->num_VFs;
>>> -	device_unlock(&pdev->dev);
>>>  
>>> -	return sysfs_emit(buf, "%u\n", num_vfs);
>>> +	return sysfs_emit(buf, "%u\n", pdev->sriov->num_VFs);
>>>  }
>>>  
>>>  /*
>>>
>> -- 
>> Sathyanarayanan Kuppuswamy
>> Linux Kernel Developer
>>
-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


