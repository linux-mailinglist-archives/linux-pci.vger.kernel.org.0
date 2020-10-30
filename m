Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00A702A088E
	for <lists+linux-pci@lfdr.de>; Fri, 30 Oct 2020 15:55:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgJ3Ozw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Oct 2020 10:55:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:45006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726613AbgJ3Ozw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 30 Oct 2020 10:55:52 -0400
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CF182075E;
        Fri, 30 Oct 2020 14:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604069750;
        bh=w+AFqyT7csNm/cofYMsxvo50coneCRgT0/3GxwEm+2o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IfSpMJOzGtNQzCVFawWiN9zajFKz7gP1nwrryacWdykhwhuwajqZFLdVrzbCw0qFl
         EixPswl+ei0cNB0FldjovofY+RNxlGliypisFE6QOJelMyu0YitBN6W/SDULyXQSAb
         MImNF+gEMHHeEaqDrM7xr317fxjp5PkhsQnHV3p4=
Received: by mail-oi1-f178.google.com with SMTP id w145so1249281oie.9;
        Fri, 30 Oct 2020 07:55:50 -0700 (PDT)
X-Gm-Message-State: AOAM530QOLVsl3GZtU89o9q2Oh77G+7S+6+bH+Yg0C8D0J/gqMTam3tj
        zhsD9iSzJ/iHR8eQa5Fd53xZlZtG/GuK7y8mCA==
X-Google-Smtp-Source: ABdhPJw9wmyWZxSrd/h0+3ol2T46r4MkxkF2xJfPDMJg/vonxvCTG/IEneZTGif7J5K0LnVZ3TCzw00dr1fq7+mvbjw=
X-Received: by 2002:aca:5dc2:: with SMTP id r185mr1925932oib.106.1604069749356;
 Fri, 30 Oct 2020 07:55:49 -0700 (PDT)
MIME-Version: 1.0
References: <20201027060011.25893-1-wan.ahmad.zainie.wan.mohamad@intel.com>
 <20201027060011.25893-2-wan.ahmad.zainie.wan.mohamad@intel.com>
 <20201028144219.GA3966314@bogus> <DM6PR11MB3721FA210CD596C4C64306F8DD150@DM6PR11MB3721.namprd11.prod.outlook.com>
In-Reply-To: <DM6PR11MB3721FA210CD596C4C64306F8DD150@DM6PR11MB3721.namprd11.prod.outlook.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 30 Oct 2020 09:55:37 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+1HiYK09+piSqJz0Jo+F3XXfg0+qpKQSDL7G32c2P4Eg@mail.gmail.com>
Message-ID: <CAL_Jsq+1HiYK09+piSqJz0Jo+F3XXfg0+qpKQSDL7G32c2P4Eg@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: PCI: Add Intel Keem Bay PCIe controller
To:     "Wan Mohamad, Wan Ahmad Zainie" 
        <wan.ahmad.zainie.wan.mohamad@intel.com>
