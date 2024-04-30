Return-Path: <linux-pci+bounces-6887-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 376EB8B7787
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 15:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F8C6B21E5D
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 13:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CDC5171E76;
	Tue, 30 Apr 2024 13:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="tYr7GrB9"
X-Original-To: linux-pci@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EE1171E6E;
	Tue, 30 Apr 2024 13:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714484790; cv=none; b=E/Xhj33vgngWObGf02gD6AjSY3uMqaTVhM1bMcI2RNlBxbBjJunuTPVUPASXbyPQwcRHhrj+WkV/2U9k3hsD1cRyyVUHLaxF0mFm8/9iKAQSGUr36Z/e+g592cduYiSK4OM1i0/oYpqHR46P9z3b7TyDGTPm3Ry3czsMHHq6CbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714484790; c=relaxed/simple;
	bh=yMY0E7DO6GwkuZa6LT1cc1T3vKerp03DvKfrKAuiXcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TjsC8zWVTY8X8eGrFxzOeIbT9YujOMFe15/3qL183U96qBD4EIGSZSQrt/Kij57hlvDUqbJodO/Pw4I+hhBqrp+PDpj8bOi3fsoBfX/E3fwVxAiqBNyJcHOyYINkqEjbVNNflvEaeIDdh0lyqrBaZNJs1k7ektF7ZuJGDt2FoRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=tYr7GrB9; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=DmItdwrvtWkHQ1poDnp7KwnHSSMiTJm6aaPxu9AvxOE=; b=tYr7GrB9EG9BkbGcCbfYtCxiuZ
	4wBgwayVXypgMQfbCASK2sRmN6vIoUS9Q3KcB9AxhfXEJUI3GmlMV/6vNO/2CKLZvxv8uDjXzVRGm
	ri8V+oQrnyGG4a7jsMP0GSAgZFKFTjf4w017pe90jclJmBSKDBrA/fuCF5n0en+5WLEM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s1noI-00ELLM-H9; Tue, 30 Apr 2024 15:46:18 +0200
Date: Tue, 30 Apr 2024 15:46:18 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
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
Subject: Re: [PATCH 07/17] net: mdio: mscc-miim: Handle the switch reset
Message-ID: <74e40e5d-e71f-4909-811e-7e9fc1120360@lunn.ch>
References: <20240430083730.134918-1-herve.codina@bootlin.com>
 <20240430083730.134918-8-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430083730.134918-8-herve.codina@bootlin.com>

On Tue, Apr 30, 2024 at 10:37:16AM +0200, Herve Codina wrote:
> The mscc-miim device can be impacted by the switch reset, at least when
> this device is part of the LAN966x PCI device.

Just to be sure i understand this correctly. The MDIO bus master can
be reset using the "switch" reset. So you are adding code to ensure
the "switch" reset is out of reset state, so the MDIO bus master
works.

Given that this is a new property, maybe give it a better name to
indicate it resets both the switch and the MDIO bus master?

	 Andrew

