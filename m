Return-Path: <linux-pci+bounces-10821-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C62C93CCB9
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jul 2024 04:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 266F0B21F08
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jul 2024 02:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB7118E11;
	Fri, 26 Jul 2024 02:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MzqyC5h/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19FA1BF3F;
	Fri, 26 Jul 2024 02:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721960858; cv=none; b=ME1thCfHgNtc9S9RD7sj8xiVKhAzQGLj1hFpyOTY9v8+KAMhORUl4nZVqH6+BHfvwvy+rA/sQn2bOvUhUXcpTnMwkPzImqm1+OPdNPEYn5r3qsWfoePFtScFY0sPpeahHwdvEPjw759itFez+O2rwUysrIi+KaNfjUJgSwWV+yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721960858; c=relaxed/simple;
	bh=OkGGEReskTiFAIXNmGQ7mm5sTD6cKpXvGbExc4kIzQA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QpH4I24y5HJfV4xvzZFLBtUQt1+/5ZH9qb9szpQrvpNa4+SQAUecS2wBT5aoqbbf2OoeVR5cWGVdjZq/IF8xsIc2yZbYHM+eYqAOiJFiXK8LezdHwlN55yfOgCHgRimqHPV7JH4LpVacfTyAXKXwstws8GgLhrb109HXrUH0MaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MzqyC5h/; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721960857; x=1753496857;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OkGGEReskTiFAIXNmGQ7mm5sTD6cKpXvGbExc4kIzQA=;
  b=MzqyC5h/yl1rxRhjmMA43KR6xrrXvsrljrjATmbZL2Oq3AVXioErYZ0R
   TePrRxkprXcv8FYx8I4kE7odmjNpHEVVJSnMWd4NJDNZ/YWCzQ4ie2O/H
   K07Bawus8FJMA1dhbKuEZnEQvqkdepBxM9PVysWXyp24tdE3WPee6a3aB
   Wg3USdnHQkz0zvZVd9TxgCyozWN5zyV76hJKpUPFcsfA3MGvxRPh1kBoX
   j3AsuWHNl3Y9e5MTp5yzt98xx4wo8VkzqYFMOeFM62d89VoOC55awq2eV
   LrJrEwbaTjENxKIK6ulnLFXswCKFsD3xOXWGv5M+NHtKXJGxiGV+iZuz8
   Q==;
X-CSE-ConnectionGUID: hUwd+BW0RDWoAkrjEAiVtg==
X-CSE-MsgGUID: 0Ar1EanoQduDGp4iQ4Vsfg==
X-IronPort-AV: E=McAfee;i="6700,10204,11144"; a="19433076"
X-IronPort-AV: E=Sophos;i="6.09,237,1716274800"; 
   d="scan'208";a="19433076"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2024 19:27:36 -0700
X-CSE-ConnectionGUID: /b/Z+7GqQc+kjuf6j66h2Q==
X-CSE-MsgGUID: xSRy6hZSS9msm+Xeyu684Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,237,1716274800"; 
   d="scan'208";a="57946862"
Received: from zhaohaif-mobl.ccr.corp.intel.com (HELO [10.125.241.20]) ([10.125.241.20])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2024 19:27:34 -0700
Message-ID: <58ca7ae5-2197-4fd5-afe6-73743cd45e8c@linux.intel.com>
Date: Fri, 26 Jul 2024 10:27:31 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] PCI: Enable io space 1k granularity for intel cpu root
 port
To: Zhou Shengqing <zhoushengqing@ttyinfo.com>
Cc: helgaas@kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, lkp@intel.com, llvm@lists.linux.dev,
 oe-kbuild-all@lists.linux.dev
