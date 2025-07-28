Return-Path: <linux-pci+bounces-33028-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A27B1372D
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 11:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18E28178591
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 09:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A76451F8755;
	Mon, 28 Jul 2025 09:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="RNaYNqKU"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFA6199EAD;
	Mon, 28 Jul 2025 09:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753693532; cv=none; b=OT10GTVvu4MmiYjumuoLMeotyOrGoAmzVKBVY1ztB3QRXlgnikFhzr89ndxkzdTLUrrKeNBbpZgRnO+2y/z+0IwGfAS8syAkQyM4tAiI/tEJgUnSmYHyi2EDBnfARBkm2BwV7BVNyNYyVqT3SUBryLDrjGDqhjABozZbrEywb7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753693532; c=relaxed/simple;
	bh=ZC1PBwzhgJuuOcx5rmgZcY9QFnKGOwDm6B46DS0dnFg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dHtil8Out6lZBtJAkzIzmO4g0F1gWS4ajYn2+1G0yrf4EkEuCTwbcjyJzSr+O5DbiGkH8XZBvBCK2eozE5eJAY34EakySm+mRgnib9l3V4kLTq/JNV0qzBMwbJWR+503fJNaDhnLJuvgZdqQP+rWbW9ycy9FsTHejEU/Qmmql5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=RNaYNqKU; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1753693526; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=T8LcCGaO+6i8uxsy1cdV0D7zwVU5uHMOV2qU0c01c9o=;
	b=RNaYNqKUsi+4GmgioPacoK1ZdJp/0/JtntzhbCmCUYYK7DtR3X4rmxgm7iB/OtxCInbgIkmsHosYdoLt1Kqe7QaSoYQffrZAO6b/ovgmBztrOxsATI32rtDT5NRETsDDt6HQ5ZnIpziopF3BtSBEsWR6soUHASmVvD/eyr4bvsA=
Received: from 30.246.181.19(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WkGahay_1753693523 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 28 Jul 2025 17:05:25 +0800
Message-ID: <09cc9d71-5375-4e35-bbd9-5eec7930ddc7@linux.alibaba.com>
Date: Mon, 28 Jul 2025 17:05:22 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 1/2] PCI: trace: Add a generic RAS tracepoint for
 hotplug event
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: rostedt@goodmis.org, lukas@wunner.de, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, ilpo.jarvinen@linux.intel.com,
 mattc@purestorage.com, Jonathan.Cameron@huawei.com, bhelgaas@google.com,
 tony.luck@intel.com, bp@alien8.de, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, oleg@redhat.com, naveen@kernel.org,
 davem@davemloft.net, anil.s.keshavamurthy@intel.com, mark.rutland@arm.com,
 peterz@infradead.org, tianruidong@linux.alibaba.com
References: <20250725210913.GA3130903@bhelgaas>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20250725210913.GA3130903@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi, Bjorn,

在 2025/7/26 05:09, Bjorn Helgaas 写道:
> On Wed, Jul 23, 2025 at 11:31:07AM +0800, Shuai Xue wrote:
>> Hotplug events are critical indicators for analyzing hardware health,
>> and surprise link downs can significantly impact system performance and
>> reliability.
>>
>> Define a new TRACING_SYSTEM named "pci", add a generic RAS tracepoint
>> for hotplug event to help health checks. Add enum pci_hotplug_event in
>> include/uapi/linux/pci.h so applications like rasdaemon can register
>> tracepoint event handlers for it.
>>
>> The output is like below:
>>
>> $ echo 1 > /sys/kernel/debug/tracing/events/pci/pci_hp_event/enable
>> $ cat /sys/kernel/debug/tracing/trace_pipe
>>      <...>-206     [001] .....    40.373870: pci_hp_event: 0000:00:02.0 slot:10, event:LINK_DOWN
>>
>>      <...>-206     [001] .....    40.374871: pci_hp_event: 0000:00:02.0 slot:10, event:CARD_NOT_PRESENT
> 
> I asked about documentation earlier [1], but didn't see any response.
> I think these tracepoints are important and will be widely used, so it
> seems like some kind of user guide would be helpful.

Sorry for missing your earlier email about documentation.

> Is there any convention for documenting tracepoints somewhere?  It
> looks like there's some doc in Documentation/trace/?  Should we be
> adding something there?

