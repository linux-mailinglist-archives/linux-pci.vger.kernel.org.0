Return-Path: <linux-pci+bounces-8101-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF9B68D5495
	for <lists+linux-pci@lfdr.de>; Thu, 30 May 2024 23:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6650F1C21A70
	for <lists+linux-pci@lfdr.de>; Thu, 30 May 2024 21:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3AD014D422;
	Thu, 30 May 2024 21:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SZb6JxrH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B520F4D8CF;
	Thu, 30 May 2024 21:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717104385; cv=none; b=LBnYZOBeltN4Y1O7n3cykkQ5viAQFZoi4RtlcE8Ju/6RvIjxTjcDHcLVWuulVF5z/aj7rm+/6yM7eUwe0QtQKLO81yDV3Pr/lSNFqpBxOt1BHdZjUKLEvr4VSsqW58bs2U3FWBc65yUaw2vXE2sQAstjEQJpPn6QgRvFS/EXI4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717104385; c=relaxed/simple;
	bh=S8Gx4dx6wpolppq7M6u8f+6LMw1fjDjq2x1saO7FuxI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xm2ILCtoQ/1O01nAnD567ApmW3XxsxYbB5lx9QiMKPIWYBJQBHwzK3zOecK08tEepz9wvu4DNQApkw7ZnBI5fhVKjptN8SG2hecmuHc+dU5NbQY55gRo4th843XXynPpXLLiRA9YUYNOZxDhmG+qTQVqZg4dteUvY0PEeP2FgOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SZb6JxrH; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717104385; x=1748640385;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=S8Gx4dx6wpolppq7M6u8f+6LMw1fjDjq2x1saO7FuxI=;
  b=SZb6JxrH8scdL8qA/pFa9wE6YYS09IQRVv3WZnYqlMh6RfVAlugQGL9A
   3PMCP0g6iKDQ8m45vd5aMslOuJWKyO8KFvR+MrPE3eDythlDGFhdh/Bvh
   HL25ApBw68Z1fA5evliNO1bcSsMpmxf6ftufBQIG9bj6Mu0TBiJgwRhRC
   3CU2kfSV9lzj84XLdpnFH/N3UtDhGiIyqf4ngxE0o2xJIrHzyWUnouwBr
   XIsWN1og/9booVWyj7Kruyp7E1ZnYRzHozPz0zpVUPPZ2o5yH1lDrOhDC
   4e2XNQWNk2IjjYEmEPs+6oiX+zrtV7d9UOx9VfhWETahu8o7loP9scrxT
   g==;
X-CSE-ConnectionGUID: ntwXuX/tTvWeQrkR4PDqVA==
X-CSE-MsgGUID: xL3qdyS/R3SVwcAYqvxl8A==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="17457750"
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="17457750"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 14:26:24 -0700
X-CSE-ConnectionGUID: CpRKavTbRcWorin1hocuug==
X-CSE-MsgGUID: dP+I7IDGSr2F+ZacfmXCOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="73440193"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.125.111.201]) ([10.125.111.201])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 14:26:22 -0700
Message-ID: <2d7edaf0-10f6-4afb-8f7c-15b04805e5f2@intel.com>
Date: Thu, 30 May 2024 14:26:21 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: Revert / replace the cfg_access_lock lockdep
 mechanism
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>, bhelgaas@google.com,
 Imre Deak <imre.deak@intel.com>, Jani Saarinen <jani.saarinen@intel.com>,
 linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
