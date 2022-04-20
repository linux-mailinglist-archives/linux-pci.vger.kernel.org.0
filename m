Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C12B508912
	for <lists+linux-pci@lfdr.de>; Wed, 20 Apr 2022 15:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378892AbiDTNVj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Apr 2022 09:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242970AbiDTNVi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Apr 2022 09:21:38 -0400
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C096342A03;
        Wed, 20 Apr 2022 06:18:52 -0700 (PDT)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-e5bdd14b59so1873459fac.11;
        Wed, 20 Apr 2022 06:18:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=B3CbAt4ZX/EEyH49jyAg9jAZpFJcJq4CEXfhKoE4EjY=;
        b=BQ58M06eeS7/UfYa8nf7lS96baHMfKjTYrxmNuIn4Oy4/u9DkKNPSXlipQt3lbZ4pD
         KiHPOtAzDEVxlRHBMaksP0dAkNcsMs6E7LLf1XJLMPB9pHwqM6MKS0LqIkm3n9AT6jMl
         CUFGXfZlt6j2dT4U3NBw1u2lsAjCgwCZSob+bV8qdyq2PpKuGO02vYhhFEsrBG8y5ydd
         +82XB0i6ZgeETvjhK/c5ZaXJwPURx0bQ94bV+dzIZymc7K9z/wu6cn2xoMwcA6oycpJK
         XAhA7amK16MawkH5Y/IDvbZl4T/cm40d4SYxiX9V83LKcgQEfX3ZeFrLn2lARv4nWjaK
         ob7Q==
X-Gm-Message-State: AOAM531xW+7wBWPKUE9Ofn2wifzsCPmz/bKvZ1OQt5fAldqly3UjMJFx
        V4tRmxUmuanaLZq5ciBU7g==
X-Google-Smtp-Source: ABdhPJx2A5aMeqamW9lvDMpyT+zJ9u6tnpoQnlk5qYdgWXu62FfEJRvWdUGDP2ElX2LCKfRj2sQdZA==
X-Received: by 2002:a05:6870:538f:b0:e1:def7:7640 with SMTP id h15-20020a056870538f00b000e1def77640mr1486007oan.34.1650460731982;
        Wed, 20 Apr 2022 06:18:51 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t83-20020aca5f56000000b00322b2a08b85sm2418869oib.19.2022.04.20.06.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 06:18:51 -0700 (PDT)
Received: (nullmailer pid 1152994 invoked by uid 1000);
        Wed, 20 Apr 2022 13:18:50 -0000
Date:   Wed, 20 Apr 2022 08:18:50 -0500
From:   Rob Herring <robh@kernel.org>
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v2 2/8] dt-bindings: PCI: renesas-pci-usb: Convert
 bindings to json-schema
Message-ID: <YmAIOt1vAEzHGvBP@robh.at.kernel.org>
References: <20220414074011.500533-1-herve.codina@bootlin.com>
 <20220414074011.500533-3-herve.codina@bootlin.com>
 <YlhkwvGdcf4ozTzG@robh.at.kernel.org>
 <20220420144411.2d369b49@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420144411.2d369b49@bootlin.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 20, 2022 at 02:44:11PM +0200, Herve Codina wrote:
