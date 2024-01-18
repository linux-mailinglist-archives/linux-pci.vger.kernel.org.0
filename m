Return-Path: <linux-pci+bounces-2307-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA1F83116E
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jan 2024 03:32:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BDC01C21D7A
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jan 2024 02:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAAC528EC;
	Thu, 18 Jan 2024 02:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hPpofyRm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79ED3566D;
	Thu, 18 Jan 2024 02:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705545152; cv=none; b=qQwlEB5pOuQtC0ABLncCTq+E37QbqJAEh9K1mHxHFQZ+nqzPTb+Tms0ZO0f5dH9xBj4oMiMUvJs/k6pXAoBHZRBbHBKgV8iQRp5KUkQn4TZC11CJn+sED/84CKR7c9o+mJ1lYQhMD6YwKwNkWsU/Bp6H1JCovluwXfzFzyXssiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705545152; c=relaxed/simple;
	bh=rZUgRK/6bWCbmtxrq6/nPe4yEvZHLPc6MjZDysW0tkE=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:X-IronPort-AV:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:From:To:Cc:References:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=hu1lhbFdgXBddTSrDzVeT00qm7gFml73RTsNluglg3EFdvl6YN09f3viT1yhuCItLq3psMJe2QGgn5A8FbkP3DINl7TxZnUzI89QkzT++eG4I5UA4/bLNZDiUUxqCAbnPfs7UGOxGsU5k/2clGj0X1BcxNSurDGuGmKeZdku9aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hPpofyRm; arc=none smtp.client-ip=134.134.136.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705545151; x=1737081151;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=rZUgRK/6bWCbmtxrq6/nPe4yEvZHLPc6MjZDysW0tkE=;
  b=hPpofyRmxHCrQnpU01ON8tKaiNIDueaQGHJjar6HVBgLLiBpU3ny/nsw
   kmj7CSrMdHFCaI15TjGDZP3PSyBA9HCW1nT7lxjvlfY+jw7Nf2PrWi8Zk
   MyjgNQgusdgBzuVQtcAQtyQYwolvDqiJ3qYp+yKfwsp1EyoalvLh7C007
   faa3WUB1lHsSqU8FUeGH3w7YRxiChr5xTsRk5JVu5OOFG3LjuUGZ/qLq7
   Bu5kSYPHZSYPN/br/28BFyhlmJsm9z377FWp3/WvcHSMT15P7gtvB3Bhl
   n/Cw4w2T+5W9FIGF27C4NCNF1cXpWOvbaG2YxT0u9f0YKG4nS+6LaBgFe
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="404096617"
X-IronPort-AV: E=Sophos;i="6.05,201,1701158400"; 
   d="scan'208";a="404096617"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2024 18:32:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="854865851"
X-IronPort-AV: E=Sophos;i="6.05,201,1701158400"; 
   d="scan'208";a="854865851"
Received: from zhaohaif-mobl.ccr.corp.intel.com (HELO [10.254.215.192]) ([10.254.215.192])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2024 18:32:23 -0800
Message-ID: <f6e57309-be5a-4a84-a280-6ed00a550548@linux.intel.com>
Date: Thu, 18 Jan 2024 10:32:20 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v10 0/5] fix vt-d hard lockup when hotplug ATS capable
 device
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, kevin.tian@intel.com,
 bhelgaas@google.com, dwmw2@infradead.org, will@kernel.org,
 robin.murphy@arm.com, lukas@wunner.de
Cc: linux-pci@vger.kernel.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20231228170206.720675-1-haifeng.zhao@linux.intel.com>
 <1a2a4069-c737-4a3c-a2f6-cce06823331b@linux.intel.com>
 <3ee904e9-8a93-4bd9-8df7-6294885589e4@linux.intel.com>
 <42f7848a-0262-4871-b5dc-0e87beebfd11@linux.intel.com>
 <dcd27bc8-5eca-41ae-bb86-fd8e657ccfed@linux.intel.com>
 <d72d0a12-f3a4-4b4d-8b3b-5e59937a21d3@linux.intel.com>
 <5a9c38ec-1dc2-40d3-99eb-02b87be660a6@linux.intel.com>
 <9cc2010f-269c-4d23-b284-6fe4162f8810@linux.intel.com>
In-Reply-To: <9cc2010f-269c-4d23-b284-6fe4162f8810@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 1/18/2024 10:26 AM, Ethan Zhao wrote:
>
> On 1/18/2024 8:46 AM, Baolu Lu wrote:
>> On 1/17/24 5:00 PM, Ethan Zhao wrote:
>>> +       /*
>>> +        * If the ATS invalidation target device is gone this moment 
>>> (surprise
>>> +        * removed, died, no response) don't try this request again. 
>>> this
>>> +        * request will not get valid result anymore. but the 
>>> request was
>>> +        * already submitted to hardware and we predict to get a ITE in
>>> +        * followed batch of request, if so, it will get handled then.
>>> +        */
>>> +       if (target_pdev && !pci_device_is_present(target_pdev))
>>> +               return -EINVAL;
>>
>> Again, we should not ignore the error triggered by the current request.
>> Do not leave it to the next one. The WAIT descriptor is a fence. Handle
>> everything within its boundary.
>
>  We didn't set fence bit to every ATS invalidation wait descriptor,
>
> only the intel_drain_pasid_prq() queue a drain page requests with FN
>
> sit, but that is not called in hotplug removal path.

So, in fact so far, it doesn't act as a fence except the 
intel_drain_pasid_prq() ,

and it never handle everthing within its border.


Thanks,

Ethan

>
>
> Thanks,
>
> Ethan
>
>
>
>>
>> Best regards,
>> baolu
>

