Return-Path: <linux-pci+bounces-10377-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D66A932CDD
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2024 17:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24FB91F21681
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2024 15:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069BC19F49D;
	Tue, 16 Jul 2024 15:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="f5WUxMue"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888BE19FA99;
	Tue, 16 Jul 2024 15:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721145513; cv=none; b=h4dmr00aE326tCaqP8D3k8hu7sqE0QudcixCXPv1xG/3Ky5ohn/bqbuGfFEKzcQQQGYlLk1HlSO1iDyohXM7VEKdYdFFu0pQ1gtTpr5QS2zdI8pch5CZ90yeHMKaWOZtkqe3yGLnw+HXBx7RIf1o8JDCFPEPnf2bUfmRy/eeJyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721145513; c=relaxed/simple;
	bh=NDRLYyT8pN/HFDs6K/Dfs1m0KHkA5QT/h/5XhCFwghE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZmqWHx4vv+wKebDsPnFU0RSRvZUxFtHSLNNScHzz/kuOj3yHN2NU5XUKM9m7P2sqYI5bftC2ro3DPmt/z6MDguLPSEUvE3tkTgd4rbLs4z40ygxZ/ANPnZImPXfEQPf6rM8RHii5wzr9Zm9KHtpicyKof08smRjs1yjg3s6xmlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=f5WUxMue; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BEAA81C0006;
	Tue, 16 Jul 2024 15:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1721145503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/6fyfU7hh9xia4CKde5/FfdqWurIEu+oueFw1Yyue2o=;
	b=f5WUxMuemYRLVJeAA6sWlmzDtzBkqz+hbBTE5MQ0kHlOXdG6MUR0c8BtaEs+EqnSCI3Ila
	oWQ7hQ1r4xxK56Gmh+RY5r0HAgbmte0NZFR2vK51PpC9WmuJ/qjiPYGOT91n7b/wmAvwQp
	AARSmzwvBd3AaTQqEiU4c/eNwjxx6JXYEtgDlRT+bI0GkZgmiM4QPzIB8k+kFbXNo+dtNP
	1SjaHNhg6AUvxBYJq9luF1KHnqww9r9kj2tCfM9rbGp0vB4vRmq7N1rQF1xSSxdUBp7MZU
	CCweZyaBh2wC4Xd+/EE6L01nAU2Rf5ke/xhu79Ld/dvkiLfpjzSnInlHCk2qjg==
Date: Tue, 16 Jul 2024 17:58:18 +0200
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
Message-ID: <20240716175818.2ef948d9@bootlin.com>
In-Reply-To: <7289bb54-99f2-4630-a437-21997a9e2b1f@app.fastmail.com>
References: <20240627091137.370572-1-herve.codina@bootlin.com>
	<20240627091137.370572-7-herve.codina@bootlin.com>
	<20240711152952.GL501857@google.com>
	<20240711184438.65446cc3@bootlin.com>
	<2024071113-motocross-escalator-e034@gregkh>
	<CAL_Jsq+1r3SSaXupdNAcXO-4rcV-_3_hwh0XJaBsB9fuX5nBCQ@mail.gmail.com>
	<20240712151122.67a17a94@bootlin.com>
	<83f7fa09-d0e6-4f36-a27d-cee08979be2a@app.fastmail.com>
	<20240715141229.506bfff7@bootlin.com>
	<7289bb54-99f2-4630-a437-21997a9e2b1f@app.fastmail.com>
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

On Tue, 16 Jul 2024 16:44:12 +0200
"Arnd Bergmann" <arnd@arndb.de> wrote:

> On Mon, Jul 15, 2024, at 14:12, Herve Codina wrote:
> > Hi Arnd,
> >
> > On Fri, 12 Jul 2024 16:14:31 +0200
> > "Arnd Bergmann" <arnd@arndb.de> wrote:
> >  
> >> On Fri, Jul 12, 2024, at 15:11, Herve Codina wrote:  
> >> > On Thu, 11 Jul 2024 14:33:26 -0600 Rob Herring <robh@kernel.org> wrote:    
> >> >> On Thu, Jul 11, 2024 at 1:08 PM Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:    
> >>   
> >> >> > >
> >> >> > > This PCI driver purpose is to instanciate many other drivers using a DT
> >> >> > > overlay. I think MFD is the right subsystem.      
> >> >> 
> >> >> It is a Multi-function Device, but it doesn't appear to use any of the
> >> >> MFD subsystem. So maybe drivers/soc/? Another dumping ground, but it
> >> >> is a driver for an SoC exposed as a PCI device.
> >> >>     
> >> >
> >> > In drivers/soc, drivers/soc/microchip/ could be the right place.
> >> >
> >> > Conor, are you open to have the PCI LAN966x device driver in
> >> > drivers/soc/microchip/ ?    
> >> 
> >> That sounds like a much worse fit than drivers/mfd: the code
> >> here does not actually run on the lan966x soc, it instead runs
> >> on whatever other machine you happen to plug it into as a
> >> PCI device.  
> >
> > Maybe drivers/misc ?  
> 
> That's probably a little better, and there is already
> drivers/misc/mchp_pci1xxxx in there, which also has some
> aux devices.
> 
> Maybe we need a new place and then move both of these
> and some of the similar devices from drivers/mfd to that, but
> we don't really have to pick one now.
> 

In the next iteration, I plan to move the lan966x pci driver in
drivers/misc/

Not sure that it needs to be in a subdir.

Best regards
Hervé

