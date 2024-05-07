Return-Path: <linux-pci+bounces-7172-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB888BE5E5
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2024 16:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9389F28F899
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2024 14:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4BA15ECF5;
	Tue,  7 May 2024 14:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KoH6ZvPO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jG/kf6O1"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6C8152196;
	Tue,  7 May 2024 14:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715092070; cv=none; b=SYMvlfk5ErxYVpAvZA9uy9Ot/jVB9bM1ITrSRZyPjkWpoZh+1ky3fTa6CWfJgbCEVVL1M7q25Ki4dmUVHmUedsPRH4V3NfkUVOvn3uqhlPhP5XB0ihfC3JBNcFvhItU6X21A8OhRv0iFLerryoPbtwJRg8NuypWx7pRo+DXIJL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715092070; c=relaxed/simple;
	bh=+Q+NydcMUcdWT3YLnEE9ECpiROxo2MNZO2wKlTzIxKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GmKA+2xmdOLmVdEpbhi3FAimG0q1PVcOyPQHbghW+6sHcLvO3RU3H3X8vOXZG/xI45m0WNFNwl5s9HCBGEUZb7r074ny69tyvx8gGeWDWPvp4mStc5o4nPtETaoiPda0ZECfFnOFFV57ZREPk0FwKAuqAsp5UsvGecwDkxzcm0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KoH6ZvPO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jG/kf6O1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 7 May 2024 16:27:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715092063;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ier8OnNlqjn0MPQE8OdCNPD0vTSAJTNYuTmOd4uysZs=;
	b=KoH6ZvPOGTAyZDMzUG7afOw8y0vbaZ2v8oF3PQFd/JkOoZVNrNI1Qr5k9tLeEyV2+GCmI1
	WwH/COAuU5Rzg+wTlY3l9lgcNqH5y20UUOu9MsokhVfNzKQp4/IqpWEOwG0tqdrBBiI00z
	LbAV8cSlcJZXs8itB/mO6sGtcLkNouKLBWDLMGbiCtu9VlG+K/ySEHZMb6ERFI+qohWFUx
	meV2bltRzScpy5hVl0QqsP4l4mKB1okiDXiRb3D4S/vLYKVK4li1EE8hHapFkGiX1BYWs7
	PhWhP5aj5pvd8SHRcHnzRXf6xSl+uiZG3qBglC7FJUG0Fjkym9Z7j75uwriGcQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715092063;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ier8OnNlqjn0MPQE8OdCNPD0vTSAJTNYuTmOd4uysZs=;
	b=jG/kf6O1dnlSfxsyOeqDhN+H2QhwbzS2XJILX2slkvUQs6+2YzwFwqpGbvF4NDOO9IdnZp
	PS94V4+zbTcAbCCg==
From: Nam Cao <namcao@linutronix.de>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Yinghai Lu <yinghai@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v2 2/2] PCI: pciehp: Abort hot-plug if
 pci_hp_add_bridge() fails
Message-ID: <20240507142738.wyj19VVh@linutronix.de>
References: <cover.1714838173.git.namcao@linutronix.de>
 <f3db713f4a737756782be6e94fcea3eda352e39f.1714838173.git.namcao@linutronix.de>
 <Zjcc6Suf5HmmZVM9@wunner.de>
 <20240505071451.df3l6mdK@linutronix.de>
 <20240506083701.NZNifFGn@linutronix.de>
 <ZjkxTGaAc48jPzqC@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjkxTGaAc48jPzqC@wunner.de>

On Mon, May 06, 2024 at 09:36:44PM +0200, Lukas Wunner wrote:
> On Mon, May 06, 2024 at 10:37:01AM +0200, Nam Cao wrote:
> > I just discovered a new crash scenario with shpchp:
> > 
> > First, hot-add a bridge:
> > (qemu) device_add pci-bridge,id=br2,bus=br1,chassis_nr=1,addr=1
> > 
> > But with the current patch, the hot-plug is still successful, just that the
> > bridge is not properly configured:
> > $ lspci -t
> > -[0000:00]-+-00.0
> >            +-01.0
> >            +-02.0
> >            +-03.0-[01-02]----00.0-[02]----01.0--  <-- new hot-added bridge
> >            +-1f.0
> >            +-1f.2
> >            \-1f.3
> > 
> > But! Now I leave the hot-added bridge as is, and hot-add an ethernet card:
> > (qemu) device_add e1000,bus=br1,id=eth0,addr=2
> > 
> > this command crashes the kernel (full crash log below).
> > 
> > The problem is because during hot-plugging of this ethernet card,
> > pci_bus_add_devices() is invoked and the previously hot-plugged bridge hasn't
> > been marked as "added" yet, so the driver attempts to add this bridge
> > again, leading to the crash.
> > 
> > Now for pciehp, this scenario cannot happen, because there is only a single
> > slot, so we cannot hot-plug another device. But still, this makes me think
> > perhaps we shouldn't leave the hot-plugged bridge in a improperly-configured
> > state as this patch is doing. I cannot think of a scenario that would crash pciehp
> > similarly to shpchp. But that's just me, maybe there is a rare scenario
> > that can crash pciehp, but I just haven't seen yet.
> > 
> > My point is: better safe than sorry. I propose going back to the original
> > solution: calling pci_stop_and_remove_bus_device() and return a negative
> > error, and get rid of this improperly configured bridge. It is useless
> > anyways without a subordinate bus number.
> > 
> > What do you think?
> 
> When the kernel runs out of BAR address space for devices downstream of
> a bridge, it doesn't de-enumerate the bridge.  The devices are just
> unusable.
> 
> So my first intuition is that running out of bus numbers shouldn't result
> in de-enumeration either.

The BAR case is a bit different: it is a legal configuration for a bridge
to have no address space downstream: we can configure the bridge with
limit<base to indicate that there is no downstream addresses. There is
nothing similar for secondary bus number: there is no legal bus number
configuration for the bridge in this case.

> Remind me, how exactly does the NULL pointer deref occur?  I think it's
> because no struct pci_bus was allocated for the subordinate bus of the
> hot-plugged bridge, right?  Because AFAICS that would happen in
> 
> pci_hp_add_bridge()
>   pci_can_bridge_extend()
>     pci_add_new_bus()
>       pci_alloc_child_bus()
> 
> but we never get that far because pci_hp_add_bridge() bails out with -1.
> So the subordinate pointer remains a NULL pointer.

This is correct. NULL deference happens due to subordinate pointer being
NULL.
 
> Perhaps we should allocate an empty struct pci_bus instead.

This feels a bit hacky. What bus number could we set to this struct? And I
doubt that the PCI subsystem is written with the expectation that struct pci_bus
can be a dummy one, so I would guess that the probability of breaking thing
is high with this approach.

> Or check for a NULL subordinate pointer instead of crashing.

I think this is a possible solution, but it is a bit complicated: all usage
of subordinate pointers will need to be looked at. Further more, secondary bus
number being zero is currently taken as unconfigured/invalid (for example
in pci_scan_bridge_extend()), that needs to be changed as well. Doing this
has a good chance of breaking things.
 
I don't really see the upside of the above, compared to just deleting this
bridge. It is not really counter-intuitive that the OS rejects a
hot-plugged device that cannot be configured, right? Also this solution is
wayyy simpler. Unless there is problem with this that I am not seeing?

Best regards,
Nam

