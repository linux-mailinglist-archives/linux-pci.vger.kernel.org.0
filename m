Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0AFC50B7F9
	for <lists+linux-pci@lfdr.de>; Fri, 22 Apr 2022 15:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbiDVNNv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Apr 2022 09:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447749AbiDVNNu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Apr 2022 09:13:50 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46064757C
        for <linux-pci@vger.kernel.org>; Fri, 22 Apr 2022 06:10:54 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id lc2so16252959ejb.12
        for <linux-pci@vger.kernel.org>; Fri, 22 Apr 2022 06:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=k/nnolE75mTdZ6OFqYAwzODo+9cFddciH31d1PvbACY=;
        b=S/3KrJxn8U9tt/Qq0o8RqJaX4XZD2UpHNxtKA39eE9WWfrUNR4+t4E2hUZcc5iAe9u
         QnnL9eUGXchD7jmfXcC9KwZ9mJEwyyWWtmKfrMOGCghQ5ireD7kpWY6kBqSi/UNEOEXo
         z5XeSKmVifPPYaDeNSmYunDBM8diGVA4g6yOONI4bejyaHODIzPrchu4Rz9vpoRCYyiH
         OGEieGtA8f3HBwbWMReSlyXfiYfgQm7tLCbk94K0wF+QDWcVNY17Q95xtqRytzD8db9M
         bW1Ph5X7837EPT5cp8Kn779n+l4at0z+wRXd21eZ2ccOGunE5xapAnC9RP8ThJm3YT7k
         4a1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=k/nnolE75mTdZ6OFqYAwzODo+9cFddciH31d1PvbACY=;
        b=v8PhpTRORYLoAAkTOsrZuyPrrJOtQ9X7Yrgr/MP8Y6XJexq6dXM9/oTP8mx+DqeAln
         fvPqvbhIBEHe6FkOOS0DdhbDn3ADgJBvVJ5EaI2IYgGuAt9izdqoyCvKw7hxMHPPFcB0
         Z3kjbdS0qgqZtEf6SWMv1p284pvCeLCPzz/BpsBmJSr9ECJJVaSkKnQkaT98HSre95RJ
         1hE2eytyHYZtB6pHC0USI/ByDqPuj0/kRIMmJfdCwMIwe1zD5RQX7r0z5CghHygApG0D
         1RO4qBtGosruF4XyoZY3zEWWxfOdKNBkUJRlc/aFRu7uhUKLDHj8CGqHS9AEHGzm0XiN
         a4DQ==
X-Gm-Message-State: AOAM53341AE3yqt29Cybbra0nct/lHXlr8aiCtqDOeWT5NmuIraXqwf4
        E2iNDPNJVsfgsKbvdILW9EBYmQ==
X-Google-Smtp-Source: ABdhPJz0gMANsvcAD6N981A+kZ/x8BMrbch2CzLxWU+kqajf+kfW8dN//wwyFVTLO+a/KarXS2BXrg==
X-Received: by 2002:a17:906:18b2:b0:6d0:ee54:1add with SMTP id c18-20020a17090618b200b006d0ee541addmr4041751ejf.499.1650633053320;
        Fri, 22 Apr 2022 06:10:53 -0700 (PDT)
Received: from [192.168.0.232] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id hy24-20020a1709068a7800b006e888dbf1d6sm729022ejc.91.2022.04.22.06.10.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Apr 2022 06:10:52 -0700 (PDT)
Message-ID: <cbc35460-9ca0-0caa-7e7e-8458ec0b8f36@linaro.org>
Date:   Fri, 22 Apr 2022 15:10:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/6] dt-bindings: pci/qcom,pcie: convert to YAML
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
 <20220422114841.1854138-2-dmitry.baryshkov@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220422114841.1854138-2-dmitry.baryshkov@linaro.org>
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
> Changes to examples:
>  - Inline clock and reset numbers rather than including dt-bindings
>    files because of conflicts between the headers
>  - Split ranges properties to follow current practice
> 
> Changes to the schema:
>  - Fixed the ordering of clock-names/reset-names according to
>    the dtsi files.
>  - Mark vdda-supply as required only for apq/ipq8064 (as it was marked
>    as generally required in the txt file).
> 
> Note: while it was not clearly described in text schema, the majority of
> Qualcomm platforms follow the snps,dw-pcie schema and use two
> compatibility strings in the DT files: platform-specific one and a
> fallback to the generic snps,dw-pcie one. This will be sorted out in the
> next patches.

