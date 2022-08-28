Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3626E5A3E45
	for <lists+linux-pci@lfdr.de>; Sun, 28 Aug 2022 17:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbiH1POz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 28 Aug 2022 11:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbiH1POx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 28 Aug 2022 11:14:53 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 987B05F52
        for <linux-pci@vger.kernel.org>; Sun, 28 Aug 2022 08:14:50 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id h8so4484321lfm.8
        for <linux-pci@vger.kernel.org>; Sun, 28 Aug 2022 08:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=Dy0fgOx4rs48xpPzhvYKmnOx5ut2Vc9V8HGuvC4JxW4=;
        b=DR9vp7IXbNgPqDZSpylfxilurcU1UggJIT4OFcDPLXOuuZsnSX22M2Z4KVEDxWOQi+
         WSyOJbN2WzCw3gytmVcJbRnEPh5RwHclLDz0puZmgcnzY/Xy0Lx9HN45hENBxCfdmkjc
         kvBTCG/3LEzD0P8tOwmXGXPo0x3DC/+4nP/xf3G7Vw2fB/WfvuGrUbDsngJgcrt9LwEV
         IKvwxOHJUWGD48g65TGhy3jli4SG/QhfXDK9Eew6NEKf49hChWveC2Br2/t8fkTBsQMN
         IQF6Mfc/j9IJ7fprAtEI02u6qF8ru2iPDsCrgIHn4ltu1d4ui6iKinHKLjhfKumCiWqU
         TW6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=Dy0fgOx4rs48xpPzhvYKmnOx5ut2Vc9V8HGuvC4JxW4=;
        b=cLHzPqcgqKzhizDM1uabOTFugiC1GBvu/jGHgZH94i+P9OTCYDh+H/0Vptn4MUiX9W
         Mf4DUFQKHeEgdckWL2VXt9TbfjVBFgE3C8TBXq+6YpX3swNsj4JpQP4pa7phDW0Ao8iX
         DS9MlAw7rb2btmnRIXUBIcFpl6Wr/b/ankY/nu00wl4Z/ZjpRuIhkud1nd74WtZA4s9G
         tKLgEsws6mOSCq3JeRJB5Cq189AavttEKCkZuC8hhBhjcxQ62D3JWXg0+bhH31SrRvVI
         ZEoNHTdonZKXz4CVv/vfmpAmW0/45aJDopDX46kVpRkgEAiK0Q2Yos41qNR2bhkyrP0k
         dBtg==
X-Gm-Message-State: ACgBeo0Oy4okpYeJojept+tag6G2pQ/eaKFnGWPZlmKq9y6QgXyH8fvI
        qzX6Nzbi6KtyEILLbrwP9bWeQQ==
X-Google-Smtp-Source: AA6agR5T2TkBOQbss1s3ybLDZsyJ+LfcbzIbm0RluqQcWtY2KsqK4I9CH3ZH741/o6qsHudbuJ+QLA==
X-Received: by 2002:a05:6512:c1c:b0:494:6c98:a298 with SMTP id z28-20020a0565120c1c00b004946c98a298mr217253lfu.18.1661699689022;
        Sun, 28 Aug 2022 08:14:49 -0700 (PDT)
Received: from [192.168.0.71] (82.131.98.15.cable.starman.ee. [82.131.98.15])
        by smtp.gmail.com with ESMTPSA id i4-20020a198c44000000b00492c5ec6f84sm970215lfj.249.2022.08.28.08.14.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Aug 2022 08:14:48 -0700 (PDT)
Message-ID: <755e203f-d02c-16ca-254a-f9b1d751f1f5@linaro.org>
Date:   Sun, 28 Aug 2022 18:14:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 09/11] dt-bindings: PCI: qcom-ep: Define clocks per
 platform
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        lpieralisi@kernel.org, robh@kernel.org, andersson@kernel.org
Cc:     kw@linux.com, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        dmitry.baryshkov@linaro.org
References: <20220826181923.251564-1-manivannan.sadhasivam@linaro.org>
 <20220826181923.251564-10-manivannan.sadhasivam@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220826181923.251564-10-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 26/08/2022 21:19, Manivannan Sadhasivam wrote:
> In preparation of adding the bindings for future SoCs, let's define the
> clocks per platform.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  .../devicetree/bindings/pci/qcom,pcie-ep.yaml | 46 +++++++++++--------
>  1 file changed, 27 insertions(+), 19 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> index b728ede3f09f..83a2cfc63bc1 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> @@ -9,9 +9,6 @@ title: Qualcomm PCIe Endpoint Controller binding
>  maintainers:
>    - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>  
> -allOf:
> -  - $ref: "pci-ep.yaml#"
> -
>  properties:
>    compatible:
>      const: qcom,sdx55-pcie-ep
> @@ -35,24 +32,12 @@ properties:
>        - const: mmio
>  
>    clocks:
> -    items:
> -      - description: PCIe Auxiliary clock
> -      - description: PCIe CFG AHB clock
> -      - description: PCIe Master AXI clock
> -      - description: PCIe Slave AXI clock
> -      - description: PCIe Slave Q2A AXI clock
> -      - description: PCIe Sleep clock
> -      - description: PCIe Reference clock
> +    minItems: 7

MinItems is not needed. They should be added in your next patch.

> +    maxItems: 7
>  
>    clock-names:
> -    items:
> -      - const: aux
> -      - const: cfg
> -      - const: bus_master
> -      - const: bus_slave
> -      - const: slave_q2a
> -      - const: sleep
> -      - const: ref
> +    minItems: 7

MinItems is not needed. They should be added in your next patch.


> +    maxItems: 7
>  
>    qcom,perst-regs:
>      description: Reference to a syscon representing TCSR followed by the two
> @@ -112,6 +97,29 @@ required:
>    - reset-names
>    - power-domains
>  
> +allOf:
> +  - $ref: "pci-ep.yaml#"

While moving this line around, drop the quotes.

> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,sdx55-pcie-ep
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 7

minItems is not needed

> +          maxItems: 7

Best regards,
Krzysztof
