Return-Path: <linux-pci+bounces-1980-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCEE0829484
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jan 2024 08:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8129E1F2793B
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jan 2024 07:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45D73A1DA;
	Wed, 10 Jan 2024 07:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R3mFbeWh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7333E470;
	Wed, 10 Jan 2024 07:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704873121; x=1736409121;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pDvYrmhpBlr6Ouka9BO91HIwFCHKwrpkfzJvRUkQeIU=;
  b=R3mFbeWhyfTUC4FatA/V4kS8eggkySaN2+0iDerTfS8nFdJNEOs59AW8
   hnaLEjkpJdTpDgR2zVaA1hICj1jIitUkixP6hzv3RWv/6UNDQhdJDYgH6
   P/i4FNdk0m8l03K5y2DSlKAt6mlphJCVBiJ780e4G2loW35W1clx47hO/
   Q0YU3YnzNerzXK9kIAI3xEPRycpwXbjMZMuQyYbolWmh9vczdVWAbnvsn
   AXFlqJ7MJUDgk2I3TldgO68iIfeWzLRupx9O0r4uQkeN8nuNcYgP21CdQ
   3Mh1ixQFhjmt9OywY0P/ZlHLqGSYBwlsFzvROvLiSl56DOAPfCyACHEDd
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="388882588"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="388882588"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2024 23:52:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="955281702"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="955281702"
Received: from zhaohaif-mobl.ccr.corp.intel.com (HELO [10.93.11.157]) ([10.93.11.157])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2024 23:51:57 -0800
Message-ID: <5de13afa-4079-467a-a7b1-badfb9ac95cc@linux.intel.com>
Date: Wed, 10 Jan 2024 15:51:53 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v10 1/5] iommu/vt-d: add pci_dev parameter to
 qi_submit_sync and refactor callers
To: Baolu Lu <baolu.lu@linux.intel.com>, kevin.tian@intel.com,
 bhelgaas@google.com, dwmw2@infradead.org, will@kernel.org,
 robin.murphy@arm.com, lukas@wunner.de
Cc: linux-pci@vger.kernel.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20231228170206.720675-1-haifeng.zhao@linux.intel.com>
 <20231228170206.720675-2-haifeng.zhao@linux.intel.com>
 <a2e507b3-a018-44d8-9e92-459670505bcd@linux.intel.com>
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
In-Reply-To: <a2e507b3-a018-44d8-9e92-459670505bcd@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 1/10/2024 12:59 PM, Baolu Lu wrote:
> On 12/29/23 1:02 AM, Ethan Zhao wrote:
>> Signed-off-by: Ethan Zhao<haifeng.zhao@linux.intel.com>
>
> Please don't leave the message body empty. You should describe why do
> you want to add the change in this patch.
Seems the description part was lost, will append next version.
>
>> ---
>>   drivers/iommu/intel/dmar.c          | 45 +++++++++++++++++++++--------
>>   drivers/iommu/intel/iommu.c         | 26 +++++------------
>>   drivers/iommu/intel/iommu.h         | 17 +++++------
>>   drivers/iommu/intel/irq_remapping.c |  2 +-
>>   drivers/iommu/intel/pasid.c         | 11 ++-----
>>   drivers/iommu/intel/svm.c           | 13 ++++-----
>>   6 files changed, 58 insertions(+), 56 deletions(-)
>>
>> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
>> index 23cb80d62a9a..3d661f2b7946 100644
>> --- a/drivers/iommu/intel/dmar.c
>> +++ b/drivers/iommu/intel/dmar.c
>> @@ -1344,7 +1344,7 @@ static int qi_check_fault(struct intel_iommu 
>> *iommu, int index, int wait_index)
>>    * can be part of the submission but it will not be polled for 
>> completion.
>>    */
>>   int qi_submit_sync(struct intel_iommu *iommu, struct qi_desc *desc,
>> -           unsigned int count, unsigned long options)
>> +           unsigned int count, unsigned long options, struct pci_dev 
>> *pdev)
>
> How about adding a bit in options parameter to tell whether the @pdev is
> valid?

well, checking the option bit or checking pdev == NULL, use one parameter

to describe another one is common function defination method if one

parameter couldn't self-describe.

This case, we always check pdev(one checking), and if we check option 
bit first, then have

to check pdev again (one or two checking).  I prefer checking pdev only.


Thanks,

Ethan

>
> Best regards,
> baolu

