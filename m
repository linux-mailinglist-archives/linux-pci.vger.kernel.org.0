Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA24E1339B3
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2020 04:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgAHDnT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Jan 2020 22:43:19 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40438 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbgAHDnT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Jan 2020 22:43:19 -0500
Received: by mail-ot1-f67.google.com with SMTP id w21so2248446otj.7
        for <linux-pci@vger.kernel.org>; Tue, 07 Jan 2020 19:43:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ilH05ihXEuc/NhF/tPgNdcykj6uPjvXn5uaHX6J7/Ak=;
        b=YG0jyb9OGaSj5tlW+ispzSzJVbOLGEGfA7DteO471/my0IzgGV1GFQKqLAVvoF+/Fv
         TMhcnhBDxV/8Dkfv23HDvsdErqWDyFQ8Y6xNl/Rvs+4sf3DaIkvRl8peXPM2uAPYZ7yA
         g9islBz8BRYepDZ+j+M2FAX/Y8Nb1FHp+G9caDcqKE188FxNrfI1gEMpYO+SfVaiBsZW
         tau3ETgFL7NX4K2UYvrikWUR+sCSZnCbj6sRcVqgv1tfWeDijeuoksWDcT93yRO3OwPx
         9ZI4eXAjL4BvZ834V6dMbv4aTeMhgovQZ3xcGCiz+IJK3JRNoT9lP7Hw5VLVPIry/1g/
         XHog==
X-Gm-Message-State: APjAAAUBpHT8ddUTZqsRTrviFmTTcPDPuBTMxpnh43H3+lsEP6fGon9F
        Uhxgf5d7vUmIwWzvR95JPHNjIMM=
X-Google-Smtp-Source: APXvYqxNsj0648i0mUsmWkcGQWccoy//d5YNdwIQjn2VAnS/G5S9/XkzD0r7wbFRxOJoO1DzyAoTBQ==
X-Received: by 2002:a05:6830:1442:: with SMTP id w2mr2717282otp.143.1578454997280;
        Tue, 07 Jan 2020 19:43:17 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e65sm661379otb.62.2020.01.07.19.43.14
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 19:43:15 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 2219e3
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Tue, 07 Jan 2020 21:43:14 -0600
Date:   Tue, 7 Jan 2020 21:43:14 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Murray <andrew.murray@arm.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 01/14] dt-bindings: PCI: cadence: Add PCIe RC/EP DT
 schema for Cadence PCIe
Message-ID: <20200108034314.GA5412@bogus>
References: <20200106102058.19183-1-kishon@ti.com>
 <20200106102058.19183-2-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200106102058.19183-2-kishon@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 06, 2020 at 03:50:45PM +0530, Kishon Vijay Abraham I wrote:
> Add PCIe Host (RC) and Endpoint (EP) device tree schema for Cadence
> PCIe core library. Platforms using Cadence PCIe core can include the
> schemas added here in the platform specific schemas.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  .../devicetree/bindings/pci/cdns-pcie-ep.yaml | 20 ++++++++++++
>  .../bindings/pci/cdns-pcie-host.yaml          | 30 +++++++++++++++++
>  .../devicetree/bindings/pci/cdns-pcie.yaml    | 32 +++++++++++++++++++
>  3 files changed, 82 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/cdns-pcie-ep.yaml
>  create mode 100644 Documentation/devicetree/bindings/pci/cdns-pcie-host.yaml
>  create mode 100644 Documentation/devicetree/bindings/pci/cdns-pcie.yaml

Need to remove the old files.

Note that I posted a conversion of Cadence host[1]. Yours goes further, 
but please compare and add anything mine has that yours doesn't.

[1] https://lore.kernel.org/linux-pci/20191231193903.15929-2-robh@kernel.org/

> 
> diff --git a/Documentation/devicetree/bindings/pci/cdns-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/cdns-pcie-ep.yaml
> new file mode 100644
> index 000000000000..36aaae5931c3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/cdns-pcie-ep.yaml
> @@ -0,0 +1,20 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2020 Texas Instruments Incorporated - http://www.ti.com/
> +%YAML 1.2
> +--
> +$id: "http://devicetree.org/schemas/pci/cdns-pcie-ep.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Cadence PCIe Endpoint
> +
> +maintainers:
> +  - Tom Joseph <tjoseph@cadence.com>
> +
> +allOf:
> +  - $ref: "cdns-pcie.yaml#"
> +
> +properties:
> +  max-functions:
> +    description: Maximum number of functions that can be configured (default 1)
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint8
> diff --git a/Documentation/devicetree/bindings/pci/cdns-pcie-host.yaml b/Documentation/devicetree/bindings/pci/cdns-pcie-host.yaml
> new file mode 100644
> index 000000000000..78261bc4f0c5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/cdns-pcie-host.yaml
> @@ -0,0 +1,30 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2020 Texas Instruments Incorporated - http://www.ti.com/
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/pci/cdns-pcie-host.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Cadence PCIe Host
> +
> +maintainers:
> +  - Tom Joseph <tjoseph@cadence.com>
> +
> +allOf:
> +  - $ref: "/schemas/pci/pci-bus.yaml#"
> +  - $ref: "cdns-pcie.yaml#"
> +
> +properties:
> +  vendor-id:
> +    description: The PCI vendor ID (16 bits, default is design dependent)
> +
> +  device-id:
> +    description: The PCI device ID (16 bits, default is design dependent)

While these got defined here as 16-bits, these should be fixed to 32-bit 
because they are established properties for a long time.

> +
> +  cdns,no-bar-match-nbits:
> +    description: Set into the no BAR match register to configure the number
> +      of least significant bits kept during inbound (PCIe -> AXI) address
> +      translations (default 32)
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32

What about compatible?

> +
> diff --git a/Documentation/devicetree/bindings/pci/cdns-pcie.yaml b/Documentation/devicetree/bindings/pci/cdns-pcie.yaml
> new file mode 100644
> index 000000000000..497d3dc2e6f2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/cdns-pcie.yaml
> @@ -0,0 +1,32 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2020 Texas Instruments Incorporated - http://www.ti.com/
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/pci/cdns-pcie.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Cadence PCIe Core
> +
> +maintainers:
> +  - Tom Joseph <tjoseph@cadence.com>
> +
> +properties:
> +  max-link-speed:
> +    minimum: 1
> +    maximum: 3
> +
> +  num-lanes:
> +    minimum: 1
> +    maximum: 2

Needs a type.

The Cadence IP can't support x4, x8, or x16?

> +
> +  cdns,max-outbound-regions:
> +    description: Set to maximum number of outbound regions.
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  phys:
> +    description: List of Generic PHY phandles. One per lane if more than one in
> +      the list. If only one PHY listed it must manage all lanes.
> +
> +  phy-names:
> +    description: List of names to identify the PHY.
> -- 
> 2.17.1
> 
