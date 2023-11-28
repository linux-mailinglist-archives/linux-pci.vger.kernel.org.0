Return-Path: <linux-pci+bounces-223-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 642297FB91E
	for <lists+linux-pci@lfdr.de>; Tue, 28 Nov 2023 12:13:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F88E1C213FA
	for <lists+linux-pci@lfdr.de>; Tue, 28 Nov 2023 11:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87F54F5F1;
	Tue, 28 Nov 2023 11:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u/6jtH/X"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F991B4
	for <linux-pci@vger.kernel.org>; Tue, 28 Nov 2023 03:13:21 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5c8c8f731aaso54320457b3.0
        for <linux-pci@vger.kernel.org>; Tue, 28 Nov 2023 03:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701170001; x=1701774801; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5+7m1qZKqcCsz92JzY98CnLRq03LO4op042hU6Jlus8=;
        b=u/6jtH/XIXWHS+OuJkBKBg1j+crIKxo3k+jmFB7w9VgICUusnKbmSWfNALJz2ddpcH
         9YKpN2SJBgKWWUYqSH69S2nnp5hWt+hfKrQUnJUfh7F25qwaMm2+kI9Kz2ZsVCYNrRUZ
         MDQD8SHZ6GWVlW6tSPkGCq3hlJycjP2C6s2xlorUibIMXbVUEns/mGcu/t5uFxGSQl62
         pzVkktGXSp2ulMcMJTbMiG5+r9FhIdfA1S5ffFTUl4nCdOn4qM0pubt88l0TKlHZ0LXH
         nED1HAXpwSnbiu5HuNP8kxPX4Y3spF7Ex2sSAi8kXPo1hMxlxhNRUyc6bGMsgsh0koCx
         6EFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701170001; x=1701774801;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5+7m1qZKqcCsz92JzY98CnLRq03LO4op042hU6Jlus8=;
        b=ieS5gcjPj+pwFUWbsg8FJFOunJTISnTQWCC5PzBtzC7BQrbbN25UxtffrAbmb2pt1P
         u/CNf4U5ueLtrMo4yWPhEgI7ULikEW9DPYIvbKvyJwwOP51xEplRf6On42BAj++hXrQX
         mU+hjdTk1R3bgJDzPWpRdn2fY6yzCuXvWESQSgT8M2mFaR6SqzzfwaqW/98/po2DnzqM
         XGSijRUug+Z5yh8Tq5rdQj1KX4Dznbz5Lu4dk7LQz9a1U15QZ+CHVo6M7AU6qNVt5rnN
         JhGQizUeZkMqeACHJfGGREUDk9imO4jsL5WK6W3ggII1iSfkIM3hE96p6Fdf2S8b9r9q
         2Jeg==
X-Gm-Message-State: AOJu0YxVHezI3oxPdd0NtH2p3feTqJCp8/9m6EobTG0EKqN/232ObSqu
	BFxgsDK9Zc9As5BH2kCNdZTDVSE4vjES3dS7o26I9w==
X-Google-Smtp-Source: AGHT+IEIlYIUgXUVgijUk5SHHCon10nYrdq9xIAy+EVj6X4AyLg1jrCQz1JjEvO+OvZ+6zebaSGf51Pr4C1gpwhT2mE=
X-Received: by 2002:a25:ab2d:0:b0:daf:686c:4919 with SMTP id
 u42-20020a25ab2d000000b00daf686c4919mr15140437ybi.18.1701170000650; Tue, 28
 Nov 2023 03:13:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231124092121.16866-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20231124092121.16866-1-krzysztof.kozlowski@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 28 Nov 2023 12:12:44 +0100
Message-ID: <CAPDyKFpiCOAobAKJ3o3udssKx4oHbQwOF3=hHgx3Uqtn1mxpaw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: correct white-spaces in examples
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-mmc@vger.kernel.org, netdev@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-remoteproc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 24 Nov 2023 at 10:21, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Use only one and exactly one space around '=' in DTS example.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org> # For MMC

Kind regards
Uffe

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
> -        richtek,output-charge-current      = <500000>;
> -        richtek,end-of-charge-percentage    = <10>;
> -        richtek,battery-regulation-voltage  = <4200000>;
> -        richtek,boost-output-voltage       = <5050000>;
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
> -      compatible       = "fsl,imx7d-cm4";
> -      memory-region    = <&m4_reserved_sysmem1>, <&m4_reserved_sysmem2>;
> -      syscon           = <&src>;
> -      clocks           = <&clks IMX7D_ARM_M4_ROOT_CLK>;
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

