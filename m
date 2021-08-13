Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 338893EBB33
	for <lists+linux-pci@lfdr.de>; Fri, 13 Aug 2021 19:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbhHMRSH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Aug 2021 13:18:07 -0400
Received: from mail-oi1-f182.google.com ([209.85.167.182]:38571 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbhHMRSG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Aug 2021 13:18:06 -0400
Received: by mail-oi1-f182.google.com with SMTP id u25so16896025oiv.5;
        Fri, 13 Aug 2021 10:17:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=h68fhwaIJGBeInei61waRjahlBNK+UqY88zaiPuB/Gw=;
        b=Uvkk06mxrnKkewYnBdLqrz44OuLqlHMcWL2Cg+fH/r2BMQ58xb7UbmpvjWpI8BCkpK
         YjShmO9/rbcS7JqMqgKPWNyqm2tky8p43aVQIq5RE5oXCw+fr9pAS1JoFBGU0IE1yoxS
         v8rncdS251O9EfJI4ZGQHzF+SaoPS5rkkAbzW1F74Qdw3zkGaQ9ATqJeDpq/bd3JaOMa
         WATMUPLtO8tXCfSSIb/Cr3mweEA6x5n2FuPMwuXoIeGOBSP+dOUTI1PHU+GippZxjElv
         iI+i6ilGqt2B0YiCe3wVuFGhS7KnB/xdUSP4jkC6LQZxlA74RRxj8v+sPTzXjH5ncUKf
         Lx+Q==
X-Gm-Message-State: AOAM533W9OsOuFCoaDuzj5dmLK7Ar5VdTixnGvimkLQgWN7CWf4R8Q7l
        9bHC/DRrCRUSrk0mifk6uQ==
X-Google-Smtp-Source: ABdhPJx3K3cc3GWnc2e23wyDvjtkfl5TevTPrmq0X8fptV6TKcYWL8Ix2VpQOeEyvmefqxyPYSiIZA==
X-Received: by 2002:a05:6808:f07:: with SMTP id m7mr2921822oiw.16.1628875059355;
        Fri, 13 Aug 2021 10:17:39 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a19sm427823otl.48.2021.08.13.10.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 10:17:38 -0700 (PDT)
Received: (nullmailer pid 3698805 invoked by uid 1000);
        Fri, 13 Aug 2021 17:17:36 -0000
Date:   Fri, 13 Aug 2021 12:17:36 -0500
From:   Rob Herring <robh@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Tom Joseph <tjoseph@cadence.com>, linux-omap@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: PCI: ti,j721e: Add bindings to
 specify legacy interrupts
Message-ID: <YRapMFNb63MSPJ1E@robh.at.kernel.org>
References: <20210804132912.30685-1-kishon@ti.com>
 <20210804132912.30685-2-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210804132912.30685-2-kishon@ti.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 04, 2021 at 06:59:10PM +0530, Kishon Vijay Abraham I wrote:
> Add bindings to specify interrupt controller for legacy interrupts.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  .../bindings/pci/ti,j721e-pci-host.yaml           | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
> index cc900202df29..f461d7b4c0cc 100644
> --- a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
> +++ b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
> @@ -74,6 +74,11 @@ properties:
>  
>    msi-map: true
>  
> +patternProperties:
> +  "interrupt-controller":

Not a pattern unless you meant for foo-interrupt-controller-bar to be 
valid.

Anything is allowed in the node?

> +    type: object
> +    description: interrupt controller to handle legacy interrupts.
> +
>  required:
>    - compatible
>    - reg
> @@ -97,6 +102,8 @@ unevaluatedProperties: false
>  
>  examples:
>    - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
>      #include <dt-bindings/soc/ti,sci_pm_domain.h>
>      #include <dt-bindings/gpio/gpio.h>
>  
> @@ -131,5 +138,13 @@ examples:
>              ranges = <0x01000000 0x0 0x10001000  0x00 0x10001000  0x0 0x0010000>,
>                       <0x02000000 0x0 0x10011000  0x00 0x10011000  0x0 0x7fef000>;
>              dma-ranges = <0x02000000 0x0 0x0 0x0 0x0 0x10000 0x0>;
> +
> +
> +            pcie0_intc: interrupt-controller {
> +                    interrupt-controller;
> +                    #interrupt-cells = <1>;
> +                    interrupt-parent = <&gic500>;
> +                    interrupts = <GIC_SPI 312 IRQ_TYPE_EDGE_RISING>;
> +            };
>          };
>      };
> -- 
> 2.17.1
> 
> 
