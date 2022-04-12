Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FDFA4FEA3D
	for <lists+linux-pci@lfdr.de>; Wed, 13 Apr 2022 01:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229474AbiDLXSY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Apr 2022 19:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiDLXSU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Apr 2022 19:18:20 -0400
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4761605FF;
        Tue, 12 Apr 2022 15:05:49 -0700 (PDT)
Received: by mail-oi1-f177.google.com with SMTP id k13so197818oiw.1;
        Tue, 12 Apr 2022 15:05:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qiLhy5En6qOrIdw1hARFp7ZQvamsIP/5dzhc1+Si6fI=;
        b=j75vQXUcUtvIy9dkQc5F49qHb2qyMhzcL0x30FDZve8m16FQu7XYdFsjf86cirO8a1
         jmCXud2aDG+j7ipCz2WNqCxj3hi3oInw4yX2BMLwBcHb8yNdJhSjgHlwMOQ+7Q/rpEOk
         ftqahx928UQZANHPCtFVJW1kb0SfQC/Uc+rKIX6lBlfhBFYny2tYWULw/Q+9/+YqdUjm
         PsqJMgAz+UU62C55M+UcDMpWrwIxrRS0tC1Y01p1AaHLoLD9GsVYXDoELf9BiQmCXJ1V
         L0DF6/Y92fpHPufZA8B7MgOqV1E9ypqiHnd9MvnGfNRntMYd6hbFpjdrSdQ131I0+Elb
         OqVw==
X-Gm-Message-State: AOAM5330TAppQbNgZNs86R+37llgBlzMa4U9ENHiXbuHvmEw04R7W4Wx
        +qb1/6aWYcDfSJ7ApuwkrmkyzWPXKw==
X-Google-Smtp-Source: ABdhPJzipANd7lS/ByWMtonoDdO+pJ9I111+w80YFq0oVtDRmvTMiuTaB2NXYLveW1Q+1PGg3bMB9w==
X-Received: by 2002:a05:6808:238a:b0:2f7:22df:1d58 with SMTP id bp10-20020a056808238a00b002f722df1d58mr2655257oib.10.1649801148672;
        Tue, 12 Apr 2022 15:05:48 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id j16-20020a056808057000b002fa638813acsm608665oig.36.2022.04.12.15.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 15:05:48 -0700 (PDT)
Received: (nullmailer pid 1026559 invoked by uid 1000);
        Tue, 12 Apr 2022 22:05:47 -0000
Date:   Tue, 12 Apr 2022 17:05:47 -0500
From:   Rob Herring <robh@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] dt-bindings: PCI: uniphier-ep: Clean up reg,
 clocks, resets, and their names using compatible string
Message-ID: <YlX3uxZzmnb1nM/R@robh.at.kernel.org>
References: <1649294553-17310-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1649294553-17310-3-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1649294553-17310-3-git-send-email-hayashi.kunihiko@socionext.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 07, 2022 at 10:22:32AM +0900, Kunihiko Hayashi wrote:
> Instead of "oneOf:" choices, use "allOf:" and "if:" to define reg, clocks,
> resets, and their names that can be taken by the compatible string.
> 
> The order of their names doesn't change here.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  .../pci/socionext,uniphier-pcie-ep.yaml       | 84 ++++++++++++-------
>  1 file changed, 56 insertions(+), 28 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/socionext,uniphier-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/socionext,uniphier-pcie-ep.yaml
> index 437e61618d06..49a5b2ca266c 100644
> --- a/Documentation/devicetree/bindings/pci/socionext,uniphier-pcie-ep.yaml
> +++ b/Documentation/devicetree/bindings/pci/socionext,uniphier-pcie-ep.yaml
> @@ -15,9 +15,6 @@ description: |
>  maintainers:
>    - Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>  
> -allOf:
> -  - $ref: /schemas/pci/snps,dw-pcie-ep.yaml#
> -
>  properties:
>    compatible:
>      enum:
> @@ -28,41 +25,19 @@ properties:
>      minItems: 4
>      maxItems: 5
>  
> -  reg-names:
> -    oneOf:
> -      - items:
> -          - const: dbi
> -          - const: dbi2
> -          - const: link
> -          - const: addr_space
> -      - items:
> -          - const: dbi
> -          - const: dbi2
> -          - const: link
> -          - const: addr_space
> -          - const: atu

This could be just:

      minItems: 4
      items:
        - const: dbi
        - const: dbi2
        - const: link
        - const: addr_space
        - const: atu

Then the if/then can have just 'minItems: 5' or 'maxItems: 4' for each 
case. I prefer the if/then schemas to be minimal.

> +  reg-names: true
>  
>    clocks:
>      minItems: 1
>      maxItems: 2
>  
> -  clock-names:
> -    oneOf:
> -      - items:              # for Pro5
> -          - const: gio
> -          - const: link
> -      - const: link         # for NX1
> +  clock-names: true
>  
>    resets:
>      minItems: 1
>      maxItems: 2
>  
> -  reset-names:
> -    oneOf:
> -      - items:              # for Pro5
> -          - const: gio
> -          - const: link
> -      - const: link         # for NX1
> +  reset-names: true
>  
>    num-ib-windows:
>      const: 16
> @@ -78,6 +53,59 @@ properties:
>    phy-names:
>      const: pcie-phy
>  
> +allOf:
> +  - $ref: /schemas/pci/snps,dw-pcie-ep.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: socionext,uniphier-pro5-pcie-ep
> +    then:
> +      properties:
> +        reg:
> +          minItems: 4
> +          maxItems: 4
> +        reg-names:
> +          items:
> +            - const: dbi
> +            - const: dbi2
> +            - const: link
> +            - const: addr_space
> +        clocks:
> +          minItems: 2
> +          maxItems: 2
> +        clock-names:
> +          items:
> +            - const: gio
> +            - const: link
> +        resets:
> +          minItems: 2
> +          maxItems: 2
> +        reset-names:
> +          items:
> +            - const: gio
> +            - const: link
> +    else:
> +      properties:
> +        reg:
> +          minItems: 4
> +          maxItems: 5
> +        reg-names:
> +          items:
> +            - const: dbi
> +            - const: dbi2
> +            - const: link
> +            - const: addr_space
> +            - const: atu
> +        clocks:
> +          maxItems: 1
> +        clock-names:
> +          const: link
> +        resets:
> +          maxItems: 1
> +        reset-names:
> +          const: link
> +
>  required:
>    - compatible
>    - reg
> -- 
> 2.25.1
> 
> 