I don't get why you add snps,dw-pcie fallback here, even though original
bindings (except examples, which are not bindings) were not mentioning
it. Maybe just skip it?

> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  .../devicetree/bindings/pci/qcom,pcie.txt     | 397 ------------
>  .../devicetree/bindings/pci/qcom,pcie.yaml    | 607 ++++++++++++++++++
>  2 files changed, 607 insertions(+), 397 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pci/qcom,pcie.txt
>  create mode 100644 Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> 

(...)

> -	};
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> new file mode 100644
> index 000000000000..89a1021df9bc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> @@ -0,0 +1,607 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/qcom,pcie.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm PCI express root complex
> +
> +maintainers:
> +  - Bjorn Andersson <bjorn.andersson@linaro.org>
> +  - Stanimir Varbanov <svarbanov@mm-sol.com>
> +
> +description: |
> +  Qualcomm PCIe root complex controller is bansed on the Synopsys DesignWare
> +  PCIe IP.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - qcom,pcie-ipq8064
> +          - qcom,pcie-ipq8064-v2
> +          - qcom,pcie-apq8064
> +          - qcom,pcie-apq8084
> +          - qcom,pcie-msm8996
> +          - qcom,pcie-ipq4019
> +          - qcom,pcie-ipq8074
> +          - qcom,pcie-qcs404
> +          - qcom,pcie-sc8180x
> +          - qcom,pcie-sdm845
> +          - qcom,pcie-sm8250
> +          - qcom,pcie-sm8450-pcie0
> +          - qcom,pcie-sm8450-pcie1
> +          - qcom,pcie-ipq6018
> +      - const: snps,dw-pcie
> +
> +  reg:
> +    minItems: 4
> +    maxItems: 5
> +
> +  reg-names:
> +    minItems: 4
> +    maxItems: 5
> +    items:
> +      enum:
> +        - parf # Qualcomm specific registers
> +        - dbi # DesignWare PCIe registers
> +        - elbi # External local bus interface registers
> +        - config # PCIe configuration space
> +        - atu # ATU address space (optional)> +
> +  interrupts:
> +    maxItems: 1
> +
> +  interrupt-names:
> +    items:
> +      - const: "msi"
> +
> +  clocks: true

min/maxItems

same for clock-names

> +
> +  vdda-supply:
> +    description: A phandle to the core analog power supply
> +
> +  vdda_phy-supply:
> +    description: A phandle to the core analog power supply for PHY
> +
> +  vdda_refclk-supply:
> +    description: A phandle to the core analog power supply for IC which generates reference clock
> +
> +  vddpe-3v3-supply:
> +    description: A phandle to the PCIe endpoint power supply
> +
> +  phys:
> +    maxItems: 1
> +
> +  phy-names:
> +    items:
> +      - const: "pciephy"
> +
> +  perst-gpio:
> +    description: GPIO pin number of PERST# signal
> +    maxItems: 1
> +    deprecated: true

Old binding did not have it.

> +
> +  perst-gpios:
> +    description: GPIO controlled connection to PERST# signal
> +    maxItems: 1
> +

You miss here power-domains, resets and reset-names with min/maxItems.

> +  wake-gpio:
> +    description: GPIO pin number of WAKE# signal
> +    maxItems: 1
> +    deprecated: true

Old binding did not have it.

> +
> +  wake-gpios:
> +    description: GPIO controlled connection to WAKE# signal
> +    maxItems: 1
> +
> +  iommu-map: true
> +  iommu-map-mask: true

Not present in old binding. If this is trully needed, mention it in
commit msg.

> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - interrupts
> +  - interrupt-names

What about interrupt-cells, clocks, clock-names, resets, reset-names?

