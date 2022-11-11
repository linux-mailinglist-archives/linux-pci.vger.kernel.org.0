Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0608B6255B2
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 09:48:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233363AbiKKIr7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 03:47:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233351AbiKKIr4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 03:47:56 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A75D6748FC;
        Fri, 11 Nov 2022 00:47:53 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id w14so5544241wru.8;
        Fri, 11 Nov 2022 00:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jel38J1a9uL1OPaQKUSp38nO5k1Zrs1cWfc+j0Y3MDg=;
        b=Fm7G0bOk0tvTIcN5yeEQS5af4MwHmAmvhaSXVhGM7Wc2pa2bz5xYMqreRxOOFa4XEe
         gx7SDj+1vBsqz6MYun8KjivOWx0jwMx1wBaaf3AsKKaJCbhvgt33WGghHf5wp45KVhci
         0k7iqo4XI25XnD76+iHBUTgtjLt4s0unzaWRdGZNHauSkOpmOPFUNy2jPN2/nvpdzT2Y
         Hvgj9lfjlUm/lG0LYdZ/N3vsBP+HGxVnxTwREE9WD19i5l6Ci57UC3BUnuZKhkL9xIxL
         tbciCHUYQV9rW486W4HmNoMdSwqqsaxU2hYrj0L9t+0GnYFXEMwEIetM2Ri2liF019Jg
         9TUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jel38J1a9uL1OPaQKUSp38nO5k1Zrs1cWfc+j0Y3MDg=;
        b=tRuNhZIfe0YBPAnyfbPrfoIGiw5nBgE0gSMbi3zzQPkXJVGLlRFTqIaFQIIO0FL/wu
         vurdeqZb5PlUhyhgd3SNrwyycww1kVGJI4Dk3qkveDSTPU6qKrZ10x2M0lZGodxTh5HF
         Rohn5mRdCxV630hlf58akVWFXEj5HxMt06zpKz/cZXdQXnmviLOGTLphIz9eK1FA1OVc
         36X954xNwszfTXifEsFafCKlnCT0IZniw9319xMxtVTEHAYjniGzPuj0Zz5nMlvQXHlD
         A3JBNh3e70T43+PKCSAnVuW27j547ZYX6CZRganLr4h2YFkHTgLEqXQd4jKIw7Jtf/Sb
         QXzQ==
X-Gm-Message-State: ANoB5pkXScZ0HGvq5c2JvfdHEvPrQk5mCvIi0UrhcVyWMcmb4gNHwOLu
        LB/jk7CRucC0dJiA3Lp8Ntk=
X-Google-Smtp-Source: AA0mqf5jHGLCbHg6kRQS6wlZ8SNwRCkkqeGaAsG2XNoT6746K/UtemlW/nWekvFCpiGrr3GvyRFSxA==
X-Received: by 2002:a5d:4386:0:b0:22e:3177:1401 with SMTP id i6-20020a5d4386000000b0022e31771401mr594871wrq.148.1668156472076;
        Fri, 11 Nov 2022 00:47:52 -0800 (PST)
Received: from [192.168.1.131] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id q189-20020a1c43c6000000b003cf483ee8e0sm8043194wma.24.2022.11.11.00.47.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Nov 2022 00:47:49 -0800 (PST)
Message-ID: <50a2022c-d535-1162-e1b5-ae6b6e7bbd32@gmail.com>
Date:   Fri, 11 Nov 2022 09:47:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v5 2/3] arm64: dts: mt8195: Add pcie and pcie phy nodes
Content-Language: en-US
To:     Tinghan Shen <tinghan.shen@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20221103025656.8714-1-tinghan.shen@mediatek.com>
 <20221103025656.8714-3-tinghan.shen@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20221103025656.8714-3-tinghan.shen@mediatek.com>
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



On 03/11/2022 03:56, Tinghan Shen wrote:
> Add pcie and pcie phy nodes for mt8195.
> 
> Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Applied thanks!

