Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B04F50BD87
	for <lists+linux-pci@lfdr.de>; Fri, 22 Apr 2022 18:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449859AbiDVQwY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Apr 2022 12:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449855AbiDVQwW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Apr 2022 12:52:22 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213015F8DB
        for <linux-pci@vger.kernel.org>; Fri, 22 Apr 2022 09:49:28 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id w187so6137624ybe.2
        for <linux-pci@vger.kernel.org>; Fri, 22 Apr 2022 09:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yjyLuNFV4sqz/6Z5vCk0BquB2BUmGkkNwZpzUE7yayc=;
        b=NtuKuR9ejemQ0Vbhk022ozJzoN15S796zqY5kgkmqgh6HhdelrBgcjSgK1k9bJTUeU
         qAX5HUlKUr0VW3Z7IRW9qQNyKnSrlEEmphawhq+/XXaJXZ5bzQyITUIQq5A25JcMsdXd
         9Vc+b5SzYFyBzlXLCZQzXncxo/aEo9dmbXP8+94K8cH8tjsWFSdbGQiMEO7jn2ixHC++
         PTLxiKs+YoPEA8ZZQwVNL/r+5Fx/s7WWheIsrekxPAxC2VirHqN2dieFniKqZ7/VnejI
         DyLcnJ0pBcwo7QY2WU4HaPsGvCRsVR9RuBxG8Cxsg/0BHOiDXg4Uh2Liehyk8AKrXJ82
         uiKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yjyLuNFV4sqz/6Z5vCk0BquB2BUmGkkNwZpzUE7yayc=;
        b=7OXimEdyv0Niwo05f+IvTo9gBOsP8QbDQf0JfxTqi9bZQofL1XQnc8Az7aJ6e2VK4o
         bK9AMu19qQ79AX2J2n1icLYUrCQJvMlbvCa/JDP8E3NBurVsB6MzEgRQDZ8yOsnVwrcS
         BuEPRk+WmX1PdkqFGggfBIKqnz/gY+dVwzNXbv0YpKiIReRNdeaZxUrrcqGpG/qi/yW8
         gpXlvAMRYMj+srEk/o2ak/TzJRaJwvVtUfRETWOy9II6bNKPCpB2wILMRHMIsc3oozkw
         wqreSeriNUq4dod5ficHtjjf3REBgmKtFznOaaHTPF/IKXQFw6HoXm7Qx+I498undV+l
         iwEg==
X-Gm-Message-State: AOAM533wgknjyqebzqjrluKnS/IXN+SlV7YwM3iXBqYJ7FoHZ8aZQ/eT
        eEpNVtjjTlRQiV8ZLRGKM8etPlVJEiCz19n4KZPDiA==
X-Google-Smtp-Source: ABdhPJwy2xeRF63SDT0AhX59gghBPDPyHcSHhZA6XKRkTCrbOimvg+nahXvjrYYDANXbKLK5Gf9/epRz2Ei1gMsmB6A=
X-Received: by 2002:a25:d507:0:b0:63d:a541:1a8c with SMTP id
 r7-20020a25d507000000b0063da5411a8cmr5548591ybe.92.1650646167265; Fri, 22 Apr
 2022 09:49:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220422114841.1854138-1-dmitry.baryshkov@linaro.org>
 <20220422114841.1854138-2-dmitry.baryshkov@linaro.org> <cbc35460-9ca0-0caa-7e7e-8458ec0b8f36@linaro.org>
In-Reply-To: <cbc35460-9ca0-0caa-7e7e-8458ec0b8f36@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 22 Apr 2022 19:49:16 +0300
Message-ID: <CAA8EJprvk8kt-Vq5WdeMqqZGJpMN5N9AaAAG1xp=pGM+EQF9Fw@mail.gmail.com>
Subject: Re: [PATCH 1/6] dt-bindings: pci/qcom,pcie: convert to YAML
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 22 Apr 2022 at 16:10, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 22/04/2022 13:48, Dmitry Baryshkov wrote:
> > Changes to examples:
> >  - Inline clock and reset numbers rather than including dt-bindings
> >    files because of conflicts between the headers
> >  - Split ranges properties to follow current practice
> >
> > Changes to the schema:
> >  - Fixed the ordering of clock-names/reset-names according to
> >    the dtsi files.
> >  - Mark vdda-supply as required only for apq/ipq8064 (as it was marked
> >    as generally required in the txt file).
> >
> > Note: while it was not clearly described in text schema, the majority of
> > Qualcomm platforms follow the snps,dw-pcie schema and use two
> > compatibility strings in the DT files: platform-specific one and a
> > fallback to the generic snps,dw-pcie one. This will be sorted out in the
> > next patches.
>
> I don't get why you add snps,dw-pcie fallback here, even though original
> bindings (except examples, which are not bindings) were not mentioning
> it. Maybe just skip it?

