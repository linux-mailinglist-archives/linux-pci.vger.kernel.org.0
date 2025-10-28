Return-Path: <linux-pci+bounces-39487-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A854C1280A
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 02:14:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 833E3461E0E
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 01:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2E0212559;
	Tue, 28 Oct 2025 01:14:27 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E4F212552;
	Tue, 28 Oct 2025 01:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761614067; cv=none; b=gjHWm+SYKYHB1uatetaqkWf+if31cnEhN+VsEMmhCh3uCmyt0kw3bF7HW7ydwTYCcwHpmgsWKIFx5+EG8guAkRfXfFtyhZ78sa3JkhzgZ6mXNdlBmxCjATnGiXHYy6TbzY1uE8dDKPmuAIFeYzAWkVyDAYaZRduWQf8vX3qsmFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761614067; c=relaxed/simple;
	bh=HPmqcX9I7aYWkfvKn4CtPntBBzaTOma5E6hk6L1IY0g=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=oJFu8dYl6XH5INbyqsCexQbhmjyTwadrN0982XRRRW/IE79ipNJBG0ZwdBuGKyljlQq0DgtPdpcoTFzNDqtjXZVqcKIHtcQVmkAM29S+LSO1kg2gZlCoAjAgtU/VqSgYTaIeNtaxLABMyaJrskm3noBy3krb/ZoCAgTxhMJGWvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8BxmdHrGABpI1cbAA--.59711S3;
	Tue, 28 Oct 2025 09:14:19 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowJCxM+TnGABpxC4UAQ--.13588S3;
	Tue, 28 Oct 2025 09:14:17 +0800 (CST)
Subject: Re: [PATCH v2 1/2] PCI: Allow per function PCI slots
To: Niklas Schnelle <schnelle@linux.ibm.com>, Farhan Ali
 <alifm@linux.ibm.com>, linux-s390@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: helgaas@kernel.org, mjrosato@linux.ibm.com, bblock@linux.ibm.com,
 agordeev@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com,
 stable@vger.kernel.org, Tianrui Zhao <zhaotianrui@loongson.cn>,
 Huacai Chen <chenhuacai@kernel.org>
References: <20251022212411.1989-1-alifm@linux.ibm.com>
 <20251022212411.1989-2-alifm@linux.ibm.com>
 <e5a5d582a75c030a63c364d553c13baf373663ac.camel@linux.ibm.com>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <aa0214e8-31be-2b21-c8af-b7831efd60a7@loongson.cn>
Date: Tue, 28 Oct 2025 09:11:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <e5a5d582a75c030a63c364d553c13baf373663ac.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxM+TnGABpxC4UAQ--.13588S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxXw1Dtr4DJw1kCr4UKFykWFX_yoWrZry8pF
	W8CF1jkFyrJrW7AwsIv3WF9a4Yvan3JFWUGrWDG343uayYyr18tF15tF1Yg3s7JrW5uF1I
	va15Zw45uF95AFgCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
	xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v2
	6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
	vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
	wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc4
	0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
	xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
	1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU70PfDUUU
	U



On 2025/10/27 下午8:29, Niklas Schnelle wrote:
> On Wed, 2025-10-22 at 14:24 -0700, Farhan Ali wrote:
>> On s390 systems, which use a machine level hypervisor, PCI devices are
>> always accessed through a form of PCI pass-through which fundamentally
>> operates on a per PCI function granularity. This is also reflected in the
>> s390 PCI hotplug driver which creates hotplug slots for individual PCI
>> functions. Its reset_slot() function, which is a wrapper for
>> zpci_hot_reset_device(), thus also resets individual functions.
>>
>> Currently, the kernel's PCI_SLOT() macro assigns the same pci_slot object
>> to multifunction devices. This approach worked fine on s390 systems that
>> only exposed virtual functions as individual PCI domains to the operating
>> system.  Since commit 44510d6fa0c0 ("s390/pci: Handling multifunctions")
>> s390 supports exposing the topology of multifunction PCI devices by
>> grouping them in a shared PCI domain. When attempting to reset a function
>> through the hotplug driver, the shared slot assignment causes the wrong
>> function to be reset instead of the intended one. It also leaks memory as
>> we do create a pci_slot object for the function, but don't correctly free
>> it in pci_slot_release().
>>
>> Add a flag for struct pci_slot to allow per function PCI slots for
>> functions managed through a hypervisor, which exposes individual PCI
>> functions while retaining the topology.
> 
> I wonder if LoongArch which now also does per PCI function pass-through
> might need this too. Adding their KVM maintainers.

Hi Niklas,

Thanks for your reminder. Yes, LoongArch do per PCI function 
pass-throught. In theory, function pci_slot_enabled_per_func() should 
return true on LoongArch also. Only that now IOMMU driver is not merged, 
there is no way to test it, however we will write down this as a note 
inside about this issue and verify it once IOMMU driver is merged.


Regards
Bibo Mao
> 
>>
>> Fixes: 44510d6fa0c0 ("s390/pci: Handling multifunctions")
>> Cc: stable@vger.kernel.org
>> Suggested-by: Niklas Schnelle <schnelle@linux.ibm.com>
>> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
>> ---
>>   drivers/pci/pci.c   |  5 +++--
>>   drivers/pci/slot.c  | 25 ++++++++++++++++++++++---
>>   include/linux/pci.h |  1 +
>>   3 files changed, 26 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index b14dd064006c..36ee38e0d817 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -4980,8 +4980,9 @@ static int pci_reset_hotplug_slot(struct hotplug_slot *hotplug, bool probe)
>>   
>>   static int pci_dev_reset_slot_function(struct pci_dev *dev, bool probe)
>>   {
>> -	if (dev->multifunction || dev->subordinate || !dev->slot ||
>> -	    dev->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET)
>> +	if (dev->subordinate || !dev->slot ||
>> +	    dev->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET ||
>> +	    (dev->multifunction && !dev->slot->per_func_slot))
>>   		return -ENOTTY;
>>   
>>   	return pci_reset_hotplug_slot(dev->slot->hotplug, probe);
>> diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
>> index 50fb3eb595fe..ed10fa3ae727 100644
>> --- a/drivers/pci/slot.c
>> +++ b/drivers/pci/slot.c
>> @@ -63,6 +63,22 @@ static ssize_t cur_speed_read_file(struct pci_slot *slot, char *buf)
>>   	return bus_speed_read(slot->bus->cur_bus_speed, buf);
>>   }
>>   
>> +static bool pci_dev_matches_slot(struct pci_dev *dev, struct pci_slot *slot)
>> +{
>> +	if (slot->per_func_slot)
>> +		return dev->devfn == slot->number;
>> +
>> +	return PCI_SLOT(dev->devfn) == slot->number;
>> +}
>> +
>> +static bool pci_slot_enabled_per_func(void)
>> +{
>> +	if (IS_ENABLED(CONFIG_S390))
>> +		return true;
>> +
>> +	return false;
>> +}
>> +
> --- snip ---
>>   
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index d1fdf81fbe1e..6ad194597ab5 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -78,6 +78,7 @@ struct pci_slot {
>>   	struct list_head	list;		/* Node in list of slots */
>>   	struct hotplug_slot	*hotplug;	/* Hotplug info (move here) */
>>   	unsigned char		number;		/* PCI_SLOT(pci_dev->devfn) */
>> +	unsigned int		per_func_slot:1; /* Allow per function slot */
>>   	struct kobject		kobj;
>>   };
>>   
> 
> Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
> 


