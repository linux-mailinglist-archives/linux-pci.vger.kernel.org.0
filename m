Return-Path: <linux-pci+bounces-32629-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B626DB0BF76
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 10:55:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E34547A2E47
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 08:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB68928152D;
	Mon, 21 Jul 2025 08:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y6Xw41Ih"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F1FA94A;
	Mon, 21 Jul 2025 08:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753088124; cv=none; b=uzoUHA0Qhn/C+FalEKjpfBydbj+xTb4yc6R1WFw3PWEUqmkced5TBIWMXrYnDFokAOXV6efLz1NlcmiQHMzrLlmTcFl/mE9ROIN/9pYWYZ/78TnqYAmk2a9nM0ZR7PLTBqiFquzGL7rwKJ17BshcZb1GCMwmOCOAOwEINTDlwhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753088124; c=relaxed/simple;
	bh=ZCj8HMh45XjsLbv8p4FzdSDZ689KnYroF28qfUNPefw=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=cBOEO126VOL+j4AbHGeQOSZQeXwlybP8D/cx1YruhKW749ZhFHgCNQU0BiI5e9XVyTp+FZ7W2bg+pXK00ViNJUTp/vmyMQSTztYTTkLMnKw2XqvjfkoVh0V1CQpaqnykrt3QQcAjZuwbPO8uz3kRGbHwrFpfwSIhAtjH+EG9fLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y6Xw41Ih; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753088124; x=1784624124;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=ZCj8HMh45XjsLbv8p4FzdSDZ689KnYroF28qfUNPefw=;
  b=Y6Xw41IhrIIo3AYrd3kgflhTJcIiz8Z6abjfFljtcOrOwR3r/P4rzwGl
   39gMH2VbU4GMNNtnr0PSKakxf5OKf9aP44k58Af6JhDRX2wvQ0RaWuj8F
   SIp9Xj7NbEBmN7/JIT6xlWAwnO1z91JKgh1ikI5H4u3KjITeDksqEEXYP
   f8Itm6PvEOfnA7Tzph/d0gXrhtVtGGKX0bu4kCdQra4WZBnH+H2KQrbt7
   1flPzsZrBgKDWOCAbV7zuoprERMNA4b4S3qjaLqkkTYg1G9Z6tEwkratp
   orKu1MpoXfIItwdnQsNERI3hpJp+Qc8HeXE4+DbMBF+35RYnisrS9sdUJ
   w==;
X-CSE-ConnectionGUID: O8eOHtLkT0Cg6//7O5l5vg==
X-CSE-MsgGUID: Dlm8PZaqTPqVoPR6cg85eg==
X-IronPort-AV: E=McAfee;i="6800,10657,11498"; a="72753179"
X-IronPort-AV: E=Sophos;i="6.16,328,1744095600"; 
   d="scan'208";a="72753179"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 01:55:23 -0700
X-CSE-ConnectionGUID: wmzktg8hTwum2UHfB71QFA==
X-CSE-MsgGUID: ddWZrynlTCCg0R++sfN1Tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,328,1744095600"; 
   d="scan'208";a="159218388"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.225])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 01:55:15 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 21 Jul 2025 11:55:11 +0300 (EEST)
To: Shuai Xue <xueshuai@linux.alibaba.com>, Bjorn Helgaas <helgaas@kernel.org>, 
    rostedt@goodmis.org, mhiramat@kernel.org
cc: Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, linux-edac@vger.kernel.org, 
    linux-trace-kernel@vger.kernel.org, bhelgaas@google.com, 
    tony.luck@intel.com, bp@alien8.de, mathieu.desnoyers@efficios.com, 
    oleg@redhat.com, naveen@kernel.org, davem@davemloft.net, 
    anil.s.keshavamurthy@intel.com, mark.rutland@arm.com, peterz@infradead.org, 
    tianruidong@linux.alibaba.com, 
    Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v8] PCI: hotplug: Add a generic RAS tracepoint for hotplug
 event
