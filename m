Return-Path: <linux-pci+bounces-36740-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C69CB94B7D
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 09:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62673190178E
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 07:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B6930F80B;
	Tue, 23 Sep 2025 07:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="lot0i4E5"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6730119F464;
	Tue, 23 Sep 2025 07:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758611748; cv=none; b=amWiqfRVy19fG0VP9ZqLASqW08jAP4WCRdVtqlt3aW4Ukz5UP8FFXaTK6nMa3pBRxfRKDacYeQwq34LcqSMaF811Jjc+pkjAIjqtPw2hUfzWeAXvNixHeqOjZjM+Hq7DUKGubvy3SkIEjZb5giIpTzsnDkzNXqH6KBq0HlzIOeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758611748; c=relaxed/simple;
	bh=xcFFxcY1G/LdshskQPV+mJHzzX3ScfDQdl2cQFk/5T4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jfnTMExwmOFmyfEsrxv14SA7NzUdo4yhBkXzVW9Gs4qZ9YJSufJorVmgOjuko6/0utakyJGnhuJmZwufk9LSe9jaG/5FS+GOFtMa7psu7t5zVKHXl6kEbb1dXecESZMu8wk4MUZ2U6ikybK+6I/xZFFAbEM+Tn95/vKe21TUgMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=lot0i4E5; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1758611742; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=YQ9Ax8VzDo1IjCKYLeNEOtC2Yz/urxKFImhxEwzB7vc=;
	b=lot0i4E54biwenGapAahqiGC5UmEJn912Z2kPRs5cVkY7acgoBWpRhav9wQ76MNk/wa9rF7kVacHLZFH00jvgYyzbwosWpajtLDyjz24/dLN1tm1aM21uyGTseGYaNqJXzxz2ygUjNmvArbTSw4bY/twYbq2hCgooJFsmzs2/3Y=
Received: from 30.246.179.19(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WoeDW7-_1758611739 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 23 Sep 2025 15:15:40 +0800
Message-ID: <fb87ff46-ebcf-450d-bfd5-b1ef52cda4be@linux.alibaba.com>
Date: Tue, 23 Sep 2025 15:15:38 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 1/3] PCI: trace: Add a generic RAS tracepoint for
 hotplug event
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: rostedt@goodmis.org, Lukas Wunner <lukas@wunner.de>,
 linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 linux-edac@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 helgaas@kernel.org, mattc@purestorage.com, Jonathan.Cameron@huawei.com,
 bhelgaas@google.com, tony.luck@intel.com, bp@alien8.de, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, oleg@redhat.com, naveen@kernel.org,
 davem@davemloft.net, anil.s.keshavamurthy@intel.com, mark.rutland@arm.com,
 peterz@infradead.org, tianruidong@linux.alibaba.com
References: <20250920060117.866-1-xueshuai@linux.alibaba.com>
 <20250920060117.866-2-xueshuai@linux.alibaba.com>
 <6bab311a-d5ba-133c-fddd-52899959445c@linux.intel.com>
 <12c84bff-6863-4730-b08a-631df904aa12@linux.alibaba.com>
 <fe2abb10-3847-af1c-12c2-193c32befe0c@linux.intel.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <fe2abb10-3847-af1c-12c2-193c32befe0c@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/9/23 14:46, Ilpo Järvinen 写道:
