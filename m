Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62F5612583B
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2019 01:08:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbfLSAIo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Dec 2019 19:08:44 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:35187 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfLSAIo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Dec 2019 19:08:44 -0500
Received: by mail-oi1-f195.google.com with SMTP id k4so2183914oik.2;
        Wed, 18 Dec 2019 16:08:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=t1JJXmt720Zb6BD4BUA0bAKl1uyoZrlRPVoTi/cRZVs=;
        b=g63PpBuhPHHx/NjWVNbDFkeJ+10nrtuAPqsRFJhfxjEXIvjw+D30RsSsI8oSUJgffS
         maZTfnduSvJDSV8PuwDZ3SXBo6eoTW3jAZ7IpPlIpUb1fGojCiq1CfKPoCrNQOwZKISa
         5B4UrXNz+l+B5LU70sxPYIURNPIyFduXu87n/Iy0IB/C5h9UvF7v6VJVwBP2/nxYEvjU
         c37y8+ew94u7B9D+rwt6jNTs3R1gEQS8YZ/F0V/IvWKSH6xEbe2xBxGOgYZCSlAOtOAk
         wZOoV29TsFUwOS4dgKUJMA46HzSaD6KpVAoXkiJj53Fcaaxd0ZnBQdlDVIUzYTVFxpjT
         1R9A==
X-Gm-Message-State: APjAAAWZ/5ruSkgvgiJJl0YCb0Jgdgv3/fYQ+Dwv3gj0TsdYIQTzaI1V
        gl7O0rsyW8JGfLFXVIYkCg==
X-Google-Smtp-Source: APXvYqyKZXwLxO6rUXSyJwIPdUhZSxscATWJJWANja+WDLZIegYJgJ0YceZdYtQK2oyFsV4hK3HatQ==
X-Received: by 2002:aca:c492:: with SMTP id u140mr1608234oif.80.1576714122736;
        Wed, 18 Dec 2019 16:08:42 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t15sm1411319otp.60.2019.12.18.16.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 16:08:42 -0800 (PST)
Date:   Wed, 18 Dec 2019 18:08:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Murray <andrew.murray@arm.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH 09/13] dt-bindings: PCI: Add host mode dt-bindings for
 TI's J721E SoC
Message-ID: <20191219000841.GA4251@bogus>
References: <20191209092147.22901-1-kishon@ti.com>
 <20191209092147.22901-10-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191209092147.22901-10-kishon@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Dec 09, 2019 at 02:51:43PM +0530, Kishon Vijay Abraham I wrote:
> Add host mode dt-bindings for TI's J721E SoC.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  .../bindings/pci/ti,j721e-pci-host.yaml       | 161 ++++++++++++++++++
>  1 file changed, 161 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
> new file mode 100644
> index 000000000000..96184e1f419f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
> @@ -0,0 +1,161 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com/
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/pci/ti,j721e-pci-host.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: TI J721E PCI Host (PCIe Wrapper)
> +
> +maintainers:
> +  - Kishon Vijay Abraham I <kishon@ti.com>

There's now a PCI bus schema. Reference it here:

allOf:
  - $ref: "/schemas/pci/pci-bus.yaml#"

> +
> +properties:
> +  compatible:
> +      enum:
> +          - ti,j721e-pcie-host

Indentation.

> +
> +  reg:
> +    maxItems: 4
> +
> +  reg-names:
> +    items:
> +      - const: intd_cfg
> +      - const: user_cfg
> +      - const: reg
> +      - const: cfg
> +
> +  ti,syscon-pcie-ctrl:
> +    description: Phandle to the SYSCON entry required for configuring PCIe mode
> +                 and link speed.
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/phandle

You can drop the 'allOf' here if there aren't more constraints.

> +
> +  max-link-speed:
> +    minimum: 1
> +    maximum: 3
> +
> +  num-lanes:
> +    minimum: 1
> +    maximum: 2
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +    description: clock-specifier to represent input to the PCIe
> +
> +  clock-names:
> +    items:
> +      - const: fck
> +

