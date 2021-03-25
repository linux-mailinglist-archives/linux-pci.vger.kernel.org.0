Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0152349CF6
	for <lists+linux-pci@lfdr.de>; Fri, 26 Mar 2021 00:38:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbhCYXiP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Mar 2021 19:38:15 -0400
Received: from mail-il1-f172.google.com ([209.85.166.172]:43556 "EHLO
        mail-il1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbhCYXiO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Mar 2021 19:38:14 -0400
Received: by mail-il1-f172.google.com with SMTP id d2so3583263ilm.10;
        Thu, 25 Mar 2021 16:38:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fSf0ZNyZVaDp/Q6TMA1lW2i5RIZolhAWaOpqwUzEOq8=;
        b=K5Z52YuOMgatmXQ/+wVMh8ew26UKgnL/EeBjgwaLwul3ACPqKYp6BTCUuE+SspaNkn
         U12KkuuLk/JRLZGrOMh4OcN1NhdpurSj3lROprLhfGPKjVd9YGBzJDirx2yZZ19VYFzT
         7FnuePgTwEclfDCrxVSWuCGomzpchNgrmS6QeL13Sgt5CYiz1TTmWmOuW9TKkqXAEdEy
         v/GUhjdnBs7o9gX3AzEkUkJXVIFaxYjmeDwen3aP8pRhdRFsgI2kpj+czf5bb4kwvT8k
         JHlGQJGuBaRHyqrZNklbMxfA4yy/7AsFTU2x7c8MjdWPpzVjcIeOXTAMRdBs9L0yJDor
         G7tA==
X-Gm-Message-State: AOAM532INGxHDjfLGWCexu9rc21hDI5yAwcKIGcmGRSVPTySLGJ+KCp6
        65e9jlrQhglnrnNd1FcOLw==
X-Google-Smtp-Source: ABdhPJwuv6Q3EGM4X8aIYQO3cyFAmqK0aMZ10NrbNU9nmrJF3KSV3GJFpwHx+cd5GpYEuT6eSrf7Pg==
X-Received: by 2002:a05:6e02:6d2:: with SMTP id p18mr1651444ils.251.1616715494212;
        Thu, 25 Mar 2021 16:38:14 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id k10sm3384472iop.42.2021.03.25.16.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 16:38:13 -0700 (PDT)
Received: (nullmailer pid 1949077 invoked by uid 1000);
        Thu, 25 Mar 2021 23:38:12 -0000
Date:   Thu, 25 Mar 2021 17:38:12 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: Re: [PATCH 1/6] dt-bindings: PCI: ti,am65: Add PCIe host mode
 dt-bindings for TI's AM65 SoC
Message-ID: <20210325233812.GA1943834@robh.at.kernel.org>
References: <20210325090026.8843-1-kishon@ti.com>
 <20210325090026.8843-2-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210325090026.8843-2-kishon@ti.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 25, 2021 at 02:30:21PM +0530, Kishon Vijay Abraham I wrote:
> Add PCIe host mode dt-bindings for TI's AM65 SoC.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  .../bindings/pci/ti,am65-pci-host.yaml        | 111 ++++++++++++++++++
>  1 file changed, 111 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml b/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml
> new file mode 100644
> index 000000000000..b77e492886fa
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml
> @@ -0,0 +1,111 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2021 Texas Instruments Incorporated - http://www.ti.com/
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/pci/ti,am65-pci-host.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
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
> +    enum:
> +      - ti,am654-pcie-rc
> +
> +  reg:
> +    maxItems: 4
> +
> +  reg-names:
> +    items:
> +      - const: app
> +      - const: dbics

Please use 'dbi' like everyone else if this isn't shared with the other 
TI DW PCI bindings.

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
> +patternProperties:
> +  "interrupt-controller":

Don't need quotes.

> +    type: object
> +    description: interrupt controller to handle legacy interrupts.
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - max-link-speed
> +  - num-lanes
> +  - power-domains
> +  - ti,syscon-pcie-id
> +  - ti,syscon-pcie-mode
> +  - msi-map
> +  - ranges
> +  - reset-gpios
> +  - phys
> +  - phy-names
> +  - dma-coherent

'interrupt-controller' node is optional?

> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/soc/ti,sci_pm_domain.h>
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    bus {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        pcie0_rc: pcie@5500000 {
> +                compatible = "ti,am654-pcie-rc";
> +                reg =  <0x0 0x5500000 0x0 0x1000>,
> +                       <0x0 0x5501000 0x0 0x1000>,
> +                       <0x0 0x10000000 0x0 0x2000>,
> +                       <0x0 0x5506000 0x0 0x1000>;
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
> +                #interrupt-cells = <1>;
> +                interrupt-map-mask = <0 0 0 7>;
> +                interrupt-map = <0 0 0 1 &pcie0_intc 0>, /* INT A */
> +                                <0 0 0 2 &pcie0_intc 0>, /* INT B */
> +                                <0 0 0 3 &pcie0_intc 0>, /* INT C */
> +                                <0 0 0 4 &pcie0_intc 0>; /* INT D */
> +
> +                pcie0_intc: interrupt-controller {
> +                        interrupt-controller;
> +                        #interrupt-cells = <1>;
> +                        interrupt-parent = <&gic500>;
> +                        interrupts = <GIC_SPI 328 IRQ_TYPE_EDGE_RISING>;
> +                };
> +        };
> -- 
> 2.17.1
> 
