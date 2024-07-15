Return-Path: <linux-pci+bounces-10260-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D939313BA
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 14:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6202D281974
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 12:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF49218A957;
	Mon, 15 Jul 2024 12:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="C72YI2wv"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB2823BF;
	Mon, 15 Jul 2024 12:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721045564; cv=none; b=g74OayVrMNODovPAs57hRqF+D69oEv8ugWagBKMwFFDJOJKclpMxOR1C18ym/e4gzm5yRtel5l8psSc+3oDs9n0TE0ASxyTCrkdUddEtDzWQ/SyobVXaWJOk8VMFtvXDrq0p0YyVBxEs0AYFiYoHfM4Q4qSqAsIKIEtnyaBn8hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721045564; c=relaxed/simple;
	bh=VMT/rOOT1qU6Hq3BJfq7+bEmeu/KFHSk04Ws3Ap/4ck=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CixhIZAfeYB5tBb8J8948/wYsNPE2TGogervwopoookf6+5WCUKz0dD8c/Qlc595bvc18Jcjj76d6CLLEY8fPQ86ZXOsm1l8x9Xgr7lHjAEq5kjo5tnosjvbhOeeKFaRP7fQAu+m40s+obQPV0ImDnVy24JnuvQL5ra3Z6oVuKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=C72YI2wv; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4A18DFF807;
	Mon, 15 Jul 2024 12:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1721045554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J42xHR7gwk4N29F7WjDkMRYuLDoqLtCVLUGQwLuIj/c=;
	b=C72YI2wvQberRhw2lVvuDSA+IPGFIE/OYIHxbtnYZM3vI9rff8lNmiBdud4necXX0yPdL2
	tRLV/EmzVfjFoxUSRvJ9gntMpsyEXBvavtT2eajp73QNd3Xg/yf8ce0JreU4aoLahoqWOu
	Vg2ynDc3WQ3uRPZBJsqt1Jdu3sw/Ku+8ISx7ujQ4IYn57r3ZcgmOK0GMiPmS8vl+Aff5xs
	zvwWXZYwpghuWnR2GKE0iVl7MPpYMSqa0/APTgBjIm3BC7LooahALXAKdbQW3eBtkMOt3y
	TJ2HKx0utDS0yL4Y3A9Dr5wNs6DM0eGlOoOo+S5x1A+5LpHu552OKkV02V5brw==
Date: Mon, 15 Jul 2024 14:12:29 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: "Arnd Bergmann" <arnd@arndb.de>
Cc: "Rob Herring" <robh@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Conor Dooley" <conor@kernel.org>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Lee Jones" <lee@kernel.org>, "Andy
 Shevchenko" <andy.shevchenko@gmail.com>, "Simon Horman" <horms@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, UNGLinuxDriver@microchip.com,
 "Saravana Kannan" <saravanak@google.com>, "Bjorn Helgaas"
 <bhelgaas@google.com>, "Philipp Zabel" <p.zabel@pengutronix.de>, "Lars
 Povlsen" <lars.povlsen@microchip.com>, "Steen Hegelund"
 <Steen.Hegelund@microchip.com>, "Daniel Machon"
 <daniel.machon@microchip.com>, "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Horatiu Vultur"
 <horatiu.vultur@microchip.com>, "Andrew Lunn" <andrew@lunn.ch>,
 devicetree@vger.kernel.org, Netdev <netdev@vger.kernel.org>,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Allan
 Nielsen" <allan.nielsen@microchip.com>, "Luca Ceresoli"
 <luca.ceresoli@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v3 6/7] mfd: Add support for LAN966x PCI device
Message-ID: <20240715141229.506bfff7@bootlin.com>
In-Reply-To: <83f7fa09-d0e6-4f36-a27d-cee08979be2a@app.fastmail.com>
References: <20240627091137.370572-1-herve.codina@bootlin.com>
	<20240627091137.370572-7-herve.codina@bootlin.com>
	<20240711152952.GL501857@google.com>
	<20240711184438.65446cc3@bootlin.com>
	<2024071113-motocross-escalator-e034@gregkh>
	<CAL_Jsq+1r3SSaXupdNAcXO-4rcV-_3_hwh0XJaBsB9fuX5nBCQ@mail.gmail.com>
	<20240712151122.67a17a94@bootlin.com>
	<83f7fa09-d0e6-4f36-a27d-cee08979be2a@app.fastmail.com>
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

Hi Arnd,

On Fri, 12 Jul 2024 16:14:31 +0200
"Arnd Bergmann" <arnd@arndb.de> wrote:

> On Fri, Jul 12, 2024, at 15:11, Herve Codina wrote:
> > On Thu, 11 Jul 2024 14:33:26 -0600 Rob Herring <robh@kernel.org> wrote:  
> >> On Thu, Jul 11, 2024 at 1:08 PM Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:  
> 
> >> > >
> >> > > This PCI driver purpose is to instanciate many other drivers using a DT
> >> > > overlay. I think MFD is the right subsystem.    
> >> 
> >> It is a Multi-function Device, but it doesn't appear to use any of the
> >> MFD subsystem. So maybe drivers/soc/? Another dumping ground, but it
> >> is a driver for an SoC exposed as a PCI device.
> >>   
> >
> > In drivers/soc, drivers/soc/microchip/ could be the right place.
> >
> > Conor, are you open to have the PCI LAN966x device driver in
> > drivers/soc/microchip/ ?  
> 
> That sounds like a much worse fit than drivers/mfd: the code
> here does not actually run on the lan966x soc, it instead runs
> on whatever other machine you happen to plug it into as a
> PCI device.

Maybe drivers/misc ?

Best regards,
Hervé