> +  "#address-cells":
> +    const: 3
> +
> +  "#size-cells":
> +    const: 2
> +
> +  bus-range:
> +    description: Range of bus numbers associated with this controller.

Drop these 3 as they are all standard.

> +
> +  cdns,max-outbound-regions:
> +    description: As defined in
> +                 Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.txt
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/int32

Can be negative? Use uint32.

The int* definitions are kind of broken until dtc is fixed to maintain 
sign.

> +      - enum: [16]

const: 16

> +
> +  cdns,no-bar-match-nbits:
> +    description: As defined in
> +                 Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.txt
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/int32
> +      - enum: [64]
> +
> +  vendor-id:
> +    const: 0x104c
> +    description: As defined in
> +                 Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.txt

And elsewhere. Drop the description.

> +
> +  device-id:
> +    const: 0xb00d
> +    description: As defined in
> +                 Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.txt
> +
> +  msi-map: true
> +
> +  dma-coherent:
> +    description: Indicates that the PCIe IP block can ensure the coherency
> +
> +  ranges: true

Don't you know how many?

> +
> +  reset-gpios:
> +    description: GPIO specifier for the PERST# signal
> +
> +  phys:
> +    description: As defined in
> +                 Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.txt
> +
> +  phy-names:
> +    description: As defined in
> +                 Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.txt
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - ti,syscon-pcie-ctrl
> +  - max-link-speed
> +  - num-lanes
> +  - power-domains
> +  - clocks
> +  - clock-names

> +  - "#address-cells"
> +  - "#size-cells"

Can drop these 2. The bus schema requires them.

> +  - bus-range
> +  - cdns,max-outbound-regions
> +  - cdns,no-bar-match-nbits
> +  - vendor-id
> +  - device-id
> +  - msi-map
> +  - dma-coherent
> +  - ranges

Can drop, too.

> +  - reset-gpios

Isn't having this board dependent?

> +  - phys
> +  - phy-names
> +
> +examples:
> +  - |
> +    #include <dt-bindings/soc/ti,sci_pm_domain.h>
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +
> +    pcie0_rc: pcie@2900000 {
> +            compatible = "ti,j721e-pcie-host";
> +            reg = <0x00 0x02900000 0x00 0x1000>,
> +                  <0x00 0x02907000 0x00 0x400>,
> +                  <0x00 0x0d000000 0x00 0x00800000>,
> +                  <0x00 0x10000000 0x00 0x00001000>;
> +            reg-names = "intd_cfg", "user_cfg", "reg", "cfg";
> +            ti,syscon-pcie-ctrl = <&pcie0_ctrl>;
> +            max-link-speed = <3>;
> +            num-lanes = <2>;
> +            power-domains = <&k3_pds 239 TI_SCI_PD_EXCLUSIVE>;
> +            clocks = <&k3_clks 239 1>;
> +            clock-names = "fck";
> +            #address-cells = <3>;
> +            #size-cells = <2>;
> +            bus-range = <0x0 0xf>;
> +            cdns,max-outbound-regions = <16>;
> +            cdns,no-bar-match-nbits = <64>;
> +            vendor-id = /bits/ 16 <0x104c>;
> +            device-id = /bits/ 16 <0xb00d>;
> +            msi-map = <0x0 &gic_its 0x0 0x10000>;
> +            dma-coherent;
> +            reset-gpios = <&exp1 6 GPIO_ACTIVE_HIGH>;
> +            phys = <&serdes0_pcie_link>;
> +            phy-names = "pcie_phy";
> +            ranges = <0x01000000 0x0 0x10001000  0x00 0x10001000  0x0 0x0010000>,
> +                     <0x02000000 0x0 0x10011000  0x00 0x10011000  0x0 0x7fef000>;
> +    };
> -- 
> 2.17.1
> 