Ack, I'll squash the snps,dw-pcie patch into this one.

>
> >
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >  .../devicetree/bindings/pci/qcom,pcie.txt     | 397 ------------
> >  .../devicetree/bindings/pci/qcom,pcie.yaml    | 607 ++++++++++++++++++
> >  2 files changed, 607 insertions(+), 397 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/pci/qcom,pcie.txt
> >  create mode 100644 Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> >
>
> (...)
>
> > -     };
> > diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> > new file mode 100644
> > index 000000000000..89a1021df9bc
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> > @@ -0,0 +1,607 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/pci/qcom,pcie.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Qualcomm PCI express root complex
> > +
> > +maintainers:
> > +  - Bjorn Andersson <bjorn.andersson@linaro.org>
> > +  - Stanimir Varbanov <svarbanov@mm-sol.com>
> > +
> > +description: |
> > +  Qualcomm PCIe root complex controller is bansed on the Synopsys DesignWare
> > +  PCIe IP.
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - enum:
> > +          - qcom,pcie-ipq8064
> > +          - qcom,pcie-ipq8064-v2
> > +          - qcom,pcie-apq8064
> > +          - qcom,pcie-apq8084
> > +          - qcom,pcie-msm8996
> > +          - qcom,pcie-ipq4019
> > +          - qcom,pcie-ipq8074
> > +          - qcom,pcie-qcs404
> > +          - qcom,pcie-sc8180x
> > +          - qcom,pcie-sdm845
> > +          - qcom,pcie-sm8250
> > +          - qcom,pcie-sm8450-pcie0
> > +          - qcom,pcie-sm8450-pcie1
> > +          - qcom,pcie-ipq6018
> > +      - const: snps,dw-pcie
> > +
> > +  reg:
> > +    minItems: 4
> > +    maxItems: 5
> > +
> > +  reg-names:
> > +    minItems: 4
> > +    maxItems: 5
> > +    items:
> > +      enum:
> > +        - parf # Qualcomm specific registers
> > +        - dbi # DesignWare PCIe registers
> > +        - elbi # External local bus interface registers
> > +        - config # PCIe configuration space
> > +        - atu # ATU address space (optional)> +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  interrupt-names:
> > +    items:
> > +      - const: "msi"
> > +
> > +  clocks: true
>
> min/maxItems
>
> same for clock-names
>
> > +
> > +  vdda-supply:
> > +    description: A phandle to the core analog power supply
> > +
> > +  vdda_phy-supply:
> > +    description: A phandle to the core analog power supply for PHY
> > +
> > +  vdda_refclk-supply:
> > +    description: A phandle to the core analog power supply for IC which generates reference clock
> > +
> > +  vddpe-3v3-supply:
> > +    description: A phandle to the PCIe endpoint power supply
> > +
> > +  phys:
> > +    maxItems: 1
> > +
> > +  phy-names:
> > +    items:
> > +      - const: "pciephy"
> > +
> > +  perst-gpio:
> > +    description: GPIO pin number of PERST# signal
> > +    maxItems: 1
> > +    deprecated: true
>
> Old binding did not have it.

Ack, dropping.

>
> > +
> > +  perst-gpios:
> > +    description: GPIO controlled connection to PERST# signal
> > +    maxItems: 1
> > +
>
> You miss here power-domains, resets and reset-names with min/maxItems.

power-domains are described later in the non-8064 cases.

Will add everything here.

>
> > +  wake-gpio:
> > +    description: GPIO pin number of WAKE# signal
> > +    maxItems: 1
> > +    deprecated: true
>

Ack dropping.

>
> > +
> > +  wake-gpios:
> > +    description: GPIO controlled connection to WAKE# signal
> > +    maxItems: 1
> > +
> > +  iommu-map: true
> > +  iommu-map-mask: true
>
> Not present in old binding. If this is trully needed, mention it in
> commit msg.

They are used on newer platforms. Will mention it.

>
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - reg-names
> > +  - interrupts
> > +  - interrupt-names
>
> What about interrupt-cells, clocks, clock-names, resets, reset-names?

Ugh. Missed them, adding back.

