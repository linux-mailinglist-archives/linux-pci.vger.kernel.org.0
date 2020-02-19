Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC359164FD2
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2020 21:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbgBSU1D (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Feb 2020 15:27:03 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44873 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbgBSU1C (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Feb 2020 15:27:02 -0500
Received: by mail-ot1-f65.google.com with SMTP id h9so1426933otj.11;
        Wed, 19 Feb 2020 12:27:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CdW2v94vclBbMClu4Uts81wJU8rv+QPDvyeeQ3vvmNk=;
        b=L7mQF17uPy56+VtZKx73GNovD30OoV6vbmZaLrjTaLP0ucrC61rr2jkEyqp4pQNQtj
         uJetKm+AwBifEq7nMfkofGKF75/GDisHt/6H+DY6CcagPPyM6bKbMsZYQTrcmpF4coyF
         8ZrJI+yLfpxGdJh2dbODGO5kx497b8V+Vcp9NJVNo++MIWHnSPPobZOQNz4iKLqS+Vt1
         CDyy/zgukKtwj7Rfvijhzc/DBPNfS/CkWl6X7iwEPXPaB6pYzgJ2DxuwebrV66d6ETKH
         vcuO2rf4TfXOTw2GeYqzwZaXFpm4J5mhxixsk6sTGWCb5uMmzbvupwTeTzCuiy4PMHL1
         zrig==
X-Gm-Message-State: APjAAAUYrBtd8R9wxz8D0ZzxoFjoYH9nYAwGpT+zSPsdvoRoSGQb1M+g
        r2hyaQ9l81F3wAyPp2ptTA==
X-Google-Smtp-Source: APXvYqz+hinonc4v6VST89rZ3Ydv6zU5hyEVqM43ywd3Axx39ymW7FHAQ8T8eXK1+IvzATwTNIBD2w==
X-Received: by 2002:a9d:3b09:: with SMTP id z9mr21138164otb.195.1582144021801;
        Wed, 19 Feb 2020 12:27:01 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a1sm285965oti.2.2020.02.19.12.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 12:27:01 -0800 (PST)
Received: (nullmailer pid 13831 invoked by uid 1000);
        Wed, 19 Feb 2020 20:27:00 -0000
Date:   Wed, 19 Feb 2020 14:27:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Mark Rutland <mark.rutland@arm.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: PCI: cadence: Add PCIe RC/EP DT
 schema for Cadence PCIe
Message-ID: <20200219202700.GA21908@bogus>
References: <20200217111519.29163-1-kishon@ti.com>
 <20200217111519.29163-2-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200217111519.29163-2-kishon@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Feb 17, 2020 at 04:45:18PM +0530, Kishon Vijay Abraham I wrote:
> Add PCIe Host (RC) and Endpoint (EP) device tree schema for Cadence
> PCIe core library. Platforms using Cadence PCIe core can include the
> schemas added here in the platform specific schemas.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  .../devicetree/bindings/pci/cdns-pcie-ep.yaml | 22 +++++++++
>  .../bindings/pci/cdns-pcie-host.yaml          | 27 +++++++++++
>  .../devicetree/bindings/pci/cdns-pcie.yaml    | 45 +++++++++++++++++++
>  3 files changed, 94 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/cdns-pcie-ep.yaml
>  create mode 100644 Documentation/devicetree/bindings/pci/cdns-pcie-host.yaml
>  create mode 100644 Documentation/devicetree/bindings/pci/cdns-pcie.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/cdns-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/cdns-pcie-ep.yaml
> new file mode 100644
> index 000000000000..b22d54605009
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/cdns-pcie-ep.yaml
> @@ -0,0 +1,22 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
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
> +    description: Maximum number of functions that can be configured
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint8
> +    minimum: 1
> +    default: 1
> +    maximum: 256

Create a pcie-ep.yaml and put this there as every endpoint binding 
seems to use this and I'm sure there's more properties to come. 

Also, the max can only be 255.

> diff --git a/Documentation/devicetree/bindings/pci/cdns-pcie-host.yaml b/Documentation/devicetree/bindings/pci/cdns-pcie-host.yaml
> new file mode 100644
> index 000000000000..ab6e43b636ec
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/cdns-pcie-host.yaml
> @@ -0,0 +1,27 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
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
> +  cdns,no-bar-match-nbits:
> +    description:
> +      Set into the no BAR match register to configure the number of least
> +      significant bits kept during inbound (PCIe -> AXI) address translations

This should probably be deprecated IMO. This info should really be 
extracted from sizes in 'dma-ranges'.

> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0
> +    maximum: 64
> +    default: 32
> +
> +  msi-parent: true
> diff --git a/Documentation/devicetree/bindings/pci/cdns-pcie.yaml b/Documentation/devicetree/bindings/pci/cdns-pcie.yaml
> new file mode 100644
> index 000000000000..fd690b062de1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/cdns-pcie.yaml
> @@ -0,0 +1,45 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
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
> +    description: maximum link speed
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 1
> +    maximum: 4

Standard property in pci-bus.yaml, no need to define it again.

> +
> +  num-lanes:
> +    description: maximum number of lanes
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 1
> +    maximum: 16

This should be added to pci-bus.yaml. Assume here it is.

> +
> +  cdns,max-outbound-regions:
> +    description: maximum number of outbound regions
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 1
> +    maximum: 32
> +    default: 32

This too should be deprecated IMO. It is nothing more than error 
checking number of 'ranges' entries. But deprecating should be a 
follow-up.

> +
> +  phys:
> +    description:
> +      One per lane if more than one in the list. If only one PHY listed it must
> +      manage all lanes.
> +    minItems: 1
> +    maxItems: 16
> +
> +  phy-names:
> +    items:
> +      - const: pcie-phy
> +    # FIXME: names when more than 1
> -- 
> 2.17.1
> 
