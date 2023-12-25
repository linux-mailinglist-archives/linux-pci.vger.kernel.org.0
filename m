Return-Path: <linux-pci+bounces-1360-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBCDE81DD69
	for <lists+linux-pci@lfdr.de>; Mon, 25 Dec 2023 02:16:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EEA1281B03
	for <lists+linux-pci@lfdr.de>; Mon, 25 Dec 2023 01:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50DB63F;
	Mon, 25 Dec 2023 01:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PAEDNhqt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE23863C;
	Mon, 25 Dec 2023 01:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703466967; x=1735002967;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AN6j4b88pHInwupaFOPvPp1/+g+OaqdqdthkZu1zhwk=;
  b=PAEDNhqtpgYp4LYRFkpAXcpbBiY0Ixe4infTbY3IfZJQGnYPaugN5Da8
   7PDamm1IYA6xpfwYzlRJi9+hCNk3v4nwI5o8MbQsOPB5bCDUOqIf+7jLH
   q0SnVuTqb1xsLXoFNzw+eYhSGGQi8YYgqYF80j6zZAjdvXEcks9+FuSMt
   9WRcyKSoqdS1sbromfi0ZIMnFwDqL6xOxisf9O6HqflQUXjiyyw8ps2d4
   +4CKcHjsf/6c/6LtZL0o1waJ2tiYqpRuquCxoX982xgi4jNfJkUs/nXRp
   Uk63jPeL5jdToLRNoc0QsRV1+4gO6S9OyyyrMd82H2X/cDCcchgVmpRJD
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10934"; a="3091597"
X-IronPort-AV: E=Sophos;i="6.04,302,1695711600"; 
   d="scan'208";a="3091597"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2023 17:16:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,302,1695711600"; 
   d="scan'208";a="19668623"
Received: from zhaohaif-mobl.ccr.corp.intel.com (HELO [10.93.26.36]) ([10.93.26.36])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2023 17:16:03 -0800
Message-ID: <09b432c6-7716-4db5-a33d-23b8407955f1@linux.intel.com>
Date: Mon, 25 Dec 2023 09:16:00 +0800
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
Content-Transfer-Encoding: 8bit


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
That would be harder to read ?
> Please amend the code comment with a spec reference, i.e.
> "(see Implementation Note in PCIe r6.1 sec 10.3.1)"
> so that readers of the code know where the magic number "1min+50%"
> is coming from.
Yup.
>
> Is flush_target_dev guaranteed to always be a pci_dev?

yes, as Baolu said, only PCI and ATS capable device supports

devTLB invalidation operation, this is checked by its caller path.

>
> I'll let iommu maintainers comment on whether storing a flush_target_dev
> pointer is the right approach.  (May store a back pointer from
> struct intel_iommu to struct device_domain_info?)

One of them,  wonder which one is better, but device_domain_info

is still per device...seems no good to back it there.

>
> Maybe move the "to_pci_dev(iommu->flush_target_dev)" lookup outside the
> loop to avoid doing this over and over again?

hmm. that is a macro renam of container_of(), exactly, doesn't matter.

right ?

>
> I think we still have a problem here if the device is not removed
> but simply takes a long time to respond to Invalidate Requests
> (as it is permitted to do per the Implementation Note).  We'll
> busy-wait for the completion and potentially run into the watchdog's
> time limit again.  So I think you or someone else in your org should
> add OKRs to refactor the code so that it sleeps in-between polling

refactor code would be long story, so far still a quick fix for the issue.

and I think developers have other justifiction or conern about the

non-sync version, once again, thanks for your comment.


regards,

Ethan

> for Invalidate Completions (instead of busy-waiting with interrupts
> disabled).
>
> Thanks,
>
> Lukas

