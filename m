Return-Path: <linux-pci+bounces-8274-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1C98FC164
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 03:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9BC4B23174
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 01:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F17D4EB37;
	Wed,  5 Jun 2024 01:41:55 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513D461FC0;
	Wed,  5 Jun 2024 01:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717551715; cv=none; b=aQApi1eIbCvG3i+42zU3XfNXidHLnj9fb/OK68diPxWXpcr/OCgc+0uPjE8yaCSwoP8vpNhka6KNpLH9hZMjFyG8660G0M8QgCrh3qb3AcPr4Frgrx2FkvAH0orwSp3nUeA5OmvPVtBYyryEXn9GuVw+wo0qO9MtW6tXJimQ46w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717551715; c=relaxed/simple;
	bh=exuOLswyfPVZSQG8VHRSc5T6M/j1+LWAe960fq8wyu0=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=WNryek4BSvOtDF4fvjiXOouBvBGilqcJXHhtU2l5r0L3FIsht05r5EMYV3JoMzYTWCLFRzx/jWam/Z7gVi8C7HbaXWhp11/HWGgUxcAl42CasfePTaMzgWgiKecqizSPe/AxiNmUIrg3w41dP6Hpwd66sJ44uHYZoUxaSyto3gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [111.207.111.194])
	by gateway (Coremail) with SMTP id _____8Bx7epewl9mdJoDAA--.15681S3;
	Wed, 05 Jun 2024 09:41:50 +0800 (CST)
Received: from [10.180.13.176] (unknown [111.207.111.194])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8BxmsZbwl9mOAAVAA--.52410S3;
	Wed, 05 Jun 2024 09:41:48 +0800 (CST)
Subject: Re: [PATCH] PCI: use local_pci_probe when best selected cpu is
 offline
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Huacai Chen
 <chenhuacai@loongson.cn>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 stable@vger.kernel.org
References: <20240529111947.1549556-1-zhanghongchen@loongson.cn>
 <CAAhV-H5KD8BPzZYjpj5s4iSjOfJr+Q9hCV1nQn6fsUXPU8sriA@mail.gmail.com>
From: Hongchen Zhang <zhanghongchen@loongson.cn>
Message-ID: <9d5918ae-35ee-3221-19ba-e8e78e11bda3@loongson.cn>
Date: Wed, 5 Jun 2024 09:41:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAhV-H5KD8BPzZYjpj5s4iSjOfJr+Q9hCV1nQn6fsUXPU8sriA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8BxmsZbwl9mOAAVAA--.52410S3
X-CM-SenderInfo: x2kd0w5krqwupkhqwqxorr0wxvrqhubq/1tbiAQASB2ZecxMHOgBcst
X-Coremail-Antispam: 1Uk129KBj93XoW7Aw1DAF15ZF17Cr1kXFW5Jwc_yoW8WFyUpF
	ZxJayvkr40qF1UG3sIq3W5ZFyY9anrJF929392kw15ZF9xAr1Iqa17tFZ8Wr18GrWkZr1I
	v3W7XryDWFWUurgCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
	AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8zwZ7UU
	UUU==

On 2024/6/4 下午10:57, Huacai Chen wrote:
> Hi, Hongchen,
> 
> On Wed, May 29, 2024 at 7:19 PM Hongchen Zhang
> <zhanghongchen@loongson.cn> wrote:
> The title should be better like this:
> PCI: Use local_pci_probe() when best selected CPU is offline
> 
>>
>> When the best selected cpu is offline, work_on_cpu will stuck
>> forever. Therefore, in this case, we should call
>> local_pci_probe instead of work_on_cpu.
> 
> It is better to reword like this:
> 
> When the best selected CPU is offline, work_on_cpu() will stuck forever.
> This can be happen if a node is online while all its CPUs are offline
> (we can use "maxcpus=1" without "nr_cpus=1" to reproduce it), Therefore,
> in this case, we should call local_pci_probe() instead of work_on_cpu().
> 
OK, Let me modify the log and send V2.
> Huacai
> 
>>
>> Cc: <stable@vger.kernel.org>
>> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
>> Signed-off-by: Hongchen Zhang <zhanghongchen@loongson.cn>
>> ---
>>   drivers/pci/pci-driver.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
>> index af2996d0d17f..32a99828e6a3 100644
>> --- a/drivers/pci/pci-driver.c
>> +++ b/drivers/pci/pci-driver.c
>> @@ -386,7 +386,7 @@ static int pci_call_probe(struct pci_driver *drv, struct pci_dev *dev,
>>                  free_cpumask_var(wq_domain_mask);
>>          }
>>
>> -       if (cpu < nr_cpu_ids)
>> +       if ((cpu < nr_cpu_ids) && cpu_online(cpu))
>>                  error = work_on_cpu(cpu, local_pci_probe, &ddi);
>>          else
>>                  error = local_pci_probe(&ddi);
>> --
>> 2.33.0
>>
>>


-- 
Best Regards
Hongchen Zhang


