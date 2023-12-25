Return-Path: <linux-pci+bounces-1372-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E41C881DF54
	for <lists+linux-pci@lfdr.de>; Mon, 25 Dec 2023 09:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13A661C217BD
	for <lists+linux-pci@lfdr.de>; Mon, 25 Dec 2023 08:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A69161C2E;
	Mon, 25 Dec 2023 08:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QJpNCfuq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A664A3D74;
	Mon, 25 Dec 2023 08:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703494657; x=1735030657;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4sWfpwqIqIKMzSSqACx6Lv3JJINe2WMVJr4cfeM7640=;
  b=QJpNCfuqLEI0FbG4DHn4dCpwpHVBV8m/5Kk013bAubhzcHIYCzd6LEbY
   IY30N8C4e0PaFNILXepZdly8W4G6xxN65JWNs9Arq+C5cuA8Y6s0v8dWl
   5++sUnV9Wb3iPHYRkgLQjpsJ5Su6wJc33a/eRMmgtjlmrD5Rv5+N9+B4F
   1HyVI5uZ5s0qwzGPa3RgTyXRB6I2VYCfge3E9JJDvZN/7aYzMbvxMk9eg
   ItjST1n1nELtILQTg8NzCMdM+a09s4+s8vgL2w9gffNhr4QpjbhXBI2sF
   e09Of5OdY5MoQ/lCpLg/S2pNZzyiq0T5yPcfCnVHwTwF22QVvzUEaboJR
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="396009000"
X-IronPort-AV: E=Sophos;i="6.04,302,1695711600"; 
   d="scan'208";a="396009000"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2023 00:57:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="753897451"
X-IronPort-AV: E=Sophos;i="6.04,302,1695711600"; 
   d="scan'208";a="753897451"
Received: from zhaohaif-mobl.ccr.corp.intel.com (HELO [10.93.26.36]) ([10.93.26.36])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2023 00:57:33 -0800
Message-ID: <7650e7ef-0e84-4673-98b0-64682487e01a@linux.intel.com>
Date: Mon, 25 Dec 2023 16:57:31 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v6 4/4] iommu/vt-d: break out devTLB invalidation if
 target device is gone
To: Lukas Wunner <lukas@wunner.de>
Cc: bhelgaas@google.com, baolu.lu@linux.intel.com, dwmw2@infradead.org,
 will@kernel.org, robin.murphy@arm.com, linux-pci@vger.kernel.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20231224050657.182022-1-haifeng.zhao@linux.intel.com>
 <20231224050657.182022-5-haifeng.zhao@linux.intel.com>
 <20231224104709.GB31197@wunner.de>
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
In-Reply-To: <20231224104709.GB31197@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 12/24/2023 6:47 PM, Lukas Wunner wrote:
> On Sun, Dec 24, 2023 at 12:06:57AM -0500, Ethan Zhao wrote:
>> --- a/drivers/iommu/intel/dmar.c
>> +++ b/drivers/iommu/intel/dmar.c
>> @@ -1423,6 +1423,13 @@ int qi_submit_sync(struct intel_iommu *iommu, struct qi_desc *desc,
>>   	writel(qi->free_head << shift, iommu->reg + DMAR_IQT_REG);
>>   
>>   	while (qi->desc_status[wait_index] != QI_DONE) {
>> +		/*
>> +		 * if the devTLB invalidation target device is gone, don't wait
>> +		 * anymore, it might take up to 1min+50%, causes system hang.
>> +		 */
>> +		if (type == QI_DIOTLB_TYPE && iommu->flush_target_dev)
>> +			if (!pci_device_is_present(to_pci_dev(iommu->flush_target_dev)))
>> +				break;
> As a general approach, this is much better now.
>
> Please combine the nested if-clauses into one.
>
> Please amend the code comment with a spec reference, i.e.
> "(see Implementation Note in PCIe r6.1 sec 10.3.1)"
> so that readers of the code know where the magic number "1min+50%"
> is coming from.
>
> Is flush_target_dev guaranteed to always be a pci_dev?
>
> I'll let iommu maintainers comment on whether storing a flush_target_dev
> pointer is the right approach.  (May store a back pointer from
> struct intel_iommu to struct device_domain_info?)
>
> Maybe move the "to_pci_dev(iommu->flush_target_dev)" lookup outside the
> loop to avoid doing this over and over again?
>
> I think we still have a problem here if the device is not removed
> but simply takes a long time to respond to Invalidate Requests
> (as it is permitted to do per the Implementation Note).  We'll

If the hardware implenmentation didn't extend the PCIe spec, that

is possible and horrible case for current synchromous queue model

for ATS invalidation. but to wipe the concern and quote info not public

here, perhaps not proper for me.


Thanks,

Ethan

> busy-wait for the completion and potentially run into the watchdog's
> time limit again.  So I think you or someone else in your org should
> add OKRs to refactor the code so that it sleeps in-between polling
> for Invalidate Completions (instead of busy-waiting with interrupts
> disabled).
>
> Thanks,
>
> Lukas
>

