Return-Path: <linux-pci+bounces-38064-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 842BFBDA709
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 17:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F8DB3E101A
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 15:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310093002A2;
	Tue, 14 Oct 2025 15:40:34 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A55F2DECD4;
	Tue, 14 Oct 2025 15:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760456434; cv=none; b=i3h5/xY0cyoulake8AfJGGMxEXAOtDWC5aWRuplPeoJli+VpvdmbzaxVX8Ctb9QnO8/etJvlODDyv+qoxcw4K8I24Uotq0V6hoO53BP+WepfuoUJ6PfrileXfqbxapA+RJ6dLXShlY/hn86n8T5spJLdgDTMswvm/8xQ0fsE2SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760456434; c=relaxed/simple;
	bh=BN0cRurDhQvRoxeXN8Mz3Cz2hPp/sBOtgKJbjhSJQyc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hpjS7bjarvodVR9GmsLXMGHelLbgJeyTXszjXMUQwt3m+FNyIoDj7BO/vRkIV/eqywSzRcXjHAcZnB4WNGag5XBruHNzws+yFH6VkXkbQtyV10L2/Yv0nwerobLl3ySaUTBtaHpWrZ2pV7hiyKNhcBIsiftr0xrHGYbWshLbnLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 4CF23BC054;
	Tue, 14 Oct 2025 15:40:28 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf09.hostedemail.com (Postfix) with ESMTPA id 0187020030;
	Tue, 14 Oct 2025 15:40:23 +0000 (UTC)
Date: Tue, 14 Oct 2025 11:40:29 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: lukas@wunner.de, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, helgaas@kernel.org,
 ilpo.jarvinen@linux.intel.com, mattc@purestorage.com,
 Jonathan.Cameron@huawei.com, bhelgaas@google.com, tony.luck@intel.com,
 bp@alien8.de, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 oleg@redhat.com, naveen@kernel.org, davem@davemloft.net,
 anil.s.keshavamurthy@intel.com, mark.rutland@arm.com, peterz@infradead.org,
 tianruidong@linux.alibaba.com
Subject: Re: [PATCH v12 1/3] PCI: trace: Add a generic RAS tracepoint for
 hotplug event
Message-ID: <20251014114029.4c59bb1a@gandalf.local.home>
In-Reply-To: <20251014123159.57764-2-xueshuai@linux.alibaba.com>
References: <20251014123159.57764-1-xueshuai@linux.alibaba.com>
	<20251014123159.57764-2-xueshuai@linux.alibaba.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: g3a8azz8jeckjuqkykwgg67ktcyoid1c
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 0187020030
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+56UC/0yh7pDLxktD4Ww/pF2GM3+ZNLaY=
X-HE-Tag: 1760456423-588206
X-HE-Meta: U2FsdGVkX1/qBhVcJ0onmnLBSHa++eubqrKZF2PFjqVPlCldnstYoRazugdO+YWZkIVcctGko81qhZCSs8vnLdIor1zt9/1uGNdHamW1GucCqsNS50hC3lm49cCPUBOGVx/ByTkRSapWnN5TjHsp12Wfb4Zde4RXLUdZV7uykreXujlih7Fu9V/LsRfteDpdnZkjCNUvb//ck/JjlEHNiVAledrwMO6KqBYlEpzsSCsACHSNF0AzlaWasCLCTd9EvxfIgYit2PnmZqrA9Ihp2fyHXnlvezc+TiaOljB8xpXBmIS9KJkV4ckYzuDG4DxUfmJP6AyeP+fPbKxsFRrJwH7cCH0wc94JRYrcrDPffY3o3Yad6s35a43fT5oAJPlh15LfGROEie02vnDv53MspU1+x4PcBJRiHruntzAOZDw=

On Tue, 14 Oct 2025 20:31:57 +0800
Shuai Xue <xueshuai@linux.alibaba.com> wrote:

