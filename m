Return-Path: <linux-pci+bounces-6888-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD0B98B77AE
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 15:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC308B20D92
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 13:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CFDD172794;
	Tue, 30 Apr 2024 13:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Gq+InA1z"
X-Original-To: linux-pci@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD283AC16;
	Tue, 30 Apr 2024 13:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714485371; cv=none; b=YQqNKC0haB1FeGrXU3elKVo4adaiHo8jFOKpDJN8l1kXkGNCeV0d7SSEuenaBZvwXsUHT4EJZEm2RrWa6T1DkWnDsyvXyVh1P0/kXbHFLfROzXZqKiD7JJLgf9y2fxWsJ7+WmtdFvj8iTm82TD1eCjg62yJmdvb3zrs0/enZSvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714485371; c=relaxed/simple;
	bh=KJAUaEgFcZsb19v2jnocVjIWhEitYWWvWoQpiXDUSVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ey3gJt59tpT7iyyhBNpZCPc16fGx6HO2BOoZM47+el4uZcTo6aJut8OIXlWTdJjBJOKJ9aEZqBwWwygmATuDID7xHeqrZwbuzHe88wQxrM/7YwsBNy8xmGZrc8mzAvqqMKPoCf4ejGksXdy5gsdcZVclN9k1YcENc/5Y9I+Kg5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Gq+InA1z; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=dH9Hrnu56eQ6hZPqq2X0hsqCxQsq5z3exzFLte5ULcw=; b=Gq+InA1z/ou0yW4hfvqA5DzEkK
	fmHae/3NoDsB16hdWZ1IlOweivHyhah+zXNF/gO84adewtCO7zPXb+QEpsr3smHaVpqabfWzPP36i
	hOwOrlUdFwRHN1ydlQer3QvO/hd1wa5GBmRzB13HPTCsfxf3L2vW469+0TSkId8OPVU8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s1nxe-00ELPE-K0; Tue, 30 Apr 2024 15:55:58 +0200
Date: Tue, 30 Apr 2024 15:55:58 +0200
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
Subject: Re: [PATCH 06/17] dt-bindings: net: mscc-miim: Add resets property
Message-ID: <5d899584-38ed-4eee-9ba5-befdedbc5734@lunn.ch>
References: <20240430083730.134918-1-herve.codina@bootlin.com>
 <20240430083730.134918-7-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430083730.134918-7-herve.codina@bootlin.com>

On Tue, Apr 30, 2024 at 10:37:15AM +0200, Herve Codina wrote:
> Add the (optional) resets property.
> The mscc-miim device is impacted by the switch reset especially when the
> mscc-miim device is used as part of the LAN966x PCI device.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
>  Documentation/devicetree/bindings/net/mscc,miim.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/mscc,miim.yaml b/Documentation/devicetree/bindings/net/mscc,miim.yaml
> index 5b292e7c9e46..a8c92cec85a6 100644
> --- a/Documentation/devicetree/bindings/net/mscc,miim.yaml
> +++ b/Documentation/devicetree/bindings/net/mscc,miim.yaml
> @@ -38,6 +38,14 @@ properties:
>  
>    clock-frequency: true
>  
> +  resets:
> +    items:
> +      - description: Reset controller used for switch core reset (soft reset)

A follow up to the comment on the next patch. I think it should be
made clear in the patch and the binding, the aim is to reset the MDIO
bus master, not the switch. It just happens that the MDIO bus master
is within the domain of the switch core, and so the switch core reset
also resets the MDIO bus master.

Architecturally, this is important. I would not expect the MDIO driver
to be resetting the switch, the switch driver should be doing
that. But we have seen some odd Qualcomm patches where the MDIO driver
has been doing things outside the scope of MDIO, playing with resets
and clocks which are not directly related to the MDIO bus master. I
want to avoid any confusion here, especially when Qualcomm tries
again, and maybe points at this code.

	Andrew

