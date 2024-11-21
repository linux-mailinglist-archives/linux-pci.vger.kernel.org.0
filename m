Return-Path: <linux-pci+bounces-17163-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEDC29D4DF7
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2024 14:43:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4FC82819E0
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2024 13:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7D31D86C0;
	Thu, 21 Nov 2024 13:43:20 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FBA1D5CCD;
	Thu, 21 Nov 2024 13:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732196600; cv=none; b=mSwCIKD4ZdZ357bh1x6Kj76sML/3+2YNXVoHiTEPh9aLO10HN3LVF7uRjcG1AzO75um6Dr7jzBg47Dm5MZ5jZegSVvFiWDLgHnkUz5Q/cXdtrQI2L/nn55TWgYKOTzzcCkGWk4uOJlMJxyKjSz/2rF1I2dPlKa7nPDQ7j1W/ChI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732196600; c=relaxed/simple;
	bh=t1xS6VPnNXhFDtO31L5INNt/+JTUA64GJsQLsWahz44=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AG7pvr9N1KTYlytyRbvcNwWa8Hb/of5vsl+hwkBSfx0+ndekZidf+qEhUqf62ZDA7Na8Hn53OtAqUEngaJ6+ZboGPt3nGILM24VYwMXt8ylmlxxB4j4mUHASffDxTc4We7rZgVKWIjQiLPN1Rujy24ScM8JQrfkEBj4D8yqOeH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07634C4CECC;
	Thu, 21 Nov 2024 13:43:17 +0000 (UTC)
Date: Thu, 21 Nov 2024 08:43:54 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bhelgaas@google.com,
 tony.luck@intel.com, bp@alien8.de, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, oleg@redhat.com, naveen@kernel.org,
 davem@davemloft.net, anil.s.keshavamurthy@intel.com, mark.rutland@arm.com,
 peterz@infradead.org
Subject: Re: [PATCH v3] PCI: hotplug: Add a generic RAS tracepoint for
 hotplug event
Message-ID: <20241121084354.4a554829@gandalf.local.home>
In-Reply-To: <7002248c-f3af-42aa-ba42-a65cd738ae37@linux.alibaba.com>
References: <20241120124328.19111-1-xueshuai@linux.alibaba.com>
	<Zz786zZljAy2J5i7@wunner.de>
	<7002248c-f3af-42aa-ba42-a65cd738ae37@linux.alibaba.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 Nov 2024 19:34:31 +0800
Shuai Xue <xueshuai@linux.alibaba.com> wrote:

> Sure, I can reorganize the directory. You have two optional proposals:
> 
> 1. /sys/kernel/debug/tracing/events/pci_hp_event

I'm guessing the above has TRACING_SYSTEM = pci_hp_event ? That is, the
above is a system and not an event.

> 2. /sys/kernel/debug/tracing/events/pci/pci_hp_event

Whereas here, it's an event.

> 
> I personally prefer the second approach. However, I'll defer the final decision
> to the tracing subsystem maintainer, considering their expertise and
> familiarity with the existing conventions.

Normally the system is determined by the users of the tracing
infrastructure and not the tracing maintainers. But I can give you some
guidelines.

The "system" level:

  /sys/kernel/tracing/events/<system>

is just a way to group like events making it easier to enable them all at once:

 echo 1 > /sys/kernel/tracing/events/<system>/enable

or

  trace-cmd start -e <system>

The name of the "system" should be something that all the events underneath
represent. Note, although events in two different systems can have the same
name, it's best to try to keep them all unique. That's because if you have:


 systemA/foo  and systemB/foo

If you add to the kernel command line: trace_event=foo
it will enable both events. Although that could be fixed with: trace_event=systemA:foo

Note: trace_event=systemA  would enable all systemA events at boot.

That said, is all these events going to be related to hotplug? If so, you
probably want "hotplug" or "hp" in the system name. If you make it just
"pci", then it will be expected that all the events will be related to PCI
in general.

Does that help?

-- Steve


