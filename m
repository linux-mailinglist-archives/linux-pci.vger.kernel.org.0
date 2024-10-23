Return-Path: <linux-pci+bounces-15088-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1959ABCE9
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 06:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A2372846C7
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 04:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023C18289A;
	Wed, 23 Oct 2024 04:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RcAgTSAq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15917611E;
	Wed, 23 Oct 2024 04:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729657451; cv=none; b=Y2H6cLnlJhx/O4K4v1gDenH5I/j9N1Srd9hkXg4+mzDhHm8bSczKlWgGTkMVqQW58xMIV4zmArpmimWg9XumQJsSSajB/0ohjnsCaKX6k7WlZ2hitGoFjuYOwBlFVSHTFAwXM8/qNVOX1qTPcfMgyaZnzTmIWHr8ZVIHFg+UgmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729657451; c=relaxed/simple;
	bh=vjzKtv+fNYXbH8kQ0M16SYnCrW9aO+lJfCoZJwJZW6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S9xNrQT1KFKr6BNAHy5Ixd8GcZftzJOjVnkPnxZXgjBVs8ztx1c9KepYyrbQf/WoGn/fGpCjjVBWhU6mPLE84utK4R5DaM6JHUEyZrPeuyHAW1AvPGrlRYbtKjSEkIxISJy7XI20Qow4wngjNzd6QfQsPf+g6J7hJivjHnxOz0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RcAgTSAq; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729657450; x=1761193450;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vjzKtv+fNYXbH8kQ0M16SYnCrW9aO+lJfCoZJwJZW6s=;
  b=RcAgTSAqrieGDpU6iXhOyQ6KHXALVmTmibsvjUHwBnr1evFmYL64/8SO
   n+hnw0wBq54B6pFDy3l0yjDjsao2WhF2FYLxR4w+/BymgjXSUbti0TGy2
   DwpY8Yg81SwxZ04L2QKvJVIeIGA5MyhbC6SOPq4EyoarAFUtv3jOZG6g9
   Q1WzM3RDZSuOpf3+zJvXjw7OSgIRBzMSJ4058sl/m8OVEgBuOQ0IyJQ0G
   UeIeo4NwwDghC9cEag8hu4Q1biZIcJ5r9eyDavoifvbUyuRurFBf0BE1i
   Kt/mOrzjLpAHXVeUQFWsyDbG+ZO9nIw3oLAPtpMa6rzmq89wT/77otOCw
   Q==;
X-CSE-ConnectionGUID: 7sAzrUHqQYWD4KYMSH6/hg==
X-CSE-MsgGUID: 45HsM3bHQbO3cR3e7l+0Qw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29007128"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29007128"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 21:24:09 -0700
X-CSE-ConnectionGUID: q+lyIo4sQtKlZDkhbKOJNg==
X-CSE-MsgGUID: PSH65DBjRH2sY7nQocQ68Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,225,1725346800"; 
   d="scan'208";a="79647731"
Received: from zhanghao-mobl.ccr.corp.intel.com (HELO [10.238.129.184]) ([10.238.129.184])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 21:24:08 -0700
Message-ID: <3354e37e-c48a-4696-a074-2df9e625fc0c@linux.intel.com>
Date: Wed, 23 Oct 2024 12:23:54 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: pciehp: Fix system hang on resume after hot-unplug
 during suspend
