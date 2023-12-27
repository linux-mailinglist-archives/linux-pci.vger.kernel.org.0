Return-Path: <linux-pci+bounces-1477-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1656B81F302
	for <lists+linux-pci@lfdr.de>; Thu, 28 Dec 2023 00:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB9511F231E0
	for <lists+linux-pci@lfdr.de>; Wed, 27 Dec 2023 23:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9BC48CF2;
	Wed, 27 Dec 2023 23:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HOXV1GnW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CA8495C1;
	Wed, 27 Dec 2023 23:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703719903; x=1735255903;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sx4ii87qo8dLRfnk777qZjzpLyvbTgoLski5VtRe4j8=;
  b=HOXV1GnWtLbd49YI8XoreJM3Ycncflawp8Ha/cO0GedA4A9ZDges5Umq
   i8CVI6d94/Klp4zuLcD4vQjcG/cbQz23w2lTRAQDvWhfQyV9sY0YBVMxY
   PFonKt+SIlghImP9LSC3YCe3gcWMU1LnrcjteAUFZV7olRgkwmcmkMrZm
   x4GNwkYTj2hH02GR2lyXFK1uo/Byz8XTCtxp208wtFzQQORnFRl9LQ3/k
   snGoonlgsV3gts05jUsc8tCHyHCGpxG8C2T3tT9+pFIdJPXGckiu8VqzI
   og5HBVAIrAI+gQmrXZXUAMhXy5AiBfJoMmtf5nu0OKAuMHfYWGSj8+PM4
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="3576035"
X-IronPort-AV: E=Sophos;i="6.04,310,1695711600"; 
   d="scan'208";a="3576035"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 15:31:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,310,1695711600"; 
   d="scan'208";a="20079157"
Received: from meijunzh-mobl.ccr.corp.intel.com (HELO [10.249.169.31]) ([10.249.169.31])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 15:31:39 -0800
Message-ID: <64c77298-dd3e-4102-a9d3-0433708d33ac@linux.intel.com>
Date: Thu, 28 Dec 2023 07:31:35 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v8 4/5] iommu/vt-d: don't issue device-TLB invalidate
 request when device is disconnected
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, baolu.lu@linux.intel.com, dwmw2@infradead.org,
 will@kernel.org, robin.murphy@arm.com, lukas@wunner.de,
 linux-pci@vger.kernel.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20231227131151.GA1499234@bhelgaas>
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
In-Reply-To: <20231227131151.GA1499234@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 12/27/2023 9:11 PM, Bjorn Helgaas wrote:
> I suggest using "ATS Invalidate Request" in the subject as well.
> Otherwise we have to figure out whether "device-TLB invalidate
> request" is the same as "ATS Invalidate Request".
>
> If they are the same, just use the same words.
>
> On Tue, Dec 26, 2023 at 09:59:22PM -0500, Ethan Zhao wrote:
>> Except those aggressive hotplug cases - surprise remove a hotplug device
>> while its safe removal is requested and handled in process by:
>>
>> 1. pull it out directly.
>> 2. turn off its power.
>> 3. bring the link down.
>> 4. just died there that moment.
>>
>> etc, in a word, 'gone' or 'disconnected'.
>>
>> Mostly are regular normal safe removal and surprise removal unplug.
>> these hot unplug handling process could be optimized for fix the ATS
>> invalidation hang issue by calling pci_dev_is_disconnected() in function
>> devtlb_invalidation_with_pasid() to check target device state to avoid
>> sending meaningless ATS invalidation request to iommu when device is gone.
>> (see IMPLEMENTATION NOTE in PCIe spec r6.1 section 10.3.1)
> Suggest "ATS Invalidate Request", capitalized exactly that way so we
> know it's a specific name of something defined in the PCIe spec.
>
>> For safe removal, device wouldn't be removed untill the whole software
>> handling process is done, it wouldn't trigger the hard lock up issue
>> caused by too long ATS invalidation timeout wait. in safe removal path,
> Ditto.
>
> Capitalize "In the safe removal ..." since it starts a new sentence.
>
>> device state isn't set to pci_channel_io_perm_failure in
>> pciehp_unconfigure_device() by checking 'presence' parameter, calling
>> pci_dev_is_disconnected() in devtlb_invalidation_with_pasid() will return
>> false there, wouldn't break the function.
>>
>> For surprise removal, device state is set to pci_channel_io_perm_failure in
>> pciehp_unconfigure_device(), means device is already gone (disconnected)
>> call pci_dev_is_disconnected() in devtlb_invalidation_with_pasid() will
>> return true to break the function not to send ATS invalidation request to
> Ditto.

Okay.


Thanks,

Ethan

>> the disconnected device blindly, thus avoid the further long time waiting
>> triggers the hard lockup.
>>
>> safe removal & surprise removal
>>
>> pciehp_ist()
>>     pciehp_handle_presence_or_link_change()
>>       pciehp_disable_slot()
>>         remove_board()
>>           pciehp_unconfigure_device(presence)

