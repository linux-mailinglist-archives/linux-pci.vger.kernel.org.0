Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F08183F9FB6
	for <lists+linux-pci@lfdr.de>; Fri, 27 Aug 2021 21:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbhH0TQI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Aug 2021 15:16:08 -0400
Received: from sibelius.xs4all.nl ([83.163.83.176]:63904 "EHLO
        sibelius.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbhH0TQI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Aug 2021 15:16:08 -0400
Received: from localhost (bloch.sibelius.xs4all.nl [local])
        by bloch.sibelius.xs4all.nl (OpenSMTPD) with ESMTPA id f7d4fb37;
        Fri, 27 Aug 2021 21:15:11 +0200 (CEST)
Date:   Fri, 27 Aug 2021 21:15:11 +0200 (CEST)
From:   Mark Kettenis <mark.kettenis@xs4all.nl>
To:     Mark Kettenis <mark.kettenis@xs4all.nl>
Cc:     devicetree@vger.kernel.org, alyssa@rosenzweig.io,
        kettenis@openbsd.org, tglx@linutronix.de, maz@kernel.org,
        robh+dt@kernel.org, marcan@marcan.st, bhelgaas@google.com,
        nsaenz@kernel.org, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
        daire.mcnamara@microchip.com, nsaenzjulienne@suse.de,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-rpi-kernel@lists.infradead.org
In-Reply-To: <20210827171534.62380-2-mark.kettenis@xs4all.nl> (message from
        Mark Kettenis on Fri, 27 Aug 2021 19:15:26 +0200)
Subject: Re: [PATCH v4 1/4] dt-bindings: interrupt-controller: Convert MSI controller to json-schema
References: <20210827171534.62380-1-mark.kettenis@xs4all.nl> <20210827171534.62380-2-mark.kettenis@xs4all.nl>
Message-ID: <561420d562d3e421@bloch.sibelius.xs4all.nl>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> From: Mark Kettenis <mark.kettenis@xs4all.nl>
> Date: Fri, 27 Aug 2021 19:15:26 +0200
> 
> From: Mark Kettenis <kettenis@openbsd.org>
> 
> Split the MSI controller bindings from the MSI binding document
> into DT schema format using json-schema.
> 
> Signed-off-by: Mark Kettenis <kettenis@openbsd.org>
> ---
>  .../interrupt-controller/msi-controller.yaml  | 34 +++++++++++++++++++
>  .../bindings/pci/brcm,stb-pcie.yaml           |  1 +
>  .../bindings/pci/microchip,pcie-host.yaml     |  1 +
>  3 files changed, 36 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/msi-controller.yaml
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/msi-controller.yaml b/Documentation/devicetree/bindings/interrupt-controller/msi-controller.yaml
> new file mode 100644
> index 000000000000..5ed6cd46e2e0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/msi-controller.yaml
> @@ -0,0 +1,34 @@
> +# SPDX-License-Identifier: BSD-2-Clause

Noticed that checkpatch complains that the preferred license for new
binding schemas is (GPL-2.0-only OR BSD-2-Clause) so I'll fix that in
the next version.

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interrupt-controller/msi-controller.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MSI controller
> +
> +maintainers:
> +  - Marc Zyngier <marc.zyngier@arm.com>
> +
> +description: |
> +  An MSI controller signals interrupts to a CPU when a write is made
> +  to an MMIO address by some master. An MSI controller may feature a
> +  number of doorbells.
> +
> +properties:
> +  "#msi-cells":
> +    description: |
> +      The number of cells in an msi-specifier, required if not zero.
> +
> +      Typically this will encode information related to sideband data,
> +      and will not encode doorbells or payloads as these can be
> +      configured dynamically.
> +
> +      The meaning of the msi-specifier is defined by the device tree
> +      binding of the specific MSI controller.
> +
> +  msi-controller:
> +    description:
> +      Identifies the node as an MSI controller.
> +    $ref: /schemas/types.yaml#/definitions/flag
> +
> +additionalProperties: true
> diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> index b9589a0daa5c..5c67976a8dc2 100644
> --- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> @@ -88,6 +88,7 @@ required:
>  
>  allOf:
>    - $ref: /schemas/pci/pci-bus.yaml#
> +  - $ref: ../interrupt-controller/msi-controller.yaml#
>    - if:
>        properties:
>          compatible:
> diff --git a/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml b/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
> index fb95c276a986..684d9d036f48 100644
> --- a/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
> +++ b/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
> @@ -11,6 +11,7 @@ maintainers:
>  
>  allOf:
>    - $ref: /schemas/pci/pci-bus.yaml#
> +  - $ref: ../interrupt-controller/msi-controller.yaml#
>  
>  properties:
>    compatible:
> -- 
> 2.32.0
> 
> 
