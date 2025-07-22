Return-Path: <linux-pci+bounces-32693-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E4AB0CFD4
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 04:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C78B6C5B5B
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 02:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9156E1E25EB;
	Tue, 22 Jul 2025 02:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="V/UTAvpF"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AFF1DE8A0;
	Tue, 22 Jul 2025 02:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753152220; cv=none; b=h41xPanxPaGh7agLrpDjh5Gx8SxYKTB1xoWrwYLA63fwLJQYOWUIFUIKJtaSBtJakB3eUpYJ8IH8mjc3Gf3aK4ovvoP5MNJh4qbkIysIFmyq4HT+X9kFqAGIegVIYctC9d/miMGi5IUrfUoL4Rr3X7Rg0JgI2cIymr0qIrDmmDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753152220; c=relaxed/simple;
	bh=TpfBpPjtQ1TIVKcfvIOgBenSM0Z5cK8+wHNXEIxdfG8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VTU7wVOK0ZBYCkxvUsSPUVfxZC3nVvKYm3pli8TJ5MLfxJIebCSQecq9GtZ7/ui+zkiQZdhyKEZr+4JfywucinUILgxevEg+zb8rdCotnhYw69DXDcCn1jWrRcCu00Da3wappoLfuSylPpbxfS1j5OQWseeiUalxJlqNVncV4r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=V/UTAvpF; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1753152212; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=PSvOwAd8F8NSw1DU5J+G8+UcmSTgRBwFglVhweOlEgw=;
	b=V/UTAvpFe22i21zs9tTZmyYoSpShw+oar2ObjnVEodRkRiyZZnYn7OWtw1wBXQIm/kM4punfgLSInLhEs/S6eHeZdNCA/6ZdPP3pzLGMWHsp6nhR50nVkkdH516xfrBZNjtduW/vU99xpADxSKGgzFW+CjhVYa79SeUb9eK9+uI=
Received: from 30.246.160.95(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WjTqfLr_1753152209 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 22 Jul 2025 10:43:30 +0800
Message-ID: <fcfc51c0-6a1f-435b-844b-4daba132f7b6@linux.alibaba.com>
Date: Tue, 22 Jul 2025 10:43:29 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8] PCI: hotplug: Add a generic RAS tracepoinggt for
 hotplug event
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Matthew W Carlis <mattc@purestorage.com>, helgaas@kernel.org,
 Lukas Wunner <lukas@wunner.de>, anil.s.keshavamurthy@intel.com,
 bhelgaas@google.com, bp@alien8.de, davem@davemloft.net,
 linux-edac@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 linux-pci@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 mark.rutland@arm.com, mathieu.desnoyers@efficios.com, mhiramat@kernel.org,
 naveen@kernel.org, oleg@redhat.com, peterz@infradead.org,
 rostedt@goodmis.org, tianruidong@linux.alibaba.com, tony.luck@intel.com
References: <20250717235055.GA2664149@bhelgaas>
 <20250718034616.26250-1-mattc@purestorage.com>
 <e92f8d1f-457c-4248-8397-81b0e20ff4af@linux.alibaba.com>
 <11119800-3b6a-a683-3500-115a057c2826@linux.intel.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <11119800-3b6a-a683-3500-115a057c2826@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/7/21 18:18, Ilpo Järvinen 写道:
