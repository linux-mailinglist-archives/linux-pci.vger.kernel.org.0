Return-Path: <linux-pci+bounces-38300-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 49580BE1CD7
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 08:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E728A4E24E8
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 06:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FDAA2E9EB2;
	Thu, 16 Oct 2025 06:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jH275lYM"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631071AF0BB;
	Thu, 16 Oct 2025 06:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760597395; cv=none; b=D87tBnAphjgKGjDWPwDo8Uq6ALUxe+PjoBNBfD7mx1wibX4BZ5wkZBvpE1kQS+lJa+w7p07h2wmG/s189hmRzedebjwXZ+ILFZ97tf91Ds5Ie6gfh02n1dM69i5Uy+lgXy9XzZLQVf1leZkcVktKi632HoHEys3mMwu9ki89PDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760597395; c=relaxed/simple;
	bh=bn1lrHEzCCwWVW4d8u3Qp0idkV5ZZim2U7XS2jQsmWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dZBzeFwog4NBZD63NuQNfyW5URVCxcPwv8kxs28Sw2rhPHNoPCZVcGm686VhBe+0T5i51UfGFmKID2+YTD+047uUuBamVsVPq1wLNLIdq/Z4eY6xKbdQzHaQJ3rTl7ycx3eW9KlKoFtLL+YqBlsdk5OWbOSPDWyR+7mL6jiMyWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jH275lYM; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 36D964E410EB;
	Thu, 16 Oct 2025 06:49:49 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E04396062C;
	Thu, 16 Oct 2025 06:49:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 034F6102F229A;
	Thu, 16 Oct 2025 08:49:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760597386; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=czokHCTfTPtDbPxXgyLjjpAbneuUswNmdcoNEF/a6oo=;
	b=jH275lYMg6M6lfZ2QSBDLrVt41RHnmpy52MdGOj22g9ENKx1tP9pTFlUVf0ll0SGU5QESH
	HH2AsglVyD9Tmp7h6lj9/t8q8PRjaveJLW2hH7hWIRVqKek4yzJOqdt0SQcP7ycxRiw6Xh
	AxKGxLAequ8fbnTKnpcpl+8CvfWgAT6xSEGSL8qLesP+J6Ianvimpk7GZVuPk7502u2ST5
	MkIrfCfZQiNWNKUauKkaR7SFpQauSN7d/FwaVwo/3M8e2zTz4+7iYaV+yDKUaEj9jboKWa
	mBP0144b/bi9XsL8Gu0kPJq9ZodqyLaPAoOS9p8/mlRZvXClg38dL2MH2+CYeQ==
Date: Thu, 16 Oct 2025 08:49:13 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <festevam@gmail.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Lee Jones <lee@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-iio@vger.kernel.org, linux-media@vger.kernel.org,
	netdev@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-phy@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: Fix inconsistent quoting
Message-ID: <2025101606491337a4fffe@mail.local>
References: <20251015232015.846282-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015232015.846282-1-robh@kernel.org>
X-Last-TLS-Session-Version: TLSv1.3

