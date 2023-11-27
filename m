Return-Path: <linux-pci+bounces-188-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E3097FA822
	for <lists+linux-pci@lfdr.de>; Mon, 27 Nov 2023 18:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C17771C209E9
	for <lists+linux-pci@lfdr.de>; Mon, 27 Nov 2023 17:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5DC3A8E0;
	Mon, 27 Nov 2023 17:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CRwsOlxE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8183C10D4
	for <linux-pci@vger.kernel.org>; Mon, 27 Nov 2023 09:35:13 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1cfc9c4acb6so10164935ad.0
        for <linux-pci@vger.kernel.org>; Mon, 27 Nov 2023 09:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701106513; x=1701711313; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CTJlPmL67mqQHQt9cjcLyt689DNtIDqgGshXcQsxtcg=;
        b=CRwsOlxEX7dFMB0hs+F6M6dsAgmsVsBjaddWCzWS4CABAI64QU/L6lLjLW6RVEqq6o
         uqedBdafJl93ykqpw3vpK2kXwEpvHj84LQlN974E/Z3/c7YVJQX6H9Z24xotMZ3H49I8
         rcfmUEg55qfbvZGi9v1po+FGaY5Rquu0BEWf9AEMDHZ21HYH51IMTsoOcQNCxKCvpHJm
         BOtW/UWrz1igveMsSPt7JsZ16pTB0csS7mxER2V85Eu7ezI38JJPRNFICiVhGLiJJR8v
         yaueLeiLsBTQc7bls+pSi4aR/m8TpFOLgfid9Phl5k6ocyC3T0DC4F8LoX2E1IidSO9O
         Wn+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701106513; x=1701711313;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CTJlPmL67mqQHQt9cjcLyt689DNtIDqgGshXcQsxtcg=;
        b=nXABPHr/HyZJMumuQGr0ZHC2Rf51FQHFrg51MJ2VNdrTZpxEnOx3wKAhabljw3lG3T
         m33z2WG0Y1WHikutmvysDTVYzjqjVtZWzrgJuDcoVB0zYFKFyc9YlU1cyI/t6VSHRpfY
         RSLmKrnUsSagvHE3VJuqhgGEZM9TI/qDDJPAW2jC7v3OaoX2esAStjXirnPCWnm3DxaA
         OGnVG1ibe/w9TuZC0ycBHcAbcwVPG+HBR3XCSn0a3gBeiICioB72Accct+pjxJ0/k0CJ
         ezLm0JzAqtAqu5B9weR1meMAJCNya2SRu6u7FlknU9dF/0zf9/Shrs46CzWoOxSPMQZm
         W3sA==
X-Gm-Message-State: AOJu0YwKBbqP2sQJh0RKBJxud91D7U/363SbJ0i/kLQ41VLyrL3A01AC
	oDduuRlbpm9ThxMaf4p4wmfycg==
X-Google-Smtp-Source: AGHT+IE+WnLBAAioYY6kU40XE2Y7lnA0y06FmkeQ4YIFqavRam5H78HmIiskYAR7duIiVYCBdD1Bmg==
X-Received: by 2002:a17:902:e882:b0:1cf:d634:361 with SMTP id w2-20020a170902e88200b001cfd6340361mr3320340plg.43.1701106512867;
        Mon, 27 Nov 2023 09:35:12 -0800 (PST)
Received: from p14s ([2604:3d09:148c:c800:eb81:232:a693:3576])
        by smtp.gmail.com with ESMTPSA id j6-20020a17090276c600b001c9b384731esm8487827plt.270.2023.11.27.09.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 09:35:12 -0800 (PST)
Date: Mon, 27 Nov 2023 10:35:09 -0700
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-mmc@vger.kernel.org, netdev@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: correct white-spaces in examples
Message-ID: <ZWTTTSScBPWBKMrw@p14s>
References: <20231124092121.16866-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124092121.16866-1-krzysztof.kozlowski@linaro.org>

