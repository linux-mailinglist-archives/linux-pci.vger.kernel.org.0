Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FEA463218E
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 13:05:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiKUMFy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 07:05:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbiKUMFx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 07:05:53 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64711EC6E
        for <linux-pci@vger.kernel.org>; Mon, 21 Nov 2022 04:05:50 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id r12so18536983lfp.1
        for <linux-pci@vger.kernel.org>; Mon, 21 Nov 2022 04:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U8lk1yGk+k1jHpBFenfM0E1QDY7dO/CdbSlBNPwvv7M=;
        b=LL2WCbIR4i1mBwmicLqdPhaaBHpYS/pB5qx+cDvQyMuNImKhaeHSKN4omMeoJ5yVs0
         Bc0qnjoCinSjOLLI+Xz69fG8Y9IZywlwyuMXExxYZJKUIOZgUU3ga/ksFGy97ZdaSqGs
         uyimQZEaLtBUPrQKUpf3phHBqqo5DFqD+PppswTgSXfomx3jmkzvzkq3yA3/WKi4Q0TU
         sDuS0pkMc0jZpteQBU2Oere/jW1quENeLtv1tXGyFB1wNMkht39QMzrUditBGZLQDfyS
         cZY02SjnAiKrfdlRVHWVXkrFybqik6oM1Dm0+3G8Oh5xRtUP7ri0zrxYeqCGvtoUxpot
         QQnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U8lk1yGk+k1jHpBFenfM0E1QDY7dO/CdbSlBNPwvv7M=;
        b=4U4hLnXsvrEbM1J46CMXaXBWF2fiisMZtUjuE5oVnAhvgfUTwdzoiNFGQeb1rXD1gN
         QYvYk8we6KXEK/x9cVu3oKEmp8HGZho7B662aYvevaStqFkiCMDnJJJoEsATibZjTDvL
         81LIZjJhaiWt4PD+tRWn3rbh4lm9iDcX16YGzoDMo/y9y4zZL1VRfEjFKCCtiLcEi/G7
         XZuvww7REURCISggwqRyUyUzRfGybv3Ow1ovtei5+hqF2Is3Jdb0eY/5MkIBhg+G1N8o
         CsdsLzX5CP47K1KWTPeTduGU0LuMZlP8ZJ9dVk5Qa1FP9D+Mm3hM5Je5PhKpm2WMMCKD
         P0oA==
X-Gm-Message-State: ANoB5pk0P766o/JLbBFSZSL9JlEPczA2oKoBbi69pD49HQVy+RT9Dg43
        mlI7qXuwuBOgsR+qv9igTtGo3w==
X-Google-Smtp-Source: AA0mqf4A51rPoijgjuQKSdOsv/cU3hGnDdJXXaLypfldqje/5jUfbTIYx0C/yihusXwzzxxaT054kw==
X-Received: by 2002:ac2:5dea:0:b0:4b2:2cff:8446 with SMTP id z10-20020ac25dea000000b004b22cff8446mr5881122lfq.572.1669032348998;
        Mon, 21 Nov 2022 04:05:48 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id y3-20020a197503000000b004b4b5bd8d02sm1981733lfe.78.2022.11.21.04.05.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 04:05:48 -0800 (PST)
Message-ID: <d728bb46-558c-67e8-c93b-96f2a6ab77a3@linaro.org>
Date:   Mon, 21 Nov 2022 13:05:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 2/6] dt-bindings: PCI: Add PCIe controller bindings for
 FSD
Content-Language: en-US
To:     Shradha Todi <shradha.t@samsung.com>, bhelgaas@google.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        kishon@ti.com, vkoul@kernel.org, lpieralisi@kernel.org,
        kw@linux.com, mani@kernel.org, arnd@arndb.de,
        gregkh@linuxfoundation.org, alim.akhtar@samsung.com,
        ajaykumar.rs@samsung.com, rcsekar@samsung.com,
        sriranjani.p@samsung.com, bharat.uppal@samsung.com,
        s.prashar@samsung.com, aswani.reddy@samsung.com,
        pankaj.dubey@samsung.com, p.rajanbabu@samsung.com,
        niyas.ahmed@samsung.com, chanho61.park@samsung.com
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
References: <20221121105210.68596-1-shradha.t@samsung.com>
 <CGME20221121104725epcas5p3af00b0c717f2132f5c1ba7fd4e903e26@epcas5p3.samsung.com>
 <20221121105210.68596-3-shradha.t@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221121105210.68596-3-shradha.t@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21/11/2022 11:52, Shradha Todi wrote:
