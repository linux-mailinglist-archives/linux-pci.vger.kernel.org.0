Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F25B6621C0D
	for <lists+linux-pci@lfdr.de>; Tue,  8 Nov 2022 19:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbiKHSjh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Nov 2022 13:39:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231947AbiKHSja (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Nov 2022 13:39:30 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAFA25654B;
        Tue,  8 Nov 2022 10:39:29 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id l14so22445184wrw.2;
        Tue, 08 Nov 2022 10:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fDlEuFCBkdVRiL30o36F0YHf2u/rviJA13UeBNADX6E=;
        b=oZgvgoauLGM+Et3oeewioTomOSt9a57yhx+w7jvo/dLkd+N4wHA9fqLsjdkYRB+A+6
         EUmJqDrvL2K7YKaNXMyVhRvY36XvITlaGCabK6XyPw/5gMrNcG0JoAfU+efXo6J+eu+o
         YOPYiWSjFYcEcHcB7osfQ5BYSuoOjshPXORlB6O8Rxj5+KC7qJ9a1ArBrVM2KrkRkD95
         EqEL5uCurls6ejSygf05NwZfa3c6O2WmCT7ucFJdapAiBayPdLBy/J8/wt9gZXAiRaHt
         Upn8FEFMs3m6wSNUT8tE//LnVkIi3s02glVFFh1SYcSUNMTdVLgunW7Xm9tju27euzoW
         74hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fDlEuFCBkdVRiL30o36F0YHf2u/rviJA13UeBNADX6E=;
        b=MCRxfIXYPcMcjTwoBT9IbUO85y44Qj/epp/imDeNynpNq7YkLbqviL3UMgopiEnKf3
         5IEGvtdAZVz80wbwi0bjE7NXlX4FQqojVvolcSDZ7OeT6YKb92tkNeLVbepER4z6daJl
         pKhI5CK5hgZjLC/6GJ6DhTEPozk6wB7Yv1nozOT7uWyqgS22/kluNkqx+itFlw6W6j/v
         KrhWTumjsdj88eC2yxf5DRniW/NDcm+CC2cZruvfhuzoOzRnnfkt7FB2e6/LRbK1LJSd
         hqz+bi8uoD1AlbVKWoGFPygT1yv8hgIluamIWasr1Wl6yiSVfW6rgvSP7MxFW7fcyRDf
         B1Dw==
X-Gm-Message-State: ACrzQf1jP+0VFPMIOkxC8vCojIX8nfIyRNyDEc58EATzRWGtmXaLUpQ6
        YQQberXxK5WtUMPXoaLXVso=
X-Google-Smtp-Source: AMsMyM5U4O4Ks0X3U7IIFCiH2wrc6/rcOFM1HBtZ7MAH8fXll7ttTvdO2hWx5RuEBHNM5XLkhMJS3Q==
X-Received: by 2002:adf:f386:0:b0:236:6e8c:f5bb with SMTP id m6-20020adff386000000b002366e8cf5bbmr35438914wro.587.1667932768232;
        Tue, 08 Nov 2022 10:39:28 -0800 (PST)
Received: from [192.168.0.25] ([37.222.251.204])
        by smtp.gmail.com with ESMTPSA id r9-20020adfdc89000000b002258235bda3sm11079057wrj.61.2022.11.08.10.39.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 10:39:27 -0800 (PST)
Message-ID: <8e8bf059-7347-3586-0cc9-e02c007de9b2@gmail.com>
Date:   Tue, 8 Nov 2022 19:39:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v5 3/3] arm64: dts: mt8195: Add venc node
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
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Irui Wang <irui.wang@mediatek.com>
References: <20221103025656.8714-1-tinghan.shen@mediatek.com>
 <20221103025656.8714-4-tinghan.shen@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20221103025656.8714-4-tinghan.shen@mediatek.com>
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
> Add venc node for mt8195 SoC.
> 
> Signed-off-by: Irui Wang <irui.wang@mediatek.com>
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Applied this patch, for the 2/3 we need PCIe maintainer to take the binding 
change or provide an ACked by.

Regards,
Matthias

> ---
>   arch/arm64/boot/dts/mediatek/mt8195.dtsi | 24 ++++++++++++++++++++++++
>   1 file changed, 24 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> index 7d74a5211091..dbfc15174de3 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> @@ -2109,6 +2109,30 @@
>   			power-domains = <&spm MT8195_POWER_DOMAIN_VENC>;
>   		};
>   
> +		venc: video-codec@1a020000 {
> +			compatible = "mediatek,mt8195-vcodec-enc";
> +			reg = <0 0x1a020000 0 0x10000>;
> +			iommus = <&iommu_vdo M4U_PORT_L19_VENC_RCPU>,
> +				 <&iommu_vdo M4U_PORT_L19_VENC_REC>,
> +				 <&iommu_vdo M4U_PORT_L19_VENC_BSDMA>,
> +				 <&iommu_vdo M4U_PORT_L19_VENC_SV_COMV>,
> +				 <&iommu_vdo M4U_PORT_L19_VENC_RD_COMV>,
> +				 <&iommu_vdo M4U_PORT_L19_VENC_CUR_LUMA>,
> +				 <&iommu_vdo M4U_PORT_L19_VENC_CUR_CHROMA>,
> +				 <&iommu_vdo M4U_PORT_L19_VENC_REF_LUMA>,
> +				 <&iommu_vdo M4U_PORT_L19_VENC_REF_CHROMA>;
> +			interrupts = <GIC_SPI 341 IRQ_TYPE_LEVEL_HIGH 0>;
> +			mediatek,scp = <&scp>;
> +			clocks = <&vencsys CLK_VENC_VENC>;
> +			clock-names = "venc_sel";
> +			assigned-clocks = <&topckgen CLK_TOP_VENC>;
> +			assigned-clock-parents = <&topckgen CLK_TOP_UNIVPLL_D4>;
> +			power-domains = <&spm MT8195_POWER_DOMAIN_VENC>;
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			dma-ranges = <0x1 0x0 0x0 0x40000000 0x0 0xfff00000>;
> +		};
> +
>   		vencsys_core1: clock-controller@1b000000 {
>   			compatible = "mediatek,mt8195-vencsys_core1";
>   			reg = <0 0x1b000000 0 0x1000>;
