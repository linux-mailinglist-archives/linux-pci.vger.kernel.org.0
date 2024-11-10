Return-Path: <linux-pci+bounces-16403-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6042B9C33D8
	for <lists+linux-pci@lfdr.de>; Sun, 10 Nov 2024 17:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 892221C209CD
	for <lists+linux-pci@lfdr.de>; Sun, 10 Nov 2024 16:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A4812BF24;
	Sun, 10 Nov 2024 16:52:08 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13782B9A6;
	Sun, 10 Nov 2024 16:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731257528; cv=none; b=WTBBl5gOe56CczYqxYfjKfVh2NaDb+HlZsLbvZhgrdZTgRj6UhHBcxnFNK/Sey3HWSeujWHMJuIIOoF3V7o1W+DbRE7gQ3m+cL6FJlLPT94MUL1C1D4xV7Xt4ncaSFexFX1QE24tu/3U4C6IgxICymYKkZTMXjm1KOHpgLrrB8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731257528; c=relaxed/simple;
	bh=+y86gxO0Qzp7rWLMZ6NDFXF5z9IpPHPeGKuzAxRUdIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ELOTg2A4qVYtJRYXPfWdIHu6dBwvQRMooWgvXtwcM4oRs6IvINMGSA/5bw7R6xXQmOo79Q3BvbI2xBh0SVBxgrzSYOrGesVT4Ap3Cxggl/0Hkw+ZGvUFWmXayXZDaTjJnj2bJYXuGR8lOyDRh9tjkVmWJc6BVUJyIJs3FTEVRc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 2828428017287;
	Sun, 10 Nov 2024 17:44:53 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 0CDCB1AD7F2; Sun, 10 Nov 2024 17:44:53 +0100 (CET)
Date: Sun, 10 Nov 2024 17:44:53 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-edac@vger.kernel.org, bhelgaas@google.com,
	tony.luck@intel.com, bp@alien8.de
Subject: Re: [RFC PATCH] PCI: pciehp: Generate a RAS tracepoint for hotplug
 event
Message-ID: <ZzDjBQaO2YjUlsjz@wunner.de>
References: <20241108030939.75354-1-xueshuai@linux.alibaba.com>
 <Zy-hbwLohwf-_hCN@wunner.de>
 <faccb715-8d9f-4761-855a-0fb8be2ebad4@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <faccb715-8d9f-4761-855a-0fb8be2ebad4@linux.alibaba.com>

On Sun, Nov 10, 2024 at 06:12:09PM +0800, Shuai Xue wrote:
> 2024/11/10 01:52, Lukas Wunner:
> > On Fri, Nov 08, 2024 at 11:09:39AM +0800, Shuai Xue wrote:
> > > --- a/drivers/pci/hotplug/pciehp_ctrl.c
> > > +++ b/drivers/pci/hotplug/pciehp_ctrl.c
> > > @@ -19,6 +19,7 @@
> > >   #include <linux/types.h>
> > >   #include <linux/pm_runtime.h>
> > >   #include <linux/pci.h>
> > > +#include <ras/ras_event.h>
> > >   #include "pciehp.h"
> > 
> > Hm, why does the TRACE_EVENT() definition have to live in ras_event.h?
> > Why not, say, in pciehp.h?
> 
> IMHO, it is a type of RAS related event, so I add it in ras_event.h,
> similar to other events like aer_event and memory_failure_event.
> 
> I could move it to pciehp.h, if the maintainers prefer that location.

IMO pciehp.h makes more sense than ras/ras_event.h.

The addition of AER to ras/ras_event.h was over a decade ago with
commit 0a2409aad38e ("trace, AER: Move trace into unified interface").
That commit wasn't acked by Bjorn.  It wasn't even cc'ed to linux-pci:

https://lore.kernel.org/all/1402475691-30045-3-git-send-email-gong.chen@linux.intel.com/

I can see a connection between AER and RAS, but PCI hotplug tracepoints
are not exclusively RAS, they might be useful for other purposes as well.
Note that pciehp is not just used on servers but also e.g. for Thunderbolt
on mobile devices and the tracepoints might come in handy to debug that.


> > Wouldn't it be more readable to just log the event that occured
> > as a string, e.g. "Surprise Removal" (and "Insertion" or "Hot Add"
> > for the other trace event you're introducing) instead of the state?
> > 
> > Otherwise you see "ON_STATE" in the log but that's actually the
> > *old* value so you have to mentally convert this to "previously ON,
> > so now must be transitioning to OFF".
> 
> I see your point. "Surprise Removal" or "Insertion" is indeed the exact
> state transition. However, I am concerned that using a string might make
> it difficult for user space tools like rasdaemon to parse.

If this is parsed by a user space daemon, put the enum in a uapi header,
e.g. include/uapi/linux/pci.h.


> How about adding a new enum for state transition? For example:
> 
> 	enum pciehp_trans_type {
> 		PCIEHP_SAFE_REMOVAL,
> 		PCIEHP_SURPRISE_REMOVAL,
> 		PCIEHP_Hot_Add,
> 	...
> 	}

In that case, I'd suggest adding an entry to the enum for all the
ctrl_info() messages, i.e.

Link Up
Link Down
Card present
Card not present

Amend pciehp_handle_presence_or_link_change() with curly braces
around all the affected if-blocks and put a trace event next to the
ctrl_info() message.

Also, since these events are not pciehp-specific, I'd call the enum
something like pci_hotplug_event and the entries PCI_HOTPLUG_...
(or PCI_HP_... if you prefer short names).  These trace events could
in principle be raised by any of the other hotplug drivers in
drivers/pci/hotplug/, not just pciehp.

Thanks,

Lukas

