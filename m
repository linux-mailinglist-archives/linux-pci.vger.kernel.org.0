Return-Path: <linux-pci+bounces-38291-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 215E4BE118C
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 02:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 572474EA4EE
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 00:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1D613B58B;
	Thu, 16 Oct 2025 00:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dj94XWJV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A73F1114;
	Thu, 16 Oct 2025 00:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760574400; cv=none; b=HA9Da0UFZIzhK00IisNprU+BAMOJs+mtH58YOHBlU3wG6w8pj7qPVfBjxhv3ucPUGgGWhuCma/MlZvwguXs3qD9hZtOzOXjdzxxOyCmkMxmA6YmT6bbW9aie1ndMFYYb33seXJirmuR3AYlM9AyWaUyuUAnHCQBJrRKR/6O7pMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760574400; c=relaxed/simple;
	bh=U28sDA1Foqogqj0EpzymayQ1wgUPbptp/B4nVYhh2VQ=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=aDchgbxM+vX/lDpblCXYah+pDzopWQHmXEeCFprmuifDL31i6PVC4668GOdaHfA2p6QqihqxCfn2xS0yR3NTI7kryxmCPfVSCKXPhBcS7MTyvMcQJZXaJ7CM0ypIP0AWriUkoOBuBF+vOY3FMh5CQarqR22juTtbEqPW5pPOUUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dj94XWJV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90F7CC4CEF8;
	Thu, 16 Oct 2025 00:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760574399;
	bh=U28sDA1Foqogqj0EpzymayQ1wgUPbptp/B4nVYhh2VQ=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=Dj94XWJV8URBCP7eHQRkGso8jdIVf4yq32iKR936m+qK40hXECoK27b6FucGkMto0
	 xKqWpYkuWx4UHz/896XaCHoBe6Q1JiK0Kxc00rN7K8h+LuhdBPw9dxd2mNpLuJ/PYx
	 tzubS/ZUMVIURtzvMmnHMgnXnGMfdlqmgRAfFKecvQdGrHV4o08O4AeT2FvZxs8MR3
	 S2oBcLETPjUKZ1Z7T+ECLUUDZZ7/de+DlhSPpNl+CJxTWzsD31NPwc+R9Fx7aH5B6+
	 JSbYHle1X/IxBGUx/oiSimthNjSWELBTTa2mpPBZ3gOWs/hRRYtOhh7vtqt1X+IZ/X
	 O62U8DSbcPnEw==
Date: Wed, 15 Oct 2025 19:26:36 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, devicetree@vger.kernel.org, 
 Jakub Kicinski <kuba@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
 Joel Stanley <joel@jms.id.au>, Bjorn Helgaas <bhelgaas@google.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Lee Jones <lee@kernel.org>, 
 Daire McNamara <daire.mcnamara@microchip.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Eric Dumazet <edumazet@google.com>, linux-iio@vger.kernel.org, 
 Manivannan Sadhasivam <mani@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Jonathan Cameron <jic23@kernel.org>, linux-phy@lists.infradead.org, 
 Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org, 
 Paolo Abeni <pabeni@redhat.com>, Kishon Vijay Abraham I <kishon@kernel.org>, 
 Stephen Boyd <sboyd@kernel.org>, Jassi Brar <jassisinghbrar@gmail.com>, 
 linux-gpio@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>, 
 linux-media@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 linux-clk@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
 linux-pci@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, linux-kernel@vger.kernel.org, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Fabio Estevam <festevam@gmail.com>, linux-arm-kernel@lists.infradead.org, 
 Linus Walleij <linus.walleij@linaro.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Tony Lindgren <tony@atomide.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
In-Reply-To: <20251015232015.846282-1-robh@kernel.org>
References: <20251015232015.846282-1-robh@kernel.org>
Message-Id: <176057439666.933167.2958808777480882513.robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: Fix inconsistent quoting


On Wed, 15 Oct 2025 18:16:24 -0500, Rob Herring (Arm) wrote:
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
>  .../mailbox/qcom,apcs-kpss-global.yaml        | 16 +++++++--------
>  .../mailbox/xlnx,zynqmp-ipi-mailbox.yaml      |  2 +-
>  .../bindings/media/fsl,imx6q-vdoa.yaml        |  2 +-
>  .../devicetree/bindings/mfd/aspeed-lpc.yaml   |  4 ++--
>  .../devicetree/bindings/mfd/ti,twl.yaml       |  4 ++--
>  .../bindings/net/ethernet-switch.yaml         |  2 +-
>  .../pci/plda,xpressrich3-axi-common.yaml      |  2 +-
>  .../bindings/phy/motorola,cpcap-usb-phy.yaml  |  4 ++--
>  .../pinctrl/microchip,sparx5-sgpio.yaml       | 12 +++++------
>  .../bindings/pinctrl/qcom,pmic-gpio.yaml      | 10 +++++-----
>  .../bindings/pinctrl/qcom,pmic-mpp.yaml       |  6 +++---
>  .../bindings/pinctrl/renesas,pfc.yaml         |  4 ++--
>  .../bindings/pinctrl/renesas,rza1-ports.yaml  |  2 +-
>  .../pinctrl/renesas,rzg2l-pinctrl.yaml        |  2 +-
>  .../pinctrl/renesas,rzv2m-pinctrl.yaml        |  2 +-
>  .../bindings/power/renesas,sysc-rmobile.yaml  |  4 ++--
>  .../soc/microchip/atmel,at91rm9200-tcb.yaml   |  8 ++++----
>  .../soc/tegra/nvidia,tegra20-pmc.yaml         | 12 +++++------
>  24 files changed, 75 insertions(+), 74 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/pinctrl/renesas,pfc.example.dts:90.36-37 syntax error
FATAL ERROR: Unable to parse input tree
make[2]: *** [scripts/Makefile.dtbs:132: Documentation/devicetree/bindings/pinctrl/renesas,pfc.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1525: dt_binding_check] Error 2
make: *** [Makefile:248: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20251015232015.846282-1-robh@kernel.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


