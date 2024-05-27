Return-Path: <linux-pci+bounces-7882-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1C08D0C02
	for <lists+linux-pci@lfdr.de>; Mon, 27 May 2024 21:15:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 167841F24087
	for <lists+linux-pci@lfdr.de>; Mon, 27 May 2024 19:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6533B15FA91;
	Mon, 27 May 2024 19:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="AskB/Z8j"
X-Original-To: linux-pci@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E5A15A84C;
	Mon, 27 May 2024 19:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716837323; cv=none; b=ud3/lToApiSv4Jzc+eg6LmrtlHr9nwNBzS08ErR7+bkpG27NteQiRW44DOv+GR9c3B3X+nbtH2BcAIViVEA6ZxQ6jaxACmlSKczsFJi8UvRciW9poavOjV08VGVMBPQJBf7qo0a6zsv7QcCganH+J85hklPn7FATtzCoMBL9n9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716837323; c=relaxed/simple;
	bh=t9dKE3OE+UvOv+I9BogWYUHVDJOyOwmwZ3HVgvQEEKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sQYO/gNaCuUT2DPLTq1KV3UWQVd1iyviCKmKlxydn0+v+DGOm6tixqw4HYg6EuYvJUALTyro8BNG8f8+8qYxBDY4s2YTYQt2TO88c5g0+9rxuwniM+t7xY0ysYHcBaJ41ld4U+60kf2qahAoD1eoxJoIDf0BRsViaNPSC6RJ4YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=AskB/Z8j; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=pQs5qfLOie+oe4AgGFwygJ+ARY+6siqECSzhKcrqjU0=; b=AskB/Z8jzs0FQXvTKWgZ7KNibN
	77NCciN9MVIeAQ4N+2L8iLvI6/GbIceDW2lFwZIfoYAPya9+a5V19dI5qYhFPNvtkZY3an3rrF/Zh
	eSXzK3Cpz2CpdQXYFTcFCvyolpCeVnD087l804lWZMFNKIeY1M2T7tHQ94xLdIVJv3T4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sBfoB-00G6Gg-2j; Mon, 27 May 2024 21:14:59 +0200
Date: Mon, 27 May 2024 21:14:59 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Simon Horman <horms@kernel.org>,
	Sai Krishna Gajula <saikrishnag@marvell.com>,
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
Subject: Re: [PATCH v2 06/19] dt-bindings: net: mscc-miim: Add resets property
Message-ID: <6bc36a52-dc73-41d3-ba5b-863277974b95@lunn.ch>
References: <20240527161450.326615-1-herve.codina@bootlin.com>
 <20240527161450.326615-7-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527161450.326615-7-herve.codina@bootlin.com>

On Mon, May 27, 2024 at 06:14:33PM +0200, Herve Codina wrote:
> Add the (optional) resets property.
> The mscc-miim device is impacted by the switch reset especially when the
> mscc-miim device is used as part of the LAN966x PCI device.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

