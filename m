Return-Path: <linux-pci+bounces-32337-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A132B0807B
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 00:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0ECF7AC0CA
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 22:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA95291C35;
	Wed, 16 Jul 2025 22:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bLa6uDZJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9A12857F1;
	Wed, 16 Jul 2025 22:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752704735; cv=none; b=Vi89Ek+nkTPfUhjQbLe/KuoTavxJXjnunF5nfEe9WFVOgygqz3LQi8fCDJLrULMwW0Mh777eHRA7dihE44KB8N50sAUmwDj6w5rD/rs4xDaKDk9UKI3bjbKKziy0FzFgAYG5cxojlFzzmFC1b2NQH7Z0KeEARV/ZB1fOKz5fqsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752704735; c=relaxed/simple;
	bh=b8p1yGebBghXJBd69Xqts/21wlzTMjRSUIp9WAfmGtg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=jyYVPHWL89PwecH6K91LowoTOM8EodJqf4Q7P7uV2jtadSDRhsNy1xn1Lbzu7zNuQaLX5eLKm4fpYsetOqr2S/fE0xuSxYda8MyXzYeFIHCAYxEWyBoswSUkmzXb1Axl9Pc4DjfP+dDrHGYXo4++Sgb0dHmuPlppXOEZGpGRdBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bLa6uDZJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 950FDC4CEE7;
	Wed, 16 Jul 2025 22:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752704734;
	bh=b8p1yGebBghXJBd69Xqts/21wlzTMjRSUIp9WAfmGtg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=bLa6uDZJw2dw2YRoHZuZEC1yP+RL5rzv8+TnUCg2Uh21tacQ6b1HvrQEUhwOjYwgg
	 mC624E72HRNtB8vQGOzncBEK0d0FVrGUC4b2eYeUXLZOSD5SX1uRSD+7riCQ6FiAtw
	 FmSAsFiqCecAH6Cb9qmsQKas/w+wM+eFAvvhYZpOzieQQDLCupaowiwQrTkeqO02bg
	 jd0FqxrHvZk1gyMncqry/8hYSseU9OQviSsPPzbVJRFT5ZmOkZ8z+wcZd+4OlW+pHM
	 aqBt9yJ/vMXLCDUWFWfLQce9U466WyajVpKhsKTCr6g9iBrB3KNDwwFgq6b69JpuVe
	 YVNmiRkjioaPw==
Date: Wed, 16 Jul 2025 17:25:33 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: rostedt@goodmis.org, lukas@wunner.de, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, bhelgaas@google.com,
	tony.luck@intel.com, bp@alien8.de, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, oleg@redhat.com, naveen@kernel.org,
	davem@davemloft.net, anil.s.keshavamurthy@intel.com,
	mark.rutland@arm.com, peterz@infradead.org,
	tianruidong@linux.alibaba.com,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v8] PCI: hotplug: Add a generic RAS tracepoint for
 hotplug event
Message-ID: <20250716222533.GA2559636@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250512013839.45960-1-xueshuai@linux.alibaba.com>

[+cc Ilpo, Jonathan (should have been included since the patch has his
Reviewed-by)]

Thanks for the ping; I noticed quite a bit of discussion but didn't
follow it myself, so didn't know it was basically all resolved.

On Mon, May 12, 2025 at 09:38:39AM +0800, Shuai Xue wrote:
> Hotplug events are critical indicators for analyzing hardware health,
> particularly in AI supercomputers where surprise link downs can
> significantly impact system performance and reliability.

I dropped the "particularly in AI supercomputers" part because I think
this is relevant in general.

> To this end, define a new TRACING_SYSTEM named pci, add a generic RAS
> tracepoint for hotplug event to help healthy check, and generate
> tracepoints for pcie hotplug event.

I'm not quite clear on the difference between "add generic RAS
tracepoint for hotplug event" and "generate tracepoints for pcie
hotplug event."  Are these two different things?

I see the new TRACE_EVENT(pci_hp_event, ...) definition.  Is that what
you mean by the "generic RAS tracepoint"?

And the five new trace_pci_hp_event() calls that use the TRACE_EVENT
are the "tracepoints for PCIe hotplug event"?

> Add enum pci_hotplug_event in
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

> +#define PCI_HOTPLUG_EVENT					\
> +	EM(PCI_HOTPLUG_LINK_UP,			"Link Up")	\
> +	EM(PCI_HOTPLUG_LINK_DOWN,		"Link Down")	\
> +	EM(PCI_HOTPLUG_CARD_PRESENT,		"Card present")	\
> +	EMe(PCI_HOTPLUG_CARD_NOT_PRESENT,	"Card not present")

Running this:

  $ git grep -E "\<(EM|EMe)\("

I notice that these new events don't look like the others, which
mostly look like "word" or "event-type" or "VERB object".

I'm OK with this, but just giving you a chance to consider what will
be the least surprise to users and easiest for grep and shell
scripting.

I also noticed capitalization of "Up" and "Down", but not "present"
and "not present".

"Card" is only used occasionally and informally in the PCIe spec, and
not at all in the context of hotplug of Slot Status (Presence Detect
State refers to "adapter in the slot"), but it does match the pciehp
dmesg text, so it probably makes sense to use that.

Anyway, I applied this on pci/trace for v6.17.  If there's anything
you want to tweak in the commit log or event text, we can still do
that.

  https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=trace

Bjorn

