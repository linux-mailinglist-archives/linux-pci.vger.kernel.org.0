Return-Path: <linux-pci+bounces-19399-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 257E7A03DB7
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 12:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 959C118869DD
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 11:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D621E1C07;
	Tue,  7 Jan 2025 11:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="riGqL69e"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1479E1EBA08;
	Tue,  7 Jan 2025 11:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736249439; cv=none; b=b9DBO3kTzOX7DKDNmWOI9ZEGQfPrER2BCnWgm534QroubC7gKztl5pEQoV4V+4LXvoHF8L3miRh+0OXy23oFsPchQ2XWZTrAIemAIfmh5LcEdkEnVbb5inqoK+m+HxD0olCabQj254S3Tq2LzbiGmYGNVzgi62m3Oak5NGsDYRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736249439; c=relaxed/simple;
	bh=VX9WvdEJFXQTEHRk2/R6Oxi/92xLP9iKJUH5SQHEypE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KmIV9zpAHYH2mWnU0DROc5HjlQsjgVsYGl4SNpA228EbUEP6SBJ6T4YyVU8Mlghxy7OoawwM38RC5aGJFR0oDmRG2df5JXD2fP8h/HDc96kiA2gTEGS4uB3wE+o8Z6OFEAAGcmR8fwuHLzlG9X9gOj76UmcnGBDH+NTYiKdjvSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=riGqL69e; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1736249431; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=r674C5QUpJ5epP+RP012uB6HOOActU7Qt8c/PmN0ng0=;
	b=riGqL69euH1PPgoYGEjvd09ZBET2iLqHtOkZcvfdLAMGfep9yvhY1z4/813JBV8mdKbxBkwPtT8Hk1JWC5LdotE2SDfW8hgGnT9NnyhAOp87gmLpLTBXw0RFTmgUIW3BUywQa1hpoCSdopSjzR1sXg1vXDmfZ08YfQzmyPJsCXQ=
Received: from 30.246.161.230(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WNATaL-_1736249428 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 07 Jan 2025 19:30:29 +0800
Message-ID: <f77669b5-c174-48c7-8f0f-187d1f54ea91@linux.alibaba.com>
Date: Tue, 7 Jan 2025 19:30:28 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] PCI: hotplug: Add a generic RAS tracepoint for hotplug
 event
To: Lukas Wunner <lukas@wunner.de>
Cc: bhelgaas@google.com, tony.luck@intel.com, bp@alien8.de,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, oleg@redhat.com,
 naveen@kernel.org, davem@davemloft.net, anil.s.keshavamurthy@intel.com,
 mark.rutland@arm.com, peterz@infradead.org, rostedt@goodmis.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-edac@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20241123113108.29722-1-xueshuai@linux.alibaba.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20241123113108.29722-1-xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/11/23 19:31, Shuai Xue 写道:
