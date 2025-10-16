Return-Path: <linux-pci+bounces-38332-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D92B1BE2F49
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 12:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD120188B441
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 10:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC3A299A81;
	Thu, 16 Oct 2025 10:53:53 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F72328613;
	Thu, 16 Oct 2025 10:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760612033; cv=none; b=heUKVMsXD0bFI8+aTzm+Hh89JjDbL0Nd0AIXFSkNE/euIpW11hNUm4773iPAZayKMeq9LY9ZZe+7Kq9L5MMq6ElyHj4DUSm3Oa0gAasvRY/Shyrd8vWALwvum7dnI5cpQxgOue8Np8uUXR+JW1k9HOGgM76zX8CMIh0XbpR76Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760612033; c=relaxed/simple;
	bh=tvLe7oqK/Vj/59PdAQQug6bKhT8NZJUWW0AetLUgCqs=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lGtwgs2QSkFEWse1Gb6LcLVk//8sauyFROQjbrPfUAh7MgAW7zSDkuJvhdfDaElW+CGv8spsTFZvlw/KoOsrFjHnWAJmTsZtjir1RlvUlhI+cdIcUir/wpzos81CNn1Nf/vSL7LV6rGIoAKHDQF8CKGlqambyDweU7pkECVMzkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cnPtG3GQNz6L4xg;
	Thu, 16 Oct 2025 18:52:38 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 0C2D81402A5;
	Thu, 16 Oct 2025 18:53:43 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 16 Oct
 2025 11:53:40 +0100
Date: Thu, 16 Oct 2025 11:53:39 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
CC: Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>, Thierry Reding
	<thierry.reding@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz
 Golaszewski <brgl@bgdev.pl>, Shawn Guo <shawnguo@kernel.org>, "Fabio Estevam"
	<festevam@gmail.com>, Nuno =?UTF-8?Q?S=C3=A1?= <nuno.sa@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>, "Michael Hennerich"
	<Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, Andy
 Shevchenko <andy@kernel.org>, Jassi Brar <jassisinghbrar@gmail.com>, Mauro
 Carvalho Chehab <mchehab@kernel.org>, "Lee Jones" <lee@kernel.org>, Joel
 Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	Andrew Lunn <andrew@lunn.ch>, "Vladimir Oltean" <olteanv@gmail.com>, "David
 S. Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, Daire McNamara
	<daire.mcnamara@microchip.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?UTF-8?Q?Wilczy?= =?UTF-8?Q?=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
	"Bjorn Andersson" <andersson@kernel.org>, Geert Uytterhoeven
	<geert+renesas@glider.be>, Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea
	<claudiu.beznea@tuxon.dev>, Florian Fainelli <f.fainelli@gmail.com>, "Tony
 Lindgren" <tony@atomide.com>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
	<linux-gpio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-iio@vger.kernel.org>, <linux-media@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-phy@lists.infradead.org>
Subject: Re: [PATCH] dt-bindings: Fix inconsistent quoting
Message-ID: <20251016115339.000047f7@huawei.com>
In-Reply-To: <20251015232015.846282-1-robh@kernel.org>
References: <20251015232015.846282-1-robh@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Wed, 15 Oct 2025 18:16:24 -0500
"Rob Herring (Arm)" <robh@kernel.org> wrote:

> yamllint has gained a new check which checks for inconsistent quoting
> (mixed " and ' quotes within a file). Fix all the cases yamllint found
> so we can enable the check (once the check is in a release). Use
> whichever quoting is dominate in the file.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../arm/altera/socfpga-clk-manager.yaml       |  4 ++--
>  .../bindings/clock/nvidia,tegra124-car.yaml   |  8 ++++----
>  .../bindings/clock/nvidia,tegra20-car.yaml    |  6 +++---
>  .../devicetree/bindings/gpio/gpio-mxs.yaml    |  9 +++++----
>  .../bindings/gpio/snps,dw-apb-gpio.yaml       |  4 ++--
>  .../bindings/iio/temperature/adi,ltc2983.yaml | 20 +++++++++----------
For this one
Acked-by: Jonathan Cameron <jonathan.cameron@huawei.com>


