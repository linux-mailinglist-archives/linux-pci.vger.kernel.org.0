Return-Path: <linux-pci+bounces-36747-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C4AB94ECC
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 10:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CDCD1659E9
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 08:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15BA4318152;
	Tue, 23 Sep 2025 08:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="FJCjAhIf"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F3A31815E;
	Tue, 23 Sep 2025 08:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758615009; cv=none; b=IydRj0fp9X5VCdtH4azWqp6xjybCkMZJlCEkNt7fqRKr7T+hv13efRwcN55d7NoymwoY2nGfuSf3dYITmWxId3o0HSlY916AA3QbSN3zCsDsgL/60+kYIPyNAOhvxRPILSEuu2O1a9SIwTf7z5eBLGhF+U4ia+8uOkQ7dd5FVf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758615009; c=relaxed/simple;
	bh=GK6W2o2yxoO4wKeHSfnhUxQ3k4NiNOnEOep+Li3hwfo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JCi3x9TdsXWAfVWtzaWZYLWG9soJX30RS9fQMQ5eLEWuvj1QXfjvlMar7QsWpJbw6U6kbdesww/r/WKhKhJ7lRpQdHDCJp5w3QyD5B2Xg9iiOSFRckknFlwZ+FaqMJs667XI/6SnSYcl/IioK2/qocbHl9MYW5TKk0sKxrOL6AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=FJCjAhIf; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1758614997; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=kgV6N3k9/Wc8oyqFWj6fu9j0StoO2o5pi55D5FleEKo=;
	b=FJCjAhIfcQv786hJJ5GzRUglpGucqmdS1N85jhjQrn+AL4ztiZVRXtTORKMmvZ/rYzII+TeS/CLja3MbcHFCyImHAr7DfF3lCcTJG+LkYHJsCP0EqkMFzImG57gAJfaheKLqJp89LOJ0n8lVHU6P/Ni9iPhXkSMI0VmmGZNqMrc=
