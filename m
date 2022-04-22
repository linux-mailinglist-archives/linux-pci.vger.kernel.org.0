Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 636F550B7B0
	for <lists+linux-pci@lfdr.de>; Fri, 22 Apr 2022 14:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233528AbiDVM6W (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Apr 2022 08:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233921AbiDVM6U (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Apr 2022 08:58:20 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 104C556C18
        for <linux-pci@vger.kernel.org>; Fri, 22 Apr 2022 05:55:27 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id y21so3429302edo.2
        for <linux-pci@vger.kernel.org>; Fri, 22 Apr 2022 05:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=6vgHlzcKC268jTWZ9odOWX/FSZ6GN/04Cms2yj6NXO8=;
        b=a1of9vQz8vasCH1atiME1s6g4QTTKaL+N5yYSEejqN2v3DuJ4CrAnnWhx0wYeTM4AY
         ZCYFvp9rFBHMjEXH69F4Z4RH9dt9HIwhdSg9Wp6TspiZKSjvq+XRHwkotIr9OjX20h4Y
         hLO2nAP2K1myaVpARQtg4KEJ4vZTst8cjtgzLs/BfCWidJGHDTnow79aRsNO0QtlPp5O
         +ihdtjzHfsHJljhmO2nSAMtqQcQFUb0E8MdzkjUm6kvlZvgTJp5mixobudVqprgDxX9g
         rBtYpZLiiUiYU7FPVazTF2JmXvCAMukEHS9h2kDTAE8UIS+pxw0yfT+UlRDkhHNtoYyC
         uapA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6vgHlzcKC268jTWZ9odOWX/FSZ6GN/04Cms2yj6NXO8=;
        b=FOJde4qHcJ+mKsOtrAi2pLSeRC21YTi9fqd31lCIluJNgH936w7urjpxhoenhmFfWm
         DS7VleG6Iur+Y/ToFeYwHB/wOVjQipUj6k4OMKrv0KZ8H97h3zOfIEEOYDmVeKrSwREL
         iVqBostE8aGakeQP9IbFWndQ5KcybWleaCV8mcafBy/oqJUZOI7L1hB88euZXRXee2FV
         WxDsp8MFakTUmaBAK8apmktuhz13oTvwDIkQo38bSEyz9Pby5UAhGcxxvfhMINdi1L6R
         1BO9iYgqMuEPQmfZ2nkBwxljHbbHKQB0AaNz9LqhRr9J8Oj6dn6PyVPTAlUfLA21j3YF
         K/cg==
X-Gm-Message-State: AOAM531JGoxDREWXRM98C5QzX7c2ABVhGm6eVIWTmZpegbYEWEBpLN1c
        zXZPgUPA5CGMg/lWAB+IudY+2yO+rQ3gxA==
X-Google-Smtp-Source: ABdhPJzI1Jcy6wmQ4Uw+AZ385Sm2PGtBq4LI0ya6/KbcNmsbCsgd6VEPxn3uSUPGBvEd583NfftG6g==
X-Received: by 2002:a05:6402:1581:b0:41d:9b15:1432 with SMTP id c1-20020a056402158100b0041d9b151432mr4804679edv.386.1650632125571;
        Fri, 22 Apr 2022 05:55:25 -0700 (PDT)
Received: from [192.168.0.232] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id g9-20020aa7c849000000b00412fc6bf26dsm876417edt.80.2022.04.22.05.55.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Apr 2022 05:55:25 -0700 (PDT)
Message-ID: <fe9c5691-caa1-79b4-666b-daac8913b546@linaro.org>
Date:   Fri, 22 Apr 2022 14:55:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 3/6] dt-bindings: pci/qcom-pcie: specify reg-names
 explicitly
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Vinod Koul <vkoul@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20220422114841.1854138-1-dmitry.baryshkov@linaro.org>
 <20220422114841.1854138-4-dmitry.baryshkov@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220422114841.1854138-4-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 22/04/2022 13:48, Dmitry Baryshkov wrote:
> Instead of specifying the enum of possible reg-names, specify them
> explicitly. This allows us to specify which chipsets need the "atu"
> regions, which do not. Also it clearly describes which platforms
> enumerate PCIe cores using the dbi region and which use parf region for
> that.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  .../devicetree/bindings/pci/qcom,pcie.yaml    | 96 ++++++++++++++++---
>  1 file changed, 81 insertions(+), 15 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> index 7210057d1511..e78e63ea4b25 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> @@ -35,21 +35,6 @@ properties:
>            - qcom,pcie-ipq6018
>        - const: snps,dw-pcie
>  
> -  reg:
> -    minItems: 4
> -    maxItems: 5

This should stay.

> -
> -  reg-names:
> -    minItems: 4
> -    maxItems: 5
> -    items:
> -      enum:
> -        - parf # Qualcomm specific registers
> -        - dbi # DesignWare PCIe registers
> -        - elbi # External local bus interface registers
> -        - config # PCIe configuration space
> -        - atu # ATU address space (optional)

Move one of your lists for specific compatibles here and name last
element optional (minItems: 4).

You will need to fix the order of regs in DTS to match the one defined here.

> -
>    interrupts:
>      maxItems: 1
>  
> @@ -108,6 +93,87 @@ required:
>  
>  allOf:
>    - $ref: /schemas/pci/pci-bus.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,pcie-apq8064
> +              - qcom,pcie-ipq4019
> +              - qcom,pcie-ipq8064
> +              - qcom,pcie-ipq8064v2
> +              - qcom,pcie-ipq8074
> +              - qcom,pcie-qcs404
> +    then:
> +      properties:
> +        reg:
> +          minItems: 4
> +          maxItems: 4

Only maxItems: 4

> +        reg-names:
> +          items:
> +            - const: dbi # DesignWare PCIe registers
> +            - const: elbi # External local bus interface registers
> +            - const: parf # Qualcomm specific registers
> +            - const: config # PCIe configuration space

No need for this, instead only maxItems:4

> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,pcie-ipq6018
> +    then:
> +      properties:
> +        reg:
> +          minItems: 5
> +          maxItems: 5

Only minItems:5 should be needed.

> +        reg-names:
> +          items:
> +            - const: dbi # DesignWare PCIe registers
> +            - const: elbi # External local bus interface registers
> +            - const: atu # ATU address space (optional)
> +            - const: parf # Qualcomm specific registers
> +            - const: config # PCIe configuration space

This can be removed.

All other cases should be merged with the ones here.

Best regards,
Krzysztof
