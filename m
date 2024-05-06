Return-Path: <linux-pci+bounces-7134-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9F78BD57E
	for <lists+linux-pci@lfdr.de>; Mon,  6 May 2024 21:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6761F280C90
	for <lists+linux-pci@lfdr.de>; Mon,  6 May 2024 19:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5D115359F;
	Mon,  6 May 2024 19:36:56 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6C515AD90;
	Mon,  6 May 2024 19:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715024216; cv=none; b=dscn3fa2bZQgkvdoybfc8ma+khgFQ6gPJLQjW3dgAckZjvxxKs6zntmnTyxDC7XPHLjFLNW9qBxVYgc2kw+q1zSEbwKIUidzdA0MpB+yWnCYEqhgEsk9oHKQIZlrT01Yq3zki2mDmPQb1ITFmZTvtbT9YIrqTq0QCvqJ0DnVg5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715024216; c=relaxed/simple;
	bh=bnSLbu/SWkzlHsUFsJAiqLw1w0E49t2wGliMqDiSqks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rNzxoO4PZbPRVBTReVqqffSMrOIS6e4GILCV9XnQiJjx7LjUWf1w3Q2r+9l8nWsC9BRzZ0UkFGmQdR2FE2y+WdmGat7r7QqHa7HosEXot95EK0Ge2720jAXs4RNOtS7IeGACIqGC+g3bB6Z8YCJPwrgLZRunH8+pdLreYx3zatI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 90D73300115D8;
	Mon,  6 May 2024 21:36:44 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 66F7C4A88D5; Mon,  6 May 2024 21:36:44 +0200 (CEST)
Date: Mon, 6 May 2024 21:36:44 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Nam Cao <namcao@linutronix.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Yinghai Lu <yinghai@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v2 2/2] PCI: pciehp: Abort hot-plug if
 pci_hp_add_bridge() fails
Message-ID: <ZjkxTGaAc48jPzqC@wunner.de>
References: <cover.1714838173.git.namcao@linutronix.de>
 <f3db713f4a737756782be6e94fcea3eda352e39f.1714838173.git.namcao@linutronix.de>
 <Zjcc6Suf5HmmZVM9@wunner.de>
 <20240505071451.df3l6mdK@linutronix.de>
 <20240506083701.NZNifFGn@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240506083701.NZNifFGn@linutronix.de>

On Mon, May 06, 2024 at 10:37:01AM +0200, Nam Cao wrote:
> I just discovered a new crash scenario with shpchp:
> 
> First, hot-add a bridge:
> (qemu) device_add pci-bridge,id=br2,bus=br1,chassis_nr=1,addr=1
> 
> But with the current patch, the hot-plug is still successful, just that the
> bridge is not properly configured:
> $ lspci -t
> -[0000:00]-+-00.0
>            +-01.0
>            +-02.0
>            +-03.0-[01-02]----00.0-[02]----01.0--  <-- new hot-added bridge
>            +-1f.0
>            +-1f.2
>            \-1f.3
> 
> But! Now I leave the hot-added bridge as is, and hot-add an ethernet card:
> (qemu) device_add e1000,bus=br1,id=eth0,addr=2
> 
> this command crashes the kernel (full crash log below).
> 
> The problem is because during hot-plugging of this ethernet card,
> pci_bus_add_devices() is invoked and the previously hot-plugged bridge hasn't
> been marked as "added" yet, so the driver attempts to add this bridge
> again, leading to the crash.
> 
> Now for pciehp, this scenario cannot happen, because there is only a single
> slot, so we cannot hot-plug another device. But still, this makes me think
> perhaps we shouldn't leave the hot-plugged bridge in a improperly-configured
> state as this patch is doing. I cannot think of a scenario that would crash pciehp
> similarly to shpchp. But that's just me, maybe there is a rare scenario
> that can crash pciehp, but I just haven't seen yet.
> 
> My point is: better safe than sorry. I propose going back to the original
> solution: calling pci_stop_and_remove_bus_device() and return a negative
> error, and get rid of this improperly configured bridge. It is useless
> anyways without a subordinate bus number.
> 
> What do you think?

When the kernel runs out of BAR address space for devices downstream of
a bridge, it doesn't de-enumerate the bridge.  The devices are just
unusable.

So my first intuition is that running out of bus numbers shouldn't result
in de-enumeration either.

Remind me, how exactly does the NULL pointer deref occur?  I think it's
because no struct pci_bus was allocated for the subordinate bus of the
hot-plugged bridge, right?  Because AFAICS that would happen in

pci_hp_add_bridge()
  pci_can_bridge_extend()
    pci_add_new_bus()
      pci_alloc_child_bus()

but we never get that far because pci_hp_add_bridge() bails out with -1.
So the subordinate pointer remains a NULL pointer.

Perhaps we should allocate an empty struct pci_bus instead.
Or check for a NULL subordinate pointer instead of crashing.

I can't really say off the top of my head which solution is appropriate
here, it requires going through the code paths and identifying the
complexity associated with each solution.

Thanks,

Lukas

