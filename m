Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF577139F7
	for <lists+linux-pci@lfdr.de>; Sun, 28 May 2023 16:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjE1ORl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 28 May 2023 10:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjE1ORk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 28 May 2023 10:17:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 519CFBD;
        Sun, 28 May 2023 07:17:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF0A760C3A;
        Sun, 28 May 2023 14:17:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BDEBC433EF;
        Sun, 28 May 2023 14:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685283458;
        bh=ZcxgB136p3hk0as9toDTgLvODHgCQ2FC/7oQEioZVEw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iqWnwVb7ITUvf0o83xC7036ivo76GCzphkD73YDylcbLT4wfEvTHDEFgc9diJMlmq
         AnbVXAJQ9cruHK/Nai9PSeubS2eJWGPu2NCt3c5QovAT/fwMru9G1NvzDsuAKt/kRu
         qFrCV0FtTgeFQH3tQStXX2XbLHgDOyRNrJ++lzX0+uMI28wN5QlgsTTWluLS8rq1Ou
         rPnJrK46hSwSbqoVTyNVp2CjKZrw5Thjb1U8a3jn/MjgzR2WKev/Op0rxOMRCyWrEk
         VxDJ0kK/tEn6uP2KgowdHKg1upox5/6hntpQxO48zUi7FDWQxuLc183qcsEVQRMVkv
         vNGR+sXL8JCIA==
Date:   Sun, 28 May 2023 19:47:13 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Devi Priya <quic_devipriy@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, quic_srichara@quicinc.com,
        quic_sjaganat@quicinc.com, quic_kathirav@quicinc.com,
        quic_arajkuma@quicinc.com, quic_anusha@quicinc.com,
        quic_ipkumar@quicinc.com
Subject: Re: [PATCH V4 3/6] dt-bindings: PCI: qcom: Add IPQ9574
Message-ID: <20230528141713.GB2814@thinkpad>
References: <20230519090219.15925-1-quic_devipriy@quicinc.com>
 <20230519090219.15925-4-quic_devipriy@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230519090219.15925-4-quic_devipriy@quicinc.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 19, 2023 at 02:32:16PM +0530, Devi Priya wrote:
> Add bindings for PCIe hosts on IPQ9574 platform and allow
> msi-parent property.
> 

Why can't you use existing "msi-map" property instead of "msi-parent"?

- Mani

> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
> ---
>  Changes in V4:
> 	- Dropped msi-parent from anyOf: as msi-parent and msi-map
> 	  cannot coexist and added it specific to ipq9574
> 
>  .../devicetree/bindings/pci/qcom,pcie.yaml    | 48 +++++++++++++++++++
>  1 file changed, 48 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> index 81971be4e554..af5c7a390df1 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> @@ -26,6 +26,7 @@ properties:
>            - qcom,pcie-ipq8064-v2
>            - qcom,pcie-ipq8074
>            - qcom,pcie-ipq8074-gen3
> +          - qcom,pcie-ipq9574
>            - qcom,pcie-msm8996
>            - qcom,pcie-qcs404
>            - qcom,pcie-sa8540p
> @@ -113,6 +114,8 @@ properties:
>    power-domains:
>      maxItems: 1
>  
> +  msi-parent: true
> +
>    perst-gpios:
>      description: GPIO controlled connection to PERST# signal
>      maxItems: 1
> @@ -171,6 +174,7 @@ allOf:
>              enum:
>                - qcom,pcie-ipq6018
>                - qcom,pcie-ipq8074-gen3
> +              - qcom,pcie-ipq9574
>      then:
>        properties:
>          reg:
> @@ -382,6 +386,39 @@ allOf:
>              - const: ahb # AHB Reset
>              - const: axi_m_sticky # AXI Master Sticky reset
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,pcie-ipq9574
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 6
> +          maxItems: 6
> +        clock-names:
> +          items:
> +            - const: ahb  # AHB clock
> +            - const: aux  # Auxiliary clock
> +            - const: axi_m # AXI Master clock
> +            - const: axi_s # AXI Slave clock
> +            - const: axi_bridge # AXI bridge clock
> +            - const: rchng
> +        resets:
> +          minItems: 8
> +          maxItems: 8
> +        reset-names:
> +          items:
> +            - const: pipe # PIPE reset
> +            - const: sticky # Core Sticky reset
> +            - const: axi_s_sticky # AXI Slave Sticky reset
> +            - const: axi_s # AXI Slave reset
> +            - const: axi_m_sticky # AXI Master Sticky reset
> +            - const: axi_m # AXI Master reset
> +            - const: aux # AUX Reset
> +            - const: ahb # AHB Reset
> +
>    - if:
>        properties:
>          compatible:
> @@ -767,6 +804,7 @@ allOf:
>                  - qcom,pcie-ipq8064v2
>                  - qcom,pcie-ipq8074
>                  - qcom,pcie-ipq8074-gen3
> +                - qcom,pcie-ipq9574
>                  - qcom,pcie-qcs404
>      then:
>        required:
> @@ -862,6 +900,16 @@ allOf:
>            items:
>              - const: msi
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,pcie-ipq9574
> +    then:
> +      required:
> +        - msi-parent
> +
>  unevaluatedProperties: false
>  
>  examples:
> -- 
> 2.17.1
> 

-- 
மணிவண்ணன் சதாசிவம்
