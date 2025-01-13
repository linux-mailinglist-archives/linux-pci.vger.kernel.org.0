Return-Path: <linux-pci+bounces-19690-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7932A0C2CF
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jan 2025 21:55:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81EF43A6AAD
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jan 2025 20:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466901CD1E4;
	Mon, 13 Jan 2025 20:55:07 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCEB1C3038;
	Mon, 13 Jan 2025 20:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736801707; cv=none; b=CPISBkXK30ak+SzGFl22Hk2YrOLaNEFiznWTTyRqKfEynI646TXnWqpVmDxwYoSxIQMxhzFg6FViQh20rTHloSV9gyKOI0OFS1zCK2RNsMQlUi5yrD4N11KEFOERK5SZj1UTrBfLc33Ym1axx8c8BV99HcwcluHWqZsIoBUoT/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736801707; c=relaxed/simple;
	bh=6bMWu777N3S6Mqw6qsW3g6f/h0LX2c+kc+7vAg5rOD4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EtpD2I27O7i/Ye+mOAiED6HYLQymwmoLG5loCduIuuV0RjrzzN/xpH3W6PxR+KSfBcjqfm35A9Tgyx4lrnlUyuAj3aC8lceFFDiRoh/GCvIzWo479szlkwc03lWdTkBQkU9LMfA+YOwtRStO61oaHZO6OqY+tnAJfJtMqSBPzKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2BFCC4CEDD;
	Mon, 13 Jan 2025 20:55:04 +0000 (UTC)
Date: Mon, 13 Jan 2025 15:55:03 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: lukas@wunner.de, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, helgaas@kernel.org,
 bhelgaas@google.com, tony.luck@intel.com, bp@alien8.de,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, oleg@redhat.com,
 naveen@kernel.org, davem@davemloft.net, anil.s.keshavamurthy@intel.com,
 mark.rutland@arm.com, peterz@infradead.org, tianruidong@linux.alibaba.com
Subject: Re: [PATCH v5] PCI: hotplug: Add a generic RAS tracepoint for
 hotplug event
Message-ID: <20250113155503.71467082@gandalf.local.home>
In-Reply-To: <20250109025543.56830-1-xueshuai@linux.alibaba.com>
References: <20250109025543.56830-1-xueshuai@linux.alibaba.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  9 Jan 2025 10:55:43 +0800
Shuai Xue <xueshuai@linux.alibaba.com> wrote:

> diff --git a/drivers/pci/hotplug/trace.h b/drivers/pci/hotplug/trace.h
> new file mode 100644
> index 000000000000..5b60cd7bcffb
> --- /dev/null
> +++ b/drivers/pci/hotplug/trace.h
> @@ -0,0 +1,68 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#if !defined(_TRACE_HW_EVENT_PCI_HP_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_HW_EVENT_PCI_HP_H
> +
> +#include <linux/tracepoint.h>
> +
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM pci
> +
> +#define PCI_HOTPLUG_EVENT					\
> +	EM(PCI_HOTPLUG_LINK_UP,			"Link Up")	\
> +	EM(PCI_HOTPLUG_LINK_DOWN,		"Link Down")	\
> +	EM(PCI_HOTPLUG_CARD_PRESENT,		"Card present")	\
> +	EMe(PCI_HOTPLUG_CARD_NOT_PRESENT,	"Card not present")

Since you are creating these enums in this patch, you can also do a
shortcut here too. Instead of doing the define here, move it to
include/uapi/linux/pci.h:

> +
> +/* Enums require being exported to userspace, for user tool parsing */
> +#undef EM
> +#undef EMe
> +#define EM(a, b)	TRACE_DEFINE_ENUM(a);
> +#define EMe(a, b)	TRACE_DEFINE_ENUM(a);
> +
> +PCI_HOTPLUG_EVENT
> +
> +/*
> + * Now redefine the EM() and EMe() macros to map the enums to the strings
> + * that will be printed in the output.
> + */
> +#undef EM
> +#undef EMe
> +#define EM(a, b)	{a, b},
> +#define EMe(a, b)	{a, b}
> +
> +TRACE_EVENT(pci_hp_event,
> +
> +	TP_PROTO(const char *port_name,
> +		 const char *slot,
> +		 const int event),
> +
> +	TP_ARGS(port_name, slot, event),
> +
> +	TP_STRUCT__entry(
> +		__string(	port_name,	port_name	)
> +		__string(	slot,		slot		)
> +		__field(	int,		event	)
> +	),
> +
> +	TP_fast_assign(
> +		__assign_str(port_name);
> +		__assign_str(slot);
> +		__entry->event = event;
> +	),
> +
> +	TP_printk("%s slot:%s, event:%s\n",
> +		__get_str(port_name),
> +		__get_str(slot),
> +		__print_symbolic(__entry->event, PCI_HOTPLUG_EVENT)
> +	)
> +);
> +
> +#endif /* _TRACE_HW_EVENT_PCI_HP_H */
> +
> +#undef TRACE_INCLUDE_PATH
> +#define TRACE_INCLUDE_PATH  ../../drivers/pci/hotplug
> +#undef TRACE_INCLUDE_FILE
> +#define TRACE_INCLUDE_FILE trace
> +
> +/* This part must be outside protection */
> +#include <trace/define_trace.h>
> diff --git a/include/uapi/linux/pci.h b/include/uapi/linux/pci.h
> index a769eefc5139..4f150028965d 100644
> --- a/include/uapi/linux/pci.h
> +++ b/include/uapi/linux/pci.h
> @@ -39,4 +39,11 @@
>  #define PCIIOC_MMAP_IS_MEM	(PCIIOC_BASE | 0x02)	/* Set mmap state to MEM space. */
>  #define PCIIOC_WRITE_COMBINE	(PCIIOC_BASE | 0x03)	/* Enable/disable write-combining. */
>  
> +enum pci_hotplug_event {
> +	PCI_HOTPLUG_LINK_UP,
> +	PCI_HOTPLUG_LINK_DOWN,
> +	PCI_HOTPLUG_CARD_PRESENT,
> +	PCI_HOTPLUG_CARD_NOT_PRESENT,
> +};

Instead of defining the enum as you did above, if you have the define of
the enums here, you could do:

#define PCI_HOTPLUG_EVENT					\
	EM(PCI_HOTPLUG_LINK_UP,			"Link Up")	\
	EM(PCI_HOTPLUG_LINK_DOWN,		"Link Down")	\
	EM(PCI_HOTPLUG_CARD_PRESENT,		"Card present")	\
	EMe(PCI_HOTPLUG_CARD_NOT_PRESENT,	"Card not present")

#undef EM
#undef EMe
#define EM(a, b)	a,
#define EMe(a, b)	a,

enum pci_hotplug_event {
	PCI_HOTPLUG_EVENT
};

Then you only have one place to worry about adding new enums ;-)

-- Steve

> +
>  #endif /* _UAPILINUX_PCI_H */


