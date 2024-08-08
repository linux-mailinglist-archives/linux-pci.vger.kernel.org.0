Return-Path: <linux-pci+bounces-11487-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B320C94BF1D
	for <lists+linux-pci@lfdr.de>; Thu,  8 Aug 2024 16:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E543E1C259DF
	for <lists+linux-pci@lfdr.de>; Thu,  8 Aug 2024 14:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB41718E749;
	Thu,  8 Aug 2024 14:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="D6uE+mMv"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656F118E740;
	Thu,  8 Aug 2024 14:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723126065; cv=none; b=C1oR3diMD7map2E4IUsLkXHNYxiln5Z7/oDKxuSftjGEGcUMCNjusCHjE3WVfkMfcesVpiZiwJWpY1YKYwPic9HT+CR5T2bUIc6ulT1gjLuP8RlhAtf2vqSjmXEoxkvSkhihThwSY71zQSYPNtuy90dzzMnjCx4WnJ+BIpkgZAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723126065; c=relaxed/simple;
	bh=2eFUcF4Ok8H/r5DzQ956VAy5kWMYpZXm6mNcox2QdPU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n3qkO6wNrqy4H9TtD0BtbAtJWxKLjBQ0BNCTAOqW9twIBESDZqvT64Ji2cqLGCXAc92qqRa4A+pNJbqyPUkSiJCAPn4SQENiWEmX6UPQCD+G3fFogKqSzeatoxJJldlTpgj1MTgRRt1lzeiTk2uMXDDg1PvwBKarrY6Z9oNJDzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=D6uE+mMv; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CF814E0005;
	Thu,  8 Aug 2024 14:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1723126060;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kSHBR50la6iokVWygP7kM2FMcIflEjS6RBzmmxnEkQw=;
	b=D6uE+mMvqw6FhVXuMMxS/wRCXEj95rNeYf2PE5mBLmG/2wWNrcjPIvN1OBHXC0TJSKbA1J
	DTqOLD3CzBr3c2kcjAJSdw4gQ5kXZ/1eftc4QYDXcyG0lM/wQXfIREbNEdw6FZH0lEoXPp
	kaq1mliaOqvtQgzBlXPN9r5/vM+XvcTdj/9sBCRommwRQq2W54tBIR3CQ0JCkhCOwOBlRB
	hqEVCKArZitC2HnLPdD6KN5Y7D+CWwXFAIPkV3g/f7JZoODSB01zyVW8+SP5Kg5UUWW7iT
	7dMdfE6LimW9RuptcqfsvYFl1pyts57y2OdsYVorSp/tCiT5rF/fSu9JBBTlHA==
Date: Thu, 8 Aug 2024 16:07:37 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Simon Horman
 <horms@kernel.org>, Lee Jones <lee@kernel.org>, Arnd Bergmann
 <arnd@arndb.de>, Derek Kiernan <derek.kiernan@amd.com>, Dragan Cvetic
 <dragan.cvetic@amd.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Philipp Zabel
 <p.zabel@pengutronix.de>, Lars Povlsen <lars.povlsen@microchip.com>, Steen
 Hegelund <Steen.Hegelund@microchip.com>, Daniel Machon
 <daniel.machon@microchip.com>, UNGLinuxDriver@microchip.com, Rob Herring
 <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Horatiu Vultur
 <horatiu.vultur@microchip.com>, Andrew Lunn <andrew@lunn.ch>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, Allan Nielsen <allan.nielsen@microchip.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v4 1/8] misc: Add support for LAN966x PCI device
Message-ID: <20240808160737.4d8806ee@bootlin.com>
In-Reply-To: <CAHp75Ve0SVSzM36srTY7DwqY5_T9Bkqa0_xyDC2RzU=D1nsTwg@mail.gmail.com>
References: <20240805101725.93947-1-herve.codina@bootlin.com>
	<20240805101725.93947-2-herve.codina@bootlin.com>
	<CAHp75VdtFET87R9DZbz27vEeyv4K5bn7mxDCnBVdpFVJ=j6qtg@mail.gmail.com>
	<20240807120956.30c8264e@bootlin.com>
	<CAHp75Ve0SVSzM36srTY7DwqY5_T9Bkqa0_xyDC2RzU=D1nsTwg@mail.gmail.com>
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

Hi Andy,

On Thu, 8 Aug 2024 15:32:07 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Wed, Aug 7, 2024 at 1:10 PM Herve Codina <herve.codina@bootlin.com> wrote:
> > On Mon, 5 Aug 2024 22:13:38 +0200
> > Andy Shevchenko <andy.shevchenko@gmail.com> wrote:  
> > > On Mon, Aug 5, 2024 at 12:19 PM Herve Codina <herve.codina@bootlin.com> wrote:  
> 
> ...
> 
> > > > +       if (!pdev->irq)
> > > > +               return ERR_PTR(-EOPNOTSUPP);  
> > >
> > > Before even trying to get it via APIs? (see below as well)
> > > Also, when is it possible to have 0 here?  
> >
> > pdev->irq can be 0 if the PCI device did not request any IRQ
> > (i.e. PCI_INTERRUPT_PIN in PCI config header is 0).  
> 
> > I use that to check whether or not INTx is supported.  
> 
> But why do you need that? What happens if you get a new device that
> supports let's say MSI?
> 
> > Even if this code is present in the LAN966x PCI driver, it can be use as a
> > starting point for other drivers and may be moved to a common part in the
> > future.
> >
> > Do you think I should remove it ?  
> 
> I think pci_alloc_vectors() should be enough. Make it to be the first
> call, if you think it's better.
> 

Thanks for your answer.

I will remove the pdev->irq check an rely pci_alloc_vectors().
Not sure that I will move the call to the first call.

Best regards.
Hervé

