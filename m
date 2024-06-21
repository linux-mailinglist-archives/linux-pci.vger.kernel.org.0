Return-Path: <linux-pci+bounces-9086-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 84DF1912D89
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jun 2024 20:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11083B21109
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jun 2024 18:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22BD17B4F2;
	Fri, 21 Jun 2024 18:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dcpUiTfj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E4A179957;
	Fri, 21 Jun 2024 18:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718995765; cv=none; b=r2SE1JjRTq8Nn0OTP0u3QAhhTsR7jRUMAziOrnAybEpi73eRx9OyZNqJcX1zJKOjjFYEiEZcRZiNi6/YSSIlagdMoeSBIreDA/3s7oC1KCeJwP4QI0PRGV8iAHfiOFjHrQDr8kZeUzCytRGtZwhGwJXxF8Kws0JVDhi2h9o4ngQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718995765; c=relaxed/simple;
	bh=H/7KJb3Hymr1bKAoWOE4wiwISddzEhYEUB2Cpn7f+Ag=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=aZYm/JoYtfAKsDK7D8Grz/KrICrVO4t5qgvvYQ5V4y1U1cEU+t5yvSnOfkAgpucJV9XXrXSGRSWcz41Iq1mUhxhoENEM6pufP05dV4YzXkxnTYO+mb4PDiFvykJq5FBA2SdzV5mlqsnu9PiY/eJuQryNsihKBD1d66Awgx+Dpyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dcpUiTfj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6002C2BBFC;
	Fri, 21 Jun 2024 18:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718995765;
	bh=H/7KJb3Hymr1bKAoWOE4wiwISddzEhYEUB2Cpn7f+Ag=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=dcpUiTfj0pZj8c9YnwxOVMJKgC183M8l4XD3bZKdRLAHBOa7QLAQ2dXK1BEXCuQNq
	 kMQSxeZsDzahW34rhdDVxY1GWkssuw98Ekh37+4w35obX2lbQazn/8Yu/rSaZuKwgr
	 iN1ulmzWHCXe66KikX/r72y+IVu3zRSmNHbr+d+qmBQA6Wk7+Jh/IimR3iOeIgGUSb
	 2K023F37o+dgCPwG4gzdRGBmx+l9DvcRCzNd4KN82/NT6njH7xHI8uFhcfhaV1Fvx2
	 M4nRoZP7Fd+AtL4hX8mcKUeI8EYaKYtfuVOFNE2ZmcHzTYo2HBppxQFy4HC2IadRAN
	 R2oqIwo/a4xSg==
Date: Fri, 21 Jun 2024 13:49:23 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Herve Codina <herve.codina@bootlin.com>,
	Simon Horman <horms@kernel.org>,
	Sai Krishna Gajula <saikrishnag@marvell.com>,
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
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
Subject: Re: [PATCH v2 18/19] mfd: Add support for LAN966x PCI device
Message-ID: <20240621184923.GA1398370@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VdeoNXRTmMoK-S6qecU1nOQWDZVONeHU+imFiwcTxe8xg@mail.gmail.com>

On Fri, Jun 21, 2024 at 05:45:05PM +0200, Andy Shevchenko wrote:
> On Thu, Jun 20, 2024 at 7:19 PM Herve Codina <herve.codina@bootlin.com> wrote:
> > On Thu, 20 Jun 2024 18:43:09 +0200
> > Herve Codina <herve.codina@bootlin.com> wrote:
> > > On Thu, 20 Jun 2024 18:07:16 +0200
> > > Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > > > On Thu, Jun 20, 2024 at 5:56 PM Herve Codina <herve.codina@bootlin.com> wrote:
> > > > > On Wed, 5 Jun 2024 23:24:43 +0300
> > > > > Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > > > > > Mon, May 27, 2024 at 06:14:45PM +0200, Herve Codina kirjoitti:

> > > > > > > +static struct pci_device_id lan966x_pci_ids[] = {
> > > > > > > +   { PCI_DEVICE(0x1055, 0x9660) },
> > > > > >
> > > > > > Don't you have VENDOR_ID defined somewhere?
> > > > >
> > > > > No and 0x1055 is taken by PCI_VENDOR_ID_EFAR in pci-ids.h
> > > > > but SMSC acquired EFAR late 1990's and MCHP acquired SMSC in 2012
> > > > > https://elixir.bootlin.com/linux/latest/source/drivers/net/ethernet/microchip/lan743x_main.h#L851
> > > > >
> > > > > I will patch pci-ids.h to create:
> > > > >   #define PCI_VENDOR_ID_SMSC PCI_VENDOR_ID_EFAR
> > > > >   #define PCI_VENDOR_ID_MCHP PCI_VENDOR_ID_SMSC
> > > > > As part of this patch, I will update lan743x_main.h to remove its own #define
> > > > >
> > > > > And use PCI_VENDOR_ID_MCHP in this series.
> > > >
> > > > Okay, but I don't think (but I haven't checked) we have something like
> > > > this ever done there. In any case it's up to Bjorn how to implement
> > > > this.
> >
> > Right, I wait for Bjorn reply before changing anything.
> 
> But we already have the vendor ID with the same value. Even if the
> company was acquired, the old ID still may be used. In that case an
> update on PCI IDs can go in a separate change justifying it. In any
> case, I would really want to hear from Bjorn on this and if nothing
> happens, to use the existing vendor ID for now to speed up the series
> to be reviewed/processed.

We have "#define PCI_VENDOR_ID_EFAR 0x1055" in pci_ids.h, but
https://pcisig.com/membership/member-companies?combine=1055 shows no
results, so it *looks* like EFAR/SMSC/MCHP are currently squatting on
that ID without it being officially assigned.

I think MCHP needs to register 0x1055 with the PCI-SIG
(administration@pcisig.com) if it wants to continue using it.
The vendor is responsible for managing the Device ID space, so this
registration includes the burden of tracking all the Device IDs that
were assigned by EFAR and SMSC and now MCHP so there are no conflicts.

I don't want to change the existing PCI_VENDOR_ID_EFAR, and I also
don't want to add a PCI_VENDOR_ID_MCHP for 0x1055 until that ID has
been registered with the PCI-SIG.

So I propose that you use PCI_VENDOR_ID_EFAR for now, and if/when MCHP
registers 0x1055 with PCI-SIG so it is unambiguously owned by MCHP, we
can add "#define PCI_VENDOR_ID_MCHP PCI_VENDOR_ID_EFAR" or similar.
As Andy points out, this would be a separate logical change in its own
patch.

Bjorn

