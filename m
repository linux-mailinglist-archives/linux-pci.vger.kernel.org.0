Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A943050085C
	for <lists+linux-pci@lfdr.de>; Thu, 14 Apr 2022 10:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232514AbiDNIbZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Thu, 14 Apr 2022 04:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiDNIbY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Apr 2022 04:31:24 -0400
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5184A5F8F5;
        Thu, 14 Apr 2022 01:29:00 -0700 (PDT)
Received: by mail-qv1-f48.google.com with SMTP id i14so3469208qvk.13;
        Thu, 14 Apr 2022 01:29:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=K4jhu4FAbusiwXx4SNoJui+7n/4ZIgbjfyFZftFmys0=;
        b=JrcpXosUGEQQVkkg7zGuv18azwIIm1RZrl8OIuzJ9kbcLPIDng9AEhg1pDrdvA7etV
         w6g0vpJftJtP/M3UF21AlSJxXt6t1q9786eV6BMAlYCbk/r3dHgJqHv/Xd4g8gvqe2gR
         /R4xD4QZSmfMexnJHbfY3fE/ZXqmGMGj8Gm93lm5pShGEeQVm7/Q0JBCINJD+QE2QKIN
         9oZfy+aBN09kLJMzGUX1uJ2rNc7wXAgBiT2kG6l5jAzmm4ZxneNZTOnh7vF+fTEM/LAo
         q3qnrtBjBcE4bmlLn+1TbeRIh0YYfNIql9ubgwn2Y64PAaDYsxv5jY0lYaM7bg2t7JAj
         UObw==
X-Gm-Message-State: AOAM533erq02vBBT5raJIDY/o57HdGr3v6kvZ2OemC35KrC7fYsb/LwM
        jzaU8e7tRZG4Xfycb/qETcFSPWYSvL9v2w==
X-Google-Smtp-Source: ABdhPJxF0bn1PAHoUKUoBadVoOG0HnPUZBjOTykhlucx9KNCLS1t5tBBdzcRNM9kM1iT4SsjPs2xjw==
X-Received: by 2002:a05:6214:c48:b0:440:cded:f2ab with SMTP id r8-20020a0562140c4800b00440cdedf2abmr11685831qvj.18.1649924939228;
        Thu, 14 Apr 2022 01:28:59 -0700 (PDT)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id j188-20020a3755c5000000b0067d1c76a09fsm679326qkb.74.2022.04.14.01.28.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Apr 2022 01:28:59 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-2ebf3746f87so47737447b3.6;
        Thu, 14 Apr 2022 01:28:58 -0700 (PDT)
X-Received: by 2002:a81:618b:0:b0:2db:d952:8a39 with SMTP id
 v133-20020a81618b000000b002dbd9528a39mr1106796ywb.132.1649924938578; Thu, 14
 Apr 2022 01:28:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220414074011.500533-1-herve.codina@bootlin.com> <20220414074011.500533-3-herve.codina@bootlin.com>
In-Reply-To: <20220414074011.500533-3-herve.codina@bootlin.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 14 Apr 2022 10:28:47 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUhr7emtsxoxGP5EH2EzNK=PM_7+-32cesecjQjoW1ryQ@mail.gmail.com>
Message-ID: <CAMuHMdUhr7emtsxoxGP5EH2EzNK=PM_7+-32cesecjQjoW1ryQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] dt-bindings: PCI: renesas-pci-usb: Convert
 bindings to json-schema
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Hervé,

On Thu, Apr 14, 2022 at 9:40 AM Herve Codina <herve.codina@bootlin.com> wrote:
> Convert Renesas PCI bridge bindings documentation to json-schema.
> Also name it 'renesas,pci-usb' as it is specifically used to
> connect the PCI USB controllers to AHB bus.
>
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Thanks a lot for tackling this DT binding file!

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/renesas,pci-usb.yaml
> @@ -0,0 +1,134 @@
> +# SPDX-License-Identifier: GPL-2.0

scripts/checkpatch.pl says:
WARNING: DT binding documents should be licensed (GPL-2.0-only OR BSD-2-Clause)

> +  reg:
> +    description: |
> +      A list of physical regions to access the device. The first is
> +      the operational registers for the OHCI/EHCI controllers and the
> +      second is for the bridge configuration and control registers.
> +    minItems: 2
> +    maxItems: 2

reg:
  items:
    - description: Operational registers for the OHCI/EHCI controllers.
    - description: Bridge configuration and control registers.

> +
> +  interrupts:
> +    description: Interrupt for the device.

maxItems: 1

The description is not needed.

> +
> +  interrupt-map:
> +    description: |
> +      Standard property used to define the mapping of the PCI interrupts
> +      to the GIC interrupts.
> +
> +  interrupt-map-mask:
> +    description:
> +      Standard property that helps to define the interrupt mapping.
> +
> +  clocks:
> +    description: The reference to the device clock.

maxItems: 1

The description is not needed.

Missing "resets" and "power-domains" properties.

Missing description of the child nodes.

> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - interrupt-map
> +  - interrupt-map-mask
> +  - clocks

Missing "resets" and "power-domains".

> +  - bus-range
> +  - "#address-cells"
> +  - "#size-cells"
> +  - "#interrupt-cells"
> +
> +unevaluatedProperties: false

Why doesn't "make dtbs_check" complain about the presence of
e.g. "resets" in the actual DTS files?

> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/r8a7790-cpg-mssr.h>
> +
> +    bus {
> +        #address-cells = <2>;
> +        #size-cells = <2>;

I think you should drop this (and the corresponding high addresses
below).

> +
> +        pci0: pci@ee090000  {
> +            compatible = "renesas,pci-r8a7790", "renesas,pci-rcar-gen2";
> +            device_type = "pci";
> +            clocks = <&cpg CPG_MOD 703>;
> +            reg = <0 0xee090000 0 0xc00>,
> +                  <0 0xee080000 0 0x1100>;
> +            interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;

                        power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
                        resets = <&cpg 703>;

> +            status = "disabled";
> +
> +            bus-range = <0 0>;
> +            #address-cells = <3>;
> +            #size-cells = <2>;
> +            #interrupt-cells = <1>;
> +            ranges = <0x02000000 0 0xee080000 0 0xee080000 0 0x00010000>;
> +            dma-ranges = <0x42000000 0 0x40000000 0 0x40000000 0 0x40000000>;
> +            interrupt-map-mask = <0xf800 0 0 0x7>;
> +            interrupt-map = <0x0000 0 0 1 &gic GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>,
> +                            <0x0800 0 0 1 &gic GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>,
> +                            <0x1000 0 0 2 &gic GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
> +
> +            usb@1,0 {
> +                reg = <0x800 0 0 0 0>;
> +                phys = <&usb0 0>;
> +                phy-names = "usb";
> +            };
> +

ERROR: trailing whitespace
#249: FILE: Documentation/devicetree/bindings/pci/renesas,pci-usb.yaml:127:
+            $

> +            usb@2,0 {
> +                reg = <0x1000 0 0 0 0>;
> +                phys = <&usb0 0>;
> +                phy-names = "usb";
> +            };
> +        };
> +    };

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