> Document the PCIe controller device tree bindings for

Subject: drop second, redundant "bindings".

> Tesla FSD SoC for both RC and EP

Full stop.

> 
> Signed-off-by: Shradha Todi  <shradha.t@samsung.com>
> ---
>  .../bindings/pci/tesla,pcie-fsd-ep.yaml       | 107 ++++++++++++++++
>  .../bindings/pci/tesla,pcie-fsd.yaml          | 117 ++++++++++++++++++
>  2 files changed, 224 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/tesla,pcie-fsd-ep.yaml
>  create mode 100644 Documentation/devicetree/bindings/pci/tesla,pcie-fsd.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/tesla,pcie-fsd-ep.yaml b/Documentation/devicetree/bindings/pci/tesla,pcie-fsd-ep.yaml
> new file mode 100644
> index 000000000000..07308cb9a35c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/tesla,pcie-fsd-ep.yaml

Filename based on compatible.

> @@ -0,0 +1,107 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/tesla,pcie-fsd-ep.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Synopsys DesignWare based PCIe EP controller on FSD SoCs
> +
> +maintainers:
> +  - Shradha Todi <shradha.t@samsung.com>
> +
> +description: |
> +  FSD PCIe EP controller is based on Synopsys DesignWare PCIe IP
> +  and thus inherits all the common properties defined in
> +  snps,dw-pcie-ep.yaml. The controller instance is dual mode and
> +  can work in Root port mode or Endpoint mode at a time.
> +
> +allOf:
> +  - $ref: /schemas/pci/snps,dw-pcie-ep.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - tesla,fsd-pcie-ep
> +
> +  reg:
> +    items:
> +      - description: controller's application logic registers
> +      - description: controller's own configuration registers
> +                     are available.
> +      - description: controller's own configuration shadow registers
> +                     are available.
> +      - description: Map the remote Root Complex slave address space
> +
> +  reg-names:
> +    items:
> +      - const: appl
> +      - const: dbi
> +      - const: dbi2
> +      - const: addr_space
> +
> +  clocks:
> +    items:
> +      - description: Auxiliary clock for PCIe
> +      - description: AHB clock for PCIe dbi
> +      - description: AHB clock for PCIe master
> +      - description: AHB clock for PCIe slave
> +
> +  clock-names:
> +    items:
> +      - const: aux_clk
> +      - const: dbi_clk
> +      - const: mstr_clk
> +      - const: slv_clk

Drop "_clk" everywhere.

> +
> +  interrupts:
> +    items:
> +      - description: Controller interrupt
> +
> +  interrupt-names:
> +    items:
> +      - const: sub_ctrl_intr

Drop entire property.

> +
> +  tesla,pcie-sysreg:
> +    $ref: '/schemas/types.yaml#/definitions/phandle-array'

Drop quotes.

In the PHY patch you said it is one phandle. Here it is an array. If it
is an array, then define it  properly:
https://elixir.bootlin.com/linux/v5.18-rc1/source/Documentation/devicetree/bindings/soc/samsung/exynos-usi.yaml#L42

> +    description: phandle for system control registers, used to
> +                 control signals at system level
> +
> +required:
> +

Drop blank line.

> +  - compatible
> +  - reg
> +  - reg-names
> +  - clocks
> +  - clock-names
> +  - ranges
> +  - num-lanes
> +  - tesla,pcie-sysreg
> +
> +additionalProperties: true

This must be false. Did you see such code anywhere in existing bindings?
Maybe you meant unevaluatedProperties?

> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/fsd-clk.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    pcie4_ep: pcie-ep@15400000 {
> +      compatible = "tesla,fsd-pcie-ep";
> +      clocks = <&clock_fsys0 PCIE_SUBCTRL_INST0_AUX_CLK_SOC>,
> +               <&clock_fsys0 PCIE_SUBCTRL_INST0_DBI_ACLK_SOC>,
> +               <&clock_fsys0 PCIE_SUBCTRL_INST0_MSTR_ACLK_SOC>,
> +               <&clock_fsys0 PCIE_SUBCTRL_INST0_SLV_ACLK_SOC>;
> +      clock-names = "aux_clk", "dbi_clk", "mstr_clk", "slv_clk";
> +      interrupts = <GIC_SPI 93 IRQ_TYPE_EDGE_RISING>;
> +      interrupt-names = "sub_ctrl_intr";
> +      reg = <0x15090000 0x1000>,

reg is a second property.

> +            <0x15400000 0x1000>,
> +            <0x15401000 0x80>,
> +            <0x15800000 0xFF0000>;

Lowercase hex.

> +      reg-names = "appl", "dbi", "dbi2", "addr_space";
> +      num-lanes = <4>;
> +      tesla,pcie-sysreg = <&sysreg_fsys0 0x434>;
> +      phys = <&pcie_phy0>;
> +      phy-names = "pcie_phy0";
> +      status = "disabled";

No status.

> +    };
> +...
> diff --git a/Documentation/devicetree/bindings/pci/tesla,pcie-fsd.yaml b/Documentation/devicetree/bindings/pci/tesla,pcie-fsd.yaml
> new file mode 100644
> index 000000000000..85648e5c7d27
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/tesla,pcie-fsd.yaml

All comments apply here as well.

> @@ -0,0 +1,117 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +
> +$id: http://devicetree.org/schemas/pci/tesla,pcie-fsd.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Synopsys DesignWare based PCIe controller on FSD SoCs
> +
> +maintainers:
> +  - Shradha Todi <shradha.t@samsung.com>
> +
> +description: |
> +  FSD PCIe controller is based on Synopsys DesignWare PCIe IP
> +  and thus inherits all the common properties defined in
> +  designware-pcie.txt.
> +
> +allOf:
> +  - $ref: /schemas/pci/snps,dw-pcie.yaml#
> +
> +properties:
> +  compatible:
> +    const: tesla,fsd-pcie
> +
> +  reg:
> +    items:
> +      - description: controller's application logic registers
> +      - description: controller's own configuration registers
> +                     are available.
> +      - description: configuration registers
> +
> +  reg-names:
> +    items:
> +      - const: appl
> +      - const: dbi
> +      - const: config
> +
> +  clocks:
> +    items:
> +      - description: Auxiliary clock for PCIe
> +      - description: AHB clock for PCIe dbi
> +      - description: AHB clock for PCIe master
> +      - description: AHB clock for PCIe slave
> +
> +  clock-names:
> +    items:
> +      - const: aux_clk
> +      - const: dbi_clk
> +      - const: mstr_clk
> +      - const: slv_clk
> +
> +  interrupts:
> +    minItems: 1
> +    items:
> +      - description: MSI interrupt
> +      - description: Controller interrupt
> +
> +  interrupt-names:
> +    minItems: 1
> +    items:
> +      - const: msi
> +      - const: sub_ctrl_intr

Drop "_intr"

> +
> +  tesla,pcie-sysreg:
> +    $ref: '/schemas/types.yaml#/definitions/phandle-array'
> +    description: phandle for system control registers, used to
> +                 control signals at system level
> +
> +required:
> +

?

> +  - compatible
> +  - reg
> +  - reg-names
> +  - clocks
> +  - clock-names
> +  - ranges
> +  - num-lanes
> +  - tesla,pcie-sysreg
> +
> +additionalProperties: true

false

> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/fsd-clk.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    bus {
> +      #address-cells = <2>;
> +      #size-cells = <2>;
> +
> +      pcie4_rc: pcie@15400000 {
> +        compatible = "tesla,fsd-pcie";
> +        clocks = <&clock_fsys0 PCIE_SUBCTRL_INST0_AUX_CLK_SOC>,
> +                 <&clock_fsys0 PCIE_SUBCTRL_INST0_DBI_ACLK_SOC>,
> +                 <&clock_fsys0 PCIE_SUBCTRL_INST0_MSTR_ACLK_SOC>,
> +                 <&clock_fsys0 PCIE_SUBCTRL_INST0_SLV_ACLK_SOC>;
> +        clock-names = "aux_clk", "dbi_clk", "mstr_clk", "slv_clk";
> +        #address-cells = <3>;
> +        #size-cells = <2>;
> +        dma-coherent;
> +        interrupts = <GIC_SPI 93 IRQ_TYPE_EDGE_RISING>;
> +        interrupt-names = "msi";
> +        num-lanes = <4>;
> +        reg = <0x0 0x15090000 0x0 0x1000>,
> +              <0x0 0x15400000 0x0 0x1000>,
> +              <0x0 0x15800000 0x0 0x1000>;

reg is always second. reg-names in such case third. ranges fourth.

> +        reg-names = "appl", "dbi", "config";


Best regards,
Krzysztof

