Return-Path: <linux-pci+bounces-7072-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF608BBA60
	for <lists+linux-pci@lfdr.de>; Sat,  4 May 2024 11:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 670C01C21142
	for <lists+linux-pci@lfdr.de>; Sat,  4 May 2024 09:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87BE817554;
	Sat,  4 May 2024 09:52:00 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116E8171CC;
	Sat,  4 May 2024 09:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714816320; cv=none; b=QgrGB6f0lER34noEUwN7JtYmsFzq8GI80hxQJAWw231NMgtbTENxT43iV4TOJ649Ml0uWssLYcAkmZ5RV+jlpG0jZaHtYCLX3dYhZtTCP5K2+EeSZt2JcqIfSZCR7nvGOLYEdQUGe5tMNjF+WhqEeUQUr4SulXDVK3Nw4cxIBFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714816320; c=relaxed/simple;
	bh=RMBSFlZXIJPNLK4klI3vtcmMbNzgx7eIQVu539eDDDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IxWNjljCkI0+wVrxBVX8c9wPAezr0mtgqyjGCnZoPtmizzKQAlYFTZXfZVbjqmJpCkekn2zYHefrsHyHS8ZHlbrwMXvvZoyAfIvLS8vOsUUfkT6CP2I9Rltg1r5EczXYwHl2NqaVFtrCQ+KLj2hcyEesPBKEW+gUPmDXV15XgjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 1A94D3000E44A;
	Sat,  4 May 2024 11:51:55 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id E30861FE09; Sat,  4 May 2024 11:51:54 +0200 (CEST)
Date: Sat, 4 May 2024 11:51:54 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Nam Cao <namcao@linutronix.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Yinghai Lu <yinghai@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rajesh Shah <rajesh.shah@intel.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/4] PCI: pciehp: bail out if pci_hp_add_bridge() fails
Message-ID: <ZjYFOrGlluGW_GzV@wunner.de>
References: <cover.1714762038.git.namcao@linutronix.de>
 <401e4044e05d52e4243ca7faa65d5ec8b19526b8.1714762038.git.namcao@linutronix.de>
 <ZjX3t1NerOlGBhzw@wunner.de>
 <20240504093529.p8pbGxuK@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240504093529.p8pbGxuK@linutronix.de>

On Sat, May 04, 2024 at 11:35:29AM +0200, Nam Cao wrote:
> On Sat, May 04, 2024 at 10:54:15AM +0200, Lukas Wunner wrote:
> > On Fri, May 03, 2024 at 09:23:20PM +0200, Nam Cao wrote:
> > > If there is no bus number available for the downstream bus of the
> > > hot-plugged bridge, pci_hp_add_bridge() will fail. The driver proceeds
> > > regardless, and the kernel crashes.
> > > 
> > > Abort if pci_hp_add_bridge() fails.
> > [...]
> > > --- a/drivers/pci/hotplug/pciehp_pci.c
> > > +++ b/drivers/pci/hotplug/pciehp_pci.c
> > > @@ -58,8 +58,13 @@ int pciehp_configure_device(struct controller *ctrl)
> > >  		goto out;
> > >  	}
> > >  
> > > -	for_each_pci_bridge(dev, parent)
> > > -		pci_hp_add_bridge(dev);
> > > +	for_each_pci_bridge(dev, parent) {
> > > +		if (pci_hp_add_bridge(dev)) {
> > > +			pci_stop_and_remove_bus_device(dev);
> > > +			ret = -EINVAL;
> > > +			goto out;
> > > +		}
> > > +	}
> > 
> > Is the pci_stop_and_remove_bus_device() really necessary here?
> > Why not just leave the bridge as is, without any child devices?
> 
> pci_stop_and_remove_bus_device() is not necessary to prevent kernel
> crashing. But without this, we cannot hot-plug any other devices to this
> slot afterward, despite the bridge has already been removed. Below is what
> happens without pci_stop_and_remove_bus_device().
> 
> First, we hotplug a bridge. That fails, so QEMU removes this bridge:
> (qemu) device_add pci-bridge,id=br2,bus=br1,chassis_nr=19,addr=1
> [    9.289609] shpchp 0000:01:00.0: Latch close on Slot(1-1)
> [    9.291145] shpchp 0000:01:00.0: Button pressed on Slot(1-1)
> [    9.292705] shpchp 0000:01:00.0: Card present on Slot(1-1)
> [    9.294369] shpchp 0000:01:00.0: PCI slot #1-1 - powering on due to button press
> [   15.529997] pci 0000:02:01.0: [1b36:0001] type 01 class 0x060400 conventional PCI bridge
> [   15.533907] pci 0000:02:01.0: BAR 0 [mem 0x00000000-0x000000ff 64bit]
> [   15.535802] pci 0000:02:01.0: PCI bridge to [bus 00]
> [   15.538519] pci 0000:02:01.0:   bridge window [io  0x0000-0x0fff]
> [   15.540261] pci 0000:02:01.0:   bridge window [mem 0x00000000-0x000fffff]
> [   15.543486] pci 0000:02:01.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
> [   15.547151] pci 0000:02:01.0: No bus number available for hot-added bridge
> [   15.549067] shpchp 0000:01:00.0: Cannot add device at 0000:02:01
> [   15.553104] shpchp 0000:01:00.0: Latch open on Slot(1-1)
> [   15.555246] shpchp 0000:01:00.0: Card not present on Slot(1-1)

I'm not familiar with shpchp, I don't understand why it's thinking
that there's no card after it failed to find a bus number.

Could you reproduce with pciehp instead of shpchp please?

Thanks,

Lukas

