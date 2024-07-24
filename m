Return-Path: <linux-pci+bounces-10701-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC31E93AC49
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 07:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55A8A284BA2
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 05:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542CA4317C;
	Wed, 24 Jul 2024 05:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ddT/BjAv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBD14CDEC;
	Wed, 24 Jul 2024 05:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721799600; cv=none; b=TfxfrFefBWjtfhNUT2xp18R7Hu+ltoaCR1P5XO8kzSTZrfAWvy16pXrMruKfe3MzQQwQHGu5yGy05wFruHxMUeQgp3+wSDBGj3agme3FW2r8xXogrpNhRkstx4M+0C1SfUMJpBbSVeRoVBQgM/CFY8iIVnXq9dCuas7DlW3W4tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721799600; c=relaxed/simple;
	bh=vgv/sVuDrseMUP/pyCPPjNCD18JQT/rUZ2CaLlZU5tM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TpHdnVPAdiH4PDoTjK2ldg/Nl4sJq1zvPkWKcUjV+T2TPoITvRqhkg9BEAZXYOEDzVTP0Iuzg2o0EIGPJOE2yfNcgJNjv4mUEEfGU21fPuuv59/8exyAZEEe7srUkmwYe6kSvpLsk1BhUTc6qW1ksz6OcncP3dbleehxRBPuEYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ddT/BjAv; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721799599; x=1753335599;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vgv/sVuDrseMUP/pyCPPjNCD18JQT/rUZ2CaLlZU5tM=;
  b=ddT/BjAvUZpsfO2NwujRTYxJHKcTw+NtpYK9Wl/cSfmyLGiSx0WIUuf4
   liW4gzQ1fEI7y4mt54RfFWrePFmrf9heE39XViqNkOtLzM0IW4xTAs3td
   A3n7+W5hOex3LTTI3FGq5Z+IU7UfW7r/ROeVYeyrpeZ6cgohkrgRY6YzN
   dGEXfPNiRwr3xN//05sWbepjyyyfFZMteIqov/CwMGO3a2z+AQAJ+4huL
   9MTaucH6B6vSYP0e4EtC/bRUWlK6x7hvYHEIre+WYWZyRBtPML4xL6s2+
   uSZ/c7RGY6DcqFzEXQWYTVh1/AJyhBjVygqniCwPX804FQ06nW0jDESYm
   g==;
X-CSE-ConnectionGUID: WAjFaOvmRPqtITvr+d3STg==
X-CSE-MsgGUID: DxBPaiUmQfOPwQwE6YYVEg==
X-IronPort-AV: E=McAfee;i="6700,10204,11142"; a="30118102"
X-IronPort-AV: E=Sophos;i="6.09,232,1716274800"; 
   d="scan'208";a="30118102"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2024 22:39:58 -0700
X-CSE-ConnectionGUID: ncONMvkLQDyBLaGSnoYQxA==
X-CSE-MsgGUID: x8TCFx/SQ5mhehx6BHXj0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,232,1716274800"; 
   d="scan'208";a="56622781"
Received: from zhaohaif-mobl.ccr.corp.intel.com (HELO [10.124.9.238]) ([10.124.9.238])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2024 22:39:54 -0700
Message-ID: <48373ac6-574b-4f72-b4f1-ddb7de8a5107@linux.intel.com>
Date: Wed, 24 Jul 2024 13:39:45 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] Subject: PCI: Enable io space 1k granularity for intel
 cpu root port
To: Zhou Shengqing <zhoushengqing@ttyinfo.com>
Cc: helgaas@kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, lkp@intel.com, llvm@lists.linux.dev,
 oe-kbuild-all@lists.linux.dev
References: <e5c1990b-8c40-4376-bd9f-3701bf4eab91@linux.intel.com>
 <20240724033829.4724-1-zhoushengqing@ttyinfo.com>
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
In-Reply-To: <20240724033829.4724-1-zhoushengqing@ttyinfo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/24/2024 11:38 AM, Zhou Shengqing wrote:
>> On 7/23/2024 4:04 PM, Zhou Shengqing wrote:
>>>> I think this has potential.  Can you include a more complete citation
>>>> for the Intel spec?  Complete name, document number if available,
>>>> revision, section?  Hopefully it's publically available?
>>> Most of intel CPU EDS specs are under NDA. But you can refer to
>>> https://www.intel.com/content/dam/www/public/us/en/documents/datasheets/xeon-e5-v2-datasheet-vol-2.pdf
>>> keyword:"EN1K".
>>> ...
>>>
>>> 	while ((d = pci_get_device(PCI_VENDOR_ID_INTEL, 0x09a2, d))) {
>>> 		if (pci_domain_nr(d->bus) == pci_domain_nr(dev->bus)) {
>> Perhaps it is enough to check if the 0x09a2 VT-d and the rootport are on the smae bus
>> e.g. On my SPR, domain 0000
> Thank you for your comment.
>
> Do you mean it shoud be like this?
>
> 	while ((d = pci_get_device(PCI_VENDOR_ID_INTEL, 0x09a2, d))) {
> 		if (d->bus->number == dev->bus->number) {
> 			pci_read_config_word(d, 0x1c0, &en1k);
> 			if (en1k & 0x4) {
> 				pci_info(dev, "1K I/O windows enabled per %s EN1K setting\n", pci_name(d));
> 				dev->io_window_1k = 1;
> 			}
> 		}
> 	}
>
>> 00:00.0 System peripheral: Intel Corporation Device 09a2 (rev 20)
>> 00:0f.0 PCI bridge: Intel Corporation Device 1bbf (rev 10) (prog-if 00 [Normal decode])
>>
>>    
>> 15:00.0 System peripheral: Intel Corporation Device 09a2 (rev 20)
>> 15:01.0 PCI bridge: Intel Corporation Device 352a (rev 04) (prog-if 00 [Normal decode])
>>
>> and if you check domain number only, they might sit on different bus, perhaps that
>> would make thing complex, could you make sure the VT-d is on the upstream bus of the
>> bridge ?
> I checked it on ICX SPR EMR GNR, VT-d is always on the same bus with root port,
> and VT-d device and function number is always 0.

Yes, every VT-d instance in the root complex and the root port integrated are
on the same bus. and VT-d is the first device of that bus.

The EDS doesn't say if there is exception one of the VT-d instances in an
system its EN1K wasn't set while others were set, vice vesa. so I suggest
just check the VT-d and then set the root port's io_windows_1k of the same bus.

Hope that works for your case.


Thanks,
Ethan

>
> Please let me know if further modifications are needed.
>
>> Thanks,
>> Ethan

