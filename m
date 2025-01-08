Return-Path: <linux-pci+bounces-19556-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E78A063E0
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 18:59:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C46A7A1FDC
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 17:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986C62010E2;
	Wed,  8 Jan 2025 17:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r0W61zLs"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3259200BA1;
	Wed,  8 Jan 2025 17:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736359148; cv=none; b=bEpPDmtPbyG7Rfan2QrriG4VjtbXrOSMgICC1ljTm3KOUI+exRCdXlYHkeaMiykmq4+Lyad9qcHEaoZuQb+d9cQh9gn9wu8GiNwDKsGgjTFMVKmidg95AiBlbDqPcpndalhhfOhazw+RC06kHcPdxvQqonpbDu3rE0DKOhYozio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736359148; c=relaxed/simple;
	bh=O2XDXD8Xm7GHb5KI+CthKfj6xXSH1ionPxcoedIrqco=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Qo2kpn26HzrkN0n+hGBFJb/zE9dozuXr6/fPjZhmv/4rPgSmUYvx/7yQbRF6Ui0yuDohh4enUoXOwpH2I030riUYPdiQfb3hwC7i3EzNNFKXlyPXCGylg3z43Kk/vAeIBjTZhEkK2jVCTJBFaR7U6IhH7Et0Ms33Ry2bsE3xgRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r0W61zLs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E85CDC4CED3;
	Wed,  8 Jan 2025 17:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736359148;
	bh=O2XDXD8Xm7GHb5KI+CthKfj6xXSH1ionPxcoedIrqco=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=r0W61zLsjnC0R+u4ELOMlREs7x0YRTCqSnja79nlKb58/aTvmXArPcGnISdzO1Qxn
	 jZB2lrpWgmZ3AD9LgO4GxXidw0oIlugy+DXhH5yDOa7sRuLz2u2W9paMA1bTwGQewt
	 lMuzaAviw34ypwJt5wni6iOH+mDzXdQ7SU/cKdUELl+EpA9/acSfrAdBOV0KZRG3Y3
	 /jYxHR8SSIujXliosSCm6RfSpRkVkLAd+IXKUax+viwxlWz4UyF96TcPn+oKaxsQeG
	 i2A2KWaH33atYBsYj8NY7aWbDJb7fUnC22ZguEpq8oOYkNmiyeZc8Wg9WnD6MRTwY2
	 qKghQVkR44NLg==
Date: Wed, 8 Jan 2025 11:59:06 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: rostedt@goodmis.org, lukas@wunner.de, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, bhelgaas@google.com,
	tony.luck@intel.com, bp@alien8.de, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, oleg@redhat.com, naveen@kernel.org,
	davem@davemloft.net, anil.s.keshavamurthy@intel.com,
	mark.rutland@arm.com, peterz@infradead.org
Subject: Re: [PATCH v4] PCI: hotplug: Add a generic RAS tracepoint for
 hotplug event
Message-ID: <20250108175906.GA219807@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <309dd6e6-53ec-4f82-94ca-242941bd7136@linux.alibaba.com>

On Wed, Jan 08, 2025 at 05:04:25PM +0800, Shuai Xue wrote:
> 在 2025/1/8 07:19, Bjorn Helgaas 写道:
> > On Sat, Nov 23, 2024 at 07:31:08PM +0800, Shuai Xue wrote:
> > > Hotplug events are critical indicators for analyzing hardware health,
> > > particularly in AI supercomputers where surprise link downs can
> > > significantly impact system performance and reliability. The failure
> > > characterization analysis illustrates the significance of failures
> > > caused by the Infiniband link errors. Meta observes that 2% in a machine
> > > learning cluster and 6% in a vision application cluster of Infiniband
> > > failures co-occur with GPU failures, such as falling off the bus, which
> > > may indicate a correlation with PCIe.[1]
> > > 
> > > To this end, define a new TRACING_SYSTEM named pci, add a generic RAS
> > > tracepoint for hotplug event to help healthy check, and generate
> > > tracepoints for pcie hotplug event. To monitor these tracepoints in
> > > userspace, e.g. with rasdaemon, put `enum pci_hotplug_event` in uapi
> > > header.
> > > 
> > > The output like below:
> > > $ echo 1 > /sys/kernel/debug/tracing/events/pci/pci_hp_event/enable
> > > $ cat /sys/kernel/debug/tracing/trace_pipe
> > >             <...>-206     [001] .....    40.373870: pci_hp_event: 0000:00:02.0 slot:10, event:Link Down
> > > 
> > >             <...>-206     [001] .....    40.374871: pci_hp_event: 0000:00:02.0 slot:10, event:Card not present
> > > 
> > > [1]https://arxiv.org/abs/2410.21680
> > 
> > Doesn't apply on pci/main (v6.13-rc1); can you rebase it?
> 
> Sure. Do you mean Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git
>   branch main

Yes.  The most recent -rc1 is generally a safe bet for basing patches.

> > Probably more detail than necessary about AI supercomputers,
> > Infiniband, vision applications, etc.  This is a very generic issue.
> 
> Agreed. It is generic. Are you asking for the first background paragraph to be
> deleted?

I think the important part is that hotplug and link down events are
critical indicators of hardware health.  That's enough to motivate
this patch.

> > "Falling off the bus" doesn't really mean anything to me.  I suppose
> > it's another way to describe a "link down" event that leads to UR
> > errors when trying to access the device?
> 
> Sorry for the confusion. "Falling off the bus" is a common error for
> NVIDIA GPU observed in production. The GPU driver will log a such
> message when GPU is not accessible.

Yep, I see those too, and I wish the message weren't phrased so
casually.  IIRC this is typically logged when an MMIO read returns ~0,
which happens when a UR or similar error occurs.

> > I'm guessing that monitoring these via rasdaemon requires more than
> > just adding "enum pci_hotplug_event"?  Or does rasdaemon read
> > include/uapi/linux/pci.h and automagically incorporate new events?
> > Maybe there's at least a rebuild involved?
> 
> Yes, a rebuild is needed. Rasdaemon has a basic infrastructure to manually
> register a tracepoint event handler. For example, for this new event, we can
> register to handle pci_hp_event:
> 
>     rc = add_event_handler(ras, pevent, page_size, "pci", "pci_hp_event",
> 			   ras_pci_hp_event_handler, NULL, PCI_HOTPLUG_EVENT);

I would say something like "Add enum pci_hotplug_event in
include/uapi/linux/pci.h so applications like rasdaemon can register
tracepoint event handlers for it."

Bjorn

