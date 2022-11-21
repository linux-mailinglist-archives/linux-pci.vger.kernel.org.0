Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E27D5632A48
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 18:05:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbiKURFq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 12:05:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbiKURFg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 12:05:36 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD25C6D01;
        Mon, 21 Nov 2022 09:05:35 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id i64-20020a1c3b43000000b003d016c21100so3671367wma.3;
        Mon, 21 Nov 2022 09:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wQ34R1ClvRJ30zGsVGp2RiEaSuUp9nthQZpzgznhpr8=;
        b=aMKwG0neuXdoNBJBy55LDxor41lGbfQMps+JlNnHqgoiOxjrPOtxdSE4RsHOecn/zZ
         UL8K7CG/gfcDLfDwRG2eluolShQ/8EH+mKVLF9yhV+Jd76lhsOyTqeJbI2W5X9IPIxh1
         yHRkJ91sF/u07+Rj0pUzoR3KynwVymat66kmdiUHqPs2Xti/MrOj4ll60J/uCVSR4XnX
         R42niY3I8FM6vWjMH6Wkrj8eqfXqLhk5K0GEyQqhQJVxTKkRONnDELnEBjspckBt68hg
         0Ts0diRaHbiI/L+6P9aSduy/8I64EiyzVkMPsay2JUloz4KcNoCs3RphVpBxd18f8h0D
         xaYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wQ34R1ClvRJ30zGsVGp2RiEaSuUp9nthQZpzgznhpr8=;
        b=G/MHEG00U1g2ZeXtVicB8Lgv4+votxpygOOWJAlLjjdUumMucgKlUd5EEWLalykHzo
         FhI0DBQNorI1bFryhRVKrYk9TEgf344Fr2JLHZx5Wti7FjewHNgYzaNsIzwXK2WX6q6d
         IYV8h8r1mvZaD/d9dhkt8rMMovHZgVFZD1WMvwauR/YHYFQmsNAt62qzRaGr7Cvv29LL
         WdbZXlHs4JuoHC60j9YsnvaJvdm98ggZiOF/ItMIEHOW9mWic3aSeDB1xWJ48EdtTkZI
         sHFQYKidjSCT76EzFLUBoO6ubKVXnjsGrNZ0fLjaYmdP9TNLdsF457A6NRwzG76DIaqF
         991g==
X-Gm-Message-State: ANoB5pmL8A4HKpRHSglpeggApjecHe9g6FfcuJvMOvYZt+3nX16Grojl
        UT1TSXJcPJUVRt5fH47E+QQ=
X-Google-Smtp-Source: AA0mqf6071ld2DQr5qO+/kKEHgogUnSmTC4vQ9vKrpj5EJuxP+w5Y+6e1Xaod0BnpQlAlpY4LP+xlw==
X-Received: by 2002:a05:600c:6012:b0:3cf:cb16:f242 with SMTP id az18-20020a05600c601200b003cfcb16f242mr5063589wmb.82.1669050334101;
        Mon, 21 Nov 2022 09:05:34 -0800 (PST)
Received: from [192.168.1.131] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id w19-20020adfbad3000000b00241c6729c2bsm8621083wrg.26.2022.11.21.09.05.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 09:05:32 -0800 (PST)
Message-ID: <53d6f1a2-86c8-409e-6b4a-d4e0f181adde@gmail.com>
Date:   Mon, 21 Nov 2022 18:05:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v6 04/11] dt-bindings: PCI: mediatek-gen3: add SoC based
 clock config
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
        Rob Herring <robh@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
References: <20221118190126.100895-1-linux@fw-web.de>
 <20221118190126.100895-5-linux@fw-web.de>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20221118190126.100895-5-linux@fw-web.de>
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
> The PCIe driver covers different SOC which needing different clock
> configs. Define them based on compatible.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Acked-by: Jianjun Wang <jianjun.wang@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
> v2:
> - fix typo in mediatek,mt8192-pcie
> v3:
> - remove contains to match only if compatible is no fallback
>    tested with series "Add driver nodes for MT8195 SoC" and mt7986
>    pcie-nodes, dtbs_check is now clean
> ---
>   .../bindings/pci/mediatek-pcie-gen3.yaml      | 47 ++++++++++++++-----
>   1 file changed, 35 insertions(+), 12 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> index c00be39af64e..5d7369debff2 100644
> --- a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> +++ b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> @@ -43,9 +43,6 @@ description: |+
>     each set has its own address for MSI message, and supports 32 MSI vectors
>     to generate interrupt.
>   
> -allOf:
> -  - $ref: /schemas/pci/pci-bus.yaml#
> -
>   properties:
>     compatible:
>       oneOf:
> @@ -84,15 +81,7 @@ properties:
>       maxItems: 6
>   
>     clock-names:
> -    items:
> -      - const: pl_250m
> -      - const: tl_26m
> -      - const: tl_96m
> -      - const: tl_32k
> -      - const: peri_26m
> -      - enum:
> -          - top_133m        # for MT8192
> -          - peri_mem        # for MT8188/MT8195
> +    maxItems: 6
>   
>     assigned-clocks:
>       maxItems: 1
> @@ -138,6 +127,40 @@ required:
>     - '#interrupt-cells'
>     - interrupt-controller
>   
> +allOf:
> +  - $ref: /schemas/pci/pci-bus.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          const: mediatek,mt8192-pcie
> +    then:
> +      properties:
> +        clock-names:
> +          items:
> +            - const: pl_250m
> +            - const: tl_26m
> +            - const: tl_96m
> +            - const: tl_32k
> +            - const: peri_26m
> +            - const: top_133m
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - mediatek,mt8188-pcie
> +              - mediatek,mt8195-pcie
> +    then:
> +      properties:
> +        clock-names:
> +          items:
> +            - const: pl_250m
> +            - const: tl_26m
> +            - const: tl_96m
> +            - const: tl_32k
> +            - const: peri_26m
> +            - const: peri_mem
> +
>   unevaluatedProperties: false
>   
>   examples:
