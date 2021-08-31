Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6E8F3FCEDD
	for <lists+linux-pci@lfdr.de>; Tue, 31 Aug 2021 22:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241262AbhHaU6J (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 Aug 2021 16:58:09 -0400
Received: from mail-ot1-f47.google.com ([209.85.210.47]:38408 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234503AbhHaU6I (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 Aug 2021 16:58:08 -0400
Received: by mail-ot1-f47.google.com with SMTP id i8-20020a056830402800b0051afc3e373aso828702ots.5;
        Tue, 31 Aug 2021 13:57:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=V9SoZJoKiitq1u8ZN3GHpVYKyGQkP7ERaxx9gqUGTIc=;
        b=c+t4E0Oyn6axGlennppbvBtgooayJ/hwTuTeRkOq5HLwHR72hNp8KFmip6+cUHcq29
         94whYFXhHGSY871auLmL4MT2CrH8+96TFG5gf0v/JuH1np4pRaRlvQikgjXFaCkf1f2O
         m1sCUfbw1pDheXCwRf/PyTlMO0SXkyvChzSOKWEuYT4Xl9xIYlqK42FA7eHthyfTNY/M
         wrpqCic4J7ZAYXO2MGTpG0q4iBqKy1r03oEsaBSTt/PmdeNcLqVPGd2lqRD/vdKGnVV9
         50Ophv9dDbZEzLFqrrOCkpIT5xpjIubxgHbKl++7U8hEGK/K/ewsK16CjFa+9uZ+JlvT
         PwzQ==
X-Gm-Message-State: AOAM531gW0E+S1Yt/GmbNrQcgUf12iA0d3FjKXS9NPXQ/7pn6b4eXJeF
        AYt2RxVo66bGfJHCqak2oA==
X-Google-Smtp-Source: ABdhPJw8tg9zBXdq43Opas4yOvgMpEeoLCoWvqxX0MLBbbRLQ0kd9i6hMb6doP19JQTUoXrSvMdcfw==
X-Received: by 2002:a9d:6d02:: with SMTP id o2mr25604533otp.302.1630443432535;
        Tue, 31 Aug 2021 13:57:12 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id x3sm3703482ooe.32.2021.08.31.13.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 13:57:11 -0700 (PDT)
Received: (nullmailer pid 634764 invoked by uid 1000);
        Tue, 31 Aug 2021 20:57:10 -0000
Date:   Tue, 31 Aug 2021 15:57:10 -0500
From:   Rob Herring <robh@kernel.org>
To:     Mark Kettenis <mark.kettenis@xs4all.nl>
Cc:     devicetree@vger.kernel.org, alyssa@rosenzweig.io,
        Mark Kettenis <kettenis@openbsd.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Hector Martin <marcan@marcan.st>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Jim Quinlan <jim2101024@gmail.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-rpi-kernel@lists.infradead.org
Subject: Re: [PATCH v4 1/4] dt-bindings: interrupt-controller: Convert MSI
 controller to json-schema
Message-ID: <YS6XpkluSVRIvR6J@robh.at.kernel.org>
References: <20210827171534.62380-1-mark.kettenis@xs4all.nl>
 <20210827171534.62380-2-mark.kettenis@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210827171534.62380-2-mark.kettenis@xs4all.nl>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 27, 2021 at 07:15:26PM +0200, Mark Kettenis wrote:
> From: Mark Kettenis <kettenis@openbsd.org>
> 
> Split the MSI controller bindings from the MSI binding document
> into DT schema format using json-schema.
> 
> Signed-off-by: Mark Kettenis <kettenis@openbsd.org>
> ---
>  .../interrupt-controller/msi-controller.yaml  | 34 +++++++++++++++++++
>  .../bindings/pci/brcm,stb-pcie.yaml           |  1 +
>  .../bindings/pci/microchip,pcie-host.yaml     |  1 +
>  3 files changed, 36 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/msi-controller.yaml
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/msi-controller.yaml b/Documentation/devicetree/bindings/interrupt-controller/msi-controller.yaml
> new file mode 100644
> index 000000000000..5ed6cd46e2e0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/msi-controller.yaml
> @@ -0,0 +1,34 @@
> +# SPDX-License-Identifier: BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interrupt-controller/msi-controller.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MSI controller
> +
> +maintainers:
> +  - Marc Zyngier <marc.zyngier@arm.com>
> +
> +description: |
> +  An MSI controller signals interrupts to a CPU when a write is made
> +  to an MMIO address by some master. An MSI controller may feature a
> +  number of doorbells.
> +
> +properties:
> +  "#msi-cells":
> +    description: |
> +      The number of cells in an msi-specifier, required if not zero.
> +
> +      Typically this will encode information related to sideband data,
> +      and will not encode doorbells or payloads as these can be
> +      configured dynamically.
> +
> +      The meaning of the msi-specifier is defined by the device tree
> +      binding of the specific MSI controller.

I'd prefer we limit this to the maximum range. I'd like to know when 
someone needs 2 cells (or 3000).

enum: [ 0, 1 ]

Though no one seems to use 0 (making it optional was probably a 
mistake...)

> +
> +  msi-controller:
> +    description:
> +      Identifies the node as an MSI controller.
> +    $ref: /schemas/types.yaml#/definitions/flag

dependencies:
  "#msi-cells": [ msi-controller ]

> +
> +additionalProperties: true
> diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> index b9589a0daa5c..5c67976a8dc2 100644
> --- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> @@ -88,6 +88,7 @@ required:
>  
>  allOf:
>    - $ref: /schemas/pci/pci-bus.yaml#
> +  - $ref: ../interrupt-controller/msi-controller.yaml#

/schemas/interrupt-controller/msi-controller.yaml#

>    - if:
>        properties:
>          compatible:
> diff --git a/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml b/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
> index fb95c276a986..684d9d036f48 100644
> --- a/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
> +++ b/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
> @@ -11,6 +11,7 @@ maintainers:
>  
>  allOf:
>    - $ref: /schemas/pci/pci-bus.yaml#
> +  - $ref: ../interrupt-controller/msi-controller.yaml#
>  
>  properties:
>    compatible:
> -- 
> 2.32.0
> 
> 
