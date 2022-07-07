Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24C3A569C8F
	for <lists+linux-pci@lfdr.de>; Thu,  7 Jul 2022 10:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235158AbiGGIGD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Jul 2022 04:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235151AbiGGIGB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Jul 2022 04:06:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1082133A1A;
        Thu,  7 Jul 2022 01:06:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C19761EF9;
        Thu,  7 Jul 2022 08:06:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B450EC341C0;
        Thu,  7 Jul 2022 08:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657181159;
        bh=8HhI9xWrGYoIGVcKzmnwY5opn+oK3onvMh6g217ucv8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AWpTfxvfa0L56XFPwKwDAFNhSom2vIc+LLeo+liS+J0uw+zrjd8+X98UN/yWlnGaT
         ASTm1t+9MO69dKvv+qlS8iG3IPlsOlaEY1uognIlqseNbsHIMssfTA6u8vnxxov+yF
         405K5I0zZHlkep+z0JGCqolID+0I+fwIe9SHGKnjK0VuWsws8ZOHN6a1fNCo/8GE9O
         7oNwpisfgcUeEW/VXUkmOA+dOwBnDP0VVe8iaEqF2UqqVrNR3ku7VAJ+/elWVner7+
         Y5a3swfgc+7/8GbNGNuLqqa0j78nlUWvNitr/YFzgUOHP9gae4smcTq3hDOA9ySq5s
         BFkR8zm3p4Dtw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1o9MWP-0004rC-JQ; Thu, 07 Jul 2022 10:06:01 +0200
Date:   Thu, 7 Jul 2022 10:06:01 +0200
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
Subject: Re: [PATCH v16 5/6] dt-bindings: PCI: qcom: Support additional MSI
 interrupts
Message-ID: <YsaT6fzySULqFt33@hovoldconsulting.com>
References: <20220704152746.807550-1-dmitry.baryshkov@linaro.org>
 <20220704152746.807550-6-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220704152746.807550-6-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 04, 2022 at 06:27:45PM +0300, Dmitry Baryshkov wrote:
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
> index c40ba753707c..ee5414522e3c 100644
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

This still has the misspelled property name here (plural s) so the
conditional is always false.

I know I included a fix for this in my follow-on series, but if you are
respinning the series anyway you should fix it up.

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
