Return-Path: <linux-pci+bounces-4221-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E87086BEA6
	for <lists+linux-pci@lfdr.de>; Thu, 29 Feb 2024 02:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A23B21C22712
	for <lists+linux-pci@lfdr.de>; Thu, 29 Feb 2024 01:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 232873612E;
	Thu, 29 Feb 2024 01:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z4DCk7e+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D7F37149;
	Thu, 29 Feb 2024 01:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709171933; cv=none; b=W8t/m74I3t9XcBq8v1mWWBtcdNAKWJ3GgdcDU6WAkJCQp4N9UzaAM/ALQ9GOYTSMkNgMR1VhPXeVgBKb+t6TGMNJe01QJXgzx2cgg81cDGlaG/BV0QU3wvIOo1BkWaGlUGcPkueJNIb3E09+BY81K0eGQuwRVGcj2OtvfZoo5ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709171933; c=relaxed/simple;
	bh=S8jmVo0I46uk03wXhxccYbMoWVhLMZ8mWEQqkTnYATs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HcvC5ckHJYqcdXVvBi6RVaRRTo0dRJIzZZNR+m9ePFsha0blJ22PUpLomP4QvMlwHOd42O0utrPJE21rlgp3znq7CH20ENGsiatWv+ohREpqpKNfsEVXxk02aqR5AswOjrDWV+a3lenq/2CF/rtICe3mJ4dimkNNGuxkZd21E8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z4DCk7e+; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709171930; x=1740707930;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=S8jmVo0I46uk03wXhxccYbMoWVhLMZ8mWEQqkTnYATs=;
  b=Z4DCk7e+tEOk4CWS5gI91thOkyY7JYrLHqL1oWNHvIfWrHW1qltRVpoq
   Tg6oMMEcd/m76oiC8FkhQQRTW16NxmAl2ZupX9HzoJ58u2ega/DXUNPUF
   V0/9GrebRlYsGetH6YySAGbvyKbQC4wJNoX3d+QxRiSpHsCbWqIOGMSLX
   lI/bDSaWKNHK0N7k47zqtklpwdGf4KusQ//z+854ED/WcWnbY2BhPVyqU
   BvI1gjfOfEdH5CteoU+vQ7Z7k05K9h+FU5FcxuNaD8AptM3XzP/BL/YyR
   7oKN2q9JB/7BQ6qJeBYHAkjg8AJyrZCIAq1CmGBliSk6FOOuS/uNMbVG8
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="3495735"
X-IronPort-AV: E=Sophos;i="6.06,192,1705392000"; 
   d="scan'208";a="3495735"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 17:58:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,192,1705392000"; 
   d="scan'208";a="7590267"
Received: from zhaohaif-mobl.ccr.corp.intel.com (HELO [10.124.229.115]) ([10.124.229.115])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 17:58:45 -0800
Message-ID: <c3585084-5587-49ca-bc2d-db92714a557b@linux.intel.com>
Date: Thu, 29 Feb 2024 09:58:43 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 1/3] PCI: make pci_dev_is_disconnected() helper public
 for other drivers
To: Bjorn Helgaas <helgaas@kernel.org>, Baolu Lu <baolu.lu@linux.intel.com>
Cc: bhelgaas@google.com, robin.murphy@arm.com, jgg@ziepe.ca,
 kevin.tian@intel.com, dwmw2@infradead.org, will@kernel.org, lukas@wunner.de,
 yi.l.liu@intel.com, dan.carpenter@linaro.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 Haorong Ye <yehaorong@bytedance.com>
