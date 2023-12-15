Return-Path: <linux-pci+bounces-1033-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2467F813F74
	for <lists+linux-pci@lfdr.de>; Fri, 15 Dec 2023 02:51:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B063F1F2296D
	for <lists+linux-pci@lfdr.de>; Fri, 15 Dec 2023 01:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD180650;
	Fri, 15 Dec 2023 01:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MDmlLjKQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EBC1FD6;
	Fri, 15 Dec 2023 01:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702605077; x=1734141077;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=B8ZnBuUqYeF5LUId9bwYmxo/DbwCwkj6wYLDz93eA1o=;
  b=MDmlLjKQ0meym/7/2vDxz0Bbr0+7jdfJuW1emL6uyu1BlNnGa4px4Z5R
   ADSJQ3/efJWc9DUUZxzesmDYSlYl+E4elnL/XbNlgXmi3Y9K+WJ26xdSI
   vfFTcY4jLCE76ELKfumsi1UIJGXdM8FNkz+uFMmg/OZRKOIbi0d4Eeu26
   enGbHnQzE6nPP3/00xOcc3LSnIZQLPpH0Tp6C4B2ztFfY6fwnUC3thT5n
   8aWvsfQyhM28l6srD654jfAXsSmV6JEd97lDDGwPTFsgXVhL1BobSvblD
   CMnmxXUY2p1Wz++z4yh/fgHlxh0w0SXwXVxSyQNtIjv+PUKAdcxOG0c5M
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="394088293"
X-IronPort-AV: E=Sophos;i="6.04,277,1695711600"; 
   d="scan'208";a="394088293"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 17:51:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="844948298"
X-IronPort-AV: E=Sophos;i="6.04,277,1695711600"; 
   d="scan'208";a="844948298"
Received: from zhaohaif-mobl.ccr.corp.intel.com (HELO [10.255.30.96]) ([10.255.30.96])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 17:51:13 -0800
Message-ID: <a121f7ee-6993-4784-a199-e747643d441a@linux.intel.com>
Date: Fri, 15 Dec 2023 09:51:10 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iommu/vt-d: don's issue devTLB flush request when
 device is disconnected
To: Baolu Lu <baolu.lu@linux.intel.com>, bhelgaas@google.com,
 dwmw2@infradead.org, will@kernel.org, robin.murphy@arm.com
Cc: linux-pci@vger.kernel.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, Haorong Ye <yehaorong@bytedance.com>
References: <20231213034637.2603013-1-haifeng.zhao@linux.intel.com>
 <20231213034637.2603013-3-haifeng.zhao@linux.intel.com>
 <96051115-c928-4f3c-bd65-4f3f8e83ca9c@linux.intel.com>
 <e6fddbb0-fa8f-43d4-8a5e-d177e9465912@linux.intel.com>
 <8c8a1e49-5447-4d61-b3ba-782873cc0f4a@linux.intel.com>
 <2f49219e-601d-4ddc-a7b7-6ea8968a2f80@linux.intel.com>
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
In-Reply-To: <2f49219e-601d-4ddc-a7b7-6ea8968a2f80@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 12/15/2023 9:34 AM, Baolu Lu wrote:
> On 2023/12/15 9:03, Ethan Zhao wrote:
>>
>> 2. supprise_removal
>>
>>   Users remove the devece directly or bring the device link down/turn 
>> off
>>
>>   device power first by setting pci config space, link-down/not-present/
>>
>>   power-off are all handled by pciehp the same way 
>> "supprise_removal", in
>>
>>   such case, pciehp_ist() will flag the device as "disconnected" 
>> first, then
>>
>>   unconfig the devcie, unload driver, iommu release device(issing 
>> devTLB flush)
>>
>>   delete device. so we checking the device state could work such cases.
>
> If so, then it is fine for the iommu driver. As Robin said, if the
> device needs more cleanup, the iommu core should register a right
> callback to the driver core and handle it before the device goes away.
>
> Disabling PCI features seems to be a reasonable device cleanup. This
> gives us another reason to move ATS enabling/disabling out from the

For supprise_removal, device was already removed, powered-off, iommu

device-release got notification  or cleanup callback is  invoked to disable

ATS to not-present device etc ,

I didn't get the meaning to do so, perhaps I misunderstand ?

Thanks,

Ethan

> iommu subsystem. Once this is done, the device driver will enable ATS
> during its probe and disable it during its release. There will be no
> such workaround in the iommu driver anymore.
>
> Best regards,
> baolu

