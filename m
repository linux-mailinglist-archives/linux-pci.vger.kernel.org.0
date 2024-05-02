Return-Path: <linux-pci+bounces-7007-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4738B9AD7
	for <lists+linux-pci@lfdr.de>; Thu,  2 May 2024 14:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 901D71C21B88
	for <lists+linux-pci@lfdr.de>; Thu,  2 May 2024 12:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412757E564;
	Thu,  2 May 2024 12:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="bNgfbgJ/"
X-Original-To: linux-pci@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8CD60EC3;
	Thu,  2 May 2024 12:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714652822; cv=none; b=Cuiv//5KgYD7FN+t/yJ4pflfAn+Ggsgxcn+FjuIdff/WCWrziT3G8/oxqYA40TQXkHXFBgOunr2qX6UY3HLVALnwx0NlrSRj3EQtZEIM/rz+mzrwLLSD4PsvlAftGS9PBnDgpndbDmtL5DagErxlqmi9w8yL/84335re/h+77nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714652822; c=relaxed/simple;
	bh=ubGsjiWQHWPaEZ1fQ7tqbi/KKjuYjwt1nMnswlvWugU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uov5vh5jFYoqs8EK8zA5Opdx/tacbpzt/Fjb5/SuudlVEyxy7ACdvzQ/v41TbVxvCy9UmraDZ3YzHn8jNa8Pw+GlabMQEggq+CwN9EKoKdUoyEtqhnV/xK1DBl1iMbpq7eC6xExuLjvleeuETqQ2SYw5QP1cOFPeEpTgz1z+S7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=bNgfbgJ/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=gVITxXoUTVKTfjI6S12QFG1wv1DAg8EEN4Ngn7R7v5M=; b=bNgfbgJ/L9jRQ2A93jsYogUi+N
	kWVgx9OUBoOTsJoCcLnAlM6XDTuqJr5/b2Qg5GAYLGF2BXEZ/MWrDQvuHcnTqN2csm1keEMrEAtix
	pmaiapgE22GVw3XeCstUGB1Oe/srzXlYSK/M8u46dgZAzc8c2vtsOE9QQyf662Yasyis=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s2VWG-00EVEN-M8; Thu, 02 May 2024 14:26:36 +0200
Date: Thu, 2 May 2024 14:26:36 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Conor Dooley <conor.dooley@microchip.com>
Cc: Herve Codina <herve.codina@bootlin.com>,
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Lee Jones <lee@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	UNGLinuxDriver@microchip.com,
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
Subject: Re: [PATCH 06/17] dt-bindings: net: mscc-miim: Add resets property
Message-ID: <4f9fd16b-773d-40e7-86d8-db19e2f6da16@lunn.ch>
References: <20240430083730.134918-1-herve.codina@bootlin.com>
 <20240430083730.134918-7-herve.codina@bootlin.com>
 <5d899584-38ed-4eee-9ba5-befdedbc5734@lunn.ch>
 <20240430174023.4d15a8a4@bootlin.com>
 <2b01ed8a-1169-4928-952e-1645935aca2f@lunn.ch>
 <20240502115043.37a1a33a@bootlin.com>
 <20240502-petted-dork-20eb02e5a8e3@wendy>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502-petted-dork-20eb02e5a8e3@wendy>

On Thu, May 02, 2024 at 11:31:00AM +0100, Conor Dooley wrote:
> On Thu, May 02, 2024 at 11:50:43AM +0200, Herve Codina wrote:
> > Hi Andrew,
> > 
> > On Tue, 30 Apr 2024 18:31:46 +0200
> > Andrew Lunn <andrew@lunn.ch> wrote:
> > 
> > > > We have the same construction with the pinctrl driver used in the LAN966x
> > > >   Documentation/devicetree/bindings/pinctrl/mscc,ocelot-pinctrl.yaml
> > > > 
> > > > The reset name is 'switch' in the pinctrl binding.
> > > > I can use the same description here as the one present in the pinctrl binding:
> > > >   description: Optional shared switch reset.
> > > > and keep 'switch' as reset name here (consistent with pinctrl reset name).
> > > > 
> > > > What do you think about that ?  
> > > 
> > > It would be good to document what it is shared with. So it seems to be
> > > the switch itself, pinctl and MDIO? Anything else?
> > > 
> > 
> > To be honest, I know that the GPIO controller (microchip,sparx5-sgpio) is
> > impacted but I don't know if anything else is impacted by this reset.
> > I can update the description with:
> >   description:
> >     Optional shared switch reset.
> >     This reset is shared with at least pinctrl, GPIO, MDIO and the switch
> >     itself.
> > 
> > Does it sound better ?
> 
> $dayjob hat off, bindings hat on: If you don't know, can we get someone
> from Microchip (there's some and a list in CC) to figure it out?

That is probably a good idea, there is potential for hard to find bugs
here, when a device gets an unexpected reset. Change the order things
probe, or an unexpected EPRODE_DEFER could be interesting.

       Andrew

