Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7DB603F41
	for <lists+linux-pci@lfdr.de>; Wed, 19 Oct 2022 11:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233507AbiJSJaz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Oct 2022 05:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233913AbiJSJ3v (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Oct 2022 05:29:51 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B12EB774;
        Wed, 19 Oct 2022 02:13:14 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 754E166015ED;
        Wed, 19 Oct 2022 09:55:52 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666169753;
        bh=qCUZKYlUvnwloHXmaClS+rjs+8bWGqFAUjftTWAGEx0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=LjE9o1GkblbjvaNm++jLYcGI4z/7vIBJEIcY9dQ++qrF+YgZSueMSbMEgippcC9Mw
         pLlEtU7beTPzMCPEZ6cNp3+GeTyHcDiUkUs37Tmd6FG6BeuD1bl1mMHh+54tbwUy27
         9y07KjbsIHu3KFQVGQBU5ATCPRLarQwbSAsOF8yOynbMqANFjGrVTAo4MSnbhNQs0v
         K5gNaAJ2l5wNOKPA09IVlZK15+UtGaJXSPWSkIJpUFQzJoqBI/GLNiiSx6hDMH5Psm
         4sp+lykeNyXJ/ZVIO9mrnvEVWhHmy0rqXMUZF3viHi8tHPL3KQdeCq1lYLQpLTmb03
         uhmwv4ph4+UnQ==
Message-ID: <c30fbc60-bcdf-71f5-0db7-bd9bb27ddd37@collabora.com>
Date:   Wed, 19 Oct 2022 10:55:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v1 2/3] arm64: dts: mt8195: Add pcie and pcie phy nodes
Content-Language: en-US
To:     Tinghan Shen <tinghan.shen@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20221017070858.13902-1-tinghan.shen@mediatek.com>
 <20221017070858.13902-3-tinghan.shen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221017070858.13902-3-tinghan.shen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Il 17/10/22 09:08, Tinghan Shen ha scritto:
> Add pcie and pcie phy nodes for mt8195.
> 
> Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> ---
>   arch/arm64/boot/dts/mediatek/mt8195.dtsi | 143 +++++++++++++++++++++++
>   1 file changed, 143 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> index d03f0c2b8233..903e92d6156f 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> @@ -1182,6 +1182,104 @@
>   			status = "disabled";
>   		};
>   
> +		pcie0: pcie@112f0000 {
> +			compatible = "mediatek,mt8195-pcie",
> +				     "mediatek,mt8192-pcie";

..snip..

> +
> +			phys = <&pciephy>;
> +			phy-names = "pcie-phy";
> +
> +			power-domains = <&spm MT8195_POWER_DOMAIN_PCIE_MAC_P0>;

You're missing the resets:

			resets = <&infracfg_ao MT8195_INFRA_RST2_PCIE_P0_SWRST>;
			reset-names = "mac";

> +
> +			#interrupt-cells = <1>;
> +			interrupt-map-mask = <0 0 0 7>;

..snip..

> +		};
> +
> +		pcie1: pcie@112f8000 {
> +			compatible = "mediatek,mt8195-pcie",
> +				     "mediatek,mt8192-pcie";

..snip..

> +			power-domains = <&spm MT8195_POWER_DOMAIN_PCIE_MAC_P1>;

Here too:
			resets = <&infracfg_ao MT8195_INFRA_RST2_USBSIF_P1_SWRST>,
				 <&infracfg_ao MT8195_INFRA_RST2_PCIE_P1_SWRST>;
			reset-names = "phy", "mac";

> +
> +			#interrupt-cells = <1>;

..snip..

> @@ -1241,6 +1339,34 @@
>   				reg = <0x189 0x2>;
>   				bits = <7 5>;
>   			};
> +			pciephy_rx_ln1: pciephy-rx-ln1@190 {
> +				reg = <0x190 0x1>;
> +				bits = <0 4>;
> +			};
> +			pciephy_tx_ln1_nmos: pciephy-tx-ln1-nmos@190 {

Please run dtbs_check and try to build the kernel before pushing commits upstream.
This will give you a not-so-nice warning and that shall not happen.

You can solve it by naming these nodes like:
pciephy-rx-ln1@190,1
pciephy-tx-ln1-nmos@190,2

...etc

Regards,
Angelo

