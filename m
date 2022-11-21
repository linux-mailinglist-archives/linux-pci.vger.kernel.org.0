Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5B5632AD7
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 18:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbiKURVU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 12:21:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbiKURVA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 12:21:00 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A85CDCFB98;
        Mon, 21 Nov 2022 09:20:10 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id t1so8953614wmi.4;
        Mon, 21 Nov 2022 09:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xMcN9cuI8kd/EBAZ74WJbV4knfpudOgQHBZHEvjiUeg=;
        b=CdG/Jsfw1WTtgaq07815E+5iiz2BxCttLVutSSsFDeJFpdjNTgCM7mczngh0Mw0gQz
         SnTnYE2NuBXGHWFYumksr7JptJia+L+A9Py3dN8WPTyvvc9GgnpNljN4pEl0euji5eE1
         eyC8cYmYM+bHAe88l8/ZMLMlpikoW4T6vKWbn1n/jk48V1E2Dw4Y61p9lNjkiZxY3k5Y
         eopvdLuyLCetDs8o1UMQQd1ayN+JEoDZr37YZm1qdCe1sGBeqsPyXWYDnouy4B1/K2IM
         NYCYuCeeYrJTx/Cp+fZ3+lAaZ4ij8zzFbQKPGliDB5otsq7HURxo8kzaKU+ve9GHoDCw
         2vBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xMcN9cuI8kd/EBAZ74WJbV4knfpudOgQHBZHEvjiUeg=;
        b=EiI1JU1Twh5tQLsldOJElWjx8UB5PSnYdOOZUC3wZdzJhDxYoEBSovqHyAozppnGbP
         lFOLU4HB7k5sCk1+dwAgfiOBRxCIFKAEC1FhJjuzF+6etxy51eKX3ncB7da/TjwnJphq
         ILmDvVNSdSZ89X0O29Gec38EurhIjTdbTU21O2UgyoyooZU0iEvr3FzrK/R5qXJ87ZY7
         k+OvPCNe/Cm5fOZqm0fG8mse9yVFp5tgTxUoecX5ND6ZDkWKjp46XVI42nY07vUAXQMk
         TMOEnnD7hHIDxlunjB7QZGK3FfaO05cvmSIkz6K9g1eIu6AG9WkeK1u9T69EtGtT/QBr
         h5yA==
X-Gm-Message-State: ANoB5pl70EMGHEGLEMNca9H1JwPCsWAmDIzZPFF+O7KkzWDfXX03auWm
        re9YIfrvS0di9XVxwLtsaQM=
X-Google-Smtp-Source: AA0mqf5NIforkcTyJS8N4lSRmBCwg/nq8MPBei0Dm1KYtcSUjGsnHEVqkWMPQgn0njhjv49oLeM4WQ==
X-Received: by 2002:a05:600c:4f93:b0:3cf:a616:ccc0 with SMTP id n19-20020a05600c4f9300b003cfa616ccc0mr17500223wmq.73.1669051208958;
        Mon, 21 Nov 2022 09:20:08 -0800 (PST)
Received: from [192.168.1.131] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id c12-20020adffb4c000000b0022a3a887ceasm11736948wrs.49.2022.11.21.09.20.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 09:20:07 -0800 (PST)
Message-ID: <7902124b-fb5e-6eb4-1f57-f3fd49146e24@gmail.com>
Date:   Mon, 21 Nov 2022 18:20:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v6 06/11] arm64: dts: mt7986: add spi related device nodes
Content-Language: en-US
To:     Frank Wunderlich <linux@fw-web.de>,
        linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Bo Jiao <Bo.Jiao@mediatek.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-usb@vger.kernel.org,
        Sam Shih <sam.shih@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
References: <20221118190126.100895-1-linux@fw-web.de>
 <20221118190126.100895-7-linux@fw-web.de>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20221118190126.100895-7-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 18/11/2022 20:01, Frank Wunderlich wrote:
> From: Sam Shih <sam.shih@mediatek.com>
> 
> This patch adds spi support for MT7986.
> 
> Signed-off-by: Sam Shih <sam.shih@mediatek.com>
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Applied, thanks!