On Fri, Nov 24, 2023 at 10:21:21AM +0100, Krzysztof Kozlowski wrote:
> Use only one and exactly one space around '=' in DTS example.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Merging idea: Rob's DT.
> Should apply cleanly on Rob's for-next.
> ---
>  .../devicetree/bindings/auxdisplay/hit,hd44780.yaml       | 2 +-
>  .../devicetree/bindings/clock/baikal,bt1-ccu-pll.yaml     | 2 +-
>  Documentation/devicetree/bindings/iio/adc/adi,ad7780.yaml | 6 +++---
>  .../devicetree/bindings/iio/adc/qcom,spmi-iadc.yaml       | 2 +-
>  .../devicetree/bindings/iio/adc/qcom,spmi-rradc.yaml      | 2 +-
>  .../interrupt-controller/st,stih407-irq-syscfg.yaml       | 4 ++--
>  Documentation/devicetree/bindings/mmc/arm,pl18x.yaml      | 2 +-
>  Documentation/devicetree/bindings/net/sff,sfp.yaml        | 2 +-
>  .../devicetree/bindings/pci/toshiba,visconti-pcie.yaml    | 2 +-
>  .../bindings/pinctrl/renesas,rzg2l-pinctrl.yaml           | 6 +++---
>  .../devicetree/bindings/power/supply/richtek,rt9455.yaml  | 8 ++++----
>  .../devicetree/bindings/regulator/mps,mp5416.yaml         | 4 ++--
>  .../devicetree/bindings/regulator/mps,mpq7920.yaml        | 4 ++--
>  .../devicetree/bindings/remoteproc/fsl,imx-rproc.yaml     | 8 ++++----

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

