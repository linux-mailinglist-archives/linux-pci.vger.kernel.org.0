Return-Path: <linux-pci+bounces-10711-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E31693ACEF
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 09:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 954ECB215B9
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 07:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3BA94C3D0;
	Wed, 24 Jul 2024 07:05:44 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A664C84;
	Wed, 24 Jul 2024 07:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721804744; cv=none; b=OABFNBq7Tq1C+cWXhPemTFyKk23xZvaojB0WYLAN0MRBiEYsvoyl2AkYYk2O4UuwqjILVlqAety3YT/lFwufUGeJZGtJ+PoI++pTIpYoNLwXKJfHgYN5bzWNw7qvy5v3k4zWpDBA58dD35NVYnGzIEjPuMPbq32kDS795gDbxQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721804744; c=relaxed/simple;
	bh=NJzJ+6eswf7If47jsaja4ykHVWVCTmgmSDHPCmI0mBo=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Il+wPd9UCpxTtzlJ4JiLQafGGMpGQFnv1EpVl+9tkNES4KnyR3cvcqcqXVFj3YIoEU6QsHkg+Cibc9i9kKQnPvqVBLdpDPoVBB/CFk8HZRu4J8Fd6DfPpXezeUosu51nwWKgyHfGiIezzcrBzAjjpwQOgITQWwbK64PrEvh1u3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [111.207.111.194])
	by gateway (Coremail) with SMTP id _____8BxKurBp6Bm8NkAAA--.3376S3;
	Wed, 24 Jul 2024 15:05:37 +0800 (CST)
Received: from [10.180.13.176] (unknown [111.207.111.194])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8Cx78e8p6BmhexWAA--.61518S3;
	Wed, 24 Jul 2024 15:05:34 +0800 (CST)
Subject: Re: [PATCH v3] PCI: pci_call_probe: call local_pci_probe() when
 selected cpu is offline
To: Ethan Zhao <haifeng.zhao@linux.intel.com>,
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
 <db628499-6faf-43c8-93e5-c24208ca0578@linux.intel.com>
From: Hongchen Zhang <zhanghongchen@loongson.cn>
Message-ID: <ea5a5c52-69ca-9504-dd80-a90c3000d9c6@loongson.cn>
Date: Wed, 24 Jul 2024 15:05:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <db628499-6faf-43c8-93e5-c24208ca0578@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8Cx78e8p6BmhexWAA--.61518S3
X-CM-SenderInfo: x2kd0w5krqwupkhqwqxorr0wxvrqhubq/1tbiAQAIB2agXhkDYAABst
X-Coremail-Antispam: 1Uk129KBj93XoWxWry7CFWrXr4ktFyDury8Zwc_yoWruw4UpF
	ykJFyUJrWkXr18J342qw1UZry0gw1DJa4UXw17JF15JFWqyr1Iqr47Xrn0gr1DJr4kJr1U
	Aw1UJrW7uFyUAFbCm3ZEXasCq-sJn29KB7ZKAUJUUUUf529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	AVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWx
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4SoGDU
	UUU

