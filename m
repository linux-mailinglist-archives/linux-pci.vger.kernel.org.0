Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1816DF1CD
	for <lists+linux-pci@lfdr.de>; Wed, 12 Apr 2023 12:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjDLKSC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Apr 2023 06:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbjDLKSB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Apr 2023 06:18:01 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7965730FF;
        Wed, 12 Apr 2023 03:17:59 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id qa44so27146136ejc.4;
        Wed, 12 Apr 2023 03:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681294678;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PcDUlmxRY10X0YHmhy/Fi+Rk8z1h3TiNmSt5ErLw9W4=;
        b=DGfPyUoDRTIQzp1lmPfZIF7Ok/pIl6tEBRG4Fz9fac09VFqNNEQFoztcxaUPunqdA0
         iujWFxf9VBvUzff6T33wh6G7mrq3dZK54zcmaUMm5Oegj2OzfQSQpEinN2TLVu/3mOwY
         TFQzRTk5YZ7kGXA6lYAG3D19pmHk/AabQrtra3tb5zlEDq0X8LeQV1u3x27KzokkTwra
         XM0le3PAkgp7p8vbVMQmK/WhMDNCCAyd6rCQ20dso1NT0TPtmAucC43ilWNXMfyz+4I8
         k6C48JpiFfJN9SG57JzH2O5iRRvx/HqqCcNFUnN2qjxgIuVjMZaOWYxbURmrBRjTQ8lw
         vczw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681294678;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PcDUlmxRY10X0YHmhy/Fi+Rk8z1h3TiNmSt5ErLw9W4=;
        b=jrm4Hf6BSGUku21QekAiYrrFpNkp8zgfi1gELUeW2zJkJBpy+EaDOrdUUblVSg2t8A
         Ey0/S9mSf3DPj5s4O25e+KYqBWdfhMY83+eKDX6LcfN4mZPJQK/lNkyqPLJM9xSLQP3G
         o/n9Ifcl4P8+7/VyI1iH+4cWchu92LtdniEVQZfxP9czedqz8HXnqagsaOFLCSrO/gBq
         yNpl/RbafsMMrGREmlU66fJRU3t8MJYPhQMe1YO06v+wT8DQp7cquJ6ifMvwuEIGUUVN
         BoQT5tQEtYttLZR6mfQeQt5MIjdkuoWob1kUK5Jew55rQbPyxesniPjGp7p5oLljaU3e
         2JDg==
X-Gm-Message-State: AAQBX9ete9IHQPTesDopQqbptlvV9/aOg71WbDtdbZbeCyWF+9PgeH1d
        xr1lbHGIvTD7qP9ndKYRnWtq8MHpI23oJ+bujFg=
X-Google-Smtp-Source: AKy350a/P8S0sd/XT625mO06xi/NHGq3G+kmgZqDIKpER/L+xgfhmjOBoRRCob3Y7jllm2lR+6dyFPfl1+c481gx7Hw=
X-Received: by 2002:a17:906:9f0c:b0:949:87e1:5b32 with SMTP id
 fy12-20020a1709069f0c00b0094987e15b32mr2986699ejc.9.1681294677803; Wed, 12
 Apr 2023 03:17:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230406111142.74410-1-minda.chen@starfivetech.com> <20230406111142.74410-2-minda.chen@starfivetech.com>
In-Reply-To: <20230406111142.74410-2-minda.chen@starfivetech.com>
From:   Bin Meng <bmeng.cn@gmail.com>
Date:   Wed, 12 Apr 2023 18:17:46 +0800
Message-ID: <CAEUhbmVC6cx78G=-3FON8=B2rFOn4aU5z58gxeVY4t_U6k7eOA@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] dt-binding: pci: add JH7110 PCIe dt-binding documents.
To:     Minda Chen <minda.chen@starfivetech.com>
Cc:     Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-pci@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mason Huo <mason.huo@starfivetech.com>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Kevin Xie <kevin.xie@starfivetech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 6, 2023 at 7:59=E2=80=AFPM Minda Chen <minda.chen@starfivetech.=
com> wrote:
>
> Add PCIe controller driver dt-binding documents
> for StarFive JH7110 SoC platform.
>
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> ---
>  .../bindings/pci/starfive,jh7110-pcie.yaml    | 163 ++++++++++++++++++
>  1 file changed, 163 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/starfive,jh7110=
-pcie.yaml
>
> diff --git a/Documentation/devicetree/bindings/pci/starfive,jh7110-pcie.y=
aml b/Documentation/devicetree/bindings/pci/starfive,jh7110-pcie.yaml
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

