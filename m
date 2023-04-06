Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C990E6D9FB9
	for <lists+linux-pci@lfdr.de>; Thu,  6 Apr 2023 20:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240118AbjDFSZD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Apr 2023 14:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239721AbjDFSZC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Apr 2023 14:25:02 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D075B83
        for <linux-pci@vger.kernel.org>; Thu,  6 Apr 2023 11:24:59 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id lj25so3529428ejb.11
        for <linux-pci@vger.kernel.org>; Thu, 06 Apr 2023 11:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680805497;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6r4M3/20NCF90WldhYI6dBy2L6b19MPQ4oWqZe9uR0g=;
        b=xyGvIncYsvAhAnmjZ5hqP918pCTK9mrLNRX9uoc78LE60hSA5ZqTusKtU6yIBNf0Os
         n8Y5NH+7jPSViCl/GACJFqVwsXsH4hGZxJvKxLSvKSLj6mMiLuG41Cdmdg3TjXn5jt31
         bmF0EOejvTL0QaUEUEqg4BlKwMo2RnmoZetVTNE0dMfDVtYVeSiwFr1RyX8wC2tIPclC
         Uq/i34LsemyJo/uk/DEvluDNOqpPu/107PW87lCderC6KhWXV8jQJdEAlyGWCR5Vb9dB
         NJFttea7l5m8wPZ2b+apoV/0TIgBY0M9pr/A/i/dITy8V0rooegFiQbQ/lxglBAdA174
         FBZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680805497;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6r4M3/20NCF90WldhYI6dBy2L6b19MPQ4oWqZe9uR0g=;
        b=k05HxgnPqbuomr8LDR30BIlKC0IPajlfjB6F8uUQOzRWHGT9zmgoLBp+g1LBXP4YYR
         kO7VCduccabOxW2Bjdl1DPLGIoISlbVsIiE9YeR193AHKbSNasjAIJph9Rj0ihgMLz49
         yTqPkDp3ABwN/9a3nBrTdVz5hbZC9yTDry/eVCjGeQApTJHKPVm5XvV6IyXqq/POV0u2
         NGu7i/ice5jB7/DUYhF5n1TERw4O0LrchyRD51+HpdTyYZp/fkNEPWs/mMC8dIKsEa5Y
         bxnbPwRAHQwpItN96FzFLZVd83ff8hWKykp8nz/Y7wDC0/u4YzUBvL1m0Cg/ICD43bSd
         Hf3Q==
X-Gm-Message-State: AAQBX9dueWzLxM/UJMupTDUCqxo3xaahbentQ6rNIwxO8VTsz8NF0By4
        4ajF4D+Em3EUuJYGzBCTL0iajg==
X-Google-Smtp-Source: AKy350YYtP7sG8RlXl6/kG7vInHbk81rKWcqMST+cC4JCnS+hlXlOAvk9bgDGOeYBYvYlBFhj6q7ug==
X-Received: by 2002:a17:907:3f16:b0:8a5:8620:575 with SMTP id hq22-20020a1709073f1600b008a586200575mr9241478ejc.3.1680805497522;
        Thu, 06 Apr 2023 11:24:57 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed? ([2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed])
        by smtp.gmail.com with ESMTPSA id s27-20020a1709060c1b00b009475bd8f441sm1115544ejf.60.2023.04.06.11.24.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 11:24:57 -0700 (PDT)
Message-ID: <38bc48bf-7d8c-8ddd-861f-3b7f3d2edce6@linaro.org>
Date:   Thu, 6 Apr 2023 20:24:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v1 1/3] dt-binding: pci: add JH7110 PCIe dt-binding
 documents.
Content-Language: en-US
To:     Minda Chen <minda.chen@starfivetech.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-pci@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mason Huo <mason.huo@starfivetech.com>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Kevin Xie <kevin.xie@starfivetech.com>
References: <20230406111142.74410-1-minda.chen@starfivetech.com>
 <20230406111142.74410-2-minda.chen@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230406111142.74410-2-minda.chen@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 06/04/2023 13:11, Minda Chen wrote:
> Add PCIe controller driver dt-binding documents
> for StarFive JH7110 SoC platform.

Use subject prefixes matching the subsystem (which you can get for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching). Missing: 's'

Subject: drop second/last, redundant "dt-binding documents". The
"dt-bindings" prefix is already stating that these are bindings and
documentation.

Drop also full stop.

