Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 381F5173B7B
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2020 16:34:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbgB1PeO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Feb 2020 10:34:14 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:45947 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726956AbgB1PeO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Feb 2020 10:34:14 -0500
Received: by mail-oi1-f195.google.com with SMTP id v19so3173996oic.12;
        Fri, 28 Feb 2020 07:34:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JHoIxRhgYioRssl3aItHva/kMqhlc714/thZOuTd344=;
        b=N9O6QWZ9j3Tb9YEFOprQHaawNP5VSf6yKHN8ZbSmG2DdheszGQlAlizeOlfLmuEBgC
         jygAyah4fHnfDV5WDB6tG0KPMCJB8Qn3sb3FzXuvb2GfaQ6LQLKLqMcjchGXJbAVZCjU
         Z44NlqRDw2icEVt+G3v5g23fe6QJ6Z6f2+LDuVdXIDAoHmPPWL4wMcTS66S1Mk5dr0lG
         R9+28gd1y7LhSvXvmFZ8UHAOutlhmo8PHeyqvy0qE65gq6PSrQEVHhLIWIRtUXjodt36
         /zURg0K/HwI9f+TvrcI5fudT/WGwObnuzocWX2y2N1qESNd7stWDNwK1ckDfVxID+DV1
         e38Q==
X-Gm-Message-State: APjAAAXoOtlcHZOAkZC2qreL3mCCNdcNhRL09+Ly+Ll9TKIBPMogVAko
        NUbHRAFR1Vo0T+8bq9gBSQ==
X-Google-Smtp-Source: APXvYqxGbQolRQFv5+0zxGuLWsBLC8hwoIZ3Faz/JTGNBK5nNQnnwNk9b0SEpFexZcs116M+q/rSjA==
X-Received: by 2002:aca:f1c6:: with SMTP id p189mr3641411oih.159.1582904053100;
        Fri, 28 Feb 2020 07:34:13 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t22sm3245899otq.18.2020.02.28.07.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 07:34:12 -0800 (PST)
Received: (nullmailer pid 450 invoked by uid 1000);
        Fri, 28 Feb 2020 15:34:11 -0000
Date:   Fri, 28 Feb 2020 09:34:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Tom Joseph <tjoseph@cadence.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v3 1/4] dt-bindings: PCI: Add PCI Endpoint Controller
 Schema
Message-ID: <20200228153411.GA7882@bogus>
References: <20200224130905.952-1-kishon@ti.com>
 <20200224130905.952-2-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200224130905.952-2-kishon@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Feb 24, 2020 at 06:39:02PM +0530, Kishon Vijay Abraham I wrote:
> Define a common schema for PCI Endpoint Controllers.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  .../devicetree/bindings/pci/pci-ep.yaml       | 41 +++++++++++++++++++
>  1 file changed, 41 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/pci-ep.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/pci-ep.yaml b/Documentation/devicetree/bindings/pci/pci-ep.yaml
> new file mode 100644
> index 000000000000..2287771a066a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/pci-ep.yaml
> @@ -0,0 +1,41 @@
> +# SPDX-License-Identifier: (GPL2.0-only OR BSD-2-Clause)

Typo. Run checkpatch.

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/pci-ep.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: PCI Endpoint Controller Schema
> +
> +description: |
> +  Common properties for PCI Endpoint Controller Nodes.
> +
> +maintainers:
> +  - Kishon Vijay Abraham I <kishon@ti.com>
> +
> +properties:
> +  $nodename:
> +    pattern: "^pcie-ep?@"

Why the '?'? Let's define the name and fix anything that doesn't match.

> +
> +  max-functions:
> +    description: Maximum number of functions that can be configured
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint8
> +    minimum: 1
> +    default: 1
> +    maximum: 255
> +
> +  max-link-speed:
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [ 1, 2, 3, 4 ]
> +
> +  num-lanes:
> +    description: maximum number of lanes
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 1
> +    default: 1
> +    maximum: 16
> +
> +required:
> +  - compatible
> -- 
> 2.17.1
> 
