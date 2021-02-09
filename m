Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C24631497B
	for <lists+linux-pci@lfdr.de>; Tue,  9 Feb 2021 08:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbhBIH0e (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Feb 2021 02:26:34 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:12501 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbhBIH0O (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Feb 2021 02:26:14 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DZZBn4XhfzjLHC;
        Tue,  9 Feb 2021 15:24:01 +0800 (CST)
Received: from [127.0.0.1] (10.40.192.131) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.498.0; Tue, 9 Feb 2021
 15:25:22 +0800
Subject: Re: [PATCH v1 1/2] irqchip/gic-v3-its: don't set bitmap for LPI which
 user didn't allocate
To:     Marc Zyngier <maz@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linuxarm@openeuler.org>
References: <1612781926-56206-1-git-send-email-luojiaxing@huawei.com>
 <1612781926-56206-2-git-send-email-luojiaxing@huawei.com>
 <508c6c07a2c599ae1fc8b726fda69b44@kernel.org>
From:   luojiaxing <luojiaxing@huawei.com>
Message-ID: <bfe5e98a-52a6-636b-6b61-45482c07e2ec@huawei.com>
Date:   Tue, 9 Feb 2021 15:25:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <508c6c07a2c599ae1fc8b726fda69b44@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.40.192.131]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 2021/2/8 19:59, Marc Zyngier wrote:
> On 2021-02-08 10:58, Luo Jiaxing wrote:
>> The driver sets the LPI bitmap of device based on 
>> get_count_order(nvecs).
>> This means that when the number of LPI interrupts does not meet the 
>> power
>> of two, redundant bits are set in the LPI bitmap. However, when free
>> interrupt, these redundant bits is not cleared. As a result, device will
>> fails to allocate the same numbers of interrupts next time.
>>
>> Therefore, clear the redundant bits set in LPI bitmap.
>>
>> Fixes: 4615fbc3788d ("genirq/irqdomain: Don't try to free an interrupt
>> that has no mapping")
>>
>> Signed-off-by: Luo Jiaxing <luojiaxing@huawei.com>
>> ---
>>  drivers/irqchip/irq-gic-v3-its.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/irqchip/irq-gic-v3-its.c 
>> b/drivers/irqchip/irq-gic-v3-its.c
>> index ed46e60..027f7ef 100644
>> --- a/drivers/irqchip/irq-gic-v3-its.c
>> +++ b/drivers/irqchip/irq-gic-v3-its.c
>> @@ -3435,6 +3435,10 @@ static int its_alloc_device_irq(struct
>> its_device *dev, int nvecs, irq_hw_number
>>
>>      *hwirq = dev->event_map.lpi_base + idx;
>>
>> +    bitmap_clear(dev->event_map.lpi_map,
>> +             idx + nvecs,
>> +             roundup_pow_of_two(nvecs) - nvecs);
>> +
>>      return 0;
>>  }
>
> What makes you think that the remaining LPIs are free to be released?


I think that the LPI bitmap is used to mark the valid LPI interrupts 
allocated to the PCIe device.

Therefore, for the remaining LPIs, the ITS can reserve entries in the 
ITT table, but the bitmap does not need to be set.


Maybe my understanding is wrong, and I'm a little confused about the 
function of this bitmap.


> Even if the end-point has request a non-po2 number of MSIs, it could
> very well rely on the the rest of it to be available (specially in the
> case of PCI Multi-MSI).


yes, you are right. But for Multi-MSI, does it mean that one PCIE device 
can own several MSI interrupts?


Another question, is it possible for module driver to use these 
remaining LPIs?

For example, in my case


I allcoate 32 MSI with 16 affi-IRQ in it.

MSI can only offer 20 MSIs because online CPU number is 4 and it create 
20 msi desc then.

ITS create a its device for this PCIe device and generate a ITT tabel 
for 32 MSIs.


so in MSI, it provide 20 valid MSIs, but in ITS, lpi bitmap show that 32 
MSI is allocated.

This logic is a bit strange and a little incomprehensible.


>
> Have a look at the thread pointed out by John for a potential fix.


Sorry for missing that, I think it can fix my issue too, let me test it 
later.


Thanks

jiaxing


>
> Thanks,
>
>         M.