References: <2912551a-b4c6-4bd4-8c1c-22de7fd8fa20@linux.intel.com>
 <20240725074403.12928-1-zhoushengqing@ttyinfo.com>
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
In-Reply-To: <20240725074403.12928-1-zhoushengqing@ttyinfo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 7/25/2024 3:44 PM, Zhou Shengqing wrote:
>> On 7/24/2024 2:35 PM, Zhou Shengqing wrote:
>>>>> Do you mean it shoud be like this?
>>>>>
>>>>> 	while ((d = pci_get_device(PCI_VENDOR_ID_INTEL, 0x09a2, d))) {
>>>>> 		if (d->bus->number == dev->bus->number) {
>>>>> 			pci_read_config_word(d, 0x1c0, &en1k);
>>>>> 			if (en1k & 0x4) {
>>>>> 				pci_info(dev, "1K I/O windows enabled per %s EN1K setting\n", pci_name(d));
>>>>> 				dev->io_window_1k = 1;
>>>>> 			}
>>>>> 		}
>>>>> 	}
>>>>>
>>>>>> 00:00.0 System peripheral: Intel Corporation Device 09a2 (rev 20)
>>>>>> 00:0f.0 PCI bridge: Intel Corporation Device 1bbf (rev 10) (prog-if 00 [Normal decode])
>>>>>>
>>>>>>      
>>>>>> 15:00.0 System peripheral: Intel Corporation Device 09a2 (rev 20)
>>>>>> 15:01.0 PCI bridge: Intel Corporation Device 352a (rev 04) (prog-if 00 [Normal decode])
>>>>>>
>>>>>> and if you check domain number only, they might sit on different bus, perhaps that
>>>>>> would make thing complex, could you make sure the VT-d is on the upstream bus of the
>>>>>> bridge ?
>>>>> I checked it on ICX SPR EMR GNR, VT-d is always on the same bus with root port,
>>>>> and VT-d device and function number is always 0.
>>>> Yes, every VT-d instance in the root complex and the root port integrated are
>>>> on the same bus. and VT-d is the first device of that bus.
>>>>
>>>> The EDS doesn't say if there is exception one of the VT-d instances in an
>>>> system its EN1K wasn't set while others were set, vice vesa. so I suggest
>>>> just check the VT-d and then set the root port's io_windows_1k of the same bus.
>>> But as Bjorn mentioned at July 12, 2024, 6:48 p.m.,
>>>
>>> "To be safe, "d" (the [8086:09a2] device) should be on the same bus as
>>> "dev" (with VMD, I think we get Root Ports *below* the VMD bridge,
>>> which would be a different bus, and they presumably are not influenced
>>> by the EN1K bit."
>>>
>>> When VMD enabled, just check bus number identical may lead to enable
>>> 1k io windows for VMD domain root port. E.g. 0000:80:00.0 is a
>>> VT-d(09a2). If VMD enabled, there might be a root port 10000:80:01.0 present.
>>> this code may lead to enable 10000:80:01.0 io_window_1k = 1.
>>> This is probably not expected.
>>>
>>> If I modify it like this,
>>>
>>> 	while ((d = pci_get_device(PCI_VENDOR_ID_INTEL, 0x09a2, d))) {
>> BTW, don't save letters to use single letter variable 'd', please use 'vtd_dev' or
>> something else to express the VT-d device.
> Got it!
>
>>> 	---if (d->bus->number == dev->bus->number) {
>>> 	+++if (d->bus == dev->bus) {
>> What if their 'bus' are NULL, though it is almost impossible. :)
>>
>>> 			pci_read_config_word(d, 0x1c0, &en1k);
>>> 			if (en1k & 0x4) {
>>> 				pci_info(dev, "1K I/O windows enabled per %s EN1K setting\n", pci_name(d));
>>> 				dev->io_window_1k = 1;
>>> 			}
>>> 		}
>>> 	}
>>>       
>>> Can the situation mentioned above be avoided?
>> Yes, my understanding, as Bjorn pointed out root port extended from VMD
>> bridge not on the same bus as VT-d.
> For the root port extended from VMD, should the 1k window be set
> when BIOS setup EN1K knob enabled?
> In my case, I think  EN1K should not apply to the VMD root port.
>
> But what I'm confused about is, how can I reasonably exclude the VMD root port
> in the code?

VMD, if enabled, is EP, not RP. and its RPs are mapped into its own space, and
sit at different buses as VT-d, no need to care about them if am correct.

Thanks,
Ethan

>>
>

