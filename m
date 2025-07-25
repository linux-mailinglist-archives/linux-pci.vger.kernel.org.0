Return-Path: <linux-pci+bounces-32909-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6EE4B1164B
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jul 2025 04:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A41B3AD6B9
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jul 2025 02:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FAF12264DB;
	Fri, 25 Jul 2025 02:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="GmLIjHgL"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F61615E90;
	Fri, 25 Jul 2025 02:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753409805; cv=none; b=bH0sn3lsNPfHJqpa9OBBdbcrHs9StIJnFPxP32E8f7IJJZ8FYHLsxumZ3zuJCpQtb2601sY+X8tAudO8Y6FS9mM9JXEUQGKdUa/+yrJ1nkk1df6CDQxByVDfIEY1vWfmxs5DcXBIZiuxjZ/8dBpfSG9hAJItMy2QWZt9g/Gkw1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753409805; c=relaxed/simple;
	bh=jklrWlvZSAvEwya4WHpogsJH90OlBTNToR0j1DSs7Vk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SxLqDna6IVlWRpwnfBzAngUxWztVqDkmNmP+QDRiecVdPyVaIx1361skGtrdT7saGtktm6OVGc6xNg1pKXtbN2Qx4FWmuvVvuU5cRAAwe18bbhhzgQiuGZWt0MSa1OKX6qisftjW0YeCgojo6Fs+Wfmy2HuQaOPmzeNjK0Jr1u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=GmLIjHgL; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1753409799; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=yrZolcLcXQ859KBYYZrptDVW8HUiOnYUEc53nlnfK7Q=;
	b=GmLIjHgL0f93AvReQ7B3gtuwf7luLF2xVKStKljM1byAf3IyFPtgyvI+O5MpEhjO6Kkish9Wm8DVA6EbLJxDNqDLaQp4RYhPeBhDBbXmj0gjhRtau1SwbtmN39XBT8qQVQHYghUI14OyJudIRRj0ZJrxmC0ArnlKGRBzUZBYiQw=
Received: from 30.246.181.19(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WjuuK8u_1753409471 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 25 Jul 2025 10:11:12 +0800
Message-ID: <0611d06d-e198-4617-a0ba-3050ca6191c6@linux.alibaba.com>
Date: Fri, 25 Jul 2025 10:11:10 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 2/2] PCI: trace: Add a RAS tracepoint to monitor link
 speed changes
To: Steven Rostedt <rostedt@goodmis.org>
Cc: lukas@wunner.de, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-edac@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 helgaas@kernel.org, ilpo.jarvinen@linux.intel.com, mattc@purestorage.com,
 Jonathan.Cameron@huawei.com, bhelgaas@google.com, tony.luck@intel.com,
 bp@alien8.de, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 oleg@redhat.com, naveen@kernel.org, davem@davemloft.net,
 anil.s.keshavamurthy@intel.com, mark.rutland@arm.com, peterz@infradead.org,
 tianruidong@linux.alibaba.com
References: <20250723033108.61587-1-xueshuai@linux.alibaba.com>
 <20250723033108.61587-3-xueshuai@linux.alibaba.com>
 <20250723100559.7f0adb3c@batman.local.home>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20250723100559.7f0adb3c@batman.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi, Steve

在 2025/7/23 22:05, Steven Rostedt 写道:
> On Wed, 23 Jul 2025 11:31:08 +0800
> Shuai Xue <xueshuai@linux.alibaba.com> wrote:
> 
>> +	TP_printk("%s type:%d, reason:%d, cur_bus_speed:%s, max_bus_speed:%s, width:%u, flit_mode:%u, status:%s\n",
>> +		__get_str(port_name),
>> +		__entry->type,
>> +		__entry->reason,
>> +		pci_speed_string(__entry->cur_bus_speed),
>> +		pci_speed_string(__entry->max_bus_speed),
> 
> Hmm, I guess pci_speed_string() should be added to libtraceveent so
> that perf and trace-cmd parses it correctly. I guess rasdaemon would
> want that too (which also uses libtraceevent).

Thank you for pointing this out. You're absolutely right that
pci_speed_string() should be properly handled in libtraceevent for
better userspace tool support.

$ cat /sys/kernel/debug/tracing/trace_pipe

    irq/57-pciehp-119     [002] .....   125.904335: pcie_link_event: 0000:00:03.0 type:4, reason:4, cur_bus_speed:2.5 GT/s PCIe, max_bus_speed:16.0 GT/s PCIe, width:1, flit_mode:0, status:DLLLA

    irq/57-pciehp-119     [002] .....   125.907051: pcie_link_event: 0000:00:03.0 type:4, reason:0, cur_bus_speed:2.5 GT/s PCIe, max_bus_speed:16.0 GT/s PCIe, width:1, flit_mode:0, status:DLLLA

Compared with debug/tracing, perf trace used the raw event field, and
the speed is not handman readable.

$ perf trace -e pci:pcie_link_event
      0.000 irq/57-pciehp/121 pci:pcie_link_event(port_name: "0000:00:03.0", type: 4, reason: 4, cur_bus_speed: 20, max_bus_speed: 23, width: 1, link_status: 8192)
      4.058 irq/57-pciehp/121 pci:pcie_link_event(port_name: "0000:00:03.0", type: 4, cur_bus_speed: 20, max_bus_speed: 23, width: 1, link_status: 8192)

I see a couple of options here:

1. Keep the current approach and add libtraceevent support as follow-up
work. The tracepoint would still be functional, but userspace tools
would show raw speed values instead of formatted strings until
libtraceevent is updated.

2. Use raw values in the tracepoint for now (e.g., store speed as
integer) and let userspace tools handle the formatting. This would avoid
the immediate dependency on libtraceevent updates.

3. Address both kernel and userspace in coordinated patch set.

Which approach would you prefer? If you think option1 is acceptable, I'm
happy to work on the libtraceevent changes as a follow-up.
Alternatively, if you'd prefer option 2, I can modify the tracepoint to
use raw values. And if you perfer opiton 3, I will also include a new
patch 3 to add a plugin helper for libtraceevent.


For the libtraceevent implementation, I believe we'd
need to:

- Add the PCI speed mapping table to libtraceevent
- Create a print function similar to other existing parsers
- Ensure perf, trace-cmd, and rasdaemon can all benefit from it

Would you like me to investigate the libtraceevent changes, or do you
have other suggestions for the approach?

Thanks again for the feedback.

Best regards,
Shuai


> 
> -- Steve
> 
> 
>> +		__entry->width,
>> +		__entry->flit_mode,
>> +		__print_flags((unsigned long)__entry->link_status, "|",
>> +				LNKSTA_FLAGS)
>> +	)
>> +);