On 15/10/2025 18:16:24-0500, Rob Herring (Arm) wrote:
> yamllint has gained a new check which checks for inconsistent quoting
> (mixed " and ' quotes within a file). Fix all the cases yamllint found
> so we can enable the check (once the check is in a release). Use
> whichever quoting is dominate in the file.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>


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
> diff --git a/Documentation/devicetree/bindings/arm/altera/socfpga-clk-manager.yaml b/Documentation/devicetree/bindings/arm/altera/socfpga-clk-manager.yaml
> index a758f4bb2bb3..275554bfedce 100644
> --- a/Documentation/devicetree/bindings/arm/altera/socfpga-clk-manager.yaml
> +++ b/Documentation/devicetree/bindings/arm/altera/socfpga-clk-manager.yaml
> @@ -39,7 +39,7 @@ properties:
>  
>        "^[a-z0-9,_]+(clk|pll|clk_gate|clk_divided)(@[a-f0-9]+)?$":
>          type: object
> -        $ref: '#/$defs/clock-props'
> +        $ref: "#/$defs/clock-props"
>          unevaluatedProperties: false
>  
>          properties:
> @@ -67,7 +67,7 @@ properties:
>          patternProperties:
>            "^[a-z0-9,_]+(clk|pll)(@[a-f0-9]+)?$":
>              type: object
> -            $ref: '#/$defs/clock-props'
> +            $ref: "#/$defs/clock-props"
>              unevaluatedProperties: false
>  
>              properties:
> diff --git a/Documentation/devicetree/bindings/clock/nvidia,tegra124-car.yaml b/Documentation/devicetree/bindings/clock/nvidia,tegra124-car.yaml
> index a9ba21144a56..13bb616249a1 100644
> --- a/Documentation/devicetree/bindings/clock/nvidia,tegra124-car.yaml
> +++ b/Documentation/devicetree/bindings/clock/nvidia,tegra124-car.yaml
> @@ -37,7 +37,7 @@ properties:
>    '#clock-cells':
>      const: 1
>  
> -  "#reset-cells":
> +  '#reset-cells':
>      const: 1
>  
>    nvidia,external-memory-controller:
> @@ -46,7 +46,7 @@ properties:
>        phandle of the external memory controller node
>  
>  patternProperties:
> -  "^emc-timings-[0-9]+$":
> +  '^emc-timings-[0-9]+$':
>      type: object
>      properties:
>        nvidia,ram-code:
> @@ -56,7 +56,7 @@ patternProperties:
>            this timing set is used for
>  
>      patternProperties:
> -      "^timing-[0-9]+$":
> +      '^timing-[0-9]+$':
>          type: object
>          properties:
>            clock-frequency:
> @@ -94,7 +94,7 @@ required:
>    - compatible
>    - reg
>    - '#clock-cells'
> -  - "#reset-cells"
> +  - '#reset-cells'
>  
>  additionalProperties: false
>  
> diff --git a/Documentation/devicetree/bindings/clock/nvidia,tegra20-car.yaml b/Documentation/devicetree/bindings/clock/nvidia,tegra20-car.yaml
> index bee2dd4b29bf..73cccc0df424 100644
> --- a/Documentation/devicetree/bindings/clock/nvidia,tegra20-car.yaml
> +++ b/Documentation/devicetree/bindings/clock/nvidia,tegra20-car.yaml
> @@ -39,11 +39,11 @@ properties:
>    '#clock-cells':
>      const: 1
>  
> -  "#reset-cells":
> +  '#reset-cells':
>      const: 1
>  
>  patternProperties:
> -  "^(sclk)|(pll-[cem])$":
> +  '^(sclk)|(pll-[cem])$':
>      type: object
>      properties:
>        compatible:
> @@ -76,7 +76,7 @@ required:
>    - compatible
>    - reg
>    - '#clock-cells'
> -  - "#reset-cells"
> +  - '#reset-cells'
>  
>  additionalProperties: false
>  
> diff --git a/Documentation/devicetree/bindings/gpio/gpio-mxs.yaml b/Documentation/devicetree/bindings/gpio/gpio-mxs.yaml
> index aaf97124803f..4b5b8e794613 100644
> --- a/Documentation/devicetree/bindings/gpio/gpio-mxs.yaml
> +++ b/Documentation/devicetree/bindings/gpio/gpio-mxs.yaml
> @@ -26,9 +26,10 @@ properties:
>        # Devices. Keep it as it to be compatible existed dts files.
>        - const: simple-bus
>  
> -  '#address-cells':
> +  "#address-cells":
>      const: 1
> -  '#size-cells':
> +
> +  "#size-cells":
>      const: 0
>  
>    reg:
> @@ -132,8 +133,8 @@ patternProperties:
>  required:
>    - compatible
>    - reg
> -  - '#address-cells'
> -  - '#size-cells'
> +  - "#address-cells"
> +  - "#size-cells"
>  
>  additionalProperties: false
>  
> diff --git a/Documentation/devicetree/bindings/gpio/snps,dw-apb-gpio.yaml b/Documentation/devicetree/bindings/gpio/snps,dw-apb-gpio.yaml
> index ab2afc0e4153..bba6f5b6606f 100644
> --- a/Documentation/devicetree/bindings/gpio/snps,dw-apb-gpio.yaml
> +++ b/Documentation/devicetree/bindings/gpio/snps,dw-apb-gpio.yaml
> @@ -111,8 +111,8 @@ additionalProperties: false
>  required:
>    - compatible
>    - reg
> -  - "#address-cells"
> -  - "#size-cells"
> +  - '#address-cells'
> +  - '#size-cells'
>  
>  examples:
>    - |
> diff --git a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
> index 312febeeb3bb..ee0b558bb866 100644
> --- a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
> +++ b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
> @@ -88,7 +88,7 @@ properties:
>      const: 0
>  
>  patternProperties:
> -  "^thermocouple@":
> +  '^thermocouple@':
>      $ref: '#/$defs/sensor-node'
>      unevaluatedProperties: false
>  
> @@ -146,7 +146,7 @@ patternProperties:
>            required:
>              - adi,custom-thermocouple
>  
> -  "^diode@":
> +  '^diode@':
>      $ref: '#/$defs/sensor-node'
>      unevaluatedProperties: false
>  
> @@ -191,7 +191,7 @@ patternProperties:
>          $ref: /schemas/types.yaml#/definitions/uint32
>          default: 0
>  
> -  "^rtd@":
> +  '^rtd@':
>      $ref: '#/$defs/sensor-node'
>      unevaluatedProperties: false
>      description: RTD sensor.
> @@ -280,7 +280,7 @@ patternProperties:
>                type: boolean
>  
>            dependencies:
> -            adi,current-rotate: [ "adi,rsense-share" ]
> +            adi,current-rotate: [ 'adi,rsense-share' ]
>  
>        - if:
>            properties:
> @@ -290,7 +290,7 @@ patternProperties:
>            required:
>              - adi,custom-rtd
>  
> -  "^thermistor@":
> +  '^thermistor@':
>      $ref: '#/$defs/sensor-node'
>      unevaluatedProperties: false
>      description: Thermistor sensor.
> @@ -364,7 +364,7 @@ patternProperties:
>        - adi,rsense-handle
>  
>      dependencies:
> -      adi,current-rotate: [ "adi,rsense-share" ]
> +      adi,current-rotate: [ 'adi,rsense-share' ]
>  
>      allOf:
>        - if:
> @@ -392,7 +392,7 @@ patternProperties:
>            required:
>              - adi,custom-thermistor
>  
> -  "^adc@":
> +  '^adc@':
>      $ref: '#/$defs/sensor-node'
>      unevaluatedProperties: false
>      description: Direct ADC sensor.
> @@ -407,7 +407,7 @@ patternProperties:
>          description: Whether the sensor is single-ended.
>          type: boolean
>  
> -  "^temp@":
> +  '^temp@':
>      $ref: '#/$defs/sensor-node'
>      unevaluatedProperties: false
>      description: Active analog temperature sensor.
> @@ -437,7 +437,7 @@ patternProperties:
>      required:
>        - adi,custom-temp
>  
> -  "^rsense@":
> +  '^rsense@':
>      $ref: '#/$defs/sensor-node'
>      unevaluatedProperties: false
>      description: Sense resistor sensor.
> @@ -476,7 +476,7 @@ allOf:
>                - adi,ltc2984
>      then:
>        patternProperties:
> -        "^temp@": false
> +        '^temp@': false
>  
>  examples:
>    - |
> diff --git a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
> index 615ed103b7e6..f40dc9048327 100644
> --- a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
> +++ b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
> @@ -187,10 +187,10 @@ allOf:
>              enum:
>                - qcom,msm8916-apcs-kpss-global
>      then:
> -      $ref: "#/$defs/msm8916-apcs-clock-controller"
> +      $ref: '#/$defs/msm8916-apcs-clock-controller'
>        properties:
>          clock-controller:
> -          $ref: "#/$defs/msm8916-apcs-clock-controller"
> +          $ref: '#/$defs/msm8916-apcs-clock-controller'
>  
>    - if:
>        properties:
> @@ -199,10 +199,10 @@ allOf:
>              enum:
>                - qcom,msm8939-apcs-kpss-global
>      then:
> -      $ref: "#/$defs/msm8939-apcs-clock-controller"
> +      $ref: '#/$defs/msm8939-apcs-clock-controller'
>        properties:
>          clock-controller:
> -          $ref: "#/$defs/msm8939-apcs-clock-controller"
> +          $ref: '#/$defs/msm8939-apcs-clock-controller'
>  
>    - if:
>        properties:
> @@ -211,10 +211,10 @@ allOf:
>              enum:
>                - qcom,sdx55-apcs-gcc
>      then:
> -      $ref: "#/$defs/sdx55-apcs-clock-controller"
> +      $ref: '#/$defs/sdx55-apcs-clock-controller'
>        properties:
>          clock-controller:
> -          $ref: "#/$defs/sdx55-apcs-clock-controller"
> +          $ref: '#/$defs/sdx55-apcs-clock-controller'
>  
>    - if:
>        properties:
> @@ -223,10 +223,10 @@ allOf:
>              enum:
>                - qcom,ipq6018-apcs-apps-global
>      then:
> -      $ref: "#/$defs/ipq6018-apcs-clock-controller"
> +      $ref: '#/$defs/ipq6018-apcs-clock-controller'
>        properties:
>          clock-controller:
> -          $ref: "#/$defs/ipq6018-apcs-clock-controller"
> +          $ref: '#/$defs/ipq6018-apcs-clock-controller'
>  
>    - if:
>        properties:
> diff --git a/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.yaml b/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.yaml
> index fe83b5cb1278..04d6473d666f 100644
> --- a/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.yaml
> +++ b/Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.yaml
> @@ -142,7 +142,7 @@ patternProperties:
>        - compatible
>        - reg
>        - reg-names
> -      - "#mbox-cells"
> +      - '#mbox-cells'
>        - xlnx,ipi-id
>  
>  required:
> diff --git a/Documentation/devicetree/bindings/media/fsl,imx6q-vdoa.yaml b/Documentation/devicetree/bindings/media/fsl,imx6q-vdoa.yaml
> index 511ac0d67a7f..988a5b3a62bd 100644
> --- a/Documentation/devicetree/bindings/media/fsl,imx6q-vdoa.yaml
> +++ b/Documentation/devicetree/bindings/media/fsl,imx6q-vdoa.yaml
> @@ -16,7 +16,7 @@ maintainers:
>  
>  properties:
>    compatible:
> -    const: "fsl,imx6q-vdoa"
> +    const: fsl,imx6q-vdoa
>  
>    reg:
>      maxItems: 1
> diff --git a/Documentation/devicetree/bindings/mfd/aspeed-lpc.yaml b/Documentation/devicetree/bindings/mfd/aspeed-lpc.yaml
> index f329223cec07..0adfeef149e7 100644
> --- a/Documentation/devicetree/bindings/mfd/aspeed-lpc.yaml
> +++ b/Documentation/devicetree/bindings/mfd/aspeed-lpc.yaml
> @@ -111,12 +111,12 @@ patternProperties:
>        reg:
>          maxItems: 1
>  
> -      '#reset-cells':
> +      "#reset-cells":
>          const: 1
>  
>      required:
>        - compatible
> -      - '#reset-cells'
> +      - "#reset-cells"
>  
>    "^lpc-snoop@[0-9a-f]+$":
>      type: object
> diff --git a/Documentation/devicetree/bindings/mfd/ti,twl.yaml b/Documentation/devicetree/bindings/mfd/ti,twl.yaml
> index 776b04e182cb..1611b1581a8e 100644
> --- a/Documentation/devicetree/bindings/mfd/ti,twl.yaml
> +++ b/Documentation/devicetree/bindings/mfd/ti,twl.yaml
> @@ -400,7 +400,7 @@ properties:
>        - '#pwm-cells'
>  
>  patternProperties:
> -  "^regulator-":
> +  '^regulator-':
>      type: object
>      unevaluatedProperties: false
>      $ref: /schemas/regulator/regulator.yaml
> @@ -429,7 +429,7 @@ required:
>    - reg
>    - interrupts
>    - interrupt-controller
> -  - "#interrupt-cells"
> +  - '#interrupt-cells'
>  
>  examples:
>    - |
> diff --git a/Documentation/devicetree/bindings/net/ethernet-switch.yaml b/Documentation/devicetree/bindings/net/ethernet-switch.yaml
> index b3b7e1a1b127..03001ba40e0f 100644
> --- a/Documentation/devicetree/bindings/net/ethernet-switch.yaml
> +++ b/Documentation/devicetree/bindings/net/ethernet-switch.yaml
> @@ -72,7 +72,7 @@ additionalProperties: true
>  $defs:
>    ethernet-ports:
>      description: An ethernet switch without any extra port properties
> -    $ref: '#'
> +    $ref: "#"
>  
>      patternProperties:
>        "^(ethernet-)?ports$":
> diff --git a/Documentation/devicetree/bindings/pci/plda,xpressrich3-axi-common.yaml b/Documentation/devicetree/bindings/pci/plda,xpressrich3-axi-common.yaml
> index 039eecdbd6aa..fe2e8beb5bab 100644
> --- a/Documentation/devicetree/bindings/pci/plda,xpressrich3-axi-common.yaml
> +++ b/Documentation/devicetree/bindings/pci/plda,xpressrich3-axi-common.yaml
> @@ -72,7 +72,7 @@ required:
>    - reg-names
>    - interrupts
>    - msi-controller
> -  - "#interrupt-cells"
> +  - '#interrupt-cells'
>    - interrupt-map-mask
>    - interrupt-map
>  
> diff --git a/Documentation/devicetree/bindings/phy/motorola,cpcap-usb-phy.yaml b/Documentation/devicetree/bindings/phy/motorola,cpcap-usb-phy.yaml
> index 0febd04a61f4..dd345cbd0a0b 100644
> --- a/Documentation/devicetree/bindings/phy/motorola,cpcap-usb-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/motorola,cpcap-usb-phy.yaml
> @@ -67,8 +67,8 @@ properties:
>    mode-gpios:
>      description: Optional GPIOs for configuring alternate modes
>      items:
> -      - description: "mode selection GPIO #0"
> -      - description: "mode selection GPIO #1"
> +      - description: mode selection GPIO#0
> +      - description: mode selection GPIO#1
>  
>  required:
>    - compatible
> diff --git a/Documentation/devicetree/bindings/pinctrl/microchip,sparx5-sgpio.yaml b/Documentation/devicetree/bindings/pinctrl/microchip,sparx5-sgpio.yaml
> index 0df4e114fdd6..fa47732d7cef 100644
> --- a/Documentation/devicetree/bindings/pinctrl/microchip,sparx5-sgpio.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/microchip,sparx5-sgpio.yaml
> @@ -18,7 +18,7 @@ description: |
>  
>  properties:
>    $nodename:
> -    pattern: "^gpio@[0-9a-f]+$"
> +    pattern: '^gpio@[0-9a-f]+$'
>  
>    compatible:
>      enum:
> @@ -26,10 +26,10 @@ properties:
>        - mscc,ocelot-sgpio
>        - mscc,luton-sgpio
>  
> -  "#address-cells":
> +  '#address-cells':
>      const: 1
>  
> -  "#size-cells":
> +  '#size-cells':
>      const: 0
>  
>    reg:
> @@ -76,7 +76,7 @@ properties:
>        - const: switch
>  
>  patternProperties:
> -  "^gpio@[0-1]$":
> +  '^gpio@[0-1]$':
>      type: object
>      properties:
>        compatible:
> @@ -132,8 +132,8 @@ required:
>    - reg
>    - clocks
>    - microchip,sgpio-port-ranges
> -  - "#address-cells"
> -  - "#size-cells"
> +  - '#address-cells'
> +  - '#size-cells'
>  
>  examples:
>    - |
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
> index 5e6dfcc3fe9b..6632bcd037ba 100644
> --- a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml
> @@ -424,13 +424,13 @@ allOf:
>  patternProperties:
>    '-state$':
>      oneOf:
> -      - $ref: "#/$defs/qcom-pmic-gpio-state"
> +      - $ref: '#/$defs/qcom-pmic-gpio-state'
>        - patternProperties:
> -          "(pinconf|-pins)$":
> -            $ref: "#/$defs/qcom-pmic-gpio-state"
> +          '(pinconf|-pins)$':
> +            $ref: '#/$defs/qcom-pmic-gpio-state'
>          additionalProperties: false
>  
> -  "-hog(-[0-9]+)?$":
> +  '-hog(-[0-9]+)?$':
>      type: object
>      required:
>        - gpio-hog
> @@ -503,7 +503,7 @@ $defs:
>                   - gpio1-gpio12 for pmxr2230
>  
>          items:
> -          pattern: "^gpio([0-9]+)$"
> +          pattern: '^gpio([0-9]+)$'
>  
>        function:
>          items:
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.yaml
> index 9364ae05f3e6..daf4c1c03712 100644
> --- a/Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.yaml
> @@ -74,10 +74,10 @@ required:
>  patternProperties:
>    '-state$':
>      oneOf:
> -      - $ref: "#/$defs/qcom-pmic-mpp-state"
> +      - $ref: '#/$defs/qcom-pmic-mpp-state'
>        - patternProperties:
>            '-pins$':
> -            $ref: "#/$defs/qcom-pmic-mpp-state"
> +            $ref: '#/$defs/qcom-pmic-mpp-state'
>          additionalProperties: false
>  
>  $defs:
> @@ -100,7 +100,7 @@ $defs:
>                   - mpp1-mpp4 for pma8084
>  
>          items:
> -          pattern: "^mpp([0-9]+)$"
> +          pattern: '^mpp([0-9]+)$'
>  
>        function:
>          items:
> diff --git a/Documentation/devicetree/bindings/pinctrl/renesas,pfc.yaml b/Documentation/devicetree/bindings/pinctrl/renesas,pfc.yaml
> index cfe004573366..ab1cfe9dcde5 100644
> --- a/Documentation/devicetree/bindings/pinctrl/renesas,pfc.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/renesas,pfc.yaml
> @@ -129,7 +129,7 @@ additionalProperties:
>  
>      - type: object
>        additionalProperties:
> -        $ref: "#/additionalProperties/anyOf/0"
> +        $ref: '#/additionalProperties/anyOf/0'
>  
>  examples:
>    - |
> @@ -190,7 +190,7 @@ examples:
>  
>              sdhi0_pins: sd0 {
>                      groups = "sdhi0_data4", "sdhi0_ctrl";
> -                    function = "sdhi0";
> +                    function = "sdhi0';
>                      power-source = <3300>;
>              };
>      };
> diff --git a/Documentation/devicetree/bindings/pinctrl/renesas,rza1-ports.yaml b/Documentation/devicetree/bindings/pinctrl/renesas,rza1-ports.yaml
> index 2bd7d47d0fdb..737eb4e14090 100644
> --- a/Documentation/devicetree/bindings/pinctrl/renesas,rza1-ports.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/renesas,rza1-ports.yaml
> @@ -118,7 +118,7 @@ additionalProperties:
>  
>      - type: object
>        additionalProperties:
> -        $ref: "#/additionalProperties/anyOf/0"
> +        $ref: '#/additionalProperties/anyOf/0'
>  
>  examples:
>    - |
> diff --git a/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
> index 5156d54b240b..00c05243b9a4 100644
> --- a/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
> @@ -135,7 +135,7 @@ additionalProperties:
>  
>      - type: object
>        additionalProperties:
> -        $ref: "#/additionalProperties/anyOf/0"
> +        $ref: '#/additionalProperties/anyOf/0'
>  
>  allOf:
>    - $ref: pinctrl.yaml#
> diff --git a/Documentation/devicetree/bindings/pinctrl/renesas,rzv2m-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/renesas,rzv2m-pinctrl.yaml
> index 5fa5d31f8866..88b2fa5e684d 100644
> --- a/Documentation/devicetree/bindings/pinctrl/renesas,rzv2m-pinctrl.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/renesas,rzv2m-pinctrl.yaml
> @@ -88,7 +88,7 @@ additionalProperties:
>  
>      - type: object
>        additionalProperties:
> -        $ref: "#/additionalProperties/anyOf/0"
> +        $ref: '#/additionalProperties/anyOf/0'
>  
>  allOf:
>    - $ref: pinctrl.yaml#
> diff --git a/Documentation/devicetree/bindings/power/renesas,sysc-rmobile.yaml b/Documentation/devicetree/bindings/power/renesas,sysc-rmobile.yaml
> index fba6914ec40d..948a9da111df 100644
> --- a/Documentation/devicetree/bindings/power/renesas,sysc-rmobile.yaml
> +++ b/Documentation/devicetree/bindings/power/renesas,sysc-rmobile.yaml
> @@ -45,7 +45,7 @@ properties:
>          const: 0
>  
>      additionalProperties:
> -      $ref: "#/$defs/pd-node"
> +      $ref: '#/$defs/pd-node'
>  
>  required:
>    - compatible
> @@ -83,7 +83,7 @@ $defs:
>        - '#power-domain-cells'
>  
>      additionalProperties:
> -      $ref: "#/$defs/pd-node"
> +      $ref: '#/$defs/pd-node'
>  
>  examples:
>    - |
> diff --git a/Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml b/Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml
> index 2c7275c4503b..abf1adca0773 100644
> --- a/Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml
> +++ b/Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml
> @@ -57,7 +57,7 @@ properties:
>      const: 0
>  
>  patternProperties:
> -  "^timer@[0-2]$":
> +  '^timer@[0-2]$':
>      description: The timer block channels that are used as timers or counters.
>      type: object
>      additionalProperties: false
> @@ -80,7 +80,7 @@ patternProperties:
>        - compatible
>        - reg
>  
> -  "^pwm@[0-2]$":
> +  '^pwm@[0-2]$':
>      description: The timer block channels that are used as PWMs.
>      $ref: /schemas/pwm/pwm.yaml#
>      type: object
> @@ -92,7 +92,7 @@ patternProperties:
>            TCB channel to use for this PWM.
>          enum: [ 0, 1, 2 ]
>  
> -      "#pwm-cells":
> +      '#pwm-cells':
>          description:
>            The only third cell flag supported by this binding is
>            PWM_POLARITY_INVERTED.
> @@ -101,7 +101,7 @@ patternProperties:
>      required:
>        - compatible
>        - reg
> -      - "#pwm-cells"
> +      - '#pwm-cells'
>  
>      additionalProperties: false
>  
> diff --git a/Documentation/devicetree/bindings/soc/tegra/nvidia,tegra20-pmc.yaml b/Documentation/devicetree/bindings/soc/tegra/nvidia,tegra20-pmc.yaml
> index 7140c312d898..f516960dbbef 100644
> --- a/Documentation/devicetree/bindings/soc/tegra/nvidia,tegra20-pmc.yaml
> +++ b/Documentation/devicetree/bindings/soc/tegra/nvidia,tegra20-pmc.yaml
> @@ -133,12 +133,12 @@ properties:
>            property. The supported-hw is a bitfield indicating SoC speedo or
>            process ID mask.
>  
> -      "#power-domain-cells":
> +      '#power-domain-cells':
>          const: 0
>  
>      required:
>        - operating-points-v2
> -      - "#power-domain-cells"
> +      - '#power-domain-cells'
>  
>    i2c-thermtrip:
>      type: object
> @@ -220,7 +220,7 @@ properties:
>          xusbc    USB Partition C               Tegra114/124/210
>  
>      patternProperties:
> -      "^[a-z0-9]+$":
> +      '^[a-z0-9]+$':
>          type: object
>          additionalProperties: false
>          properties:
> @@ -365,9 +365,9 @@ allOf:
>  additionalProperties: false
>  
>  dependencies:
> -  nvidia,suspend-mode: ["nvidia,core-pwr-off-time", "nvidia,cpu-pwr-off-time"]
> -  nvidia,core-pwr-off-time: ["nvidia,core-pwr-good-time"]
> -  nvidia,cpu-pwr-off-time: ["nvidia,cpu-pwr-good-time"]
> +  nvidia,suspend-mode: ['nvidia,core-pwr-off-time', 'nvidia,cpu-pwr-off-time']
> +  nvidia,core-pwr-off-time: ['nvidia,core-pwr-good-time']
> +  nvidia,cpu-pwr-off-time: ['nvidia,cpu-pwr-good-time']
>  
>  examples:
>    - |
> -- 
> 2.51.0
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

