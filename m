Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB4E511ECE1
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2019 22:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725799AbfLMV2P (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Dec 2019 16:28:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:35614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbfLMV2P (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 13 Dec 2019 16:28:15 -0500
Received: from localhost (mobile-166-170-223-177.mycingular.net [166.170.223.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9392B21655;
        Fri, 13 Dec 2019 21:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576272493;
        bh=qaF7uj7NHl/aVr0yA1OZtAWou3Fsmkn+JIFFbOvEopQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=faKcCz7+KhMWTTE9g0DfprFl931etP0pNRA11hVOuyOPPIFBNavtJQEJVT3vvJ40L
         MsmVC8DkCFYp1suQAD6h1YZHPujcnOLoIBmLuQdj+KxNj6ANSzXJENRpMUuy98xUZN
         jkIuorjWVXxe+7/AMnx7ru9Nyzn6ot+cbNQxSZ7I=
Date:   Fri, 13 Dec 2019 15:28:12 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Will Deacon <will@kernel.org>,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 3/3] dt-bindings: PCI: Convert generic host binding to DT
 schema
Message-ID: <20191213212812.GA201192@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191116005240.15722-3-robh@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 15, 2019 at 06:52:40PM -0600, Rob Herring wrote:
> Convert the generic PCI host binding to DT schema. The derivative Juno,
> PLDA XpressRICH3-AXI, and Designware ECAM bindings all just vary in
> their compatible strings. The simplest way to convert those to
> schema is just add them into the common generic PCI host schema.
> 
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Andrew Murray <andrew.murray@arm.com>
> Cc: Zhou Wang <wangzhou1@hisilicon.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: David Daney <david.daney@cavium.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/pci/arm,juno-r1-pcie.txt         |  10 --
>  .../bindings/pci/designware-pcie-ecam.txt     |  42 -----
>  .../bindings/pci/hisilicon-pcie.txt           |   4 +-
>  .../bindings/pci/host-generic-pci.txt         | 101 ------------
>  .../bindings/pci/host-generic-pci.yaml        | 150 ++++++++++++++++++
>  .../bindings/pci/pci-thunder-ecam.txt         |  30 ----
>  .../bindings/pci/pci-thunder-pem.txt          |   7 +-
>  .../bindings/pci/plda,xpressrich3-axi.txt     |  12 --
>  MAINTAINERS                                   |   2 +-
>  9 files changed, 155 insertions(+), 203 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pci/arm,juno-r1-pcie.txt
>  delete mode 100644 Documentation/devicetree/bindings/pci/designware-pcie-ecam.txt
>  delete mode 100644 Documentation/devicetree/bindings/pci/host-generic-pci.txt
>  create mode 100644 Documentation/devicetree/bindings/pci/host-generic-pci.yaml
>  delete mode 100644 Documentation/devicetree/bindings/pci/pci-thunder-ecam.txt
>  delete mode 100644 Documentation/devicetree/bindings/pci/plda,xpressrich3-axi.txt

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/host-generic-pci.yaml
> ...

> +  Interrupt mapping is exactly as described in `Open Firmware Recommended
> +

I think there's some text missing here.

> +allOf:
> +  - $ref: /schemas/pci/pci-bus.yaml#
> +
> +properties:
> +  compatible:
> +    description: Depends on the layout of configuration space (CAM vs ECAM
> +      respectively). May also have more specific compatibles.
> +    anyOf:
> +      - description:
> +          PCIe host controller in Arm Juno based on PLDA XpressRICH3-AXI IP
> +        items:
> +          - const: arm,juno-r1-pcie
> +          - const: plda,xpressrich3-axi
> +          - const: pci-host-ecam-generic
> +      - description: |
> +          ThunderX PCI host controller for pass-1.x silicon
> +
> +          Firmware-initialized PCI host controller to on-chip devices found on
> +          some Cavium ThunderX processors.  These devices have ECAM-based config
> +          access, but the BARs are all at fixed addresses.  We handle the fixed
> +          addresses by synthesizing Enhanced Allocation (EA) capabilities for
> +          these devices.
> +        const: cavium,pci-host-thunder-ecam
> +      - description: |
> +          In some cases, firmware may already have configured the Synopsys
> +          DesignWare PCIe controller in RC mode with static ATU window mappings
> +          that cover all config, MMIO and I/O spaces in a [mostly] ECAM
> +          compatible fashion. In this case, there is no need for the OS to
> +          perform any low level setup of clocks, PHYs or device registers, nor
> +          is there any reason for the driver to reconfigure ATU windows for
> +          config and/or IO space accesses at runtime.
> +
> +          In cases where the IP was synthesized with a minimum ATU window size
> +          of 64 KB, it cannot be supported by the generic ECAM driver, because
> +          it requires special config space accessors that filter accesses to
> +          device #1 and beyond on the first bus.
> +        items:
> +          - enum:
> +              - marvell,armada8k-pcie-ecam
> +              - socionext,synquacer-pcie-ecam
> +          - const: snps,dw-pcie-ecam
> +      - contains:
> +          enum:
> +            - pci-host-cam-generic
> +            - pci-host-ecam-generic

I assume the description that talks about "Synopsys DesignWare" goes
with "pci-host-cam-generic" and "pci-host-ecam-generic"?  I hope there
can be generic controllers using non-Synopsys IP, but I don't know
quite how the description/items/contains parts are related.

> +  reg:
> +    description:
> +      The Configuration Space base address and size, as accessed from the parent
> +      bus. The base address corresponds to the first bus in the "bus-range"
> +      property. If no "bus-range" is specified, this will be bus 0 (the
> +      default).
> +    maxItems: 1
> +
> +  ranges:
> +    description:
> +      As described in IEEE Std 1275-1994, but must provide at least a
> +      definition of non-prefetchable memory. One or both of prefetchable Memory
> +      and IO Space may also be provided.
> +    minItems: 1
> +    maxItems: 3
> +
> +  dma-coherent:
> +    description: The host controller bridges the AXI transactions into PCIe bus
> +      in a manner that makes the DMA operations to appear coherent to the CPUs.

The "host-generic-pci.yaml" name sounds very generic, so I'm not quite
sure how to read "AXI" -- that sounds like a feature of a specific
platform?  I think "dma-coherent" itself is not platform-specific.

> +required:
> +  - compatible
> +  - reg
> +  - ranges
> +
> +if:
> +  properties:
> +    compatible:
> +      contains:
> +        const: arm,juno-r1-pcie
> +then:
> +  required:
> +    - dma-coherent
