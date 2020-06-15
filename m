Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06B811F9ECF
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jun 2020 19:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731278AbgFORsv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Jun 2020 13:48:51 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:32789 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728585AbgFORsu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Jun 2020 13:48:50 -0400
Received: by mail-il1-f193.google.com with SMTP id z2so16133450ilq.0;
        Mon, 15 Jun 2020 10:48:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7kn635n+A3EnYes4BFXu6QF7YNnmuVI9peNToiemopE=;
        b=jzmCUB8gPiBXXg9Z+5ah+r/Gx3tI1u8/I3HTamCaM4GjS/MspRzVxABJWH3XBZj8dK
         vuc7125g8kmjAi48zTc0ROdSR5bkzvDnCobiG/2Lbna2rl3WI1WMt/Zfhlke2t/tga4x
         a4d/PsrWoLUMm+S3ZXW7LYYnUTGX47KNXm9C/8sxz+bZKVCLYbsYAYAg0F0yFUFOAmWt
         6njmt7mbpY4NyD1Zjw604m/D+KrHAvQi8bGxb7aY7pSEX7Hn16xGYu+yfEp8pR/wXx9o
         f1/mFTcGVmPqa6MHmhVZpJbiI0bAh6cVa2OoyPYiYNqky7DF4sQ4eopx+AAmSKA18Ok5
         vDeA==
X-Gm-Message-State: AOAM531zCMRioVhzWelZ2NwslpVRLnE5Cj7JkBph0qH9wnzZkkIn7qAx
        YasmaZprMxEiCmPha7VFjA==
X-Google-Smtp-Source: ABdhPJxw8ZUBrSdNoZ0KM84tqgOSaSJTSDg0ljmVjphSbOR1nFj9HkbHbjM55RFjiGVS/wkHkSpA7A==
X-Received: by 2002:a92:c6cd:: with SMTP id v13mr26329867ilm.150.1592243329646;
        Mon, 15 Jun 2020 10:48:49 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id b13sm8297409ilq.20.2020.06.15.10.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 10:48:49 -0700 (PDT)
Received: (nullmailer pid 2028876 invoked by uid 1000);
        Mon, 15 Jun 2020 17:48:48 -0000
Date:   Mon, 15 Jun 2020 11:48:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     linux-pci@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 03/12] dt-bindings: PCI: Add bindings for more Brcmstb
 chips
Message-ID: <20200615174848.GA2023599@bogus>
References: <20200605212706.7361-1-james.quinlan@broadcom.com>
 <20200605212706.7361-4-james.quinlan@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200605212706.7361-4-james.quinlan@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 05, 2020 at 05:26:43PM -0400, Jim Quinlan wrote:
> From: Jim Quinlan <jquinlan@broadcom.com>
> 
> - Add compatible strings for three more Broadcom STB chips: 7278, 7216,
>   7211 (STB version of RPi4).
> - add new property 'brcm,scb-sizes'
> - add new property 'resets'
> - add new property 'reset-names' for 7216 only
> - allow 'ranges' and 'dma-ranges' to have more than one item and update
>   the example to show this.
> 
> Signed-off-by: Jim Quinlan <jquinlan@broadcom.com>
> ---
>  .../bindings/pci/brcm,stb-pcie.yaml           | 58 ++++++++++++++++---
>  1 file changed, 51 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> index 8680a0f86c5a..4a012d77513f 100644
> --- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> @@ -9,12 +9,15 @@ title: Brcmstb PCIe Host Controller Device Tree Bindings
>  maintainers:
>    - Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
>  
> -allOf:
> -  - $ref: /schemas/pci/pci-bus.yaml#
> -
>  properties:
>    compatible:
> -    const: brcm,bcm2711-pcie # The Raspberry Pi 4
> +    items:
> +      - enum:
> +          - brcm,bcm2711-pcie # The Raspberry Pi 4
> +          - brcm,bcm7211-pcie # Broadcom STB version of RPi4
> +          - brcm,bcm7278-pcie # Broadcom 7278 Arm
> +          - brcm,bcm7216-pcie # Broadcom 7216 Arm
> +          - brcm,bcm7445-pcie # Broadcom 7445 Arm
>  
>    reg:
>      maxItems: 1
> @@ -34,10 +37,12 @@ properties:
>        - const: msi
>  
>    ranges:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 4
>  
>    dma-ranges:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 6
>  
>    clocks:
>      maxItems: 1
> @@ -58,8 +63,33 @@ properties:
>  
>    aspm-no-l0s: true
>  
> +  resets:
> +    description: for "brcm,bcm7216-pcie", must be a valid reset
> +      phandle pointing to the RESCAL reset controller provider node.
> +    $ref: "/schemas/types.yaml#/definitions/phandle"
> +
> +  reset-names:
> +    items:
> +      - const: rescal
> +
> +  brcm,scb-sizes:
> +    description: u64 giving the 64bit PCIe memory
> +      viewport size of a memory controller.  There may be up to
> +      three controllers, and each size must be a power of two
> +      with a size greater or equal to the amount of memory the
> +      controller supports.  Note that each memory controller
> +      may have two component regions -- base and extended -- so
> +      this information cannot be deduced from the dma-ranges.
> +
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint64-array
> +      - items:
> +          minItems: 1
> +          maxItems: 3

This can be (dropping 'allOf'):

$ref: /schemas/types.yaml#/definitions/uint64-array
minItems: 1
maxItems: 3

With that,

Reviewed-by: Rob Herring <robh@kernel.org>
