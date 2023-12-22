Return-Path: <linux-pci+bounces-1279-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DCDDE81C31F
	for <lists+linux-pci@lfdr.de>; Fri, 22 Dec 2023 03:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 687B3B22A99
	for <lists+linux-pci@lfdr.de>; Fri, 22 Dec 2023 02:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE5838D;
	Fri, 22 Dec 2023 02:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="guFxXlT1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45C0610A;
	Fri, 22 Dec 2023 02:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703212518; x=1734748518;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TRc0UGev4uFn8BTl4gPAGlPeXG+1aykIFo/Wmh5Zh8Y=;
  b=guFxXlT1BEdK9oeJ9vMjZGvXXxKAmpeEZaTfUpQvS9G8rzBCm5czAsJB
   9a14AS7yqGtclNlNdw/s6cz6qgPSrsW9pdQiDOsMP/Se4EE0C9JyDztpJ
   4j3hPQqveqTtNjqRUvdSikThEsaGj0uD2EViJLEKbPuT/SR7+eB9ce1gA
   WPpCSaxloHaBuuzmzrcZUBl5mUgn+nJuE9ftunUxY4sEODi4+Va7zilhw
   KZr1XiQoi/c8vMvaLswvv2Cn+Vc6vjSEnVQVr5fxFM70cnfpm6lD0RPiZ
   dWrsUDh6dryaPdo57zU6n6KKOeW/wIv3bcHSqX4eCvMr6ny2npt1TS/zQ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="375551828"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="375551828"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 18:35:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="950134890"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="950134890"
Received: from zhaohaif-mobl.ccr.corp.intel.com (HELO [10.93.26.36]) ([10.93.26.36])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 18:35:14 -0800
Message-ID: <cc6f7c1a-13f0-475a-9961-e22e73b13a32@linux.intel.com>
Date: Fri, 22 Dec 2023 10:35:12 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] PCI: make pci_dev_is_disconnected() helper public for
 other drivers
To: Lukas Wunner <lukas@wunner.de>
Cc: bhelgaas@google.com, baolu.lu@linux.intel.com, dwmw2@infradead.org,
 will@kernel.org, robin.murphy@arm.com, linux-pci@vger.kernel.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 Haorong Ye <yehaorong@bytedance.com>
References: <20231213034637.2603013-1-haifeng.zhao@linux.intel.com>
 <20231213034637.2603013-2-haifeng.zhao@linux.intel.com>
 <20231213104930.GB31964@wunner.de>
 <31bd82b6-6f7e-4dc4-8cbb-46fa806d699f@linux.intel.com>
 <20231221105124.GC12714@wunner.de>
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
In-Reply-To: <20231221105124.GC12714@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 12/21/2023 6:51 PM, Lukas Wunner wrote:
> On Thu, Dec 14, 2023 at 08:58:49AM +0800, Ethan Zhao wrote:
>> On 12/13/2023 6:49 PM, Lukas Wunner wrote:
>>> On Tue, Dec 12, 2023 at 10:46:36PM -0500, Ethan Zhao wrote:
>>>> move pci_dev_is_disconnected() from driver/pci/pci.h to public
>>>> include/linux/pci.h for other driver's reference.
>>>> no function change.
>>> That's merely a prose description of the code.  A reader can already
>>> see from the code what it's doing.  You need to explain the *reason*
>>> for the change instead.  E.g.:  "Make pci_dev_is_disconnected() public
>>> so that it can be called from $DRIVER to speed up hot removal
>>> handling which may otherwise take seconds because of $REASONS."
>> Yup, why I made it public. then how about
>>
>> "Make pci_dev_is_disconnected() public so that it can be called from
>> Intel vt-d driver to check the device's hotplug removal state when
>> issue devTLB flush request."
> Much better.
>
> You may optionally want to point out the location of the file in the
> source tree because not everyone may be familiar where to find the
> "Intel vt-d driver".  Also, not every reader may know where issuing
> of devTLB flush requests occurs, so it might make sense to name the
> function where that happens.  Finally, it is common to adhere to terms
> used in the PCIe Base Spec in commit messages, so "ATC Invalidate Request"
> might be preferable to "devTLB flush request".

ATS Invalidate Request ? devTLB flush request has the same meaning,

I thought all iommu/PCIe guys could understand.


Thanks,

Ethan

>
> Thanks,
>
> Lukas

