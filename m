Return-Path: <linux-pci+bounces-10709-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 536E793ACBD
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 08:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7B0A1F215A3
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 06:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DFC817C67;
	Wed, 24 Jul 2024 06:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aLCk4Y33"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6C346B91;
	Wed, 24 Jul 2024 06:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721803267; cv=none; b=boBN0SZsxZMtQ+OiH2VTd7dNge341dWSBJceZsgBrsgtCbwitHyxE70VLp8BKqGtQnMApO/WEcqYw4QuYPVilNrcZvvX3Kg1vzRgCi4zto2cTLgLuXKgut7Uf9W7p8HFqHaTLLDE1xGYAwGW3SsHoUs5K8aY/1C/fWaq8N47AFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721803267; c=relaxed/simple;
	bh=x0vOYeXeNX/sHfD9cAYNNJaVPjQFSeiii2czopLm0ho=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SnMF4fqG57RYRGy+D9k8Z8xjqaiPEsD5PvsheKfKjsy/YgZ9TQkUpu8+dYpOJiWueGefSojCUDBnyDEhnf4oLIthDE7JlphVHxqYVs4J8Wmv4tq7YL5pvlQSknvJDeprDE7udBezZ63gzCOQE2QV6Xa50fMUQHmvRZ72T8dFLsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aLCk4Y33; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721803265; x=1753339265;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=x0vOYeXeNX/sHfD9cAYNNJaVPjQFSeiii2czopLm0ho=;
  b=aLCk4Y33LroLW5COoZ7sPYyIP09ZiwAsjMYx8d4AoQzrSVMK6VL6enwW
   h3Dnc8WkyTr4teulsESg3jl6vRg+8eV3ephfgmjG716fVh8MbG6rV8vVe
   2QqG6VcvoGeP+GdJ7L2LPZEgUw+XhciHKfhUmbyTcY+SjZtg/18aKIfn0
   Fj//REClZILCrsXDCRmV0USTjHo6arxmYmRTKauz/c2gmEZ3RGDoz8PVp
   9OwvZ3h1QqXX3IZCds/b8OQEIgLTmbqoWT+U6+HstPLOMrqWOv2Th2U3C
   9GZ0IqgY8kLAIT8LXFoEoRNu/7TEsLIr3Y+IeImij79TFcgMNhH6Pp0h6
   A==;
X-CSE-ConnectionGUID: ARqp8582S+KLx9FRyu23bg==
X-CSE-MsgGUID: QtHKWT6BTdOuojhFqXlMXA==
X-IronPort-AV: E=McAfee;i="6700,10204,11142"; a="19608702"
X-IronPort-AV: E=Sophos;i="6.09,232,1716274800"; 
   d="scan'208";a="19608702"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2024 23:41:03 -0700
X-CSE-ConnectionGUID: 6sZo2mh6Thi8omSxy5kUFQ==
X-CSE-MsgGUID: ilJjkpEYTNGqVKU+ks5eIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,232,1716274800"; 
   d="scan'208";a="52168604"
Received: from zhaohaif-mobl.ccr.corp.intel.com (HELO [10.125.241.20]) ([10.125.241.20])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2024 23:40:59 -0700
Message-ID: <db628499-6faf-43c8-93e5-c24208ca0578@linux.intel.com>
Date: Wed, 24 Jul 2024 14:40:57 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] PCI: pci_call_probe: call local_pci_probe() when
 selected cpu is offline
To: Hongchen Zhang <zhanghongchen@loongson.cn>,
 Markus Elfring <Markus.Elfring@web.de>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Alex Belits <abelits@marvell.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Nitesh Narayan Lal <nitesh@redhat.com>,
 Frederic Weisbecker <frederic@kernel.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 stable@vger.kernel.org, Huacai Chen <chenhuacai@loongson.cn>