To: AceLan Kao <acelan.kao@canonical.com>, Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240926125909.2362244-1-acelan.kao@canonical.com>
 <ZvVgTGVSco0Kg7H5@wunner.de>
 <CAFv23Q=5KdqDHYxf9PVO=kq=VqP0LwRaHQ-KnY2taDEkZ9Fueg@mail.gmail.com>
 <ZvZ61srt3QAca2AI@wunner.de> <Zvf7xYEA32VgLRJ6@wunner.de>
 <CAFv23QkwxmT7qrnbfEpJNN+mnevNAor6Dk7efvYNOdjR9tGyrw@mail.gmail.com>
 <ZvvW1ua2UjwHIOEN@wunner.de> <ZvvXDQSBRZMEI2EX@wunner.de>
 <CAFv23Q=4O5czQaNw2mEnwkb9LQfODfQDeW+qQD14rfdeVEwjwA@mail.gmail.com>
 <CAFv23QmAOAobFC=4tkKBM4NQPR_b3Nsji5xa+TczUbAJ1dxhvg@mail.gmail.com>
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
In-Reply-To: <CAFv23QmAOAobFC=4tkKBM4NQPR_b3Nsji5xa+TczUbAJ1dxhvg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/17/2024 10:40 AM, AceLan Kao wrote:
> AceLan Kao <acelan.kao@canonical.com> 於 2024年10月7日 週一 下午12:34寫道：
>> Lukas Wunner <lukas@wunner.de> 於 2024年10月1日 週二 下午7:03寫道：
>>> On Tue, Oct 01, 2024 at 01:02:46PM +0200, Lukas Wunner wrote:
>>>> On Mon, Sep 30, 2024 at 09:31:53AM +0800, AceLan Kao wrote:
>>>>> Lukas Wunner <lukas@wunner.de> 2024 9 28 8:51:
>>>>>> -       if (pci_get_dsn(pdev) != ctrl->dsn)
>>>>>> +       dsn = pci_get_dsn(pdev);
>>>>>> +       if (!PCI_POSSIBLE_ERROR(dsn) &&
>>>>>> +           dsn != ctrl->dsn)
>>>>>>                  return true;
>>>>> In my case, the pciehp_device_replaced() returns true from this final check.
>>>>> And these are the values I got
>>>>> dsn = 0x00000000, ctrl->dsn = 0x7800AA00
>>>>> dsn = 0x00000000, ctrl->dsn = 0x21B7D000
>>>> Ah because pci_get_dsn() returns 0 if the device is gone.
>>>> Below is a modified patch which returns false in that case.
>>> Sorry, forgot to include the patch:
>>>
>>> -- >8 --
>>>
>>> diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
>>> index ff458e6..957c320 100644
>>> --- a/drivers/pci/hotplug/pciehp_core.c
>>> +++ b/drivers/pci/hotplug/pciehp_core.c
>>> @@ -287,24 +287,32 @@ static int pciehp_suspend(struct pcie_device *dev)
>>>   static bool pciehp_device_replaced(struct controller *ctrl)
>>>   {
>>>          struct pci_dev *pdev __free(pci_dev_put);
>>> +       u64 dsn;
>>>          u32 reg;
>>>
>>>          pdev = pci_get_slot(ctrl->pcie->port->subordinate, PCI_DEVFN(0, 0));
>>>          if (!pdev)
>>> +               return false;
>>> +
>>> +       if (pci_read_config_dword(pdev, PCI_VENDOR_ID, &reg) == 0 &&
>>> +           !PCI_POSSIBLE_ERROR(reg) &&
>>> +           reg != (pdev->vendor | (pdev->device << 16)))
>>>                  return true;
>>>
>>> -       if (pci_read_config_dword(pdev, PCI_VENDOR_ID, &reg) ||
>>> -           reg != (pdev->vendor | (pdev->device << 16)) ||
>>> -           pci_read_config_dword(pdev, PCI_CLASS_REVISION, &reg) ||
>>> +       if (pci_read_config_dword(pdev, PCI_CLASS_REVISION, &reg) == 0 &&
>>> +           !PCI_POSSIBLE_ERROR(reg) &&
>>>              reg != (pdev->revision | (pdev->class << 8)))
>>>                  return true;
>>>
>>>          if (pdev->hdr_type == PCI_HEADER_TYPE_NORMAL &&
>>> -           (pci_read_config_dword(pdev, PCI_SUBSYSTEM_VENDOR_ID, &reg) ||
>>> -            reg != (pdev->subsystem_vendor | (pdev->subsystem_device << 16))))
>>> +           pci_read_config_dword(pdev, PCI_SUBSYSTEM_VENDOR_ID, &reg) == 0 &&
>>> +           !PCI_POSSIBLE_ERROR(reg) &&
>>> +           reg != (pdev->subsystem_vendor | (pdev->subsystem_device << 16)))
>>>                  return true;
>>>
>>> -       if (pci_get_dsn(pdev) != ctrl->dsn)
>>> +       if ((dsn = pci_get_dsn(pdev)) &&
>>> +           !PCI_POSSIBLE_ERROR(dsn) &&
>>> +           dsn != ctrl->dsn)
>>>                  return true;
>>>
>>>          return false;
>> Hi Lukas,
>>
>> Sorry for the late reply, just encountered a strong typhoon in my area
>> last week and can't check this in our lab.
>>
>> The patched pciehp_device_replaced() returns false at the end of the
>> function in my case.
>> Unplug the dock which is connected with a tbt storage won't be
>> considered as a replacement.
>>
>> But when I tried to replace the dock with the tbt storage during
>> suspend, it still returned false at the end of the function like
>> unplugged.
>>
>> BTW, it's a new model, so I think the ICM is used. And the reg is
>> 0xffffffff when unplugged.
> Hi Lukas,
>
> PCI_POSSIBLE_ERROR() always returns true no matter the device is
> replaced or unplugged
> It seems difficult to distinguish between when a device is replaced
> and when it's unplugged.

If DSN (Device Serial Number) is not optional extended capability, then
we could use it as a tag to know if the device is replaced or unplugged.

So it would be better to have something like DSN but not optional in spec.

Thanks,
Ethan

>
> Do you have any ideas to fix the issue?
> This issue is severe to me, because the system hangs almost everytime
> when daisy chain tbt devices are unplugged when suspended.
> Thanks.
>

