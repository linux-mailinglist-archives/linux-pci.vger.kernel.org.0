Return-Path: <linux-pci+bounces-7429-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D9808C459B
	for <lists+linux-pci@lfdr.de>; Mon, 13 May 2024 19:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDFFA1C21865
	for <lists+linux-pci@lfdr.de>; Mon, 13 May 2024 17:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2951BF2A;
	Mon, 13 May 2024 17:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CFGtL5Et"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25091BF40;
	Mon, 13 May 2024 17:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715619908; cv=none; b=Ck3KguicQBND64A43Zg413RSBLNPD+qoYgF3irm8udz8Y42xdwfEfsgfO8TRz2AQbOnH9wYNGu15HPycIT+SyvzJtdBBpsMnJ8ceEWym+AD+2t14q4MKVkxHxdxkhgKkQihDJPPwon4dpjzOb9CP2wy/ksa5fnnNlDu/lkLaYQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715619908; c=relaxed/simple;
	bh=2oO9YGPnzJjVdWQFjsHu07AWgfnBWzbBAHS7ksNiXfM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dqNTNOBdpp+qt1yKmOi2K5GBwzmYEwDZCrlE0oREfZ0Ci40/9hrN/CP5FAXY199TrPKVqH0MzrON0/vmIuQa5/YEphK4U1dIrnG573gkGVmcP4v6HDVGzFh654758Xkj+wHgqKIhngUq924u6Nn9Ivnqhgxwfsh0nFyHF8I7NyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CFGtL5Et; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CB42AC0009;
	Mon, 13 May 2024 17:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715619902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rQXVNdXHZF8Cg+3yU/+tkFALKcRakYOMBqIyYsnVVCY=;
	b=CFGtL5Et/lKcJS3FkCxOxgRl7rft2XF/veukKqbm1/W+IxSQhSmnBYgt1b/QKNpE19diAq
	iEJKDaTsKOnRRDYXZIKHn7TPH2jHC6ldClkpwnx8rhkOSKC30UwZFJ/i3PQ75SnOM1LQ7M
	3Ud58SwsuNQVAWehev2cLvsxDS87jWWgWOuCeSiKDrNMxRk2s/seKo5nGqERwxfZIEAfgy
	y3fI8SVM/Mte5l2d2od3JSQk4Kh8Qfa4TKN5eWefys0EHRcRbPSx1e03ZcfIBEHt4F7eLq
	PUkHYwJHJB606m36h7UHVOxxgnd0HVbptEdQLGkVoUU37V68hpI9Zx3lG8P3+g==
Date: Mon, 13 May 2024 19:04:57 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Rob Herring <robh@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Lee Jones
 <lee@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Horatiu Vultur
 <horatiu.vultur@microchip.com>, UNGLinuxDriver@microchip.com, Andrew Lunn
 <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Saravana Kannan <saravanak@google.com>, Bjorn
 Helgaas <bhelgaas@google.com>, Philipp Zabel <p.zabel@pengutronix.de>, Lars
 Povlsen <lars.povlsen@microchip.com>, Steen Hegelund
 <Steen.Hegelund@microchip.com>, Daniel Machon
 <daniel.machon@microchip.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, netdev@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Allan
 Nielsen <allan.nielsen@microchip.com>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 09/17] dt-bindings: interrupt-controller: Add support
 for Microchip LAN966x OIC
Message-ID: <20240513190457.43318788@bootlin.com>
In-Reply-To: <20240513145358.GA2574205-robh@kernel.org>
References: <20240430083730.134918-1-herve.codina@bootlin.com>
	<20240430083730.134918-10-herve.codina@bootlin.com>
	<20240507152806.GA505222-robh@kernel.org>
	<20240513143720.1174306a@bootlin.com>
	<20240513145358.GA2574205-robh@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Hi Rob,

On Mon, 13 May 2024 09:53:58 -0500
Rob Herring <robh@kernel.org> wrote:

> On Mon, May 13, 2024 at 02:37:20PM +0200, Herve Codina wrote:
> > Hi Rob,
> > 
> > On Tue, 7 May 2024 10:28:06 -0500
> > Rob Herring <robh@kernel.org> wrote:
> > 
> > ...  
> > > > +examples:
> > > > +  - |
> > > > +    interrupt-controller@e00c0120 {
> > > > +        compatible = "microchip,lan966x-oic";
> > > > +        reg = <0xe00c0120 0x190>;    
> > > 
> > > Looks like this is part of some larger block?
> > >   
> > 
> > According to the registers information document:
> >   https://microchip-ung.github.io/lan9662_reginfo/reginfo_LAN9662.html?select=cpu,intr
> > 
> > The interrupt controller is mapped at offset 0x48 (offset in number of
> > 32bit words).  
> > -> Address offset: 0x48 * 4 = 0x120
> > -> size: (0x63 + 1) *  4 = 0x190  
> > 
> > IMHO, the reg property value looks correct.  
> 
> What I mean is h/w blocks don't just start at some address with small 
> alignment. That wouldn't work from a physical design standpoint. The 
> larger block here is "CPU System Regs". The block as a whole should be 
> documented, but maybe that ship already sailed.

The clock controller, also part of the "CPU System Regs" is already defined
and used without the larger block
  Documentation/devicetree/bindings/clock/microchip,lan966x-gck.yaml

IMHO, the binding related to the interrupt controller should be consistent
with the one related to the clock controller.


> 
> Also, here you call it the OIC, but the link above calls it the VCore 
> interrupt controller.

Yes, I call it OIC (Outband Interrupt Controller) as it is its name in the
datasheet explaining how it works.
The datasheet I have is not publicly available and so, I can point only to
the register map (url provided).

I think it would be better to keep "Outband Interrupt Controller" as
mentioned in the datasheet.

Best regards,
Hervé

-- 
Hervé Codina, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

