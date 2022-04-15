Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF18502D99
	for <lists+linux-pci@lfdr.de>; Fri, 15 Apr 2022 18:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244563AbiDOQRC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Apr 2022 12:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348085AbiDOQRA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Apr 2022 12:17:00 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C68A262FA;
        Fri, 15 Apr 2022 09:14:29 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id bq30so14707737lfb.3;
        Fri, 15 Apr 2022 09:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lW/qe2RzIm9tnnPJMQKGCEdZDn7PGESjeOP7WjKrFLg=;
        b=bx370Wablx32tXp7VwF7T2blFbFeERu1tAh9W+vL+8/Ow9cjlfFXYjIJJ+yKp5WStL
         BQb8ekRUUWuPnT+fn9ZHS9QWEQs2LLXH9Zhu2hsbAQsVriaBQf4JVSZs+Q+RVsGKuB1A
         Kn08rTKJ1tiiPF6A9iVSY2BktpWYy0v0b4vAnwdfAH8y7Lu8DdgTN3kqlDFNrX4RCrec
         wzteHngR9vJZfmrsJll7nQd9jZI0HpIHyxvBZvoSUBpqMyC/N3QswcujlVrXWQa3mqkW
         mOe9rbGx0QoXZ/LDiwM0U9D68NV2sHGoK6/c/9BnTiviGj1WxRIZzqnllLQuWTRbU5dn
         k3ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lW/qe2RzIm9tnnPJMQKGCEdZDn7PGESjeOP7WjKrFLg=;
        b=UbaA5IUU/mDwjoA32biOn61KEoebMAIWkh2VJhp6tZ8y3m9947nMw5DCIlBTyKZZdv
         baDaOmYkqxAZr2YSzqF56l55JpXf++J8vxiGUre4d7S5eaiYjXWad6eJ46c2qxy/1IYe
         7A/rP6Pjx4Z0DiUIlQH+7wwpo5V6oe8dxL4FV5YDNYxy0L3fHPetkloI5TqU0hP3/5o5
         yWubqDLmBsh0sobfCnojwSNBvroll3wlVi++hATt60rbEa8c8z0Z4s4Hl8VNqib4zMhp
         JuBCk8maIqcRg0ZNdtvtSp7RJH4gK4Js9vD55IFyiKF3YdO8aCnoefrmj02cti7wcG5L
         UGjw==
X-Gm-Message-State: AOAM532wANhdeUUmFWKW4X6muEKR8pBJixCy6g5+QoPpsbfRe4p6sdrx
        k3EQaJMSPozvyQ3SowWgkGM=
X-Google-Smtp-Source: ABdhPJw3KMiUM8MeDHDU4XDLlKfchX4Cnk7ttDbdYUi46AOWhx/89IEbfu2BxlalXTEaYp2Z7FTJNg==
X-Received: by 2002:ac2:43b3:0:b0:46f:3c3c:6b1c with SMTP id t19-20020ac243b3000000b0046f3c3c6b1cmr1879408lfl.148.1650039267640;
        Fri, 15 Apr 2022 09:14:27 -0700 (PDT)
Received: from mobilestation ([95.79.134.149])
        by smtp.gmail.com with ESMTPSA id f19-20020ac25cd3000000b0046bb620244dsm371317lfq.296.2022.04.15.09.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 09:14:25 -0700 (PDT)
Date:   Fri, 15 Apr 2022 19:14:23 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH 01/16] dt-bindings: PCI: dwc: Define generic and native
 DT bindings
Message-ID: <20220415161423.4ns6cgb3ydrte7hj@mobilestation>
References: <20220324013734.18234-1-Sergey.Semin@baikalelectronics.ru>
 <20220324013734.18234-2-Sergey.Semin@baikalelectronics.ru>
 <YkIejIE27RD4+8Z+@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkIejIE27RD4+8Z+@robh.at.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Rob,

