Return-Path: <linux-pci+bounces-19727-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78420A105D0
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 12:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34F613A3B52
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 11:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D47B1ADC60;
	Tue, 14 Jan 2025 11:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="fJ6C6Gjd"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707E9234CE0;
	Tue, 14 Jan 2025 11:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736855265; cv=none; b=dvS+ofN+u/UNpEPQStdPfbjB+D8iyCb6y5JS6MgjAayFeCUt3979BzDpCqKe48RwmqzcicSyyQ/SOYE8R5P8dJ6TECBjquaC1TB8c5fHcJlYG4vq5qCv1pD4xPr49QM4NL2nDTRM7OsMfYRsEaqxajltJVMF94+eGfj7LnKbw2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736855265; c=relaxed/simple;
	bh=4tAwsFeqnGlo7hrHXLcMASY1gmPfNgzKJ7nzcdo4WQI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=etILWN0MDBNwpggrz8ss/wpislsf0dX7hDhoBocGRS0bfS58dJU5GabpEgyxOidvrMj1NPT5Qo7OTlA/LUO57x+pbJaJdlbMxcuk5SOgLW/dmuYbBlUWfX0UoO7CGpw1mp49hRIzqATnfvD8SXQU1m/oqwTeOfpVdYDpnl0G+y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=fJ6C6Gjd; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1736855253; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Rbo5LYY+2tH8hjW2dw93X1Z+DEEm32sPT0fjtGGAcWw=;
	b=fJ6C6GjdUkBvYhUN3Qb6hYHDvgirOryrENLEq0ClDjZ8poWFRE+z6/kdJj6LYc8mptw903W4jKxe3/ovJ3iJqUdyq3Ejq3QxecJ1V0kIIQyMQzmxnS54VFY8MjADf/hCis/1LKqcPA376JEXfA2HgiR9YV1GU939/w4I0Qol6Gw=
Received: from 30.246.161.230(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WNfDxEn_1736855182 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 14 Jan 2025 19:47:32 +0800
Message-ID: <fbee3b88-3a7c-48a6-9d79-570251237a9c@linux.alibaba.com>
Date: Tue, 14 Jan 2025 19:47:30 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] PCI: hotplug: Add a generic RAS tracepoint for hotplug
 event
To: Steven Rostedt <rostedt@goodmis.org>
Cc: lukas@wunner.de, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-edac@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 helgaas@kernel.org, bhelgaas@google.com, tony.luck@intel.com, bp@alien8.de,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, oleg@redhat.com,
 naveen@kernel.org, davem@davemloft.net, anil.s.keshavamurthy@intel.com,
 mark.rutland@arm.com, peterz@infradead.org, tianruidong@linux.alibaba.com
References: <20250109025543.56830-1-xueshuai@linux.alibaba.com>
 <20250113155503.71467082@gandalf.local.home>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20250113155503.71467082@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/1/14 04:55, Steven Rostedt 写道:
> On Thu,  9 Jan 2025 10:55:43 +0800
> Shuai Xue <xueshuai@linux.alibaba.com> wrote:
> 
>> diff --git a/drivers/pci/hotplug/trace.h b/drivers/pci/hotplug/trace.h
>> new file mode 100644
>> index 000000000000..5b60cd7bcffb
>> --- /dev/null
>> +++ b/drivers/pci/hotplug/trace.h
>> @@ -0,0 +1,68 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#if !defined(_TRACE_HW_EVENT_PCI_HP_H) || defined(TRACE_HEADER_MULTI_READ)
>> +#define _TRACE_HW_EVENT_PCI_HP_H
>> +
>> +#include <linux/tracepoint.h>
>> +
>> +#undef TRACE_SYSTEM
>> +#define TRACE_SYSTEM pci
>> +
>> +#define PCI_HOTPLUG_EVENT					\
>> +	EM(PCI_HOTPLUG_LINK_UP,			"Link Up")	\
>> +	EM(PCI_HOTPLUG_LINK_DOWN,		"Link Down")	\
>> +	EM(PCI_HOTPLUG_CARD_PRESENT,		"Card present")	\
>> +	EMe(PCI_HOTPLUG_CARD_NOT_PRESENT,	"Card not present")
> 
> Since you are creating these enums in this patch, you can also do a
> shortcut here too. Instead of doing the define here, move it to
> include/uapi/linux/pci.h:
> 
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
>> +
>> +	TP_fast_assign(
>> +		__assign_str(port_name);
>> +		__assign_str(slot);
>> +		__entry->event = event;
>> +	),
>> +
>> +	TP_printk("%s slot:%s, event:%s\n",
>> +		__get_str(port_name),
>> +		__get_str(slot),
>> +		__print_symbolic(__entry->event, PCI_HOTPLUG_EVENT)
>> +	)
>> +);
>> +
>> +#endif /* _TRACE_HW_EVENT_PCI_HP_H */
>> +
>> +#undef TRACE_INCLUDE_PATH
>> +#define TRACE_INCLUDE_PATH  ../../drivers/pci/hotplug
>> +#undef TRACE_INCLUDE_FILE
>> +#define TRACE_INCLUDE_FILE trace
>> +
>> +/* This part must be outside protection */
>> +#include <trace/define_trace.h>
>> diff --git a/include/uapi/linux/pci.h b/include/uapi/linux/pci.h
>> index a769eefc5139..4f150028965d 100644
>> --- a/include/uapi/linux/pci.h
>> +++ b/include/uapi/linux/pci.h
>> @@ -39,4 +39,11 @@
>>   #define PCIIOC_MMAP_IS_MEM	(PCIIOC_BASE | 0x02)	/* Set mmap state to MEM space. */
>>   #define PCIIOC_WRITE_COMBINE	(PCIIOC_BASE | 0x03)	/* Enable/disable write-combining. */
>>   
>> +enum pci_hotplug_event {
>> +	PCI_HOTPLUG_LINK_UP,
>> +	PCI_HOTPLUG_LINK_DOWN,
>> +	PCI_HOTPLUG_CARD_PRESENT,
>> +	PCI_HOTPLUG_CARD_NOT_PRESENT,
>> +};
> 
> Instead of defining the enum as you did above, if you have the define of
> the enums here, you could do:
> 
> #define PCI_HOTPLUG_EVENT					\
> 	EM(PCI_HOTPLUG_LINK_UP,			"Link Up")	\
> 	EM(PCI_HOTPLUG_LINK_DOWN,		"Link Down")	\
> 	EM(PCI_HOTPLUG_CARD_PRESENT,		"Card present")	\
> 	EMe(PCI_HOTPLUG_CARD_NOT_PRESENT,	"Card not present")
> 
> #undef EM
> #undef EMe
> #define EM(a, b)	a,
> #define EMe(a, b)	a,
> 
> enum pci_hotplug_event {
> 	PCI_HOTPLUG_EVENT
> };
> 
> Then you only have one place to worry about adding new enums ;-)

Will do.


> 
> -- Steve
> 

Thanks for valuable comments.

Best Regards,
Shuai