> Hotplug events are critical indicators for analyzing hardware health,
> and surprise link downs can significantly impact system performance and
> reliability.
> 
> Define a new TRACING_SYSTEM named "pci", add a generic RAS tracepoint
> for hotplug event to help health checks. Add enum pci_hotplug_event in
> include/uapi/linux/pci.h so applications like rasdaemon can register
> tracepoint event handlers for it.
> 
> The following output is generated when a device is hotplugged:
> 
> $ echo 1 > /sys/kernel/debug/tracing/events/pci/pci_hp_event/enable
> $ cat /sys/kernel/debug/tracing/trace_pipe
>    irq/51-pciehp-88      [001] .....  1311.177459: pci_hp_event: 0000:00:02.0 slot:10, event:CARD_PRESENT
> 
>    irq/51-pciehp-88      [001] .....  1311.177566: pci_hp_event: 0000:00:02.0 slot:10, event:LINK_UP
> 
> Suggested-by: Lukas Wunner <lukas@wunner.de>
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Reviewed-by: Lukas Wunner <lukas@wunner.de>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/pci/Makefile              |  3 ++
>  drivers/pci/hotplug/pciehp_ctrl.c | 31 ++++++++++++---
>  drivers/pci/trace.c               | 11 ++++++
>  include/trace/events/pci.h        | 63 +++++++++++++++++++++++++++++++
>  include/uapi/linux/pci.h          |  7 ++++
>  5 files changed, 109 insertions(+), 6 deletions(-)
>  create mode 100644 drivers/pci/trace.c
>  create mode 100644 include/trace/events/pci.h
> 
> diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
> index 67647f1880fb..58a4e4ea76b0 100644
> --- a/drivers/pci/Makefile
> +++ b/drivers/pci/Makefile
> @@ -45,3 +45,6 @@ obj-y				+= controller/
>  obj-y				+= switch/
>  
>  subdir-ccflags-$(CONFIG_PCI_DEBUG) := -DDEBUG
> +
> +CFLAGS_trace.o := -I$(src)
> +obj-$(CONFIG_TRACING)		+= trace.o
> diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
> index bcc938d4420f..7805f697a02c 100644
> --- a/drivers/pci/hotplug/pciehp_ctrl.c
> +++ b/drivers/pci/hotplug/pciehp_ctrl.c
> @@ -19,6 +19,7 @@
>  #include <linux/types.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/pci.h>
> +#include <trace/events/pci.h>
>  
>  #include "../pci.h"
>  #include "pciehp.h"
> @@ -244,12 +245,20 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
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

I know this is v12 and I don't remember if I suggested this before and you
gave me a reason already, but why not simply pass in "ctrl" and have the
TRACE_EVENT() denote the names?

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
> @@ -269,6 +278,9 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
>  					      INDICATOR_NOOP);
>  			ctrl_info(ctrl, "Slot(%s): Card not present\n",
>  				  slot_name(ctrl));
> +			trace_pci_hp_event(pci_name(ctrl->pcie->port),
> +					   slot_name(ctrl),
> +					   PCI_HOTPLUG_CARD_NOT_PRESENT);
>  		}
>  		mutex_unlock(&ctrl->state_lock);
>  		return;
> @@ -281,12 +293,19 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
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
> diff --git a/drivers/pci/trace.c b/drivers/pci/trace.c
> new file mode 100644
> index 000000000000..cf11abca8602
> --- /dev/null
> +++ b/drivers/pci/trace.c
> @@ -0,0 +1,11 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Tracepoints for PCI system
> + *
> + * Copyright (C) 2025 Alibaba Corporation
> + */
> +
> +#include <linux/pci.h>
> +
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/pci.h>
> diff --git a/include/trace/events/pci.h b/include/trace/events/pci.h
> new file mode 100644
> index 000000000000..208609492c06
> --- /dev/null
> +++ b/include/trace/events/pci.h
> @@ -0,0 +1,63 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM pci
> +
> +#if !defined(_TRACE_HW_EVENT_PCI_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_HW_EVENT_PCI_H
> +
> +#include <linux/tracepoint.h>
> +
> +#define PCI_HOTPLUG_EVENT						\
> +	EM(PCI_HOTPLUG_LINK_UP,			"LINK_UP")		\
> +	EM(PCI_HOTPLUG_LINK_DOWN,		"LINK_DOWN")		\
> +	EM(PCI_HOTPLUG_CARD_PRESENT,		"CARD_PRESENT")		\
> +	EMe(PCI_HOTPLUG_CARD_NOT_PRESENT,	"CARD_NOT_PRESENT")
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

	TP_PROTO(struct controller *ctrl, int event),

	TP_ARGS(ctrl, event),

	TP_STRUCT__entry(
		__string(	port_name,	pci_name(ctrl->pcie->port)	)
		__string(	slot,		slot_name(ctrl)			)
		__field(	int,		event				)
	),

It would move the work out of the calling path.

-- Steve


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
> +#endif /* _TRACE_HW_EVENT_PCI_H */
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


