Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5BF3FD840
	for <lists+linux-pci@lfdr.de>; Wed,  1 Sep 2021 12:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238755AbhIAK5j (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Sep 2021 06:57:39 -0400
Received: from sibelius.xs4all.nl ([83.163.83.176]:63367 "EHLO
        sibelius.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbhIAK5i (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Sep 2021 06:57:38 -0400
Received: from localhost (bloch.sibelius.xs4all.nl [local])
        by bloch.sibelius.xs4all.nl (OpenSMTPD) with ESMTPA id bd1c1a08;
        Wed, 1 Sep 2021 12:56:38 +0200 (CEST)
Date:   Wed, 1 Sep 2021 12:56:38 +0200 (CEST)
From:   Mark Kettenis <mark.kettenis@xs4all.nl>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, alyssa@rosenzweig.io,
        kettenis@openbsd.org, tglx@linutronix.de, maz@kernel.org,
        marcan@marcan.st, bhelgaas@google.com, nsaenz@kernel.org,
        f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        jim2101024@gmail.com, daire.mcnamara@microchip.com,
        nsaenzjulienne@suse.de, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org
In-Reply-To: <YS6XpkluSVRIvR6J@robh.at.kernel.org> (message from Rob Herring
        on Tue, 31 Aug 2021 15:57:10 -0500)
Subject: Re: [PATCH v4 1/4] dt-bindings: interrupt-controller: Convert MSI
 controller to json-schema
References: <20210827171534.62380-1-mark.kettenis@xs4all.nl>
 <20210827171534.62380-2-mark.kettenis@xs4all.nl> <YS6XpkluSVRIvR6J@robh.at.kernel.org>
Message-ID: <561431434bd7dfb9@bloch.sibelius.xs4all.nl>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> Date: Tue, 31 Aug 2021 15:57:10 -0500
> From: Rob Herring <robh@kernel.org>
> 
> On Fri, Aug 27, 2021 at 07:15:26PM +0200, Mark Kettenis wrote:
> > From: Mark Kettenis <kettenis@openbsd.org>
> > 
> > Split the MSI controller bindings from the MSI binding document
> > into DT schema format using json-schema.
> > 
> > Signed-off-by: Mark Kettenis <kettenis@openbsd.org>
> > ---
> >  .../interrupt-controller/msi-controller.yaml  | 34 +++++++++++++++++++
> >  .../bindings/pci/brcm,stb-pcie.yaml           |  1 +
> >  .../bindings/pci/microchip,pcie-host.yaml     |  1 +
> >  3 files changed, 36 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/msi-controller.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/interrupt-controller/msi-controller.yaml b/Documentation/devicetree/bindings/interrupt-controller/msi-controller.yaml
> > new file mode 100644
> > index 000000000000..5ed6cd46e2e0
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/interrupt-controller/msi-controller.yaml
> > @@ -0,0 +1,34 @@
> > +# SPDX-License-Identifier: BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/interrupt-controller/msi-controller.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: MSI controller
> > +
> > +maintainers:
> > +  - Marc Zyngier <marc.zyngier@arm.com>
> > +
> > +description: |
> > +  An MSI controller signals interrupts to a CPU when a write is made
> > +  to an MMIO address by some master. An MSI controller may feature a
> > +  number of doorbells.
> > +
> > +properties:
> > +  "#msi-cells":
> > +    description: |
> > +      The number of cells in an msi-specifier, required if not zero.
> > +
> > +      Typically this will encode information related to sideband data,
> > +      and will not encode doorbells or payloads as these can be
> > +      configured dynamically.
> > +
> > +      The meaning of the msi-specifier is defined by the device tree
> > +      binding of the specific MSI controller.
> 
> I'd prefer we limit this to the maximum range. I'd like to know when 
> someone needs 2 cells (or 3000).
> 
> enum: [ 0, 1 ]
> 
> Though no one seems to use 0 (making it optional was probably a 
> mistake...)
> 
> > +
> > +  msi-controller:
> > +    description:
> > +      Identifies the node as an MSI controller.
> > +    $ref: /schemas/types.yaml#/definitions/flag
> 
> dependencies:
>   "#msi-cells": [ msi-controller ]
> 
> > +
> > +additionalProperties: true
> > diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> > index b9589a0daa5c..5c67976a8dc2 100644
> > --- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> > +++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> > @@ -88,6 +88,7 @@ required:
> >  
> >  allOf:
> >    - $ref: /schemas/pci/pci-bus.yaml#
> > +  - $ref: ../interrupt-controller/msi-controller.yaml#
> 
> /schemas/interrupt-controller/msi-controller.yaml#
> 
> >    - if:
> >        properties:
> >          compatible:
> > diff --git a/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml b/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
> > index fb95c276a986..684d9d036f48 100644
> > --- a/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
> > +++ b/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
> > @@ -11,6 +11,7 @@ maintainers:
> >  
> >  allOf:
> >    - $ref: /schemas/pci/pci-bus.yaml#
> > +  - $ref: ../interrupt-controller/msi-controller.yaml#
> >  
> >  properties:
> >    compatible:

Thanks Rob.  Makes sense to me, so I made these changes (and fixed
Marc's mail address) for v5.
