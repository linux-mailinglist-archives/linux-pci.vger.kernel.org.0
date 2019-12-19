Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8A5125847
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2019 01:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfLSAOL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Dec 2019 19:14:11 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41055 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfLSAOL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Dec 2019 19:14:11 -0500
Received: by mail-ot1-f66.google.com with SMTP id r27so4691161otc.8;
        Wed, 18 Dec 2019 16:14:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hkcbaA4/f4sNwpu+E7FWB3LQDsLo4/ub3EZsi/8F/q0=;
        b=fQnpmOJihYpeo9SejO1lv8H9IUhBVOLwKRxIAIACqy+rSahQ6RS6Mr7iqakYZnfwbJ
         5ypNPa71SbcCTDKrbIJN8RR3AHz++/YX8jT+jQSkbp/uXUMJndTUg3Vk9Z+rt+FiOy6m
         KJV4BtECDB1cpQum1oGi/V7QHwFOOQ35xSFN7nwxwr5JQyc8mEytLaWhHe1fCkOpi20g
         gdWHS8HCI/KACOyxCAtdfl4rYyKX7guTaq7ZC2GD2npMeIt9x2yiCW7SM2nmjpvpn67+
         OVQ91bTgohuqtSHmpo0f2BuemBLbuu+0dJCHqDsVQMv4KAZ+KoC+kNFD38p/PMyij3Lb
         4u5A==
X-Gm-Message-State: APjAAAUffLRsl9RspeEjvSL7bzhjho9bij/nnpKQ7fWi8YCwz3AdtuCm
        zOrbhYrj7j6OiEcITsMnqQ==
X-Google-Smtp-Source: APXvYqx1gP3LaoAhtsvF8oP0EUuAl/b6xzjtOsHyXxSrhdHuHOS6hIDso3vLaExv3Alto/yaq5P6bw==
X-Received: by 2002:a9d:ec1:: with SMTP id 59mr5300342otj.141.1576714450003;
        Wed, 18 Dec 2019 16:14:10 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q1sm1494674otr.40.2019.12.18.16.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 16:14:09 -0800 (PST)
Date:   Wed, 18 Dec 2019 18:14:08 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Murray <andrew.murray@arm.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH 10/13] dt-bindings: PCI: Add EP mode dt-bindings for TI's
 J721E SoC
Message-ID: <20191219001408.GA20303@bogus>
References: <20191209092147.22901-1-kishon@ti.com>
 <20191209092147.22901-11-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191209092147.22901-11-kishon@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Dec 09, 2019 at 02:51:44PM +0530, Kishon Vijay Abraham I wrote:
> Add PCIe EP mode dt-bindings for TI's J721E SoC.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  .../bindings/pci/ti,j721e-pci-ep.yaml         | 113 ++++++++++++++++++
>  1 file changed, 113 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml b/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
> new file mode 100644
> index 000000000000..4e2af4733998
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
> @@ -0,0 +1,113 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com/
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/pci/ti,j721e-pci-ep.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: TI J721E PCI EP (PCIe Wrapper)
> +
> +maintainers:
> +  - Kishon Vijay Abraham I <kishon@ti.com>
> +
> +properties:
> +  compatible:
> +      enum:
> +          - ti,j721e-pcie-ep

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
> +      - const: mem
> +
> +  ti,syscon-pcie-ctrl:
> +    description: Phandle to the SYSCON entry required for configuring PCIe mode
> +                 and link speed.
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/phandle
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
> +  cdns,max-outbound-regions:
> +    description: As defined in
> +                 Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.txt
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/int32

uint32

> +      - enum: [16]
> +
> +  max-functions:
> +    minimum: 1
> +    maximum: 6

Needs a type ref. Or a common definition.

> +
> +  dma-coherent:
> +    description: Indicates that the PCIe IP block can ensure the coherency
> +
> +  phys:

How many? Need to convert cdns,cdns-pcie-host.txt...

> +    description: As defined in
> +                 Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.txt
> +
> +  phy-names:
> +    description: As defined in
> +                 Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.txt

For all the properties shared with host mode, it might make sense to 
define a common schema with all those properties and then include it in 
the host and endpoint schemas.

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
> +  - cdns,max-outbound-regions
> +  - dma-coherent
> +  - max-functions
> +  - phys
> +  - phy-names
> +
> +examples:
> +  - |
> +    #include <dt-bindings/soc/ti,sci_pm_domain.h>
> +
> +     pcie0_ep: pcie-ep@d000000 {
> +            compatible = "ti,j721e-pcie-ep";
> +            reg = <0x00 0x02900000 0x00 0x1000>,
> +                  <0x00 0x02907000 0x00 0x400>,
> +                  <0x00 0x0d000000 0x00 0x00800000>,
> +                  <0x00 0x10000000 0x00 0x08000000>;
> +            reg-names = "intd_cfg", "user_cfg", "reg", "mem";
> +            ti,syscon-pcie-ctrl = <&pcie0_ctrl>;
> +            max-link-speed = <3>;
> +            num-lanes = <2>;
> +            power-domains = <&k3_pds 239 TI_SCI_PD_EXCLUSIVE>;
> +            clocks = <&k3_clks 239 1>;
> +            clock-names = "fck";
> +            cdns,max-outbound-regions = <16>;
> +            max-functions = /bits/ 8 <6>;
> +            dma-coherent;
> +            phys = <&serdes0_pcie_link>;
> +            phy-names = "pcie_phy";
> +    };
> -- 
> 2.17.1
> 
