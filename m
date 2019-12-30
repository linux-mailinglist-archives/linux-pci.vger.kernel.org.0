Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85DA212D4A8
	for <lists+linux-pci@lfdr.de>; Mon, 30 Dec 2019 22:21:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727731AbfL3VVC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Dec 2019 16:21:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:35610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727691AbfL3VVB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 30 Dec 2019 16:21:01 -0500
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA471206DB;
        Mon, 30 Dec 2019 21:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577740860;
        bh=Y0AqLq/XNbflvK1k0DHevsHGRPgeSVMI95j9mnbbrk8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kodXCV7m55vcLetOO0rXzH3MXdSyvRQjClDkAlskqLx39VAepFo4IbDYD0xq2SHuf
         6oiR3Q0GJRyOXmm2HxCCA5j9sIn3L52a2st48fPmWcD/4sfkwBMMQgpQZ0t5YULDQ6
         qS7LaxPUWtqUtlfNAKg9MwT59KJMjdY4UXM7f6zM=
Received: by mail-qk1-f169.google.com with SMTP id j9so27557840qkk.1;
        Mon, 30 Dec 2019 13:21:00 -0800 (PST)
X-Gm-Message-State: APjAAAXzNjBcIih9Cv9KgPXSMQeZtbMXoy+ql7m/YVzpKlDiJP8Dh5xI
        ifBTW4RkDMOS4mp+u03aK9myIH2F8c7AqfnThw==
X-Google-Smtp-Source: APXvYqzjgoCnak0+Ma4cVgD5d2+nLjO/PQ4RGB+uvsgVNDeFIPB3koeQFreimo9jq1TE7N0C78mAELHvqU+ppunYi+k=
X-Received: by 2002:a37:85c4:: with SMTP id h187mr57575374qkd.223.1577740859867;
 Mon, 30 Dec 2019 13:20:59 -0800 (PST)
MIME-Version: 1.0
References: <20191116005240.15722-3-robh@kernel.org> <20191213212812.GA201192@google.com>
In-Reply-To: <20191213212812.GA201192@google.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 30 Dec 2019 14:20:48 -0700
X-Gmail-Original-Message-ID: <CAL_Jsq+Nm952=8Fq6KQfrYxwxRJh5mCs2+8_6FgDTp4qZExS5g@mail.gmail.com>
Message-ID: <CAL_Jsq+Nm952=8Fq6KQfrYxwxRJh5mCs2+8_6FgDTp4qZExS5g@mail.gmail.com>
Subject: Re: [PATCH 3/3] dt-bindings: PCI: Convert generic host binding to DT schema
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Will Deacon <will@kernel.org>,
        David Daney <david.daney@cavium.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 13, 2019 at 2:28 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Fri, Nov 15, 2019 at 06:52:40PM -0600, Rob Herring wrote:
