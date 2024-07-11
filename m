Return-Path: <linux-pci+bounces-10168-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E23392ECFD
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2024 18:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 480771C21AD5
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2024 16:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D9916D4C3;
	Thu, 11 Jul 2024 16:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="P8v+jtd1"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4F31474D3;
	Thu, 11 Jul 2024 16:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720716287; cv=none; b=cUCNQ+CHAqJIG2jrvzTnnfj+gmUeFvyEzTlKg3tHxuVRrZJ8ttLiUAAQIN2FIo0j9LW6iVlYfOANLtxpD5Oo0tVNL2JKrpd/daO2aJcpsGm1fcHLXITOeu83OWx2zlJvuiiETKjlgBjHm9CgT9q5Sdfvw3mQVbhyKuT+OyI6CQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720716287; c=relaxed/simple;
	bh=2vqenC3vyN4xU/GXyPVLXXzBBrBJTvgmVlmz9ziNDvM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o1wtoa8DqC3BD4QyMOyQYuefja6noPU34yZY4pUrjqF7L64CYgn0LgchfMocFKhTZkXx9TqQSjDtnNn4MczRrkrU5eq9KdgF6jW77LdZAwXX5HummZmLW1eOvc9lyXCP5ZbzdncuWD+31ToxTVhCQf5Vy0ca34keyD/OdhOU51U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=P8v+jtd1; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 668B7E0004;
	Thu, 11 Jul 2024 16:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1720716282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vybloJtqAMD3XBXViDgsQDiBzU52F1YzHw5VHYlk7nY=;
	b=P8v+jtd1ys5EiH6FMRVDPUMNPab4NRp9wkAGbEK57+f4iby7pSGs18DQ8P4Y4ZLvuK5WLj
	SQQ1kcxRfly3QwFY6kvql7ACeTUqF57HksCL4JJj4Fkf4v/J/gipIXtdkVgOEht7nCCpcH
	hEPaFCptezq+Derxp7uiXWiOq1+bGEkLmF5fpqbhzgrbwsAqNmlwhxYGjUTsZA9avOX4tH
	LwtljISqcHPjmdYuHF1pQYHr/9B1esqtLWTba+vvfMLxU/2lO970tOuj2sZRFMyqDBuGLK
	9l0YwOfE2kna6alACHj/ngciu9N3lo4TKwV0QkCg2l8wMRw1lRswMsGlr3HVLw==
Date: Thu, 11 Jul 2024 18:44:38 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Lee Jones <lee@kernel.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Simon Horman
 <horms@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Arnd Bergmann
 <arnd@arndb.de>, UNGLinuxDriver@microchip.com, Saravana Kannan
 <saravanak@google.com>, Bjorn Helgaas <bhelgaas@google.com>, Philipp Zabel
 <p.zabel@pengutronix.de>, Lars Povlsen <lars.povlsen@microchip.com>, Steen
 Hegelund <Steen.Hegelund@microchip.com>, Daniel Machon
 <daniel.machon@microchip.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Horatiu Vultur <horatiu.vultur@microchip.com>,
 Andrew Lunn <andrew@lunn.ch>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, netdev@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Allan
 Nielsen <allan.nielsen@microchip.com>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 6/7] mfd: Add support for LAN966x PCI device
Message-ID: <20240711184438.65446cc3@bootlin.com>
In-Reply-To: <20240711152952.GL501857@google.com>
References: <20240627091137.370572-1-herve.codina@bootlin.com>
	<20240627091137.370572-7-herve.codina@bootlin.com>
	<20240711152952.GL501857@google.com>
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

Hi Lee,

On Thu, 11 Jul 2024 16:29:52 +0100
Lee Jones <lee@kernel.org> wrote:

> On Thu, 27 Jun 2024, Herve Codina wrote:
> 
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
> 
> Not entirely sure why this is in MFD.

This PCI driver purpose is to instanciate many other drivers using a DT
overlay. I think MFD is the right subsystem.

It acts as an interrupt controller because we need to have a bridge between the
device-tree interrupt world and the the PCI world.
This bridge is needed and specific to the driver in order to have resources
available from the device-tree world present in the applied overlay.

> 
> Also I'm unsure of his current views, but Greg has voiced pretty big
> feelings about representing PCI drivers as Platform ones in the past.

PCI drivers as Plaform ones ?
I probably missed something. Can you give me more details ?

Best regards,
Hervé

