Return-Path: <linux-pci+bounces-28263-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD53AC08E5
	for <lists+linux-pci@lfdr.de>; Thu, 22 May 2025 11:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 479274A76DF
	for <lists+linux-pci@lfdr.de>; Thu, 22 May 2025 09:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D4D284691;
	Thu, 22 May 2025 09:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="YjWwZuC9"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396BF17BB6;
	Thu, 22 May 2025 09:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747906908; cv=none; b=CY50CRgIdErS/uI7eyukaFuIJMsMYDLSlB361zebq+rae4iomOoOkpWgX4GHZzSEpCMPlGDNrqFJEjf1kC5rZA3Xh+uDd/izHlmuDCQjBfiPI2jkq66qJPSrRbyUEQ+sPVdt6U7H/40ZobpWT+iNoOzfBeA2ZMI4TU2LZL1bTx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747906908; c=relaxed/simple;
	bh=f2jUJ1j8NtmYUowY699rjzNoYmDolsYrdjZChArE8qQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XZBgv9d8+zW+byBjlg0Nf/AgZTt9zODCizgTOeMBZ1jbLHtM+RGmhfP8ZzjuJ90lLQRrXgsb+HcZeMv4j3uwd1C/A/ItOnEhpkoCyDDSaFuszlqmE0fUwdqdU5EifoJQFcAsXvyUqX0uUnLblUQEIcQQZw3/JHPnEvqvr9Ic0k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=YjWwZuC9; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1747906895; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=SYVo3gNekqV9B2COH5LnMpPWBh5kyqXGT2+V3ar74LE=;
	b=YjWwZuC9Tae2Pq3DqOniKOek/TE2i7BhpmtAiOLzAJR4zCn7RoHQz8ymyN/rbOM3gu2KSN8F9KRtA2bltaOfGtyjw++2zhZ2/B9iYLagWWxJ3/9gCH2xPhePpq/DgtgXxTxClDrHiFKDr29blodNke3Irn83crW98oHsW2BjByA=
Received: from 30.246.160.208(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WbVRhKz_1747906892 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 22 May 2025 17:41:33 +0800
Message-ID: <a036291f-2483-4bf0-9ac1-db310f8115aa@linux.alibaba.com>
Date: Thu, 22 May 2025 17:41:31 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8] PCI: hotplug: Add a generic RAS tracepoint for hotplug
 event
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: rostedt@goodmis.org, Lukas Wunner <lukas@wunner.de>,
 linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 linux-edac@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 helgaas@kernel.org, bhelgaas@google.com, tony.luck@intel.com, bp@alien8.de,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, oleg@redhat.com,
 naveen@kernel.org, davem@davemloft.net, anil.s.keshavamurthy@intel.com,
 mark.rutland@arm.com, peterz@infradead.org, tianruidong@linux.alibaba.com
References: <20250512013839.45960-1-xueshuai@linux.alibaba.com>
 <87b1f8c6-bd72-b1a8-40a6-bbf552552806@linux.intel.com>
 <650cd4e4-561b-4d50-9cf2-c601518c9b9f@linux.alibaba.com>
 <31693574-e8bc-9a56-bad0-6a22280c4b6b@linux.intel.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <31693574-e8bc-9a56-bad0-6a22280c4b6b@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/5/20 18:07, Ilpo Järvinen 写道:
