Return-Path: <linux-pci+bounces-42875-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A88CB1AF7
	for <lists+linux-pci@lfdr.de>; Wed, 10 Dec 2025 02:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 83F90300DC9B
	for <lists+linux-pci@lfdr.de>; Wed, 10 Dec 2025 01:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B484F230BCB;
	Wed, 10 Dec 2025 01:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="jeaPulwT"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7611C69D;
	Wed, 10 Dec 2025 01:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765331830; cv=none; b=Vnh7WCeMhP20rwSpgN47mdFtJEYUVZYsoc4Mz/n+AW3oU5V9HXtQs/2xFltsv5/k5IZK3lqY2Ysp24jIwI6556y6ma9NRl8xOT/F1Nsu1sTlzm99z3FXpjMfyUcy3IQ3WBbMmVtdiEdMHm8NO/MGqpPZxhUPhZhlQ//vdabEVJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765331830; c=relaxed/simple;
	bh=5rH7IgBTUWLfbXuzHWMxUNkJDXl/l9ZHm+5diuybFy0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cfD2igK32yeJSXxnfWyUD6SIrKfmptoprsu79aSdp+vxfVWS9zWpYRsIiyWRx5XmIUANnxKaHB3oFrnVr8Efksjzodq7BKyJjwnKYNJjfC8zsWUpjRsGxpCX+OrwvYuiCQ+NN8DBjVjV/Q9fByb6coc+07Szq1xr4Ub8/uG8G50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=jeaPulwT; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1765331817; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=1GTs03VUh2pg2He6cShVbbcuXtMMiMKBM5N4IAPUVS8=;
	b=jeaPulwTnhiROLz44XkKAlzloi3MZNsRe6AIoLUFR5ki7ejC5ejdrpluX+35nEXrIO1Uos/ENzEjoThIf/s/4hwbHqabbM3utlXAqfolA3P3uMtiAnwIm1YAjnpqtcOEbUQ+aVdPT9rhdG+XRiNFpCw2Pt5lxuky6oYJ6SQRG5M=
Received: from 30.246.178.18(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WuUd9N2_1765331814 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 10 Dec 2025 09:56:55 +0800
Message-ID: <edf92e08-85d0-4553-9461-625c03b3a5d2@linux.alibaba.com>
Date: Wed, 10 Dec 2025 09:56:53 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : [PATCH v13 3/3] Documentation: tracing: Add
 documentation about PCI tracepoints
To: ALOK TIWARI <alok.a.tiwari@oracle.com>, rostedt@goodmis.org,
 lukas@wunner.de, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-edac@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 helgaas@kernel.org, ilpo.jarvinen@linux.intel.com, mattc@purestorage.com,
 Jonathan.Cameron@huawei.com
Cc: bhelgaas@google.com, tony.luck@intel.com, bp@alien8.de,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, oleg@redhat.com,
 naveen@kernel.org, davem@davemloft.net, anil.s.keshavamurthy@intel.com,
 mark.rutland@arm.com, peterz@infradead.org, tianruidong@linux.alibaba.com
References: <20251025114158.71714-1-xueshuai@linux.alibaba.com>
 <20251025114158.71714-4-xueshuai@linux.alibaba.com>
 <1ad20492-f342-4a4b-8a2f-228db7c5673a@oracle.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <1ad20492-f342-4a4b-8a2f-228db7c5673a@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi, Alok,

在 2025/12/9 21:59, ALOK TIWARI 写道:
> 
> 
> On 10/25/2025 5:11 PM, Shuai Xue wrote:
>> The PCI tracing system provides tracepoints to monitor critical hardware
>> events that can impact system performance and reliability. Add
>> documentation about it.
>>
>> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
>> ---
>>   Documentation/trace/events-pci.rst | 74 ++++++++++++++++++++++++++++++
>>   1 file changed, 74 insertions(+)
>>   create mode 100644 Documentation/trace/events-pci.rst
>>
>> diff --git a/Documentation/trace/events-pci.rst b/Documentation/trace/events-pci.rst
>> new file mode 100644
>> index 000000000000..88bd38fcc184
>> --- /dev/null
>> +++ b/Documentation/trace/events-pci.rst
>> @@ -0,0 +1,74 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +
>> +===========================
>> +Subsystem Trace Points: PCI
>> +===========================
>> +
>> +Overview
>> +========
>> +The PCI tracing system provides tracepoints to monitor critical hardware events
>> +that can impact system performance and reliability. These events normally show
>> +up here:
>> +
>> +    /sys/kernel/tracing/events/pci
>> +
>> +Cf. include/trace/events/pci.h for the events definitions.
>> +
>> +Available Tracepoints
>> +=====================
>> +
>> +pci_hp_event
>> +------------
>> +
>> +Monitors PCI hotplug events including card insertion/removal and link
>> +state changes.
>> +::
>> +
>> +    pci_hp_event  "%s slot:%s, event:%s\n"
>> +
>> +**Event Types**:
>> +
>> +* ``LINK_UP`` - PCIe link established
>> +* ``LINK_DOWN`` - PCIe link lost
>> +* ``CARD_PRESENT`` - Card detected in slot
>> +* ``CARD_NOT_PRESENT`` - Card removed from slot
>> +
>> +**Example Usage**:
>> +
>> +    # Enable the tracepoint
>> +    echo 1> /sys/kernel/debug/tracing/events/pci/pci_hp_event/enable
> 
> missing space echo 1 >"

Good catch.

> 
>> +
>> +    # Monitor events (the following output is generated when a device is hotplugged)
>> +    cat /sys/kernel/debug/tracing/trace_pipe
>> +       irq/51-pciehp-88      [001] .....  1311.177459: pci_hp_event: 0000:00:02.0 slot:10, event:CARD_PRESENT
>> +
>> +       irq/51-pciehp-88      [001] .....  1311.177566: pci_hp_event: 0000:00:02.0 slot:10, event:LINK_UP
>> +
>> +pcie_link_event
>> +---------------
>> +
>> +Monitors PCIe link speed changes and provides detailed link status information.
>> +::
>> +
>> +    pcie_link_event  "%s type:%d, reason:%d, cur_bus_speed:%s, max_bus_speed:%s, width:%u, flit_mode:%u, status:%s\n"
> 
> %s -> %d mismatch for cur_bus_speed and max_bus_speed
> 
> TP_printk("%s type:%d, reason:%d, cur_bus_speed:%d, max_bus_speed:%d, width:%u, flit_mode:%u, status:%s\n",

Sorry for missing the format.

> 
>> +
>> +**Parameters**:
>> +
>> +* ``type`` - PCIe device type (4=Root Port, etc.)
>> +* ``reason`` - Reason for link change:
>> +
>> +  - ``0`` - Link retrain
>> +  - ``1`` - Bus enumeration
>> +  - ``2`` - Bandwidth notification enable
>> +  - ``3`` - Bandwidth notification IRQ
>> +  - ``4`` - Hotplug event
>> +
>> +
>> +**Example Usage**:
>> +
>> +    # Enable the tracepoint
>> +    echo1 > /sys/kernel/debug/tracing/events/pci/pcie_link_event/enable
>> +
>> +    # Monitor events (the following output is generated when a device is hotplugged)
>> +    cat /sys/kernel/debug/tracing/trace_pipe
>> +       irq/51-pciehp-88      [001] .....   381.545386: pcie_link_event: 0000:00:02.0 type:4, reason:4, cur_bus_speed:20, max_bus_speed:23, width:1, flit_mode:0, status:DLLLA
> 
> 
> Thanks,
> Alok

I will send a new version to fix above issues.

Thanks.
Shuai



