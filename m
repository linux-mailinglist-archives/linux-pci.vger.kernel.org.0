Return-Path: <linux-pci+bounces-7046-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67AFB8BAF19
	for <lists+linux-pci@lfdr.de>; Fri,  3 May 2024 16:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA1F42842A0
	for <lists+linux-pci@lfdr.de>; Fri,  3 May 2024 14:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8BB179BD;
	Fri,  3 May 2024 14:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LI/G1r9+"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABE957CB7;
	Fri,  3 May 2024 14:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714747218; cv=none; b=ZyREa1eW3XqPnRRNeaY3OYSqbYB+FLRdeXEIdHvRzc9Yg2hrHxNlxQL97WgoihT78aEEnnR8nNIdWp3xBvunYXJHmIuZDiv0OSg+SsmrG/RcU6uVZLjyixgvZVmHWQYqoUX5n7l+qFIfQefTb9A7zSjIyQ81ldxMMPuqrYM8Jmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714747218; c=relaxed/simple;
	bh=7BtnR9RIBEkfdbceTTLR0pLPolLNCRzRcmlTMaHVZ24=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uN6/r+zs8WqjquOm5ApiQ57ugQvkBKpX8NNwDlnW+aGociqo0WFyCZDMCd03UaFqedoYElPW/l6uNDyd3RfsBk1/AB9BFrXBf/SuEY8MfJhlVCi42fvB7vX3HrhgyA0ofWoTiuo+EzQ7lFZLGIhWbsqHaHSPQxiM0/PNwSp/I64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LI/G1r9+; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D60A1C0005;
	Fri,  3 May 2024 14:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1714747208;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tf6rG3rOuawc5yY8Jvkp/nAZaJ9cong6+YwM20vUweQ=;
	b=LI/G1r9+F5hHmudrVZgl+FhWe1cx3c4zASY1twGIyWwNBd0bKtOgrb64vqpw+L/vbBWTkZ
	WTFzxF+zCHvvzjW6FVSIvLh9AnMfTwU677Fox74DwaahvBPH78XbQAFp/syUaLC9rf8Y0m
	Y/ueil+R5O5WGty2ArXqfbquZLIZ1Q7NuLOsw2pj4FdOgpaBsTr1jr0jk8XcRzFGujTPSF
	EMzN3ivFepb212GPm9OGEFMxZoL17qfYrSfRaNnTuHxKnn8xDLHHtea0mAk4CX7+6nijDW
	GLQNWXELwoYlRw+MewekajkgP41hBz+B/UbHP9GVY/U5xLgwUVvf4Kt76Ts2JQ==
Date: Fri, 3 May 2024 16:40:03 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Lee Jones <lee@kernel.org>, Arnd Bergmann
 <arnd@arndb.de>, Horatiu Vultur <horatiu.vultur@microchip.com>,
 UNGLinuxDriver@microchip.com, Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, Saravana
 Kannan <saravanak@google.com>, Bjorn Helgaas <bhelgaas@google.com>, Philipp
 Zabel <p.zabel@pengutronix.de>, Lars Povlsen <lars.povlsen@microchip.com>,
 Steen Hegelund <Steen.Hegelund@microchip.com>, Daniel Machon
 <daniel.machon@microchip.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, netdev@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Allan
 Nielsen <allan.nielsen@microchip.com>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 15/17] pci: of_property: Add the interrupt-controller
 property in PCI device nodes
Message-ID: <20240503164003.36e7f182@bootlin.com>
In-Reply-To: <20240501173826.GA808463@bhelgaas>
References: <20240430083730.134918-16-herve.codina@bootlin.com>
	<20240501173826.GA808463@bhelgaas>
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

Hi Bjorn,

On Wed, 1 May 2024 12:38:26 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> In subject: s/pci:/PCI:/ to match history. s/Add the/Add/ for brevity.

Will be done in the next iteration.

> 
> On Tue, Apr 30, 2024 at 10:37:24AM +0200, Herve Codina wrote:
> > PCI devices and bridges DT nodes created during the PCI scan are created
> > with the interrupt-map property set to handle interrupts.
> > 
> > In order to set this interrupt-map property at a specific level, a
> > phandle to the parent interrupt controller is needed.
> > On systems that are not fully described by a device-tree, the parent
> > interrupt controller may be unavailable (i.e. not described by the
> > device-tree).  
> 
> Rewrap into one paragraph or add blank line to separate paragraphs.

Will be rewrapped in one paragraph in the next iteration.

Thanks for your review.
Best regards,
Hervé