> ---
>   arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts | 35 ++++++++++++++++++++
>   arch/arm64/boot/dts/mediatek/mt7986a.dtsi    | 28 ++++++++++++++++
>   arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts | 35 ++++++++++++++++++++
>   3 files changed, 98 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts b/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
> index 2f48cc3d3ddb..006878e3f2b2 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
> @@ -59,6 +59,20 @@ switch: switch@0 {
>   };
>   
>   &pio {
> +	spi_flash_pins: spi-flash-pins {
> +		mux {
> +			function = "spi";
> +			groups = "spi0", "spi0_wp_hold";
> +		};
> +	};
> +
> +	spic_pins: spic-pins {
> +		mux {
> +			function = "spi";
> +			groups = "spi1_2";
> +		};
> +	};
> +
>   	uart1_pins: uart1-pins {
>   		mux {
>   			function = "uart";
> @@ -105,6 +119,27 @@ conf {
>   	};
>   };
>   
> +&spi0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&spi_flash_pins>;
> +	cs-gpios = <0>, <0>;
> +	status = "okay";
> +	spi_nand: spi_nand@0 {
> +		compatible = "spi-nand";
> +		reg = <0>;
> +		spi-max-frequency = <10000000>;
> +		spi-tx-buswidth = <4>;
> +		spi-rx-buswidth = <4>;
> +	};
> +};
> +
> +&spi1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&spic_pins>;
> +	cs-gpios = <0>, <0>;
> +	status = "okay";
> +};
> +
>   &switch {
>   	ports {
>   		#address-cells = <1>;
> diff --git a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
> index afc01abfa99c..29da9b8ed753 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
> @@ -253,6 +253,34 @@ i2c0: i2c@11008000 {
>   			status = "disabled";
>   		};
>   
> +		spi0: spi@1100a000 {
> +			compatible = "mediatek,mt7986-spi-ipm", "mediatek,spi-ipm";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0 0x1100a000 0 0x100>;
> +			interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&topckgen CLK_TOP_MPLL_D2>,
> +				 <&topckgen CLK_TOP_SPI_SEL>,
> +				 <&infracfg CLK_INFRA_SPI0_CK>,
> +				 <&infracfg CLK_INFRA_SPI0_HCK_CK>;
> +			clock-names = "parent-clk", "sel-clk", "spi-clk", "hclk";
> +			status = "disabled";
> +		};
> +
> +		spi1: spi@1100b000 {
> +			compatible = "mediatek,mt7986-spi-ipm", "mediatek,spi-ipm";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0 0x1100b000 0 0x100>;
> +			interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&topckgen CLK_TOP_MPLL_D2>,
> +				 <&topckgen CLK_TOP_SPIM_MST_SEL>,
> +				 <&infracfg CLK_INFRA_SPI1_CK>,
> +				 <&infracfg CLK_INFRA_SPI1_HCK_CK>;
> +			clock-names = "parent-clk", "sel-clk", "spi-clk", "hclk";
> +			status = "disabled";
> +		};
> +
>   		ethsys: syscon@15000000 {
>   			 #address-cells = <1>;
>   			 #size-cells = <1>;
> diff --git a/arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts b/arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts
> index 79c5c78f7a14..2c7f1d4fb352 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts
> @@ -100,6 +100,20 @@ fixed-link {
>   };
>   
>   &pio {
> +	spi_flash_pins: spi-flash-pins {
> +		mux {
> +			function = "spi";
> +			groups = "spi0", "spi0_wp_hold";
> +		};
> +	};
> +
> +	spic_pins: spic-pins {
> +		mux {
> +			function = "spi";
> +			groups = "spi1_2";
> +		};
> +	};
> +
>   	wf_2g_5g_pins: wf-2g-5g-pins {
>   		mux {
>   			function = "wifi";
> @@ -132,6 +146,27 @@ conf {
>   	};
>   };
>   
> +&spi0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&spi_flash_pins>;
> +	cs-gpios = <0>, <0>;
> +	status = "okay";
> +	spi_nand: spi_nand@0 {
> +		compatible = "spi-nand";
> +		reg = <0>;
> +		spi-max-frequency = <10000000>;
> +		spi-tx-buswidth = <4>;
> +		spi-rx-buswidth = <4>;
> +	};
> +};
> +
> +&spi1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&spic_pins>;
> +	cs-gpios = <0>, <0>;
> +	status = "okay";
> +};
> +
>   &uart0 {
>   	status = "okay";
>   };
