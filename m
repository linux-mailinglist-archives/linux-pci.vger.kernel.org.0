Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA12C3FCEE1
	for <lists+linux-pci@lfdr.de>; Tue, 31 Aug 2021 22:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241266AbhHaU7M (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 Aug 2021 16:59:12 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:41896 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234503AbhHaU7L (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 Aug 2021 16:59:11 -0400
Received: by mail-ot1-f41.google.com with SMTP id o16-20020a9d2210000000b0051b1e56c98fso806287ota.8;
        Tue, 31 Aug 2021 13:58:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ttc6BFE8i2YohRGpw4NNDVy3AnnswlwsfciYjJziAtc=;
        b=VcGCa11E0y7LyDzZ1vWjkwLfdaLXSEV1/CrY4hB2nky8xpI5pFr+wY9t2lxGUZJCdi
         uuhKi7E6oQTWGQR8POuZ7hqbmA9QIMrq+1NqbTS1YZ+ltJ+QB56jnTWrzIGsKcvBWkJT
         /Zg/xG3N8YFSyzhOC2Tigi7ONDu8MV1K2joos0Qo1PXVXrOuKG7jusHjGEkETrC3A97B
         U6Xk7QI2FzGGP19jKwoTnIuu6EGTqk35IoOWJlrea1/JERrHOk6x4aMMNDkjQDcwKtYP
         tv5tN78HtWqOVm2pQDRc8hE4n9wpRX8V5JWP+qYRA4h1+7soergL7qFaeb6Gi9F4XlSy
         ipNw==
X-Gm-Message-State: AOAM531yHo2vIhGN4RpKJa9QRUgpPgux7+qrdCeGOYZzSDJow+IQzwgu
        vetaymXD8VxG8ryytXhSpg==
X-Google-Smtp-Source: ABdhPJwlhiRBHpvmPeMO1vZFfVDFZfPcHNVAGNl/9PB9MSPKy8mRNVb81dKTg4NwstxUVpTItamSeg==
X-Received: by 2002:a9d:6c04:: with SMTP id f4mr25909822otq.185.1630443495874;
        Tue, 31 Aug 2021 13:58:15 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id j8sm1586043ooc.21.2021.08.31.13.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 13:58:15 -0700 (PDT)
Received: (nullmailer pid 636154 invoked by uid 1000);
        Tue, 31 Aug 2021 20:58:14 -0000
Date:   Tue, 31 Aug 2021 15:58:14 -0500
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
Message-ID: <YS6X5kXw18/RBLLP@robh.at.kernel.org>
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

Not the current email for Marc.

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
> +
> +  msi-controller:
> +    description:
> +      Identifies the node as an MSI controller.
> +    $ref: /schemas/types.yaml#/definitions/flag
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
