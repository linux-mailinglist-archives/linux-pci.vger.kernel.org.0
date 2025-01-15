Return-Path: <linux-pci+bounces-19812-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EBDDA11764
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 03:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 564AF167D9A
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 02:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF8922E3F1;
	Wed, 15 Jan 2025 02:41:05 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF96022DFBD;
	Wed, 15 Jan 2025 02:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736908865; cv=none; b=enQjb7VPGl76UVtZKb5NCBJGT4yZbU0IboweevHLVFcq8XvBJYc9wwD2Rsz5Bs4Kn5HxRqorOOzQJNdfAzmN5FacBK/5gYBvo4GLkF3aoIUhYU236Wx0e1tCCjya9ICllHvsbztuqmJqKpNQrrdF/dWlW5ZYIll/jtjNA6vmwbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736908865; c=relaxed/simple;
	bh=0i4i5AR6EKnFcI8ynzDn8NozpqizG1CnJGcPxIm9I9E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CSjHxneB/cpcQRP9eCqCAopHnLmx72w0Mbl9sHdw4FIrIcwiqzZQBHtP41FZfBSXeC/M1zFP16CGaXsGknK9NQxfYQ5dnFK5nRyhiAY1TvyADZWfNJPG/biJUHgbI8wGB3Klf2tkaF8PSgboljLbJELelIgcvLXRH6CMsN0TEEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68205C4CEDD;
	Wed, 15 Jan 2025 02:41:02 +0000 (UTC)
Date: Tue, 14 Jan 2025 21:41:03 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: lukas@wunner.de, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, helgaas@kernel.org,
 bhelgaas@google.com, tony.luck@intel.com, bp@alien8.de,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, oleg@redhat.com,
 naveen@kernel.org, davem@davemloft.net, anil.s.keshavamurthy@intel.com,
 mark.rutland@arm.com, peterz@infradead.org, tianruidong@linux.alibaba.com
Subject: Re: [PATCH v6] PCI: hotplug: Add a generic RAS tracepoint for
 hotplug event
Message-ID: <20250114214103.6b45d30d@gandalf.local.home>
In-Reply-To: <20250115013753.49126-1-xueshuai@linux.alibaba.com>
References: <20250115013753.49126-1-xueshuai@linux.alibaba.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 15 Jan 2025 09:37:53 +0800
Shuai Xue <xueshuai@linux.alibaba.com> wrote:

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

Hmm, can't you just pass in the ctrl pointer to the tracepoint?

			trace_pci_hp_event(ctrl, PCI_HOTPLUG_LINK_DOWN);

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
> index 000000000000..1415ac505cb5
> --- /dev/null
> +++ b/drivers/pci/hotplug/trace.h
> @@ -0,0 +1,45 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#if !defined(_TRACE_HW_EVENT_PCI_HP_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_HW_EVENT_PCI_HP_H
> +
> +#include <linux/tracepoint.h>
> +
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM pci
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

Then the above would be:

	TP_PROTO(struct controller *ctrl, int event),

// don't really need a const int there

	TP_ARGS(ctrl, event),

	TP_STRUCT__entry(
		__string(	port_name,	pci_name(ctrl->pcie->port)	)
		__string(	slot,		slot_name(ctrl)			)
		__field(	int,		event				)

and everything else could be the same.

-- Steve


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