In-Reply-To: <2687d27d-09ed-429d-9ec7-463c69a3fff7@linux.alibaba.com>
Message-ID: <14b7660b-e74f-1361-aa01-c255434a9cfd@linux.intel.com>
References: <20250716222533.GA2559636@bhelgaas> <2687d27d-09ed-429d-9ec7-463c69a3fff7@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-551479686-1753088028=:945"
Content-ID: <6f119ac0-cdae-7733-ba5f-82cdc02ccf82@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-551479686-1753088028=:945
Content-Type: text/plain; CHARSET=ISO-2022-JP
Content-ID: <8212cd1e-1050-4996-81a9-bf40a5f48f14@linux.intel.com>

Steven or other tracing people, can you check below the 
discussion/question on preferred placement of the tracing 
related code.

On Thu, 17 Jul 2025, Shuai Xue wrote:
> 在 2025/7/17 06:25, Bjorn Helgaas 写道:
> > [+cc Ilpo, Jonathan (should have been included since the patch has his
> > Reviewed-by)]
> > 
> 
> Thanks.
> 
> > Thanks for the ping; I noticed quite a bit of discussion but didn't
> > follow it myself, so didn't know it was basically all resolved.

The biggest remaining uncertainty related to the placement of some of the 
tracepoint code (tracepoint creation and the trace header). None of us 
knew the answer so we tried to ask a more informed opinion from others but 
that never resulted us getting any answer.

I've a patch which adds tracing to bwctrl [1] (I'll send it officially 
once the placement discussion concludes), and in it, I ended up adding 
drivers/pci/pci-trace.c as the place where to define the tracepoints and 
include/trace/events/pci.h as the trace header placement, whereas this 
patch added them both into the hp driver code.

So if you (Bjorn) are fine placing them into each individual driver as 
done in this patch and tracing folks don't provide us guidance, we can 
go with that approach.

The placement discussion is in this subleaf of the thread:

https://lore.kernel.org/linux-pci/c0cbdd85-9702-40ab-bc97-b51b02b9fc89@linux.alibaba.com/


[1] https://lore.kernel.org/linux-pci/7c289bba-3133-0989-6333-41fc41fe3504@linux.intel.com/1-a.txt

-- 
 i.

