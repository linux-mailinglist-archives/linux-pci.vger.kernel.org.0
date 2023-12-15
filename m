Return-Path: <linux-pci+bounces-1029-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4CD3813EF6
	for <lists+linux-pci@lfdr.de>; Fri, 15 Dec 2023 02:04:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 233BB1C21ED7
	for <lists+linux-pci@lfdr.de>; Fri, 15 Dec 2023 01:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19ACC36A;
	Fri, 15 Dec 2023 01:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BzZtDp35"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7919DEBC;
	Fri, 15 Dec 2023 01:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702602224; x=1734138224;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=CX2MH67xSTwFVAHdUyHhK6vGwtMN4v76VaShUcQZ9X4=;
  b=BzZtDp35z+ljrMpc60x+gL4iEVxQiHFyeF+R0GYJRa/AYHBPkyla61qT
   HLA7tgNJJ3pJIYXJybtp/xv29ZNrYGL/8/cyL0NKbbK7AzJ1H3ZrU81M7
   PsK8GedcAjqLteY9RJ8RSzh8AolBo81OqPTmTrMlED3hJHux3u48pvWs2
   GxRH5JhgbhncJYTXkkPkeVY5VVnIyyOVUcN8Qgs918VhvwbdzzR5NvfHa
   q/lzU6fsyIFqKyyKYCxmPy2tajEUPRhdhKSRnLC539+UU/hMP7u7KB2nQ
   h7C4ofqnmHXDcTkeHGJVo6Y0seY7VRCjId8aT49degIclSvLcBsvEOetF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="2052196"
X-IronPort-AV: E=Sophos;i="6.04,277,1695711600"; 
   d="scan'208";a="2052196"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 17:03:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,277,1695711600"; 
   d="scan'208";a="17733887"
Received: from xueyu-mobl.ccr.corp.intel.com (HELO [10.255.30.96]) ([10.255.30.96])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 17:03:40 -0800
Message-ID: <8c8a1e49-5447-4d61-b3ba-782873cc0f4a@linux.intel.com>
Date: Fri, 15 Dec 2023 09:03:37 +0800
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
To: Baolu Lu <baolu.lu@linux.intel.com>, bhelgaas@google.com,
 dwmw2@infradead.org, will@kernel.org, robin.murphy@arm.com
Cc: linux-pci@vger.kernel.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, Haorong Ye <yehaorong@bytedance.com>
References: <20231213034637.2603013-1-haifeng.zhao@linux.intel.com>
 <20231213034637.2603013-3-haifeng.zhao@linux.intel.com>
 <96051115-c928-4f3c-bd65-4f3f8e83ca9c@linux.intel.com>
 <e6fddbb0-fa8f-43d4-8a5e-d177e9465912@linux.intel.com>
In-Reply-To: <e6fddbb0-fa8f-43d4-8a5e-d177e9465912@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 12/14/2023 10:26 AM, Ethan Zhao wrote:
>
> On 12/13/2023 7:59 PM, Baolu Lu wrote:
>> On 2023/12/13 11:46, Ethan Zhao wrote:
>>> For those endpoint devices connect to system via hotplug capable ports,
>>> users could request a warm reset to the device by flapping device's 
>>> link
>>> through setting the slot's link control register, as pciehpt_ist() 
>>> DLLSC
>>> interrupt sequence response, pciehp will unload the device driver and
>>> then power it off.
>>
>> Is it possible for pciehp to disable ATS on the device before unloading
>> the driver? Or should the device follow some specific steps to warm
>> reset the device?
>>
> In this case, link down first, then pciehp_ist() got DLLSC interrupt 
> to know
>
> that, I don't think it makes sense to disable device ATS here, but it 
> could
>
> flag the device is ATS disabled, well,  "disconnected" is enough to let
>
> vt-d like software knows the device state.
>
>
For hot "unplug" cases:

1. safe_removal

   Users request unplug the device via sysfs or press the attention button,

   Then pciehp will response to unconfig device/unload device driver, power

   if off, and devcie is ready to remove. in this case, devTLB invalidate

   request is sent before device link to be brought down or device power

   to be turned off. so it doesn't trigger the hard lockup.

2. supprise_removal

  Users remove the devece directly or bring the device link down/turn off

  device power first by setting pci config space, link-down/not-present/

  power-off are all handled by pciehp the same way "supprise_removal", in

  such case, pciehp_ist() will flag the device as "disconnected" first, then

  unconfig the devcie, unload driver, iommu release device(issing devTLB 
flush)

  delete device. so we checking the device state could work such cases.

But I am still think about if there are other windows.


Thanks,

Ethan


>> What happens if IOMMU issues device TLB invalidation after link down but
>> before pci_dev_is_disconnected() returns true?
>
> Seems it wouldn't happen with hotplug cases, safe_removal or
>
> supprise_removal.
>
>
>
> Thanks,
>
> Ethan
>
>>
>> Best regards,
>> baolu

