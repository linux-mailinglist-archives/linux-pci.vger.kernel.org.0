Return-Path: <linux-pci+bounces-8099-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1EE8D541D
	for <lists+linux-pci@lfdr.de>; Thu, 30 May 2024 23:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D0F91C23C87
	for <lists+linux-pci@lfdr.de>; Thu, 30 May 2024 21:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4AC41760;
	Thu, 30 May 2024 21:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kcDeTuqF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22831C6A7;
	Thu, 30 May 2024 21:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717102993; cv=none; b=izRxq3h26OVIr4H73XiiaMt8W885Fkx4ylE1qWVUGKqfUZMF83uSE8N4cWr8UZeQcCPTiXypqm9hy8QMtaDQmFKRRuA2Fy77X18wTyPkj0nsEHlWjAsO0SBstFbIdGqXME18LtPJLOF8C/RUzOLup5+MBV8bo18g45lWZjGqzsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717102993; c=relaxed/simple;
	bh=19zh76u230Mu8yohZ9kIFKmEc1j536fZT0TrevZEzsE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nRoPRTLPQEgm0MFJK45y6ooBXjlk/Zw7t6ymGuQ7NaXVf0JG0docFUytAzTAeqjl/eO0/zlcVBME4WWk7GM9ypsCwiIhLmYE/VbQcUh8qOiRNIphky0v2suFqY5IeDrglkcdvtruWsv1zbD+DLOqmz9KXxT8HCd7bjRhCusYy3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kcDeTuqF; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717102992; x=1748638992;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=19zh76u230Mu8yohZ9kIFKmEc1j536fZT0TrevZEzsE=;
  b=kcDeTuqFsZ4uJv/Dpw3bTLmPAMboPIJTqttfBv8Uiyo9Ner+AM5IN4bb
   YTptyPmp0nx0GO2jLsYPjjhme2eoiasKDDR3YLD7xbi+r98OyysQCpTAT
   2QELOJrQxJgn1jfoYPM5LfF4oOT9+FfXQhCgpVSEBYpjWN/a51gnMwtUm
   RC0ErfkXvzHFha6pyRUOSEhy5pNkYAzzd6B5h+b0DtOltJOib1hjuhlwB
   SGEYKFZXyi3BaCBmpWPXV9D7zYXyKIa44GAVfsyYxqbXU2VFVkSorfkUi
   1YP58JP5jP5UsCLZ4d8SOd/iMLpAH16Vt4CKksCt8ujc6EAAb1/tuvRus
   g==;
X-CSE-ConnectionGUID: x05f2pPLSiWrXFNAPc6LPA==
X-CSE-MsgGUID: K+2ISTajTHSihb7peT5fKA==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="25028309"
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="25028309"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 14:03:11 -0700
X-CSE-ConnectionGUID: 0cxBozVWQY+F/xR/p4ANCw==
X-CSE-MsgGUID: v8Ex3IH9Q2WwGosZSQgC3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="67139447"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.125.111.201]) ([10.125.111.201])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 14:03:10 -0700
Message-ID: <4f8387ec-47f5-4c03-bb39-7a2a398a85f9@intel.com>
Date: Thu, 30 May 2024 14:03:09 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: Revert / replace the cfg_access_lock lockdep
 mechanism
To: Bjorn Helgaas <helgaas@kernel.org>,
 Dan Williams <dan.j.williams@intel.com>
Cc: bhelgaas@google.com, Imre Deak <imre.deak@intel.com>,
 Jani Saarinen <jani.saarinen@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20240530205245.GA560944@bhelgaas>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240530205245.GA560944@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/30/24 1:52 PM, Bjorn Helgaas wrote:
> On Thu, May 30, 2024 at 12:53:46PM -0700, Dan Williams wrote:
>> Dan Williams wrote:
>>> While the experiment did reveal that there are additional places that
>>> are missing the lock during secondary bus reset, one of the places that
>>> needs to take cfg_access_lock (pci_bus_lock()) is not prepared for
>>> lockdep annotation.
>>>
>>> Specifically, pci_bus_lock() takes pci_dev_lock() recursively and is
>>> currently dependent on the fact that the device_lock() is marked
>>> lockdep_set_novalidate_class(&dev->mutex). Otherwise, without that
>>> annotation, pci_bus_lock() would need to use something like a new
>>> pci_dev_lock_nested() helper, a scheme to track a PCI device's depth in
>>> the topology, and a hope that the depth of a PCI tree never exceeds the
>>> max value for a lockdep subclass.
>>>
>>> The alternative to ripping out the lockdep coverage would be to deploy a
>>> dynamic lock key for every PCI device. Unfortunately, there is evidence
>>> that increasing the number of keys that lockdep needs to track to be
>>> per-PCI-device is prohibitively expensive for something like the
>>> cfg_access_lock.
>>>
>>> The main motivation for adding the annotation in the first place was to
>>> catch unlocked secondary bus resets, not necessarily catch lock ordering
>>> problems between cfg_access_lock and other locks.
>>>
>>> Replace the lockdep tracking with a pci_warn_once() for that primary
>>> concern.
>>>
>>> Fixes: 7e89efc6e9e4 ("PCI: Lock upstream bridge for pci_reset_function()")
>>> Reported-by: Imre Deak <imre.deak@intel.com>
>>> Closes: https://intel-gfx-ci.01.org/tree/drm-tip/Patchwork_134186v1/shard-dg2-1/igt@device_reset@unbind-reset-rebind.html
>>> Cc: Jani Saarinen <jani.saarinen@intel.com>
>>> Cc: Dave Jiang <dave.jiang@intel.com>
>>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>>
>> Bjorn, this against mainline, not your tree where I see you already have
>> "PCI: Make cfg_access_lock lockdep key a singleton" queued up. The
>> "overkill" justification for making it singleton is valid, but then
>> means that it has all the same problems as the device lock that needs to
>> be marked lockdep_set_novalidate_class().
>>
>> Let me know if you want this rebased on your for-linus branch.
>>
>> Note that the pci_warn_once() will trigger on all pci_bus_reset() users
>> unless / until pci_bus_lock() additionally locks the bridge itself ala:
>>
>> http://lore.kernel.org/r/6657833b3b5ae_14984b29437@dwillia2-xfh.jf.intel.com.notmuch
>>
>> Apologies for the thrash, this has been a useful exercise for finding
>> some of these gaps, but ultimately not possible to carry forward
>> without more invasive changes.
> 
> No problem, this is a complicated locking scenario.  These fixes are
> the only thing on my for-linus branch (which I regard as a draft
> rather than being immutable) and I haven't asked Linus to pull them
> yet, so I'll just drop both:
> 
>   ac445566fcf9 ("PCI: Make cfg_access_lock lockdep key a singleton")
>   f941b9182c54 ("PCI: Fix missing lockdep annotation for pci_cfg_access_trylock()")
> 
> I think the clearest way to do this would be to do a simple revert of
> 7e89efc6e9e4, followed by a second patch to add the pci_warn_once().

Complete revert of 7e89efc6e9e4 will also remove the bridge locking which I think we want to keep right?
> 
> The revert would definitely be v6.10 material.  The pci_warn_once()
> might be v6.11 material.  Or if you think it will find significant
> bugs, maybe that's v6.10 material as well, but it'll be easier to make
> that argument if it's in a separate patch.
> 
> Bjorn

