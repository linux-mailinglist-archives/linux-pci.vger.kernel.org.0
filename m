Return-Path: <linux-pci+bounces-10714-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8090F93AD71
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 09:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3BE51C21136
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 07:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75BBF7A141;
	Wed, 24 Jul 2024 07:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ANzTPlaI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C914E1C8;
	Wed, 24 Jul 2024 07:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721807486; cv=none; b=TY5vW+pfRFtiUyhNLQWDHObagBpIvCMdQh9i4DNV/1pjzD83clYMRNotPxxZqDkMHqDsfR3FAdIerAiNW4xANkaJT6b/GMFcqk9RD6ATDDWzc+cxO2/MZSlAlJzLCo/bC0GJ11Q4cJJ6QPPaRb2Q4n3BzXJEeAv9GPqpqVk6P/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721807486; c=relaxed/simple;
	bh=uzG+0JXYF6qzJjbjP5yT/qZlyYhyA8maeX4y4RjiLZw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ATMGZxnRlx/uXNfA1aVJcZEPwrne+WwXZKSCWb1uzLorm9dySd+sDRZGCXg604IcghF5xoSTK5U7BtaYC9eehCCGTi/3cS67hxzjzNRBFiuPPAdvfhEeUt/ZJLpcwSmBURT//8wk25ihGYTLhdsKlP/uCrtkrNGaYOoocCwLcoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ANzTPlaI; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721807484; x=1753343484;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=uzG+0JXYF6qzJjbjP5yT/qZlyYhyA8maeX4y4RjiLZw=;
  b=ANzTPlaIIwnIgNHl6xRHM/RUDOYjNsTSyH9rwsCfXWDh9dU7feGacq6s
   q1KoV0AJW9xaCFkJtvTBFsXAnS/tPXvA2fZazO4SpK+SpsBdro4tZdfOs
   bFujiM9wPxQq/jezUh8weOcz6v5cKllK543I+X2mEfeS42y1fVv7OE/LE
   j3CZrAJPPk/XxYhPmZ691G1xnePszr5Kza+Or9qG6jGPsSkdOweDI9aKW
   rkP20NcFTrP7pQBjxibyUmN5Sl5VmsaTU1WnYAGitGlec9cq7BxWfHPbe
   HrJrt1fi0AAJ7cbE0ZfI9WA5v4C6ZFcC/KxXYZbCdobgZ82qgHPWvVOvB
   g==;
X-CSE-ConnectionGUID: 6Cdx82NASVqkHz2HKfPw4w==
X-CSE-MsgGUID: 5jX95lcyR2KlbSxwQ2DUEQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11142"; a="30887504"
X-IronPort-AV: E=Sophos;i="6.09,232,1716274800"; 
   d="scan'208";a="30887504"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 00:51:23 -0700
X-CSE-ConnectionGUID: 30hHIcXNSUmw7qzlz4ZQVA==
X-CSE-MsgGUID: xSgTbuEESnmRjCuXRRVcgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,232,1716274800"; 
   d="scan'208";a="83126668"
Received: from wenwenru-mobl1.ccr.corp.intel.com (HELO [10.255.30.247]) ([10.255.30.247])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 00:51:22 -0700
Message-ID: <2912551a-b4c6-4bd4-8c1c-22de7fd8fa20@linux.intel.com>
Date: Wed, 24 Jul 2024 15:51:18 +0800
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
References: <48373ac6-574b-4f72-b4f1-ddb7de8a5107@linux.intel.com>
 <20240724063555.3819-1-zhoushengqing@ttyinfo.com>
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
In-Reply-To: <20240724063555.3819-1-zhoushengqing@ttyinfo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/24/2024 2:35 PM, Zhou Shengqing wrote:
>>> Do you mean it shoud be like this?
>>>
>>> 	while ((d = pci_get_device(PCI_VENDOR_ID_INTEL, 0x09a2, d))) {
>>> 		if (d->bus->number == dev->bus->number) {
>>> 			pci_read_config_word(d, 0x1c0, &en1k);
>>> 			if (en1k & 0x4) {
>>> 				pci_info(dev, "1K I/O windows enabled per %s EN1K setting\n", pci_name(d));
>>> 				dev->io_window_1k = 1;
>>> 			}
>>> 		}
>>> 	}
>>>
>>>> 00:00.0 System peripheral: Intel Corporation Device 09a2 (rev 20)
>>>> 00:0f.0 PCI bridge: Intel Corporation Device 1bbf (rev 10) (prog-if 00 [Normal decode])
>>>>
>>>>     
>>>> 15:00.0 System peripheral: Intel Corporation Device 09a2 (rev 20)
>>>> 15:01.0 PCI bridge: Intel Corporation Device 352a (rev 04) (prog-if 00 [Normal decode])
>>>>
>>>> and if you check domain number only, they might sit on different bus, perhaps that
>>>> would make thing complex, could you make sure the VT-d is on the upstream bus of the
>>>> bridge ?
>>> I checked it on ICX SPR EMR GNR, VT-d is always on the same bus with root port,
>>> and VT-d device and function number is always 0.
>> Yes, every VT-d instance in the root complex and the root port integrated are
>> on the same bus. and VT-d is the first device of that bus.
>>
>> The EDS doesn't say if there is exception one of the VT-d instances in an
>> system its EN1K wasn't set while others were set, vice vesa. so I suggest
>> just check the VT-d and then set the root port's io_windows_1k of the same bus.
> But as Bjorn mentioned at July 12, 2024, 6:48 p.m.,
>
> "To be safe, "d" (the [8086:09a2] device) should be on the same bus as
> "dev" (with VMD, I think we get Root Ports *below* the VMD bridge,
> which would be a different bus, and they presumably are not influenced
> by the EN1K bit."
>
> When VMD enabled, just check bus number identical may lead to enable
> 1k io windows for VMD domain root port. E.g. 0000:80:00.0 is a
> VT-d(09a2). If VMD enabled, there might be a root port 10000:80:01.0 present.
> this code may lead to enable 10000:80:01.0 io_window_1k = 1.
> This is probably not expected.
>
> If I modify it like this,
>
> 	while ((d = pci_get_device(PCI_VENDOR_ID_INTEL, 0x09a2, d))) {

BTW, don't save letters to use single letter variable 'd', please use 'vtd_dev' or
something else to express the VT-d device.

> 	---if (d->bus->number == dev->bus->number) {
> 	+++if (d->bus == dev->bus) {

What if their 'bus' are NULL, though it is almost impossible. :)

> 			pci_read_config_word(d, 0x1c0, &en1k);
> 			if (en1k & 0x4) {
> 				pci_info(dev, "1K I/O windows enabled per %s EN1K setting\n", pci_name(d));
> 				dev->io_window_1k = 1;
> 			}
> 		}
> 	}
>      
> Can the situation mentioned above be avoided?

Yes, my understanding, as Bjorn pointed out root port extended from VMD
bridge not on the same bus as VT-d.



Thanks,
Ethan

>
> Hope for your suggestion.
>
>> Hope that works for your case.
>>

