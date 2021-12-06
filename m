Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32EF346A608
	for <lists+linux-pci@lfdr.de>; Mon,  6 Dec 2021 20:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348755AbhLFT4Y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Dec 2021 14:56:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348752AbhLFT4Y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Dec 2021 14:56:24 -0500
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE5DC061746;
        Mon,  6 Dec 2021 11:52:55 -0800 (PST)
Received: by mail-ua1-x930.google.com with SMTP id p37so21933361uae.8;
        Mon, 06 Dec 2021 11:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vrXin/HXbXG1mkAXUdU3bzqqz9eX4d3rYtsLa4pucxw=;
        b=nDmVgYJ/PlSvCUzukGDeqqONJGyo38g6dxHIqMAz4ZhdMKFNYWO8zW6qPw+60MscTd
         ZkTRH2cgDr0KgoxzSbE4ybGjEmuRqdpG0TUAPpspaIkKlURBd+JO1aqhCIegCgtZGnUe
         ibnld6zq3UQCac7G8cBceBd4nd9tvhYkyGYe7s/tku2hvBJ3wZVAcM6Wd1bubAS0peNV
         ptgFa90xBpPPDM/8lrdwKbM4GKithKGd+VZjV7wBHt5Dp50BoiBF/9gpB0QONTytYwA1
         PPP5MO3zsGHhPXrGmQrnW/fcrLaC32XO/+3ua24iPnvWciTVURe9m7aCL9R40g2QLyp5
         tpzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vrXin/HXbXG1mkAXUdU3bzqqz9eX4d3rYtsLa4pucxw=;
        b=yYdmGj0FAVHe0mJh/OHDeEvmKM4GFXsuLxJWutyssa6c7tyZeulX3tmgvdBy2r45kX
         +bBOMvCUzSM4IaAc0X96P8L/YPW9jDYf/ETwvKfkM6kPfvJGZkrGv8FhiwT2p7kSTWKb
         Xcpby4+D1b4L7dm6dHQaJOVcJkyylDo7T9cxkXZNmd+nZp1YuaqtAuIj0O/2kUGJNKhq
         XDch6MkFB9su2sH1BWXUh6mwvEAMbTyizJR6PfxvNwHYnpjzMX9pdfUBGmhW4G840v5A
         NZv+fOjwMnH9ozL88L+tdBG5eiAvv2pedJ8mXdPNb3NHOGm5iR8mmts5hX7UsbjDx6CD
         E5ww==
X-Gm-Message-State: AOAM532RNwbKRQiiBb4ix4+AWVyNIw3oMs0A8ShUQ9TXwVmsWQ8vnvrc
        Fbgg8UzIaYqfX/dpc8qLB76qGvJ0nY01+TZqzZHhFSNA
X-Google-Smtp-Source: ABdhPJyUiGZbBBY7MWqrYEkfviMec8HXucbIt3f+AkAmjHcK7OnVQWqUWU5Xu/hUs3bHmfranmVtMbYS0JLk30bQKwk=
X-Received: by 2002:ab0:2a8b:: with SMTP id h11mr43242829uar.98.1638820374257;
 Mon, 06 Dec 2021 11:52:54 -0800 (PST)
MIME-Version: 1.0
References: <20211206194406.2469361-1-robh@kernel.org>
In-Reply-To: <20211206194406.2469361-1-robh@kernel.org>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Mon, 6 Dec 2021 20:52:42 +0100
Message-ID: <CAMhs-H888q9FihfXkn=wdV8j2iRTnaXiXf=9onRxab8qHvFwcQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: PCI: Fix 'unevaluatedProperties' warnings
To:     Rob Herring <robh@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Abraham I <kishon@ti.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Dec 6, 2021 at 8:44 PM Rob Herring <robh@kernel.org> wrote:
>
> With 'unevaluatedProperties' support implemented, there's several
> warnings due to undocumented properties:
>
> Documentation/devicetree/bindings/pci/mediatek,mt7621-pcie.example.dt.yaml: pcie@1e140000: pcie@0,0: Unevaluated properties are not allowed ('phy-names' was unexpected)
> Documentation/devicetree/bindings/pci/mediatek,mt7621-pcie.example.dt.yaml: pcie@1e140000: pcie@1,0: Unevaluated properties are not allowed ('phy-names' was unexpected)
> Documentation/devicetree/bindings/pci/mediatek,mt7621-pcie.example.dt.yaml: pcie@1e140000: pcie@2,0: Unevaluated properties are not allowed ('phy-names' was unexpected)
> Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.example.dt.yaml: pcie@11230000: Unevaluated properties are not allowed ('phy-names' was unexpected)
> Documentation/devicetree/bindings/pci/microchip,pcie-host.example.dt.yaml: pcie@2030000000: Unevaluated properties are not allowed ('interrupt-controller' was unexpected)
> Documentation/devicetree/bindings/pci/ti,am65-pci-ep.example.dt.yaml: pcie-ep@5500000: Unevaluated properties are not allowed ('num-ib-windows', 'num-ob-windows' were unexpected)
> Documentation/devicetree/bindings/pci/ti,am65-pci-host.example.dt.yaml: pcie@5500000: Unevaluated properties are not allowed ('num-viewport', 'interrupts' were unexpected)
> Documentation/devicetree/bindings/pci/ti,j721e-pci-host.example.dt.yaml: pcie@2900000: Unevaluated properties are not allowed ('dma-coherent' was unexpected)
>
> Add the necessary property definitions or remove the properties from the
> examples to fix these warnings.
>
> Cc: Ryder Lee <ryder.lee@mediatek.com>
> Cc: Jianjun Wang <jianjun.wang@mediatek.com>
> Cc: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: Daire McNamara <daire.mcnamara@microchip.com>
> Cc: Abraham I <kishon@ti.com>
> Cc: linux-pci@vger.kernel.org
> Cc: linux-mediatek@lists.infradead.org
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/pci/mediatek,mt7621-pcie.yaml     |  3 +++