> > On Mon, May 12, 2025 at 09:38:39AM +0800, Shuai Xue wrote:
> > > Hotplug events are critical indicators for analyzing hardware health,
> > > particularly in AI supercomputers where surprise link downs can
> > > significantly impact system performance and reliability.
> > 
> > I dropped the "particularly in AI supercomputers" part because I think
> > this is relevant in general.
> > 
> > > To this end, define a new TRACING_SYSTEM named pci, add a generic RAS
> > > tracepoint for hotplug event to help healthy check, and generate
> > > tracepoints for pcie hotplug event.
> > 
> > I'm not quite clear on the difference between "add generic RAS
> > tracepoint for hotplug event" and "generate tracepoints for pcie
> > hotplug event."  Are these two different things?
> 
> The purpose of this patch is to address the lack of tracepoints for PCIe
> hotplug events in our production environment. In the initial RFC
> version, I defined tracepoints such as "Link Up" and "Link Down"
> specifically for PCIe hotplug. Later, Lukas suggested that these
> tracepoints could be made more generic so that other PCI hotplug drivers
> could also use them.
> 
> That’s why, when defining the event, I used a "generic" pci_hotplug_event
> instead of a pcie_hotplug_event. If you're interested in more details
> about this discussion, please refer to this link[1].
> 
> [1]https://erol.kernel.org/linux-pci/git/0/commit/?id=0ffd56f572f25bcd6c2265a1863848a18dce0e29
> 
> However, currently only PCIe hotplug is using these tracepoints, which
> is why the CREATE_TRACE_POINTS macro is placed in
> drivers/pci/hotplug/pciehp_ctrl.c.
> 
> > 
> > I see the new TRACE_EVENT(pci_hp_event, ...) definition.  Is that what
> > you mean by the "generic RAS tracepoint"?
> 
> Yes.
> 
> 
> > 
> > And the five new trace_pci_hp_event() calls that use the TRACE_EVENT
> > are the "tracepoints for PCIe hotplug event"?
> 
> Actually, the tracepoints are generic, although right now they are only
> used for PCIe hotplug.
> 
> > 
> > > Add enum pci_hotplug_event in
> > > include/uapi/linux/pci.h so applications like rasdaemon can register
> > > tracepoint event handlers for it.
> > > 
> > > The output like below:
> > > 
> > > $ echo 1 > /sys/kernel/debug/tracing/events/pci/pci_hp_event/enable
> > > $ cat /sys/kernel/debug/tracing/trace_pipe
> > >      <...>-206     [001] .....    40.373870: pci_hp_event: 0000:00:02.0
> > > slot:10, event:Link Down
> > > 
> > >      <...>-206     [001] .....    40.374871: pci_hp_event: 0000:00:02.0
> > > slot:10, event:Card not present
> > 
> > > +#define PCI_HOTPLUG_EVENT					\
> > > +	EM(PCI_HOTPLUG_LINK_UP,			"Link Up")	\
> > > +	EM(PCI_HOTPLUG_LINK_DOWN,		"Link Down")	\
> > > +	EM(PCI_HOTPLUG_CARD_PRESENT,		"Card present")	\
> > > +	EMe(PCI_HOTPLUG_CARD_NOT_PRESENT,	"Card not present")
> > 
> > Running this:
> > 
> >    $ git grep -E "\<(EM|EMe)\("
> > 
> > I notice that these new events don't look like the others, which
> > mostly look like "word" or "event-type" or "VERB object".
> > 
> > I'm OK with this, but just giving you a chance to consider what will
> > be the least surprise to users and easiest for grep and shell
> > scripting.
> 
> I think this is also common. For example, MF_PAGE_TYPE for
> memory_failure_event uses a similar format:
> 
> #define MF_PAGE_TYPE \
> 	EM ( MF_MSG_KERNEL, "reserved kernel page" ) \
> 	EM ( MF_MSG_KERNEL_HIGH_ORDER, "high-order kernel page" )
> 
> 
> and aer_uncorrectable_errors for aer_event:
> 
> #define aer_uncorrectable_errors				\
> 	{PCI_ERR_UNC_UND,	"Undefined"},			\
> 	{PCI_ERR_UNC_DLP,	"Data Link Protocol Error"},	\
> 	{PCI_ERR_UNC_SURPDN,	"Surprise Down Error"},		\
> 	{PCI_ERR_UNC_POISON_TLP,"Poisoned TLP"},
> 
> > 
> > I also noticed capitalization of "Up" and "Down", but not "present"
> > and "not present".
> 
> Aha, this is a bit tricky:)
> 
> The original kernel log messages are not consistent either:
> 
> ctrl_info(ctrl, "Slot(%s): Link Down\n",
> ctrl_info(ctrl, "Slot(%s): Card not present\n",
> 
> I tried to keep the output as close as possible to the existing log
> messages. If you prefer a more consistent capitalization style, I can
> send another patch to fix that.
> 
> 
> > 
> > "Card" is only used occasionally and informally in the PCIe spec, and
> > not at all in the context of hotplug of Slot Status (Presence Detect
> > State refers to "adapter in the slot"), but it does match the pciehp
> > dmesg text, so it probably makes sense to use that.
> > 
> > Anyway, I applied this on pci/trace for v6.17.  If there's anything
> > you want to tweak in the commit log or event text, we can still do
> > that.
> > 
> >    https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=trace
> > 
> > Bjorn
> 
> Thank you again for applying this to pci/trace for v6.17. If there’s
> anything more to tweak in the commit log or event text, please let me
> know.
> 
> Best regards,
> 
> Shuai
> 
--8323328-551479686-1753088028=:945--

