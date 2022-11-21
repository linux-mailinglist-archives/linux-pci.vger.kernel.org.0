Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B176632A36
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 18:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbiKUREZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 12:04:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbiKUREZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 12:04:25 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4116D79378;
        Mon, 21 Nov 2022 09:04:24 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id t25-20020a1c7719000000b003cfa34ea516so10718120wmi.1;
        Mon, 21 Nov 2022 09:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NoFx71q/N+0qvQAXga+00ibSeehFlmzztyqyJ4eQ8tU=;
        b=SOzH1U73ZCGPIl43YAXV6NsMIfqJufbn/wt/jIDoIOp6GOyDnyNUbweXEzy6k7i/GC
         U7kDF6zkGTZJaKsG8HlSLw6o4jH+zrzamUK2ttsK/v0Ev0UHeFKF0cgO56PL/UfJ/VJq
         P5tegS169frMGQLFONlxqSDw7DKPL4qSX28m2Y8oxjCQK9OaNMfJcmdEA58NrNYCcXMD
         tVeexNRwQNzZfTAaPFiTj34BZsAFgPj6pDjykwWIRKBwlD0kuFXmIK8+OSHKMvwmpdIz
         xqrzkxoEMdn0qCvI3EfBZ+LkJcoeDhsKeEQYm3cS36/rtajPjkuv9RSkbX50qFpzKnan
         569A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NoFx71q/N+0qvQAXga+00ibSeehFlmzztyqyJ4eQ8tU=;
        b=NZZsSDuHCCaa1UHue9r6x4vrjP6SZCm9iuTOHBTaLkS4VywgVMMQ6ySXIF0d3BlEuO
         RhlLJVVpA+FGhmPlKzWTG+if/gR71PigSII7wJeBfy5Bgbs3EgRNManjNF87Lyu3cKqA
         VRyZPu4K0UVhRCKh47lSu/JYau7JFfZ8cydo7xz+Byz2bT6XNAQ2yAIakCrAiImONZlp
         XkSDVGdYbXCn0ydlotTq43Mzv/rnhZTX1V7n+JcgqVsW5igGAED3gt0NHzCTkO4dFSoe
         qINo4POl7iAbfvvba+GnAB3fDstw8yY878zxTF/QuZtBcjQyhFQisk4smesZlQXCquBT
         bC5A==
X-Gm-Message-State: ANoB5pnuQ+LeelLUL5FGc88+ljPk/bLy31MCCYWhiBo7tE4FwQQtvFMm
        wbsd7B6/NeVqV7hHEptJKVxUM9W9SLA=
X-Google-Smtp-Source: AA0mqf7NevCCp2kHDxm/siKILqFB87Rj2TAPdnv2R9chC5DSXsq7GJxVOqlYf2BRJ2sM75AZqf8HGg==
X-Received: by 2002:a05:600c:35c8:b0:3cf:cf89:2f02 with SMTP id r8-20020a05600c35c800b003cfcf892f02mr2889036wmq.2.1669050262379;
        Mon, 21 Nov 2022 09:04:22 -0800 (PST)
Received: from [192.168.1.131] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id g17-20020a05600c4ed100b003c701c12a17sm21447872wmq.12.2022.11.21.09.04.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 09:04:20 -0800 (PST)
Message-ID: <a257049b-d3a8-e0ac-d887-5bb0420579ad@gmail.com>
Date:   Mon, 21 Nov 2022 18:04:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v6 01/11] arm64: dts: mt7986: move wed_pcie node
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
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
References: <20221118190126.100895-1-linux@fw-web.de>
 <20221118190126.100895-2-linux@fw-web.de>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20221118190126.100895-2-linux@fw-web.de>
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
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Move the wed_pcie node to have node aligned by address.
> 
> Fixes: 00b9903996b3 ("arm64: dts: mediatek: mt7986: add support for Wireless Ethernet Dispatch")
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Applied, thanks!

> ---
>   arch/arm64/boot/dts/mediatek/mt7986a.dtsi | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
> index a22e10e89ab9..afc01abfa99c 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
> @@ -112,6 +112,12 @@ infracfg: infracfg@10001000 {
>   			#clock-cells = <1>;
>   		};
>   
> +		wed_pcie: wed-pcie@10003000 {
> +			compatible = "mediatek,mt7986-wed-pcie",
> +				     "syscon";
> +			reg = <0 0x10003000 0 0x10>;
> +		};
> +
>   		topckgen: topckgen@1001b000 {
>   			compatible = "mediatek,mt7986-topckgen", "syscon";
>   			reg = <0 0x1001B000 0 0x1000>;
> @@ -257,12 +263,6 @@ ethsys: syscon@15000000 {
>   			 #reset-cells = <1>;
>   		};
>   
> -		wed_pcie: wed-pcie@10003000 {
> -			compatible = "mediatek,mt7986-wed-pcie",
> -				     "syscon";
> -			reg = <0 0x10003000 0 0x10>;
> -		};
> -
>   		wed0: wed@15010000 {
>   			compatible = "mediatek,mt7986-wed",
>   				     "syscon";
