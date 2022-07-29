Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E41B5856F7
	for <lists+linux-pci@lfdr.de>; Sat, 30 Jul 2022 00:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbiG2Wxh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Jul 2022 18:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232195AbiG2WxY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Jul 2022 18:53:24 -0400
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB9D583F35;
        Fri, 29 Jul 2022 15:53:23 -0700 (PDT)
Received: by mail-io1-f51.google.com with SMTP id e69so4655063iof.5;
        Fri, 29 Jul 2022 15:53:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=qdPiZGCx2gOg+Z8f5WWlV+ALjDbF5Hu969TqFhTswc8=;
        b=v1qSuFOxS34jl27PtbSR+wiKmL48jw+uYZ1bTR7QkEd7dcNyLhCSjrAZqtu6dsXX9N
         xMPjNayJQ1P73TNo4ZlD7K3/Zm0F2SOi1E9C5H4T8TNnUcttX9h5oIh7tQRcCfF9fRsW
         O0zw2q2ntdZgazLnzhxADRw5tX2meLfD0s13J049qdtd2ScuP+nTNrm/psy/1Dv44a30
         azVsZMkirn1ZiVDaDcljF36N+dHhWdruGyuIuyL/2hphJUZAZMt+aucx8YSxbeN9KWjX
         P2PvP/Y6a/J+ntSbKm+xkNP0fPP3udgfdXR5yyf9ZugJBxHvta5VU03NBOz8E8gbwEvd
         XmKg==
X-Gm-Message-State: AJIora9G4Y2H+CEzY27UOU+Pmv3xThPoVxKF9Gsc7x4nyn5sBG08EDNz
        +DeZCLy3c6wNnJ8fTQjhKw==
X-Google-Smtp-Source: AGRyM1tVKy42bKeKa7Lz5BjK7FPG39AaKdNNz7b3gF69f/Zl3T81ORLeG5jHeetLJGrjQH3iD0lfEQ==
X-Received: by 2002:a5e:a618:0:b0:67c:27b4:1f93 with SMTP id q24-20020a5ea618000000b0067c27b41f93mr1846960ioi.75.1659135202913;
        Fri, 29 Jul 2022 15:53:22 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id r1-20020a92c5a1000000b002ddd1e250c0sm1994579ilt.5.2022.07.29.15.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 15:53:22 -0700 (PDT)
Received: (nullmailer pid 87726 invoked by uid 1000);
        Fri, 29 Jul 2022 22:53:20 -0000
Date:   Fri, 29 Jul 2022 16:53:20 -0600
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
Subject: Re: [PATCH v2] dt-bindings: PCI: mediatek-gen3: Add support for
 MT8188 and MT8195
Message-ID: <20220729225320.GA82746-robh@kernel.org>
References: <20220729033331.3075-1-jianjun.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220729033331.3075-1-jianjun.wang@mediatek.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 29, 2022 at 11:33:31AM +0800, Jianjun Wang wrote:
> MT8188 and MT8195 are ARM platform SoCs with the same PCIe IP as MT8192.
> 
> Also add new clock name "peri_mem" since the MT8188 and MT8195 use clock
> "peri_mem" instead of "top_133m".
> 
> Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
> ---
> Changes in v2:
> Merge two patches into one.
> ---
>  .../bindings/pci/mediatek-pcie-gen3.yaml      | 51 +++++++++++++++----
>  1 file changed, 40 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> index 0499b94627ae..038e25ae0be7 100644
> --- a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> +++ b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> @@ -43,12 +43,16 @@ description: |+
>    each set has its own address for MSI message, and supports 32 MSI vectors
>    to generate interrupt.
>  
> -allOf:
> -  - $ref: /schemas/pci/pci-bus.yaml#
> -
>  properties:
>    compatible:
> -    const: mediatek,mt8192-pcie
> +    oneOf:
> +      - items:
> +          - enum:
> +              - mediatek,mt8188-pcie
> +              - mediatek,mt8195-pcie
> +          - const: mediatek,mt8192-pcie
> +      - items:
> +          - const: mediatek,mt8192-pcie
>  
>    reg:
>      maxItems: 1
> @@ -78,13 +82,7 @@ properties:
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
> @@ -126,9 +124,40 @@ required:
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

I'm not sure it's worth enforcing just the last clock name. Just do:

enum: [ peri_mem, top_133m ]

And key in the top level.

Rob