> Hotplug events are critical indicators for analyzing hardware health,
> particularly in AI supercomputers where surprise link downs can
> significantly impact system performance and reliability. The failure
> characterization analysis illustrates the significance of failures
> caused by the Infiniband link errors. Meta observes that 2% in a machine
> learning cluster and 6% in a vision application cluster of Infiniband
> failures co-occur with GPU failures, such as falling off the bus, which
> may indicate a correlation with PCIe.[1]
> 
> To this end, define a new TRACING_SYSTEM named pci, add a generic RAS
> tracepoint for hotplug event to help healthy check, and generate
> tracepoints for pcie hotplug event. To monitor these tracepoints in
> userspace, e.g. with rasdaemon, put `enum pci_hotplug_event` in uapi
> header.
> 
> The output like below:
> $ echo 1 > /sys/kernel/debug/tracing/events/pci/pci_hp_event/enable
> $ cat /sys/kernel/debug/tracing/trace_pipe
>             <...>-206     [001] .....    40.373870: pci_hp_event: 0000:00:02.0 slot:10, event:Link Down
> 
>             <...>-206     [001] .....    40.374871: pci_hp_event: 0000:00:02.0 slot:10, event:Card not present
> 
> [1]https://arxiv.org/abs/2410.21680
> 
> Suggested-by: Lukas Wunner <lukas@wunner.de>
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Reviewed-by: Lukas Wunner <lukas@wunner.de>
> ---
> changes sincel v3:
> - rename TRACING_SYSTEM from pci_hotplug to pci
> - add Reviewed-by tag from Lukas
> - add Suggested-by tag from Lukas and Steven
> ---
>   drivers/pci/hotplug/pciehp_ctrl.c | 33 ++++++++++++---
>   drivers/pci/hotplug/trace.h       | 68 +++++++++++++++++++++++++++++++
>   include/uapi/linux/pci.h          |  7 ++++
>   3 files changed, 102 insertions(+), 6 deletions(-)
>   create mode 100644 drivers/pci/hotplug/trace.h
> 
> diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
> index dcdbfcf404dd..c836462ff067 100644
> --- a/drivers/pci/hotplug/pciehp_ctrl.c
> +++ b/drivers/pci/hotplug/pciehp_ctrl.c
> @@ -21,6 +21,9 @@
>   #include <linux/pci.h>
>   #include "pciehp.h"
>   
> +#define CREATE_TRACE_POINTS
> +#include "trace.h"
> +
>   /* The following routines constitute the bulk of the
>      hotplug controller logic
>    */
> @@ -239,12 +242,20 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
>   	case ON_STATE:
>   		ctrl->state = POWEROFF_STATE;
>   		mutex_unlock(&ctrl->state_lock);
> -		if (events & PCI_EXP_SLTSTA_DLLSC)
> +		if (events & PCI_EXP_SLTSTA_DLLSC) {
>   			ctrl_info(ctrl, "Slot(%s): Link Down\n",
>   				  slot_name(ctrl));
> -		if (events & PCI_EXP_SLTSTA_PDC)
> +			trace_pci_hp_event(pci_name(ctrl->pcie->port),
> +					   slot_name(ctrl),
> +					   PCI_HOTPLUG_LINK_DOWN);
> +		}
> +		if (events & PCI_EXP_SLTSTA_PDC) {
>   			ctrl_info(ctrl, "Slot(%s): Card not present\n",
>   				  slot_name(ctrl));
> +			trace_pci_hp_event(pci_name(ctrl->pcie->port),
> +					   slot_name(ctrl),
> +					   PCI_HOTPLUG_CARD_NOT_PRESENT);
> +		}
>   		pciehp_disable_slot(ctrl, SURPRISE_REMOVAL);
>   		break;
>   	default:
> @@ -264,6 +275,9 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
>   					      INDICATOR_NOOP);
>   			ctrl_info(ctrl, "Slot(%s): Card not present\n",
>   				  slot_name(ctrl));
> +			trace_pci_hp_event(pci_name(ctrl->pcie->port),
> +					   slot_name(ctrl),
> +					   PCI_HOTPLUG_CARD_NOT_PRESENT);
>   		}
>   		mutex_unlock(&ctrl->state_lock);
>   		return;
> @@ -276,12 +290,19 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
>   	case OFF_STATE:
>   		ctrl->state = POWERON_STATE;
>   		mutex_unlock(&ctrl->state_lock);
> -		if (present)
> +		if (present) {
>   			ctrl_info(ctrl, "Slot(%s): Card present\n",
>   				  slot_name(ctrl));
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
>   		ctrl->request_result = pciehp_enable_slot(ctrl);
>   		break;
>   	default:
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
>   #define PCIIOC_MMAP_IS_MEM	(PCIIOC_BASE | 0x02)	/* Set mmap state to MEM space. */
>   #define PCIIOC_WRITE_COMBINE	(PCIIOC_BASE | 0x03)	/* Enable/disable write-combining. */
>   
> +enum pci_hotplug_event {
> +	PCI_HOTPLUG_LINK_UP,
> +	PCI_HOTPLUG_LINK_DOWN,
> +	PCI_HOTPLUG_CARD_PRESENT,
> +	PCI_HOTPLUG_CARD_NOT_PRESENT,
> +};
> +
>   #endif /* _UAPILINUX_PCI_H */

Hi, Lukas,

I hope you're doing well.

I would like to inquire that if there are any further actions required from my
end to proceed for this patch?

Additionally, I would appreciate if you could inform me about who will be
pick up this patch.

Thank you.

Best Regards,
Shuai