References: <20240226230537.GA10383@bhelgaas>
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
In-Reply-To: <20240226230537.GA10383@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/27/2024 7:05 AM, Bjorn Helgaas wrote:
> On Thu, Feb 22, 2024 at 08:54:54PM +0800, Baolu Lu wrote:
>> On 2024/2/22 17:02, Ethan Zhao wrote:
>>> Make pci_dev_is_disconnected() public so that it can be called from
>>> Intel VT-d driver to quickly fix/workaround the surprise removal
>>> unplug hang issue for those ATS capable devices on PCIe switch downstream
>>> hotplug capable ports.
>>>
>>> Beside pci_device_is_present() function, this one has no config space
>>> space access, so is light enough to optimize the normal pure surprise
>>> removal and safe removal flow.
>>>
>>> Tested-by: Haorong Ye<yehaorong@bytedance.com>
>>> Signed-off-by: Ethan Zhao<haifeng.zhao@linux.intel.com>
>>> ---
>>>    drivers/pci/pci.h   | 5 -----
>>>    include/linux/pci.h | 5 +++++
>>>    2 files changed, 5 insertions(+), 5 deletions(-)
>> Hi PCI subsystem maintainers,
>>
>> The iommu drivers (including, but not limited to, the Intel VT-d driver)
>> require a helper to check the physical presence of a PCI device in two
>> scenarios:
>>
>> - During the iommu_release_device() path: This ensures the device is
>>    physically present before sending device TLB invalidation to device.
> This wording is fundamentally wrong.  Testing
> pci_dev_is_disconnected() can never ensure the device will still be
> present by the time a TLB invalidation is sent.

The logic of testing pci_dev_is_disconnected() in patch [2/3] works
in the opposite:

1. if pci_dev_is_disconnected() return true, means the device is in
    the process of surprise removal handling, adapter already been
    removed from the slot.

2. for removed device, no need to send ATS invalidation request to it.
    removed device lost power, its devTLB wouldn't be valid anymore.

3. if pci_dev_is_disconnected() return false, the device is *likely*
    to be removed at any momoment after this function called.
    such case will be treated in the iommu ITE fault handling, not to
    retry the timeout request if device isn't present (patch [3/3]).

>
> The device may be removed after the pci_dev_is_disconnected() test and
> before a TLB invalidate is sent.

even in the process while TLB is invalidating.

>
> This is why I hesitate to expose pci_dev_is_disconnected() (and
> pci_device_is_present(), which we already export) outside
> drivers/pci/.  They both lead to terrible mistakes like relying on the
> false assumption that the result will remain valid after the functions
> return, without any recognition that we MUST be able to deal with the
> cases where that assumption is broken.

Yup, your concern is worthy ,but isn't happening within this patchset.

>
> This series claims to avoid "continuous hard lockup warnings and
> system hangs".  It may reduce the likelihood, but I don't think it can
> completely avoid them.

It doesn't try to close the race window, actually we are doing post-fault
handling in patch [3/3].

>
> I don't see any acknowledgement of that in the commit logs of this
> series.  E.g., it doesn't say "we can recover from ATS Invalidate
> Completion Timeouts, but the timeouts are on the order of minutes, so
> we want to avoid them when possible."
> And given the "system hangs" language, I am not convinced that we
> actually *can* recover from those timeouts.

It is testing in customer's environment. separatly, patch[3/3] vs

patch [2/3].

>
> Using pci_dev_is_disconnected() may make those timeouts less frequent

will test patch[3/3] alone, if couldn't recover from the 100% ITE fault
case, we will look for other method.

Thanks,
Ethan

> and give the illusion that the problem is "solved", but it just means
> the problem is still there and harder to reproduce.
>
>> - During the device driver lifecycle when a device TLB invalidation
>>    timeout event is generated by the IOMMU hardware: This helps handle
>>    situations where the device might have been hot-removed.
>>
>> While there may be some adjustments needed in patch 3/3, I'd like to
>> confirm with you whether it's feasible to expose this helper for general
>> use within the iommu subsystem.
>>
>> If you agree with this change, I can route this patch to Linus through
>> the iommu tree with an "acked-by" or "reviewed-by" tag from you.
>>
>> Best regards,
>> baolu

