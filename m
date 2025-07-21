Return-Path: <linux-pci+bounces-32646-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7465B0C501
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 15:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B746172625
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 13:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CABC2D59E8;
	Mon, 21 Jul 2025 13:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="rkcVs88b"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601C029E109;
	Mon, 21 Jul 2025 13:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753103886; cv=none; b=MLzAocQB7z0iKMgwmwN0zPC1dKsrDnKlUhKyhvSfpkersoymfZynTRibIbUvYZPxdFrz0deeIL2jby4FhR6V8iX49v2w6y6kblZ9wIuMWXhO44xtD94qV5gDI2DB4iOowD0gWLT+6IRv97cq9Dr/vGtsx3xN0vUah26dCUKnV4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753103886; c=relaxed/simple;
	bh=dGm4NQ+3hGK/6za3afP2H7y1+PzpmhYcTH4ocGmLxsM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZBbUNXR8PEfoh0O5hVRhGzq4BVVPw6N1//V2AnIuWfs0rAiqkdG8LYJKk0S2KWYsOpKDaxG5ybuMPiIUOqBFs12qRapGRdlVSGdCadHA4h+BFjNy8mzT0u9n8Nv3lOOvLSfHd301GoWxyLdQqBOjfNmVPqX/gl9IuAUnznK+0YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=rkcVs88b; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1753103879; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=WnaoPqjkhqlDN6kTZRO3wpxLenliqy2lR/lm2VYfgC4=;
	b=rkcVs88b+dc96OwGR3/nv1/xcBNjVE4AdaMd3WgC/jITbpvCs91H7w88KkzESvU8sV9NCCL03G0Fr+F+rOTEGHwL5XkWziy+DnIfer/04VLaxrXy+GE20FRqmmKgfByucn1x5JWCPNq1M81DWbKeigyNBoZXEiTYlZNMNw6BIaQ=
Received: from 30.246.160.95(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WjPkmgl_1753103876 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 21 Jul 2025 21:17:57 +0800
Message-ID: <25285fbd-ffab-49e5-a8be-e3a1c8e70d3c@linux.alibaba.com>
Date: Mon, 21 Jul 2025 21:17:55 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8] PCI: hotplug: Add a generic RAS tracepoint for hotplug
 event
To: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>,
 Matthew W Carlis <mattc@purestorage.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: anil.s.keshavamurthy@intel.com, bhelgaas@google.com, bp@alien8.de,
 davem@davemloft.net, linux-edac@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, mark.rutland@arm.com,
 mathieu.desnoyers@efficios.com, mhiramat@kernel.org, naveen@kernel.org,
 oleg@redhat.com, peterz@infradead.org, rostedt@goodmis.org,
 tianruidong@linux.alibaba.com, tony.luck@intel.com
References: <20250718163532.GA2700834@bhelgaas>
 <fc0ded97-8643-4faa-a606-732bcd4ce4a1@linux.alibaba.com>
 <aHtFG3QsdohG466k@wunner.de>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <aHtFG3QsdohG466k@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/7/19 15:11, Lukas Wunner 写道:
> On Sat, Jul 19, 2025 at 01:23:28PM +0800, Shuai Xue wrote:
>>             <...>-120     [002] .....   104.864051: pci_hp_event: 0000:00:03.0 slot:30, event:PCI_HOTPLUG_CARD_PRESENT
>>             <...>-120     [002] .....   104.864081: pci_hp_event: 0000:00:03.0 slot:30, event:PCI_HOTPLUG_LINK_UP
> 
> Somehow I liked the simple "Link Up" and "Card present" strings more
> than this. :)
> 
> The PCI_HOTPLUG substring repeats what pci_hp_event already betrays,
> that this is a hotplug event.

I think Bjorn's concern is mainly about parsing issues when strings
contain spaces.

So, how about using "Link_UP" and "Card_Present" instead?

> 
>>     irq/57-pciehp-120     [002] .....   104.990434: pci_link_event: 0000:00:03.0 cur_bus_speed:20, max_bus_speed:23, width:1, flit_mode:0, reason:5
>>     irq/57-pciehp-120     [002] .....   104.992377: pci_link_event: 0000:00:03.0 cur_bus_speed:20, max_bus_speed:23, width:1, flit_mode:0, reason:0
> 
> This contains a lot of terminology specific to PCI *Express*
> (versus Conventional PCI or PCI-X).  Either it needs to be
> "pcie_link_event" or we need to come up with a structure that
> works for non-PCIe as well.
> 

I see, I will rename it to pcie_link_event.

> PCI links can be tunneled over Thunderbolt, in this case the
> link speed is fixed to 2.5 GT/s (USB4 v1.0 sec 11.2.1), but
> in reality is governed by the speed of the Thunderbolt fabric
> (which can even be asymmetric).  Do we want to report the
> virtual 2.5 GT/s in this case or the actual Thunderbolt speed?
> Or do we want a separate trace event for Thunderbolt?

I'm not a user of Thunderbolt, which way do you prefer?

> 
> For Root and Downstream Ports, the physical "port" points "downstream",
> whereas for Upstream Ports and Endpoints, the physical "port" points
> "upstream".  Software interpreting the trace event may want to know
> the direction (or whatever one wants to call it) because it cannot
> tell from the address 0000:00:03.0 what the PCIe type is.  Having to
> look this up in lspci seems cumbersome.  So it may be worthwhile to
> include either the port's direction or the device's PCIe type in the
> trace event.
> 
> Of course, hotplug only exists at Root or Downstream Ports, so any
> trace event generated from the PCIe hotplug driver will pertain to
> a downstream-facing port.  But the bandwidth controller also binds
> to Upstream Ports and its trace events may thus pertain to link speed
> changes at an upstream-facing port.

Got it, i will device's PCIe type,

> 
> Thanks,
> 
> Lukas

Thanks for valuable comments.

Best Regards,
Shuai