> Hi Rob,
> 
> On Thu, 14 Apr 2022 13:15:30 -0500
> Rob Herring <robh@kernel.org> wrote:
> 
> > On Thu, Apr 14, 2022 at 09:40:05AM +0200, Herve Codina wrote:
> > > Convert Renesas PCI bridge bindings documentation to json-schema.
> > > Also name it 'renesas,pci-usb' as it is specifically used to
> > > connect the PCI USB controllers to AHB bus.  
> > 
> > Please name it based on compatible strings. renesas,pci-rcar-gen2.yaml
> 
> Ok, renamed.
> 
> > 
> > > 
> > > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > > ---
> > >  .../devicetree/bindings/pci/pci-rcar-gen2.txt |  84 -----------
> > >  .../bindings/pci/renesas,pci-usb.yaml         | 134 ++++++++++++++++++
> > >  2 files changed, 134 insertions(+), 84 deletions(-)
> > >  delete mode 100644 Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt
> > >  create mode 100644 Documentation/devicetree/bindings/pci/renesas,pci-usb.yaml
> > > 
> > > diff --git a/Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt b/Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt
> > > deleted file mode 100644
> ...
> > > diff --git a/Documentation/devicetree/bindings/pci/renesas,pci-usb.yaml b/Documentation/devicetree/bindings/pci/renesas,pci-usb.yaml
> > > new file mode 100644
> ...
> > > index 000000000000..3f8d79b746c7
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/pci/renesas,pci-usb.yaml
> > > @@ -0,0 +1,134 @@
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/pci/renesas,pci-usb.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Renesas AHB to PCI bridge
> > > +
> > > +maintainers:
> > > +  - Marek Vasut <marek.vasut+renesas@gmail.com>
> > > +  - Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > > +
> > > +description: |
> > > +  This is the bridge used internally to connect the USB controllers to the
> > > +  AHB. There is one bridge instance per USB port connected to the internal
> > > +  OHCI and EHCI controllers.
> > > +
> > > +allOf:
> > > +  - $ref: /schemas/pci/pci-bus.yaml#
> > > +
> > > +properties:
> > > +  compatible:
> > > +    oneOf:
> > > +      - items:
> > > +          - enum:
> > > +              - renesas,pci-r8a7742      # RZ/G1H
> > > +              - renesas,pci-r8a7743      # RZ/G1M
> > > +              - renesas,pci-r8a7744      # RZ/G1N
> > > +              - renesas,pci-r8a7745      # RZ/G1E
> > > +              - renesas,pci-r8a7790      # R-Car H2
> > > +              - renesas,pci-r8a7791      # R-Car M2-W
> > > +              - renesas,pci-r8a7793      # R-Car M2-N
> > > +              - renesas,pci-r8a7794      # R-Car E2
> > > +          - const: renesas,pci-rcar-gen2 # R-Car Gen2 and RZ/G1
> > > +
> > > +  reg:
> > > +    description: |
> > > +      A list of physical regions to access the device. The first is
> > > +      the operational registers for the OHCI/EHCI controllers and the
> > > +      second is for the bridge configuration and control registers.
> > > +    minItems: 2
> > > +    maxItems: 2
> > > +
> > > +  interrupts:
> > > +    description: Interrupt for the device.
> > > +
> > > +  interrupt-map:
> > > +    description: |
> > > +      Standard property used to define the mapping of the PCI interrupts
> > > +      to the GIC interrupts.
> > > +
> > > +  interrupt-map-mask:
> > > +    description:
> > > +      Standard property that helps to define the interrupt mapping.
> > > +
> > > +  clocks:
> > > +    description: The reference to the device clock.
> > > +
> > > +  bus-range:
> > > +    description: |
> > > +      The PCI bus number range; as this is a single bus, the range
> > > +      should be specified as the same value twice.  
> > 
> > items:
> >   const: 0
> 
> Well, some other values are present in some dtsi files such as
> 'bus_range = <1 1>;' or 'bus_range = <2 2>;' in r8a7742.dtsi.
> 
> The constraint is to have the same value twice. Is there a way
> to specify this constraint ?

Yes, but probably not worthwhile. Just drop it as pci-bus.yaml already 
defines it.

> > > +
> > > +  "#address-cells":
> > > +    const: 3
> > > +
> > > +  "#size-cells":
> > > +    const: 2
> > > +
> > > +  "#interrupt-cells":
> > > +    const: 1  
> > 
> > All these are defined by pci-bus.yaml
> 
> Right.
> Replaced by:
> 
> "#address-cells": true
> "#size-cells": true
> "#interrupt-cells": true
> 
> Is that correct ?

You can just drop them completely.

Rob