On Mon, Mar 28, 2022 at 03:46:04PM -0500, Rob Herring wrote:
> On Thu, Mar 24, 2022 at 04:37:19AM +0300, Serge Semin wrote:
> > Currently both DW PCIe Root Port and End-point DT bindings are too generic
> > to be used as a descriptive set the device properties. Yes, it's very handy
> > to have them that way so the DT-schemas could be used to evaluate as many
> > DW PCIe-related DT-nodes as possible. But at the same time they don't
> > provide well defined DW PCIe RP/EP DT interface description thus leaving
> > too much flexibility for the new platforms, no encouraging the developers
> > to preserve a compatible interface.
> > 
> > Instead of currently implemented approach we suggest to be more
> > restrictive and yet preserve some level of flexibility in the DW PCIe
> > DT-bindings description. The device tree DT-schema is split up into
> > three parts: a common YAML-schema applicable for both DWC Root Port and
> > End-point controller configs, DWC PCIe Root Port-specific YAML-schema
> > and DWC PCIe End-point-specific YAML-schema, where
> > 1) pci/snps,dw-pcie-common.yaml - The common DT-schema describes the most
> > generic constraints of the "reg", "interrupts", "clocks", "resets" and
> > "phys" properties together with a set of common for both device types
> > PCIe/AXI bus properties like a maximum number of lanes or a maximum link
> > speed, number of inbound and outbound iATU windows. In addition to that a
> > set of schema definitions declared under the "$defs" property with "reg",
> > "interrupt", "clock" and "reset" names common for DWC PCIe Root Port and
> > End-point devices. They can be used by the successive DT-schemas in case
> > they are supposed to be compatible with the generic DWC PCIe controller
> > DT-bindings.
> > 2) pci/snps,dw-pcie.yaml, pci/snps,dw-pcie-ep.yaml - generic DW PCIe Root
> > Port and End-point DT-bindings which aside with the device-specific
> > properties set also contain more restrictive constraints. All new DW PCIe
> > platforms are supposed to be compatible with one of these bindings by
> > using "allOf: " property and additionally defining their own constraints
> > to close up the DT-bindings set.
> > 
> > So to speak in case if a DW PCIe-based device for some reason has too many
> > specific properties or it's bindings have already been defined in a
> > non-generic way, it's DT-schema is supposed to include 1) YAML-file and
> > provide its own constraints. Otherwise the ready-to-use bindings from 2)
> > should be utilized. There only two DT-schemas compatible with 2) at the
> > moment are samsung,axynos-pcie.yaml and intel-gw-pcie.yaml. The
> > rest of the DW PCIe-related DT-schemas are supposed to use more generic
> > DW PCIe DT-bindings - pci/snps,dw-pcie-common.yaml.
> > 
> > Note the provided here generic properties and their possible values are
> > derived from the DW PCIe RC/EP hardware manuals and from the interface
> > implemented in the driver. The DT-bindings schemas are created to be as
> > full as possible with detailed properties/names description for the
> > easier interface comprehension and new platforms bindings development.
> > 
> > Also note since there are no generic DT-nodes can be found in the kernel
> > dts-es which would have a pure "snps,dw-pcie" compatible string, these
> > DT-bindings have been created to not be selected by default for
> > evaluation. They are supposed to be used by the new vendor-specific
> > DT-schemas to at least stop adding new bindings for the same set of DWC
> > PCIe signals or properties.
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > 
> > ---
> > 
> > Rob, if you comment the "select: false" line out you'll get a lot of "'*'
> > is not of type 'array'" errors on the dt_bindings_check command execution.
> > I have spend tons of time trying to figure out what was wrong, but still
> > failed to find out a solution. For some reason the "$ref"-ed schemas
> > defined under the "$defs" basic property are considered by the parser as
> > defining an array. No matter whether I specified the "type: string"
> > keyword or not, as long as there is "enum" or "oneOf" keyword used in the
> > "*-names" property definition in "$defs" it's considered as describing an
> > array thus causing the errors like:
> 
> As-is, there were lots of errors...
> 
> > 
> > >  DTC     Documentation/devicetree/bindings/pci/snps,dw-pcie.example.dt.yaml
> > >  CHECK   Documentation/devicetree/bindings/pci/snps,dw-pcie.example.dt.yaml
> > > /.../snps,dw-pcie.example.dt.yaml: pcie@1f052000: reg-names:0: 'oneOf' conditional failed, one must be fixed:
> > >        'dbi' is not of type 'array'
> > >        From schema: /.../snps,dw-pcie.yaml
> > > /.../snps,dw-pcie.example.dt.yaml: pcie@1f052000: reg-names:1: 'oneOf' conditional failed, one must be fixed:
> > >         'config' is not of type 'array'
> > >         From schema: /.../snps,dw-pcie.yaml
> > > /.../snps,dw-pcie.example.dt.yaml: pcie@1f052000: interrupt-names:0: 'anyOf' conditional failed, one must be fixed:
> > >         /.../snps,dw-pcie.example.dt.yaml: pcie@1f052000: interrupt-names:0: 'oneOf' conditional failed, one must be fixed:
> > >                 'msi' is not of type 'array'
> > >         /../snps,dw-pcie.example.dt.yaml: pcie@1f052000: interrupt-names:0: 'oneOf' conditional failed, one must be fixed:
> > >                 'msi' is not of type 'array'
> > >         From schema: /.../snps,dw-pcie.yaml
> > 
> > As soon as I manually moved the same "$defs"-schemas into the places they
> > are referenced to, the errors disappeared and the DT-schemas validation
> > worked as expected by the semantics.
> > 
> > As I see it there must be some bug in the parser, otherwise I am out of
> > ideas how to implement the suggested in this patch design pattern. Rob,
> > could you take a look at the DT-schemas and help me out with debugging the
> > problem described above?
> 