>  14 files changed, 27 insertions(+), 27 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/auxdisplay/hit,hd44780.yaml b/Documentation/devicetree/bindings/auxdisplay/hit,hd44780.yaml
> index fde07e4b119d..406a922a714e 100644
> --- a/Documentation/devicetree/bindings/auxdisplay/hit,hd44780.yaml
> +++ b/Documentation/devicetree/bindings/auxdisplay/hit,hd44780.yaml
> @@ -113,7 +113,7 @@ examples:
>      hd44780 {
>              compatible = "hit,hd44780";
>              display-height-chars = <2>;
> -            display-width-chars  = <16>;
> +            display-width-chars = <16>;
>              data-gpios = <&pcf8574 4 0>,
>                           <&pcf8574 5 0>,
>                           <&pcf8574 6 0>,
> diff --git a/Documentation/devicetree/bindings/clock/baikal,bt1-ccu-pll.yaml b/Documentation/devicetree/bindings/clock/baikal,bt1-ccu-pll.yaml
> index 624984d51c10..7f8d98226437 100644
> --- a/Documentation/devicetree/bindings/clock/baikal,bt1-ccu-pll.yaml
> +++ b/Documentation/devicetree/bindings/clock/baikal,bt1-ccu-pll.yaml
> @@ -125,7 +125,7 @@ examples:
>      clk25m: clock-oscillator-25m {
>        compatible = "fixed-clock";
>        #clock-cells = <0>;
> -      clock-frequency  = <25000000>;
> +      clock-frequency = <25000000>;
>        clock-output-names = "clk25m";
>      };
>  ...
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7780.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7780.yaml
> index 5fcc8dd012f1..be2616ff9af6 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7780.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7780.yaml
> @@ -80,9 +80,9 @@ examples:
>              compatible = "adi,ad7780";
>              reg = <0>;
>  
> -            avdd-supply      = <&vdd_supply>;
> -            powerdown-gpios  = <&gpio0 12 GPIO_ACTIVE_HIGH>;
> -            adi,gain-gpios   = <&gpio1  5 GPIO_ACTIVE_LOW>;
> +            avdd-supply = <&vdd_supply>;
> +            powerdown-gpios = <&gpio0 12 GPIO_ACTIVE_HIGH>;
> +            adi,gain-gpios = <&gpio1  5 GPIO_ACTIVE_LOW>;
>              adi,filter-gpios = <&gpio2 15 GPIO_ACTIVE_LOW>;
>          };
>      };
> diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-iadc.yaml b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-iadc.yaml
> index 73def67fbe01..b6a233cd5f6b 100644
> --- a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-iadc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-iadc.yaml
> @@ -58,7 +58,7 @@ examples:
>              reg = <0x3600>;
>              interrupts = <0x0 0x36 0x0 IRQ_TYPE_EDGE_RISING>;
>              qcom,external-resistor-micro-ohms = <10000>;
> -            #io-channel-cells  = <1>;
> +            #io-channel-cells = <1>;
>          };
>      };
>  ...
> diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-rradc.yaml b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-rradc.yaml
> index b3a626389870..64abe9a4cd9e 100644
> --- a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-rradc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-rradc.yaml
> @@ -46,6 +46,6 @@ examples:
>          pmic_rradc: adc@4500 {
>              compatible = "qcom,pmi8998-rradc";
>              reg = <0x4500>;
> -            #io-channel-cells  = <1>;
> +            #io-channel-cells = <1>;
>          };
>      };
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/st,stih407-irq-syscfg.yaml b/Documentation/devicetree/bindings/interrupt-controller/st,stih407-irq-syscfg.yaml
> index 2b153d7c5421..e44e4e5708a7 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/st,stih407-irq-syscfg.yaml
> +++ b/Documentation/devicetree/bindings/interrupt-controller/st,stih407-irq-syscfg.yaml
> @@ -55,8 +55,8 @@ examples:
>    - |
>      #include <dt-bindings/interrupt-controller/irq-st.h>
>      irq-syscfg {
> -        compatible    = "st,stih407-irq-syscfg";
> -        st,syscfg     = <&syscfg_cpu>;
> +        compatible = "st,stih407-irq-syscfg";
> +        st,syscfg = <&syscfg_cpu>;
>          st,irq-device = <ST_IRQ_SYSCFG_PMU_0>,
>                          <ST_IRQ_SYSCFG_PMU_1>;
>          st,fiq-device = <ST_IRQ_SYSCFG_DISABLED>,
> diff --git a/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml b/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml
> index 2459a55ed540..940b12688167 100644
> --- a/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml
> +++ b/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml
> @@ -203,7 +203,7 @@ examples:
>        bus-width = <4>;
>        cap-sd-highspeed;
>        cap-mmc-highspeed;
> -      cd-gpios  = <&gpio2 31 0x4>;
> +      cd-gpios = <&gpio2 31 0x4>;
>        st,sig-dir-dat0;
>        st,sig-dir-dat2;
>        st,sig-dir-cmd;
> diff --git a/Documentation/devicetree/bindings/net/sff,sfp.yaml b/Documentation/devicetree/bindings/net/sff,sfp.yaml
> index 973e478a399d..bf6cbc7c2ba3 100644
> --- a/Documentation/devicetree/bindings/net/sff,sfp.yaml
> +++ b/Documentation/devicetree/bindings/net/sff,sfp.yaml
> @@ -120,7 +120,7 @@ examples:
>        pinctrl-names = "default";
>        pinctrl-0 = <&cps_sfpp0_pins>;
>        tx-disable-gpios = <&cps_gpio1 29 GPIO_ACTIVE_HIGH>;
> -      tx-fault-gpios  = <&cps_gpio1 26 GPIO_ACTIVE_HIGH>;
> +      tx-fault-gpios = <&cps_gpio1 26 GPIO_ACTIVE_HIGH>;
>      };
>  
>      mdio {
> diff --git a/Documentation/devicetree/bindings/pci/toshiba,visconti-pcie.yaml b/Documentation/devicetree/bindings/pci/toshiba,visconti-pcie.yaml
> index 53da2edd7c9a..120e3bb1e545 100644
> --- a/Documentation/devicetree/bindings/pci/toshiba,visconti-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/toshiba,visconti-pcie.yaml
> @@ -83,7 +83,7 @@ examples:
>                    <0x0 0x28050000 0x0 0x00010000>,
>                    <0x0 0x24200000 0x0 0x00002000>,
>                    <0x0 0x24162000 0x0 0x00001000>;
> -            reg-names  = "dbi", "config", "ulreg", "smu", "mpu";
> +            reg-names = "dbi", "config", "ulreg", "smu", "mpu";
>              device_type = "pci";
>              bus-range = <0x00 0xff>;
>              num-lanes = <2>;
> diff --git a/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
> index b5ca40d0e251..d476de82e5c3 100644
> --- a/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
> @@ -185,17 +185,17 @@ examples:
>                      sd1_mux {
>                              pinmux = <RZG2L_PORT_PINMUX(19, 0, 1)>, /* CD */
>                                       <RZG2L_PORT_PINMUX(19, 1, 1)>; /* WP */
> -                            power-source  = <3300>;
> +                            power-source = <3300>;
>                      };
>  
>                      sd1_data {
>                              pins = "SD1_DATA0", "SD1_DATA1", "SD1_DATA2", "SD1_DATA3";
> -                            power-source  = <3300>;
> +                            power-source = <3300>;
>                      };
>  
>                      sd1_ctrl {
>                              pins = "SD1_CLK", "SD1_CMD";
> -                            power-source  = <3300>;
> +                            power-source = <3300>;
>                      };
>              };
>      };
> diff --git a/Documentation/devicetree/bindings/power/supply/richtek,rt9455.yaml b/Documentation/devicetree/bindings/power/supply/richtek,rt9455.yaml
> index 07e38be39f1b..89f9603499b4 100644
> --- a/Documentation/devicetree/bindings/power/supply/richtek,rt9455.yaml
> +++ b/Documentation/devicetree/bindings/power/supply/richtek,rt9455.yaml
> @@ -79,10 +79,10 @@ examples:
>          interrupt-parent = <&gpio1>;
>          interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
>  
> -        richtek,output-charge-current	    = <500000>;
> -        richtek,end-of-charge-percentage    = <10>;
> -        richtek,battery-regulation-voltage  = <4200000>;
> -        richtek,boost-output-voltage	    = <5050000>;
> +        richtek,output-charge-current = <500000>;
> +        richtek,end-of-charge-percentage = <10>;
> +        richtek,battery-regulation-voltage = <4200000>;
> +        richtek,boost-output-voltage = <5050000>;
>  
>          richtek,min-input-voltage-regulation = <4500000>;
>          richtek,avg-input-current-regulation = <500000>;
> diff --git a/Documentation/devicetree/bindings/regulator/mps,mp5416.yaml b/Documentation/devicetree/bindings/regulator/mps,mp5416.yaml
> index 0221397eb51e..f825ee9efd81 100644
> --- a/Documentation/devicetree/bindings/regulator/mps,mp5416.yaml
> +++ b/Documentation/devicetree/bindings/regulator/mps,mp5416.yaml
> @@ -62,8 +62,8 @@ examples:
>               regulator-name = "buck1";
>               regulator-min-microvolt = <600000>;
>               regulator-max-microvolt = <2187500>;
> -             regulator-min-microamp  = <3800000>;
> -             regulator-max-microamp  = <6800000>;
> +             regulator-min-microamp = <3800000>;
> +             regulator-max-microamp = <6800000>;
>               regulator-boot-on;
>              };
>  
> diff --git a/Documentation/devicetree/bindings/regulator/mps,mpq7920.yaml b/Documentation/devicetree/bindings/regulator/mps,mpq7920.yaml
> index 6de5b027f990..0d34af98403f 100644
> --- a/Documentation/devicetree/bindings/regulator/mps,mpq7920.yaml
> +++ b/Documentation/devicetree/bindings/regulator/mps,mpq7920.yaml
> @@ -98,8 +98,8 @@ examples:
>               regulator-name = "buck1";
>               regulator-min-microvolt = <400000>;
>               regulator-max-microvolt = <3587500>;
> -             regulator-min-microamp  = <460000>;
> -             regulator-max-microamp  = <7600000>;
> +             regulator-min-microamp = <460000>;
> +             regulator-max-microamp = <7600000>;
>               regulator-boot-on;
>               mps,buck-ovp-disable;
>               mps,buck-phase-delay = /bits/ 8 <2>;
> diff --git a/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml
> index 30632efdad8b..df36e29d974c 100644
> --- a/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml
> @@ -113,10 +113,10 @@ examples:
>      };
>  
>      imx7d-cm4 {
> -      compatible	= "fsl,imx7d-cm4";
> -      memory-region	= <&m4_reserved_sysmem1>, <&m4_reserved_sysmem2>;
> -      syscon		= <&src>;
> -      clocks		= <&clks IMX7D_ARM_M4_ROOT_CLK>;
> +      compatible = "fsl,imx7d-cm4";
> +      memory-region = <&m4_reserved_sysmem1>, <&m4_reserved_sysmem2>;
> +      syscon = <&src>;
> +      clocks = <&clks IMX7D_ARM_M4_ROOT_CLK>;
>      };
>  
>    - |
> -- 
> 2.34.1
> 
> 

