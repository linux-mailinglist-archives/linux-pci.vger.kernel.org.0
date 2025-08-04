Return-Path: <linux-pci+bounces-33380-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ADAD0B1A710
	for <lists+linux-pci@lfdr.de>; Mon,  4 Aug 2025 18:11:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 773D218A205D
	for <lists+linux-pci@lfdr.de>; Mon,  4 Aug 2025 16:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E222521930B;
	Mon,  4 Aug 2025 16:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GNEsgGi6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81641F1527;
	Mon,  4 Aug 2025 16:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754323890; cv=none; b=kcku4PkyDAPxPTDw94qUtxgRWn5S0o6759Ogxr85PInQ1BoI+Nzb/WXT6JqFmikgaCHnSekS+NyuOz0abqPA2GAp4AZjksbGdn40fZDUV4+vDYimxTfsL3bGbpp9TUeKDuPmUWk5wAJ0qt7Wkrsw2ZHdTmu7mXrjBWjbO7dKG7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754323890; c=relaxed/simple;
	bh=bsVP24mM+9KicLDIG4oku4rVyO+CDQNpxwx4qnP3YI0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XDz5//e5v98pDmtStHIdHoBi83BaGmbMoGozKy2kvpkeCfZUtF4NsIXob24VXrhhgORSrp065tLGkaK8retzW2WmfUKtiZmCZK1Cw3N69yKiiQ3YuKzvxHuYG9T1ScPl56GNPXad0S5bVoPESNLldBd/2Td086xJhtn2jC+gV5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GNEsgGi6; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754323889; x=1785859889;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bsVP24mM+9KicLDIG4oku4rVyO+CDQNpxwx4qnP3YI0=;
  b=GNEsgGi60ZH4+BJgi24QAFY/R0rEhEHQa9AGY5mUex6/MbOavVGpIqHH
   yI/Izxw6DmkHO9q06kKHOvftSl0bPzEHBXvUJJYyEWrtVBFdGoEX4E2S8
   ZtYanLYS5otYbcdyOLIVHEiaZL6zHk9RMLnR7ThF2oURHx3/7dOGslq/g
   0XJXWK4JtgnbSrxapjxdgY8zJ8t5MLcZjw4KHqh6trrkIDt04apQlvzhN
   pIGjP61SgEgx3huMR2YrRx6X30s8t0t5z9/qYierTa43qwYyniVtUv+Su
   t4g1R3pfxZ+0IR0RiYK6UHC25BE7prDDfPLGSo3yUhtxFBpNhlbtSJWXt
   g==;
X-CSE-ConnectionGUID: 8rGY/6ofSeqOCTF44wSpVQ==
X-CSE-MsgGUID: ykJufyZaRXypeBMqOotj3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11512"; a="56737613"
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="56737613"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2025 09:11:28 -0700
X-CSE-ConnectionGUID: UyVmegG2TYWmo9DgVNn6iQ==
X-CSE-MsgGUID: evaMjvonQy+yj8egjlKZog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,258,1747724400"; 
   d="scan'208";a="164199112"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2025 09:11:28 -0700
Received: from [10.124.223.136] (unknown [10.124.223.136])
	by linux.intel.com (Postfix) with ESMTP id 87B1B20B571C;
	Mon,  4 Aug 2025 09:11:27 -0700 (PDT)
Message-ID: <48e24c23-67d4-4d09-a5f5-2a458a47e2e2@linux.intel.com>
Date: Mon, 4 Aug 2025 09:11:27 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI/AER: Check for NULL aer_info before ratelimiting in
 pci_print_aer()
To: Breno Leitao <leitao@debian.org>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Oliver O'Halloran <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Jon Pan-Doh <pandoh@google.com>, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
References: <20250804-aer_crash_2-v1-1-fd06562c18a4@debian.org>
 <9cd9f4cf-72ab-40f1-9ead-3e6807b4d474@linux.intel.com>
 <3kpkazpe4j4pws7rean5kelwmpfp5ij62psvdzvimcr37do47a@y2pvypskynno>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <3kpkazpe4j4pws7rean5kelwmpfp5ij62psvdzvimcr37do47a@y2pvypskynno>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 8/4/25 8:35 AM, Breno Leitao wrote:
> Hello Sathyanarayanan,
>
> On Mon, Aug 04, 2025 at 06:50:30AM -0700, Sathyanarayanan Kuppuswamy wrote:
>> On 8/4/25 2:17 AM, Breno Leitao wrote:
>>> Similarly to pci_dev_aer_stats_incr(), pci_print_aer() may be called
>>> when dev->aer_info is NULL. Add a NULL check before proceeding to avoid
>>> calling aer_ratelimit() with a NULL aer_info pointer, returning 1, which
>>> does not rate limit, given this is fatal.
>> Why not add it to pci_print_aer() ?
>>
>>> This prevents a kernel crash triggered by dereferencing a NULL pointer
>>> in aer_ratelimit(), ensuring safer handling of PCI devices that lack
>>> AER info. This change aligns pci_print_aer() with pci_dev_aer_stats_incr()
>>> which already performs this NULL check.
>> Is this happening during the kernel boot ? What is the frequency and steps
>> to reproduce? I am curious about why pci_print_aer() is called for a PCI device
>> without aer_info. Not aer_info means, that particular device is already released
>> or in the process of release (pci_release_dev()). Is this triggered by using a stale
>> pci_dev pointer?
> I've reported some of these investigations in here:
>
> https://lore.kernel.org/all/buduna6darbvwfg3aogl5kimyxkggu3n4romnmq6sozut6axeu@clnx7sfsy457/

It has some details. But you did not mention details like your environment, steps to
reproduce and how often you see it. I just want to understand in what scenario
pci_print_aer() is triggered, when releasing the device. I am wondering whether we
are missing proper locking some where.


-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


