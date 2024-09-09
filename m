Return-Path: <linux-pci+bounces-12940-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6DF97100F
	for <lists+linux-pci@lfdr.de>; Mon,  9 Sep 2024 09:46:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C93051F22C87
	for <lists+linux-pci@lfdr.de>; Mon,  9 Sep 2024 07:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE021AF4E9;
	Mon,  9 Sep 2024 07:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MYcZfupA"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100A1172BCE;
	Mon,  9 Sep 2024 07:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725867970; cv=none; b=LaLXtS8/Cv1jXxAQBfy0tMeY2d77D9d+LXODKT6N/NK+2NkqbLdyCJTvn1FYfxrDR/cdklPmiOGE21/OeSQfinEgWwCOparvJ3WdaDRzZaBdb8AmLCJJP4uIbhZHgnm5hHrfsDKnmQRN+ZT3bPbSw+d7+rOeAQQKRaJXejZ5fME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725867970; c=relaxed/simple;
	bh=usR1pa53UGdMCV6/LNXgemsvTIq2YpsDIf+l+rBvhVE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PFiFQBzUVmFf/PvGgofx6bV8qy+VI8IBaS/3Big3Nzx/2FGcpSU+KB59pkCI1NFU9JvT0HWsi6TxskOt1BI/teIEfpxfVjFTVPTg4+cHmVfM77Y41zxV7/pijoJYw6AzjtgM9m+sfNbxTLZW0+cmziqCSrR2yE/DAMn1aEC6/HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MYcZfupA; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2D4B01C0009;
	Mon,  9 Sep 2024 07:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1725867958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hJaC0HWL8QFh/tgOwfDDBfAbVaCe45J448i8/ZUpWZw=;
	b=MYcZfupA7H62RyKeIANbWTrwQppl333+j/qywB0iNywL8VuYvSIIET77QWNnNw/Aak5+2X
	yxxkrWh01O8Ktm0lf3RKTLmJS26YuSe61fPR4VQ+/mlZ5ch0G4gVrBiokzMeilTErg2PzI
	IXcPQKXb5MlJ+MhaISBgY7hdZyCDrK7Wvphtik9GkWE512Al2CWTLpH2Lr28IDOg3YkLTH
	tS1/cwfEECJFFqop2osjuAIDd4dl9SPuhotNiohmAlDvzg9sfdWr2HFLWVg8eSJM2YQlvT
	fy47zDVSRmD6pV9713wizaWlxKglvyDWcP7tn8uccTvnOGjHxen97RUmH77zFg==
Date: Mon, 9 Sep 2024 09:45:54 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Andy Shevchenko
 <andy.shevchenko@gmail.com>, Simon Horman <horms@kernel.org>, Lee Jones
 <lee@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Derek Kiernan
 <derek.kiernan@amd.com>, Dragan Cvetic <dragan.cvetic@amd.com>, Bjorn
 Helgaas <bhelgaas@google.com>, Philipp Zabel <p.zabel@pengutronix.de>, Lars
 Povlsen <lars.povlsen@microchip.com>, Steen Hegelund
 <Steen.Hegelund@microchip.com>, Daniel Machon
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
Subject: Re: [PATCH v5 1/8] misc: Add support for LAN966x PCI device
Message-ID: <20240909094554.20523717@bootlin.com>
In-Reply-To: <2024081356-mutable-everyday-6f9d@gregkh>
References: <20240808154658.247873-1-herve.codina@bootlin.com>
	<20240808154658.247873-2-herve.codina@bootlin.com>
	<2024081356-mutable-everyday-6f9d@gregkh>
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

Hi Greg, Rob,

On Tue, 13 Aug 2024 11:57:15 +0200
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Thu, Aug 08, 2024 at 05:46:50PM +0200, Herve Codina wrote:
> > Add a PCI driver that handles the LAN966x PCI device using a device-tree
> > overlay. This overlay is applied to the PCI device DT node and allows to
> > describe components that are present in the device.
> > 
> > The memory from the device-tree is remapped to the BAR memory thanks to
> > "ranges" properties computed at runtime by the PCI core during the PCI
> > enumeration.
> > 
> > The PCI device itself acts as an interrupt controller and is used as the
> > parent of the internal LAN966x interrupt controller to route the
> > interrupts to the assigned PCI INTx interrupt.
> > 
> > Signed-off-by: Herve Codina <herve.codina@bootlin.com>  
> 
> misc device is fine, even if it's not really one :)
> 
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

I didn't receive other feedback on this patch.

Is there anything blocking to have it applied?

Best regards,
Hervé

