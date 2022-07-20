Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4007257C000
	for <lists+linux-pci@lfdr.de>; Thu, 21 Jul 2022 00:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbiGTWYx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Jul 2022 18:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiGTWYw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Jul 2022 18:24:52 -0400
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4AAE43E76;
        Wed, 20 Jul 2022 15:24:50 -0700 (PDT)
Received: by mail-io1-f46.google.com with SMTP id y2so15456129ior.12;
        Wed, 20 Jul 2022 15:24:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Jimy4V1nUGJyZ9u+Dj99DopEP3pRUApHSD/GLN4AMmg=;
        b=jIHS4ybC9zpNajBJx54/e8dwY2IlN+1nvJNBclcxABk2AnPifjaatcUl/TYnyM1g64
         i0LDp5tIYUJ7MVzxVbFzuH6ROGeJXWfg9gcObHastrdL1F+OmHjtCNyUI/LosRDvgg1q
         nqUGAFDKmMmItVXOZ1DhaNAFdcqZlqpr1inLX4piHs2A3LR4ZKsvQYDnIOEWMMv+CjLM
         fF5W62nuiVDVM5vRTI1benn9QGUFqZlBZ7mCl5fsq5PeQx04QlMbVKkbAqKHoYUvsudk
         Tn49V1MyGXuuRYxPAgKj/p94NlyqpjKnozKt338Ybmci7TZegjzAQ1BZnk41tUQ5R3wu
         oVGw==
X-Gm-Message-State: AJIora+iBZsp58dJ9026tv5E9bVLkBru984HJvnnp0yOH2N7iKkczQl0
        nfAST6p/fvwynJ5+vLsKMQ==
X-Google-Smtp-Source: AGRyM1sWYsUEabacHZSH2oMcZFw7tDZ5CPWOw5X+UvmaH7kUKyTq2euwNHlUXCeHEgjsImPt7Rb9JQ==
X-Received: by 2002:a05:6638:4813:b0:33f:27bf:f6fa with SMTP id cp19-20020a056638481300b0033f27bff6famr20388764jab.42.1658355890085;
        Wed, 20 Jul 2022 15:24:50 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id f19-20020a056638113300b0033f3ab94271sm37469jar.139.2022.07.20.15.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 15:24:49 -0700 (PDT)
Received: (nullmailer pid 4089645 invoked by uid 1000);
        Wed, 20 Jul 2022 22:24:48 -0000
Date:   Wed, 20 Jul 2022 16:24:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jianjun Wang <jianjun.wang@mediatek.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ryder Lee <ryder.lee@mediatek.com>, Rex-BC.Chen@mediatek.com,
        TingHan.Shen@mediatek.com, Liju-clr.Chen@mediatek.com,
        Jian.Yang@mediatek.com
Subject: Re: [PATCH 2/2] dt-bindings: PCI: mediatek-gen3: Add new clock name
Message-ID: <20220720222448.GA4083816-robh@kernel.org>
References: <20220716074349.28655-1-jianjun.wang@mediatek.com>
 <20220716074349.28655-3-jianjun.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220716074349.28655-3-jianjun.wang@mediatek.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Jul 16, 2022 at 03:43:49PM +0800, Jianjun Wang wrote:
> MT8188 and MT8195 use clock "peri_mem" instead of "top_133m", add new
> clock name "peri_mem" for MT8188 and MT8195.

This should be part of patch 1.

Clock names for IP blocks should be local to the IP block. IOW, named 
after the input name for the clocks or what their function is if you 
don't know that. Neither the old names nor the new name seem to follow 
this. At least make the new name follow that convention.

> 
> Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
> ---
>  .../bindings/pci/mediatek-pcie-gen3.yaml      | 42 ++++++++++++++-----
>  1 file changed, 32 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> index 67d2ba25e336..038e25ae0be7 100644
> --- a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> +++ b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> @@ -43,9 +43,6 @@ description: |+
>    each set has its own address for MSI message, and supports 32 MSI vectors
>    to generate interrupt.
>  
> -allOf:
> -  - $ref: /schemas/pci/pci-bus.yaml#
> -
>  properties:
>    compatible:
>      oneOf:
> @@ -85,13 +82,7 @@ properties:
>      maxItems: 6
>  
>    clock-names:
> -    items:
> -      - const: pl_250m
> -      - const: tl_26m
> -      - const: tl_96m
> -      - const: tl_32k
> -      - const: peri_26m
> -      - const: top_133m
> +    maxItems: 6
>  
>    assigned-clocks:
>      maxItems: 1
> @@ -133,9 +124,40 @@ required:
>    - interrupts
>    - ranges
>    - clocks
> +  - clock-names
>    - '#interrupt-cells'
>    - interrupt-controller
>  
> +allOf:
> +  - $ref: /schemas/pci/pci-bus.yaml#
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
> +    else:
> +      properties:
> +        clock-names:
> +          items:
> +            - const: pl_250m
> +            - const: tl_26m
> +            - const: tl_96m
> +            - const: tl_32k
> +            - const: peri_26m
> +            - const: top_133m
> +
>  unevaluatedProperties: false
>  
>  examples:
> -- 
> 2.18.0
> 
> 
