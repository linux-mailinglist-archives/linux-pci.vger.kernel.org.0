Return-Path: <linux-pci+bounces-13713-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF7098D373
	for <lists+linux-pci@lfdr.de>; Wed,  2 Oct 2024 14:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5E812839FF
	for <lists+linux-pci@lfdr.de>; Wed,  2 Oct 2024 12:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5211D0147;
	Wed,  2 Oct 2024 12:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cfdNCCY5"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9981CF5FB;
	Wed,  2 Oct 2024 12:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727872890; cv=none; b=flDinvAtsfkWvViEY1yLShX2IL/Z4eoO3AgRO8Og8ZFkwcdgX70F0t0ucFh39Bxer64oCc3OQ5SsoihmxpQPGaN7a7SFzP8hN630SJitN131LyMGJr8mRxn24Fc9W7Mt28ftftDr3JSr4wwvY8hMFfbCmZvWWW6BZzfWUiZSv38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727872890; c=relaxed/simple;
	bh=VIzrkWZqS3BWBbgaONdAD3ExSq1hTIKL7R3IRUDAV+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LOy0Gu3e4kHJusvwyfWQuuMxlueguS94OI4Ka4fF7BywiLSh7W0x1FUaWpEuSK8wAc7b2AYDM+mHrIZK2zCOmYrV7lu9OitjVZOo5/y83cr3qUmVYAND2SF1fCGvPgBI/rk2iFAbKbU8E2FYoyWsJTu9+cAxouClDspnEpHBt4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=cfdNCCY5; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 05CB3240005;
	Wed,  2 Oct 2024 12:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727872885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qYZmngo8Akclg+S7qnBbh5hBasgfuQJ2bFb2p9LdGC4=;
	b=cfdNCCY5cEy03ATLTYtqzshKCSsOFcXvOwP4LW/qwI+tuYRZ8pvez7eyWrvgLhUwXnIpbq
	Dxh8CER0uZUfXx035l1XCzawmG7ANRyFDVLT9sI+TpimuiAvBXDJECXzejJYY/Vkaz269k
	OpM1YNVhttp+UIccvQYtyGojliCLxh4d42is77eKrVC9tGtz0TmK1V58tx3coovrq+/cwy
	wbk4nl01W709SJPq20fnwIwkpEje3TiPOR9r+0V79QgFEvR30KsoYL3nnP+DFCN7ZAMXZc
	UrjujYb5CtzDZ+wzyqae1XUu1peLwwrDxKc3AQwzgs1NIu/ULu0fSsHpOiq36A==
Date: Wed, 2 Oct 2024 14:41:19 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: "Arnd Bergmann" <arnd@arndb.de>
Cc: "Geert Uytterhoeven" <geert@linux-m68k.org>, "Andy Shevchenko"
 <andy.shevchenko@gmail.com>, "Simon Horman" <horms@kernel.org>, "Lee Jones"
 <lee@kernel.org>, "derek.kiernan@amd.com" <derek.kiernan@amd.com>,
 "dragan.cvetic@amd.com" <dragan.cvetic@amd.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Bjorn Helgaas" <bhelgaas@google.com>,
 "Philipp Zabel" <p.zabel@pengutronix.de>, "Lars Povlsen"
 <lars.povlsen@microchip.com>, "Steen Hegelund"
 <Steen.Hegelund@microchip.com>, "Daniel Machon"
 <daniel.machon@microchip.com>, UNGLinuxDriver@microchip.com, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, "Saravana Kannan" <saravanak@google.com>,
 "David S . Miller" <davem@davemloft.net>, "Eric Dumazet"
 <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni"
 <pabeni@redhat.com>, "Horatiu Vultur" <horatiu.vultur@microchip.com>,
 "Andrew Lunn" <andrew@lunn.ch>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Netdev <netdev@vger.kernel.org>,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Allan
 Nielsen" <allan.nielsen@microchip.com>, "Luca Ceresoli"
 <luca.ceresoli@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v6 3/7] misc: Add support for LAN966x PCI device
Message-ID: <20241002144119.45c78aa7@bootlin.com>
In-Reply-To: <b4602de6-bf45-4daf-8b52-f06cc6ff67ef@app.fastmail.com>
References: <20240930121601.172216-1-herve.codina@bootlin.com>
	<20240930121601.172216-4-herve.codina@bootlin.com>
	<b4602de6-bf45-4daf-8b52-f06cc6ff67ef@app.fastmail.com>
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

Hi Arnd,

