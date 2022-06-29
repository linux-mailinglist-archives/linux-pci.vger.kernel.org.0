Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C43E560271
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jun 2022 16:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbiF2OVJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jun 2022 10:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbiF2OVJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jun 2022 10:21:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455DC1B7AD;
        Wed, 29 Jun 2022 07:21:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D1E3060F6A;
        Wed, 29 Jun 2022 14:21:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26B52C34114;
        Wed, 29 Jun 2022 14:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656512467;
        bh=OYKzPYxHTOMiN4mNEQ3kYHayFya3umGiQznKSLxwEz8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SX4DDeafZB2Em2q9yBygWmXs80vIeocbXTcr9hjy9ft9NrMM+2KpboJNjLtQ36K5L
         slD4RlDhWfbmFcN7LC8IjGeLRWolnsvj1rSKMAgF715T7gzLqfS+5daLiEcVUMsW5l
         xd0sg/iRH3T5KFh6OYf4lJiJTyppvcmE+M3O2NeD6UgqICqtEJyQe5swfqfi9RIvKA
         YjSbfslE8IB3ZkaCyNcCEMHnGh9W0UyA3lN24AxUFtnuQq/+1W8mYj4EsNoGAo6Leh
         Ykt7uym+0rxbrk7VEUxwMSWHL8KAcq9BX99yfyktImjRIIzfOuPgR3w4nSvrb4koVF
         ti3WQC6Arut8Q==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1o6YYz-0004rF-U8; Wed, 29 Jun 2022 16:21:06 +0200
Date:   Wed, 29 Jun 2022 16:21:05 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v15 5/7] dt-bindings: PCI: qcom: Support additional MSI
 interrupts
Message-ID: <Yrxf0QANRAeLCVAU@hovoldconsulting.com>
References: <20220620112015.1600380-1-dmitry.baryshkov@linaro.org>
 <20220620112015.1600380-6-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220620112015.1600380-6-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 20, 2022 at 02:20:13PM +0300, Dmitry Baryshkov wrote:
> On Qualcomm platforms each group of 32 MSI vectors is routed to the
> separate GIC interrupt. Document mapping of additional interrupts.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  .../devicetree/bindings/pci/qcom,pcie.yaml    | 51 +++++++++++++++++--
>  1 file changed, 48 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> index 0b69b12b849e..7e84063afe25 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> @@ -43,11 +43,12 @@ properties:
>      maxItems: 5
>  
>    interrupts:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 8
>  
>    interrupt-names:
> -    items:
> -      - const: msi
> +    minItems: 1
> +    maxItems: 8
>  
>    # Common definitions for clocks, clock-names and reset.
>    # Platform constraints are described later.
> @@ -623,6 +624,50 @@ allOf:
>          - resets
>          - reset-names
>  
> +    # On newer chipsets support either 1 or 8 msi interrupts
> +    # On older chipsets it's always 1 msi interrupt
> +  - if:
> +      properties:
> +        compatibles:

This conditional always evaluates to false due to the typo in the
property name here (plural "compatibles").

I've just posted a fix for this (and another bug just like it) as part
of a series that depends on this series:

	https://lore.kernel.org/all/20220629141000.18111-1-johan+linaro@kernel.org/

Not sure if you need to respin a v16 just for this but otherwise it
could be folded in here.

> +          contains:
> +            enum:
> +              - qcom,pcie-msm8996
> +              - qcom,pcie-sc7280
> +              - qcom,pcie-sc8180x
> +              - qcom,pcie-sdm845
> +              - qcom,pcie-sm8150
> +              - qcom,pcie-sm8250
> +              - qcom,pcie-sm8450-pcie0
> +              - qcom,pcie-sm8450-pcie1
> +    then:
> +      oneOf:
> +        - properties:
> +            interrupts:
> +              maxItems: 1
> +            interrupt-names:
> +              items:
> +                - const: msi
> +        - properties:
> +            interrupts:
> +              minItems: 8
> +            interrupt-names:
> +              items:
> +                - const: msi0
> +                - const: msi1
> +                - const: msi2
> +                - const: msi3
> +                - const: msi4
> +                - const: msi5
> +                - const: msi6
> +                - const: msi7
> +    else:
> +      properties:
> +        interrupts:
> +          maxItems: 1
> +        interrupt-names:
> +          items:
> +            - const: msi
> +
>  unevaluatedProperties: false
>  
>  examples:

Johan
