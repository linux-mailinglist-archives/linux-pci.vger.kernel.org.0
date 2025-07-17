Return-Path: <linux-pci+bounces-32350-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FBF9B08473
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 08:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1828C3A75F0
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 06:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A081FDE14;
	Thu, 17 Jul 2025 06:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Uw5rHiZP"
X-Original-To: linux-pci@vger.kernel.org
Received: from out199-8.us.a.mail.aliyun.com (out199-8.us.a.mail.aliyun.com [47.90.199.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3881B28E7;
	Thu, 17 Jul 2025 06:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.199.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752732043; cv=none; b=IScMWWr6UOmWJ+0zqENqsCusZIbAL1TyFuHdo0/EUYSWNFxNkow1P++j+F2JGKjSux0xMXFsosxCc2fFUxWiZzShaQUaDIXyFsh4aXbAPhUt2U+oUpuXzfbo2KQsg3sa5/s2kd2vulgcVd3hFrsSGbvkBVHmqDwF2W638brDGMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752732043; c=relaxed/simple;
	bh=U0T6Bu3tjl8ID5ejFptgFvM7VZPyHrQIU0QciKVcYMo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s6qsF4sBIxDeOA3H2I5jnnbhk2n46D4MsH5W8qLiBH+llxg1uH7l52dNDcNIsE/lej5HF4bcmqLS2yQK5WJpflfFt/9PlY04qR7TxPvt0hgrMEDl4Ned881ExYdFcAp9R/R8Vn4CsFJ8gb7EXSERAc0TSlT+BWdfuWEsKXTXCM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Uw5rHiZP; arc=none smtp.client-ip=47.90.199.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752732017; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=6AjoES+phDjQlU6QcJ6LgfMU4/uIlwyP6l9QIPe7StE=;
	b=Uw5rHiZPNgV0Zv7W1gSji8PdSiYwXz4DgOaJEOHrp3c7h1trRyg9MvbiOhOwQJb44fpw3+YDTtv1tNO4EJvl/luWSjQbjVIfLDM/eUiVNSD+Hax5CTJN7OrhWLjmfGnPcCCF9aSZuEnmolbf0HA/O1DDKTiX1Y7Skxb1Ok6P5g8=
Received: from 30.246.162.71(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Wj7.qAb_1752732014 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 17 Jul 2025 14:00:15 +0800
Message-ID: <2687d27d-09ed-429d-9ec7-463c69a3fff7@linux.alibaba.com>
Date: Thu, 17 Jul 2025 14:00:14 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8] PCI: hotplug: Add a generic RAS tracepoint for hotplug
 event
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: rostedt@goodmis.org, lukas@wunner.de, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bhelgaas@google.com,
 tony.luck@intel.com, bp@alien8.de, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, oleg@redhat.com, naveen@kernel.org,
 davem@davemloft.net, anil.s.keshavamurthy@intel.com, mark.rutland@arm.com,
 peterz@infradead.org, tianruidong@linux.alibaba.com,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250716222533.GA2559636@bhelgaas>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20250716222533.GA2559636@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/7/17 06:25, Bjorn Helgaas 写道:
> [+cc Ilpo, Jonathan (should have been included since the patch has his
> Reviewed-by)]
> 

Thanks.

> Thanks for the ping; I noticed quite a bit of discussion but didn't
> follow it myself, so didn't know it was basically all resolved.
> 
> On Mon, May 12, 2025 at 09:38:39AM +0800, Shuai Xue wrote:
>> Hotplug events are critical indicators for analyzing hardware health,
>> particularly in AI supercomputers where surprise link downs can
>> significantly impact system performance and reliability.
> 
> I dropped the "particularly in AI supercomputers" part because I think
> this is relevant in general.
> 
>> To this end, define a new TRACING_SYSTEM named pci, add a generic RAS
>> tracepoint for hotplug event to help healthy check, and generate
>> tracepoints for pcie hotplug event.
> 
> I'm not quite clear on the difference between "add generic RAS
> tracepoint for hotplug event" and "generate tracepoints for pcie
> hotplug event."  Are these two different things?

The purpose of this patch is to address the lack of tracepoints for PCIe
hotplug events in our production environment. In the initial RFC
version, I defined tracepoints such as "Link Up" and "Link Down"
specifically for PCIe hotplug. Later, Lukas suggested that these
tracepoints could be made more generic so that other PCI hotplug drivers
could also use them.

That’s why, when defining the event, I used a "generic" pci_hotplug_event
instead of a pcie_hotplug_event. If you're interested in more details
about this discussion, please refer to this link[1].

[1]https://erol.kernel.org/linux-pci/git/0/commit/?id=0ffd56f572f25bcd6c2265a1863848a18dce0e29

However, currently only PCIe hotplug is using these tracepoints, which
is why the CREATE_TRACE_POINTS macro is placed in
drivers/pci/hotplug/pciehp_ctrl.c.

> 
> I see the new TRACE_EVENT(pci_hp_event, ...) definition.  Is that what
> you mean by the "generic RAS tracepoint"?

Yes.


> 
> And the five new trace_pci_hp_event() calls that use the TRACE_EVENT
> are the "tracepoints for PCIe hotplug event"?

Actually, the tracepoints are generic, although right now they are only
used for PCIe hotplug.

> 
>> Add enum pci_hotplug_event in
>> include/uapi/linux/pci.h so applications like rasdaemon can register
>> tracepoint event handlers for it.
>>
>> The output like below:
>>
>> $ echo 1 > /sys/kernel/debug/tracing/events/pci/pci_hp_event/enable
>> $ cat /sys/kernel/debug/tracing/trace_pipe
>>      <...>-206     [001] .....    40.373870: pci_hp_event: 0000:00:02.0 slot:10, event:Link Down
>>
>>      <...>-206     [001] .....    40.374871: pci_hp_event: 0000:00:02.0 slot:10, event:Card not present
> 
>> +#define PCI_HOTPLUG_EVENT					\
>> +	EM(PCI_HOTPLUG_LINK_UP,			"Link Up")	\
>> +	EM(PCI_HOTPLUG_LINK_DOWN,		"Link Down")	\
>> +	EM(PCI_HOTPLUG_CARD_PRESENT,		"Card present")	\
>> +	EMe(PCI_HOTPLUG_CARD_NOT_PRESENT,	"Card not present")
> 
> Running this:
> 
>    $ git grep -E "\<(EM|EMe)\("
> 
> I notice that these new events don't look like the others, which
> mostly look like "word" or "event-type" or "VERB object".
> 
> I'm OK with this, but just giving you a chance to consider what will
> be the least surprise to users and easiest for grep and shell
> scripting.

I think this is also common. For example, MF_PAGE_TYPE for
memory_failure_event uses a similar format:

#define MF_PAGE_TYPE \
	EM ( MF_MSG_KERNEL, "reserved kernel page" ) \
	EM ( MF_MSG_KERNEL_HIGH_ORDER, "high-order kernel page" )


and aer_uncorrectable_errors for aer_event:

#define aer_uncorrectable_errors				\
	{PCI_ERR_UNC_UND,	"Undefined"},			\
	{PCI_ERR_UNC_DLP,	"Data Link Protocol Error"},	\
	{PCI_ERR_UNC_SURPDN,	"Surprise Down Error"},		\
	{PCI_ERR_UNC_POISON_TLP,"Poisoned TLP"},

> 
> I also noticed capitalization of "Up" and "Down", but not "present"
> and "not present".

Aha, this is a bit tricky:)

The original kernel log messages are not consistent either:

ctrl_info(ctrl, "Slot(%s): Link Down\n",
ctrl_info(ctrl, "Slot(%s): Card not present\n",

I tried to keep the output as close as possible to the existing log
messages. If you prefer a more consistent capitalization style, I can
send another patch to fix that.


> 
> "Card" is only used occasionally and informally in the PCIe spec, and
> not at all in the context of hotplug of Slot Status (Presence Detect
> State refers to "adapter in the slot"), but it does match the pciehp
> dmesg text, so it probably makes sense to use that.
> 
> Anyway, I applied this on pci/trace for v6.17.  If there's anything
> you want to tweak in the commit log or event text, we can still do
> that.
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=trace
> 
> Bjorn

Thank you again for applying this to pci/trace for v6.17. If there’s
anything more to tweak in the commit log or event text, please let me
know.

Best regards,

Shuai