> On Tue, 23 Sep 2025, Shuai Xue wrote:
> 
>>
>>
>> 在 2025/9/22 21:10, Ilpo Järvinen 写道:
>>> On Sat, 20 Sep 2025, Shuai Xue wrote:
>>>
>>>> Hotplug events are critical indicators for analyzing hardware health,
>>>> and surprise link downs can significantly impact system performance and
>>>> reliability.
>>>>
>>>> Define a new TRACING_SYSTEM named "pci", add a generic RAS tracepoint
>>>> for hotplug event to help health checks. Add enum pci_hotplug_event in
>>>> include/uapi/linux/pci.h so applications like rasdaemon can register
>>>> tracepoint event handlers for it.
>>>>
>>>> The following output is generated when a device is hotplugged:
>>>>
>>>> $ echo 1 > /sys/kernel/debug/tracing/events/pci/pci_hp_event/enable
>>>> $ cat /sys/kernel/debug/tracing/trace_pipe
>>>>      irq/51-pciehp-88      [001] .....  1311.177459: pci_hp_event:
>>>> 0000:00:02.0 slot:10, event:CARD_PRESENT
>>>>
>>>>      irq/51-pciehp-88      [001] .....  1311.177566: pci_hp_event:
>>>> 0000:00:02.0 slot:10, event:LINK_UP
>>>>
>>>> Suggested-by: Lukas Wunner <lukas@wunner.de>
>>>> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
>>>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
>>>> Reviewed-by: Lukas Wunner <lukas@wunner.de>
>>>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>>> ---
>>>>    drivers/pci/Makefile              |  2 +
>>>>    drivers/pci/hotplug/Makefile      |  3 +-
>>>>    drivers/pci/hotplug/pciehp_ctrl.c | 31 ++++++++++++---
>>>>    drivers/pci/trace.c               | 11 ++++++
>>>>    include/trace/events/pci.h        | 63 +++++++++++++++++++++++++++++++
>>>>    include/uapi/linux/pci.h          |  7 ++++
>>>>    6 files changed, 110 insertions(+), 7 deletions(-)
>>>>    create mode 100644 drivers/pci/trace.c
>>>>    create mode 100644 include/trace/events/pci.h
>>>>
>>>> diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
>>>> index 67647f1880fb..bf389bc4dd3c 100644
>>>> --- a/drivers/pci/Makefile
>>>> +++ b/drivers/pci/Makefile
>>>> @@ -45,3 +45,5 @@ obj-y				+= controller/
>>>>    obj-y				+= switch/
>>>>      subdir-ccflags-$(CONFIG_PCI_DEBUG) := -DDEBUG
>>>> +
>>>> +CFLAGS_trace.o := -I$(src)
>>>> diff --git a/drivers/pci/hotplug/Makefile b/drivers/pci/hotplug/Makefile
>>>> index 40aaf31fe338..d41f7050b072 100644
>>>> --- a/drivers/pci/hotplug/Makefile
>>>> +++ b/drivers/pci/hotplug/Makefile
>>>> @@ -65,7 +65,8 @@ rpadlpar_io-objs	:=	rpadlpar_core.o \
>>>>    pciehp-objs		:=	pciehp_core.o	\
>>>>    				pciehp_ctrl.o	\
>>>>    				pciehp_pci.o	\
>>>> -				pciehp_hpc.o
>>>> +				pciehp_hpc.o	\
>>>> +				../trace.o
>>>
>>> To make it useful for any PCI tracing, not juse hotplug, this object file
>>> should be added in drivers/pci/Makefile, not here.
>>
>> Make sence. How about adding to the main CONFIG_PCI object:
>>
>> diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
>> index bf389bc4dd3c..d7f83d06351d 100644
>> --- a/drivers/pci/Makefile
>> +++ b/drivers/pci/Makefile
>> @@ -5,7 +5,7 @@
>>   obj-$(CONFIG_PCI)              += access.o bus.o probe.o host-bridge.o \
>>                                     remove.o pci.o pci-driver.o search.o \
>>                                     rom.o setup-res.o irq.o vpd.o \
>> -                                  setup-bus.o vc.o mmap.o devres.o
>> +                                  setup-bus.o vc.o mmap.o devres.o trace.o
>>
>>   obj-$(CONFIG_PCI)              += msi/
>>   obj-$(CONFIG_PCI)              += pcie/
> 
> Yes, that's the right place to add it.
> 

Thanks for confirm.
Will send a new version to fix it.

Thanks.
Shuai