References: <20240613074258.4124603-1-zhanghongchen@loongson.cn>
 <a50b3865-8a04-4a9a-8d27-b317619a75c0@linux.intel.com>
 <7340a27e-67c1-c0c3-9304-77710dc44f7f@loongson.cn>
 <670927f1-42d8-40bc-bd79-55e178bd907a@linux.intel.com>
 <0052b62b-aafe-e2eb-6d66-4ad0178bdae1@loongson.cn>
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
In-Reply-To: <0052b62b-aafe-e2eb-6d66-4ad0178bdae1@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/24/2024 11:09 AM, Hongchen Zhang wrote:
> Hi Ethan,
>
> On 2024/7/24 上午10:47, Ethan Zhao wrote:
>> On 7/24/2024 9:58 AM, Hongchen Zhang wrote:
>>> Hi Ethan,
>>> On 2024/7/22 PM 3:39, Ethan Zhao wrote:
>>>>
>>>> On 6/13/2024 3:42 PM, Hongchen Zhang wrote:
>>>>> Call work_on_cpu(cpu, fn, arg) in pci_call_probe() while the argument
>>>>> @cpu is a offline cpu would cause system stuck forever.
>>>>>
>>>>> This can be happen if a node is online while all its CPUs are
>>>>> offline (We can use "maxcpus=1" without "nr_cpus=1" to reproduce it).
>>>>>
>>>>> So, in the above case, let pci_call_probe() call local_pci_probe()
>>>>> instead of work_on_cpu() when the best selected cpu is offline.
>>>>>
>>>>> Fixes: 69a18b18699b ("PCI: Restrict probe functions to 
>>>>> housekeeping CPUs")
>>>>> Cc: <stable@vger.kernel.org>
>>>>> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
>>>>> Signed-off-by: Hongchen Zhang <zhanghongchen@loongson.cn>
>>>>> ---
>>>>> v2 -> v3: Modify commit message according to Markus's suggestion
>>>>> v1 -> v2: Add a method to reproduce the problem
>>>>> ---
>>>>>   drivers/pci/pci-driver.c | 2 +-
>>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
>>>>> index af2996d0d17f..32a99828e6a3 100644
>>>>> --- a/drivers/pci/pci-driver.c
>>>>> +++ b/drivers/pci/pci-driver.c
>>>>> @@ -386,7 +386,7 @@ static int pci_call_probe(struct pci_driver 
>>>>> *drv, struct pci_dev *dev,
>>>>>           free_cpumask_var(wq_domain_mask);
>>>>>       }
>>>>> -    if (cpu < nr_cpu_ids)
>>>>
>>>> Why not choose the right cpu to callwork_on_cpu() ? the one that is 
>>>> online. Thanks, Ethan
>>> Yes, let housekeeping_cpumask() return online cpu is a good idea, 
>>> but it may be changed by command line. so the simplest way is to 
>>> call local_pci_probe when the best selected cpu is offline.
>>
>> Hmm..... housekeeping_cpumask() should never return offline CPU, so
>> I guess you didn't hit issue with the CPU isolation, but the following
>> code seems not good.
> The issue is the dev node is online but the best selected cpu is 
> offline, so it seems that there is no better way to directly set the 
> cpu to nr_cpu_ids.

I mean where the bug is ? you should debug more about that.
just add one cpu_online(cpu) check there might suggest there
is bug in the cpu selection stage.


if (node < 0 || node >= MAX_NUMNODES || !node_online(node) ||
	    pci_physfn_is_probed(dev)) {
		cpu = nr_cpu_ids; // <----- if you hit here, then local_pci_probe() should be called.
             
	} else {
		cpumask_var_t wq_domain_mask;

		if (!zalloc_cpumask_var(&wq_domain_mask, GFP_KERNEL)) {
			error = -ENOMEM;
			goto out;
		}
		cpumask_and(wq_domain_mask,
			    housekeeping_cpumask(HK_TYPE_WQ),
			    housekeeping_cpumask(HK_TYPE_DOMAIN));

		cpu = cpumask_any_and(cpumask_of_node(node),
				      wq_domain_mask);
		free_cpumask_var(wq_domain_mask);
                 // <----- if you hit here, then work_on_cpu(cpu, local_pci_probe, &ddi) should be called.
                 // do you mean there one offline cpu is selected ?

	}

	if (cpu < nr_cpu_ids)
		error = work_on_cpu(cpu, local_pci_probe, &ddi);
	else
		error = local_pci_probe(&ddi);


Thanks,
Ethan

>>
>> ...
>>
>> if (node < 0 || node >= MAX_NUMNODES || !node_online(node) ||
>>          pci_physfn_is_probed(dev)) {
>>          cpu = nr_cpu_ids;
>>      } else {
>>
>> ....
>>
>> perhaps you could change the logic there and fix it  ?
>>
>> Thanks
>> Ethan
>>
>>
>>
>>>>
>>>>> +    if ((cpu < nr_cpu_ids) && cpu_online(cpu))
>>>>>           error = work_on_cpu(cpu, local_pci_probe, &ddi);
>>>>>       else
>>>>>           error = local_pci_probe(&ddi);
>>>
>>>
>
>

