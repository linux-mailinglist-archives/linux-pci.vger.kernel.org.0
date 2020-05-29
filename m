Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD1ED1E8594
	for <lists+linux-pci@lfdr.de>; Fri, 29 May 2020 19:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbgE2Rqj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 May 2020 13:46:39 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:34281 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727000AbgE2Rqh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 May 2020 13:46:37 -0400
Received: by mail-io1-f67.google.com with SMTP id m81so268061ioa.1;
        Fri, 29 May 2020 10:46:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uFnVyxyYwJVoCZ3HaonYsIsN3iwvAc7JxY9rKZpt/K8=;
        b=l226eS410I+Nw/TOFLAp1FhLh1I1GeQhc7SD+Ldf3t+CTKJPAmVoXhY+IKPVWjj/r2
         razrkwqmRVUgw3dlhVUs3OcYdfr5c9mFY8/3+Pm6W1ALo4RC4Q8oJuB8nsleuiIIpMgs
         8cffKVb3x1ECSVyW3ozg+xwiScajiffOyJPGt+T0T7paG61h9MaTdaeNb0aJcxUXpTz1
         geCGVhRa8vFjWjqsA1VX4RtNzTWzvide01y/9RGRK5EgsCkubU0Qkp2gDbC1rVUjcNRn
         NGdia5jLl1y8/OmeY7pz2TA3rk9mOk3bRzq9V3rvMy7MXBv/e0gRwQtry+fODTTXIAYt
         ROPQ==
X-Gm-Message-State: AOAM531iKL0w/yZnV0egcyV5aDwcW2v5l8ghBXwo3+8R4hBLIvqYQoxZ
        +5uzNz5vaUVt/BvZwlnWYA==
X-Google-Smtp-Source: ABdhPJwjS3w7ZtKakac5v5DKPoWn+fDmbQuB2ZUlOeCmiF3wBEkiaj9LvMIYSiXwx3MBAzX8lp3xHQ==
X-Received: by 2002:a02:a78e:: with SMTP id e14mr8439243jaj.9.1590774395987;
        Fri, 29 May 2020 10:46:35 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id j2sm4022503ioo.8.2020.05.29.10.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 10:46:35 -0700 (PDT)
Received: (nullmailer pid 2640143 invoked by uid 1000);
        Fri, 29 May 2020 17:46:34 -0000
Date:   Fri, 29 May 2020 11:46:34 -0600
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
Subject: Re: [PATCH v2 03/14] dt-bindings: PCI: Add bindings for more Brcmstb
 chips
Message-ID: <20200529174634.GA2630216@bogus>
References: <20200526191303.1492-1-james.quinlan@broadcom.com>
 <20200526191303.1492-4-james.quinlan@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526191303.1492-4-james.quinlan@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 26, 2020 at 03:12:42PM -0400, Jim Quinlan wrote:
> From: Jim Quinlan <jquinlan@broadcom.com>
> 
> - Add compatible strings for three more Broadcom STB chips: 7278, 7216,
>   7211 (STB version of RPi4).
> - add new property 'brcm,scb-sizes'
> - add new property 'resets'
> - add new property 'reset-names'
> - allow 'ranges' and 'dma-ranges' to have more than one item and update
>   the example to show this.
> 
> Signed-off-by: Jim Quinlan <jquinlan@broadcom.com>
> ---
>  .../bindings/pci/brcm,stb-pcie.yaml           | 40 +++++++++++++++++--
>  1 file changed, 36 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> index 8680a0f86c5a..66a7df45983d 100644
> --- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> @@ -14,7 +14,13 @@ allOf:
>  
>  properties:
>    compatible:
> -    const: brcm,bcm2711-pcie # The Raspberry Pi 4
> +    items:
> +      - enum:

Don't need items here. Just change the const to enum.

> +          - brcm,bcm2711-pcie # The Raspberry Pi 4
> +          - brcm,bcm7211-pcie # Broadcom STB version of RPi4
> +          - brcm,bcm7278-pcie # Broadcom 7278 Arm
> +          - brcm,bcm7216-pcie # Broadcom 7216 Arm
> +          - brcm,bcm7445-pcie # Broadcom 7445 Arm
>  
>    reg:
>      maxItems: 1
> @@ -34,10 +40,12 @@ properties:
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
> @@ -58,8 +66,30 @@ properties:
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

These are going to need to be an if/then schema if they only apply to 
certain compatible(s).

> +
> +  brcm,scb-sizes:
> +    description: (u32, u32) tuple giving the 64bit PCIe memory
> +      viewport size of a memory controller.  There may be up to
> +      three controllers, and each size must be a power of two
> +      with a size greater or equal to the amount of memory the
> +      controller supports.

This sounds like what dma-ranges should express?

If not, we do have 64-bit size if that what you need.

> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32-array
> +      - items:
> +          minItems: 2
> +          maxItems: 6
> +
>  required:
>    - reg
> +  - ranges
>    - dma-ranges
>    - "#interrupt-cells"
>    - interrupts
> @@ -93,7 +123,9 @@ examples:
>                      msi-parent = <&pcie0>;
>                      msi-controller;
>                      ranges = <0x02000000 0x0 0xf8000000 0x6 0x00000000 0x0 0x04000000>;
> -                    dma-ranges = <0x02000000 0x0 0x00000000 0x0 0x00000000 0x0 0x80000000>;
> +                    dma-ranges = <0x42000000 0x1 0x00000000 0x0 0x40000000 0x0 0x80000000>,
> +                                 <0x42000000 0x1 0x80000000 0x3 0x00000000 0x0 0x80000000>;
>                      brcm,enable-ssc;
> +                    brcm,scb-sizes = <0x0 0x80000000 0x0 0x80000000>;
>              };
>      };
> -- 
> 2.17.1
> 
