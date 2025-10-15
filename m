Return-Path: <linux-pci+bounces-38101-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A819EBDC28E
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 04:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FEE43AB51A
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 02:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00EA02E1F03;
	Wed, 15 Oct 2025 02:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="N9xVC8VK"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F5C2C859;
	Wed, 15 Oct 2025 02:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760495745; cv=none; b=WREnkXNWetBnbLYb6Tw/MsL+DGjOO+M2DxxB7vojy2qfh0WaCrkaT+WPZfVIj8vp2pX5g8TIAjPfOOvvWbHizN7xbyjEyzY0/DPTmCgjdtkaU7nWznDnniLM4JK0v4y/Ts3vTZxrYp3vK/3fplg+1MXr46zzpFbMYqNKKdO+8is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760495745; c=relaxed/simple;
	bh=+hhfMkLoMzMaCFC05rGhJGah8vukF2mAJqtg4s3GI4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vya8+TqsXkosCveSCc9OWjx9TmvkoqdJM8Kr2NpyFZtsZbQQK/Pf2H3+OTFfSEvH/BgDa/jgRyyjVxlcA0Jv+j/tHJH1NP7ro5aQcU83UO/+qKZKGmDT2STLGpJJk5D4V8Vjux5u7G4F2jhFVe/IwOBd9Ohi91aGBEJV32FSD6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=N9xVC8VK; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1760495739; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=tFB5nfDGfzav+SVFX4uGXGTnZIQxoYbB9Vh1ZlCmm9U=;
	b=N9xVC8VKDNUZKS17MCkswoU60YccOK6dV8mWEuz2JzliAZDVb6jECKdTF4hCDc4jVSR50yk3AtbBI7oF3Wd/nkXwwRahVili1BYJXEVNGTMzGRXIOLj2JJmwRRwsE0Z6DHYg0+MQE7C8CWckITsUY7JXxD2ITNZEQR3Ys/O3Zx0=
Received: from 30.246.161.241(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WqEPCuw_1760495736 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 15 Oct 2025 10:35:38 +0800
Message-ID: <a7dcde2d-c0e8-4a6e-ab31-1a263f855037@linux.alibaba.com>
Date: Wed, 15 Oct 2025 10:35:36 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 1/3] PCI: trace: Add a generic RAS tracepoint for
 hotplug event
To: Steven Rostedt <rostedt@goodmis.org>
Cc: lukas@wunner.de, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-edac@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 helgaas@kernel.org, ilpo.jarvinen@linux.intel.com, mattc@purestorage.com,
 Jonathan.Cameron@huawei.com, bhelgaas@google.com, tony.luck@intel.com,
 bp@alien8.de, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 oleg@redhat.com, naveen@kernel.org, davem@davemloft.net,
 anil.s.keshavamurthy@intel.com, mark.rutland@arm.com, peterz@infradead.org,
 tianruidong@linux.alibaba.com
References: <20251014123159.57764-1-xueshuai@linux.alibaba.com>
 <20251014123159.57764-2-xueshuai@linux.alibaba.com>
 <20251014114029.4c59bb1a@gandalf.local.home>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20251014114029.4c59bb1a@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/10/14 23:40, Steven Rostedt 写道:
> On Tue, 14 Oct 2025 20:31:57 +0800
> Shuai Xue <xueshuai@linux.alibaba.com> wrote:
> 
>> Hotplug events are critical indicators for analyzing hardware health,
>> and surprise link downs can significantly impact system performance and
>> reliability.
>>
>> Define a new TRACING_SYSTEM named "pci", add a generic RAS tracepoint
>> for hotplug event to help health checks. Add enum pci_hotplug_event in
>> include/uapi/linux/pci.h so applications like rasdaemon can register
>> tracepoint event handlers for it.
>>
>> The following output is generated when a device is hotplugged:
>>
>> $ echo 1 > /sys/kernel/debug/tracing/events/pci/pci_hp_event/enable
>> $ cat /sys/kernel/debug/tracing/trace_pipe
>>     irq/51-pciehp-88      [001] .....  1311.177459: pci_hp_event: 0000:00:02.0 slot:10, event:CARD_PRESENT
>>
>>     irq/51-pciehp-88      [001] .....  1311.177566: pci_hp_event: 0000:00:02.0 slot:10, event:LINK_UP
>>
>> Suggested-by: Lukas Wunner <lukas@wunner.de>
>> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
>> Reviewed-by: Lukas Wunner <lukas@wunner.de>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> ---
>>   drivers/pci/Makefile              |  3 ++
>>   drivers/pci/hotplug/pciehp_ctrl.c | 31 ++++++++++++---
>>   drivers/pci/trace.c               | 11 ++++++
>>   include/trace/events/pci.h        | 63 +++++++++++++++++++++++++++++++
>>   include/uapi/linux/pci.h          |  7 ++++
>>   5 files changed, 109 insertions(+), 6 deletions(-)
>>   create mode 100644 drivers/pci/trace.c
>>   create mode 100644 include/trace/events/pci.h
>>
>> diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
>> index 67647f1880fb..58a4e4ea76b0 100644
>> --- a/drivers/pci/Makefile
>> +++ b/drivers/pci/Makefile
>> @@ -45,3 +45,6 @@ obj-y				+= controller/
>>   obj-y				+= switch/
>>   
>>   subdir-ccflags-$(CONFIG_PCI_DEBUG) := -DDEBUG
>> +
>> +CFLAGS_trace.o := -I$(src)
>> +obj-$(CONFIG_TRACING)		+= trace.o
>> diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
>> index bcc938d4420f..7805f697a02c 100644
>> --- a/drivers/pci/hotplug/pciehp_ctrl.c
>> +++ b/drivers/pci/hotplug/pciehp_ctrl.c
>> @@ -19,6 +19,7 @@
>>   #include <linux/types.h>
>>   #include <linux/pm_runtime.h>
>>   #include <linux/pci.h>
>> +#include <trace/events/pci.h>
>>   
>>   #include "../pci.h"
>>   #include "pciehp.h"
>> @@ -244,12 +245,20 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
>>   	case ON_STATE:
>>   		ctrl->state = POWEROFF_STATE;
>>   		mutex_unlock(&ctrl->state_lock);
>> -		if (events & PCI_EXP_SLTSTA_DLLSC)
>> +		if (events & PCI_EXP_SLTSTA_DLLSC) {
>>   			ctrl_info(ctrl, "Slot(%s): Link Down\n",
>>   				  slot_name(ctrl));
>> -		if (events & PCI_EXP_SLTSTA_PDC)
>> +			trace_pci_hp_event(pci_name(ctrl->pcie->port),
>> +					   slot_name(ctrl),
>> +					   PCI_HOTPLUG_LINK_DOWN);
> 
> I know this is v12 and I don't remember if I suggested this before and you
> gave me a reason already, 


Aha, in our previous email discussions regarding the tracepoint
implementation, you provided many constructive suggestions, so I added
the Suggested-by tag. Perhaps I misunderstood the meaning of
Suggested-by - I will drop it.


> but why not simply pass in "ctrl" and have the
> TRACE_EVENT() denote the names?

Sure, I will send a version.

>> +		}
>> +		if (events & PCI_EXP_SLTSTA_PDC) {
>>   			ctrl_info(ctrl, "Slot(%s): Card not present\n",
>>   				  slot_name(ctrl));
>> +			trace_pci_hp_event(pci_name(ctrl->pcie->port),
>> +					   slot_name(ctrl),
>> +					   PCI_HOTPLUG_CARD_NOT_PRESENT);
>> +		}
>>   		pciehp_disable_slot(ctrl, SURPRISE_REMOVAL);
>>   		break;
>>   	default:
>> @@ -269,6 +278,9 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
>>   					      INDICATOR_NOOP);
>>   			ctrl_info(ctrl, "Slot(%s): Card not present\n",
>>   				  slot_name(ctrl));
>> +			trace_pci_hp_event(pci_name(ctrl->pcie->port),
>> +					   slot_name(ctrl),
>> +					   PCI_HOTPLUG_CARD_NOT_PRESENT);
>>   		}
>>   		mutex_unlock(&ctrl->state_lock);
>>   		return;
>> @@ -281,12 +293,19 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
>>   	case OFF_STATE:
>>   		ctrl->state = POWERON_STATE;
>>   		mutex_unlock(&ctrl->state_lock);
>> -		if (present)
>> +		if (present) {
>>   			ctrl_info(ctrl, "Slot(%s): Card present\n",
>>   				  slot_name(ctrl));
>> -		if (link_active)
>> -			ctrl_info(ctrl, "Slot(%s): Link Up\n",
>> -				  slot_name(ctrl));
>> +			trace_pci_hp_event(pci_name(ctrl->pcie->port),
>> +					   slot_name(ctrl),
>> +					   PCI_HOTPLUG_CARD_PRESENT);
>> +		}
>> +		if (link_active) {
>> +			ctrl_info(ctrl, "Slot(%s): Link Up\n", slot_name(ctrl));
>> +			trace_pci_hp_event(pci_name(ctrl->pcie->port),
>> +					   slot_name(ctrl),
>> +					   PCI_HOTPLUG_LINK_UP);
>> +		}
>>   		ctrl->request_result = pciehp_enable_slot(ctrl);
>>   		break;
>>   	default:
>> diff --git a/drivers/pci/trace.c b/drivers/pci/trace.c
>> new file mode 100644
>> index 000000000000..cf11abca8602
>> --- /dev/null
>> +++ b/drivers/pci/trace.c
>> @@ -0,0 +1,11 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Tracepoints for PCI system
>> + *
>> + * Copyright (C) 2025 Alibaba Corporation
>> + */
>> +
>> +#include <linux/pci.h>
>> +
>> +#define CREATE_TRACE_POINTS
>> +#include <trace/events/pci.h>
>> diff --git a/include/trace/events/pci.h b/include/trace/events/pci.h
>> new file mode 100644
>> index 000000000000..208609492c06
>> --- /dev/null
>> +++ b/include/trace/events/pci.h
>> @@ -0,0 +1,63 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#undef TRACE_SYSTEM
>> +#define TRACE_SYSTEM pci
>> +
>> +#if !defined(_TRACE_HW_EVENT_PCI_H) || defined(TRACE_HEADER_MULTI_READ)
>> +#define _TRACE_HW_EVENT_PCI_H
>> +
>> +#include <linux/tracepoint.h>
>> +
>> +#define PCI_HOTPLUG_EVENT						\
>> +	EM(PCI_HOTPLUG_LINK_UP,			"LINK_UP")		\
>> +	EM(PCI_HOTPLUG_LINK_DOWN,		"LINK_DOWN")		\
>> +	EM(PCI_HOTPLUG_CARD_PRESENT,		"CARD_PRESENT")		\
>> +	EMe(PCI_HOTPLUG_CARD_NOT_PRESENT,	"CARD_NOT_PRESENT")
>> +
>> +/* Enums require being exported to userspace, for user tool parsing */
>> +#undef EM
>> +#undef EMe
>> +#define EM(a, b)	TRACE_DEFINE_ENUM(a);
>> +#define EMe(a, b)	TRACE_DEFINE_ENUM(a);
>> +
>> +PCI_HOTPLUG_EVENT
>> +
>> +/*
>> + * Now redefine the EM() and EMe() macros to map the enums to the strings
>> + * that will be printed in the output.
>> + */
>> +#undef EM
>> +#undef EMe
>> +#define EM(a, b)	{a, b},
>> +#define EMe(a, b)	{a, b}
>> +
>> +TRACE_EVENT(pci_hp_event,
>> +
>> +	TP_PROTO(const char *port_name,
>> +		 const char *slot,
>> +		 const int event),
>> +
>> +	TP_ARGS(port_name, slot, event),
>> +
>> +	TP_STRUCT__entry(
>> +		__string(	port_name,	port_name	)
>> +		__string(	slot,		slot		)
>> +		__field(	int,		event	)
>> +	),
> 
> 	TP_PROTO(struct controller *ctrl, int event),
> 
> 	TP_ARGS(ctrl, event),
> 
> 	TP_STRUCT__entry(
> 		__string(	port_name,	pci_name(ctrl->pcie->port)	)
> 		__string(	slot,		slot_name(ctrl)			)
> 		__field(	int,		event				)
> 	),
> 
> It would move the work out of the calling path.
> 

I see.

> -- Steve


Thanks.

Best Regards,
Shuai