> 
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> ---
>  .../bindings/pci/starfive,jh7110-pcie.yaml    | 163 ++++++++++++++++++
>  1 file changed, 163 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/starfive,jh7110-pcie.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/starfive,jh7110-pcie.yaml b/Documentation/devicetree/bindings/pci/starfive,jh7110-pcie.yaml
> new file mode 100644
> index 000000000000..fa4829766195
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/starfive,jh7110-pcie.yaml
> @@ -0,0 +1,163 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/starfive,jh7110-pcie.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: StarFive JH7110 PCIe 2.0 host controller
> +
> +maintainers:
> +  - Minda Chen <minda.chen@starfivetech.com>
> +
> +allOf:
> +  - $ref: /schemas/pci/pci-bus.yaml#
> +  - $ref: /schemas/interrupt-controller/msi-controller.yaml#
> +
> +properties:
> +  compatible:
> +    const: starfive,jh7110-pcie
> +
> +  reg:
> +    maxItems: 2
> +
> +  reg-names:
> +    items:
> +      - const: reg
> +      - const: config
> +
> +  msi-parent: true
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 4
> +
> +  clock-names:
> +    items:
> +      - const: noc
> +      - const: tl
> +      - const: axi_mst0
> +      - const: apb
> +
> +  resets:
> +    items:
> +      - description: AXI MST0 reset
> +      - description: AXI SLAVE reset
> +      - description: AXI SLAVE0 reset
> +      - description: PCIE BRIDGE reset
> +      - description: PCIE CORE reset
> +      - description: PCIE APB reset
> +
> +  reset-names:
> +    items:
> +      - const: mst0
> +      - const: slv0
> +      - const: slv
> +      - const: brg
> +      - const: core
> +      - const: apb
> +
> +  starfive,stg-syscon:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    items:
> +      items:
> +        - description: phandle to System Register Controller stg_syscon node.
> +        - description: register0 offset of STG_SYSCONSAIF__SYSCFG register for PCIe.
> +        - description: register1 offset of STG_SYSCONSAIF__SYSCFG register for PCIe.
> +        - description: register2 offset of STG_SYSCONSAIF__SYSCFG register for PCIe.
> +        - description: register3 offset of STG_SYSCONSAIF__SYSCFG register for PCIe.
> +    description:
> +      The phandle to System Register Controller syscon node and the offset
> +      of STG_SYSCONSAIF__SYSCFG register for PCIe. Total 4 regsisters offset
> +      for PCIe.
> +
> +  pwren-gpios:
> +    description: Should specify the GPIO for controlling the PCI bus device power on.

What are these? Different than defined in gpio-consumer-common?

> +    maxItems: 1
> +
> +  reset-gpios:
> +    maxItems: 1
> +
> +  phys:
> +    maxItems: 1
> +
> +  interrupt-controller:
> +    type: object
> +    properties:
> +      '#address-cells':
> +        const: 0
> +
> +      '#interrupt-cells':
> +        const: 1
> +
> +      interrupt-controller: true
> +
> +    required:
> +      - '#address-cells'
> +      - '#interrupt-cells'
> +      - interrupt-controller
> +
> +    additionalProperties: false
> +
> +required:
> +  - reg
> +  - reg-names
> +  - "#interrupt-cells"

Keep consistent quotes - either ' or "

Are you sure this is correct? You have interrupt controller as child node.


> +  - interrupts
> +  - interrupt-map-mask
> +  - interrupt-map
> +  - clocks
> +  - clock-names
> +  - resets
> +  - msi-controller
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    bus {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        pcie0: pcie@2B000000 {

Lowercase hex. Everywhere.

> +            compatible = "starfive,jh7110-pcie";
> +            #address-cells = <3>;
> +            #size-cells = <2>;
> +            #interrupt-cells = <1>;
> +            reg = <0x0 0x2B000000 0x0 0x1000000>,
> +                  <0x9 0x40000000 0x0 0x10000000>;

reg (and reg-names and ranges) is always second property.

> +            reg-names = "reg", "config";
> +            device_type = "pci";
> +            starfive,stg-syscon = <&stg_syscon 0xc0 0xc4 0x130 0x1b8>;
> +            bus-range = <0x0 0xff>;
> +            ranges = <0x82000000  0x0 0x30000000  0x0 0x30000000 0x0 0x08000000>,
> +                     <0xc3000000  0x9 0x00000000  0x9 0x00000000 0x0 0x40000000>;
> +            interrupt-parent = <&plic>;
> +            interrupts = <56>;
> +            interrupt-map-mask = <0x0 0x0 0x0 0x7>;
> +            interrupt-map = <0x0 0x0 0x0 0x1 &pcie_intc0 0x1>,
> +                            <0x0 0x0 0x0 0x2 &pcie_intc0 0x2>,
> +                            <0x0 0x0 0x0 0x3 &pcie_intc0 0x3>,
> +                            <0x0 0x0 0x0 0x4 &pcie_intc0 0x4>;


Best regards,
Krzysztof

