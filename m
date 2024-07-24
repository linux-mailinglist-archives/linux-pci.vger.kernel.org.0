Return-Path: <linux-pci+bounces-10691-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED9B93AB7C
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 05:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A83861C22198
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 03:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D1B1B949;
	Wed, 24 Jul 2024 03:09:47 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9A617C6A;
	Wed, 24 Jul 2024 03:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721790586; cv=none; b=SLs+n7aImVSox9CDWRhqo9UfUnWfWVtR2RiCZSW+U3CY1jY5iJn5FRVBGeGBnc9QdPCzyHZmxAKD2V7sAWp90hfZFgNV9BcFlkyh4JmQKBPoTVEcy9sV1nA+nxEQx498/ruZD7839k1b+gmTUxU16zCtPv9DoL587QYPi0txWUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721790586; c=relaxed/simple;
	bh=iejYuhQ7ihB+2p5G+zGLpQZERLYpGXKaKTpSbspHU0k=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=SMURiyXPvgObHmOBgX7u/7HXuNO6Rsuv7cfs9OQdCSTRnpPbiQes1eq/7+4Ytl7F7HVeYMZHzmxVSSrqtnc1dPltl5ndwAIhtAFC2jZPy38JiBx+jDjNyGuVGmZoi9PLjFySZ0uuwOZghpKu+m7oV1ExcqXivMQ+IlNXwIj0BwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [111.207.111.194])
	by gateway (Coremail) with SMTP id _____8BxKup0cKBmSswAAA--.3168S3;
	Wed, 24 Jul 2024 11:09:40 +0800 (CST)
Received: from [10.180.13.176] (unknown [111.207.111.194])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8Bx28ZycKBmELBWAA--.60972S3;
	Wed, 24 Jul 2024 11:09:39 +0800 (CST)
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
From: Hongchen Zhang <zhanghongchen@loongson.cn>
Message-ID: <0052b62b-aafe-e2eb-6d66-4ad0178bdae1@loongson.cn>
Date: Wed, 24 Jul 2024 11:09:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <670927f1-42d8-40bc-bd79-55e178bd907a@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8Bx28ZycKBmELBWAA--.60972S3
X-CM-SenderInfo: x2kd0w5krqwupkhqwqxorr0wxvrqhubq/1tbiAQAIB2agXhkBmAABsX
X-Coremail-Antispam: 1Uk129KBj93XoWxur17ur1fCw1kurWxXr1fAFc_yoW5XF1fpF
	WkJay5CrWvqr18Ga42qF1UZFyFvw1DJa4xWw1xJ3W5ZFZrAF1IqF47Xrn0gryUGrWkZr10
	y3WUXry7uFWUAFbCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r12
	6r1DMcIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
	1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxG
	rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUtVW8ZwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jFApnUUU
	UU=

Hi Ethan,

On 2024/7/24 上午10:47, Ethan Zhao wrote:
> On 7/24/2024 9:58 AM, Hongchen Zhang wrote:
>> Hi Ethan,
>> On 2024/7/22 PM 3:39, Ethan Zhao wrote:
>>>
>>> On 6/13/2024 3:42 PM, Hongchen Zhang wrote:
>>>> Call work_on_cpu(cpu, fn, arg) in pci_call_probe() while the argument
>>>> @cpu is a offline cpu would cause system stuck forever.
>>>>
>>>> This can be happen if a node is online while all its CPUs are
>>>> offline (We can use "maxcpus=1" without "nr_cpus=1" to reproduce it).
>>>>
>>>> So, in the above case, let pci_call_probe() call local_pci_probe()
>>>> instead of work_on_cpu() when the best selected cpu is offline.
>>>>
>>>> Fixes: 69a18b18699b ("PCI: Restrict probe functions to housekeeping 
>>>> CPUs")
>>>> Cc: <stable@vger.kernel.org>
>>>> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
>>>> Signed-off-by: Hongchen Zhang <zhanghongchen@loongson.cn>
>>>> ---
>>>> v2 -> v3: Modify commit message according to Markus's suggestion
>>>> v1 -> v2: Add a method to reproduce the problem
>>>> ---
>>>>   drivers/pci/pci-driver.c | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
>>>> index af2996d0d17f..32a99828e6a3 100644
>>>> --- a/drivers/pci/pci-driver.c
>>>> +++ b/drivers/pci/pci-driver.c
>>>> @@ -386,7 +386,7 @@ static int pci_call_probe(struct pci_driver 
>>>> *drv, struct pci_dev *dev,
>>>>           free_cpumask_var(wq_domain_mask);
>>>>       }
>>>> -    if (cpu < nr_cpu_ids)
>>>
>>> Why not choose the right cpu to callwork_on_cpu() ? the one that is 
>>> online. Thanks, Ethan
>> Yes, let housekeeping_cpumask() return online cpu is a good idea, but 
>> it may be changed by command line. so the simplest way is to call 
>> local_pci_probe when the best selected cpu is offline.
> 
> Hmm..... housekeeping_cpumask() should never return offline CPU, so
> I guess you didn't hit issue with the CPU isolation, but the following
> code seems not good.
The issue is the dev node is online but the best selected cpu is 
offline, so it seems that there is no better way to directly set the cpu 
to nr_cpu_ids.
> 
> ...
> 
> if (node < 0 || node >= MAX_NUMNODES || !node_online(node) ||
>          pci_physfn_is_probed(dev)) {
>          cpu = nr_cpu_ids;
>      } else {
> 
> ....
> 
> perhaps you could change the logic there and fix it  ?
> 
> Thanks
> Ethan
> 
> 
> 
>>>
>>>> +    if ((cpu < nr_cpu_ids) && cpu_online(cpu))
>>>>           error = work_on_cpu(cpu, local_pci_probe, &ddi);
>>>>       else
>>>>           error = local_pci_probe(&ddi);
>>
>>


-- 
Best Regards
Hongchen Zhang


