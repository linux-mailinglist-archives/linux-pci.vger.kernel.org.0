Return-Path: <linux-pci+bounces-28002-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA8CABC53E
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 19:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F4F44A08B9
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 17:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4DFD288514;
	Mon, 19 May 2025 17:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="grTTUBit"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEE01E9B21;
	Mon, 19 May 2025 17:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747674648; cv=none; b=LGZcg9Yjl8YJo/t6dQdhP/m/XztuQtvB1Q0D2u/J1iLUKkZMoVEX4DVX9Etf5KT5ohLG6PnCzBRLm/9yrsTGbacrpzpe6W0B1ccYJlZqmyD03M05Mlzxgr7SJV0+rxLXy82+DCNEpl95NQfNhlnAIctk5jbLEz8JAwCTDqklSNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747674648; c=relaxed/simple;
	bh=jBJnRwW6I+AEyq4e/HnFfARoLiRBaG6k41aGuf3ZfsA=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=kKiyEvtFtLbUadlesLWmTLVhC30+loAkRR1y3+wldTN/SA4T1T0GRFYlH0ELo9CvGRsIT/iTKuPxoaIZdI9wKQIFp2arvqlJZk8/0e/sGUDK/tkMPtWP0xNwFI2zEIuvRAate7rUIO6lcSBm4nk+qoQLSKwrP3C0tJkoEwm8FBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=grTTUBit; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747674647; x=1779210647;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=jBJnRwW6I+AEyq4e/HnFfARoLiRBaG6k41aGuf3ZfsA=;
  b=grTTUBitXHsklyZTIzA3wSU4HpYhwQMA4pjFTdZFzC9wMd+7d6NlZ2NV
   eBsvkKbSLzUwPMCRiC9RMMaaE/wiigHuBfd9qH0gaQ+owRVeQ41c88yrl
   ZgzsXNtAZG2COlgx3oPPo0Ku6LM85MjcQvMdDLJOw2hAxf0A7mLbf7Jjm
   U9OdFhjs0qjMt9ERVYqpVCHgn1x1Sy+TL8s5sZ3R15tskod0ckCeYm/nr
   ldxRKcOVkTMj7wkX6tc+gdQj/hpRA7PhIqCEZFJ3V9t/msMGxvIN5ShZV
   C9iK4XHaJPnmBu+mfClIbmlY4wRoVqO/mcQjS1c7vuSjw/uuh6jFHPa0H
   w==;
X-CSE-ConnectionGUID: EbUjfgEFQvaQdKhLMWY1ww==
X-CSE-MsgGUID: fN675RE8RBq6XqCAD3C6UA==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="66997930"
X-IronPort-AV: E=Sophos;i="6.15,301,1739865600"; 
   d="scan'208";a="66997930"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 10:10:46 -0700
X-CSE-ConnectionGUID: dSAdntPZT7O3jx7uAhBjhA==
X-CSE-MsgGUID: Qy6G2AgZRPKFB0xBse1OrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,301,1739865600"; 
   d="scan'208";a="139315745"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.35])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 10:10:40 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 19 May 2025 20:10:37 +0300 (EEST)
To: Shuai Xue <xueshuai@linux.alibaba.com>
cc: rostedt@goodmis.org, Lukas Wunner <lukas@wunner.de>, 
    linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    linux-edac@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
    helgaas@kernel.org, bhelgaas@google.com, tony.luck@intel.com, bp@alien8.de, 
    mhiramat@kernel.org, mathieu.desnoyers@efficios.com, oleg@redhat.com, 
    naveen@kernel.org, davem@davemloft.net, anil.s.keshavamurthy@intel.com, 
    mark.rutland@arm.com, peterz@infradead.org, tianruidong@linux.alibaba.com
Subject: Re: [PATCH v8] PCI: hotplug: Add a generic RAS tracepoint for hotplug
 event
In-Reply-To: <20250512013839.45960-1-xueshuai@linux.alibaba.com>
Message-ID: <87b1f8c6-bd72-b1a8-40a6-bbf552552806@linux.intel.com>
References: <20250512013839.45960-1-xueshuai@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 12 May 2025, Shuai Xue wrote:

> Hotplug events are critical indicators for analyzing hardware health,
> particularly in AI supercomputers where surprise link downs can
> significantly impact system performance and reliability.
> 
> To this end, define a new TRACING_SYSTEM named pci, add a generic RAS
> tracepoint for hotplug event to help healthy check, and generate
> tracepoints for pcie hotplug event. Add enum pci_hotplug_event in
> include/uapi/linux/pci.h so applications like rasdaemon can register
> tracepoint event handlers for it.
> 
> The output like below:
> 
> $ echo 1 > /sys/kernel/debug/tracing/events/pci/pci_hp_event/enable
> $ cat /sys/kernel/debug/tracing/trace_pipe
>     <...>-206     [001] .....    40.373870: pci_hp_event: 0000:00:02.0 slot:10, event:Link Down
> 
>     <...>-206     [001] .....    40.374871: pci_hp_event: 0000:00:02.0 slot:10, event:Card not present
> 
> Suggested-by: Lukas Wunner <lukas@wunner.de>
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Reviewed-by: Lukas Wunner <lukas@wunner.de>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
> changes since v7:
> - replace the TRACE_INCLUDE_PATH to avoid macro conflict per Steven
> - pick up Reviewed-by from Lukas Wunner
> ---
>  drivers/pci/hotplug/Makefile      |  3 ++
>  drivers/pci/hotplug/pciehp_ctrl.c | 33 ++++++++++++---
>  drivers/pci/hotplug/trace.h       | 68 +++++++++++++++++++++++++++++++
>  include/uapi/linux/pci.h          |  7 ++++
>  4 files changed, 105 insertions(+), 6 deletions(-)
>  create mode 100644 drivers/pci/hotplug/trace.h
> 
> diff --git a/drivers/pci/hotplug/Makefile b/drivers/pci/hotplug/Makefile
> index 40aaf31fe338..a1a9d1e98962 100644
> --- a/drivers/pci/hotplug/Makefile
> +++ b/drivers/pci/hotplug/Makefile
> @@ -3,6 +3,9 @@
>  # Makefile for the Linux kernel pci hotplug controller drivers.
>  #
>  
> +# define_trace.h needs to know how to find our header
> +CFLAGS_pciehp_ctrl.o				:= -I$(src)
> +
>  obj-$(CONFIG_HOTPLUG_PCI)		+= pci_hotplug.o
>  obj-$(CONFIG_HOTPLUG_PCI_COMPAQ)	+= cpqphp.o
>  obj-$(CONFIG_HOTPLUG_PCI_IBM)		+= ibmphp.o
> diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
> index d603a7aa7483..f9beb4d3a9b8 100644
> --- a/drivers/pci/hotplug/pciehp_ctrl.c
> +++ b/drivers/pci/hotplug/pciehp_ctrl.c
> @@ -23,6 +23,9 @@
>  #include "../pci.h"
>  #include "pciehp.h"
>  
> +#define CREATE_TRACE_POINTS
> +#include "trace.h"
> +
>  /* The following routines constitute the bulk of the
>     hotplug controller logic
>   */
> @@ -244,12 +247,20 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
>  	case ON_STATE:
>  		ctrl->state = POWEROFF_STATE;
>  		mutex_unlock(&ctrl->state_lock);
> -		if (events & PCI_EXP_SLTSTA_DLLSC)
> +		if (events & PCI_EXP_SLTSTA_DLLSC) {
>  			ctrl_info(ctrl, "Slot(%s): Link Down\n",
>  				  slot_name(ctrl));
> -		if (events & PCI_EXP_SLTSTA_PDC)
> +			trace_pci_hp_event(pci_name(ctrl->pcie->port),
> +					   slot_name(ctrl),
> +					   PCI_HOTPLUG_LINK_DOWN);
> +		}
> +		if (events & PCI_EXP_SLTSTA_PDC) {
>  			ctrl_info(ctrl, "Slot(%s): Card not present\n",
>  				  slot_name(ctrl));
> +			trace_pci_hp_event(pci_name(ctrl->pcie->port),
> +					   slot_name(ctrl),
> +					   PCI_HOTPLUG_CARD_NOT_PRESENT);
> +		}
>  		pciehp_disable_slot(ctrl, SURPRISE_REMOVAL);
>  		break;
>  	default:
> @@ -269,6 +280,9 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
>  					      INDICATOR_NOOP);
>  			ctrl_info(ctrl, "Slot(%s): Card not present\n",
>  				  slot_name(ctrl));
> +			trace_pci_hp_event(pci_name(ctrl->pcie->port),
> +					   slot_name(ctrl),
> +					   PCI_HOTPLUG_CARD_NOT_PRESENT);
>  		}
>  		mutex_unlock(&ctrl->state_lock);
>  		return;
> @@ -281,12 +295,19 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
>  	case OFF_STATE:
>  		ctrl->state = POWERON_STATE;
>  		mutex_unlock(&ctrl->state_lock);
> -		if (present)
> +		if (present) {
>  			ctrl_info(ctrl, "Slot(%s): Card present\n",
>  				  slot_name(ctrl));
> -		if (link_active)
> -			ctrl_info(ctrl, "Slot(%s): Link Up\n",
> -				  slot_name(ctrl));
> +			trace_pci_hp_event(pci_name(ctrl->pcie->port),
> +					   slot_name(ctrl),
> +					   PCI_HOTPLUG_CARD_PRESENT);
> +		}
> +		if (link_active) {
> +			ctrl_info(ctrl, "Slot(%s): Link Up\n", slot_name(ctrl));
> +			trace_pci_hp_event(pci_name(ctrl->pcie->port),
> +					   slot_name(ctrl),
> +					   PCI_HOTPLUG_LINK_UP);
> +		}
>  		ctrl->request_result = pciehp_enable_slot(ctrl);
>  		break;
>  	default:
> diff --git a/drivers/pci/hotplug/trace.h b/drivers/pci/hotplug/trace.h
> new file mode 100644
> index 000000000000..21329c198019
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

Hi,

While I was thinking of adding tracing into PCIe BW controller (bwctrl), 
I ended up thinking that perhaps it would make more sense to have PCIe 
Link related tracepoints which would cover both hotplug and bwctrl so that 
also Link Speed changes would be reported through the same trace event.

Downgraded speed may indicate there's something wrong with the card and 
the Link Speed does have performance impact too for those who are pushing 
BW boundaries such as AI systems.

So my suggestion is:

- Add "Link Speed changed" to the event types.
- Add Link Speed and Width into the event format (and probably also Flit 
  mode as PCIe gen6 is coming).

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
> +#define TRACE_INCLUDE_PATH .
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
> +
>  #endif /* _UAPILINUX_PCI_H */
> 

-- 
 i.


