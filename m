Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29431614005
	for <lists+linux-pci@lfdr.de>; Mon, 31 Oct 2022 22:40:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiJaVk5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Oct 2022 17:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiJaVk4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Oct 2022 17:40:56 -0400
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 864D513F3F;
        Mon, 31 Oct 2022 14:40:55 -0700 (PDT)
Received: by mail-oi1-f175.google.com with SMTP id m204so2409239oib.6;
        Mon, 31 Oct 2022 14:40:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mlMMIdkObfUr9qYTCNdNHOKuPcSUCkYHWNEEbcfJk5c=;
        b=7ZXv93DZmaOR5Vdq9ngVBfTyBwi19HMOJ17+Mpt09sxzl/QOfvztlqKOZEyErFBW5m
         ggRwHLpbjmZHdTvonhxmWodViZmKw0DDG7AxM+vGSYGSbyYNGj5hwutGBIMrtEfxV7nu
         Hjpdg/jEnQvfDTju6r2B+qF1R8x9B3ERk+5nqlzmm6BH0PsiBlPMShHyKAD/BSpr/pVS
         mKrmhY82zQsVNgmGfgy5xoGAbMfbWMOfOrRKZL6LTZrbJPWiIR/iq7c7F8r8QHydbgVQ
         B+dXMxmYYMet8IKLK//3dMbVyKtF6EEqN7Kjnf2HhCoXo64DLQ6YZIYGrPuOdwsAScHE
         IM8A==
X-Gm-Message-State: ACrzQf0dbq3cWW7Ru72mLTtJFNBnQfSiroofk82fb1N4dl4aXHwOI0e+
        8oAiC/x1S4rMq5Wu0F70zg==
X-Google-Smtp-Source: AMsMyM4KDTKdv5e5Ppj8ZC5PVriR1NmIcUbAeITff06//T8brlplI5BWCZLdZdgGfaJONAUZpSnFTQ==
X-Received: by 2002:a05:6808:1708:b0:351:6d9b:a957 with SMTP id bc8-20020a056808170800b003516d9ba957mr16671124oib.70.1667252454726;
        Mon, 31 Oct 2022 14:40:54 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id be27-20020a056808219b00b00339befdfad0sm2740916oib.50.2022.10.31.14.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 14:40:54 -0700 (PDT)
Received: (nullmailer pid 3617874 invoked by uid 1000);
        Mon, 31 Oct 2022 21:40:55 -0000
Date:   Mon, 31 Oct 2022 16:40:55 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v1 1/7] dt-bindings: PCI: qcom: Add sm8350 to bindings
Message-ID: <20221031214055.GA3613285-robh@kernel.org>
References: <20221029211312.929862-1-dmitry.baryshkov@linaro.org>
 <20221029211312.929862-2-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221029211312.929862-2-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Oct 30, 2022 at 12:13:06AM +0300, Dmitry Baryshkov wrote:
> Add bindings for two PCIe hosts on SM8350 platform. The only difference
> between them is in the aggre0 clock, which warrants the oneOf clause for
> the clocks properties.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  .../devicetree/bindings/pci/qcom,pcie.yaml    | 54 +++++++++++++++++++
>  1 file changed, 54 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> index 54f07852d279..55bf5958ef79 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> @@ -32,6 +32,7 @@ properties:
>        - qcom,pcie-sdm845
>        - qcom,pcie-sm8150
>        - qcom,pcie-sm8250
> +      - qcom,pcie-sm8350
>        - qcom,pcie-sm8450-pcie0
>        - qcom,pcie-sm8450-pcie1
>        - qcom,pcie-ipq6018
> @@ -185,6 +186,7 @@ allOf:
>                - qcom,pcie-sc8180x
>                - qcom,pcie-sc8280xp
>                - qcom,pcie-sm8250
> +              - qcom,pcie-sm8350
>                - qcom,pcie-sm8450-pcie0
>                - qcom,pcie-sm8450-pcie1
>      then:
> @@ -540,6 +542,57 @@ allOf:
>            items:
>              - const: pci # PCIe core reset
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,pcie-sm8350
> +    then:
> +      oneOf:
> +          # Unfortunately the "optional" ref clock is used in the middle of the list
> +        - properties:
> +            clocks:
> +              maxItems: 13
> +            clock-names:
> +              items:
> +                - const: pipe # PIPE clock
> +                - const: pipe_mux # PIPE MUX
> +                - const: phy_pipe # PIPE output clock
> +                - const: ref # REFERENCE clock
> +                - const: aux # Auxiliary clock
> +                - const: cfg # Configuration clock
> +                - const: bus_master # Master AXI clock
> +                - const: bus_slave # Slave AXI clock
> +                - const: slave_q2a # Slave Q2A clock
> +                - const: tbu # PCIe TBU clock
> +                - const: ddrss_sf_tbu # PCIe SF TBU clock
> +                - const: aggre0 # Aggre NoC PCIe0 AXI clock

'enum: [ aggre0, aggre1 ]' and 'minItems: 12' would eliminate the 2nd 
case. There's a implicit requirement that string names are unique (by 
default).

> +                - const: aggre1 # Aggre NoC PCIe1 AXI clock
> +        - properties:
> +            clocks:
> +              maxItems: 12
> +            clock-names:
> +              items:
> +                - const: pipe # PIPE clock
> +                - const: pipe_mux # PIPE MUX
> +                - const: phy_pipe # PIPE output clock
> +                - const: ref # REFERENCE clock
> +                - const: aux # Auxiliary clock
> +                - const: cfg # Configuration clock
> +                - const: bus_master # Master AXI clock
> +                - const: bus_slave # Slave AXI clock
> +                - const: slave_q2a # Slave Q2A clock
> +                - const: tbu # PCIe TBU clock
> +                - const: ddrss_sf_tbu # PCIe SF TBU clock
> +                - const: aggre1 # Aggre NoC PCIe1 AXI clock
> +      properties:
> +        resets:
> +          maxItems: 1
> +        reset-names:
> +          items:
> +            - const: pci # PCIe core reset
> +
>    - if:
>        properties:
>          compatible:
> @@ -670,6 +723,7 @@ allOf:
>                - qcom,pcie-sdm845
>                - qcom,pcie-sm8150
>                - qcom,pcie-sm8250
> +              - qcom,pcie-sm8350
>                - qcom,pcie-sm8450-pcie0
>                - qcom,pcie-sm8450-pcie1
>      then:
> -- 
> 2.35.1
> 
> 
