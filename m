Return-Path: <linux-pci+bounces-6145-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FBED8A1DE8
	for <lists+linux-pci@lfdr.de>; Thu, 11 Apr 2024 20:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F2B91C24CF8
	for <lists+linux-pci@lfdr.de>; Thu, 11 Apr 2024 18:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540642C853;
	Thu, 11 Apr 2024 17:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="lxhUXvHh"
X-Original-To: linux-pci@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833E62C695;
	Thu, 11 Apr 2024 17:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712856739; cv=none; b=sQJOeO3MnnYytYMxWEmsWr3hMaBED0DAwJab01HBZZftb6IftwQd5+GudaYdDUxTkAglLH2Pa/cpnFt2HZvxc7qmieBebwcN3ufCe/TreeTcCnCyKiLFY/lmsQ9d7ZlaPLYVtF/clltmboVPaMih4sIGsNKDWmzxPC46Ym6EWWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712856739; c=relaxed/simple;
	bh=2QoTSWKTLiVnlEWmF0KLVApI58WuOPTJLa7pr5wJxy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C4S3jouDD6noCujyho5/YGqGyVAwEwzEbB57da8XcmEjzU7yO43LU7V0yEcQ3PNhU2tViSO+GhwMyGybkqmEE3zQZMCc3sPCIu46T0dzp18JuH0/s1iHogE28j5wCoOfOWLv6YPcH7Tkz/kwlh5YhV8T11wK0E9UaAZFA9rZwMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=lxhUXvHh; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=zyBM0tQ9CQLcuJaCn3dHHUyOfoZlcsgu0yaD/od/bRY=; b=lx
	hUXvHhsNuiINwLWXfo8vLxhAPoHLh1UB611yWqZqvyaed7nyLCpNYohnbMI3vaNjCChfiXhntYzFb
	mP6QdxViVT8/Gkv7IbKuMaZdXmp1vIrKBs0hF18cpMpOr/zv2PPPO/HGPQWlPatylVDM0VTbuHiJ5
	0sYb++KgwRWqQd8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ruyHM-00CnOv-IH; Thu, 11 Apr 2024 19:32:04 +0200
Date: Thu, 11 Apr 2024 19:32:04 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, pabeni@redhat.com,
	John Fastabend <john.fastabend@gmail.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Edward Cree <ecree.xilinx@gmail.com>, netdev@vger.kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	Alexander Duyck <alexanderduyck@fb.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: [net-next PATCH 00/15] eth: fbnic: Add network driver for Meta
 Platforms Host Network Interface
Message-ID: <70bccb10-cc76-4eec-b2cf-975ed422c443@lunn.ch>
References: <171217454226.1598374.8971335637623132496.stgit@ahduyck-xeon-server.home.arpa>
 <20240409135142.692ed5d9@kernel.org>
 <44093329-f90e-41a6-a610-0f9dd88254eb@lunn.ch>
 <CAKgT0UcVnhgmXNU2FGcy6hbzUQZwNBZw0EKbFF3DsKDc8r452A@mail.gmail.com>
 <c820695d-bda7-4452-a563-170700baf958@lunn.ch>
 <CAKgT0Uf4i_MN-Wkvpk29YevwsgFrQ3TeQ5-ogLrF-QyMSjtiug@mail.gmail.com>
 <c437cf8e-57d5-44d3-a71d-c95ea84838fd@lunn.ch>
 <CAKgT0UcO-=dg2g0uFSMt2UnyzF7y2W8RVFDp15RZhy=Vb4g61Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKgT0UcO-=dg2g0uFSMt2UnyzF7y2W8RVFDp15RZhy=Vb4g61Q@mail.gmail.com>

On Thu, Apr 11, 2024 at 09:00:17AM -0700, Alexander Duyck wrote:
> On Wed, Apr 10, 2024 at 3:37 PM Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > > Well I was referring more to the data path level more than the phy
> > > configuration. I suspect different people have different levels of
> > > expectations on what minimal firmware is. With this hardware we at
> > > least don't need to use firmware commands to enable or disable queues,
> > > get the device stats, or update a MAC address.
> > >
> > > When it comes to multi-host NICs I am not sure there are going to be
> > > any solutions that don't have some level of firmware due to the fact
> > > that the cable is physically shared with multiple slots.
> >
> > This is something Russell King at least considered. I don't really
> > know enough to know why its impossible for Linux to deal with multiple
> > slots.
> 
> It mostly has to do with the arbitration between them. It is a matter
> of having to pass a TON of info to the individual slice and then the
> problem is it would have to do things correctly and not manage to take
> out it's neighbor or the BMC.

How much is specific to your device? How much is just following 802.3
and the CMIS standards? I assume anything which is just following
802.3 and CMIS could actually be re-used? And you have some glue to
combine them in a way that is specific to your device?
 
> > > I am assuming we still want to do the PCS driver. So I will still see
> > > what I can do to get that setup.
> >
> > You should look at the API offered by drivers in drivers/net/pcs. It
> > is designed to be used with drivers which actually drive the hardware,
> > and use phylink. Who is responsible for configuring and looking at the
> > results of auto negotiation? Who is responsible for putting the PCS
> > into the correct mode depending on the SFP modules capabilities?
> > Because you seemed to of split the PCS into two, and hidden some of it
> > away, i don't know if it makes sense to try to shoehorn what is left
> > into a Linux driver.
> 
> We have control of the auto negotiation as that is north of the PMA
> and is configured per host. We should support clause 73 autoneg.
> Although we haven't done much with it as most of our use cases are
> just fixed speed setups to the switch over either 25G-CR1, 50G-CR2,
> 50G-CR1, or 100G-CR2. So odds are we aren't going to be doing anything
> too terribly exciting.

Maybe not, but you might of gained from the community here, if others
could of adopted this code for their devices. You might not need
clause 73, but phylink provides helpers to implement it, so it is
pretty easy to add. Maybe your initial PCS driver does not support it,
but later adopters who also licence this PCS might add it, and you get
the feature for free. The corrected/uncorrected counters i asked
about, are something you might not export in your current code via
ethtool. But again, this is something which somebody else could add a
helper for, and you would get it nearly for free.

> As far as the QSFP setup the FW is responsible for any communication
> with it. I suspect that the expectation is that we aren't going to
> need much in the way of config since we are just using direct attach
> cables.

Another place you might of got features for free. The Linux SFP driver
exports HWMON values for temperature, power, received power, etc, but
for 1G. The QSFP+ standard Versatile Diagnostics Monitoring is
different, but i could see somebody adding a generic implementation in
the Linux SFP driver, so that the HWMON support is just free. Same
goes for the error performance statics. Parts of power management
could easily be generic. It might be possible to use Linux regulators
to describe what your board is capable if, and the SFP core could then
implement the ethtool ops, checking with the regulator to see if the
power is actually available, and then talking to the SFP to tell it to
change its power class?

Florian posted some interesting statistics, that vendors tend to
maintain their own drivers, and don't get much support from the
community. However i suspect it is a different story for shared
infrastructure like PCS drivers, PHY drivers, SFP drivers. That is
where you get the most community support and the most stuff for free.
But you actually have to use it to benefit from it.

	Andrew

