Return-Path: <linux-pci+bounces-32586-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C28B0AE14
	for <lists+linux-pci@lfdr.de>; Sat, 19 Jul 2025 07:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 792491C26F22
	for <lists+linux-pci@lfdr.de>; Sat, 19 Jul 2025 05:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FBFF1DE4EC;
	Sat, 19 Jul 2025 05:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="gDZkaFoo"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADF22D613;
	Sat, 19 Jul 2025 05:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752902622; cv=none; b=ri/XwFUzpwQIzrTNd6zcTWOBLiV0DkPEvKodtogtLAeXlV4/hdVHJLkSiE6bpVYkjzI0zJDDMeWUSFL//+01HpNmAqCXHc40Qwus2An81nDnSHvDpCe4Nktjy3Zf1LDwpkgo49UWuT+pUkiFRDuoHek7d3jZjxB/lF4Fz1mrVGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752902622; c=relaxed/simple;
	bh=MI2vo8QTCrXjFavI9fS5sGHnyw7/jza0UllSeJXRncI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NYywcfbsHIXBfPJSWaynaLqDUlp7876cuqlTewprEhh1Hlia+iASJqdJw8PitO3W5aMcAgVlSmkk9zU7/NCcwl9A2ho7cbld+JFHKoZoHI+FwHopBmJ91ccHkPZcL/IXNd54zzbvJnewAFy/ptMe78pG5nP41v+tl9LL7j9e0M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=gDZkaFoo; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752902611; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=tfVcf8FOU7TQRACtqaGdjUDWcD+2QB3BbbNSR2PLnfw=;
	b=gDZkaFooCsEEC0AXIcpRIhVI1VK9TFdRjrAnKV5w7s7g946yvtp4e0YW+KT+W8ryu5W+8f/F9FRDANUIGYmZzG55ZOeAly22bk0zqk8fgFlqAq1xtghC1/qP67CIeafOAci/5H3EEpQYOaMLoKV4+mPxkE3PqQyhUr+WjEiTDAw=
Received: from 30.246.162.71(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WjDzJcv_1752902608 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 19 Jul 2025 13:23:30 +0800
Message-ID: <fc0ded97-8643-4faa-a606-732bcd4ce4a1@linux.alibaba.com>
Date: Sat, 19 Jul 2025 13:23:28 +0800
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
Cc: Matthew W Carlis <mattc@purestorage.com>, lukas@wunner.de,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 anil.s.keshavamurthy@intel.com, bhelgaas@google.com, bp@alien8.de,
 davem@davemloft.net, linux-edac@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, mark.rutland@arm.com,
 mathieu.desnoyers@efficios.com, mhiramat@kernel.org, naveen@kernel.org,
 oleg@redhat.com, peterz@infradead.org, rostedt@goodmis.org,
 tianruidong@linux.alibaba.com, tony.luck@intel.com
References: <20250718163532.GA2700834@bhelgaas>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20250718163532.GA2700834@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/7/19 00:35, Bjorn Helgaas 写道:
> On Fri, Jul 18, 2025 at 01:29:18PM +0800, Shuai Xue wrote:
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
>> IIUC, the current hotplug event (or presence event) is enough for Matthew.
>> and we would like a new tracepoing for link speed change which reports
>> speeds.
>>
>> For hotplug event, I plan to send a new version to
>>
>> 1. address Bjorn' concerns about event strings by removing its spaces.
>>
>> #define PCI_HOTPLUG_EVENT							\
>> 	EM(PCI_HOTPLUG_LINK_UP,			"PCI_HOTPLUG_LINK_UP")		\
>> 	EM(PCI_HOTPLUG_LINK_DOWN,		"PCI_HOTPLUG_LINK_DOWN")	\
>> 	EM(PCI_HOTPLUG_CARD_PRESENT,		"PCI_HOTPLUG_CARD_PRESENT")	\
>> 	EMe(PCI_HOTPLUG_CARD_NOT_PRESENT,	"PCI_HOTPLUG_CARD_NOT_PRESENT")
>>
>> 2. address Ilpo comments by moving pci_hp_event to a common place
>> (include/trace/events/pci.h) so that the new comming can also use it.
>>
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
> Seems good to me.
> 
> What do you plan for PCI_HOTPLUG_LINK_UP?  It would be nice to have
> the link info there since that's sort of a link speed change itself.
> 
> Bjorn

Hi, Bjorn,

IMMO, link information is best included in the pci_link_event tracepoint,
rather than in the hotplug event itself.

For example, with the a device hotpluged, the trace output looks like this:

$ cat /sys/kernel/debug/tracing/trace_pipe

            <...>-120     [002] .....   104.864051: pci_hp_event: 0000:00:03.0 slot:30, event:PCI_HOTPLUG_CARD_PRESENT

            <...>-120     [002] .....   104.864081: pci_hp_event: 0000:00:03.0 slot:30, event:PCI_HOTPLUG_LINK_UP

    irq/57-pciehp-120     [002] .....   104.990434: pci_link_event: 0000:00:03.0 cur_bus_speed:20, max_bus_speed:23, width:1, flit_mode:0, reason:5

    irq/57-pciehp-120     [002] .....   104.992377: pci_link_event: 0000:00:03.0 cur_bus_speed:20, max_bus_speed:23, width:1, flit_mode:0, reason:0

Here, reason 5 corresponds to PCIe hotplug, and reason 0 indicates a PCIe link retrain.

This approach keeps the separation of concerns clear: hotplug events are
tracked by pci_hp_event, while all link-related information, including
speed changes and the reason for the change, is handled by
pci_link_event.

Thanks.
Shuai

