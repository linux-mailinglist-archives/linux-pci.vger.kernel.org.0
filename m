Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9DC36EE6CA
	for <lists+linux-pci@lfdr.de>; Tue, 25 Apr 2023 19:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234782AbjDYRdf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Apr 2023 13:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234752AbjDYRde (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Apr 2023 13:33:34 -0400
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9607472A9;
        Tue, 25 Apr 2023 10:33:32 -0700 (PDT)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-187b70ab997so32337039fac.0;
        Tue, 25 Apr 2023 10:33:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682444012; x=1685036012;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h0GzhAD/cpdUlKsg6wh1agdAmhpzLWYRrNexUcUBt5g=;
        b=jV5zFtK9FTIKzYF71xvfU2+YUrBgK74Hez7GrAUmjOY6fWezxsqBR7hjGUKYNBh50r
         9Ye1T12YqcLg8ddJtu78dTcEzDIgS3Gi2UDw7oTtNtzoAKuR9joNAFOMGKc36SOVXTx1
         FaoigT7CGWRWNxLrzPs8WTrCVIhvQhVFAcCnnTolXLNcI2ASN5YQH7nP/f0q0HaLaxlE
         6+bskl57nAW9jVMUb6OdSePz/cYsJHMN+h+zAr1b/uqxzAZeykDHH5ImpQAMogzd5I+m
         P2S1Je2Z6tm/LSGv4CB/QsoUmlDhx6oMVh7VyHNAjGcr/wf/qaNhfptPclRbMEMq21cM
         suUQ==
X-Gm-Message-State: AAQBX9cxe1Gl6a+iOXC6v9HX3FOlBryllMlp6X7nC0xX8d+5j4ovhFIf
        DUhq6y9h5j1HeMLli/MPHvZPeDzMPg==
X-Google-Smtp-Source: AKy350aaMAg5yDe8SN3HyF3NKHcU7PGZ0yJJj/9pI2IQM4ze/LthkJzH0HafpAs1JK7w4HfSqZJ2LA==
X-Received: by 2002:a05:6870:3325:b0:188:b12:5db8 with SMTP id x37-20020a056870332500b001880b125db8mr9833518oae.5.1682444011715;
        Tue, 25 Apr 2023 10:33:31 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id dy14-20020a056870c78e00b0017197629658sm5691099oab.56.2023.04.25.10.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 10:33:31 -0700 (PDT)
Received: (nullmailer pid 1987956 invoked by uid 1000);
        Tue, 25 Apr 2023 17:33:30 -0000
Date:   Tue, 25 Apr 2023 12:33:30 -0500
From:   Rob Herring <robh@kernel.org>
To:     Devi Priya <quic_devipriy@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, mani@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-clk@vger.kernel.org,
        quic_srichara@quicinc.com, quic_sjaganat@quicinc.com,
        quic_kathirav@quicinc.com, quic_arajkuma@quicinc.com,
        quic_anusha@quicinc.com, quic_ipkumar@quicinc.com
Subject: Re: [PATCH V3 3/6] dt-bindings: PCI: qcom: Add IPQ9574
Message-ID: <20230425173330.GA1985131-robh@kernel.org>
References: <20230421124938.21974-1-quic_devipriy@quicinc.com>
 <20230421124938.21974-4-quic_devipriy@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230421124938.21974-4-quic_devipriy@quicinc.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 21, 2023 at 06:19:35PM +0530, Devi Priya wrote:
> Add bindings for PCIe hosts on IPQ9574 platform and allow
> msi-parent property.

Go see the long discussion about why msi-parent with msi-map is wrong. 
If something changed, explain that here.

> 
> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
> ---
>  Changes in V3:
> 	- Rebased on linux-next/master
> 
>  .../devicetree/bindings/pci/qcom,pcie.yaml    | 40 +++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> index 81971be4e554..a92cecc5fe6f 100644
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
> @@ -138,6 +141,8 @@ anyOf:
>    - required:
>        - msi-map
>        - msi-map-mask
> +  - required:
> +      - msi-parent
>  
>  allOf:
>    - $ref: /schemas/pci/pci-bus.yaml#
> @@ -171,6 +176,7 @@ allOf:
>              enum:
>                - qcom,pcie-ipq6018
>                - qcom,pcie-ipq8074-gen3
> +              - qcom,pcie-ipq9574
>      then:
>        properties:
>          reg:
> @@ -382,6 +388,39 @@ allOf:
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
> @@ -767,6 +806,7 @@ allOf:
>                  - qcom,pcie-ipq8064v2
>                  - qcom,pcie-ipq8074
>                  - qcom,pcie-ipq8074-gen3
> +                - qcom,pcie-ipq9574
>                  - qcom,pcie-qcs404
>      then:
>        required:
> -- 
> 2.17.1
> 
