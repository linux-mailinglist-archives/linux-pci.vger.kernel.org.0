Return-Path: <linux-pci+bounces-19583-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05574A06A5F
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jan 2025 02:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B56A1188950E
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jan 2025 01:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5BE15E8B;
	Thu,  9 Jan 2025 01:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="wBv31Tm5"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D437D29A9;
	Thu,  9 Jan 2025 01:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736386839; cv=none; b=lTSl9pfnk94Tcsz/5wlX5gGZcwNSjdTBYZ+jeKZjTIgRTWCMnCmeZHqK5iJR/kDb34HB4077fvU/xJNLtwbZvoYXI0g9fx9+26QH6OOm6oEhRM4+3crGY2CWkhqgHT5Sn4dC2tFfp8jIDcVeHynGFR0jK/waQOkMqBZxxxjCtF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736386839; c=relaxed/simple;
	bh=lkKvvPWj4gV68xsk82FPzrUglcSJ+bXLwU8nTgKKnsc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DY4qg7kDv02oEQaP4FVi3VYBE1j86Hy/wNnLOZKihtfL2BRHKx/9rsaHvqf6RMYVYeiqbq7oauFfpv5F8zl5UHbLgcqRXRywfiph1O9+7t7cO9kSl0fV8hozcWyDqLEhfycVu4dpU4d2Tss4GG7XvH6vseFe6Faep7swe9HnytE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=wBv31Tm5; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1736386828; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=7MEf/mEwctvG2yXt+5bH15F/zvi2AQxq2uLpYMY1fVk=;
	b=wBv31Tm5xJIZSVOCM9sNEe/lqGh5hLE8R3w9cNv8/PEyT01BdboLOq/Uvb5UW4xHFNJW7GPYPhUVVgcXQ5Uq3bOLiE2Chs2Q983t9DF7R9BcFJuOgpb/FpeumKU3YAX7EEuuuwVWpJn08oY5w4yTlMJM8mZrUZQDqyreIo/eyds=
Received: from 30.246.161.230(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WNFQTCi_1736386825 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 09 Jan 2025 09:40:27 +0800
Message-ID: <94b8fe33-26f3-4ec3-b9c1-3478d68cf709@linux.alibaba.com>
Date: Thu, 9 Jan 2025 09:40:25 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
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
References: <20250108175906.GA219807@bhelgaas>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20250108175906.GA219807@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/1/9 01:59, Bjorn Helgaas 写道:
> On Wed, Jan 08, 2025 at 05:04:25PM +0800, Shuai Xue wrote:
>> 在 2025/1/8 07:19, Bjorn Helgaas 写道:
>>> On Sat, Nov 23, 2024 at 07:31:08PM +0800, Shuai Xue wrote:
>>>> Hotplug events are critical indicators for analyzing hardware health,
>>>> particularly in AI supercomputers where surprise link downs can
>>>> significantly impact system performance and reliability. The failure
>>>> characterization analysis illustrates the significance of failures
>>>> caused by the Infiniband link errors. Meta observes that 2% in a machine
>>>> learning cluster and 6% in a vision application cluster of Infiniband
>>>> failures co-occur with GPU failures, such as falling off the bus, which
>>>> may indicate a correlation with PCIe.[1]
>>>>
>>>> To this end, define a new TRACING_SYSTEM named pci, add a generic RAS
>>>> tracepoint for hotplug event to help healthy check, and generate
>>>> tracepoints for pcie hotplug event. To monitor these tracepoints in
>>>> userspace, e.g. with rasdaemon, put `enum pci_hotplug_event` in uapi
>>>> header.
>>>>
>>>> The output like below:
>>>> $ echo 1 > /sys/kernel/debug/tracing/events/pci/pci_hp_event/enable
>>>> $ cat /sys/kernel/debug/tracing/trace_pipe
>>>>              <...>-206     [001] .....    40.373870: pci_hp_event: 0000:00:02.0 slot:10, event:Link Down
>>>>
>>>>              <...>-206     [001] .....    40.374871: pci_hp_event: 0000:00:02.0 slot:10, event:Card not present
>>>>
>>>> [1]https://arxiv.org/abs/2410.21680
>>>
>>> Doesn't apply on pci/main (v6.13-rc1); can you rebase it?
>>
>> Sure. Do you mean Git repository at:
>>
>>    git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git
>>    branch main
> 
> Yes.  The most recent -rc1 is generally a safe bet for basing patches.

Got it. Will send a new version later.

> 
>>> Probably more detail than necessary about AI supercomputers,
>>> Infiniband, vision applications, etc.  This is a very generic issue.
>>
>> Agreed. It is generic. Are you asking for the first background paragraph to be
>> deleted?
> 
> I think the important part is that hotplug and link down events are
> critical indicators of hardware health.  That's enough to motivate
> this patch.

OK, I'd like to rewrite with a generic motivation.

> 
>>> "Falling off the bus" doesn't really mean anything to me.  I suppose
>>> it's another way to describe a "link down" event that leads to UR
>>> errors when trying to access the device?
>>
>> Sorry for the confusion. "Falling off the bus" is a common error for
>> NVIDIA GPU observed in production. The GPU driver will log a such
>> message when GPU is not accessible.
> 
> Yep, I see those too, and I wish the message weren't phrased so
> casually.  IIRC this is typically logged when an MMIO read returns ~0,
> which happens when a UR or similar error occurs.
> 
>>> I'm guessing that monitoring these via rasdaemon requires more than
>>> just adding "enum pci_hotplug_event"?  Or does rasdaemon read
>>> include/uapi/linux/pci.h and automagically incorporate new events?
>>> Maybe there's at least a rebuild involved?
>>
>> Yes, a rebuild is needed. Rasdaemon has a basic infrastructure to manually
>> register a tracepoint event handler. For example, for this new event, we can
>> register to handle pci_hp_event:
>>
>>      rc = add_event_handler(ras, pevent, page_size, "pci", "pci_hp_event",
>> 			   ras_pci_hp_event_handler, NULL, PCI_HOTPLUG_EVENT);
> 
> I would say something like "Add enum pci_hotplug_event in
> include/uapi/linux/pci.h so applications like rasdaemon can register
> tracepoint event handlers for it."

Will rewrite it.

> 
> Bjorn

Thank you for valuable comments.

Best Regards,
Shuai


