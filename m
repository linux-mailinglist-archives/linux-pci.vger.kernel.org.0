Return-Path: <linux-pci+bounces-19902-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A19A126D6
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 16:05:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2810162318
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 15:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF2F13B787;
	Wed, 15 Jan 2025 15:05:47 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B7878F51;
	Wed, 15 Jan 2025 15:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736953547; cv=none; b=DAgaFg0S/0MFmiaYjy13DCyE0zxQs6AX6ryZkuOavM656suq9Z2HjbliQgagQNMRXKj0Y7AI1seN58ariXBlnQjkYvIryR3iZS94PYNSRnduRS9Jk15Ni0T8SJNJHaxtyPdes9sjsMr9Vaaq6ClSPEn8k/1jS6DJuptkAnUhnq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736953547; c=relaxed/simple;
	bh=opTS2U3tuqL1C2qtjV3d9kz7V9h5/TRmVLaoYsVjn8o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gqc/rPhrowWVwFM2Be0nLZwR+1slCvWeWW0QWZNQcNEQWESL7P5HjImajcNzCF88IffYHMi1zYCmnz4L7DFse0X1jWz/fZ28nE+pWuQ7J6YcBbbqai1Gn5dWFMdGzIRcho+Ud9ffqW08+XkCyxbop4bAon6DfEplTvF5PQsp9JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5DE5C4CED1;
	Wed, 15 Jan 2025 15:05:44 +0000 (UTC)
Date: Wed, 15 Jan 2025 10:05:47 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Shuai Xue <xueshuai@linux.alibaba.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, helgaas@kernel.org,
 bhelgaas@google.com, tony.luck@intel.com, bp@alien8.de,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, oleg@redhat.com,
 naveen@kernel.org, davem@davemloft.net, anil.s.keshavamurthy@intel.com,
 mark.rutland@arm.com, peterz@infradead.org, tianruidong@linux.alibaba.com
Subject: Re: [PATCH v6] PCI: hotplug: Add a generic RAS tracepoint for
 hotplug event
Message-ID: <20250115100547.63dec2d7@gandalf.local.home>
In-Reply-To: <Z4eA866i9eup6os3@wunner.de>
References: <20250115013753.49126-1-xueshuai@linux.alibaba.com>
	<20250114214103.6b45d30d@gandalf.local.home>
	<7b482de1-fa19-45d6-bd05-f1c3ebb77192@linux.alibaba.com>
	<Z4eA866i9eup6os3@wunner.de>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 15 Jan 2025 10:33:39 +0100
Lukas Wunner <lukas@wunner.de> wrote:

> > > 
> > > 	TP_STRUCT__entry(
> > > 		__string(	port_name,	pci_name(ctrl->pcie->port)	)
> > > 		__string(	slot,		slot_name(ctrl)			)
> > > 		__field(	int,		event				)
> > > 
> > > and everything else could be the same.  
> > 
> > Maybe it's not a good idea.
> > 
> > I think pci_hp_event is a generic event for pciehp, shpchp, octep_hp, etc.
> > But each hotplug driver has different `struct controller` and slot_name().  
> [...]
> > So, IMHO, pass port_name and slot_name from each driver is more simple.
> > 
> > + @Lukas for hotplug part.  
> 
> You're right Shuai, there's several hotplug drivers in drivers/pci/hotplug/
> and pciehp is just one of them.  It's quite possible that other drivers
> besides pciehp will want to add trace points as well.  For consistency,
> the trace event definitions need to work for all drivers.

OK, if this is a generic trace event then it does make sense sending in the
names instead of the structure.

-- Steve