> +
> +allOf:
> +  - $ref: /schemas/pci/pci-bus.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,pcie-apq8064
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 3
> +          maxItems: 3
> +        clock-names:
> +          items:
> +            - const: core # Clocks the pcie hw block
> +            - const: iface # Configuration AHB clock
> +            - const: phy # Clocks the pcie PHY block
> +        resets:
> +          minItems: 5
> +          maxItems: 5
> +        reset-names:
> +          items:
> +            - const: axi # AXI reset
> +            - const: ahb # AHB reset
> +            - const: por # POR reset
> +            - const: pci # PCI reset
> +            - const: phy # PHY reset

Missing required properties e.g. some supplies.
Plus one blank line.

The same applies below to other ifs.

> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,pcie-ipq8064
> +              - qcom,pcie-ipq8064v2

(...)

> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    pcie@1b500000 {
> +      compatible = "qcom,pcie-ipq8064", "snps,dw-pcie";
> +      reg = <0x1b500000 0x1000
> +             0x1b502000 0x80
> +             0x1b600000 0x100
> +             0x0ff00000 0x100000>;

Convert the example to match current bindings, so reg should be split.

> +      reg-names = "dbi", "elbi", "parf", "config";
> +      device_type = "pci";
> +      linux,pci-domain = <0>;
> +      bus-range = <0x00 0xff>;
> +      num-lanes = <1>;
> +      #address-cells = <3>;
> +      #size-cells = <2>;
> +      ranges = <0x81000000 0 0 0x0fe00000 0 0x00100000>, 
> +               <0x82000000 0 0 0x08000000 0 0x07e00000>; 
> +      interrupts = <GIC_SPI 238 IRQ_TYPE_NONE>;

Looks like wrong IRQ flag.

> +      interrupt-names = "msi";
> +      #interrupt-cells = <1>;
> +      interrupt-map-mask = <0 0 0 0x7>;
> +      interrupt-map = <0 0 0 1 &intc 0 36 IRQ_TYPE_LEVEL_HIGH>, 
> +                      <0 0 0 2 &intc 0 37 IRQ_TYPE_LEVEL_HIGH>, 
> +                      <0 0 0 3 &intc 0 38 IRQ_TYPE_LEVEL_HIGH>, 
> +                      <0 0 0 4 &intc 0 39 IRQ_TYPE_LEVEL_HIGH>; 
> +      clocks = <&gcc 41>,
> +               <&gcc 43>,
> +               <&gcc 44>,
> +               <&gcc 42>,
> +               <&gcc 248>;
> +      clock-names = "core", "iface", "phy", "aux", "ref";
> +      resets = <&gcc 27>,
> +               <&gcc 26>,
> +               <&gcc 25>,
> +               <&gcc 24>,
> +               <&gcc 23>,
> +               <&gcc 22>;
> +      reset-names = "axi", "ahb", "por", "pci", "phy", "ext";
> +      pinctrl-0 = <&pcie_pins_default>;
> +      pinctrl-names = "default";
> +      vdda-supply = <&pm8921_s3>;
> +      vdda_phy-supply = <&pm8921_lvs6>;
> +      vdda_refclk-supply = <&ext_3p3v>;
> +    };
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/gpio/gpio.h>
> +    pcie@fc520000 {
> +      compatible = "qcom,pcie-apq8084", "snps,dw-pcie";
> +      reg = <0xfc520000 0x2000>,
> +            <0xff000000 0x1000>,
> +            <0xff001000 0x1000>,
> +            <0xff002000 0x2000>;
> +      reg-names = "parf", "dbi", "elbi", "config";
> +      device_type = "pci";
> +      linux,pci-domain = <0>;
> +      bus-range = <0x00 0xff>;
> +      num-lanes = <1>;
> +      #address-cells = <3>;
> +      #size-cells = <2>;
> +      ranges = <0x81000000 0 0          0xff200000 0 0x00100000>, 
> +               <0x82000000 0 0x00300000 0xff300000 0 0x00d00000>; 
> +      interrupts = <GIC_SPI 243 IRQ_TYPE_NONE>;

Ditto.


Best regards,
Krzysztof