Cc:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 30, 2020 at 8:05 AM Wan Mohamad, Wan Ahmad Zainie
<wan.ahmad.zainie.wan.mohamad@intel.com> wrote:
>
> Hi Rob.
>
> Thanks for the review.
>
> > -----Original Message-----
> > From: Rob Herring <robh@kernel.org>
> > Sent: Wednesday, October 28, 2020 10:42 PM
> > To: Wan Mohamad, Wan Ahmad Zainie
> > <wan.ahmad.zainie.wan.mohamad@intel.com>
> > Cc: bhelgaas@google.com; lorenzo.pieralisi@arm.com; linux-
> > pci@vger.kernel.org; devicetree@vger.kernel.org;
> > andriy.shevchenko@linux.intel.com; mgross@linux.intel.com; Raja
> > Subramanian, Lakshmi Bai <lakshmi.bai.raja.subramanian@intel.com>
> > Subject: Re: [PATCH 1/2] dt-bindings: PCI: Add Intel Keem Bay PCIe controller
> >
> > On Tue, Oct 27, 2020 at 02:00:10PM +0800, Wan Ahmad Zainie wrote:
> > > Document DT bindings for PCIe controller found on Intel Keem Bay SoC.
> > >
> > > Signed-off-by: Wan Ahmad Zainie
> > > <wan.ahmad.zainie.wan.mohamad@intel.com>
> > > ---
> > >  .../bindings/pci/intel,keembay-pcie-ep.yaml   |  86 +++++++++++++
> > >  .../bindings/pci/intel,keembay-pcie.yaml      | 120 ++++++++++++++++++
> > >  2 files changed, 206 insertions(+)
> > >  create mode 100644
> > > Documentation/devicetree/bindings/pci/intel,keembay-pcie-ep.yaml
> > >  create mode 100644
> > > Documentation/devicetree/bindings/pci/intel,keembay-pcie.yaml
> > >
> > > diff --git
> > > a/Documentation/devicetree/bindings/pci/intel,keembay-pcie-ep.yaml
> > > b/Documentation/devicetree/bindings/pci/intel,keembay-pcie-ep.yaml
> > > new file mode 100644
> > > index 000000000000..11962c205744
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/pci/intel,keembay-pcie-
> > ep.yaml
> > > @@ -0,0 +1,86 @@
> > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause) %YAML 1.2
> > > +---
> > > +$id: "http://devicetree.org/schemas/pci/intel,keembay-pcie-ep.yaml#"
> > > +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> > > +
> > > +title: Intel Keem Bay PCIe EP controller
> > > +
> > > +maintainers:
> > > +  - Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
> > > +
> > > +properties:
> > > +  compatible:
> > > +      const: intel,keembay-pcie-ep
>
> Fixed in v2, wrong indentation as per report.
>
> > > +
> > > +  reg:
> > > +    items:
> > > +      - description: DesignWare PCIe registers
> > > +      - description: PCIe configuration space
> > > +      - description: Keem Bay specific registers
> > > +
> > > +  reg-names:
> > > +    items:
> > > +      - const: dbi
> > > +      - const: addr_space
> > > +      - const: apb
> > > +
> > > +  interrupts:
> > > +    items:
> > > +      - description: PCIe interrupt
> > > +      - description: PCIe event interrupt
> > > +      - description: PCIe error interrupt
> > > +      - description: PCIe memory access interrupt
> > > +
> > > +  interrupt-names:
> > > +    items:
> > > +      - const: intr
> > > +      - const: ev_intr
> > > +      - const: err_intr
> > > +      - const: mem_access_intr
> >
> > '_intr' is redundant. Drop it. You'll need a better name for the first one
> > though.
>
> I will drop _intr in v2.
> I will send out once I get suitable name from Keem Bay data book.
>
> >
> > > +
> > > +  num-ib-windows:
> > > +    description: Number of inbound address translation windows
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +
> > > +  num-ob-windows:
> > > +    description: Number of outbound address translation windows
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +
> > > +  num-lanes:
> > > +    description: Number of lanes to use.
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +    enum: [ 1, 2, 4, 8 ]
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - reg-names
> > > +  - interrupts
> > > +  - interrupt-names
> > > +  - num-ib-windows
> > > +  - num-ob-windows
> > > +
> > > +additionalProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > > +    #include <dt-bindings/interrupt-controller/irq.h>
> > > +  - |
> > > +    pcie-ep@37000000 {
> > > +          compatible = "intel,keembay-pcie-ep";
> > > +          reg = <0x37000000 0x00800000>,
> > > +                <0x36000000 0x01000000>,
> > > +                <0x37800000 0x00000200>;
> > > +          reg-names = "dbi", "addr_space", "apb";
> > > +          interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>,
> > > +                       <GIC_SPI 108 IRQ_TYPE_EDGE_RISING>,
> > > +                       <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
> > > +                       <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
> > > +          interrupt-names = "intr", "ev_intr", "err_intr",
> > > +                       "mem_access_intr";
> > > +          num-ib-windows = <4>;
> > > +          num-ob-windows = <4>;
> > > +          num-lanes = <2>;
> > > +    };
> > > diff --git
> > > a/Documentation/devicetree/bindings/pci/intel,keembay-pcie.yaml
> > > b/Documentation/devicetree/bindings/pci/intel,keembay-pcie.yaml
> > > new file mode 100644
> > > index 000000000000..49e5d3d35bd4
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/pci/intel,keembay-pcie.yaml
> > > @@ -0,0 +1,120 @@
> > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause) %YAML 1.2
> > > +---
> > > +$id: "http://devicetree.org/schemas/pci/intel,keembay-pcie.yaml#"
> > > +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> > > +
> > > +title: Intel Keem Bay PCIe RC controller
> > > +
> > > +maintainers:
> > > +  - Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
> > > +
> > > +allOf:
> > > +  - $ref: /schemas/pci/pci-bus.yaml#
> > > +
> > > +properties:
> > > +  compatible:
> > > +      const: intel,keembay-pcie
>
> Wrong indentation as per report.
> I will fix in v2.
>
> >
> > > +
> > > +  device_type:
> > > +    const: pci
> > > +
> > > +  "#address-cells":
> > > +    const: 3
> > > +
> > > +  "#size-cells":
> > > +    const: 2
> >
> > Can drop these 3 as pci-bus.yaml defines them.
>
> I will drop these 3 in v2.
>
> >
> > > +
> > > +  ranges:
> > > +    maxItems: 1
> > > +
> > > +  reset-gpios:
> > > +    maxItems: 1
> > > +
> > > +  reg:
> > > +    items:
> > > +      - description: DesignWare PCIe registers
> > > +      - description: PCIe configuration space
> > > +      - description: Keem Bay specific registers
> > > +
> > > +  reg-names:
> > > +    items:
> > > +      - const: dbi
> > > +      - const: config
> > > +      - const: apb
> > > +
> > > +  clocks:
> > > +    items:
> > > +      - description: bus clock
> > > +      - description: auxiliary clock
> >
> > The EP doesn't have clocks? You should have roughly the same resources for
> > RC and EP modes.
>
> For Keem Bay, EP mode link initialization is done in boot firmware.
> This include setup the clocks.
> That's why I do not include clocks for EP.
>
> >
> > > +
> > > +  clock-names:
> > > +    items:
> > > +      - const: master
> > > +      - const: aux
> > > +
> > > +  interrupts:
> > > +    items:
> > > +      - description: PCIe interrupt
> > > +      - description: PCIe event interrupt
> > > +      - description: PCIe error interrupt
> > > +
> > > +  interrupt-names:
> > > +    items:
> > > +      - const: intr
> > > +      - const: ev_intr
> > > +      - const: err_intr
> > > +
> > > +  num-lanes:
> > > +    description: Number of lanes to use.
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +    enum: [ 1, 2, 4, 8 ]
> > > +
> > > +  num-viewport:
> > > +    description: Number of view ports configured in hardware.
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +    default: 2
> >
> > Pretty sure it's not 2 if num-ib-windows and num-ob-windows are 4.
>
> As per pcie-designware-host.c, default value is 2, if it is not set.

Yes, that's true.

> My example and the DT in my system is 4.
> I will fix in v2, by using const: 4.
> Should I drop default?

Yes.

BTW, I'm going to make all 3 properties obsolete. I'm working on a
patch to detect all this. It's pretty straight-forward, just see how
many registers are writable. The WIP patch is on my for-kernelci
branch.

The problem with these properties is they are defined as RC and EP
specific, but they are really fixed h/w config independent of the
mode. And num-viewport is incomplete because the inbound and outbound
sizes are independent. The driver just currently doesn't use inbound
windows for RC mode. Also, the driver claims there can be up to 256
windows, but I'm not really sure that's right. There's 2 platforms
upstream (ls1088a and ls208xa) claiming 256 windows in DT, but testing
with the detection code indicates they only have 16 IB and 16 OB
windows. Perhaps if you have the DWC manual you could confirm what's
possible.

Rob
