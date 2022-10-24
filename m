Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5C860BBEF
	for <lists+linux-pci@lfdr.de>; Mon, 24 Oct 2022 23:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbiJXVSm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Oct 2022 17:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233999AbiJXVSX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Oct 2022 17:18:23 -0400
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1075357E1;
        Mon, 24 Oct 2022 12:24:38 -0700 (PDT)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-13b103a3e5dso13028511fac.2;
        Mon, 24 Oct 2022 12:24:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vqLHNCC4h3WefblPd4YUovHfNe5etB8EwtpDxyh2rNg=;
        b=wzi8euRnhAA1EdmwU3Q2/xYWlC+fk8VExj1JthqCgUfw2dTqoVhlZ7+/4g3FDrnVKn
         pyZYikoEqH7C3cD/b9CaZdW+c4o8ysbHUJyYc/eBDokNmHbHM/syLFuJNoY94lSo6Ks6
         2q7TaiSO3K8Qjv3t/w51rXNciTTvjw1w6tfgStuQPXCQG7NmnEkrI+rjI4hM53FJtGB/
         ErbIYdSB2vsRDe3tuwaCm2ojOBz9VWel1KDfnjdqio68urfLRnzKNkop8JzLMTp7lCo7
         pXTROgD+ja2gGfOLeaVe7yyv/leKS398LHwolxpbXW56Q+ncsxgE6d1gYKiBwH0EHnht
         V1zA==
X-Gm-Message-State: ACrzQf0qldZ/05ZRRciHj7bRQl4BQKW52LZTzwkg8IkBGtH5jtk+G4CL
        3Hv4n1pOWnjt/dUEPhB0FQ==
X-Google-Smtp-Source: AMsMyM5ai7TBx2hq9Yw2a73b9Dx0NsSpGKlCAqRK1rsVAwL1TyUeCKFTJoiykMmsw8LzRorV6iZ2tQ==
X-Received: by 2002:a05:6870:2054:b0:132:d1fb:ddf0 with SMTP id l20-20020a056870205400b00132d1fbddf0mr39306295oad.283.1666639392419;
        Mon, 24 Oct 2022 12:23:12 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id u4-20020a4ac984000000b004768f725b7csm332279ooq.23.2022.10.24.12.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 12:23:11 -0700 (PDT)
Received: (nullmailer pid 2071537 invoked by uid 1000);
        Mon, 24 Oct 2022 19:23:13 -0000
Date:   Mon, 24 Oct 2022 14:23:13 -0500
From:   Rob Herring <robh@kernel.org>
To:     Frank Wunderlich <linux@fw-web.de>
Cc:     linux-mediatek@lists.infradead.org,
        Frank Wunderlich <frank-w@public-files.de>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Sam Shih <Sam.Shih@mediatek.com>,
        Steven Liu <steven.liu@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/3] dt-bindings: PCI: mediatek-gen3: add mt7986 clock
 config
Message-ID: <20221024192313.GA2069519-robh@kernel.org>
References: <20221023170234.83621-1-linux@fw-web.de>
 <20221023170234.83621-4-linux@fw-web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221023170234.83621-4-linux@fw-web.de>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Oct 23, 2022 at 07:02:34PM +0200, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> MT7986 needs 4 clocks for PCIe, define them in binding.

Patch 2 is incomplete without this one. Therefore, patch 2 and 3 should 
be 1 patch.

> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
>  .../bindings/pci/mediatek-pcie-gen3.yaml         | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> index 3662422b38ea..e6020e684c00 100644
> --- a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> +++ b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> @@ -79,9 +79,11 @@ properties:
>        - const: mac
>  
>    clocks:
> +    minItems: 4
>      maxItems: 6
>  
>    clock-names:
> +    minItems: 4
>      maxItems: 6
>  
>    assigned-clocks:
> @@ -162,6 +164,20 @@ allOf:
>              - const: tl_32k
>              - const: peri_26m
>              - const: peri_mem
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
>  unevaluatedProperties: false
>  
> -- 
> 2.34.1
> 
> 