> There is at least an error in your schema, details latter on.

It depends on the schema usage. Please see my next comments for the
detailed explanation what I am trying to achieve here and why it would
be very useful.

> 
> It could be an issue in the fixups which in general convert 
> schemas for strings to string arrays and scalars/arrays to matrix. You 
> have to look at processed-schema.json to debug it.
> 
> The other thing is 'oneOf' errors can be confusing in terms of error 
> messages because the tooling doesn't really know which entry had the 
> least error. Like the type was right, but some secondary constraint 
> failed (as what's secondary is not expressed in any way).
> 
> I would debug it further, but I don't really like the end result. I 
> think it's too hard to follow. For the most part, we avoid $refs at the 
> property level across different schema files with the big exception 
> being types.yaml. $defs are also used sparingly. The challenge is that 
> json-schema by default will be silent on schemas misformed in lots of 
> ways. Our meta-schema adds a lot of constraints which limits what the 
> schemas can look like and ensures schemas are valid. It also allows me 
> to define new constraints rather than repeat the same review comment 
> over and over.

I see your point, but in this case I suppose an exception would gain
good benefits too. Here is why.

As I said in the patch log the main idea of this modification was to
create a common schema for the DW PCIe compatible controllers which would
be more restrictive than the existing one but more descriptive and yet
extendable if required. So using $refs was the best method for such
case.

In the framework of this patch aside with a set of the generic DW PCIe
properties, I tried to implement the schemas for the string array with
a pre-defined set values. These schemas can be used to set the
constraints on the device-specific bindings or can be omitted if
either the bindings have already been defined in a different way or
the device is incompatible with the generic bindings for some reason.
Please see the schemas defined in the pci/snps,dw-pcie-common.yaml
file.

As you can see mainly the snps,dw-pcie-common.yaml schema contains the
normal properties descriptions like 'reg', 'clocks', 'interrupts',
'resets', etc. The only peculiarity is the sub-properties defined under
the "$defs" property. See, they aren't used in that file, but are
referenced in the snps,dw-pcie-ep.yaml and snps,dw-pcie.yaml schemas in
order to create the corresponding string arrays constraints. See my
next comments for the further explanation.

> 
> > ---
> >  .../bindings/pci/fsl,imx6q-pcie.yaml          |   5 +-
> >  .../bindings/pci/hisilicon,kirin-pcie.yaml    |   4 +-
> >  .../bindings/pci/sifive,fu740-pcie.yaml       |   4 +-
> >  .../bindings/pci/snps,dw-pcie-common.yaml     | 298 ++++++++++++++++++
> >  .../bindings/pci/snps,dw-pcie-ep.yaml         | 143 ++++++---
> >  .../devicetree/bindings/pci/snps,dw-pcie.yaml | 189 +++++++----
> >  .../bindings/pci/toshiba,visconti-pcie.yaml   |   2 +-
> >  7 files changed, 524 insertions(+), 121 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
> 
> 
> > diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
> > new file mode 100644
> > index 000000000000..27fe1f5c450f
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
> > @@ -0,0 +1,298 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/pci/snps,dw-pcie-common.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Synopsys DWC PCIe RP/EP controller
> > +
> > +maintainers:
> > +  - Jingoo Han <jingoohan1@gmail.com>
> > +  - Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> > +
> > +properties:
> > +  reg:
> > +    description:
> > +      DWC PCIe CSR space is normally accessed over the dedicated Data Bus
> > +      Interface - DBI. In accordance with the reference manual the register
> > +      configuration space belongs to the Configuration-Dependent Module (CDM)
> > +      and is split up into several sub-parts Standard PCIe configuration
> > +      space, Port Logic Registers (PL), Shadow Config-space Registers,
> > +      iATU/eDMA registers. The particular sub-space is selected by the
> > +      CDM/ELBI (dbi_cs) and CS2 (dbi_cs2) signals (selector bits). Such
> > +      configuration provides a flexible interface for the system engineers to
> > +      either map the particular space at a desired MMIO address or just leave
> > +      them in a contiguous memory space if pure Native or AXI Bridge DBI access
> > +      is selected. Note the PCIe CFG-space, PL and Shadow registers are
> > +      specific to each activated function, while the rest of the sub-spaces
> > +      are common for all of them (if there are more than one).
> > +    minItems: 2
> > +    maxItems: 6
> > +
> > +  interrupts:
> > +    description:
> > +      There are two main sub-blocks which are normally capable of
> > +      generating interrupts. It's System Information Interface and MSI
> > +      interface. While the former one has some common for the Host and
> > +      End-point controllers IRQ-signals, the later interface is obviously
> > +      Root Complex specific since it's responsible for the incoming MSI
> > +      messages signalling. The System Information IRQ signals are mainly
> > +      responsible for reporting the generic PCIe hierarchy and Root
> > +      Complex events like VPD IO request, general AER, PME, Hot-plug, link
> > +      bandwidth change, link equalization request, INTx asserted/deasserted
> > +      Message detection, embedded DMA Tx/Rx/Error.
> > +    minItems: 1
> > +    maxItems: 26
> > +
> > +  clocks:
> > +    description:
> > +      DWC PCIe reference manual explicitly defines a set of the clocks required
> > +      to get the controller working correctly. In general all of them can
> > +      be divided into two groups':' application and core clocks. Note the
> > +      platforms may have some of the clock sources unspecified in case if the
> > +      corresponding domains are fed up from a common clock source.
> > +    minItems: 1
> > +    maxItems: 7
> > +
> > +  resets:
> > +    description:
> > +      DWC PCIe reference manual explicitly defines a set of the reset
> > +      signals required to be de-asserted to properly activate the controller
> > +      sub-parts. All of these signals can be divided into two sub-groups':'
> > +      application and core resets with respect to the main sub-domains they
> > +      are supposed to reset. Note the platforms may have some of these signals
> > +      unspecified in case if they are automatically handled or aggregated into
> > +      a comprehensive control module.
> > +    minItems: 1
> > +    maxItems: 10
> > +
> > +  reset-gpio:
> > +    deprecated: true
> > +    description:
> > +      Reference to the GPIO-controlled PERST# signal. It is used to reset all
> > +      the peripheral devices available on the PCIe bus.
> > +    maxItems: 1
> > +
> > +  reset-gpios:
> > +    description:
> > +      Reference to the GPIO-controlled PERST# signal. It is used to reset all
> > +      the peripheral devices available on the PCIe bus.
> > +    maxItems: 1
> > +
> > +  phys:
> > +    description:
> > +      There can be up to number of possible lanes PHYs specified.
> > +      Obviously each specified PHY is supposed to be able to work in the
> > +      PCIe mode with a speed implied by the DWC PCIe controller it is
> > +      attached to.
> > +    minItems: 1
> > +    maxItems: 16
> > +
> > +  phy-names:
> > +    minItems: 1
> > +    maxItems: 16
> > +    items:
> > +      pattern: '^pcie([0-9]+|-?phy)?$'
> > +
> > +  num-lanes:
> > +    maximum: 16
> > +
> > +  max-link-speed:
> > +    maximum: 4
> > +
> > +  num-ob-windows:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    deprecated: true
> > +    description:
> > +      Number of outbound address translation windows. This parameter can be
> > +      auto-detected based on the iATU memory writability. So there is no
> > +      point in having a dedicated DT-property for it.
> > +    maximum: 256
> > +
> > +  num-ib-windows:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    deprecated: true
> > +    description:
> > +      Number of inbound address translation windows. In the same way as
> > +      for the outbound AT windows, this parameter can be auto-detected based
> > +      on the iATU memory writability. There is no point having a dedicated
> > +      DT-property for it either.
> > +    maximum: 256
> > +
> > +  num-viewport:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    deprecated: true
> > +    description:
> > +      Number of outbound view ports configured in hardware. It's the same as
> > +      the number of outbound AT windows.
> > +    maximum: 256
> > +
> > +  snps,enable-cdm-check:
> > +    $ref: /schemas/types.yaml#/definitions/flag
> > +    description:
> > +      Enable automatic checking of CDM (Configuration Dependent Module)
> > +      registers for data corruption. CDM registers include standard PCIe
> > +      configuration space registers, Port Logic registers, DMA and iATU
> > +      registers. This feature has been available since DWC PCIe v4.80a.
> > +
> > +additionalProperties: true
> > +
> > +$defs:
> > +  reg-names:
> > +    description:
> > +      CSR space names common for the DWC PCIe Root Port and End-point
> > +      controllers.
> > +    oneOf:
> > +      - description:
> > +          Basic DWC PCIe controller configuration-space accessible over
> > +          the DBI interface. This memory space is either activated with
> > +          the CDM/ELBI = 0 and CS2 = 0 or is a contiguous memory region
> > +          with all spaces. Note iATU/eDMA CSRs are indirectly accessible
> > +          via the PL viewports on the DWC PCIe controllers older than
> > +          v4.80a.
> > +        const: dbi
> 

> This passes only for 'reg-names = "dbi";'

No, if the defined here "reg-names" schema is correctly referenced. See my
next comments.

> 
> > +      - description:
> > +          Shadow DWC PCIe config-space registers. This space is selected
> > +          by setting CDM/ELBI = 0 and CS2 = 1. This is an intermix of
> > +          the PCI-SIG PCIe CFG-space with the shadow registers for some
> > +          PCI Header space, PCI Standard and Extended Structures. It's
> > +          mainly relevant for the end-point controller configuration,
> > +          but still there are some shadow registers available for the
> > +          Root Port mode too.
> > +        const: dbi2
> 

> This passes only for 'reg-names = "dbi2";'

ditto

> 
> > +      - description:
> > +          External Local Bus registers. It's an application-dependent
> > +          registers normally defined by the platform engineers, which
> > +          are selected by setting CDM/ELBI = 1 and CS2 = 0.
> > +        enum: [ elbi, appl, app ]
> 

> This passes only for 'reg-names = "elbi", "appl", "app";'
> 
> See the problem? Replacing the 'oneOf' above with 'items' is what you 
> want. But then the schema will not allow any missing entries either. 
> DBI2 is optional for example. There is no way in json-schema to define a 
> list of ordered values(string) once and say some entries are optional 
> which I think is what you are trying to do here.

Please see the way the "$defs: *-names" properties are referenced in
the framework of this patch. My idea was to define a set of strings in
the "$defs: *-names" properties here. Then re-use that set to define
the device-specific constraints. That's why I've intentionally used
'oneOf'-based composition so the properties could be used to set a
constraints on !each! item of the corresponding strings array, but not
on the whole array as you suggest by replacing 'oneOf' with 'items'.
BTW the ordering can be defined in the corresponding schemas if it's
required. 

As an example please see the json schema of the generic DWC
PCIe End-point reg-names property I am trying to achieve here:
https://www.jsonschemavalidator.net/s/eGV3M3gK

As you can see it makes sure the reg-names array contains at least
the "dbi", "dbi2" and "addr_space" strings and may also have the
optional CSR names if it's specific to the corresponding platform.

If you need the ordered set of the strings then the next schema
can be used:
https://www.jsonschemavalidator.net/s/53KKrXV9

Regarding the ordering. As I see it, it isn't something what we need
in the modern bindings in the reference to the "*-names" properties
since the new drivers mainly rely on getting the CSR maps, interrupts,
clocks and resets by their names rather than a position in the 'reg'
phandles array. The CSRs order isn't something what hardware defines
either. Moreover tons of the DT source files don't really have the
reg-names, clock-names, etc properties initialized with some strict
order. So if we want the schema to be applicable for the already
created DT sources the ordering constraints need to be avoided.

Getting back to the patch. As I said in the patch log, alas I failed
to reproduce the described schema in the DT bindings due to the
denoted error. Seeing the JSON-schema examples are working and so does
the DT-schema parser if I manually move the "$defs: *-names" schemas
content in the place of the references, there must be some problem
with the parser. That's why I asked your help with debugging.

> 
> > +      - description:
> > +          iATU/eDMA registers common for all device functions. It's an
> > +          unrolled memory space with the internal Address Translation
> > +          Unit and Enhanced DMA, which is selected by setting CDM/ELBI = 1
> > +          and CS2 = 1. For IP-core releases prior v4.80a, these registers
> > +          have been programmed via an indirect addressing scheme using a
> > +          set of viewport CSRs mapped into the PL space. Note iATU is
> > +          normally mapped to the 0x0 address of this region, while eDMA
> > +          is available at 0x80000 base address.
> > +        enum: [ atu, atu_dma ]
> > +      - description:
> > +          Outbound iATU-available memory-region which usage scenario
> > +          depends on the DWC PCIe controller being either Root Port or
> > +          End-point. If it's Root Port then the register space shall
> > +          have the "config" name and it will be used to access the
> > +          peripheral PCIe devices configuration space. If it's PCIe
> > +          end-point controller, then the region shall be named as
> > +          "addr_space" and it will be used to generate various traffic
> > +          on the PCIe bus hierarchy. It's usage scenario depends on the
> > +          end-point functionality, for instance it can be used to create
> > +          MSI(X) messages.
> > +        enum: [ config, addr_space ]
> 

> So 'addr_space' is now valid for host mode?

Well, in general this reg-space is supposed to be of the same memory
space type - outbound iATU sub-region - for both Host and End-point
controller, but the names are different for them. Anyway basically you
are right, the schemas referencing this property will permit having
both reg names. I can split this property up into two: "$defs:
host-reg-names" and "$defs: ep-reg-names" and use the new schemas in
the Host and EP reg-names property constraints respectively. What do
you think?

> 
> (Really, for DW blocks with iATU, this should have been the whole memory 
> space and the driver could size the config space itself. (IOW, the 
> config region is configuration rather than h/w description.)

I am fully agree with you but the addr/config-space reg-bindings have
already been defined that way. It is implemented in the DWC PCIe driver
and many DT files rely on having that bindings implemented. So alas
nothing we can do about it.

> 
> > +      - description:
> > +          PHY/PCS configuration registers. Some platforms can have the
> > +          PCS and PHY CSRs accessible over a dedicated memory mapped
> > +          region, but mainly these registers are indirectly accessible
> > +          either by means of the embedded PHY viewport schema or by some
> > +          platform-specific method.
> > +        enum: [ link, phy ]
> 

> These should not be in any new users as the phy should be separate.

I agree, but these names have already been referenced in some glue
drivers so does the DW PCIe Host/EP manual have the PHY/PCS CSRs IO
interface described. Thus we have to have them described here for the
sake of compatibility.

> 
> > +
> > +  interrupt-names:
> > +    description:
> > +      IRQ signal names common for the DWC PCIe Root Port and End-point
> > +      controllers.
> > +    oneOf:
> > +      - description:
> > +          Controller request to read or write virtual product data
> > +          from/to the VPD capability registers.
> > +        const: vpd
> > +      - description:
> > +          Link Equalization Request flag is set in the Link Status 2
> > +          register (applicable if the corresponding IRQ is enabled in
> > +          the Link Control 3 register).
> > +        const: l_eq
> > +      - description:
> > +          Indicates that the eDMA Tx/Rx transfer is complete or that an
> > +          error has occurred on the corresponding channel. eDMA can have
> > +          eight Tx (Write) and Rx (Read) eDMA channels thus supporting up
> > +          to 16 IRQ signals all together. Write eDMA channels shall go
> > +          first in the ordered row as per default edma_int[*] bus setup.
> > +        pattern: '^dma([0-9]|1[0-5])?$'
> > +      - description:
> > +          PCIe protocol correctable error or a Data Path protection
> > +          correctable error is detected by the automotive/safety
> > +          feature.
> > +        const: sft_ce
> > +      - description:
> > +          Indicates that the internal safety mechanism detected and
> > +          uncorrectable error.
> > +        const: sft_ue
> 

> This says there is only a single interrupt entry. Same for the other 
> $defs.

No, this property is supposed to be considered as applicable to each
"interrupt-names" item, not for the whole array. Please see my comments
before.

-Sergey

> 
> Rob