On 2024/7/24 下午2:40, Ethan Zhao wrote:
> On 7/24/2024 11:09 AM, Hongchen Zhang wrote:
>> Hi Ethan,
>>
>> On 2024/7/24 上午10:47, Ethan Zhao wrote:
>>> On 7/24/2024 9:58 AM, Hongchen Zhang wrote:
>>>> Hi Ethan,
>>>> On 2024/7/22 PM 3:39, Ethan Zhao wrote:
>>>>>
>>>>> On 6/13/2024 3:42 PM, Hongchen Zhang wrote:
>>>>>> Call work_on_cpu(cpu, fn, arg) in pci_call_probe() while the argument
>>>>>> @cpu is a offline cpu would cause system stuck forever.
>>>>>>
>>>>>> This can be happen if a node is online while all its CPUs are
>>>>>> offline (We can use "maxcpus=1" without "nr_cpus=1" to reproduce it).
>>>>>>
>>>>>> So, in the above case, let pci_call_probe() call local_pci_probe()
>>>>>> instead of work_on_cpu() when the best selected cpu is offline.
>>>>>>
>>>>>> Fixes: 69a18b18699b ("PCI: Restrict probe functions to 
>>>>>> housekeeping CPUs")
>>>>>> Cc: <stable@vger.kernel.org>
>>>>>> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
>>>>>> Signed-off-by: Hongchen Zhang <zhanghongchen@loongson.cn>
>>>>>> ---
>>>>>> v2 -> v3: Modify commit message according to Markus's suggestion
>>>>>> v1 -> v2: Add a method to reproduce the problem
>>>>>> ---
>>>>>>   drivers/pci/pci-driver.c | 2 +-
>>>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
>>>>>> index af2996d0d17f..32a99828e6a3 100644
>>>>>> --- a/drivers/pci/pci-driver.c
>>>>>> +++ b/drivers/pci/pci-driver.c
>>>>>> @@ -386,7 +386,7 @@ static int pci_call_probe(struct pci_driver 
>>>>>> *drv, struct pci_dev *dev,
>>>>>>           free_cpumask_var(wq_domain_mask);
>>>>>>       }
>>>>>> -    if (cpu < nr_cpu_ids)
>>>>>
>>>>> Why not choose the right cpu to callwork_on_cpu() ? the one that is 
>>>>> online. Thanks, Ethan
>>>> Yes, let housekeeping_cpumask() return online cpu is a good idea, 
>>>> but it may be changed by command line. so the simplest way is to 
>>>> call local_pci_probe when the best selected cpu is offline.
>>>
>>> Hmm..... housekeeping_cpumask() should never return offline CPU, so
>>> I guess you didn't hit issue with the CPU isolation, but the following
>>> code seems not good.
>> The issue is the dev node is online but the best selected cpu is 
>> offline, so it seems that there is no better way to directly set the 
>> cpu to nr_cpu_ids.
> 
> I mean where the bug is ? you should debug more about that.
> just add one cpu_online(cpu) check there might suggest there
> is bug in the cpu selection stage.
> 
> 
> if (node < 0 || node >= MAX_NUMNODES || !node_online(node) ||
>          pci_physfn_is_probed(dev)) {
>          cpu = nr_cpu_ids; // <----- if you hit here, then 
> local_pci_probe() should be called.
>      } else {
>          cpumask_var_t wq_domain_mask;
> 
>          if (!zalloc_cpumask_var(&wq_domain_mask, GFP_KERNEL)) {
>              error = -ENOMEM;
>              goto out;
>          }
>          cpumask_and(wq_domain_mask,
>                  housekeeping_cpumask(HK_TYPE_WQ),
>                  housekeeping_cpumask(HK_TYPE_DOMAIN));
> 
>          cpu = cpumask_any_and(cpumask_of_node(node),
>                        wq_domain_mask);
>          free_cpumask_var(wq_domain_mask);
>                  // <----- if you hit here, then work_on_cpu(cpu, 
> local_pci_probe, &ddi) should be called.
Yes, but if the offline cpu is selected, local_pci_probe should be called.
>                  // do you mean there one offline cpu is selected ?
Yes, the offline cpu is selected.
> 
>      }
> 
>      if (cpu < nr_cpu_ids)
>          error = work_on_cpu(cpu, local_pci_probe, &ddi);
>      else
>          error = local_pci_probe(&ddi);
> 
> 
> Thanks,
> Ethan
> 
>>>
>>> ...
>>>
>>> if (node < 0 || node >= MAX_NUMNODES || !node_online(node) ||
>>>          pci_physfn_is_probed(dev)) {
>>>          cpu = nr_cpu_ids;
>>>      } else {
>>>
>>> ....
>>>
>>> perhaps you could change the logic there and fix it  ?
>>>
>>> Thanks
>>> Ethan
>>>
>>>
>>>
>>>>>
>>>>>> +    if ((cpu < nr_cpu_ids) && cpu_online(cpu))
>>>>>>           error = work_on_cpu(cpu, local_pci_probe, &ddi);
>>>>>>       else
>>>>>>           error = local_pci_probe(&ddi);
>>>>
>>>>
>>
>>


-- 
Best Regards
Hongchen Zhang


