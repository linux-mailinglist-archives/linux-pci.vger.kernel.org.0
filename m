Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4D193FCF0D
	for <lists+linux-pci@lfdr.de>; Tue, 31 Aug 2021 23:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234412AbhHaVW0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 Aug 2021 17:22:26 -0400
Received: from mail-ot1-f45.google.com ([209.85.210.45]:46702 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbhHaVWZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 Aug 2021 17:22:25 -0400
Received: by mail-ot1-f45.google.com with SMTP id v33-20020a0568300921b0290517cd06302dso853981ott.13;
        Tue, 31 Aug 2021 14:21:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6jdtKNJGtMPNclOsbLTtEjPl05TzE/Ds+uGwthXxqlA=;
        b=AaUNEeiqVTCfohlkSErRcsoJ3f/KoFqPbbneSqlQUXbiEHKbu7avuaf3key+iB987X
         UtdAlpzmkEzJGX4LNQ9xvEqcjsUx6jJr4Gqq8VUz3Cry0ESkJHxiK3nI1jsayCSdOw9P
         KWgUJlWuiDhRYX91+OnoHuqRGLZbqxiLvJp1sDORY9Zs+3NhIG+t6vZ1d05tPb9IiVM/
         Sj83QX1VePL2SgxOurv9NYHIQpFfVI2V3pCsizTTli9nDPPaCcVDq2dNO267Ihtf16WR
         7m6xZ/2Ij3tnNYZPH7euPYxGS634RlAaL+xamGk6rtmcawjFe8CpBolOSvnSavZC5EPR
         UlMQ==
X-Gm-Message-State: AOAM531zlkn/ORRE55oLWSTOBnVbco2tcNmhfrMNQ7wk5DBe9Em+O3oe
        IxiM8GrMrfYhP/IQGFxzxg==
X-Google-Smtp-Source: ABdhPJxHO/7oRYJs8n/4l9VZuKdHDXbkFvxcqjgFpOj8fqujBTu5jShdvNd9Ikpe2JjJ/2SpEPPjuA==
X-Received: by 2002:a9d:7017:: with SMTP id k23mr10456298otj.320.1630444889621;
        Tue, 31 Aug 2021 14:21:29 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id s24sm3874375oic.34.2021.08.31.14.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 14:21:29 -0700 (PDT)
Received: (nullmailer pid 667047 invoked by uid 1000);
        Tue, 31 Aug 2021 21:21:28 -0000
Date:   Tue, 31 Aug 2021 16:21:28 -0500
From:   Rob Herring <robh@kernel.org>
To:     Mark Kettenis <mark.kettenis@xs4all.nl>
Cc:     devicetree@vger.kernel.org, alyssa@rosenzweig.io,
        Mark Kettenis <kettenis@openbsd.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Hector Martin <marcan@marcan.st>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jim Quinlan <jim2101024@gmail.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-rpi-kernel@lists.infradead.org
Subject: Re: [PATCH v4 3/4] dt-bindings: pci: Add DT bindings for apple,pcie
Message-ID: <YS6dWI4wwg7XkuNA@robh.at.kernel.org>
References: <20210827171534.62380-1-mark.kettenis@xs4all.nl>
 <20210827171534.62380-4-mark.kettenis@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210827171534.62380-4-mark.kettenis@xs4all.nl>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 27, 2021 at 07:15:28PM +0200, Mark Kettenis wrote:
> From: Mark Kettenis <kettenis@openbsd.org>
> 
> The Apple PCIe host controller is a PCIe host controller with
> multiple root ports present in Apple ARM SoC platforms, including
> various iPhone and iPad devices and the "Apple Silicon" Macs.
> 
> Signed-off-by: Mark Kettenis <kettenis@openbsd.org>
> ---
>  .../devicetree/bindings/pci/apple,pcie.yaml   | 165 ++++++++++++++++++
>  MAINTAINERS                                   |   1 +
>  2 files changed, 166 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/apple,pcie.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/apple,pcie.yaml b/Documentation/devicetree/bindings/pci/apple,pcie.yaml
> new file mode 100644
> index 000000000000..97a126db935a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/apple,pcie.yaml
> @@ -0,0 +1,165 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/apple,pcie.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Apple PCIe host controller
> +
> +maintainers:
> +  - Mark Kettenis <kettenis@openbsd.org>
> +
> +description: |
> +  The Apple PCIe host controller is a PCIe host controller with
> +  multiple root ports present in Apple ARM SoC platforms, including
> +  various iPhone and iPad devices and the "Apple Silicon" Macs.
> +  The controller incorporates Synopsys DesigWare PCIe logic to
> +  implements its root ports.  But the ATU found on most DesignWare
> +  PCIe host bridges is absent.
> +
> +  All root ports share a single ECAM space, but separate GPIOs are
> +  used to take the PCI devices on those ports out of reset.  Therefore
> +  the standard "reset-gpios" and "max-link-speed" properties appear on
> +  the child nodes that represent the PCI bridges that correspond to
> +  the individual root ports.
> +
> +  MSIs are handled by the PCIe controller and translated into regular
> +  interrupts.  A range of 32 MSIs is provided.  These 32 MSIs can be
> +  distributed over the root ports as the OS sees fit by programming
> +  the PCIe controller's port registers.
> +
> +allOf:
> +  - $ref: /schemas/pci/pci-bus.yaml#
> +  - $ref: ../interrupt-controller/msi-controller.yaml#
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: apple,t8103-pcie
> +      - const: apple,pcie
> +
> +  reg:
> +    minItems: 3
> +    maxItems: 5
> +
> +  reg-names:
> +    minItems: 3
> +    maxItems: 5
> +    items:
> +      - const: config
> +      - const: rc
> +      - const: port0
> +      - const: port1
> +      - const: port2
> +
> +  ranges:
> +    minItems: 2
> +    maxItems: 2
> +
> +  interrupts:
> +    description:
> +      Interrupt specifiers, one for each root port.
> +    minItems: 1
> +    maxItems: 3
> +
> +  msi-parent: true

I still think this should be dropped as it is meaningless with 
'msi-controller' present.

> +
> +#  msi-ranges:
> +#    description:
> +#      A list of pairs <intid span>, where "intid" is the first
> +#      interrupt number that can be used as an MSI, and "span" the size
> +#      of that range.
> +#    $ref: /schemas/types.yaml#/definitions/phandle-array

Here, you'll want just 'maxItems: 1' as there's only 1 entry.

> +
> +  iommu-map: true
> +  iommu-map-mask: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - bus-range
> +  - interrupts
> +  - msi-controller
> +  - msi-parent
> +  - msi-ranges
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/apple-aic.h>
> +
> +    soc {
> +      #address-cells = <2>;
> +      #size-cells = <2>;
> +
> +      pcie0: pcie@690000000 {
> +        compatible = "apple,t8103-pcie", "apple,pcie";
> +        device_type = "pci";
> +
> +        reg = <0x6 0x90000000 0x0 0x1000000>,
> +              <0x6 0x80000000 0x0 0x4000>,
> +              <0x6 0x81000000 0x0 0x8000>,
> +              <0x6 0x82000000 0x0 0x8000>,
> +              <0x6 0x83000000 0x0 0x8000>;
> +        reg-names = "config", "rc", "port0", "port1", "port2";
> +
> +        interrupt-parent = <&aic>;
> +        interrupts = <AIC_IRQ 695 IRQ_TYPE_LEVEL_HIGH>,
> +                     <AIC_IRQ 698 IRQ_TYPE_LEVEL_HIGH>,
> +                     <AIC_IRQ 701 IRQ_TYPE_LEVEL_HIGH>;
> +
> +        msi-controller;
> +        msi-parent = <&pcie0>;
> +        msi-ranges = <&aic AIC_IRQ 704 IRQ_TYPE_EDGE_RISING 32>;
> +
> +        iommu-map = <0x100 &dart0 1 1>,
> +                    <0x200 &dart1 1 1>,
> +                    <0x300 &dart2 1 1>;
> +        iommu-map-mask = <0xff00>;
> +
> +        bus-range = <0 3>;
> +        #address-cells = <3>;
> +        #size-cells = <2>;
> +        ranges = <0x43000000 0x6 0xa0000000 0x6 0xa0000000 0x0 0x20000000>,
> +                 <0x02000000 0x0 0xc0000000 0x6 0xc0000000 0x0 0x40000000>;
> +
> +        clocks = <&pcie_core_clk>, <&pcie_aux_clk>, <&pcie_ref_clk>;
> +        pinctrl-0 = <&pcie_pins>;
> +        pinctrl-names = "default";
> +
> +        pci@0,0 {
> +          device_type = "pci";
> +          reg = <0x0 0x0 0x0 0x0 0x0>;
> +          reset-gpios = <&pinctrl_ap 152 0>;
> +          max-link-speed = <2>;
> +
> +          #address-cells = <3>;
> +          #size-cells = <2>;
> +          ranges;
> +        };
> +
> +        pci@1,0 {
> +          device_type = "pci";
> +          reg = <0x800 0x0 0x0 0x0 0x0>;
> +          reset-gpios = <&pinctrl_ap 153 0>;
> +          max-link-speed = <2>;
> +
> +          #address-cells = <3>;
> +          #size-cells = <2>;
> +          ranges;
> +        };
> +
> +        pci@2,0 {
> +          device_type = "pci";
> +          reg = <0x1000 0x0 0x0 0x0 0x0>;
> +          reset-gpios = <&pinctrl_ap 33 0>;
> +          max-link-speed = <1>;
> +
> +          #address-cells = <3>;
> +          #size-cells = <2>;
> +          ranges;
> +        };
> +      };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c6b8a720c0bc..30bea4042e7e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1694,6 +1694,7 @@ C:	irc://chat.freenode.net/asahi-dev
>  T:	git https://github.com/AsahiLinux/linux.git
>  F:	Documentation/devicetree/bindings/arm/apple.yaml
>  F:	Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
> +F:	Documentation/devicetree/bindings/pci/apple,pcie.yaml
>  F:	Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
>  F:	arch/arm64/boot/dts/apple/
>  F:	drivers/irqchip/irq-apple-aic.c
> -- 
> 2.32.0
> 
> 
