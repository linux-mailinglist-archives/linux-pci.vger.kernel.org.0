Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7381BEE26
	for <lists+linux-pci@lfdr.de>; Thu, 30 Apr 2020 04:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbgD3CNc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Apr 2020 22:13:32 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46319 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbgD3CNb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Apr 2020 22:13:31 -0400
Received: by mail-ot1-f67.google.com with SMTP id z25so3589407otq.13;
        Wed, 29 Apr 2020 19:13:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Kv25T34DmFJSTkCcpG3EkQ4F91aBPygfe37SiYRfZ1w=;
        b=fVDH2Oo059qF65Wx8It7HCH3TQwtsSrirCcCVWA52hsi+9bNOAQ247eVnHPFMokcDs
         wXyzZwlM3s0OyB30ALKLU19jReo+2NU81ghZkyvUe32RiwpUpxIRBbHNk0lH0hZm8h6E
         D0703fA7TXbYrtXTDGQNcK4o8B/qJ/fHG/zJ0Gk+PAeiGTONC/wDIWHJcI7AJ1TQmh0t
         upg0dH0kq0zauEchL99MuVxgKls5JFMLrPhc0pCsDDcR1WJkKY0Gcw49Jxbhz3cROeLe
         EcZl3QgExCyGzv0sDx2gWEy11QJnaEy9orxQNOCLIhIBM+MMb8g/XUukFcfNaibvy3f1
         Q0QA==
X-Gm-Message-State: AGi0PuaBkP/4k/mRgTmQiQiPhYbty0J+Vhvsd6zkfA4fEAiFgjiz5lOq
        D/Up0auzUaRs10KgS3kLDQ==
X-Google-Smtp-Source: APiQypKCVHjHs9J7+JAq/qDUcEL9ABy6N/M3B+18ySskwV1Nxa/XGc71ZP1EJkAjD4Yq5SIhFutpbA==
X-Received: by 2002:a9d:810:: with SMTP id 16mr772676oty.56.1588212810207;
        Wed, 29 Apr 2020 19:13:30 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z13sm884559oth.10.2020.04.29.19.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 19:13:29 -0700 (PDT)
Received: (nullmailer pid 21985 invoked by uid 1000);
        Thu, 30 Apr 2020 02:13:28 -0000
Date:   Wed, 29 Apr 2020 21:13:28 -0500
From:   Rob Herring <robh@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Tom Joseph <tjoseph@cadence.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 11/14] dt-bindings: PCI: Add EP mode dt-bindings for
 TI's J721E SoC
Message-ID: <20200430021327.GA18326@bogus>
References: <20200417125753.13021-1-kishon@ti.com>
 <20200417125753.13021-12-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200417125753.13021-12-kishon@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 17, 2020 at 06:27:50PM +0530, Kishon Vijay Abraham I wrote:
> Add PCIe EP mode dt-bindings for TI's J721E SoC.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  .../bindings/pci/ti,j721e-pci-ep.yaml         | 89 +++++++++++++++++++
>  1 file changed, 89 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml b/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
> new file mode 100644
> index 000000000000..cb25c45d5a96
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/ti,j721e-pci-ep.yaml
> @@ -0,0 +1,89 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2020 Texas Instruments Incorporated - http://www.ti.com/
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
> +allOf:
> +  - $ref: "cdns-pcie-ep.yaml#"
> +
> +properties:
> +  compatible:
> +      enum:
> +          - ti,j721e-pcie-ep

Wrong indentation.

Otherwise,

Reviewed-by: Rob Herring <robh@kernel.org>

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
> +  dma-coherent:
> +    description: Indicates that the PCIe IP block can ensure the coherency
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
> +            phy-names = "pcie-phy";
> +    };
> -- 
> 2.17.1
> 
