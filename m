Return-Path: <linux-pci+bounces-19817-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B06A1182D
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 04:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 903331886963
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 03:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43CA322E3F0;
	Wed, 15 Jan 2025 03:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Z1RGllAp"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCEE15250F;
	Wed, 15 Jan 2025 03:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736913564; cv=none; b=O75EVqIQIkMQ72l4iT75rU2Gk/kOB4F8r+XefiO2x4/nkshLmdGnwDvsV468rYDH3ZmlCgyMSm7ar2ZuLiIPXbN7N2+vOsnsgl4uHCN0ggFe62IMDwVNUjgn6KImAjeyl0KITAFu6vu+/CkvHaeclGXvrMCiyjStYI50O3VKRkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736913564; c=relaxed/simple;
	bh=YSMVJrCT/K9bRLlVREyx8tgq/wp+53dMWevCY5rjL7c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WT+FaPEYQGYlMx9PCV5xbUnyIR7/q5Df8WMrcCxV/kSkqAMIc67etdW0Xs4EaA0+hofsKCig+QqkycAgJfbxTBUH4sSmNKYvcOgeiAGEXGa9x8u1U5ZY73TNTTDvukKgOSpstscFhG8RCUR8mjJ2JlLBDjyOnk5ghkmD58CxszQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Z1RGllAp; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1736913558; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=sLPV+YjmBUB7qzPZOw2oCEKHmFVeZyvMf7EqOBBlrrQ=;
	b=Z1RGllAp6JlgwNT+kR1iUYdVwdql1nnuCnHbEXG2bvnz3YEeJ44tyI0tb5adKQp32swL01W2CpoUSrZm90CPDi6ley0N+pyx0gciBb1RagaTb5XWXG4l01dkTYPyEyIh8ztajJN4DgWaEovXvgPnLB2oRm+TKyo9N0rudylFH10=
Received: from 30.246.161.230(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WNh5jLY_1736913554 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 15 Jan 2025 11:59:15 +0800
Message-ID: <7b482de1-fa19-45d6-bd05-f1c3ebb77192@linux.alibaba.com>
Date: Wed, 15 Jan 2025 11:59:13 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] PCI: hotplug: Add a generic RAS tracepoint for hotplug
 event
To: Steven Rostedt <rostedt@goodmis.org>, Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-edac@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 helgaas@kernel.org, bhelgaas@google.com, tony.luck@intel.com, bp@alien8.de,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, oleg@redhat.com,
 naveen@kernel.org, davem@davemloft.net, anil.s.keshavamurthy@intel.com,
 mark.rutland@arm.com, peterz@infradead.org, tianruidong@linux.alibaba.com
References: <20250115013753.49126-1-xueshuai@linux.alibaba.com>
 <20250114214103.6b45d30d@gandalf.local.home>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20250114214103.6b45d30d@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/1/15 10:41, Steven Rostedt 写道:
> On Wed, 15 Jan 2025 09:37:53 +0800
> Shuai Xue <xueshuai@linux.alibaba.com> wrote:
> 
>> +#define CREATE_TRACE_POINTS
>> +#include "trace.h"
>> +
>>   /* The following routines constitute the bulk of the
>>      hotplug controller logic
>>    */
>> @@ -244,12 +247,20 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
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
> Hmm, can't you just pass in the ctrl pointer to the tracepoint?
> 
> 			trace_pci_hp_event(ctrl, PCI_HOTPLUG_LINK_DOWN);
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
>> @@ -269,6 +280,9 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
>>   					      INDICATOR_NOOP);
>>   			ctrl_info(ctrl, "Slot(%s): Card not present\n",
>>   				  slot_name(ctrl));
>> +			trace_pci_hp_event(pci_name(ctrl->pcie->port),
>> +					   slot_name(ctrl),
>> +					   PCI_HOTPLUG_CARD_NOT_PRESENT);
>>   		}
>>   		mutex_unlock(&ctrl->state_lock);
>>   		return;
>> @@ -281,12 +295,19 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
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
>> diff --git a/drivers/pci/hotplug/trace.h b/drivers/pci/hotplug/trace.h
>> new file mode 100644
>> index 000000000000..1415ac505cb5
>> --- /dev/null
>> +++ b/drivers/pci/hotplug/trace.h
>> @@ -0,0 +1,45 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#if !defined(_TRACE_HW_EVENT_PCI_HP_H) || defined(TRACE_HEADER_MULTI_READ)
>> +#define _TRACE_HW_EVENT_PCI_HP_H
>> +
>> +#include <linux/tracepoint.h>
>> +
>> +#undef TRACE_SYSTEM
>> +#define TRACE_SYSTEM pci
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
> 
> Then the above would be:
> 
> 	TP_PROTO(struct controller *ctrl, int event),
> 
> // don't really need a const int there
> 
> 	TP_ARGS(ctrl, event),
> 
> 	TP_STRUCT__entry(
> 		__string(	port_name,	pci_name(ctrl->pcie->port)	)
> 		__string(	slot,		slot_name(ctrl)			)
> 		__field(	int,		event				)
> 
> and everything else could be the same.

Maybe it's not a good idea.

I think pci_hp_event is a generic event for pciehp, shpchp, octep_hp, etc. But
each hotplug driver has different `struct controller` and slot_name(). For
example:

// drivers/pci/hotplug/pciehp.h
static inline const char *slot_name(struct controller *ctrl)
{
	return hotplug_slot_name(&ctrl->hotplug_slot);
}

// drivers/pci/hotplug/shpchp.h
static inline const char *slot_name(struct slot *slot)
{
	return hotplug_slot_name(&slot->hotplug_slot);
}

So, IMHO, pass port_name and slot_name from each driver is more simple.

+ @Lukas for hotplug part.

> 
> -- Steve
> 
> 

Thanks.

Best Regards,
Shuai


