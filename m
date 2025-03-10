Return-Path: <linux-pci+bounces-23264-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5ACDA58AFE
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 05:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57E633A83E2
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 04:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7361B414A;
	Mon, 10 Mar 2025 04:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="u76rC6KT"
X-Original-To: linux-pci@vger.kernel.org
Received: from out199-13.us.a.mail.aliyun.com (out199-13.us.a.mail.aliyun.com [47.90.199.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3184D199FBA;
	Mon, 10 Mar 2025 04:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.199.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741579218; cv=none; b=BJ4li8xqogvj1hk9pTOSlTNPrajY1FzjdtfDkIUyzEavaB7EFRCjGSW+GSjpJtXhwh95PL9cdhnIwbYXu7Qu3HJ6T1HWHwp6ALRwVGpO7jDph0dhsixz2sFM+QN5rUuJNty8Xb1Ip/2Xe9FqzZXxUxS3pNwZ7Vf9R90bQy9YSGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741579218; c=relaxed/simple;
	bh=CROjvy/MKdJ5/RFwYmWjeYXRcyQwv00nYgwEaSCxdpg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MADYnCE1ZegzOuQ3nU3odqBVOGvTuWGRltL5Cf1GpeRDagMnUGCWNbB/coX2MZPOz29FV0sj4s5VLkRby2z9kH0r1eWK2UQgil5pM0bybVzbvWwuF0H7oGnvsapQ8xmxEVaAvXLythurWukTyudTXEkv6VjHAsPewSGPQh2O5b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=u76rC6KT; arc=none smtp.client-ip=47.90.199.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1741579199; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=uqEuDYBQyu1rVnaZ3FTs3Lz5M58Kfacepcx3ohjxnR0=;
	b=u76rC6KTa1rpdODYJkH43Wh2UFTvlbMYJneWhhFH8ZfK97tZuVxB+S3xPDU1CO2jS7OZ0fDN/Hwbs/NFmGfJNU2K+KZLZkZPBDAlmhI4Tnpqa0K4lt+7wPyZXxTX4zv3wtCww8KzP2aT/ZnVaMu1biNVgN8nL1nRAxP3S86TYgo=
Received: from 30.246.161.128(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WQym12P_1741579196 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 10 Mar 2025 11:59:57 +0800
Message-ID: <deb6f0c4-77b8-431e-9b81-555a8344c750@linux.alibaba.com>
Date: Mon, 10 Mar 2025 11:59:55 +0800
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

Hi, Steve,

If I move PCI_HOTPLUG_EVENT into one place, `include/upai/linux/pci.h`,
I need to include:

     #include <linux/tracepoint.h>

Then, kernel build fails with CONFIG_UAPI_HEADER_TEST=y:

$ make -j128
   DESCEND objtool
   CALL    scripts/checksyscalls.sh
   INSTALL libsubcmd_headers
   HDRTEST usr/include/linux/pci.h
In file included from <command-line>:32:
./usr/include/linux/pci.h:22:10: fatal error: linux/tracepoint.h: No such file or directory
    22 | #include <linux/tracepoint.h>
       |          ^~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[4]: *** [usr/include/Makefile:85: usr/include/linux/pci.hdrtest] Error 1
make[3]: *** [scripts/Makefile.build:465: usr/include] Error 2
make[2]: *** [scripts/Makefile.build:465: usr] Error 2
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/media/nvme/shawn.xs/kernels/linux/Makefile:1994: .] Error 2
make: *** [Makefile:251: __sub-make] Error 2

Do you have any objections that I reverted to this version v5?

Thanks.
Shuai