>
> > +
> > +allOf:
> > +  - $ref: /schemas/pci/pci-bus.yaml#
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - qcom,pcie-apq8064
> > +    then:
> > +      properties:
> > +        clocks:
> > +          minItems: 3
> > +          maxItems: 3
> > +        clock-names:
> > +          items:
> > +            - const: core # Clocks the pcie hw block
> > +            - const: iface # Configuration AHB clock
> > +            - const: phy # Clocks the pcie PHY block
> > +        resets:
> > +          minItems: 5
> > +          maxItems: 5
> > +        reset-names:
> > +          items:
> > +            - const: axi # AXI reset
> > +            - const: ahb # AHB reset
> > +            - const: por # POR reset
> > +            - const: pci # PCI reset
> > +            - const: phy # PHY reset
>
> Missing required properties e.g. some supplies.

Ok, I'll merge all apq8064 and ipq8064 entries into a single if/then condition.

> Plus one blank line.
>
> The same applies below to other ifs.
>
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - qcom,pcie-ipq8064
> > +              - qcom,pcie-ipq8064v2
>
> (...)
>
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +    pcie@1b500000 {
> > +      compatible = "qcom,pcie-ipq8064", "snps,dw-pcie";
> > +      reg = <0x1b500000 0x1000
> > +             0x1b502000 0x80
> > +             0x1b600000 0x100
> > +             0x0ff00000 0x100000>;
>
> Convert the example to match current bindings, so reg should be split.

I wonder why the dt_bindings check didn't warn me about it.

>
> > +      reg-names = "dbi", "elbi", "parf", "config";
> > +      device_type = "pci";
> > +      linux,pci-domain = <0>;
> > +      bus-range = <0x00 0xff>;
> > +      num-lanes = <1>;
> > +      #address-cells = <3>;
> > +      #size-cells = <2>;
> > +      ranges = <0x81000000 0 0 0x0fe00000 0 0x00100000>,
> > +               <0x82000000 0 0 0x08000000 0 0x07e00000>;
> > +      interrupts = <GIC_SPI 238 IRQ_TYPE_NONE>;
>
> Looks like wrong IRQ flag.

Ack

>
> > +      interrupt-names = "msi";
> > +      #interrupt-cells = <1>;
> > +      interrupt-map-mask = <0 0 0 0x7>;
> > +      interrupt-map = <0 0 0 1 &intc 0 36 IRQ_TYPE_LEVEL_HIGH>,
> > +                      <0 0 0 2 &intc 0 37 IRQ_TYPE_LEVEL_HIGH>,
> > +                      <0 0 0 3 &intc 0 38 IRQ_TYPE_LEVEL_HIGH>,
> > +                      <0 0 0 4 &intc 0 39 IRQ_TYPE_LEVEL_HIGH>;
> > +      clocks = <&gcc 41>,
> > +               <&gcc 43>,
> > +               <&gcc 44>,
> > +               <&gcc 42>,
> > +               <&gcc 248>;
> > +      clock-names = "core", "iface", "phy", "aux", "ref";
> > +      resets = <&gcc 27>,
> > +               <&gcc 26>,
> > +               <&gcc 25>,
> > +               <&gcc 24>,
> > +               <&gcc 23>,
> > +               <&gcc 22>;
> > +      reset-names = "axi", "ahb", "por", "pci", "phy", "ext";
> > +      pinctrl-0 = <&pcie_pins_default>;
> > +      pinctrl-names = "default";
> > +      vdda-supply = <&pm8921_s3>;
> > +      vdda_phy-supply = <&pm8921_lvs6>;
> > +      vdda_refclk-supply = <&ext_3p3v>;
> > +    };
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +    #include <dt-bindings/gpio/gpio.h>
> > +    pcie@fc520000 {
> > +      compatible = "qcom,pcie-apq8084", "snps,dw-pcie";
> > +      reg = <0xfc520000 0x2000>,
> > +            <0xff000000 0x1000>,
> > +            <0xff001000 0x1000>,
> > +            <0xff002000 0x2000>;
> > +      reg-names = "parf", "dbi", "elbi", "config";
> > +      device_type = "pci";
> > +      linux,pci-domain = <0>;
> > +      bus-range = <0x00 0xff>;
> > +      num-lanes = <1>;
> > +      #address-cells = <3>;
> > +      #size-cells = <2>;
> > +      ranges = <0x81000000 0 0          0xff200000 0 0x00100000>,
> > +               <0x82000000 0 0x00300000 0xff300000 0 0x00d00000>;
> > +      interrupts = <GIC_SPI 243 IRQ_TYPE_NONE>;
>
> Ditto.

Ack


--
With best wishes
Dmitry
