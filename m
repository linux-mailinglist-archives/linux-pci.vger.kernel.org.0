Return-Path: <linux-pci+bounces-10690-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39BA593AB5D
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 04:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 313E61C22827
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 02:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745041757E;
	Wed, 24 Jul 2024 02:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jfMWalNR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55EDADF5B;
	Wed, 24 Jul 2024 02:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721789242; cv=none; b=uba2UTbmlQ25er+66Vyn/2BP+UowTuQNKs/CbQ88kYhJs8ag/HgHw6yavXuqdTWWicl/IotptU8q659rmpvzAmdZNkYV2jqq9soqb2r51eat3DsZielEhkKTCy+DWHsUTz15LUDX5fFSHzg3UPcpoyO4P3TaQ1fjNpIcE9Znifc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721789242; c=relaxed/simple;
	bh=9Vz8MYQsrGkJZnEnokzhHArRg9sVUnAdHQO+HCp4GWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LLDtDIebfTx0X3UwVQ62pgOiZePkppe/5ozASHSZewMMYjhd+4s8w4jKLMjlfWRxfYqpZKQthDBGttoHhZwLPBnWSKJwD3qXl7O4pcq19hh25e+eDbT5txawAyZN3qNXEBdc416c9ycy+KRcNlKuggU4htRkb5A+K7o7B4ObF/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jfMWalNR; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721789241; x=1753325241;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9Vz8MYQsrGkJZnEnokzhHArRg9sVUnAdHQO+HCp4GWg=;
  b=jfMWalNRkjbdfcqA5ceWoE/Y4fvxSvirkIAEqsF2L77JM78+flbcNc6x
   3DshM8xDJTWbwV4w9zo0NH9Q4rDXpK5h6rVj+iTmVu+H5Ei+9b3oo3ghD
   qAa17e9Y89VifEa9xf/6w7H4Zkcv5Pp/RZQpzn1nnbFXjLnVI1iYoHF5c
   Aqf1kIctP3lELEL1PvrJ40qoAphb0jrIdOlCJlT5jrxa2j+2IHxQ2yIZW
   J+NvL2LklLlJDwmxgzE8FjLR5redJf3hbg33XvFO8zx6GCb6QiiEoEAkw
   2WzrbS2H0BFPfWyLjTcBUGbFM/4tRfuKH4VTLCFVY0JUeUgKhvidwMux+
   g==;
X-CSE-ConnectionGUID: LsCh948sS0uuL6sJh27m5A==
X-CSE-MsgGUID: ailozAeeQYGnzlUEJmnziA==
X-IronPort-AV: E=McAfee;i="6700,10204,11142"; a="30592152"
X-IronPort-AV: E=Sophos;i="6.09,232,1716274800"; 
   d="scan'208";a="30592152"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2024 19:47:10 -0700
X-CSE-ConnectionGUID: elHXUOmYSXKPqUR/bd+ZGQ==
X-CSE-MsgGUID: AgyOkfmzQLipPoeZZYO+XA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,232,1716274800"; 
   d="scan'208";a="57551471"
Received: from zhaohaif-mobl.ccr.corp.intel.com (HELO [10.124.9.238]) ([10.124.9.238])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2024 19:47:06 -0700
Message-ID: <670927f1-42d8-40bc-bd79-55e178bd907a@linux.intel.com>
Date: Wed, 24 Jul 2024 10:47:04 +0800
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
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
In-Reply-To: <7340a27e-67c1-c0c3-9304-77710dc44f7f@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/24/2024 9:58 AM, Hongchen Zhang wrote:
> Hi Ethan,
> On 2024/7/22 PM 3:39, Ethan Zhao wrote:
>>
>> On 6/13/2024 3:42 PM, Hongchen Zhang wrote:
>>> Call work_on_cpu(cpu, fn, arg) in pci_call_probe() while the argument
>>> @cpu is a offline cpu would cause system stuck forever.
>>>
>>> This can be happen if a node is online while all its CPUs are
>>> offline (We can use "maxcpus=1" without "nr_cpus=1" to reproduce it).
>>>
>>> So, in the above case, let pci_call_probe() call local_pci_probe()
>>> instead of work_on_cpu() when the best selected cpu is offline.
>>>
>>> Fixes: 69a18b18699b ("PCI: Restrict probe functions to housekeeping 
>>> CPUs")
>>> Cc: <stable@vger.kernel.org>
>>> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
>>> Signed-off-by: Hongchen Zhang <zhanghongchen@loongson.cn>
>>> ---
>>> v2 -> v3: Modify commit message according to Markus's suggestion
>>> v1 -> v2: Add a method to reproduce the problem
>>> ---
>>>   drivers/pci/pci-driver.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
>>> index af2996d0d17f..32a99828e6a3 100644
>>> --- a/drivers/pci/pci-driver.c
>>> +++ b/drivers/pci/pci-driver.c
>>> @@ -386,7 +386,7 @@ static int pci_call_probe(struct pci_driver 
>>> *drv, struct pci_dev *dev,
>>>           free_cpumask_var(wq_domain_mask);
>>>       }
>>> -    if (cpu < nr_cpu_ids)
>>
>> Why not choose the right cpu to callwork_on_cpu() ? the one that is 
>> online. Thanks, Ethan
> Yes, let housekeeping_cpumask() return online cpu is a good idea, but 
> it may be changed by command line. so the simplest way is to call 
> local_pci_probe when the best selected cpu is offline.

Hmm..... housekeeping_cpumask() should never return offline CPU, so
I guess you didn't hit issue with the CPU isolation, but the following
code seems not good.

...

if (node < 0 || node >= MAX_NUMNODES || !node_online(node) ||
         pci_physfn_is_probed(dev)) {
         cpu = nr_cpu_ids;
     } else {

....

perhaps you could change the logic there and fix it  ?

Thanks
Ethan



>>
>>> +    if ((cpu < nr_cpu_ids) && cpu_online(cpu))
>>>           error = work_on_cpu(cpu, local_pci_probe, &ddi);
>>>       else
>>>           error = local_pci_probe(&ddi);
>
>

