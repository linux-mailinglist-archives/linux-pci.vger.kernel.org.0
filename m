Return-Path: <linux-pci+bounces-2728-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C58D8408E5
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 15:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B14D31F21BC4
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 14:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1530B152DE8;
	Mon, 29 Jan 2024 14:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NARfMgzI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82335152DE0;
	Mon, 29 Jan 2024 14:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706539746; cv=none; b=OSdXkklJh4h2UCa78psL4QVqYASvFy8C17EkSi2rKaAo5ocnP3Th5HjGL/0bXsoc51+/wuCkEEvaJyEIeTM61hZ9BMGhAZtwfUvs/8LeS2SCis/N6B4YzdLBavYHBwCBxgUzR1TGamr7UC+Dks8TF9GCKzSaQvRVzk34WYnvm6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706539746; c=relaxed/simple;
	bh=B+Q7J9j4jl1343Xufi5xIgruTezV/90wo8FCib5ZR9U=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cnRop6YX+Gn2f+D3P8Jv9Xh9naa3RzORNi3RdQ17emi5k6tArnxu6sjtZFERhAQeeLTRxsC1KlMc7GAP2bext0aG64PbuhBTPZywXVWf/9mrP5j0JQ6Ni/fcjB5wUO+KJvzAZxoak6sC81FboSr0MvZ5YGUGnHBRM3ZAgLg+27E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NARfMgzI; arc=none smtp.client-ip=192.55.52.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706539743; x=1738075743;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=B+Q7J9j4jl1343Xufi5xIgruTezV/90wo8FCib5ZR9U=;
  b=NARfMgzI18WTFMR551Rxnos7Bp5cFdzf/QnyUxiCCmpnc4okQPWIMLFZ
   pjb1vHE7Gt/fl/i6wgkspX1G3bGdEkoPGEbhU/fmgaaVZ436PMrsrgKYn
   gXsW5cBZRasot6oGuREfX0hNjlFGw2Br12BFx5u46NfXUv5jhGaBczCDE
   rTOijaXPCFk9HKtK99r5mGBjLrjCTe7Z7sKgu3ISRXf9JIRkvm3iYW24k
   1Kn7PBFuSqV/pZR+Eu3bsdoOcrb/bAeV6SRLzBXkFaKF38gwRLMEbYx/o
   ZDnenzYfnAYGacaQjcq06Dm/so7r/1ve6ip0LDDPHd6CabP8BBIq5ll6x
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="402609503"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="402609503"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 06:49:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="960907268"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="960907268"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.249.174.51]) ([10.249.174.51])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 06:48:58 -0800
Message-ID: <46e0c704-cc77-4d23-9503-0d6d5d07bb26@linux.intel.com>
Date: Mon, 29 Jan 2024 22:48:56 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, "dwmw2@infradead.org" <dwmw2@infradead.org>,
 "will@kernel.org" <will@kernel.org>, "lukas@wunner.de" <lukas@wunner.de>,
 "Liu, Yi L" <yi.l.liu@intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v12 5/5] iommu/vt-d: improve ITE fault handling if target
 device isn't present
To: "Tian, Kevin" <kevin.tian@intel.com>,
 Ethan Zhao <haifeng.zhao@linux.intel.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>
References: <20240129034924.817005-1-haifeng.zhao@linux.intel.com>
 <20240129034924.817005-6-haifeng.zhao@linux.intel.com>
 <BN9PR11MB52761CC3E5F08D4B7BAD7F918C7E2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52761CC3E5F08D4B7BAD7F918C7E2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/1/29 17:06, Tian, Kevin wrote:
>> From: Ethan Zhao<haifeng.zhao@linux.intel.com>
>> Sent: Monday, January 29, 2024 11:49 AM
>>
>> Because surprise removal could happen anytime, e.g. user could request safe
>> removal to EP(endpoint device) via sysfs and brings its link down to do
>> surprise removal cocurrently. such aggressive cases would cause ATS
>> invalidation request issued to non-existence target device, then deadly
>> loop to retry that request after ITE fault triggered in interrupt context.
>> this patch aims to optimize the ITE handling by checking the target device
>> presence state to avoid retrying the timeout request blindly, thus avoid
>> hard lockup or system hang.
>>
>> Signed-off-by: Ethan Zhao<haifeng.zhao@linux.intel.com>
>> ---
>>   drivers/iommu/intel/dmar.c | 18 ++++++++++++++++++
>>   1 file changed, 18 insertions(+)
>>
>> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
>> index 814134e9aa5a..2e214b43725c 100644
>> --- a/drivers/iommu/intel/dmar.c
>> +++ b/drivers/iommu/intel/dmar.c
>> @@ -1272,6 +1272,7 @@ static int qi_check_fault(struct intel_iommu
>> *iommu, int index, int wait_index,
>>   {
>>   	u32 fault;
>>   	int head, tail;
>> +	u64 iqe_err, ite_sid;
>>   	struct q_inval *qi = iommu->qi;
>>   	int shift = qi_shift(iommu);
>>
>> @@ -1316,6 +1317,13 @@ static int qi_check_fault(struct intel_iommu
>> *iommu, int index, int wait_index,
>>   		tail = readl(iommu->reg + DMAR_IQT_REG);
>>   		tail = ((tail >> shift) - 1 + QI_LENGTH) % QI_LENGTH;
>>
>> +		/*
>> +		 * SID field is valid only when the ITE field is Set in FSTS_REG
>> +		 * see Intel VT-d spec r4.1, section 11.4.9.9
>> +		 */
>> +		iqe_err = dmar_readq(iommu->reg + DMAR_IQER_REG);
>> +		ite_sid = DMAR_IQER_REG_ITESID(iqe_err);
>> +
>>   		writel(DMA_FSTS_ITE, iommu->reg + DMAR_FSTS_REG);
>>   		pr_info("Invalidation Time-out Error (ITE) cleared\n");
>>
>> @@ -1325,6 +1333,16 @@ static int qi_check_fault(struct intel_iommu
>> *iommu, int index, int wait_index,
>>   			head = (head - 2 + QI_LENGTH) % QI_LENGTH;
>>   		} while (head != tail);
>>
>> +		/*
>> +		 * If got ITE, we need to check if the sid of ITE is the same as
>> +		 * current ATS invalidation target device, if yes, don't try this
>> +		 * request anymore if the target device isn't present.
>> +		 * 0 value of ite_sid means old VT-d device, no ite_sid value.
>> +		 */
>> +		if (pdev && ite_sid && !pci_device_is_present(pdev) &&
>> +			ite_sid == pci_dev_id(pci_physfn(pdev)))
>> +			return -ETIMEDOUT;
>> +
> since the hardware already reports source id leading to timeout, can't we
> just find the pci_dev according to reported ite_sid? this is a slow path (either
> due to device in bad state or removed) hence it's not necessary to add more
> intelligence to pass the pci_dev in, leading to only a partial fix can be backported.
> 
> It's also more future-proof, say if one day the driver allows batching invalidation
> requests for multiple devices then no need to pass in a list of devices.

I have ever thought about this solution and gave up in the end due to
the locking issue.

A batch of qi requests must be handled in the spin lock critical region
to enforce that only one batch of requests is submitted at a time.
Searching pci_dev in this locking region might result in nested locking
issues, and I haven't found a good solution for this yet.

Unless someone can bring up a better solution, perhaps we have to live
in a world where only single device TLB invalidation request in a batch
could be submitted to the queue.

Best regards,
baolu

