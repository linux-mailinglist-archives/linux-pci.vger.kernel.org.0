Return-Path: <linux-pci+bounces-19481-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 306BEA04D58
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 00:19:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 213F016645A
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 23:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430471E0DE6;
	Tue,  7 Jan 2025 23:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P4nz+26N"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EAB9273F9;
	Tue,  7 Jan 2025 23:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736291987; cv=none; b=ndR99Uz84rB6eDNSoidcLH8BTHdD8VSO7Z2NLRZ98OPWse2IKiOfgc1mEd+DecanF42XzsI6WSXKN96ZSqESj//6DClYlf/GGUvK7VB5EyxKdPEfyVEUXEAipBMcPxfaElgnAGOUAG58B42bwzHsItRr3emqtut1kf84jDNBjcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736291987; c=relaxed/simple;
	bh=uLe1aQ1N0NaquwCKd57H9kZ0jKwjEuy0gX6CElECvDU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=h1q/tdNMUoDvr//69iHtu6DOSAx3ow0LlaB5oXEFpVypnfuFN7pEgYiRcwB/HwmfsTC5xTS1eyh26/L/eTEIs3Es1FemYNnc7zWZLdReTAuRhTnkLn/Z9PjxNSDElKSyHN9+sg6++ErIEk4yLhDAR6MXkBa59W9WUeCiZ0hp7m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P4nz+26N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99746C4CED6;
	Tue,  7 Jan 2025 23:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736291986;
	bh=uLe1aQ1N0NaquwCKd57H9kZ0jKwjEuy0gX6CElECvDU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=P4nz+26N0LayYSPeauwv2Shgsz8JIenh60zoDjW9eZzMLxQd9rLfMpK39gq2odvh/
	 b8O13xVsX7n1M4XsBZH6xci8gcxq8iX+ZX2plA28eWU6WWm2HGPS1XKn7thb2egtln
	 pgldReXdxuu5CnUKVXsq4C8Ez414+xNRGPKXlJZzH21BHeOPJYWdVdG8LmHucmXoOe
	 v62QXVCmwoIvXZVqHHK8n+kqK2PCXznPW89oYW2Iq50ZNYIQ6suCMvvk72PA60tovv
	 1fQfcZ3crKsjA8AfMshSBd8EkiMP8aRo7+TXgQwztEw/++ps66M5VCeMzCd+cfNCtU
	 eNO9E5cQoN2AA==
Date: Tue, 7 Jan 2025 17:19:43 -0600
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
Message-ID: <20250107231943.GA189869@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241123113108.29722-1-xueshuai@linux.alibaba.com>

On Sat, Nov 23, 2024 at 07:31:08PM +0800, Shuai Xue wrote:
> Hotplug events are critical indicators for analyzing hardware health,
> particularly in AI supercomputers where surprise link downs can
> significantly impact system performance and reliability. The failure
> characterization analysis illustrates the significance of failures
> caused by the Infiniband link errors. Meta observes that 2% in a machine
> learning cluster and 6% in a vision application cluster of Infiniband
> failures co-occur with GPU failures, such as falling off the bus, which
> may indicate a correlation with PCIe.[1]
> 
> To this end, define a new TRACING_SYSTEM named pci, add a generic RAS
> tracepoint for hotplug event to help healthy check, and generate
> tracepoints for pcie hotplug event. To monitor these tracepoints in
> userspace, e.g. with rasdaemon, put `enum pci_hotplug_event` in uapi
> header.
> 
> The output like below:
> $ echo 1 > /sys/kernel/debug/tracing/events/pci/pci_hp_event/enable
> $ cat /sys/kernel/debug/tracing/trace_pipe
>            <...>-206     [001] .....    40.373870: pci_hp_event: 0000:00:02.0 slot:10, event:Link Down
> 
>            <...>-206     [001] .....    40.374871: pci_hp_event: 0000:00:02.0 slot:10, event:Card not present
> 
> [1]https://arxiv.org/abs/2410.21680

Doesn't apply on pci/main (v6.13-rc1); can you rebase it?

s/pcie/PCIe/ in English text.

Probably more detail than necessary about AI supercomputers,
Infiniband, vision applications, etc.  This is a very generic issue.

"Falling off the bus" doesn't really mean anything to me.  I suppose
it's another way to describe a "link down" event that leads to UR
errors when trying to access the device?

I'm guessing that monitoring these via rasdaemon requires more than
just adding "enum pci_hotplug_event"?  Or does rasdaemon read
include/uapi/linux/pci.h and automagically incorporate new events?
Maybe there's at least a rebuild involved?

Anything in the arxiv link that is specifically relevant to this patch
needs to be in the commit log itself.  But I think there's already
enough information here to motivate this change, and whatever is in
the arxiv link may be of general interest, but is probably not
required to justify, understand, or debug this useful functionality.

Bjorn

