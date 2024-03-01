Return-Path: <linux-pci+bounces-4289-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83FFE86D955
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 03:04:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4816B212B4
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 02:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F14383A9;
	Fri,  1 Mar 2024 02:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GOVRdKUp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4302B9A8;
	Fri,  1 Mar 2024 02:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709258638; cv=none; b=c3RRvqpri+OWH/Qe0+9SSGLo36FJw4OlRSK+aUa1hAt+tGDuzJLFWmKVXQRnz/dpPmNRIQQGak8Uq9Toh9T7PUU+fkBQaj+XbehtT3m7/R1ZRWGF6qP8gx2oOG0xCkAXG33kIN/3Dj/uKuh+YC7xs8rx5xDO0GkLgWOw7rItiFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709258638; c=relaxed/simple;
	bh=D0UYIJU+Wae4fIkSE6J7PCAdA+0TfZGkj99JFM0PZIw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r01j5HiNOEHVSZ4JiZ2I1WsyTXUFx5xfUETg8OhPUQKvd+Djf3Qk+FuGZ/gqkS9QUzrpkmklbEX2cy3qa7PiPI8Ha5VExjj4wNrmdGETnGZkHydNwPvgzv8RdQP4ell/rxnTBcmQjplvcxYHLXr4JDKz5SYyIshPPjBEbjidgj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GOVRdKUp; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709258637; x=1740794637;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=D0UYIJU+Wae4fIkSE6J7PCAdA+0TfZGkj99JFM0PZIw=;
  b=GOVRdKUpiFM4i5eZDjEj5RekeGPW6XH/s739W0XwKz0Jfjddx1jNHfgp
   Cxyo4arTkF0UE9FYb3NTmNJVp+oD0M22h+svx2N3AUBW0MxZDk384qTD4
   tYcmxJMTy6nvDSx/XVe8vhA/LvdZg2Q5bKuWl/aAeC5Ydp1vzrH/EBFR/
   jB52DLT9lZDabw5xau5Ph/Ha7lyc5RnvXMA2K+bxPDCbgCybg7SsaI1I3
   aWLK2l3I8wCx1gXZC/3JK1j0WwtOHHX2QDmi8vd2HhLYwnRr7lNdMyjMT
   sCrPmi4qhyF1elxgv9im33q81CnVGORjym3Wa7Tm8SIlpXSAIWOMV3T/V
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="14925480"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="14925480"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 18:03:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="12579781"
Received: from zhaohaif-mobl.ccr.corp.intel.com (HELO [10.124.229.115]) ([10.124.229.115])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 18:03:51 -0800
Message-ID: <5a137fa9-c18d-44e1-b486-1256b677c678@linux.intel.com>
Date: Fri, 1 Mar 2024 10:03:49 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 1/3] PCI: make pci_dev_is_disconnected() helper public
 for other drivers
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, bhelgaas@google.com,
 robin.murphy@arm.com, jgg@ziepe.ca, kevin.tian@intel.com,
 dwmw2@infradead.org, will@kernel.org, lukas@wunner.de, yi.l.liu@intel.com,
 dan.carpenter@linaro.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 Haorong Ye <yehaorong@bytedance.com>
References: <20240229223302.GA363505@bhelgaas>
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
In-Reply-To: <20240229223302.GA363505@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/1/2024 6:33 AM, Bjorn Helgaas wrote:
> On Thu, Feb 29, 2024 at 09:58:43AM +0800, Ethan Zhao wrote:
>> On 2/27/2024 7:05 AM, Bjorn Helgaas wrote:
>>> On Thu, Feb 22, 2024 at 08:54:54PM +0800, Baolu Lu wrote:
>>>> On 2024/2/22 17:02, Ethan Zhao wrote:
>>>>> Make pci_dev_is_disconnected() public so that it can be called from
>>>>> Intel VT-d driver to quickly fix/workaround the surprise removal
>>>>> unplug hang issue for those ATS capable devices on PCIe switch downstream
>>>>> hotplug capable ports.
>>>>>
>>>>> Beside pci_device_is_present() function, this one has no config space
>>>>> space access, so is light enough to optimize the normal pure surprise
>>>>> removal and safe removal flow.
>>>>>
>>>>> Tested-by: Haorong Ye<yehaorong@bytedance.com>
>>>>> Signed-off-by: Ethan Zhao<haifeng.zhao@linux.intel.com>
>>>>> ---
>>>>>     drivers/pci/pci.h   | 5 -----
>>>>>     include/linux/pci.h | 5 +++++
>>>>>     2 files changed, 5 insertions(+), 5 deletions(-)
>>>> Hi PCI subsystem maintainers,
>>>>
>>>> The iommu drivers (including, but not limited to, the Intel VT-d driver)
>>>> require a helper to check the physical presence of a PCI device in two
>>>> scenarios:
>>>>
>>>> - During the iommu_release_device() path: This ensures the device is
>>>>     physically present before sending device TLB invalidation to device.
>>> This wording is fundamentally wrong.  Testing
>>> pci_dev_is_disconnected() can never ensure the device will still be
>>> present by the time a TLB invalidation is sent.
>> The logic of testing pci_dev_is_disconnected() in patch [2/3] works
>> in the opposite:
>>
>> 1. if pci_dev_is_disconnected() return true, means the device is in
>>     the process of surprise removal handling, adapter already been
>>     removed from the slot.
>>
>> 2. for removed device, no need to send ATS invalidation request to it.
>>     removed device lost power, its devTLB wouldn't be valid anymore.
>>
>> 3. if pci_dev_is_disconnected() return false, the device is *likely*
>>     to be removed at any momoment after this function called.
>>     such case will be treated in the iommu ITE fault handling, not to
>>     retry the timeout request if device isn't present (patch [3/3]).
>>
>>> The device may be removed after the pci_dev_is_disconnected() test and
>>> before a TLB invalidate is sent.
>> even in the process while TLB is invalidating.
>>
>>> This is why I hesitate to expose pci_dev_is_disconnected() (and
>>> pci_device_is_present(), which we already export) outside
>>> drivers/pci/.  They both lead to terrible mistakes like relying on the
>>> false assumption that the result will remain valid after the functions
>>> return, without any recognition that we MUST be able to deal with the
>>> cases where that assumption is broken.
>> Yup, your concern is worthy ,but isn't happening within this patchset.
> OK, I acked the patch.

Great !

>
> I guess my complaint is really with pci_device_is_present() because
> that's even harder to use correctly.
>
> pci_device_is_present():
>    slow (may do config access to device)
>    true  => device *was* present in the recent past, may not be now
>    false => device is not accessible

so the 'false' result is reliable for post-calling code, then give up
more attempt of the same request. the usage in patch[3/3]

>
> pci_dev_is_disconnected():
>    fast (doesn't touch device)
>    true  => device is not accessible

also we are relying on the 'true' result returned, used in  patch[2/3].

>    false => basically means nothing
>
> I guess they're both hard ;)

seems I didn't mess them up. :)

Thanks,
Ethan

>
> Bjorn