Since this is a PLDA IP that is likely to be reused by other vendors,
should this indicate the PLDA in the string?

Or the file name should be renamed to something like the synopsis dw-pcie?

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
> +        - description: phandle to System Register Controller stg_syscon =
node.
> +        - description: register0 offset of STG_SYSCONSAIF__SYSCFG regist=
er for PCIe.
> +        - description: register1 offset of STG_SYSCONSAIF__SYSCFG regist=
er for PCIe.
> +        - description: register2 offset of STG_SYSCONSAIF__SYSCFG regist=
er for PCIe.
> +        - description: register3 offset of STG_SYSCONSAIF__SYSCFG regist=
er for PCIe.
> +    description:
> +      The phandle to System Register Controller syscon node and the offs=
et
> +      of STG_SYSCONSAIF__SYSCFG register for PCIe. Total 4 regsisters of=
fset
> +      for PCIe.
> +
> +  pwren-gpios:
> +    description: Should specify the GPIO for controlling the PCI bus dev=
ice power on.
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
> +        #address-cells =3D <2>;
> +        #size-cells =3D <2>;
> +
> +        pcie0: pcie@2B000000 {
> +            compatible =3D "starfive,jh7110-pcie";
> +            #address-cells =3D <3>;
> +            #size-cells =3D <2>;
> +            #interrupt-cells =3D <1>;
> +            reg =3D <0x0 0x2B000000 0x0 0x1000000>,
> +                  <0x9 0x40000000 0x0 0x10000000>;
> +            reg-names =3D "reg", "config";
> +            device_type =3D "pci";
> +            starfive,stg-syscon =3D <&stg_syscon 0xc0 0xc4 0x130 0x1b8>;
> +            bus-range =3D <0x0 0xff>;
> +            ranges =3D <0x82000000  0x0 0x30000000  0x0 0x30000000 0x0 0=
x08000000>,
> +                     <0xc3000000  0x9 0x00000000  0x9 0x00000000 0x0 0x4=
0000000>;
> +            interrupt-parent =3D <&plic>;
> +            interrupts =3D <56>;
> +            interrupt-map-mask =3D <0x0 0x0 0x0 0x7>;
> +            interrupt-map =3D <0x0 0x0 0x0 0x1 &pcie_intc0 0x1>,
> +                            <0x0 0x0 0x0 0x2 &pcie_intc0 0x2>,
> +                            <0x0 0x0 0x0 0x3 &pcie_intc0 0x3>,
> +                            <0x0 0x0 0x0 0x4 &pcie_intc0 0x4>;
> +            msi-parent =3D <&pcie0>;
> +            msi-controller;
> +            clocks =3D <&syscrg 86>,
> +                     <&stgcrg 10>,
> +                     <&stgcrg 8>,
> +                     <&stgcrg 9>;
> +            clock-names =3D "noc", "tl", "axi_mst0", "apb";
> +            resets =3D <&stgcrg 11>,
> +                     <&stgcrg 12>,
> +                     <&stgcrg 13>,
> +                     <&stgcrg 14>,
> +                     <&stgcrg 15>,
> +                     <&stgcrg 16>;
> +
> +            pcie_intc0: interrupt-controller {
> +                #address-cells =3D <0>;
> +                #interrupt-cells =3D <1>;
> +                interrupt-controller;
> +            };
> +        };
> +    };
> --

Regards,
Bin