Regarding tracepoint documentation conventions, you raise a good point.
Looking at Documentation/trace/, most of the existing documentation
focuses on the tracing infrastructure itself rather than individual
tracepoint events.

For tracepoint events like the ones I'm familiar with (aer_event,
memory_failure_event, mce_event, mc_event), the typical approach has
been:

     - Self-documenting through code - The TRACE_EVENT() definitions in
       include/trace/events/ serve as the primary specification
     - UAPI headers - Enums and structures in include/uapi/ provide the
       interface definitions
     - Commit messages - Detailed explanations of when/why events are
       generated

However, there are some exceptions where specific events do have
dedicated documentation:

     - Documentation/trace/events-power.rst - Power management events
     - Documentation/trace/events-kmem.rst - Kernel memory allocation events
     - Documentation/trace/events-nmi.rst - NMI events
     - Documentation/trace/events-msr.rst - MSR (Model Specific Register) events

Given your point about these PCI tracepoints potentially being widely
used, I think adding documentation would be valuable. Bellow is the RFC
doc, are you happy with this?

diff --git a/Documentation/trace/events-pci.rst b/Documentation/trace/events-pci.rst
new file mode 100644
index 000000000000..f2f7cacba862
--- /dev/null
+++ b/Documentation/trace/events-pci.rst
@@ -0,0 +1,72 @@
+===========================
+Subsystem Trace Points: PCI
+===========================
+
+Overview
+========
+The PCI tracing system provides tracepoints to monitor critical hardware events
+that can impact system performance and reliability. These events normally show
+up here:
+
+       /sys/kernel/tracing/events/pci
+
+Cf. include/trace/events/pci.h for the events definitions.
+
+Available Tracepoints
+=====================
+
+pci_hp_event
+------------
+
+Monitors PCI hotplug events including card insertion/removal and link
+state changes.
+::
+
+    pci_hp_event  "%s slot:%s, event:%s\n"
+
+**Event Types**:
+
+* ``LINK_UP`` - PCIe link established
+* ``LINK_DOWN`` - PCIe link lost
+* ``CARD_PRESENT`` - Card detected in slot
+* ``CARD_NOT_PRESENT`` - Card removed from slot
+
+**Example Usage**:
+
+    # Enable the tracepoint
+    echo 1> /sys/kernel/debug/tracing/events/pci/pci_hp_event/enable
+
+    # Monitor events
+    cat /sys/kernel/debug/tracing/trace_pipe
+    <...>-206     [001] .....    40.373870: pci_hp_event: 0000:00:02.0 slot:10, event:LINK_DOWN
+
+    <...>-206     [001] .....    40.374871: pci_hp_event: 0000:00:02.0 slot:10, event:CARD_NOT_PRESENT
+
+
+pcie_link_event
+---------------
+
+Monitors PCIe link speed changes and provides detailed link status information.
+::
+
+    pcie_link_event  "%s type:%d, reason:%d, cur_bus_speed:%s, max_bus_speed:%s, width:%u, flit_mode:%u, status:%s\n"
+
+**Parameters**:
+
+* ``type`` - PCIe device type (4=Root Port, etc.)
+* ``reason`` - Reason for link change:
+
+  - ``0`` - Link retrain
+  - ``1`` - Bus enumeration
+  - ``2`` - Bandwidth controller enable
+  - ``3`` - Bandwidth controller IRQ
+  - ``4`` - Hotplug event
+
+
+**Example Usage**::
+
+    # Enable the tracepoint
+    echo1 > /sys/kernel/debug/tracing/events/pci/pcie_link_event/enable
+
+    # Monitor link events
+    cat /sys/kernel/debug/tracing/trace_pipe


> 
>> Suggested-by: Lukas Wunner <lukas@wunner.de>
>> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
>> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> Nit: I assume this came from the patch I had applied to pci/trace, but
> you shouldn't include any sign-offs from people to whom you send
> patches [2].

Yep, I copied the commit log from your applied patch in pci/trace. I
will drop your sign-offs.

> 
> Bjorn
> 
> [1] https://lore.kernel.org/all/20250717192950.GA2594528@bhelgaas/#t
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=v6.13#n449


Thanks for the guidance!

Best regards,
Shuai



