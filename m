Return-Path: <linux-pci+bounces-10684-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03FF693AAD6
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 03:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4FE82844EE
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 01:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B04FD53C;
	Wed, 24 Jul 2024 01:58:23 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C90BA47;
	Wed, 24 Jul 2024 01:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721786303; cv=none; b=CWSxNhoyzMKY/1uGF7dL4GxKik72EXbEM/QwvckO+palZwvs5Pj0BJs7bKMUSTd/AOzIpnXXA13hXmiNe0ELV9Do0a0KvcTWhh562zo2NWh0ngfgsa8jMb8sEypB8Ba5QFrRWdSUsJQAEmK20MDkayWr6MS7zlgpbutf6gWaTjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721786303; c=relaxed/simple;
	bh=zTI/9lOgKmgqllYrdOynyvXw5CkyrdYdZJmnrTzc4vI=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=UhLfd6tUnwmjJ26D4WULqBOxf7iWV8r4/pQ8+obgLdREMvP6AFs28ehRb1qFuZS35iSu6iRKV73JWEfQUJjOQ9AfKmB7zMDGJSc2xXnQX62H2NXQQ9WaibHuWSVS92lJoK+VAmJflsTsWzppkO8ayZp9nBH0sURTnEtFwa5s0nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [111.207.111.194])
	by gateway (Coremail) with SMTP id _____8Cxruu6X6BmkMYAAA--.3159S3;
	Wed, 24 Jul 2024 09:58:18 +0800 (CST)
Received: from [10.180.13.176] (unknown [111.207.111.194])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8AxBMW4X6Bm8ppWAA--.50447S3;
	Wed, 24 Jul 2024 09:58:17 +0800 (CST)
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
From: Hongchen Zhang <zhanghongchen@loongson.cn>
Message-ID: <7340a27e-67c1-c0c3-9304-77710dc44f7f@loongson.cn>
Date: Wed, 24 Jul 2024 09:58:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <a50b3865-8a04-4a9a-8d27-b317619a75c0@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8AxBMW4X6Bm8ppWAA--.50447S3
X-CM-SenderInfo: x2kd0w5krqwupkhqwqxorr0wxvrqhubq/1tbiAQAIB2agXhkAJQABsr
X-Coremail-Antispam: 1Uk129KBj93XoW7trW3Jw4kZFW7XF18Jr17CFX_yoW8Cw4kpF
	WkJayFkrWvqF48CasFqa18uFyFgwsrJa4Ikw4xA3W5ZFW3AF1Iqr47WwnIgr1UGrWkZr1I
	y3WUXrykuFW5ZFbCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4j6r4UJwAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_
	Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrw
	CYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48J
	MxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
	IxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUcbAwUUUUU

Hi Ethan,
On 2024/7/22 PM 3:39, Ethan Zhao wrote:
> 
> On 6/13/2024 3:42 PM, Hongchen Zhang wrote:
>> Call work_on_cpu(cpu, fn, arg) in pci_call_probe() while the argument
>> @cpu is a offline cpu would cause system stuck forever.
>>
>> This can be happen if a node is online while all its CPUs are
>> offline (We can use "maxcpus=1" without "nr_cpus=1" to reproduce it).
>>
>> So, in the above case, let pci_call_probe() call local_pci_probe()
>> instead of work_on_cpu() when the best selected cpu is offline.
>>
>> Fixes: 69a18b18699b ("PCI: Restrict probe functions to housekeeping 
>> CPUs")
>> Cc: <stable@vger.kernel.org>
>> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
>> Signed-off-by: Hongchen Zhang <zhanghongchen@loongson.cn>
>> ---
>> v2 -> v3: Modify commit message according to Markus's suggestion
>> v1 -> v2: Add a method to reproduce the problem
>> ---
>>   drivers/pci/pci-driver.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
>> index af2996d0d17f..32a99828e6a3 100644
>> --- a/drivers/pci/pci-driver.c
>> +++ b/drivers/pci/pci-driver.c
>> @@ -386,7 +386,7 @@ static int pci_call_probe(struct pci_driver *drv, 
>> struct pci_dev *dev,
>>           free_cpumask_var(wq_domain_mask);
>>       }
>> -    if (cpu < nr_cpu_ids)
> 
> Why not choose the right cpu to callwork_on_cpu() ? the one that is 
> online. Thanks, Ethan
Yes, let housekeeping_cpumask() return online cpu is a good idea, but it 
may be changed by command line. so the simplest way is to call 
local_pci_probe when the best selected cpu is offline.
> 
>> +    if ((cpu < nr_cpu_ids) && cpu_online(cpu))
>>           error = work_on_cpu(cpu, local_pci_probe, &ddi);
>>       else
>>           error = local_pci_probe(&ddi);


-- 
Best Regards
Hongchen Zhang


