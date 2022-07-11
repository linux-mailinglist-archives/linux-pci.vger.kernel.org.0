Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25E24570AAE
	for <lists+linux-pci@lfdr.de>; Mon, 11 Jul 2022 21:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbiGKT0Z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Jul 2022 15:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiGKT0Z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Jul 2022 15:26:25 -0400
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 974BB6111C;
        Mon, 11 Jul 2022 12:26:24 -0700 (PDT)
Received: by mail-il1-f171.google.com with SMTP id h16so3604217ila.2;
        Mon, 11 Jul 2022 12:26:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q2aRCRjRGyUgPo+G8hd6HpXzcYfE+IlRWWwImwreJk8=;
        b=wv/KbNH2HUhORUE2HSgFm+N2v4FeqEKxaMiLlpaOxlADD+Rw4IeuyoC+xlX7Ee8SVC
         q29OJnX/7g7tp6UW5fPDqucgfMryasQ17fyDROWACRNlLsOm637AYgGfjXh3e3LF8K27
         WfczH81bKNI/rWlSZJL8z584Z6zdwwTSm4OUTZ26x5n8cX6j0gsG2YEsbbv00O/ZD6H4
         8oVJvdnT6PuNZ3nR2KREjVgs71U8AmxyAEFI2I338K4XXudxj9KWgu926L2h+vYnWaS3
         Qj+ZdOGoODBZ088uMdynwtSslmHTePylyEGi9ie3T9kqtvjCGgONr93ogN065lCvXh6z
         Akmg==
X-Gm-Message-State: AJIora9EliANDdo98JWiXlkamNXemkYCcNhTDG7W64bBI/aS75mOJXxJ
        Sl1Bs18UY7QAMvEWbQZBs3Hx89Gqkw==
X-Google-Smtp-Source: AGRyM1sYH/LG1i3UL0ff3cLaldCuJMLyEGkqcs3UZdbpFvA+i3cdZaMCtHc9ABQVz95SQrNlib05Cg==
X-Received: by 2002:a05:6e02:1b01:b0:2dc:7472:a5d1 with SMTP id i1-20020a056e021b0100b002dc7472a5d1mr5001915ilv.62.1657567583828;
        Mon, 11 Jul 2022 12:26:23 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id v27-20020a02b09b000000b0032e0851ea0fsm3250398jah.10.2022.07.11.12.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 12:26:23 -0700 (PDT)
Received: (nullmailer pid 133532 invoked by uid 1000);
        Mon, 11 Jul 2022 19:26:21 -0000
Date:   Mon, 11 Jul 2022 13:26:21 -0600
From:   Rob Herring <robh@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     bhelgaas@google.com, lpieralisi@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, kw@linux.com, kishon@ti.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V4 2/9] dt-bindings: PCI: tegra234: Add schema for
 tegra234 rootport mode
Message-ID: <20220711192621.GA126971-robh@kernel.org>
References: <20220707081301.29961-1-vidyas@nvidia.com>
 <20220707081301.29961-3-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220707081301.29961-3-vidyas@nvidia.com>
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

On Thu, Jul 07, 2022 at 01:42:54PM +0530, Vidya Sagar wrote:
> Add support for PCIe controllers that operate in the rootport mode
> in tegra234 chipset.
> 
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
> V4:
> * Rebased on top of previous patch
> 
> V3:
> * New patch in this series
> 
>  .../bindings/pci/nvidia,tegra194-pcie.yaml    | 136 +++++++++++++++++-
>  1 file changed, 130 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml
> index 5d7cb56c86a2..c0dfe2e01112 100644
> --- a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml
> @@ -24,6 +24,7 @@ properties:
>    compatible:
>      enum:
>        - nvidia,tegra194-pcie
> +      - nvidia,tegra234-pcie
>  
>    reg:
>      items:
> @@ -92,7 +93,8 @@ properties:
>        A phandle to the node that controls power to the respective PCIe
>        controller and a specifier name for the PCIe controller.
>  
> -      specifiers are defined in "include/dt-bindings/power/tegra194-powergate.h" file.
> +      Tegra194 specifiers are defined in "include/dt-bindings/power/tegra194-powergate.h" file.
> +      Tegra234 specifiers are defined in "include/dt-bindings/power/tegra234-powergate.h" file.
>  
>    interconnects:
>      items:
> @@ -112,17 +114,30 @@ properties:
>        Must contain a pair of phandle to BPMP controller node followed by
>        controller ID. Following are the controller IDs for each controller:
>  
> +      Tegra194
> +
>          0: C0
>          1: C1
>          2: C2
>          3: C3
>          4: C4
>          5: C5
> -    items:
> -      - items:
> -          - description: phandle to BPMP controller node
> -          - description: PCIe controller ID
> -            maximum: 5
> +
> +      Tegra234
> +
> +        0 : C0
> +        1 : C1
> +        2 : C2
> +        3 : C3
> +        4 : C4
> +        5 : C5
> +        6 : C6
> +        7 : C7
> +        8 : C8
> +        9 : C9
> +        10: C10
> +
> +      Platform constraints are described later
>  
>    nvidia,update-fc-fixup:
>      description: |
> @@ -131,6 +146,8 @@ properties:
>        of the following conditions thereby enabling root port to exchange
>        optimum number of FC (Flow Control) credits with downstream devices:
>  
> +      NOTE:- This is applicable only for Tegra194.
> +
>          1. If C0/C4/C5 run at x1/x2 link widths (irrespective of speed and MPS)
>          2. If C0/C1/C2/C3/C4/C5 operate at their respective max link widths and
>            a) speed is Gen-2 and MPS is 256B
> @@ -162,10 +179,56 @@ properties:
>        if the platform has one such slot. (Ex:- x16 slot owned by C5 controller
>        in p2972-0000 platform).
>  
> +  nvidia,enable-srns:
> +    description: |
> +      This boolean property needs to be present if the controller is configured
> +      to operate in SRNS (Separate Reference Clocks with No Spread-Spectrum Clocking).
> +      NOTE:- This is applicable only for Tegra234.
> +
> +    $ref: /schemas/types.yaml#/definitions/flag
> +
> +  nvidia,enable-ext-refclk:
> +    description: |
> +      This boolean property needs to be present if the controller is configured
> +      to use the reference clocking coming in from an external clock source instead of
> +      using the internal clock source.
> +
> +    $ref: /schemas/types.yaml#/definitions/flag
> +
>  allOf:
>    - $ref: /schemas/pci/pci-bus.yaml#
>    - $ref: /schemas/pci/snps,dw-pcie.yaml#
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - nvidia,tegra194-pcie
> +    then:
> +      properties:
> +        nvidia,bpmp:
> +          items:
> +            - items:
> +                - description: phandle to BPMP controller node
> +                - description: PCIe controller ID
> +                  maximum: 5
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - nvidia,tegra234-pcie
> +    then:
> +      properties:
> +        nvidia,bpmp:
> +          items:
> +            - items:
> +                - description: phandle to BPMP controller node
> +                - description: PCIe controller ID
> +                  maximum: 10

I don't think this works because you still have a limit of 5 in the 
definition of nvidia,bpmp. I would just change it's limit to 10 and drop 
these if/then schemas. I don't think the extra checking is really worth 
it.

Rob
