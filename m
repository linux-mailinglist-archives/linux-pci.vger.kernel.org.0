Return-Path: <linux-pci+bounces-19520-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E8CA05611
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 10:04:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 035E1164036
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 09:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73481E9B2B;
	Wed,  8 Jan 2025 09:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="XN+6NTKr"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E4014B95A;
	Wed,  8 Jan 2025 09:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736327080; cv=none; b=gRiuHL/99mMdeEVWkp+0+R668cMgl0IjL1zJb3HWz1RtzEOcjG8XmTFVtfjOQAHR+ES4VHT7vxrAdmXmw5nCDanWZyNqNgtu6543W6fF7+e3V2TYaA74wWZEVM7mIIs775ERmut3S4xg8K7OyW9IHfCOQYzEi6gKOL9WC6l6Edw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736327080; c=relaxed/simple;
	bh=xNR/nXvwFudfyaWoOBM9ZGvzX6rok5QN+Q64OKRxbZw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=KJYfO2K+o1lask7x9bD+5xJh97I0S1cYkcoiR0bumfYx43L0/wK3+Xb2rF+cuc243dcySmoGbowGm8m/7O2jmIQapkdYxCvEAzaxPo4+ko8W4LlSV1jDSHJKKeMJ1McFq4jnseO8QXDaPLKQyV/syDlmsHRXoiQ2B2BVYdJBJgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=XN+6NTKr; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1736327068; h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type;
	bh=ijIs5T/si3GfhX3wBZjJciP7Ftp7BZ+lLRzqIm/A8wc=;
	b=XN+6NTKrDrsIMMrwOM9OKRS6VRdU4tXnj9nhNbV6Kq2paYwS3N97iqeXqtVDrfqd2EJOJiWpN2uLwoZYeW9HmJrHszPZgIpy57vt0TiJcFeUrysif85uDfijRYItYsLTiNsNFrG+wQf6Z8/ySk/MRSYLoiZIUBEgWU4siWka4AU=
Received: from 30.246.161.230(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WNDVWZy_1736327065 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 08 Jan 2025 17:04:27 +0800
Message-ID: <309dd6e6-53ec-4f82-94ca-242941bd7136@linux.alibaba.com>
Date: Wed, 8 Jan 2025 17:04:25 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Shuai Xue <xueshuai@linux.alibaba.com>
Subject: Re: [PATCH v4] PCI: hotplug: Add a generic RAS tracepoint for hotplug
 event
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: rostedt@goodmis.org, lukas@wunner.de, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bhelgaas@google.com,
 tony.luck@intel.com, bp@alien8.de, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, oleg@redhat.com, naveen@kernel.org,
 davem@davemloft.net, anil.s.keshavamurthy@intel.com, mark.rutland@arm.com,
 peterz@infradead.org
References: <20250107231943.GA189869@bhelgaas>
In-Reply-To: <20250107231943.GA189869@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/1/8 07:19, Bjorn Helgaas 写道:
> On Sat, Nov 23, 2024 at 07:31:08PM +0800, Shuai Xue wrote:
>> Hotplug events are critical indicators for analyzing hardware health,
>> particularly in AI supercomputers where surprise link downs can
>> significantly impact system performance and reliability. The failure
>> characterization analysis illustrates the significance of failures
>> caused by the Infiniband link errors. Meta observes that 2% in a machine
>> learning cluster and 6% in a vision application cluster of Infiniband
>> failures co-occur with GPU failures, such as falling off the bus, which
>> may indicate a correlation with PCIe.[1]
>>
>> To this end, define a new TRACING_SYSTEM named pci, add a generic RAS
>> tracepoint for hotplug event to help healthy check, and generate
>> tracepoints for pcie hotplug event. To monitor these tracepoints in
>> userspace, e.g. with rasdaemon, put `enum pci_hotplug_event` in uapi
>> header.
>>
>> The output like below:
>> $ echo 1 > /sys/kernel/debug/tracing/events/pci/pci_hp_event/enable
>> $ cat /sys/kernel/debug/tracing/trace_pipe
>>             <...>-206     [001] .....    40.373870: pci_hp_event: 0000:00:02.0 slot:10, event:Link Down
>>
>>             <...>-206     [001] .....    40.374871: pci_hp_event: 0000:00:02.0 slot:10, event:Card not present
>>
>> [1]https://arxiv.org/abs/2410.21680
> 
> Doesn't apply on pci/main (v6.13-rc1); can you rebase it?

Sure. Do you mean Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git
   branch main

> 
> s/pcie/PCIe/ in English text.

Will fix it.

> 
> Probably more detail than necessary about AI supercomputers,
> Infiniband, vision applications, etc.  This is a very generic issue.

Agreed. It is generic. Are you asking for the first background paragraph to be
deleted?

> 
> "Falling off the bus" doesn't really mean anything to me.  I suppose
> it's another way to describe a "link down" event that leads to UR
> errors when trying to access the device?

Sorry for the confusion. "Falling off the bus" is a common error for NVIDIA GPU
observed in production. The GPU driver will log a such message when GPU is not
accessible. And we also see many hotplug event like bellow:

[12945750.691652] pcieport 0000:42:02.0: pciehp: Slot(65): Link Down
[12945750.691655] pcieport 0000:42:02.0: pciehp: Slot(65): Card not present

> https://docs.nvidia.com/deploy/xid-errors/index.html#xid-79-gpu-has-fallen-off-the-bus

> 
> I'm guessing that monitoring these via rasdaemon requires more than
> just adding "enum pci_hotplug_event"?  Or does rasdaemon read
> include/uapi/linux/pci.h and automagically incorporate new events?
> Maybe there's at least a rebuild involved?

Yes, a rebuild is needed. Rasdaemon has a basic infrastructure to manually
register a tracepoint event handler. For example, for this new event, we can
register to handle pci_hp_event:

     rc = add_event_handler(ras, pevent, page_size, "pci", "pci_hp_event",
			   ras_pci_hp_event_handler, NULL, PCI_HOTPLUG_EVENT);

> 
> Anything in the arxiv link that is specifically relevant to this patch
> needs to be in the commit log itself.  But I think there's already
> enough information here to motivate this change, and whatever is in
> the arxiv link may be of general interest, but is probably not
> required to justify, understand, or debug this useful functionality.

I see, will remove the arxiv link.

> 
> Bjorn

Thank you for quick reply.

Best Regards,
Shuai