Acked-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>

Thanks,
    Sergio Paracuellos

>  .../bindings/pci/mediatek-pcie-gen3.yaml       |  4 ++++
>  .../bindings/pci/microchip,pcie-host.yaml      | 18 ++++++++++++++++++
>  .../bindings/pci/ti,am65-pci-ep.yaml           |  2 --
>  .../bindings/pci/ti,am65-pci-host.yaml         |  4 +++-
>  .../bindings/pci/ti,j721e-pci-host.yaml        |  2 ++
>  6 files changed, 30 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/pci/mediatek,mt7621-pcie.yaml b/Documentation/devicetree/bindings/pci/mediatek,mt7621-pcie.yaml
> index 044fa967bc8b..d60f43fd9c5a 100644
> --- a/Documentation/devicetree/bindings/pci/mediatek,mt7621-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/mediatek,mt7621-pcie.yaml
> @@ -45,6 +45,9 @@ patternProperties:
>        phys:
>          maxItems: 1
>
> +      phy-names:
> +        pattern: '^pcie-phy[0-2]$'
> +
>      required:
>        - "#interrupt-cells"
>        - interrupt-map-mask
> diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> index 742206dbd965..0499b94627ae 100644
> --- a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> +++ b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
> @@ -95,6 +95,10 @@ properties:
>    phys:
>      maxItems: 1
>
> +  phy-names:
> +    items:
> +      - const: pcie-phy
> +
>    '#interrupt-cells':
>      const: 1
>
> diff --git a/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml b/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
> index 7b0776457178..edb4f81253c8 100644
> --- a/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
> +++ b/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
> @@ -46,6 +46,24 @@ properties:
>    msi-parent:
>      description: MSI controller the device is capable of using.
>
> +  interrupt-controller:
> +    type: object
> +    properties:
> +      '#address-cells':
> +        const: 0
> +
> +      '#interrupt-cells':
> +        const: 1
> +
> +      interrupt-controller: true
> +
> +    required:
> +      - '#address-cells'
> +      - '#interrupt-cells'
> +      - interrupt-controller
> +
> +    additionalProperties: false
> +
>  required:
>    - reg
>    - reg-names
> diff --git a/Documentation/devicetree/bindings/pci/ti,am65-pci-ep.yaml b/Documentation/devicetree/bindings/pci/ti,am65-pci-ep.yaml
> index 78c217d362a7..a6896cb40e83 100644
> --- a/Documentation/devicetree/bindings/pci/ti,am65-pci-ep.yaml
> +++ b/Documentation/devicetree/bindings/pci/ti,am65-pci-ep.yaml
> @@ -66,8 +66,6 @@ examples:
>          reg-names = "app", "dbics", "addr_space", "atu";
>          power-domains = <&k3_pds 120 TI_SCI_PD_EXCLUSIVE>;
>          ti,syscon-pcie-mode = <&pcie0_mode>;
> -        num-ib-windows = <16>;
> -        num-ob-windows = <16>;
>          max-link-speed = <2>;
>          dma-coherent;
>          interrupts = <GIC_SPI 340 IRQ_TYPE_EDGE_RISING>;
> diff --git a/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml b/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml
> index 834dc1c1743c..eabe1635e336 100644
> --- a/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml
> +++ b/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml
> @@ -29,6 +29,9 @@ properties:
>        - const: config
>        - const: atu
>
> +  interrupts:
> +    maxItems: 1
> +
>    power-domains:
>      maxItems: 1
>
> @@ -87,7 +90,6 @@ examples:
>          ti,syscon-pcie-id = <&pcie_devid>;
>          ti,syscon-pcie-mode = <&pcie0_mode>;
>          bus-range = <0x0 0xff>;
> -        num-viewport = <16>;
>          max-link-speed = <2>;
>          dma-coherent;
>          interrupts = <GIC_SPI 340 IRQ_TYPE_EDGE_RISING>;
> diff --git a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
> index cc900202df29..2115d5a3f0e1 100644
> --- a/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
> +++ b/Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml
> @@ -60,6 +60,8 @@ properties:
>        - const: fck
>        - const: pcie_refclk
>
> +  dma-coherent: true
> +
>    vendor-id:
>      const: 0x104c
>
> --
> 2.32.0
>
