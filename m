Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 882CE3D6A26
	for <lists+linux-pci@lfdr.de>; Tue, 27 Jul 2021 01:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233965AbhGZWic (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Jul 2021 18:38:32 -0400
Received: from mail-io1-f42.google.com ([209.85.166.42]:39598 "EHLO
        mail-io1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233905AbhGZWiY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Jul 2021 18:38:24 -0400
Received: by mail-io1-f42.google.com with SMTP id j21so13912349ioo.6;
        Mon, 26 Jul 2021 16:18:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=H2+O3INu+m5vlU7Nzgc5GHqD5M2MaJu5bxCc0FaG6FU=;
        b=plnIs5R8cMGMCrxgeJJM+eAwSgwbTQmZJrrou6KwfAOjXnkWNE9XPm+Tfw384Jky3A
         NcPo2VTWv1wrLlbsYqXZ/1u5k70f2AN8Ga8j8+GAHoCz8h26ZunSGp5jWnwyY0Uq8ajo
         7jCm/owJf5xTc+wIaNlHdsQ0SxfmGPEZVr/5panT2zN+97XvQ9wDwZpqh8Lu76+rZuy4
         RCIDzyO0bnpYqNQZRoZVL/HgvG4UYROXPDes8AoNpV96ZNlvIVHVo+ymJRM39HvzBihA
         z4GRGbyG4f0+rMjUZsyev8HYWKGcJa71PSNgSyy4qqjOHpRv7fuVgPRCt6sWiHJBng2O
         Jc2A==
X-Gm-Message-State: AOAM532dd75S6ggY4tDzAKe+sKRgUK7ZGYcBONbch9XtmzhTYbnR6w71
        mYW+tO2qmzeG0XxrTpVFug==
X-Google-Smtp-Source: ABdhPJwqnDJuCvTLIQQXuvX3rdQEhNUYGlIzaEoXDgoxYLH/Dws2TGz6OT0a+XidQW5JzNznsSbsXQ==
X-Received: by 2002:a05:6602:249a:: with SMTP id g26mr16423388ioe.150.1627341531664;
        Mon, 26 Jul 2021 16:18:51 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id o12sm645877ilg.10.2021.07.26.16.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 16:18:50 -0700 (PDT)
Received: (nullmailer pid 1064762 invoked by uid 1000);
        Mon, 26 Jul 2021 23:18:48 -0000
Date:   Mon, 26 Jul 2021 17:18:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mark Kettenis <mark.kettenis@xs4all.nl>
Cc:     devicetree@vger.kernel.org, maz@kernel.org, robin.murphy@arm.com,
        sven@svenpeter.dev, Mark Kettenis <kettenis@openbsd.org>,
        Hector Martin <marcan@marcan.st>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: pci: Add DT bindings for apple,pcie
Message-ID: <20210726231848.GA1025245@robh.at.kernel.org>
References: <20210726083204.93196-1-mark.kettenis@xs4all.nl>
 <20210726083204.93196-2-mark.kettenis@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210726083204.93196-2-mark.kettenis@xs4all.nl>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 26, 2021 at 10:32:00AM +0200, Mark Kettenis wrote:
> From: Mark Kettenis <kettenis@openbsd.org>
> 
> The Apple PCIe host controller is a PCIe host controller with
> multiple root ports present in Apple ARM SoC platforms, including
> various iPhone and iPad devices and the "Apple Silicon" Macs.
> 
> Signed-off-by: Mark Kettenis <kettenis@openbsd.org>
> ---
>  .../devicetree/bindings/pci/apple,pcie.yaml   | 166 ++++++++++++++++++
>  MAINTAINERS                                   |   1 +
>  2 files changed, 167 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/apple,pcie.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/apple,pcie.yaml b/Documentation/devicetree/bindings/pci/apple,pcie.yaml
> new file mode 100644
> index 000000000000..bfcbdee79c64
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/apple,pcie.yaml
> @@ -0,0 +1,166 @@
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

blank line

> +  All root ports share a single ECAM space, but separate GPIOs are
> +  used to take the PCI devices on those ports out of reset.  Therefore
> +  the standard "reset-gpio" and "max-link-speed" properties appear on

reset-gpios

> +  the child nodes that represent the PCI bridges that correspond to
> +  the individual root ports.

blank line

> +  MSIs are handled by the PCIe controller and translated into regular
> +  interrupts.  A range of 32 MSIs is provided.  These 32 MSIs can be
> +  distributed over the root ports as the OS sees fit by programming
> +  the PCIe controller's port registers.
> +
> +allOf:
> +  - $ref: /schemas/pci/pci-bus.yaml#
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
> +  msi-controller: true
> +  msi-parent: true
> +
> +  msi-ranges:
> +    description:
> +      A list of pairs <intid span>, where "intid" is the first
> +      interrupt number that can be used as an MSI, and "span" the size
> +      of that range.
> +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
> +    items:
> +      minItems: 2
> +      maxItems: 2

I still have issues I raised on v1 with this property. It's genericish 
looking, but not generic. 'intid' as a single cell can't specify any 
parent interrupt such as a GIC which uses 3 cells. You could put in all 
the cells, but you'd still be assuming which cell you can increment.

I think you should just list all these under 'interrupts' using 
interrupt-names to make your life easier:

interrupt-names:
  items:
    - const: port0
    - const: port1
    - const: port2
    - const: msi0
    - const: msi1
    - const: msi2
    - const: msi3
    ...

Yeah, it's kind of verbose, but if the h/w block handles N interrupts, 
you should list N interrupts. The worst case for the above is N entries 
too if not contiguous.

Rob