On Wed, 02 Oct 2024 11:08:15 +0000
"Arnd Bergmann" <arnd@arndb.de> wrote:

> On Mon, Sep 30, 2024, at 12:15, Herve Codina wrote:
> 
> > +			pci-ep-bus@0 {
> > +				compatible = "simple-bus";
> > +				#address-cells = <1>;
> > +				#size-cells = <1>;
> > +
> > +				/*
> > +				 * map @0xe2000000 (32MB) to BAR0 (CPU)
> > +				 * map @0xe0000000 (16MB) to BAR1 (AMBA)
> > +				 */
> > +				ranges = <0xe2000000 0x00 0x00 0x00 0x2000000
> > +				          0xe0000000 0x01 0x00 0x00 0x1000000>;  
> 
> I was wondering about how this fits into the PCI DT
> binding, is this a child of the PCI device, or does the
> "pci-ep-bus" refer to the PCI device itself?

This is a child of the PCI device.
The overlay is applied at the PCI device node and so, the pci-ep-bus is
a child of the PCI device node.

> 
> Where do the "0x01 0x00 0x00" and "0x00 0x00 0x00" addresses
> come from? Shouldn't those be "02000010 0x00 0x00" and
> "02000014 0x00 0x00" to refer to the first and second
> relocatable 32-bit memory BAR?

These addresses are built dynamically by the PCI core during the PCI scan.
  https://elixir.bootlin.com/linux/v6.11/source/drivers/pci/of_property.c#L101
They are use to reference the BARs.
0x00 for BAR0, 0x01 for BAR1, ...

The full DT, once PCI device are present, scanned and the overlay applied,
looks like the following:
--- 8< ---
	pcie@d0070000 {
		/* Node present on the base device tree */
		compatible = "marvell,armada-3700-pcie";
		#address-cells = <0x03>;
		#size-cells = <0x02>;
		ranges = <0x82000000 0x00 0xe8000000 0x00 0xe8000000 0x00 0x7f00000
			  0x81000000 0x00 0x00 0x00 0xefff0000 0x00 0x10000>;
		device_type = "pci";
		...

		pci@0,0 {
			/*
			 * Node created at runtime during the PCI scan
			 * This node is PCI bridge (class 604)
			 */
			#address-cells = <0x03>;
			#size-cells = <0x02>;
			device_type = "pci";
			compatible = "pci11ab,100\0pciclass,060400\0pciclass,0604";
			ranges = <0x82000000 0x00 0xe8000000 0x82000000 0x00 0xe8000000 0x00 0x4400000>;
			...

			dev@0,0 {
				/*
				 * Node created at runtime during the
				 * PCI scan. This is my LAN966x PCI device.
				 */
				#address-cells = <0x03>;
				interrupts = <0x01>;
				#size-cells = <0x02>;
				compatible = "pci1055,9660\0pciclass,020000\0pciclass,0200";

				/*
				 * Ranges items allow to reference BAR0,
				 * BAR1, ... from children nodes.
				 * The property is created by the PCI core
				 * during the PCI bus scan.
				 */
				ranges = <0x00 0x00 0x00 0x82010000 0x00 0xe8000000 0x00 0x2000000
					  0x01 0x00 0x00 0x82010000 0x00 0xea000000 0x00 0x1000000
					  0x02 0x00 0x00 0x82010000 0x00 0xeb000000 0x00 0x800000
					  0x03 0x00 0x00 0x82010000 0x00 0xeb800000 0x00 0x800000
					  0x04 0x00 0x00 0x82010000 0x00 0xec000000 0x00 0x20000
					  0x05 0x00 0x00 0x82010000 0x00 0xec020000 0x00 0x2000>;
				...

				pci-ep-bus@0 {
					/* Node added by the overlay */
					#address-cells = <0x01>;
					#size-cells = <0x01>;
					compatible = "simple-bus";

					/*
					 * Remap 0xe2000000 to BAR0 and
					 * 0xe0000000 to BAR1
					 */
					ranges = <0xe2000000 0x00 0x00 0x00 0x2000000
						  0xe0000000 0x01 0x00 0x00 0x1000000>;
					...

					mdio@e200413c {
						#address-cells = <0x01>;
						resets = <0x25 0x00>;
						#size-cells = <0x00>;
						compatible = "microchip,lan966x-miim";
						reg = <0xe200413c 0x24 0xe2010020 0x04>;
						...
--- 8< ---

Hope this full picture helped to understand the address translations
involved.

Best regards,
Hervé