> On Tue, 20 May 2025, Shuai Xue wrote:
> 
>> Hi, Ilpo,
>>
>> 在 2025/5/20 01:10, Ilpo Järvinen 写道:
>>> On Mon, 12 May 2025, Shuai Xue wrote:
>>>
>>>> Hotplug events are critical indicators for analyzing hardware health,
>>>> particularly in AI supercomputers where surprise link downs can
>>>> significantly impact system performance and reliability.
>>>>
>>>> To this end, define a new TRACING_SYSTEM named pci, add a generic RAS
>>>> tracepoint for hotplug event to help healthy check, and generate
>>>> tracepoints for pcie hotplug event. Add enum pci_hotplug_event in
>>>> include/uapi/linux/pci.h so applications like rasdaemon can register
>>>> tracepoint event handlers for it.
>>>>
>>>> The output like below:
>>>>
>>>> $ echo 1 > /sys/kernel/debug/tracing/events/pci/pci_hp_event/enable
>>>> $ cat /sys/kernel/debug/tracing/trace_pipe
>>>>       <...>-206     [001] .....    40.373870: pci_hp_event: 0000:00:02.0
>>>> slot:10, event:Link Down
>>>>
>>>>       <...>-206     [001] .....    40.374871: pci_hp_event: 0000:00:02.0
>>>> slot:10, event:Card not present
>>>>
>>>> Suggested-by: Lukas Wunner <lukas@wunner.de>
>>>> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
>>>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
>>>> Reviewed-by: Lukas Wunner <lukas@wunner.de>
>>>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>>> ---
>>>> changes since v7:
>>>> - replace the TRACE_INCLUDE_PATH to avoid macro conflict per Steven
>>>> - pick up Reviewed-by from Lukas Wunner
>>>> ---
>>>>    drivers/pci/hotplug/Makefile      |  3 ++
>>>>    drivers/pci/hotplug/pciehp_ctrl.c | 33 ++++++++++++---
>>>>    drivers/pci/hotplug/trace.h       | 68 +++++++++++++++++++++++++++++++
>>>>    include/uapi/linux/pci.h          |  7 ++++
>>>>    4 files changed, 105 insertions(+), 6 deletions(-)
>>>>    create mode 100644 drivers/pci/hotplug/trace.h
>>>>
>>>> diff --git a/drivers/pci/hotplug/Makefile b/drivers/pci/hotplug/Makefile
>>>> index 40aaf31fe338..a1a9d1e98962 100644
>>>> --- a/drivers/pci/hotplug/Makefile
>>>> +++ b/drivers/pci/hotplug/Makefile
>>>> @@ -3,6 +3,9 @@
>>>>    # Makefile for the Linux kernel pci hotplug controller drivers.
>>>>    #
>>>>    +# define_trace.h needs to know how to find our header
>>>> +CFLAGS_pciehp_ctrl.o				:= -I$(src)
>>>> +
>>>>    obj-$(CONFIG_HOTPLUG_PCI)		+= pci_hotplug.o
>>>>    obj-$(CONFIG_HOTPLUG_PCI_COMPAQ)	+= cpqphp.o
>>>>    obj-$(CONFIG_HOTPLUG_PCI_IBM)		+= ibmphp.o
>>>> diff --git a/drivers/pci/hotplug/pciehp_ctrl.c
>>>> b/drivers/pci/hotplug/pciehp_ctrl.c
>>>> index d603a7aa7483..f9beb4d3a9b8 100644
>>>> --- a/drivers/pci/hotplug/pciehp_ctrl.c
>>>> +++ b/drivers/pci/hotplug/pciehp_ctrl.c
>>>> @@ -23,6 +23,9 @@
>>>>    #include "../pci.h"
>>>>    #include "pciehp.h"
>>>>    +#define CREATE_TRACE_POINTS
>>>> +#include "trace.h"
>>>> +
>>>>    /* The following routines constitute the bulk of the
>>>>       hotplug controller logic
>>>>     */
>>>> @@ -244,12 +247,20 @@ void pciehp_handle_presence_or_link_change(struct
>>>> controller *ctrl, u32 events)
>>>>    	case ON_STATE:
>>>>    		ctrl->state = POWEROFF_STATE;
>>>>    		mutex_unlock(&ctrl->state_lock);
>>>> -		if (events & PCI_EXP_SLTSTA_DLLSC)
>>>> +		if (events & PCI_EXP_SLTSTA_DLLSC) {
>>>>    			ctrl_info(ctrl, "Slot(%s): Link Down\n",
>>>>    				  slot_name(ctrl));
>>>> -		if (events & PCI_EXP_SLTSTA_PDC)
>>>> +			trace_pci_hp_event(pci_name(ctrl->pcie->port),
>>>> +					   slot_name(ctrl),
>>>> +					   PCI_HOTPLUG_LINK_DOWN);
>>>> +		}
>>>> +		if (events & PCI_EXP_SLTSTA_PDC) {
>>>>    			ctrl_info(ctrl, "Slot(%s): Card not present\n",
>>>>    				  slot_name(ctrl));
>>>> +			trace_pci_hp_event(pci_name(ctrl->pcie->port),
>>>> +					   slot_name(ctrl),
>>>> +					   PCI_HOTPLUG_CARD_NOT_PRESENT);
>>>> +		}
>>>>    		pciehp_disable_slot(ctrl, SURPRISE_REMOVAL);
>>>>    		break;
>>>>    	default:
>>>> @@ -269,6 +280,9 @@ void pciehp_handle_presence_or_link_change(struct
>>>> controller *ctrl, u32 events)
>>>>    					      INDICATOR_NOOP);
>>>>    			ctrl_info(ctrl, "Slot(%s): Card not present\n",
>>>>    				  slot_name(ctrl));
>>>> +			trace_pci_hp_event(pci_name(ctrl->pcie->port),
>>>> +					   slot_name(ctrl),
>>>> +					   PCI_HOTPLUG_CARD_NOT_PRESENT);
>>>>    		}
>>>>    		mutex_unlock(&ctrl->state_lock);
>>>>    		return;
>>>> @@ -281,12 +295,19 @@ void pciehp_handle_presence_or_link_change(struct
>>>> controller *ctrl, u32 events)
>>>>    	case OFF_STATE:
>>>>    		ctrl->state = POWERON_STATE;
>>>>    		mutex_unlock(&ctrl->state_lock);
>>>> -		if (present)
>>>> +		if (present) {
>>>>    			ctrl_info(ctrl, "Slot(%s): Card present\n",
>>>>    				  slot_name(ctrl));
>>>> -		if (link_active)
>>>> -			ctrl_info(ctrl, "Slot(%s): Link Up\n",
>>>> -				  slot_name(ctrl));
>>>> +			trace_pci_hp_event(pci_name(ctrl->pcie->port),
>>>> +					   slot_name(ctrl),
>>>> +					   PCI_HOTPLUG_CARD_PRESENT);
>>>> +		}
>>>> +		if (link_active) {
>>>> +			ctrl_info(ctrl, "Slot(%s): Link Up\n",
>>>> slot_name(ctrl));
>>>> +			trace_pci_hp_event(pci_name(ctrl->pcie->port),
>>>> +					   slot_name(ctrl),
>>>> +					   PCI_HOTPLUG_LINK_UP);
>>>> +		}
>>>>    		ctrl->request_result = pciehp_enable_slot(ctrl);
>>>>    		break;
>>>>    	default:
>>>> diff --git a/drivers/pci/hotplug/trace.h b/drivers/pci/hotplug/trace.h
>>>> new file mode 100644
>>>> index 000000000000..21329c198019
>>>> --- /dev/null
>>>> +++ b/drivers/pci/hotplug/trace.h
>>>> @@ -0,0 +1,68 @@
>>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>>> +#if !defined(_TRACE_HW_EVENT_PCI_HP_H) ||
>>>> defined(TRACE_HEADER_MULTI_READ)
>>>> +#define _TRACE_HW_EVENT_PCI_HP_H
>>>> +
>>>> +#include <linux/tracepoint.h>
>>>> +
>>>> +#undef TRACE_SYSTEM
>>>> +#define TRACE_SYSTEM pci
>>>> +
>>>> +#define PCI_HOTPLUG_EVENT					\
>>>> +	EM(PCI_HOTPLUG_LINK_UP,			"Link Up")	\
>>>> +	EM(PCI_HOTPLUG_LINK_DOWN,		"Link Down")	\
>>>> +	EM(PCI_HOTPLUG_CARD_PRESENT,		"Card present")	\
>>>> +	EMe(PCI_HOTPLUG_CARD_NOT_PRESENT,	"Card not present")
>>>
>>> Hi,
>>>
>>> While I was thinking of adding tracing into PCIe BW controller (bwctrl),
>>> I ended up thinking that perhaps it would make more sense to have PCIe
>>> Link related tracepoints which would cover both hotplug and bwctrl so that
>>> also Link Speed changes would be reported through the same trace event.
>>>
>>> Downgraded speed may indicate there's something wrong with the card and
>>> the Link Speed does have performance impact too for those who are pushing
>>> BW boundaries such as AI systems.
>>
>> Agreed!
>>
>>>
>>> So my suggestion is:
>>>
>>> - Add "Link Speed changed" to the event types.
>>> - Add Link Speed and Width into the event format (and probably also Flit
>>>     mode as PCIe gen6 is coming).
>>
>>
>> How about bellow event format:
>>
>> +	TP_STRUCT__entry(
>> +		__string(	port_name,	port_name	)
>> +		__field(	unsigned char,	cur_bus_speed	)
>> +		__field(	unsigned char,	max_bus_speed	)
> 
> Add also the Link Width.

Got it.
> 
>> +		__field(	unsigned char,	flit_mode	)
>> +	),
>>
>> And add the event to pcie_update_link_speed():
>>
>> @@ -796,6 +799,10 @@ void pcie_update_link_speed(struct pci_bus *bus)
>>          pcie_capability_read_word(bridge, PCI_EXP_LNKSTA, &linksta);
>>          pcie_capability_read_word(bridge, PCI_EXP_LNKSTA2, &linksta2);
>>          __pcie_update_link_speed(bus, linksta, linksta2);
>> +
>> +       trace_pci_link_event(pci_name(bridge), bus->cur_bus_speed,
>> +                                          bus->max_bus_speed,
> 
> I don't think outputting the internal values of enum pci_bus_speed is a
> good idea. Maybe these could be printed as a string (with
> pci_speed_string()) or encoded with trace interface specific values.

I see, a human readable string is better.
> 
> Perhaps it would make sense to check if the speed really changed before
> sending that event, but there are good sides in both approaches as I
> know some platforms assert LBMS more than once during a single Link Speed
> change.
> 
>> +                                          PCI_HOTPLUG_LINK_SPEED_CHANGED);
>>
>> But I don't find link speed changed in hotplug driver
> 
> pciehp_check_link_status() calls __pcie_update_link_speed().

Thanks.

> 
>> , and the format of "Link Speed changed" is a bit different from
>> "pci_hp_event".
> 
> The difference is only because when the Link is down, there's no Link
> Speed (obviously). Whenever a new device is hotplugged and it comes up,
> there's also Link Speed for it which can be included into the trace event.
> 
> I think the trace event should have some special value for the fields that
> are N/A due to Link being off. While it would be possible to create
> separate events for speed changes and hotplug, I don't see any pros in
> that approach over just having the N/A fields marked as such when the Link
> is Down.
> 
> Perhaps it would even make sense to add PCIE_SPEED_LINK_DOWN into
> bus->cur_bus_speed when hotplug finds the card is gone (I'm not entirely
> sure how bwctrl or pcie_cooling driver would cope with that though, they
> might need minor tweaking to support it, and there are a few other drivers
> that use that field).
> 
>> Do we really need a PCI_HOTPLUG_EVENT? May PCI_LINK_EVENT is more
>> appropriate?
> 
> Ah, right, I forgot to mention it would make sense to rename it to
> PCI_LINK_EVENT.
> 

Got it.

Thanks.
Shuai

