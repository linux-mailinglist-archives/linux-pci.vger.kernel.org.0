Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA0C39198C
	for <lists+linux-pci@lfdr.de>; Wed, 26 May 2021 16:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234295AbhEZOKl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 May 2021 10:10:41 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:34448 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232948AbhEZOKl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 May 2021 10:10:41 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14QE93ss043533;
        Wed, 26 May 2021 09:09:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1622038143;
        bh=vEBga0t3qzngzYqUbWJAGuom3PVx+7aw7ixeVFU50RQ=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=uA9+Nj7SUYepheLee3Z6eeliDqCHW3dIG9ss7BAc/fZhFiWPwfIKk0hRo3gCEI8h2
         fOhntTV0xyzP31qxJhgZi3+SisV9Bv+CwudnY3hVx9/eI8SW+SfR9Kpo8YIjPZ1TQP
         9PX9PXVM7akV9A9GKGcJROhVts6Wua8K4Xo8hi58=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14QE92TP119995
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 May 2021 09:09:03 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 26
 May 2021 09:09:02 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 26 May 2021 09:09:02 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14QE92Mf055817;
        Wed, 26 May 2021 09:09:02 -0500
Date:   Wed, 26 May 2021 09:09:02 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Lokesh Vutla <lokeshvutla@ti.com>
Subject: Re: [PATCH] dt-bindings: PCI: ti,am65: Convert PCIe host/endpoint
 mode dt-bindings to YAML
Message-ID: <20210526140902.lnk5du5k3b4sny3m@handheld>
References: <20210526134708.27887-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210526134708.27887-1-kishon@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 19:17-20210526, Kishon Vijay Abraham I wrote:
> Convert PCIe host/endpoint mode dt-bindings for TI's AM65/Keystone SoC
> to YAML binding.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>

[...]
> diff --git a/Documentation/devicetree/bindings/pci/ti,am65-pci-ep.yaml b/Documentation/devicetree/bindings/pci/ti,am65-pci-ep.yaml
> new file mode 100644
> index 000000000000..419d48528105
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/ti,am65-pci-ep.yaml
> @@ -0,0 +1,80 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2021 Texas Instruments Incorporated - http://www.ti.com/
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/pci/ti,am65-pci-ep.yaml#"

drop the '"'?

> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"

drop the '"'?
> +
> +title: TI AM65 PCI Endpoint
> +
> +maintainers:
> +  - Kishon Vijay Abraham I <kishon@ti.com>
> +
> +allOf:
> +  - $ref: "pci-ep.yaml#"

drop the '"' ?

> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,am654-pcie-ep
> +
> +  reg:
> +    maxItems: 4
> +
> +  reg-names:
> +    items:
> +      - const: app
> +      - const: dbics
> +      - const: addr_space
> +      - const: atu
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  ti,syscon-pcie-mode:
> +    description: Phandle to the SYSCON entry required for configuring PCIe in RC or EP mode.
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +
> +  interrupts:
> +    minItems: 1
> +
> +  dma-coherent: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - max-link-speed
> +  - power-domains
> +  - ti,syscon-pcie-mode
> +  - dma-coherent
> +
> +unevaluatedProperties: false

Is it possible to lock this down further with additionalProperties: false?

I could add some ridiculous property like system-controller; to the
example and the checks wont catch it.

same with the host as well.

> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/soc/ti,sci_pm_domain.h>
> +    #include <dt-bindings/gpio/gpio.h>
you could drop this (unused)
> +
> +    bus {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
We dont really need this, right? this is an example.. see below

> +
> +        pcie0_ep: pcie-ep@5500000 {
> +                compatible = "ti,am654-pcie-ep";
> +                reg =  <0x0 0x5500000 0x0 0x1000>,
> +                       <0x0 0x5501000 0x0 0x1000>,
> +                       <0x0 0x10000000 0x0 0x8000000>,
> +                       <0x0 0x5506000 0x0 0x1000>;
^^ just change this to
reg =  <0x5500000 0x1000>,
       <0x5501000 0x1000>,
       <0x10000000 0x8000000>
       <0x5506000 0x1000>;
> +                reg-names = "app", "dbics", "addr_space", "atu";
> +                power-domains = <&k3_pds 120 TI_SCI_PD_EXCLUSIVE>;
> +                ti,syscon-pcie-mode = <&pcie0_mode>;
> +                num-ib-windows = <16>;
> +                num-ob-windows = <16>;
> +                max-link-speed = <2>;
> +                dma-coherent;
> +                interrupts = <GIC_SPI 340 IRQ_TYPE_EDGE_RISING>;
> +        };
> +    };
> diff --git a/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml b/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml
> new file mode 100644
> index 000000000000..3764ce01ee5c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml
> @@ -0,0 +1,105 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2021 Texas Instruments Incorporated - http://www.ti.com/
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/pci/ti,am65-pci-host.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"

Drop the '"' ?
> +
> +title: TI AM65 PCI Host
> +
> +maintainers:
> +  - Kishon Vijay Abraham I <kishon@ti.com>
> +
> +allOf:
> +  - $ref: /schemas/pci/pci-bus.yaml#
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: ti,am654-pcie-rc
> +      - description: PCIe controller in Keystone
> +        items:
> +          - const: ti,keystone-pcie
> +          - const: snps,dw-pcie
> +
> +  reg:
> +    maxItems: 4
> +
> +  reg-names:
> +    items:
> +      - const: app
> +      - const: dbics
> +      - const: config
> +      - const: atu
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  ti,syscon-pcie-id:
> +    description: Phandle to the SYSCON entry required for getting PCIe device/vendor ID
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +
> +  ti,syscon-pcie-mode:
> +    description: Phandle to the SYSCON entry required for configuring PCIe in RC or EP mode.
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +
> +  msi-map: true
> +
> +  dma-coherent: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - max-link-speed
> +  - ti,syscon-pcie-id
> +  - ti,syscon-pcie-mode
> +  - ranges
> +
> +if:
> +  properties:
> +    compatible:
> +      enum:
> +        - ti,am654-pcie-rc
> +then:
> +  required:
> +    - dma-coherent
> +    - power-domains
> +    - msi-map
> +
> +unevaluatedProperties: false

Is it possible to lock this down further with additionalProperties: false?

Same rationale as above.
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/soc/ti,sci_pm_domain.h>
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    bus {
> +        #address-cells = <2>;
> +        #size-cells = <2>;

We dont really need this, right? this is an example.. see below
> +
> +        pcie0_rc: pcie@5500000 {
> +                compatible = "ti,am654-pcie-rc";
> +                reg =  <0x0 0x5500000 0x0 0x1000>,
> +                       <0x0 0x5501000 0x0 0x1000>,
> +                       <0x0 0x10000000 0x0 0x2000>,
> +                       <0x0 0x5506000 0x0 0x1000>;
^^ just change this to
reg =  <0x5500000 0x1000>,
       <0x5501000 0x1000>,
       <0x10000000 0x8000000>
       <0x5506000 0x1000>;
> +                reg-names = "app", "dbics", "config", "atu";
> +                power-domains = <&k3_pds 120 TI_SCI_PD_EXCLUSIVE>;
> +                #address-cells = <3>;
> +                #size-cells = <2>;
> +                ranges = <0x81000000 0 0          0x0 0x10020000 0 0x00010000>,
> +                         <0x82000000 0 0x10030000 0x0 0x10030000 0 0x07FD0000>;
> +                ti,syscon-pcie-id = <&pcie_devid>;
> +                ti,syscon-pcie-mode = <&pcie0_mode>;
> +                bus-range = <0x0 0xff>;
> +                num-viewport = <16>;
> +                max-link-speed = <2>;
> +                dma-coherent;
> +                interrupts = <GIC_SPI 340 IRQ_TYPE_EDGE_RISING>;
> +                msi-map = <0x0 &gic_its 0x0 0x10000>;
> +                device_type = "pci";
> +        };
> +    };
> -- 
> 2.17.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