> > Convert the generic PCI host binding to DT schema. The derivative Juno,
> > PLDA XpressRICH3-AXI, and Designware ECAM bindings all just vary in
> > their compatible strings. The simplest way to convert those to
> > schema is just add them into the common generic PCI host schema.
> >
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Cc: Andrew Murray <andrew.murray@arm.com>
> > Cc: Zhou Wang <wangzhou1@hisilicon.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: David Daney <david.daney@cavium.com>
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  .../bindings/pci/arm,juno-r1-pcie.txt         |  10 --
> >  .../bindings/pci/designware-pcie-ecam.txt     |  42 -----
> >  .../bindings/pci/hisilicon-pcie.txt           |   4 +-
> >  .../bindings/pci/host-generic-pci.txt         | 101 ------------
> >  .../bindings/pci/host-generic-pci.yaml        | 150 ++++++++++++++++++
> >  .../bindings/pci/pci-thunder-ecam.txt         |  30 ----
> >  .../bindings/pci/pci-thunder-pem.txt          |   7 +-
> >  .../bindings/pci/plda,xpressrich3-axi.txt     |  12 --
> >  MAINTAINERS                                   |   2 +-
> >  9 files changed, 155 insertions(+), 203 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/pci/arm,juno-r1-pcie.txt
> >  delete mode 100644 Documentation/devicetree/bindings/pci/designware-pcie-ecam.txt
> >  delete mode 100644 Documentation/devicetree/bindings/pci/host-generic-pci.txt
> >  create mode 100644 Documentation/devicetree/bindings/pci/host-generic-pci.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/pci/pci-thunder-ecam.txt
> >  delete mode 100644 Documentation/devicetree/bindings/pci/plda,xpressrich3-axi.txt
>
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pci/host-generic-pci.yaml
> > ...
>
> > +  Interrupt mapping is exactly as described in `Open Firmware Recommended
> > +
>
> I think there's some text missing here.

Removed now. The schemas capture in constraints what the missing text
did in free-form.

> > +allOf:
> > +  - $ref: /schemas/pci/pci-bus.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    description: Depends on the layout of configuration space (CAM vs ECAM
> > +      respectively). May also have more specific compatibles.
> > +    anyOf:
> > +      - description:
> > +          PCIe host controller in Arm Juno based on PLDA XpressRICH3-AXI IP
> > +        items:
> > +          - const: arm,juno-r1-pcie
> > +          - const: plda,xpressrich3-axi
> > +          - const: pci-host-ecam-generic
> > +      - description: |
> > +          ThunderX PCI host controller for pass-1.x silicon
> > +
> > +          Firmware-initialized PCI host controller to on-chip devices found on
> > +          some Cavium ThunderX processors.  These devices have ECAM-based config
> > +          access, but the BARs are all at fixed addresses.  We handle the fixed
> > +          addresses by synthesizing Enhanced Allocation (EA) capabilities for
> > +          these devices.
> > +        const: cavium,pci-host-thunder-ecam
> > +      - description: |
> > +          In some cases, firmware may already have configured the Synopsys
> > +          DesignWare PCIe controller in RC mode with static ATU window mappings
> > +          that cover all config, MMIO and I/O spaces in a [mostly] ECAM
> > +          compatible fashion. In this case, there is no need for the OS to
> > +          perform any low level setup of clocks, PHYs or device registers, nor
> > +          is there any reason for the driver to reconfigure ATU windows for
> > +          config and/or IO space accesses at runtime.
> > +
> > +          In cases where the IP was synthesized with a minimum ATU window size
> > +          of 64 KB, it cannot be supported by the generic ECAM driver, because
> > +          it requires special config space accessors that filter accesses to
> > +          device #1 and beyond on the first bus.
> > +        items:
> > +          - enum:
> > +              - marvell,armada8k-pcie-ecam
> > +              - socionext,synquacer-pcie-ecam
> > +          - const: snps,dw-pcie-ecam
> > +      - contains:
> > +          enum:
> > +            - pci-host-cam-generic
> > +            - pci-host-ecam-generic
>
> I assume the description that talks about "Synopsys DesignWare" goes
> with "pci-host-cam-generic" and "pci-host-ecam-generic"?

No, it's a catch all for all other cases.

I'll add a description to make the separation more clear. Using
'contains' here was leftover from when I initially kept the same
separate file structure. With it all combined to 1 schema, there's
really no need for that and it should be 'items' list instead. The
difference is we'll fail on 'compatible = "foo,bar-pci",
"pci-host-ecam-generic";' whereas that is valid for 'contains'.

> I hope there
> can be generic controllers using non-Synopsys IP, but I don't know
> quite how the description/items/contains parts are related.

The '-' are important. They separate each entry under the 'anyOf'.

There are a few besides the ones listed with quirks:

arch/arm/boot/dts/alpine.dtsi
arch/arm64/boot/dts/al/alpine-v2.dtsi
arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi
arch/arm64/boot/dts/arm/fvp-base-revc.dts
arch/arm64/boot/dts/cavium/thunder2-99xx.dtsi
arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
arch/xtensa/boot/dts/virt.dts

Some of these might actually be Synopsys. The entry for Synopsys is
only for the not quite compliant configured IP.

Note that 'pci-host-cam-generic' is unused at least by anything upstream.

>
> > +  reg:
> > +    description:
> > +      The Configuration Space base address and size, as accessed from the parent
> > +      bus. The base address corresponds to the first bus in the "bus-range"
> > +      property. If no "bus-range" is specified, this will be bus 0 (the
> > +      default).
> > +    maxItems: 1
> > +
> > +  ranges:
> > +    description:
> > +      As described in IEEE Std 1275-1994, but must provide at least a
> > +      definition of non-prefetchable memory. One or both of prefetchable Memory
> > +      and IO Space may also be provided.
> > +    minItems: 1
> > +    maxItems: 3
> > +
> > +  dma-coherent:
> > +    description: The host controller bridges the AXI transactions into PCIe bus
> > +      in a manner that makes the DMA operations to appear coherent to the CPUs.
>
> The "host-generic-pci.yaml" name sounds very generic, so I'm not quite
> sure how to read "AXI" -- that sounds like a feature of a specific
> platform? I think "dma-coherent" itself is not platform-specific.

Indeed. On second thought, just 'true' here is enough as we don't need
individual bindings to describe common properties over and over.

Rob