Received: from 30.246.179.19(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WoeFI1T_1758614994 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 23 Sep 2025 16:09:55 +0800
Message-ID: <8706188e-23b2-4cb1-b279-3b462ba9b9de@linux.alibaba.com>
Date: Tue, 23 Sep 2025 16:09:53 +0800
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
 <fb87ff46-ebcf-450d-bfd5-b1ef52cda4be@linux.alibaba.com>
 <acfde737-23b3-7b0a-65c6-01082a71e5e8@linux.intel.com>
 <453b792a-23f9-6d72-f35a-60526b3e04e0@linux.intel.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <453b792a-23f9-6d72-f35a-60526b3e04e0@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/9/23 15:34, Ilpo Järvinen 写道:
> On Tue, 23 Sep 2025, Ilpo Järvinen wrote:
> 
>> On Tue, 23 Sep 2025, Shuai Xue wrote:
>>
>>>
>>>
>>> 在 2025/9/23 14:46, Ilpo Järvinen 写道:
>>>> On Tue, 23 Sep 2025, Shuai Xue wrote:
>>>>
>>>>>
>>>>>
>>>>> 在 2025/9/22 21:10, Ilpo Järvinen 写道:
>>>>>> On Sat, 20 Sep 2025, Shuai Xue wrote:
>>>>>>
>>>>>>> Hotplug events are critical indicators for analyzing hardware health,
>>>>>>> and surprise link downs can significantly impact system performance
>>>>>>> and
>>>>>>> reliability.
>>>>>>>
>>>>>>> Define a new TRACING_SYSTEM named "pci", add a generic RAS tracepoint
>>>>>>> for hotplug event to help health checks. Add enum pci_hotplug_event in
>>>>>>> include/uapi/linux/pci.h so applications like rasdaemon can register
>>>>>>> tracepoint event handlers for it.
>>>>>>>
>>>>>>> The following output is generated when a device is hotplugged:
>>>>>>>
>>>>>>> $ echo 1 > /sys/kernel/debug/tracing/events/pci/pci_hp_event/enable
>>>>>>> $ cat /sys/kernel/debug/tracing/trace_pipe
>>>>>>>       irq/51-pciehp-88      [001] .....  1311.177459: pci_hp_event:
>>>>>>> 0000:00:02.0 slot:10, event:CARD_PRESENT
>>>>>>>
>>>>>>>       irq/51-pciehp-88      [001] .....  1311.177566: pci_hp_event:
>>>>>>> 0000:00:02.0 slot:10, event:LINK_UP
>>>>>>>
>>>>>>> Suggested-by: Lukas Wunner <lukas@wunner.de>
>>>>>>> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
>>>>>>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
>>>>>>> Reviewed-by: Lukas Wunner <lukas@wunner.de>
>>>>>>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>>>>>> ---
>>>>>>>     drivers/pci/Makefile              |  2 +
>>>>>>>     drivers/pci/hotplug/Makefile      |  3 +-
>>>>>>>     drivers/pci/hotplug/pciehp_ctrl.c | 31 ++++++++++++---
>>>>>>>     drivers/pci/trace.c               | 11 ++++++
>>>>>>>     include/trace/events/pci.h        | 63
>>>>>>> +++++++++++++++++++++++++++++++
>>>>>>>     include/uapi/linux/pci.h          |  7 ++++
>>>>>>>     6 files changed, 110 insertions(+), 7 deletions(-)
>>>>>>>     create mode 100644 drivers/pci/trace.c
>>>>>>>     create mode 100644 include/trace/events/pci.h
>>>>>>>
>>>>>>> diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
>>>>>>> index 67647f1880fb..bf389bc4dd3c 100644
>>>>>>> --- a/drivers/pci/Makefile
>>>>>>> +++ b/drivers/pci/Makefile
>>>>>>> @@ -45,3 +45,5 @@ obj-y				+= controller/
>>>>>>>     obj-y				+= switch/
>>>>>>>       subdir-ccflags-$(CONFIG_PCI_DEBUG) := -DDEBUG
>>>>>>> +
>>>>>>> +CFLAGS_trace.o := -I$(src)
>>>>>>> diff --git a/drivers/pci/hotplug/Makefile
>>>>>>> b/drivers/pci/hotplug/Makefile
>>>>>>> index 40aaf31fe338..d41f7050b072 100644
>>>>>>> --- a/drivers/pci/hotplug/Makefile
>>>>>>> +++ b/drivers/pci/hotplug/Makefile
>>>>>>> @@ -65,7 +65,8 @@ rpadlpar_io-objs	:=	rpadlpar_core.o \
>>>>>>>     pciehp-objs		:=	pciehp_core.o	\
>>>>>>>     				pciehp_ctrl.o	\
>>>>>>>     				pciehp_pci.o	\
>>>>>>> -				pciehp_hpc.o
>>>>>>> +				pciehp_hpc.o	\
>>>>>>> +				../trace.o
>>>>>>
>>>>>> To make it useful for any PCI tracing, not juse hotplug, this object
>>>>>> file
>>>>>> should be added in drivers/pci/Makefile, not here.
>>>>>
>>>>> Make sence. How about adding to the main CONFIG_PCI object:
>>>>>
>>>>> diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
>>>>> index bf389bc4dd3c..d7f83d06351d 100644
>>>>> --- a/drivers/pci/Makefile
>>>>> +++ b/drivers/pci/Makefile
>>>>> @@ -5,7 +5,7 @@
>>>>>    obj-$(CONFIG_PCI)              += access.o bus.o probe.o host-bridge.o \
>>>>>                                      remove.o pci.o pci-driver.o search.o \
>>>>>                                      rom.o setup-res.o irq.o vpd.o \
>>>>> -                                  setup-bus.o vc.o mmap.o devres.o
>>>>> +                                  setup-bus.o vc.o mmap.o devres.o
>>>>> trace.o
>>>>>
>>>>>    obj-$(CONFIG_PCI)              += msi/
>>>>>    obj-$(CONFIG_PCI)              += pcie/
>>>>
>>>> Yes, that's the right place to add it.
>>>>
>>>
>>> Thanks for confirm.
>>> Will send a new version to fix it.
>>
>> I actually now started to wonder if it should be made depend on some
>> tracing related config (sending this out quickly if you were just
>> waiting for my confirmation to send quickly... I'm still investigating
>> what other subsystems do).
> 
> Probably this is what we actually want:
> 
> obj-$(CONFIG_TRACING)			+= trace.o
> 


Thanks for the input, lots of trace.o, e.g. for cxl and nvme, are compiled
under CONFIG_TRACING.

Will use CONFIG_TRACING :)

Thanks.
Shuai

