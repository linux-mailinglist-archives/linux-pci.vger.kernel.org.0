Return-Path: <linux-pci+bounces-17466-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BEE99DEBCC
	for <lists+linux-pci@lfdr.de>; Fri, 29 Nov 2024 18:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C018282080
	for <lists+linux-pci@lfdr.de>; Fri, 29 Nov 2024 17:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0789F1A00D1;
	Fri, 29 Nov 2024 17:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jsfNbPPn"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D6A14B962;
	Fri, 29 Nov 2024 17:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732901806; cv=none; b=NVhM7jfXsjkaCbMhetkpi3PXAFPQ8IE71khMSpFfPi/6+LOLkvrg7iqt0WRmbVQ64lyiMe4CzmLsJMDgkAd6LPFmf5FG5CgAU2FKreHuq3K4AJ6WqOZXkug/RbkBLIRPwN45yF8t85g/5fx/q17Zq6g+CXNZ2SNmW1HSoiVKMKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732901806; c=relaxed/simple;
	bh=Am9e06vfxrQwa7zePLWjQsY8vfb6jcJtBoyeRsKXqNc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ep76YtgVEBkulCqL7q2IpQKj697HzSFjKCuYqQzE3GKBu2/7axvtGkrI5ug+uZnExoFk6IEvJTCGlzCwxRw64r2QQ3J6o1aHfc1CHgTC1UkdbmmBurztYoebJFs6yhmhLZROwYHo/z6gDXabUgnk/9bOQMl6E2MnbnAlZbJeMpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jsfNbPPn; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A47B9240015;
	Fri, 29 Nov 2024 17:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732901800;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z02MjlJuh3b3hDQPFS72EpBOSuOXivey6EAK77/5mEo=;
	b=jsfNbPPng/GRegUIEJ4p4mxJOa8AY12nYR20XbQ8t3rkvxi4NdJbUYcQ4tQvsVxfaJEpx5
	OD9BHE20vUPRbjY9K3HLWUewLAcPcTLeIBpdT3VN6pCSeVNisCLFZ0uZd1xQsWAyXCVJGX
	mYiS1Sz1N3iPyl7AdZ2WC8wFTLlUGWraMIy0SBIkA54GSVixqK0aJZPAjdiXm7Bc6k5HIi
	Hn5iJf899ZRyhy0R6cvRjOt38EzG/5YZA2sv0hgstXCMZ9fplreT4vwb8ct4D1G9BTqPvN
	e2FWnmGmQ6zaah6xPjFkOIxCYtVO8hGsdI92t1qD45flUEypQIWtibQRa8/B2g==
Date: Fri, 29 Nov 2024 18:36:36 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Michal Kubecek <mkubecek@suse.cz>, Andy
 Shevchenko <andy.shevchenko@gmail.com>, Simon Horman <horms@kernel.org>,
 Lee Jones <lee@kernel.org>, "derek.kiernan@amd.com"
 <derek.kiernan@amd.com>, "dragan.cvetic@amd.com" <dragan.cvetic@amd.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Philipp Zabel <p.zabel@pengutronix.de>, Lars Povlsen
 <lars.povlsen@microchip.com>, Steen Hegelund
 <Steen.Hegelund@microchip.com>, Daniel Machon
 <daniel.machon@microchip.com>, UNGLinuxDriver@microchip.com, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Saravana Kannan <saravanak@google.com>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Horatiu Vultur
 <horatiu.vultur@microchip.com>, Andrew Lunn <andrew@lunn.ch>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Netdev
 <netdev@vger.kernel.org>, linux-pci@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Allan Nielsen
 <allan.nielsen@microchip.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Ricardo Ribalda
 <ribalda@chromium.org>
Subject: Re: [PATCH v9 1/6] misc: Add support for LAN966x PCI device
Message-ID: <20241129183636.7043fa66@bootlin.com>
In-Reply-To: <CAMuHMdWgqEZtd82hSp0iYahtTcTnORFytTm11EiZOjLf8V9tQw@mail.gmail.com>
References: <20241010063611.788527-1-herve.codina@bootlin.com>
	<20241010063611.788527-2-herve.codina@bootlin.com>
	<dywwnh7ns47ffndsttstpcsw44avxjvzcddmceha7xavqjdi77@cqdgmpdtywol>
	<20241129091013.029fced3@bootlin.com>
	<1a895f7c-bbfc-483d-b36b-921788b07b36@app.fastmail.com>
	<CAMuHMdWXgXiHNUhrXB9jT4opnOQYUxtW=Vh0yBQT0jJS49+zsw@mail.gmail.com>
	<93ad42dc-eac6-4914-a425-6dbcd5dccf44@app.fastmail.com>
	<CAMuHMdWgqEZtd82hSp0iYahtTcTnORFytTm11EiZOjLf8V9tQw@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Hi,

+Cc Ricardo

On Fri, 29 Nov 2024 11:29:44 +0100
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Hi Arnd,
> 
> On Fri, Nov 29, 2024 at 10:23 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > On Fri, Nov 29, 2024, at 09:44, Geert Uytterhoeven wrote:  
> > > On Fri, Nov 29, 2024 at 9:25 AM Arnd Bergmann <arnd@arndb.de> wrote:  
> > >> On Fri, Nov 29, 2024, at 09:10, Herve Codina wrote:
> > >> I would write in two lines as
> > >>
> > >>         depends on PCI
> > >>         depends on OF_OVERLAY
> > >>
> > >> since OF_OVERLAY already depends on OF, that can be left out.
> > >> The effect is the same as your variant though.  
> > >
> > > What about
> > >
> > >     depends on OF
> > >     select OF_OVERLAY
> > >
> > > as "OF" is a clear bus dependency, due to the driver providing an OF
> > > child bus (cfr. I2C or SPI bus controller drivers depending on I2C or
> > > SPI), and OF_OVERLAY is an optional software mechanism?  
> >

A patch has be done in that way by Ricardo Ribalda
  https://lore.kernel.org/all/20241129-lan966x-depend-v1-1-603fc4996c4f@chromium.org/

> > OF_OVERLAY is currently a user visible option, so I think it's
> > intended to be used with 'depends on'. The only other callers
> > of this interface are the kunit test modules that just leave
> > out the overlay code if that is disabled.  
> 
> Indeed, there are no real upstream users of OF_OVERLAY left.
> Until commit 1760eb547276299a ("drm: rcar-du: Drop leftovers
> dependencies from Kconfig"), the rcar-lvds driver selected OF_OVERLAY
> to be able to fix up old DTBs.
> 
> > If we decide to treat OF_OVERLAY as a library instead, it should
> > probably become a silent Kconfig option that gets selected by
> > all its users including the unit tests, and then we can remove
> > the #ifdef checks there.  
> 
> Yep.
> 
> > Since OF_OVERLAY pulls in OF_DYNAMIC, I would still prefer that
> > to be a user choice. Silently enabling OF_OVERLAY definitely has
> > a risk of introducing regressions since it changes some of the
> > interesting code paths in the core, in particular it enables
> > reference counting in of_node_get(), which many drivers get wrong.  
> 
> Distro kernels will have to enable this anyway, if they want to
> support LAN966x...
> 

Best regards,
Hervé