> On Fri, 18 Jul 2025, Shuai Xue wrote:
>> 在 2025/7/18 11:46, Matthew W Carlis 写道:
>>> On Thu, Jul 17, 2025 Bjorn Helgaas wrote
>>>> So I think your idea of adding current link speed/width to the "Link
>>>> Up" event is still on the table, and that does sound useful to me.
>>>
>>> We're already reading the link status register here to check DLLA so
>>> it would be nice. I guess if everything is healthy we're probably already
>>> at the maximum speed by this point.
>>>
>>>> In the future we might add another tracepoint when we enumerate the
>>>> device and know the Vendor/Device ID.
>>>
>>> I think we might have someone who would be interested in doing it.
>>
>>
>> Hi, all,
>>
>> IIUC, the current hotplug event (or presence event) is enough for Matthew.
>> and we would like a new tracepoing for link speed change which reports
>> speeds.
>>
>> For hotplug event, I plan to send a new version to
>>
>> 1. address Bjorn' concerns about event strings by removing its spaces.
>>
>> #define PCI_HOTPLUG_EVENT
>> \
>> 	EM(PCI_HOTPLUG_LINK_UP,			"PCI_HOTPLUG_LINK_UP")
>> \
>> 	EM(PCI_HOTPLUG_LINK_DOWN,		"PCI_HOTPLUG_LINK_DOWN")
>> \
>> 	EM(PCI_HOTPLUG_CARD_PRESENT,		"PCI_HOTPLUG_CARD_PRESENT")
>> \
>> 	EMe(PCI_HOTPLUG_CARD_NOT_PRESENT,
>> "PCI_HOTPLUG_CARD_NOT_PRESENT")
>>
>> 2. address Ilpo comments by moving pci_hp_event to a common place
>> (include/trace/events/pci.h) so that the new comming can also use it.
> 
> Ah, I only now noticed you've decided to re-place them. Please disregard
> my other comment about this being still open/undecided item.
> 
>> For link speed change event (perhaps named as pci_link_event),
>> I plan to send a seperate patch, which provides:
>>
>> 	TP_STRUCT__entry(
>> 		__string(	port_name,	port_name	)
>> 		__field(	unsigned char,	cur_bus_speed	)
>> 		__field(	unsigned char,	max_bus_speed	)
>>   		__field(	unsigned char,	width		)
>>   		__field(	unsigned int,	flit_mode	)
>> 		__field(	unsigned char,	reason		)
>> 		),
>>
>> The reason field is from Lukas ideas which indicates why the link speed
>> changed, e.g. "hotplug", "autonomous", "thermal", "retrain", etc.
>>
>> Are you happy with above changes?
> 
> Since you're probably quite far with the pcie link event patch too given
> above, could you take a look at the LNKSTA flags representation in my
> patch and incorporate those as well as there seems to always lot of
> uncertainty about those flags when investigating the LBMS/bwctrl related
> issues so it seems prudent to explicitly include them into the traceevent
> output:
> 
> https://lore.kernel.org/linux-pci/7c289bba-3133-0989-6333-41fc41fe3504@linux.intel.com/
> 
> 

Sure, Thank you for the feedback.

I like the LNKSTA flags, LNKSTA flags provides better genericity
compared to the custom reason field I initially proposed. But it may
cause confusion when used in pcie_retrain_link(). However, I've
identified a potential issue when this approach is applied in
pcie_retrain_link() scenarios.

Consider the following trace output when a device hotpluged:

$ cat /sys/kernel/debug/tracing/trace_pipe
$ cat /sys/kernel/debug/tracing/trace_pipe
            <...>-118     [002] .....    28.414220: pci_hp_event: 0000:00:03.0 slot:30, event:PCI_HOTPLUG_CARD_PRESENT

            <...>-118     [002] .....    28.414273: pci_hp_event: 0000:00:03.0 slot:30, event:PCI_HOTPLUG_LINK_UP

    irq/57-pciehp-118     [002] .....    28.540189: pcie_link_event: 0000:00:03.0 type:4, cur_bus_speed:2.5 GT/s PCIe, max_bus_speed:16.0 GT/s PCIe, width:1, flit_mode:0, status:DLLLA

    irq/57-pciehp-118     [002] .....    28.544999: pcie_link_event: 0000:00:03.0 type:4, cur_bus_speed:2.5 GT/s PCIe, max_bus_speed:16.0 GT/s PCIe, width:1, flit_mode:0, status:DLLLA

The problem is that both trace events show status:DLLLA (Data Link Layer
Link Active), which is the direct reading from PCI_EXP_LNKSTA. However,
this doesn't accurately reflect the underlying context:

- First DLLLA: Triggered by board_added() - link establishment after
   card insertion
- Second DLLLA: Triggered by pcie_retrain_link() - link retraining
   completion

( I trace the events in pcie_update_link_speed() )

In the second case, the more relevant status would be PCI_EXP_LNKSTA_LT
(Link Training) to indicate that link retraining was performed, even
though the final register state shows DLLLA.

Question: Should we explicitly report the contextual status (e.g.,
PCI_EXP_LNKSTA_LT for retraining scenarios) rather than always reading
the current register field? This would provide more meaningful trace
information for debugging link state transitions.

Additionally, I'd appreciate your thoughts on the overall tracepoint
format shown above. Does this structure provide sufficient information
for hotplug and link analysis while maintaining readability?

Thanks.
Shuai

