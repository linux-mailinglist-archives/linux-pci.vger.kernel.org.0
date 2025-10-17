Return-Path: <linux-pci+bounces-38425-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 372B5BE6A89
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 08:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 06B5D4FFF61
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 06:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B950C30E83B;
	Fri, 17 Oct 2025 06:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="k15RyFdy"
X-Original-To: linux-pci@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B2981720;
	Fri, 17 Oct 2025 06:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760682388; cv=none; b=OSTKSAvKn3x15ye2+qauWIHcj446IJFODmhNmBMfHcKQmy1326QOoiKWwhXHafmsgqsedcG2FxpJ4bUVJQcATGW12vCp36vhDJFZuoTNYDmUnfn1zGmXOJpx9Ip10jz4aRgm0q4bOnioh+B/LhDxh7WwvWGQIc+mXy+p0XyCZ9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760682388; c=relaxed/simple;
	bh=Xim6qWFGZ+WXmsN/CH8emkwIniPHErnqJeZArc8D40Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tzNqBAOo1OwO1ETrn6K0I4hy0+4yj0gG9yXoM61zUBcFbCjV4pbDol+Xow9oNSxtKAESXro1pd3jboHmctXkyr04MqgAArDLnfuLw/x9CicaWTOtjWgRnIrkZmhB3b76QOrTrw7s11r6CcDKqAlYHi2tnoZwxvm/ZB3K/XUd4+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=k15RyFdy; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1760682385;
	bh=Xim6qWFGZ+WXmsN/CH8emkwIniPHErnqJeZArc8D40Q=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=k15RyFdyVoJeYb08mMxu9adUujB7QSVw0G8fEYvyrO1hC267ta5tTk7xCiorfMzFY
	 dcaqex8C4Z/PhhZbi/JLLMBLfbHE4sg+dE8wShuqba2NgcTLaL/LisqwJ4qBj84rYP
	 ILfzVe5i4ngO6+IFyR6aj+1FiHo2d1OVgetdauhjzGJZj60QekvzgKyD8T/0X6yqFA
	 ciQK0hoEQTN3K3XPo02a5DmhUlAhRcpoR2xO2CUGfUQszFmaWu8tV3NdoCFO8xah4l
	 XJsNP2GCSaOrHjLJwB8oNVjnU6+k5yO5U52I/inTnecgBf7vDqohqdobpbimsbuRh5
	 eaq60xEt/THHw==
Received: from [192.168.68.113] (unknown [180.150.112.213])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 539D56477A;
	Fri, 17 Oct 2025 14:26:20 +0800 (AWST)
Message-ID: <23813eab1406130dfdb6b63615fe1c1b4b634e29.camel@codeconstruct.com.au>
Subject: Re: [PATCH] dt-bindings: Fix inconsistent quoting
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: "Rob Herring (Arm)" <robh@kernel.org>, Krzysztof Kozlowski	
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Stephen Boyd	
 <sboyd@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Linus
 Walleij	 <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
 Shawn Guo	 <shawnguo@kernel.org>, Fabio Estevam <festevam@gmail.com>, Nuno
 =?ISO-8859-1?Q?S=E1?=	 <nuno.sa@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich	 <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Jassi Brar <jassisinghbrar@gmail.com>, Mauro Carvalho Chehab	
 <mchehab@kernel.org>, Lee Jones <lee@kernel.org>, Joel Stanley
 <joel@jms.id.au>,  Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean
 <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>,  Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>,  Daire McNamara <daire.mcnamara@microchip.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof
 =?UTF-8?Q?Wilczy=C5=84ski?=	 <kwilczynski@kernel.org>, Manivannan
 Sadhasivam <mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Vinod
 Koul <vkoul@kernel.org>, Kishon Vijay Abraham I	 <kishon@kernel.org>, Bjorn
 Andersson <andersson@kernel.org>, Geert Uytterhoeven	
 <geert+renesas@glider.be>, Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea
 <claudiu.beznea@tuxon.dev>, Florian Fainelli	 <f.fainelli@gmail.com>, Tony
 Lindgren <tony@atomide.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org, 
	linux-media@vger.kernel.org, netdev@vger.kernel.org,
 linux-pci@vger.kernel.org, 	linux-phy@lists.infradead.org
Date: Fri, 17 Oct 2025 16:56:19 +1030
In-Reply-To: <20251015232015.846282-1-robh@kernel.org>
References: <20251015232015.846282-1-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-10-15 at 18:16 -0500, Rob Herring (Arm) wrote:
> yamllint has gained a new check which checks for inconsistent quoting
> (mixed " and ' quotes within a file). Fix all the cases yamllint found
> so we can enable the check (once the check is in a release). Use
> whichever quoting is dominate in the file.
>=20
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
> =C2=A0.../arm/altera/socfpga-clk-manager.yaml=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 4 ++--
> =C2=A0.../bindings/clock/nvidia,tegra124-car.yaml=C2=A0=C2=A0 |=C2=A0 8 +=
+++----
> =C2=A0.../bindings/clock/nvidia,tegra20-car.yaml=C2=A0=C2=A0=C2=A0 |=C2=
=A0 6 +++---
> =C2=A0.../devicetree/bindings/gpio/gpio-mxs.yaml=C2=A0=C2=A0=C2=A0 |=C2=
=A0 9 +++++----
> =C2=A0.../bindings/gpio/snps,dw-apb-gpio.yaml=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 4 ++--
> =C2=A0.../bindings/iio/temperature/adi,ltc2983.yaml | 20 +++++++++-------=
---
> =C2=A0.../mailbox/qcom,apcs-kpss-global.yaml=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 16 +++++++--------
> =C2=A0.../mailbox/xlnx,zynqmp-ipi-mailbox.yaml=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 2 +-
> =C2=A0.../bindings/media/fsl,imx6q-vdoa.yaml=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> =C2=A0.../devicetree/bindings/mfd/aspeed-lpc.yaml=C2=A0=C2=A0 |=C2=A0 4 +=
+--

For aspeed-lpc.yaml:

Acked-by: Andrew Jeffery <andrew@codeconstruct.com.au>

