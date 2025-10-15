Return-Path: <linux-pci+bounces-38125-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8572BDCBB5
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 08:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45CBF1920B68
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 06:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8767130F93D;
	Wed, 15 Oct 2025 06:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="A0mQOTUw"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F78326FD84;
	Wed, 15 Oct 2025 06:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760509762; cv=none; b=qyXtu7osgs3CoZu2OtzhkS1aM3b4IB3IbVtfTH9mzvsV74hD31tOqpTqOWo/Fhn/Tq2y9F3A0X7J3JNheyibHzCpfRTq0b93Ix4ehpRTaCnlyaWcU54nfJ0UfkbMzbbvusRn4youbycnTVZKm3MiQN37AnRs2lG6498Aa+r8sMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760509762; c=relaxed/simple;
	bh=iezWRS8yvUvdTBT7iwBhic4M/CXdCiQL0UFtWijk8LM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QfTSSCIgp3tq/yy3Lsz9yiKFm2MMpWt/TqDiomaEJmzB/jMY/XsJn1Zc2himZIN4awogEw0ruhdC+UIzB8BLOyqoiNZ0wNieFlOOKKYpdAoCc2tFWdy9O42LTBAkHUIU+CeJw1/bXg6nxV1m673LnsfQ9LTmzIiZ596TW3JWvfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=A0mQOTUw; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1760509750; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=bbP6wfltIs9nIK3nD5iSabINDJ6NIt6iMczHxBUfYUU=;
	b=A0mQOTUwa+qs9fLoqAZllb5fY5OEsoEPkaSOzLN/xv43TH7G8795Dq/uYNPDUPK+cPL3OaF4fRm441FYRH96G5M55c5u+qVOFDUo6xKayXvAtXE2h7MWCHeeFN2zv8L79Pu1baEwao7hKZoWcxrRB2T7ZdJpqgmEeoqTDxlCHiI=
Received: from 30.246.161.241(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WqF7sLp_1760509747 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 15 Oct 2025 14:29:08 +0800
Message-ID: <b6353617-048a-4e12-a1d4-6d1484619927@linux.alibaba.com>
Date: Wed, 15 Oct 2025 14:29:07 +0800
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
> gave me a reason already, but why not simply pass in "ctrl" and have the
> TRACE_EVENT() denote the names?
> 
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
> -- Steve
> 

Hi, Steve,

Thank you for your suggestion about passing the controller directly to
the trace event. I investigated this approach, but unfortunately we
cannot implement it due to structural limitations in the PCI hotplug
subsystem.

The issue is that `struct controller` is not standardized across
different PCI hotplug drivers. Each driver defines its own version:

- pciehp has its own struct controller
- cpqphp has a different struct controller
- ibmphp and shpchp also have their own variants

This leads to naming conflicts. For example, both pciehp and cpqphp
define a slot_name() function, but with different signatures:

// In pciehp:
static inline const char *slot_name(struct controller *ctrl)
{
     return hotplug_slot_name(&ctrl->hotplug_slot);
}

// In cpqphp:
static inline const char *slot_name(struct slot *slot)

Additionally, `struct hotplug_slot` is not a common field across all
controller variants, making it impossible to have a unified way to
extract the slot name from a generic controller pointer in the trace
event.

Since we want these trace events to be generic and usable across all PCI
hotplug drivers (not just pciehp), we need to pass the already-resolved
strings rather than driver-specific structures. This ensures
compatibility and avoids the complexity of handling multiple controller
types within the trace infrastructure.

I understand this means doing the name resolution in the calling path,
but it's necessary to maintain a generic interface that works across all
PCI hotplug implementations.

Best Regards,
Shuai

