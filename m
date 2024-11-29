Return-Path: <linux-pci+bounces-17441-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 354789DC03E
	for <lists+linux-pci@lfdr.de>; Fri, 29 Nov 2024 09:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78926281992
	for <lists+linux-pci@lfdr.de>; Fri, 29 Nov 2024 08:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB4D91581E1;
	Fri, 29 Nov 2024 08:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Vl3fTfXg"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7340745C14;
	Fri, 29 Nov 2024 08:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732867832; cv=none; b=DdV+TGXNFL9tcBEC+kxMSyGqOhZ/GmeZkY9h6fIhpxJLBdv3gXb345qaRG8HI9wDhhq/qrxCQbclzq3UDoWlO9nBX90ldotcIE/TRSJIeAF7kecQeZabPLgzeTR3jzcAc+wUjsmVn1De35CzlIk3YN8a3k/iiw0JWRMjqEVvHuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732867832; c=relaxed/simple;
	bh=AYPeFCSY+ZM8FxtiRhfjwjKx4LWm2P0yK9KPPipft6U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EExgx+2P45AF1NzBsVzCtrHdIpOtYJjXdXbeS4I5Mqq1xfmVucnBGa2UbhbIbYxDe4o4IqzedSZ95YTpDqRnSU41rX4Th/L55rkiqIKOZ765N7YIaci+dHUIaNU/O6NUCRQig9JzWBAgSzoOWdZWdIu9FZY1lAXCPNzkVRTv8u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Vl3fTfXg; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id ADF4240003;
	Fri, 29 Nov 2024 08:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732867819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xI6ZyEQYlO67EDyhVXwWpx45NB2tNXa1Y4U0cY6j/nk=;
	b=Vl3fTfXgOUqb4XayzRUopNxuNO2a0PA88El3Vu57k1X2uvPqC3YDMFL4SXXvcnqdEv2qcC
	p7VAOtljAwIHPBmNSp/2/uIvdwozWyEuG9XBsypuWuD9uKEPEgHC0fLTumczbcD3dofyC9
	qwO/5TjFzq8qFITgBpYSGKkjQ8BvHIjfMvKXBRMcXgC/2yjhWejvojKqQRsryivCiD1JCy
	dx5myJsMw0QS86yN7CcSdrwNtG5t2wrN0bmKXVAjU9S2vPTG9ALfB6xSEIHzaGIeJBjGxS
	iM8o8ZeVZ4ex/HxBnuVh1FCfjxnQ9p06O9oGcM/2Z2YNI4a1b9mEiZwCTOlX7A==
Date: Fri, 29 Nov 2024 09:10:13 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Michal Kubecek <mkubecek@suse.cz>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Andy Shevchenko
 <andy.shevchenko@gmail.com>, Simon Horman <horms@kernel.org>, Lee Jones
 <lee@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Derek Kiernan
 <derek.kiernan@amd.com>, Dragan Cvetic <dragan.cvetic@amd.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Philipp Zabel <p.zabel@pengutronix.de>, Lars Povlsen
 <lars.povlsen@microchip.com>, Steen Hegelund
 <Steen.Hegelund@microchip.com>, Daniel Machon
 <daniel.machon@microchip.com>, UNGLinuxDriver@microchip.com, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Saravana Kannan <saravanak@google.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Horatiu Vultur
 <horatiu.vultur@microchip.com>, Andrew Lunn <andrew@lunn.ch>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Allan Nielsen
 <allan.nielsen@microchip.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v9 1/6] misc: Add support for LAN966x PCI device
Message-ID: <20241129091013.029fced3@bootlin.com>
In-Reply-To: <dywwnh7ns47ffndsttstpcsw44avxjvzcddmceha7xavqjdi77@cqdgmpdtywol>
References: <20241010063611.788527-1-herve.codina@bootlin.com>
	<20241010063611.788527-2-herve.codina@bootlin.com>
	<dywwnh7ns47ffndsttstpcsw44avxjvzcddmceha7xavqjdi77@cqdgmpdtywol>
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

Hi Michal,

On Thu, 28 Nov 2024 20:42:53 +0100
Michal Kubecek <mkubecek@suse.cz> wrote:

...
> > --- a/drivers/misc/Kconfig
> > +++ b/drivers/misc/Kconfig
> > @@ -610,6 +610,30 @@ config MARVELL_CN10K_DPI
> >  	  To compile this driver as a module, choose M here: the module
> >  	  will be called mrvl_cn10k_dpi.
> >  
> > +config MCHP_LAN966X_PCI
> > +	tristate "Microchip LAN966x PCIe Support"
> > +	depends on PCI
> > +	select OF
> > +	select OF_OVERLAY  
> 
> Are these "select" statements what we want? When configuring current
> mainline snapshot, I accidentally enabled this driver and ended up
> flooded with an enormous amount of new config options, most of which
> didn't make much sense on x86_64. It took quite long to investigate why.
> 
> Couldn't we rather use
> 
> 	depends on PCI && OF && OF_OVERLAY
> 
> like other drivers?
> 

I don't have a strong opinion on this 'select' vs 'depends on' for those
symbols.

I used select because the dependency is not obvious for a user that just
want the driver for the LAN966x PCI device.

Best regards,
Hervé

