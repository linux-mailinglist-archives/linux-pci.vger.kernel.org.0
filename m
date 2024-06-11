Return-Path: <linux-pci+bounces-8601-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C88B904233
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jun 2024 19:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F374FB232D9
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jun 2024 17:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975CC4502B;
	Tue, 11 Jun 2024 17:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YYJSgajD"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A5C4207A;
	Tue, 11 Jun 2024 17:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718125982; cv=none; b=gfZ011fhHXxIN2Q0244ubZx+qf5BV8dy/Q4NQUQACCw5UNqHtXEYv08+98Dv+TXBgxPtw/CcXsA2k+NoKeS71tDjuWeQhKD7E228zzENCyE8VzZvBBaIV927/MBKtyRMlz+sQBNIDKnhll2/emMPrrlj394h6X5YVNnseYNbbTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718125982; c=relaxed/simple;
	bh=VPJiEyN1LjxU1D7rLJKPD/845LAmaZGNHNFrrRwhQ2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Rp4eC+paGV9lMqqhVdyHypTbDVngyesJ6KjpU9KcP7hv56BWVixk9tba0HD489cf1s6zUk2GiYzqvE0uRLIF8eK2FpXy54Mkt0cS61qvl3Kkc87JxmZsMEr4GNFSZNZe9c33nWBzyuknHzqtjQl+yheqPoMYDA0zBltIaLLisR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YYJSgajD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AE42C2BD10;
	Tue, 11 Jun 2024 17:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718125981;
	bh=VPJiEyN1LjxU1D7rLJKPD/845LAmaZGNHNFrrRwhQ2Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=YYJSgajDnEwTI9UWwe+OfG3g4ifsQqHnPYOEk/a5k078qBJvllVmjvPZqyXJMYttu
	 NzqjT0YViP/tvdgTVpnUYtKbAgLI+DzzVg6PjJ88iELDdgdZfMwXjAE1TzzwvaTI82
	 4IFdoQBAdDPLzHighuW3XgN1+IL8MBr0ZGTTsfcW2JloXY7AFProGh18NIZGeTLvz6
	 VvyTIxb7JubsQhcQOSaqoKBH+IQZG0vX+C1UBJkVIh5SnB7lOP0vqSPx8D3jg0dlmt
	 2Fcc0mN9ZIsfmHmGQneiIjejDxwnEZ8kENbGn/ex+jQigrQabi04W3a/f65I+f/jNn
	 duZZGW7RwJ5Mw==
Date: Tue, 11 Jun 2024 12:13:00 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Herve Codina <herve.codina@bootlin.com>,
	Simon Horman <horms@kernel.org>,
	Sai Krishna Gajula <saikrishnag@marvell.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Lee Jones <lee@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	UNGLinuxDriver@microchip.com, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Saravana Kannan <saravanak@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Lars Povlsen <lars.povlsen@microchip.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	netdev@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 17/19] PCI: of_property: Add interrupt-controller
 property in PCI device nodes
Message-ID: <20240611171300.GA990134@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610213735.GA3112053-robh@kernel.org>

On Mon, Jun 10, 2024 at 03:37:35PM -0600, Rob Herring wrote:
> On Thu, Jun 06, 2024 at 02:26:12PM -0500, Bjorn Helgaas wrote:
> > On Mon, May 27, 2024 at 06:14:44PM +0200, Herve Codina wrote:
> > > PCI devices and bridges DT nodes created during the PCI scan are created
> > > with the interrupt-map property set to handle interrupts.
> > > 
> > > In order to set this interrupt-map property at a specific level, a
> > > phandle to the parent interrupt controller is needed. On systems that
> > > are not fully described by a device-tree, the parent interrupt
> > > controller may be unavailable (i.e. not described by the device-tree).
> > > 
> > > As mentioned in the [1], avoiding the use of the interrupt-map property
> > > and considering a PCI device as an interrupt controller itself avoid the
> > > use of a parent interrupt phandle.
> > > 
> > > In that case, the PCI device itself as an interrupt controller is
> > > responsible for routing the interrupts described in the device-tree
> > > world (DT overlay) to the PCI interrupts.
> > > 
> > > Add the 'interrupt-controller' property in the PCI device DT node.
> > > 
> > > [1]: https://lore.kernel.org/lkml/CAL_Jsq+je7+9ATR=B6jXHjEJHjn24vQFs4Tvi9=vhDeK9n42Aw@mail.gmail.com/
> > > 
> > > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > 
> > No objection from me, but I'd like an ack/review from Rob.
> 
> Given it is more DT patches in the series, how about I take them and 
> this one with your ack instead?

Sure.  There's very little PCI content here, so I didn't plan to take
them; I just thought this needed at least your ack :)

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

