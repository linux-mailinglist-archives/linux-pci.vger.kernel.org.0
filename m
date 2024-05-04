Return-Path: <linux-pci+bounces-7071-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A928BBA47
	for <lists+linux-pci@lfdr.de>; Sat,  4 May 2024 11:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AACFE282A41
	for <lists+linux-pci@lfdr.de>; Sat,  4 May 2024 09:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53ECB11C83;
	Sat,  4 May 2024 09:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wezq/xX7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ld8PUdy4"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EB95221;
	Sat,  4 May 2024 09:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714815339; cv=none; b=Jz7YPio+9C6JjjUHEmTW2gwXsAEieB7bnstooYP7H9RC0Joy2KaYI1a2Eb9P5+Y3b4tNx4Ar0iPW878R7n4XkKdH/nP0WuUqWlEHCMNCNsA40fTrurnEYNYQSEi82GofCv4qArKe3Jh6LGEjAS3yWa7eU69L5gkUlFvO9Kg2zcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714815339; c=relaxed/simple;
	bh=rirSMqQpo3rIWksqPbYyKWaw05Ls23tdgirteckiGOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TW+QZLeGe0Z2p1q+EL34PvMhuk0qRk6kaDq0NOcl776vkM1PI6foCiPfeznfIsolkIiCRcKU57FbnmUn9ZcYMay3fIfAJNRUb6R2Nyc9LzmjSnNfrkC2eDzxH9/U57ipiYWdrfdH31K+C34eowIdfADGx0vbnPyrEggvlctNNk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wezq/xX7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ld8PUdy4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 4 May 2024 11:35:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714815335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mprjEP9r9wSRznT2f4YFOHY7Ce6AUzgFEOg+L4BcIs8=;
	b=wezq/xX7Tqsb2bXf/uYkEZrb6Se1F1l28Qkx7cVQ+9QB52XA9CvMa63CQWxc/hfZn3yTOQ
	eqK4puQ9odbpmYhtx/9xGKP0f+AiocNH285JzfhDm/WnQAt/soJJvgVF2lCPwpwfpiR3P5
	Cmhsax4PvdhupWAT139iYMI0fb57KSJnbIXA+J3Mf0z7NhZx64DOB4OVozQUqLKNwCvLVD
	lPkl1M8wogoDlxNDeF/dLtE2y1puJ7hLhB1Zi3gZ+HKxy37+q11mun2fvTrsA6Tc2Naejg
	5IwNuq9OQCzIZsrw6wqxn0ODtJ8FuLsaLAAZm9Y3tnr3R/QRWtPdw9as52bIsw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714815335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mprjEP9r9wSRznT2f4YFOHY7Ce6AUzgFEOg+L4BcIs8=;
	b=ld8PUdy4DqTvvGyt0jVc2Cds0oBwCFG+hZUs+KM38c4ai0nT4i75hH8CH370OAi6jzwDS8
	k0CX46clMsS2D2Cw==
From: Nam Cao <namcao@linutronix.de>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Yinghai Lu <yinghai@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rajesh Shah <rajesh.shah@intel.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/4] PCI: pciehp: bail out if pci_hp_add_bridge() fails
Message-ID: <20240504093529.p8pbGxuK@linutronix.de>
References: <cover.1714762038.git.namcao@linutronix.de>
 <401e4044e05d52e4243ca7faa65d5ec8b19526b8.1714762038.git.namcao@linutronix.de>
 <ZjX3t1NerOlGBhzw@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjX3t1NerOlGBhzw@wunner.de>

On Sat, May 04, 2024 at 10:54:15AM +0200, Lukas Wunner wrote:
> On Fri, May 03, 2024 at 09:23:20PM +0200, Nam Cao wrote:
> > If there is no bus number available for the downstream bus of the
> > hot-plugged bridge, pci_hp_add_bridge() will fail. The driver proceeds
> > regardless, and the kernel crashes.
> > 
> > Abort if pci_hp_add_bridge() fails.
> [...]
> > --- a/drivers/pci/hotplug/pciehp_pci.c
> > +++ b/drivers/pci/hotplug/pciehp_pci.c
> > @@ -58,8 +58,13 @@ int pciehp_configure_device(struct controller *ctrl)
> >  		goto out;
> >  	}
> >  
> > -	for_each_pci_bridge(dev, parent)
> > -		pci_hp_add_bridge(dev);
> > +	for_each_pci_bridge(dev, parent) {
> > +		if (pci_hp_add_bridge(dev)) {
> > +			pci_stop_and_remove_bus_device(dev);
> > +			ret = -EINVAL;
> > +			goto out;
> > +		}
> > +	}
> 
> Is the pci_stop_and_remove_bus_device() really necessary here?
> Why not just leave the bridge as is, without any child devices?

pci_stop_and_remove_bus_device() is not necessary to prevent kernel
crashing. But without this, we cannot hot-plug any other devices to this
slot afterward, despite the bridge has already been removed. Below is what
happens without pci_stop_and_remove_bus_device().

First, we hotplug a bridge. That fails, so QEMU removes this bridge:
(qemu) device_add pci-bridge,id=br2,bus=br1,chassis_nr=19,addr=1
[    9.289609] shpchp 0000:01:00.0: Latch close on Slot(1-1)
[    9.291145] shpchp 0000:01:00.0: Button pressed on Slot(1-1)
[    9.292705] shpchp 0000:01:00.0: Card present on Slot(1-1)
[    9.294369] shpchp 0000:01:00.0: PCI slot #1-1 - powering on due to button press
[   15.529997] pci 0000:02:01.0: [1b36:0001] type 01 class 0x060400 conventional PCI bridge
[   15.533907] pci 0000:02:01.0: BAR 0 [mem 0x00000000-0x000000ff 64bit]
[   15.535802] pci 0000:02:01.0: PCI bridge to [bus 00]
[   15.538519] pci 0000:02:01.0:   bridge window [io  0x0000-0x0fff]
[   15.540261] pci 0000:02:01.0:   bridge window [mem 0x00000000-0x000fffff]
[   15.543486] pci 0000:02:01.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[   15.547151] pci 0000:02:01.0: No bus number available for hot-added bridge
[   15.549067] shpchp 0000:01:00.0: Cannot add device at 0000:02:01
[   15.553104] shpchp 0000:01:00.0: Latch open on Slot(1-1)
[   15.555246] shpchp 0000:01:00.0: Card not present on Slot(1-1)

Then, hot-plug an ethernet device. But the kernel still incorrectly
thought the bridge is still there, and refuses this new ethernet device:
(qemu) device_add e1000,bus=br1,addr=1
[   58.163529] shpchp 0000:01:00.0: Latch close on Slot(1-1)
[   58.165076] shpchp 0000:01:00.0: Button pressed on Slot(1-1)
[   58.166650] shpchp 0000:01:00.0: Card present on Slot(1-1)
[   58.168287] shpchp 0000:01:00.0: PCI slot #1-1 - powering on due to button press
[   64.677492] shpchp 0000:01:00.0: Device 0000:02:01.0 already exists at 0000:02:01, cannot hot-add
[   64.680007] shpchp 0000:01:00.0: Cannot add device at 0000:02:01
[   64.682802] shpchp 0000:01:00.0: Latch open on Slot(1-1)
[   64.684353] shpchp 0000:01:00.0: Card not present on Slot(1-1)

Best regards,
Nam