> ---
>   arch/arm64/boot/dts/mediatek/mt8195.dtsi | 150 +++++++++++++++++++++++
>   1 file changed, 150 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> index 905d1a90b406..7d74a5211091 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> @@ -13,6 +13,7 @@
>   #include <dt-bindings/phy/phy.h>
>   #include <dt-bindings/pinctrl/mt8195-pinfunc.h>
>   #include <dt-bindings/power/mt8195-power.h>
> +#include <dt-bindings/reset/mt8195-resets.h>
>   
>   / {
>   	compatible = "mediatek,mt8195";
> @@ -1182,6 +1183,110 @@
>   			status = "disabled";
>   		};
>   
> +		pcie0: pcie@112f0000 {
> +			compatible = "mediatek,mt8195-pcie",
> +				     "mediatek,mt8192-pcie";
> +			device_type = "pci";
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +			reg = <0 0x112f0000 0 0x4000>;
> +			reg-names = "pcie-mac";
> +			interrupts = <GIC_SPI 791 IRQ_TYPE_LEVEL_HIGH 0>;
> +			bus-range = <0x00 0xff>;
> +			ranges = <0x81000000 0 0x20000000
> +				  0x0 0x20000000 0 0x200000>,
> +				 <0x82000000 0 0x20200000
> +				  0x0 0x20200000 0 0x3e00000>;
> +
> +			iommu-map = <0 &iommu_infra IOMMU_PORT_INFRA_PCIE0 0x2>;
> +			iommu-map-mask = <0x0>;
> +
> +			clocks = <&infracfg_ao CLK_INFRA_AO_PCIE_PL_P_250M_P0>,
> +				 <&infracfg_ao CLK_INFRA_AO_PCIE_TL_26M>,
> +				 <&infracfg_ao CLK_INFRA_AO_PCIE_TL_96M>,
> +				 <&infracfg_ao CLK_INFRA_AO_PCIE_TL_32K>,
> +				 <&infracfg_ao CLK_INFRA_AO_PCIE_PERI_26M>,
> +				 <&pericfg_ao CLK_PERI_AO_PCIE_P0_MEM>;
> +			clock-names = "pl_250m", "tl_26m", "tl_96m",
> +				      "tl_32k", "peri_26m", "peri_mem";
> +			assigned-clocks = <&topckgen CLK_TOP_TL>;
> +			assigned-clock-parents = <&topckgen CLK_TOP_MAINPLL_D4_D4>;
> +
> +			phys = <&pciephy>;
> +			phy-names = "pcie-phy";
> +
> +			power-domains = <&spm MT8195_POWER_DOMAIN_PCIE_MAC_P0>;
> +
> +			resets = <&infracfg_ao MT8195_INFRA_RST2_PCIE_P0_SWRST>;
> +			reset-names = "mac";
> +
> +			#interrupt-cells = <1>;
> +			interrupt-map-mask = <0 0 0 7>;
> +			interrupt-map = <0 0 0 1 &pcie_intc0 0>,
> +					<0 0 0 2 &pcie_intc0 1>,
> +					<0 0 0 3 &pcie_intc0 2>,
> +					<0 0 0 4 &pcie_intc0 3>;
> +			status = "disabled";
> +
> +			pcie_intc0: interrupt-controller {
> +				interrupt-controller;
> +				#address-cells = <0>;
> +				#interrupt-cells = <1>;
> +			};
> +		};
> +
> +		pcie1: pcie@112f8000 {
> +			compatible = "mediatek,mt8195-pcie",
> +				     "mediatek,mt8192-pcie";
> +			device_type = "pci";
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +			reg = <0 0x112f8000 0 0x4000>;
> +			reg-names = "pcie-mac";
> +			interrupts = <GIC_SPI 792 IRQ_TYPE_LEVEL_HIGH 0>;
> +			bus-range = <0x00 0xff>;
> +			ranges = <0x81000000 0 0x24000000
> +				  0x0 0x24000000 0 0x200000>,
> +				 <0x82000000 0 0x24200000
> +				  0x0 0x24200000 0 0x3e00000>;
> +
> +			iommu-map = <0 &iommu_infra IOMMU_PORT_INFRA_PCIE1 0x2>;
> +			iommu-map-mask = <0x0>;
> +
> +			clocks = <&infracfg_ao CLK_INFRA_AO_PCIE_PL_P_250M_P1>,
> +				 <&clk26m>,
> +				 <&infracfg_ao CLK_INFRA_AO_PCIE_TL_96M>,
> +				 <&clk26m>,
> +				 <&infracfg_ao CLK_INFRA_AO_PCIE_PERI_26M>,
> +				 /* Designer has connect pcie1 with peri_mem_p0 clock */
> +				 <&pericfg_ao CLK_PERI_AO_PCIE_P0_MEM>;
> +			clock-names = "pl_250m", "tl_26m", "tl_96m",
> +				      "tl_32k", "peri_26m", "peri_mem";
> +			assigned-clocks = <&topckgen CLK_TOP_TL_P1>;
> +			assigned-clock-parents = <&topckgen CLK_TOP_MAINPLL_D4_D4>;
> +
> +			phys = <&u3port1 PHY_TYPE_PCIE>;
> +			phy-names = "pcie-phy";
> +			power-domains = <&spm MT8195_POWER_DOMAIN_PCIE_MAC_P1>;
> +
> +			resets = <&infracfg_ao MT8195_INFRA_RST2_PCIE_P1_SWRST>;
> +			reset-names = "mac";
> +
> +			#interrupt-cells = <1>;
> +			interrupt-map-mask = <0 0 0 7>;
> +			interrupt-map = <0 0 0 1 &pcie_intc1 0>,
> +					<0 0 0 2 &pcie_intc1 1>,
> +					<0 0 0 3 &pcie_intc1 2>,
> +					<0 0 0 4 &pcie_intc1 3>;
> +			status = "disabled";
> +
> +			pcie_intc1: interrupt-controller {
> +				interrupt-controller;
> +				#address-cells = <0>;
> +				#interrupt-cells = <1>;
> +			};
> +		};
> +
>   		nor_flash: spi@1132c000 {
>   			compatible = "mediatek,mt8195-nor",
>   				     "mediatek,mt8173-nor";
> @@ -1241,6 +1346,34 @@
>   				reg = <0x189 0x2>;
>   				bits = <7 5>;
>   			};
> +			pciephy_rx_ln1: pciephy-rx-ln1@190,1 {
> +				reg = <0x190 0x1>;
> +				bits = <0 4>;
> +			};
> +			pciephy_tx_ln1_nmos: pciephy-tx-ln1-nmos@190,2 {
> +				reg = <0x190 0x1>;
> +				bits = <4 4>;
> +			};
> +			pciephy_tx_ln1_pmos: pciephy-tx-ln1-pmos@191,1 {
> +				reg = <0x191 0x1>;
> +				bits = <0 4>;
> +			};
> +			pciephy_rx_ln0: pciephy-rx-ln0@191,2 {
> +				reg = <0x191 0x1>;
> +				bits = <4 4>;
> +			};
> +			pciephy_tx_ln0_nmos: pciephy-tx-ln0-nmos@192,1 {
> +				reg = <0x192 0x1>;
> +				bits = <0 4>;
> +			};
> +			pciephy_tx_ln0_pmos: pciephy-tx-ln0-pmos@192,2 {
> +				reg = <0x192 0x1>;
> +				bits = <4 4>;
> +			};
> +			pciephy_glb_intr: pciephy-glb-intr@193 {
> +				reg = <0x193 0x1>;
> +				bits = <0 4>;
> +			};
>   		};
>   
>   		u3phy2: t-phy@11c40000 {
> @@ -1461,6 +1594,23 @@
>   			};
>   		};
>   
> +		pciephy: phy@11e80000 {
> +			compatible = "mediatek,mt8195-pcie-phy";
> +			reg = <0 0x11e80000 0 0x10000>;
> +			reg-names = "sif";
> +			nvmem-cells = <&pciephy_glb_intr>, <&pciephy_tx_ln0_pmos>,
> +				      <&pciephy_tx_ln0_nmos>, <&pciephy_rx_ln0>,
> +				      <&pciephy_tx_ln1_pmos>, <&pciephy_tx_ln1_nmos>,
> +				      <&pciephy_rx_ln1>;
> +			nvmem-cell-names = "glb_intr", "tx_ln0_pmos",
> +					   "tx_ln0_nmos", "rx_ln0",
> +					   "tx_ln1_pmos", "tx_ln1_nmos",
> +					   "rx_ln1";
> +			power-domains = <&spm MT8195_POWER_DOMAIN_PCIE_PHY>;
> +			#phy-cells = <0>;
> +			status = "disabled";
> +		};
> +
>   		ufsphy: ufs-phy@11fa0000 {
>   			compatible = "mediatek,mt8195-ufsphy", "mediatek,mt8183-ufsphy";
>   			reg = <0 0x11fa0000 0 0xc000>;
