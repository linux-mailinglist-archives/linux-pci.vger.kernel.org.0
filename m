Return-Path: <linux-pci+bounces-17190-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC9DC9D568B
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2024 01:07:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CCBC2817F8
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2024 00:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9035CA31;
	Fri, 22 Nov 2024 00:07:50 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FE717C;
	Fri, 22 Nov 2024 00:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732234070; cv=none; b=kmbIEXykijRbnDSpa6plq42I47X6Uv//9cKly2ByKT8AhQye6+kzhl62+TZc6w2k6Ly6qf/yhm0sAquvqP2ndMUBc8F85NlnYkZyPuexx6O4qCktZHmRVseoilMGtsH1YXC1mKfm2k1quzrSHHD2ucdFLDYkx0+lqPYAtmX1Oho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732234070; c=relaxed/simple;
	bh=2hx0YHbz0UHwnC51Hk7bSwd0mYR4Maj8ubb9Zq6tLXc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B0rOYxpxv86hHwlIlXMnbZrtNMh+bzGHewwCKL3f789DHSgDh2UJ+lZqCk/Ga8GA1yqp9xw86l15BrnMHB9hZWEWlgM5q7e+VdYBDktUUD+DgK65OtKfozkaJR+RKNDGSFzjusGF0hSEi3A3bh1ypDOHsD6HcC9/+99qofbxiUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12C54C4CECC;
	Fri, 22 Nov 2024 00:07:47 +0000 (UTC)
Date: Thu, 21 Nov 2024 19:08:26 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Shuai Xue <xueshuai@linux.alibaba.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bhelgaas@google.com,
 tony.luck@intel.com, bp@alien8.de, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, oleg@redhat.com, naveen@kernel.org,
 davem@davemloft.net, anil.s.keshavamurthy@intel.com, mark.rutland@arm.com,
 peterz@infradead.org
Subject: Re: [PATCH v3] PCI: hotplug: Add a generic RAS tracepoint for
 hotplug event
Message-ID: <20241121190826.78506b40@gandalf.local.home>
In-Reply-To: <Zz-9vviSWP8oRPUx@wunner.de>
References: <20241120124328.19111-1-xueshuai@linux.alibaba.com>
	<Zz786zZljAy2J5i7@wunner.de>
	<7002248c-f3af-42aa-ba42-a65cd738ae37@linux.alibaba.com>
	<20241121084354.4a554829@gandalf.local.home>
	<Zz-9vviSWP8oRPUx@wunner.de>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 Nov 2024 00:09:50 +0100
Lukas Wunner <lukas@wunner.de> wrote:

> Would something like
> 
>   /sys/kernel/debug/tracing/events/pci/hotplug_event
> 
> be possible?  It would seem more elegant than
> 
>   /sys/kernel/debug/tracing/events/pci/pci_hp_event
> 
> because it avoids the duplication of "pci" in the path.

Most events have the name of the system in it (see the sched events).
That's to prevent the duplicates in other places. Also, in the trace
output, only the event name is shown and not the system. That is, if you
have more than one "hotplug_event" enabled, the trace will not
differentiate them.

My suggestion is the "pci_hp_event" as it will be more obvious in the trace
output.

-- Steve

