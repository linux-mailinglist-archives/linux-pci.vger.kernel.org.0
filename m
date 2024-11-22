Return-Path: <linux-pci+bounces-17191-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E2A99D57DF
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2024 02:55:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C72F4B21C4A
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2024 01:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10441779BD;
	Fri, 22 Nov 2024 01:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="s2VpgaRV"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BBB16BE14;
	Fri, 22 Nov 2024 01:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732240405; cv=none; b=PVh/xaJWaCfYHYq9W8IFoNXQ0Hx6jLvwnAayM4vE1r0yxwaeyg4Dj9lFBqXrv1KeQDRjk+605iQJ46WvtOeixpd6PYAhz3WUsf80lNJ3GULe5OqjPqJV5b6IyPfIjXMaHddfhBPmYivNwRTtjQP2m0ZPUGJzU7ZDU9bJS/f+I+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732240405; c=relaxed/simple;
	bh=mLlfRtBu8W4YXdufHsN+Hh7aEi5K5STCPwNPOH+/4ZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UyA6Bn5GV/5XHwvyd/uMfDue91RQSaZf6IqR7z0qdIADv/vH7JK1gIZY81YWu3MTIyC2iL9wT/TTszBG2LegyhAhb4vluXXCub6BNXaIizmB7GEA7suxOHdTDyd+qXhEqiPbNwksyFhKSSBAN+4Lf5xz5aOgmVHk1MUTUXAKR/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=s2VpgaRV; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1732240394; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=0w7XvBE2P7BNoXQjEnWX/nWFWyUO7hkvrfRZsmxX9RM=;
	b=s2VpgaRVQVXUwEqTy1NmuNoSe6VOJV5XqnBOqjANnqAyJJnzFzwaw82hQkIZOLCKkHjOmHgMmWFmhft6rrdtNYlz9aCq4BtvEcGHJ89oEWvPMEA12t6fp4KsqeUWupjzePABqENjGgZ1X0Iu4v3SFmHGZMZiSGDm3PYfWL+WjIc=
Received: from 30.246.161.197(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WJyg7UH_1732240390 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 22 Nov 2024 09:53:12 +0800
Message-ID: <3f9b87c0-ff22-433f-adca-80716502c28f@linux.alibaba.com>
Date: Fri, 22 Nov 2024 09:53:10 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] PCI: hotplug: Add a generic RAS tracepoint for hotplug
 event
To: Steven Rostedt <rostedt@goodmis.org>, Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-edac@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bhelgaas@google.com, tony.luck@intel.com, bp@alien8.de, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, oleg@redhat.com, naveen@kernel.org,
 davem@davemloft.net, anil.s.keshavamurthy@intel.com, mark.rutland@arm.com,
 peterz@infradead.org
References: <20241120124328.19111-1-xueshuai@linux.alibaba.com>
 <Zz786zZljAy2J5i7@wunner.de>
 <7002248c-f3af-42aa-ba42-a65cd738ae37@linux.alibaba.com>
 <20241121084354.4a554829@gandalf.local.home>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20241121084354.4a554829@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/11/21 21:43, Steven Rostedt 写道:
> On Thu, 21 Nov 2024 19:34:31 +0800
> Shuai Xue <xueshuai@linux.alibaba.com> wrote:
> 
>> Sure, I can reorganize the directory. You have two optional proposals:
>>
>> 1. /sys/kernel/debug/tracing/events/pci_hp_event
> 
> I'm guessing the above has TRACING_SYSTEM = pci_hp_event ? That is, the
> above is a system and not an event.
> 
>> 2. /sys/kernel/debug/tracing/events/pci/pci_hp_event
> 
> Whereas here, it's an event.
> 
>>
>> I personally prefer the second approach. However, I'll defer the final decision
>> to the tracing subsystem maintainer, considering their expertise and
>> familiarity with the existing conventions.
> 
> Normally the system is determined by the users of the tracing
> infrastructure and not the tracing maintainers. But I can give you some
> guidelines.
> 
> The "system" level:
> 
>    /sys/kernel/tracing/events/<system>
> 
> is just a way to group like events making it easier to enable them all at once:
> 
>   echo 1 > /sys/kernel/tracing/events/<system>/enable
> 
> or
> 
>    trace-cmd start -e <system>
> 
> The name of the "system" should be something that all the events underneath
> represent. Note, although events in two different systems can have the same
> name, it's best to try to keep them all unique. That's because if you have:
> 
> 
>   systemA/foo  and systemB/foo
> 
> If you add to the kernel command line: trace_event=foo
> it will enable both events. Although that could be fixed with: trace_event=systemA:foo
> 
> Note: trace_event=systemA  would enable all systemA events at boot.
> 
> That said, is all these events going to be related to hotplug? If so, you
> probably want "hotplug" or "hp" in the system name. If you make it just
> "pci", then it will be expected that all the events will be related to PCI
> in general.

I think Lukas is asking for a system for pci related tracepoint.

> 
> Does that help?

Yes, it really does.

> 
> -- Steve

Thanks a lot.

Best Regards,
Shuai