References: <20240530210822.GA562010@bhelgaas>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240530210822.GA562010@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/30/24 2:08 PM, Bjorn Helgaas wrote:
> On Thu, May 30, 2024 at 02:03:09PM -0700, Dave Jiang wrote:
>> On 5/30/24 1:52 PM, Bjorn Helgaas wrote:
>>> On Thu, May 30, 2024 at 12:53:46PM -0700, Dan Williams wrote:
>>>> Dan Williams wrote:
>>>>> While the experiment did reveal that there are additional places that
>>>>> are missing the lock during secondary bus reset, one of the places that
>>>>> needs to take cfg_access_lock (pci_bus_lock()) is not prepared for
>>>>> lockdep annotation.
>>>>>
>>>>> Specifically, pci_bus_lock() takes pci_dev_lock() recursively and is
>>>>> currently dependent on the fact that the device_lock() is marked
>>>>> lockdep_set_novalidate_class(&dev->mutex). Otherwise, without that
>>>>> annotation, pci_bus_lock() would need to use something like a new
>>>>> pci_dev_lock_nested() helper, a scheme to track a PCI device's depth in
>>>>> the topology, and a hope that the depth of a PCI tree never exceeds the
>>>>> max value for a lockdep subclass.
>>>>>
>>>>> The alternative to ripping out the lockdep coverage would be to deploy a
>>>>> dynamic lock key for every PCI device. Unfortunately, there is evidence
>>>>> that increasing the number of keys that lockdep needs to track to be
>>>>> per-PCI-device is prohibitively expensive for something like the
>>>>> cfg_access_lock.
>>>>>
>>>>> The main motivation for adding the annotation in the first place was to
>>>>> catch unlocked secondary bus resets, not necessarily catch lock ordering
>>>>> problems between cfg_access_lock and other locks.
>>>>>
>>>>> Replace the lockdep tracking with a pci_warn_once() for that primary
>>>>> concern.
>>>>>
>>>>> Fixes: 7e89efc6e9e4 ("PCI: Lock upstream bridge for pci_reset_function()")
>>>>> Reported-by: Imre Deak <imre.deak@intel.com>
>>>>> Closes: https://intel-gfx-ci.01.org/tree/drm-tip/Patchwork_134186v1/shard-dg2-1/igt@device_reset@unbind-reset-rebind.html
>>>>> Cc: Jani Saarinen <jani.saarinen@intel.com>
>>>>> Cc: Dave Jiang <dave.jiang@intel.com>
>>>>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>>>>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>>>>
>>>> Bjorn, this against mainline, not your tree where I see you already have
>>>> "PCI: Make cfg_access_lock lockdep key a singleton" queued up. The
>>>> "overkill" justification for making it singleton is valid, but then
>>>> means that it has all the same problems as the device lock that needs to
>>>> be marked lockdep_set_novalidate_class().
>>>>
>>>> Let me know if you want this rebased on your for-linus branch.
>>>>
>>>> Note that the pci_warn_once() will trigger on all pci_bus_reset() users
>>>> unless / until pci_bus_lock() additionally locks the bridge itself ala:
>>>>
>>>> http://lore.kernel.org/r/6657833b3b5ae_14984b29437@dwillia2-xfh.jf.intel.com.notmuch
>>>>
>>>> Apologies for the thrash, this has been a useful exercise for finding
>>>> some of these gaps, but ultimately not possible to carry forward
>>>> without more invasive changes.
>>>
>>> No problem, this is a complicated locking scenario.  These fixes are
>>> the only thing on my for-linus branch (which I regard as a draft
>>> rather than being immutable) and I haven't asked Linus to pull them
>>> yet, so I'll just drop both:
>>>
>>>   ac445566fcf9 ("PCI: Make cfg_access_lock lockdep key a singleton")
>>>   f941b9182c54 ("PCI: Fix missing lockdep annotation for pci_cfg_access_trylock()")
>>>
>>> I think the clearest way to do this would be to do a simple revert of
>>> 7e89efc6e9e4, followed by a second patch to add the pci_warn_once().
>>
>> Complete revert of 7e89efc6e9e4 will also remove the bridge locking
>> which I think we want to keep right?
> 
> I dunno, you tell me.  If we want to revert just part of 7e89efc6e9e4,
> it would be clearer to do that by itself, then add the new stuff
> separately.

Unless Dan objects I think we should do a partial revert and only remove the lockdep bits.
> 
>>> The revert would definitely be v6.10 material.  The pci_warn_once()
>>> might be v6.11 material.  Or if you think it will find significant
>>> bugs, maybe that's v6.10 material as well, but it'll be easier to make
>>> that argument if it's in a separate patch.
>>>
>>> Bjorn

