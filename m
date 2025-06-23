Return-Path: <linux-pci+bounces-30337-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 240D4AE33DB
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 05:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E85081890170
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 03:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375CA19342F;
	Mon, 23 Jun 2025 03:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="nKz+Mdq1"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A051DDD1;
	Mon, 23 Jun 2025 03:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750647895; cv=none; b=BFlEyi4PjXnUm0sS1t5eUPNecTtEP03vOQl/CIKuHrZvnGYt7ZZHD2o5oopgcf1W2JccuGQJjtd5cqDKnqYbn81Eaah8MVt8DMDUirgWJ0UdLql2shkkJnbJDkTx1d66U2yGEJJ4cqQpFyIIj/NcNt0kcQvoO87sSdVc5Tt98eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750647895; c=relaxed/simple;
	bh=a648IPzo65DASVTu/mn0R4z0gLCIMWV2LgAjH1BnKUg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hjyyzjo2orI+neGiR23txGxoTVF/gPYRxRg60mmQzrSvu7SXQtAxAK0l4wOpNqBHTCywtAyk0c7ReekC6xDj4g0qYJYCz2bglrtTzoIorN5xNDUORroNFOIDVMg/dwAw6TzmzM8ha4YqI9UzcFHXp4JM8CuPtm3dxQFTMoaiZdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=nKz+Mdq1; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1750647883; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=mcNkuNTmzIQu0HBmtmC8P6vqmaUZwx5CS6edDfV1nks=;
	b=nKz+Mdq1XqmGBwQarPf/RmT0yi6yN3mQw8rZ60OSWMB2P6aHGv41Sr52nRBoFp57RLhi6wTPBwsUAgloKD7hbflmpysrJ1AfY0FbkVm7fpm5UqebBB6okiPmsuR8dELoE27P4EP9ZQDBKcW6NUIirR1uFE5/sMLUFRKyzQeiIcs=
Received: from 30.246.181.6(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WeSBcWA_1750647880 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 23 Jun 2025 11:04:41 +0800
Message-ID: <c0cbdd85-9702-40ab-bc97-b51b02b9fc89@linux.alibaba.com>
Date: Mon, 23 Jun 2025 11:04:40 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8] PCI: hotplug: Add a generic RAS tracepoint for hotplug
 event
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Lukas Wunner <lukas@wunner.de>, rostedt@goodmis.org
Cc: rostedt@goodmis.org, linux-pci@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, linux-edac@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, helgaas@kernel.org, bhelgaas@google.com,
 tony.luck@intel.com, bp@alien8.de, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, oleg@redhat.com, naveen@kernel.org,
 davem@davemloft.net, anil.s.keshavamurthy@intel.com, mark.rutland@arm.com,
 peterz@infradead.org, tianruidong@linux.alibaba.com
References: <20250512013839.45960-1-xueshuai@linux.alibaba.com>
 <6b4d1351-805e-c8fc-3484-11c0ec466cf0@linux.intel.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <6b4d1351-805e-c8fc-3484-11c0ec466cf0@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/6/2 14:30, Ilpo Järvinen 写道:
> On Mon, 12 May 2025, Shuai Xue wrote:
> 
>> Hotplug events are critical indicators for analyzing hardware health,
>> particularly in AI supercomputers where surprise link downs can
>> significantly impact system performance and reliability.
>>
>> To this end, define a new TRACING_SYSTEM named pci, add a generic RAS
>> tracepoint for hotplug event to help healthy check, and generate
>> tracepoints for pcie hotplug event. Add enum pci_hotplug_event in
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
>>
>> Suggested-by: Lukas Wunner <lukas@wunner.de>
>> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
>> Reviewed-by: Lukas Wunner <lukas@wunner.de>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> ---
>> changes since v7:
>> - replace the TRACE_INCLUDE_PATH to avoid macro conflict per Steven
>> - pick up Reviewed-by from Lukas Wunner
>> ---
>>   drivers/pci/hotplug/Makefile      |  3 ++
>>   drivers/pci/hotplug/pciehp_ctrl.c | 33 ++++++++++++---
>>   drivers/pci/hotplug/trace.h       | 68 +++++++++++++++++++++++++++++++
>>   include/uapi/linux/pci.h          |  7 ++++
>>   4 files changed, 105 insertions(+), 6 deletions(-)
>>   create mode 100644 drivers/pci/hotplug/trace.h
>>
>> diff --git a/drivers/pci/hotplug/Makefile b/drivers/pci/hotplug/Makefile
>> index 40aaf31fe338..a1a9d1e98962 100644
>> --- a/drivers/pci/hotplug/Makefile
>> +++ b/drivers/pci/hotplug/Makefile
>> @@ -3,6 +3,9 @@
>>   # Makefile for the Linux kernel pci hotplug controller drivers.
>>   #
>>   
>> +# define_trace.h needs to know how to find our header
>> +CFLAGS_pciehp_ctrl.o				:= -I$(src)
>> +
>>   obj-$(CONFIG_HOTPLUG_PCI)		+= pci_hotplug.o
>>   obj-$(CONFIG_HOTPLUG_PCI_COMPAQ)	+= cpqphp.o
>>   obj-$(CONFIG_HOTPLUG_PCI_IBM)		+= ibmphp.o
>> diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
>> index d603a7aa7483..f9beb4d3a9b8 100644
>> --- a/drivers/pci/hotplug/pciehp_ctrl.c
>> +++ b/drivers/pci/hotplug/pciehp_ctrl.c
>> @@ -23,6 +23,9 @@
>>   #include "../pci.h"
>>   #include "pciehp.h"
>>   
>> +#define CREATE_TRACE_POINTS
>> +#include "trace.h"
> 
> Hi,
> 
> Instead of spreading tracepoint creating into subdriver code like this,
> should we place it into one place, e.g., drivers/pci/pci-trace.c (which is
> what I seem to have used in my yet to be submitted patch that adds
> tracepoints into bwctrl link speed events)?
> 
>> diff --git a/drivers/pci/hotplug/trace.h b/drivers/pci/hotplug/trace.h
>> new file mode 100644
>> index 000000000000..21329c198019
>> --- /dev/null
>> +++ b/drivers/pci/hotplug/trace.h
> 
> Perhaps in include/trace/events/pci.h (or
> include/trace/events/pci-hotplug.h)?
> 
> I don't know what is the general rule having them inside drivers/ vs
> include/trace/events, Documentation/trace/tracepoints.rst only mentions
> the latter, but there seems to be plenty under drivers/ too.
> 

Hi, Ilpo,

I don't know either.

I think it is tracepoint stuff and it is up to @Steve.
@Steve, which way do you prefer?

Thanks for help.

Best Regards,
Shuai



