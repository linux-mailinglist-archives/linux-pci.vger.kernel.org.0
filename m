Return-Path: <linux-pci+bounces-39357-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E288C0BF8E
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 07:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EB9E5348F1F
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 06:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8161C25A353;
	Mon, 27 Oct 2025 06:40:52 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59654220694;
	Mon, 27 Oct 2025 06:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761547252; cv=none; b=aJPp8mcxiOWnmGvqm4d3RWH3GvPl6Z+2EOcG1jDColaFY9e3dIC+38MwskZ44TaNyYoKLFLboIDR1hr7dhgjW1/iBYZMehHjklP6sappzfRkSEKJiM0S418bKPEd5izY9w1IekzPOjvWEzdGJaMyp8cBXbAcDD7S0gszKwvAdiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761547252; c=relaxed/simple;
	bh=1cPgG+9C6oCZXG+WREjZDOcDEmwQbfny6TBzvDyPlRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=thghfVGbA7xOZZ86eTFYqXz3Vr2GVL60A0aOPUNB2JKSxskw1rzTECM6W40j5q12d7g3qKwCYxBsneTQsJ4bxxhTnQX/NEeKlxcAmYQOv8IDkbq+UdMJzARUy60UuuAsTOKF6nhfDh/yjhqZPmDv+8W7jubdaNJixr13NQw44mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 138682C051FB;
	Mon, 27 Oct 2025 07:40:47 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id BABE74B2A; Mon, 27 Oct 2025 07:40:46 +0100 (CET)
Date: Mon, 27 Oct 2025 07:40:46 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Crystal Wood <crwood@redhat.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org, Attila Fazekas <afazekas@redhat.com>,
	linux-pci@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Bjorn Helgaas <helgaas@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver OHalloran <oohall@gmail.com>
Subject: Re: [PATCH] genirq/manage: Reduce priority of forced secondary IRQ
 handler
Message-ID: <aP8T7rahGYzJqnP5@wunner.de>
References: <83f58870043e2ae64f19b3a2169b5c3cf3f95130.1757346718.git.lukas@wunner.de>
 <87348g95yd.ffs@tglx>
 <aM_5uXlknW286cfg@wunner.de>
 <1b3684b424af051b5cb1fbce9ab65fc5cdf2b1a1.camel@redhat.com>
 <20251024133332.wSQOgUZb@linutronix.de>
 <de1ec7fcc1711e3062cc321ab55552339630de30.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de1ec7fcc1711e3062cc321ab55552339630de30.camel@redhat.com>

On Fri, Oct 24, 2025 at 04:00:02PM -0500, Crystal Wood wrote:
> On Fri, 2025-10-24 at 15:33 +0200, Sebastian Andrzej Siewior wrote:
> > On 2025-10-03 13:25:53 [-0500], Crystal Wood wrote:
> > > On Sun, 2025-09-21 at 15:12 +0200, Lukas Wunner wrote:
> > > > On Sat, Sep 20, 2025 at 11:20:26PM +0200, Thomas Gleixner wrote:
> > > > > I obviously understand that the proposed change squashs the whole
> > > > > class of similar (not yet detected) issues, but that made me look at
> > > > > that particular instance nevertheless.
> > > > > 
> > > > > All aer_irq() does is reading two PCI config words, writing one and
> > > > > then sticking 64bytes into a KFIFO. All of that is hard interrupt
> > > > > safe. So arguably this AER problem can be nicely solved by the below
> > > > > one-liner, no?
> > > > 
> > > > The one-liner (which sets IRQF_NO_THREAD) was what Crystal originally
> > > > proposed:
> > > > 
> > > > https://lore.kernel.org/r/20250902224441.368483-1-crwood@redhat.com/
> > > 
> > > So, is the plan to apply the original patch then?
> > 
> > Did we settle on something?
> > I wasn't sure if you can mix IRQF_NO_THREAD with IRQF_ONESHOT for shared
> > handlers. If that is a thing, we Crystal's original would do it.
> 
> Do you mean mixing IRQF_NO_THREAD on this irq (which should eliminate
> the forced IRQF_ONESHOT) with another shared irq that still has
> IRQF_ONESHOT?
> 
> I suspect it was a non-issue because of IRQCHIP_ONESHOT_SAFE disabling
> the forced oneshot (the other irq was pciehp).  Given that these are
> pcie-specific, do they ever get used without MSI (which sets
> IRQCHIP_ONESHOT_SAFE)[1]?

It seems fragile to depend on IRQCHIP_ONESHOT_SAFE.  What about irqchips
which don't set that?  What about PCIe ports which use legacy INTx
instead of MSI?

As Sebastian pointed out, setting IRQF_NO_THREAD for the AER driver but
not for any of the other PCIe port services risks starving the AER
primary handler if any of the other PCIe port services' (threaded)
primary handlers take a long time:

https://lore.kernel.org/r/20250904073024.YsLeZqK_@linutronix.de/

I went through all PCIe port services to see if IRQF_NO_THREAD could be
set on all of them.  Alas that's not possible:

pciehp's primary handler acquires a spinlock because of runtime PM API
calls (device->power.lock).  It's not a raw_spin_lock_t, so it becomes
a sleeping lock on RT which cannot be acquired in hardirq context and
converting to a raw_spin_lock_t would be non-trivial and probably
undesirable.

pme's primary handler also acquires a spinlock, this one could be
converted to a raw_spin_lock_t.

FWIW, PCIe port services requesting a (potentially shared) interrupt are:
drivers/pci/hotplug/pciehp_hpc.c
drivers/pci/pcie/aer.c
drivers/pci/pcie/dpc.c
drivers/pci/pcie/pme.c
drivers/pci/pcie/bwctrl.c

Long story short, I'll respin the patch to reduce the forced secondary
thread's priority, taking into account Thomas' feedback.
(Apologies for not having done this earlier.)

Thanks,

Lukas

