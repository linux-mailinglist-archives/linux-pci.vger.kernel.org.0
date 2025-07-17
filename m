Return-Path: <linux-pci+bounces-32445-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2B1B09490
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 21:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A32225833C4
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 19:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E88A298CA1;
	Thu, 17 Jul 2025 19:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N+igieEw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B432163BD;
	Thu, 17 Jul 2025 19:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752779272; cv=none; b=CVAkUAw5AD5Jt+7iojLUtl+RNKT18xyJG2R2Ur/STf9mnfYYJknA6KWv5uM1X/0fZNh7dyfMOn4mJ5A5OXsk67gWiNkb7UoV+mUu8DLDQK8UyRkpx9P/qlMssPLHh4mtAayKWtWVrPmfRN+W6sE0gtdkkX4LVNfz8alYze5eoOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752779272; c=relaxed/simple;
	bh=PKFjRqVwhUwPbYtM13D4640UBaWEd7kT1tK0lbdIN0E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=jUs8xR4ISxZXWidPqdjsTF414mMEQgSpf+MrbNuXbZwJF3uX4ClpsTkQYr0jyRQbj6YRPdEkWvBIx9OKmyhACBlUdqhiIQ6+5CDwUSiS7lKetbgDmZ6khd5mEgVTPm3NUFqWIwf7u86i7kzsG/ZF1z4zWOlIVj2Kyp3pZu+Kqrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N+igieEw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC017C4CEE3;
	Thu, 17 Jul 2025 19:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752779271;
	bh=PKFjRqVwhUwPbYtM13D4640UBaWEd7kT1tK0lbdIN0E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=N+igieEwq4MRp14XvuTho3hv1FOnkG9+CHfPQ3Lp42p4/0JQnAVOU3aULMXucnQK5
	 pgkBX5sZzTU6vjJp+euu0mEV8zSulxaZK2IzO7xbt+BFd6/ieB8KtWodaOYFYAoaJj
	 UXgLfd6ECTjgXS08L9dFUWFV9YIvI7gCpENCwsPFp5lL9QirKO9foFui4k328Nb/uN
	 mL7tIWM6aVi7zR9jKB1FnbnvQgDoXJFcHV5LqYigEIu0So10spoVAb/FHeOMYsxe+z
	 /Dwu2jTbRceaZR6wzgFJ2CU7xZZxtFf1xMfggcqUaf9eu8qUKOjuSlP8tk3jnLQv2B
	 YU3X/zcjsKAUg==
Date: Thu, 17 Jul 2025 14:07:50 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Matthew W Carlis <mattc@purestorage.com>
Cc: xueshuai@linux.alibaba.com, anil.s.keshavamurthy@intel.com,
	bhelgaas@google.com, bp@alien8.de, davem@davemloft.net,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	lukas@wunner.de, mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org,
	naveen@kernel.org, oleg@redhat.com, peterz@infradead.org,
	rostedt@goodmis.org, tianruidong@linux.alibaba.com,
	tony.luck@intel.com,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v8] PCI: hotplug: Add a generic RAS tracepoint for
 hotplug event
Message-ID: <20250717190750.GA2592519@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717172826.22120-1-mattc@purestorage.com>

[+cc Ilpo, Jonathan]

On Thu, Jul 17, 2025 at 11:28:26AM -0600, Matthew W Carlis wrote:
> A bit late to the discussion here..  Looks like "too late" in fact,
> but I wanted to just make some comments.

Not too late, thanks for your thoughts!  When I apply things, I
consider them a draft with intention to go upstream, but not
immutable.  If it makes sense to revise or postpone, we can still do
that.

> On Tue, 12 May 2025, Shuai Xue wrote:
> > Hotplug events are critical indicators for analyzing hardware
> > health,
> 
> In terms of a "hot plug" event I'm not actually sure what that
> means. I mean to say that the spec has some room for different
> implementations.  I think sometimes that means a presence detect
> state change event, but a system is not required to implement a
> presence pin (at least not for the Slot Status presence). Some
> vendors support an "inband" presence which is when the LTSSM
> essentially asserts presence if the link is active and deasserts it
> when the link is down.
> 
> Appendix I in the newer PCIe specs say to use data link layer state
> change event if presence is not implemented. It looks like this
> tracepoint would still work, but its just something to keep in mind.
> At the risk of including too much information I could see it also
> being useful to put the device/vendor IDs of the DSP and the EP into
> the trace event for link up. Perhaps even the link speed/width cap
> for DSP/EP. The real challenge with tracking a fleet is getting all
> the things you care about into one place.
> 
> On Tue, 20 May 2025, Lukas Wunner wrote:
> > Link speed changes and device plug/unplug events are orthogonal
> 
> I guess what I wanted to get at here were some of the discussion
> from Lukas & Ilpo. I think it makes sense to separate presence
> events from link events, but I think it would make sense to have a
> "link tracepoint" which reports previous and new speed. One of those
> speeds being DOWN/DISABLED etc. Width could be in there as well. I
> have seen many times now an engineer become confused about checking
> speed because "Current Link Speed" & "Negotiated Link Width" are
> "undefined" when "Data Link Layer Active" bit is unset. Ideally a
> solution here would be immediately clear to the user.
> 
> When it comes to tracking things across a "fleet" having the slot
> number of the device is extremely useful. We have an internal
> specification for our slot number assignments that allows us to
> track meaning across different generations of hardware or different
> architectures. The BDF is often changing between generations, but
> the meaning of the slot is not.

All the tracepoints here already include:

  - pci_name() (the bus/device/function)

  - slot_name() (which I think comes from make_slot_name(); would you
    want something else?)

and IIUC, it would be helpful for you to add:

  - DSP Vendor/Device ID (the Root Port or Switch Downstream Port,
    which is relatively static, so seems less useful to me than the
    USP/EP would be)

  - USP/EP Vendor/Device ID

And you would consider adding a new format for "Link Up" that would
include the above plus current link speed/width?  I expect we will
likely see new tracepoints similar to "Link Up" for link speed/width
changes done by bwctrl, and this would definitely make sense for
those.

As a consumer of tracepoints, do you have an opinion on the event
string?  I wonder if spaces in the strings complicate searching and
scripting?  I don't think tracepoints necessarily need to match text
in dmesg exactly because I suspect they're mostly processed
mechanically.  But I'm not a tracepoint user myself (yet), and about
20% of existing tracepoints already include spaces, so maybe it's not
a concern.

Bjorn

