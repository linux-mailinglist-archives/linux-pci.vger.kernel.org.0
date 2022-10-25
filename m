Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C49ED60CAA9
	for <lists+linux-pci@lfdr.de>; Tue, 25 Oct 2022 13:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbiJYLLD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Oct 2022 07:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbiJYLLC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Oct 2022 07:11:02 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76971DDD2;
        Tue, 25 Oct 2022 04:11:00 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C229D6602363;
        Tue, 25 Oct 2022 12:10:58 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666696259;
        bh=wUzXNP2554vw1kifpUJL6eaLTVMshR1MxYNA6by4EzE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=bQjtAhXTWZEzWSb+blobyNbH+w/nBH91kxBzhBQmcTrWeWOV2jNfxWEeVag77fRb+
         I5XEZOTyi8Gt2beznmq2vcKlDrumy7kXeVEI5oVvSRkHZL3AS8IOUryl/zzntQKDSR
         2rAjpdHTphT+7wir469slnKFVY1JuXILXbSDbWFr9grT3cygqMIkJWP0IaSz8+dMA2
         o6SyxK9tqqLyHSltatqW8L24CmQqyFEelNPfQUR1OzA/SDSF2hm+BQ4IeOdCVnICbr
         /JbuKdGABjIL2gFp7/ih7fFqCiPz848r6LouRDS2nAo3pxCYg6avUdxZFE2A+eI/Gq
         aiCHa13yUt/ew==
Message-ID: <22728b06-f460-6dda-21fa-1d7a7ae3b903@collabora.com>
Date:   Tue, 25 Oct 2022 13:10:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v2 2/2] dt-bindings: PCI: mediatek-gen3: add support for
 mt7986
Content-Language: en-US
To:     Frank Wunderlich <linux@fw-web.de>,
        linux-mediatek@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     devicetree@vger.kernel.org, Ryder Lee <ryder.lee@mediatek.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-kernel@lists.infradead.org
References: <20221025072837.16591-1-linux@fw-web.de>
 <20221025072837.16591-3-linux@fw-web.de>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221025072837.16591-3-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Il 25/10/22 09:28, Frank Wunderlich ha scritto:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Add compatible string and clock-definition for mt7986. It needs 4 clocks
> for PCIe, define them in binding.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
> v2:
> - squashed patch 2+3 (compatible and clock definition)
> ---
>   .../bindings/pci/mediatek-pcie-gen3.yaml        | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> index 98d3f0f1cd76..57d0e84253e9 100644
> --- a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> +++ b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> @@ -48,6 +48,7 @@ properties:
>       oneOf:
>         - items:
>             - enum:
> +              - mediatek,mt7986-pcie
>                 - mediatek,mt8188-pcie
>                 - mediatek,mt8195-pcie
>             - const: mediatek,mt8192-pcie
> @@ -78,9 +79,11 @@ properties:
>         - const: mac
>   
>     clocks:
> +    minItems: 4
>       maxItems: 6

I'm not sure that this is really correct.
If you have a list of items (const or description, doesn't matter), you don't have
to specify maxItems, as it is implicitly equal to the number of items.
Also, specifying minItems means that you're "setting" one or more items as
optional.

It looks like you're specifying a specific and definite list of items for both
clocks and clock-names... and for all of the supported SoCs, so, I don't think
that having {min,max}Items globally specified on clocks, clock-names make any
kind of sense.

.....but I'd like for someone else to give an opinion on this as well.

Krzysztof, please?

Cheers,
Angelo

>   
>     clock-names:
> +    minItems: 4
>       maxItems: 6
>   
>     assigned-clocks:
> @@ -161,6 +164,20 @@ allOf:
>               - const: tl_32k
>               - const: peri_26m
>               - const: peri_mem
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - mediatek,mt7986-pcie
> +    then:
> +      properties:
> +        clock-names:
> +          items:
> +            - const: pl_250m
> +            - const: tl_26m
> +            - const: peri_26m
> +            - const: top_133m
>   
>   unevaluatedProperties: false
>   
> 

