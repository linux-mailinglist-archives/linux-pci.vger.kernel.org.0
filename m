Return-Path: <linux-pci+bounces-36454-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B51CB879FF
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 03:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D961C58028B
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 01:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A6A24418E;
	Fri, 19 Sep 2025 01:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ZB8F5UGs"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225E424167B;
	Fri, 19 Sep 2025 01:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758246034; cv=none; b=abe3qpOyv6LtZKMuMpgRnGemfhgJ39/01vsUl2ogmdz4PY/sE6Ls2iWSmcg6DO/Y8k2KveNT6tzX8VmPFeuBBtIEVRd4d/NIY2u/GZIbE1Po8Qw9Yr/6GHi2nNAC+CVXbl/r6/bpEFBwTP4DfypcZDXwOAhY6a6Hkln8+tPKxWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758246034; c=relaxed/simple;
	bh=1PtLLluYShGHAQg/h1z17ZQOqMZIPeNVJzQVlBvj5X4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=skroTJvvPYejFz0rlK5tOMiF6nCvL/Am32eONsGmEbIlKyXXazZGUUZ4Q3MMtUAkirO1LR7CQPJ+6n+61kusUNxkng0MxRAbv7SAdXti/rzf2CI7Vm2DRmcTskQQIxCK4UB1T7kog2NImTuJy/UUJY4dojuxTL1pNHbe3iWa4Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ZB8F5UGs; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1758246029; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=tPEMXjlZOHU86z4opAhFqFfDO6eWBc+PbnVHOGJhATU=;
	b=ZB8F5UGsSR8/a0T6k/vya/HUFs+tp8bR3kVpoCvOZNjknedCyflNorF4JphIRU0cZNjpR3aUkGjjogbKxiuFtTOoOVqenpF8Hvc4h9y6LJzcoefcUIAcNOPYCz7fmJYppuBHBP3uZOnmTc5xU6fOn0I9lChxt4MxZjWL33YdF3w=
Received: from 30.246.178.33(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WoHq.Hr_1758246026 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 19 Sep 2025 09:40:27 +0800
Message-ID: <ad68796a-8bb6-4f4a-9d30-80e7ffa4ded4@linux.alibaba.com>
Date: Fri, 19 Sep 2025 09:40:26 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 0/2] add PCI hotplug and PCIe link tracepoint
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: rostedt@goodmis.org, lukas@wunner.de, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, ilpo.jarvinen@linux.intel.com,
 mattc@purestorage.com, Jonathan.Cameron@huawei.com, bhelgaas@google.com,
 tony.luck@intel.com, bp@alien8.de, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, oleg@redhat.com, naveen@kernel.org,
 davem@davemloft.net, anil.s.keshavamurthy@intel.com, mark.rutland@arm.com,
 peterz@infradead.org, tianruidong@linux.alibaba.com
References: <20250918230629.GA1928363@bhelgaas>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20250918230629.GA1928363@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/9/19 07:06, Bjorn Helgaas 写道:
> On Wed, Jul 23, 2025 at 11:31:06AM +0800, Shuai Xue wrote:
>> changes since v8:
>> - rewrite commit log from Bjorn
>> - move pci_hp_event to a common place (include/trace/events/pci.h) per Ilpo
>> - rename hotplug event strings per Bjorn and Lukas
>> - add PCIe link tracepoint per Bjorn, Lukas, and Ilpo
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
>> Shuai Xue (2):
>>    PCI: trace: Add a generic RAS tracepoint for hotplug event
>>    PCI: trace: Add a RAS tracepoint to monitor link speed changes
>>
>>   drivers/pci/hotplug/pciehp_ctrl.c |  33 +++++++--
>>   drivers/pci/hotplug/pciehp_hpc.c  |   5 +-
>>   drivers/pci/pci.c                 |   2 +-
>>   drivers/pci/pci.h                 |  12 ++-
>>   drivers/pci/pcie/bwctrl.c         |   4 +-
>>   drivers/pci/probe.c               |  10 ++-
>>   include/linux/pci.h               |   1 +
>>   include/trace/events/pci.h        | 119 ++++++++++++++++++++++++++++++
>>   include/uapi/linux/pci.h          |   7 ++
>>   9 files changed, 177 insertions(+), 16 deletions(-)
>>   create mode 100644 include/trace/events/pci.h
> 
> Hi Shuai,
> 
> I lost track of what happened with this series.  It seemed like we
> were pretty close but there were some trivial issues, and I don't
> think we ever merged it.  Did I miss something, or are you waiting on
> me?
> 
> Bjorn

Hi Bjorn,

Thank you for following up on this series. I apologize for the lack of
updates.

You're right that we were close to merging - I've been tied up with
other urgent work and haven't had a chance to address the remaining
minor issues.

I'll prepare and send out a new version this week with all the requested
changes.

Thanks for your patience.

Best regards,
Shuai

