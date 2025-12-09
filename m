Return-Path: <linux-pci+bounces-42842-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3117CB00CF
	for <lists+linux-pci@lfdr.de>; Tue, 09 Dec 2025 14:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 97BD33021F8B
	for <lists+linux-pci@lfdr.de>; Tue,  9 Dec 2025 13:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779F9328B4F;
	Tue,  9 Dec 2025 13:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="q1QGnjRf"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E7C1898F8;
	Tue,  9 Dec 2025 13:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765286682; cv=none; b=nL6oYNlZHWGi49q1QF97Uv5HlADsL7QGq7nHJydHQYzhYgbocenVOL9K/Udezd2VfQM9jg0AAwxDMH5gDLaZAcGnrkfawRHWg/ae1eXEA/3i3DbLoI7OospCOdd6J7CuHUWMm88YfxABi3o14TVTKUC8qs/NXSzQjUN2YNEyksM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765286682; c=relaxed/simple;
	bh=hJ/0sOpN+P0Q+WIGMfkW3OT9OkaXeoB90zN2c5rYRNY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=eeeukTmZOcXozv4of68ORpjKX7QznAGto6Qsh5B1yRna8S8ZoR+McrKySvNzCAfwU8G2l3g/alrSvp6MKZUlGFQ3f78Ner0TXnp/bdg1n7Kd4bW4GLgUTtuvYH3DxyZdNJBxGdyZ+FlOiBTiWU8ug+2acf7jw4YRAxV/he/um6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=q1QGnjRf; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1765286669; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=OakDZAcNjV0xxUESbvHAt5urGQN2h5Z6UwAQnSxdGKE=;
	b=q1QGnjRfmJ5VtzF94BWW0lMQT5GlpoMJudIK7j/jJQQOPDKL3fpxZBTA9+UkSR3IB4CCx5lVYAvRqe0P5/8l+vOeWAR0E6RAPtYDyIv5Lix226IUDvXhTTX7QxOOw9BV/2VTP63OCOto9WYxrm0cZ5qgC+j5KVIoI07YAKvtd58=
Received: from 30.246.178.18(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WuT351B_1765286340 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 09 Dec 2025 21:19:02 +0800
Message-ID: <bed37798-8c38-4669-b841-45924473696a@linux.alibaba.com>
Date: Tue, 9 Dec 2025 21:19:00 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 0/3] PCI: trace: Add a RAS tracepoint to monitor link
 speed changes
From: Shuai Xue <xueshuai@linux.alibaba.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: tony.luck@intel.com, bp@alien8.de, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, oleg@redhat.com, naveen@kernel.org,
 davem@davemloft.net, anil.s.keshavamurthy@intel.com, mark.rutland@arm.com,
 peterz@infradead.org, tianruidong@linux.alibaba.com, rostedt@goodmis.org,
 lukas@wunner.de, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-edac@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 helgaas@kernel.org, ilpo.jarvinen@linux.intel.com, mattc@purestorage.com,
 Jonathan.Cameron@huawei.com
References: <20251025114158.71714-1-xueshuai@linux.alibaba.com>
 <1f9ee237-9d62-4c33-83c3-ce4d9ca9497f@linux.alibaba.com>
In-Reply-To: <1f9ee237-9d62-4c33-83c3-ce4d9ca9497f@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/11/4 17:34, Shuai Xue 写道:
> 
> 
> 在 2025/10/25 19:41, Shuai Xue 写道:
>> changes since v12:
>> - add Reviewed-by tag for PATCH 1 from Steve
>> - add Reviewed-by tag for PATCH 1-3 from Ilpo
>> - add comments for why use string to define tracepoint per Steve
>> - minor doc improvements from Ilpo
>> - remove use pci_speed_string to fix PCI dependends which cause build error on sparc64
>>
>> changes since v11:
>> - rebase to Linux 6.18-rc1 (no functional changes)
>>
>> changes since v10:
>> - explicitly include header file per Ilpo
>> - add comma on any non-terminator entry  per Ilpo
>> - compile trace.o under CONFIG_TRACING per Ilpo
>>
>> changes since v9:
>> - add a documentation about PCI tracepoints per Bjorn
>> - create a dedicated drivers/pci/trace.c that always defines the PCI tracepoints per Steve
>> - move tracepoint callite into __pcie_update_link_speed() per Lukas and Bjorn
>>
>> changes since v8:
>> - rewrite commit log from Bjorn
>> - move pci_hp_event to a common place (include/trace/events/pci.h) per Ilpo
>> - rename hotplug event strings per Bjorn and Lukas
>> - add PCIe link tracepoint per Bjorn, Lukas, and Ilpo
>>
>> changes since v7:
>> - replace the TRACE_INCLUDE_PATH to avoid macro conflict per Steven
>> - pick up Reviewed-by from Lukas Wunner
>>
>> Hotplug events are critical indicators for analyzing hardware health, and
>> surprise link downs can significantly impact system performance and reliability.
>> In addition, PCIe link speed degradation directly impacts system performance and
>> often indicates hardware issues such as faulty devices, physical layer problems,
>> or configuration errors.
>>
>> This patch set add PCI hotplug and PCIe link tracepoint to help analyze PCI
>> hotplug events and PCIe link speed degradation.
>>
>> Shuai Xue (3):
>>    PCI: trace: Add a generic RAS tracepoint for hotplug event
>>    PCI: trace: Add a RAS tracepoint to monitor link speed changes
>>    Documentation: tracing: Add documentation about PCI tracepoints
>>
> 
> Hi, Bjorn,
> 
> Gentle ping.
> 
> Do you have any further concerns about this patch set?
> 
> Shuai

Hi, all,

Gentle ping.

Thanks.
Shuai


