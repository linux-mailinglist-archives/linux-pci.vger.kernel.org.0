Return-Path: <linux-pci+bounces-38102-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F3ABDC29D
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 04:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C27084E7872
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 02:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE0F30BF76;
	Wed, 15 Oct 2025 02:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="JkjaWM6k"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7747F2C859;
	Wed, 15 Oct 2025 02:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760495816; cv=none; b=CK7rRDtjXzSyaduVBYVVebg0TRsmcQRbmXKS9xd16R/OQ8FMwtr2jFxLhhVARQGdPuZPzZBCJ8PfnPOf/WBePU4D5ZmYomoKhPuXPvz5Feb7ugluyylrXEAQwxUzIsqa/HNMY7sI2nmgxiPAw0eQJP/xwdpNvM9iNshOhCwr/dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760495816; c=relaxed/simple;
	bh=MfJiuQXGEa+ZudRLsqGdnGIMZpZIxG2Ns1QCu4p4hpk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DuN2NMR36hQp3qqJBPRfO4eFxZNO6obJsxpeZ0UxGwQmea+V7xkP9CTTyqj9hwTis4KxgrhiNhJdqAwUaOW10W8yM7oM2Uza/E+RCAHShqhTkoAyao2tr+9El6Si2zZIMzXgoFNOViuCnqlVPVb/GdWj0r5Hnvdg7jfeg8tofIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=JkjaWM6k; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1760495810; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=vnwhlmL/z9NcPBs6eAHRxmAdfMjUHuo2IL/i6fru8dM=;
	b=JkjaWM6k/hmT3Ny7dL37Eo8sjgkbY0iO8dSv09IV27ziNj+iZ8DejJ1l+ehiYeR/xQhxbyhqrPh4Z4mCNJqojVOtFnzOrrknmZcEy9QLCZGpv+8rrD3TH2FQD+Cg9x5jnGtrq2u18q0EfEGhCUAvuX+Km+VwxhtcD1pxF3D1M1Q=
Received: from 30.246.161.241(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WqEYAuU_1760495808 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 15 Oct 2025 10:36:49 +0800
Message-ID: <8c8f7c7e-286a-4020-8fdf-ff025e92f19f@linux.alibaba.com>
Date: Wed, 15 Oct 2025 10:36:47 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 3/3] Documentation: tracing: Add documentation about
 PCI tracepoints
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: rostedt@goodmis.org, Lukas Wunner <lukas@wunner.de>,
 linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 linux-edac@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 helgaas@kernel.org, mattc@purestorage.com, Jonathan.Cameron@huawei.com,
 bhelgaas@google.com, tony.luck@intel.com, bp@alien8.de, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, oleg@redhat.com, naveen@kernel.org,
 davem@davemloft.net, anil.s.keshavamurthy@intel.com, mark.rutland@arm.com,
 peterz@infradead.org, tianruidong@linux.alibaba.com
References: <20251014123159.57764-1-xueshuai@linux.alibaba.com>
 <20251014123159.57764-4-xueshuai@linux.alibaba.com>
 <cf4d3079-2d1b-dfa4-aa5f-e018962131bd@linux.intel.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <cf4d3079-2d1b-dfa4-aa5f-e018962131bd@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/10/14 22:40, Ilpo Järvinen 写道:
> On Tue, 14 Oct 2025, Shuai Xue wrote:
> 
>> The PCI tracing system provides tracepoints to monitor critical hardware
>> events that can impact system performance and reliability. Add
>> documentation about it.
>>
>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
>> ---
>>   Documentation/trace/events-pci.rst | 74 ++++++++++++++++++++++++++++++
>>   1 file changed, 74 insertions(+)
>>   create mode 100644 Documentation/trace/events-pci.rst
>>
>> diff --git a/Documentation/trace/events-pci.rst b/Documentation/trace/events-pci.rst
>> new file mode 100644
>> index 000000000000..500b27713224
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
>> +	/sys/kernel/tracing/events/pci
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
>> +    pci_hp_event  "%s slot:%s, event:%s\n"
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
>> +    # Enable the tracepoint
>> +    echo 1> /sys/kernel/debug/tracing/events/pci/pci_hp_event/enable
>> +
>> +    # Monitor events (the following output is generated when a device is hotplugged)
>> +    cat /sys/kernel/debug/tracing/trace_pipe
>> +       irq/51-pciehp-88      [001] .....  1311.177459: pci_hp_event: 0000:00:02.0 slot:10, event:CARD_PRESENT
>> +
>> +       irq/51-pciehp-88      [001] .....  1311.177566: pci_hp_event: 0000:00:02.0 slot:10, event:LINK_UP
>> +
>> +pcie_link_event
>> +---------------
>> +
>> +Monitors PCIe link speed changes and provides detailed link status information.
>> +::
>> +
>> +    pcie_link_event  "%s type:%d, reason:%d, cur_bus_speed:%s, max_bus_speed:%s, width:%u, flit_mode:%u, status:%s\n"
>> +
>> +**Parameters**:
>> +
>> +* ``type`` - PCIe device type (4=Root Port, etc.)
>> +* ``reason`` - Reason for link change:
>> +
>> +  - ``0`` - Link retrain
>> +  - ``1`` - Bus enumeration
>> +  - ``2`` - Bandwidth controller enable
>> +  - ``3`` - Bandwidth controller IRQ
> 
> Maybe these two should be called "Bandwidth notification" as that's the
> name of the underlying mechanism.

Sure, I will rename it.

> 
> For the entire series,
> 
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Thanks.

Best Regards,
Shuai


