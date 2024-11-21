Return-Path: <linux-pci+bounces-17189-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D8199D560E
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2024 00:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BFA5B2180F
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2024 23:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332061DE2A1;
	Thu, 21 Nov 2024 23:10:04 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7032C23098E;
	Thu, 21 Nov 2024 23:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732230604; cv=none; b=RMpN++g/wF2j/5YRpPB9sy62F2zGrJaAqvtC90enRcaYR6qnhZNaZ2hv8WrSrAotXZMJv8U6eX14Mzvl92WxjRqww5BIlQdwihY9yp5Bi01Yw75ebBc34EE43koTF4Jc3Oa+xLFdqZXUjsmYQSVDTyuZ4N8QK1jhONDoUOxWUkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732230604; c=relaxed/simple;
	bh=6tTZz3sao9WY5s+VJbUEW5RMKf+iTRCr9kuCxAehess=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LqyGia3aGY2ubXtWg//hhiNMFs5j2CdhD+4dJdC3hsuXtw13RguTwiKDjdotFzz0833xK43yQarYE8JTdap/TDF1EnU1RF6+e3PUAgGoG8nW6waQo5yCawdZNbUgSdTp4vA/WqLergHwl2/+DCYt9+VM/2YhxYXVSRhXALbVHq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 33ECA102CB650;
	Fri, 22 Nov 2024 00:09:51 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 075F04F1110; Fri, 22 Nov 2024 00:09:51 +0100 (CET)
Date: Fri, 22 Nov 2024 00:09:50 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Shuai Xue <xueshuai@linux.alibaba.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, bhelgaas@google.com,
	tony.luck@intel.com, bp@alien8.de, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, oleg@redhat.com, naveen@kernel.org,
	davem@davemloft.net, anil.s.keshavamurthy@intel.com,
	mark.rutland@arm.com, peterz@infradead.org
Subject: Re: [PATCH v3] PCI: hotplug: Add a generic RAS tracepoint for
 hotplug event
Message-ID: <Zz-9vviSWP8oRPUx@wunner.de>
References: <20241120124328.19111-1-xueshuai@linux.alibaba.com>
 <Zz786zZljAy2J5i7@wunner.de>
 <7002248c-f3af-42aa-ba42-a65cd738ae37@linux.alibaba.com>
 <20241121084354.4a554829@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241121084354.4a554829@gandalf.local.home>

On Thu, Nov 21, 2024 at 08:43:54AM -0500, Steven Rostedt wrote:
> On Thu, 21 Nov 2024 19:34:31 +0800
> Shuai Xue <xueshuai@linux.alibaba.com> wrote:
> > Sure, I can reorganize the directory. You have two optional proposals:
> > 
> > 1. /sys/kernel/debug/tracing/events/pci_hp_event
> > 2. /sys/kernel/debug/tracing/events/pci/pci_hp_event
> > 
> > I personally prefer the second approach.
[...]
> That said, is all these events going to be related to hotplug? If so, you
> probably want "hotplug" or "hp" in the system name. If you make it just
> "pci", then it will be expected that all the events will be related to PCI
> in general.

Grouping them under "pci" probably makes more sense than grouping them
under "hotplug".  A lot can be hotplugged (cpu, memory, PCI, USB, ...)
but it's mostly unrelated hardware and enabling all their events at once
doesn't seem to make much sense.  Whereas I can imagine people want to
enable all PCI trace events.  We currently only have tracepoints for AER
in the PCI core, but perhaps people will want to add new ones for
power faults, DPC recovery, bandwidth control etc.

Would something like

  /sys/kernel/debug/tracing/events/pci/hotplug_event

be possible?  It would seem more elegant than

  /sys/kernel/debug/tracing/events/pci/pci_hp_event

because it avoids the duplication of "pci" in the path.

Thanks,

Lukas

