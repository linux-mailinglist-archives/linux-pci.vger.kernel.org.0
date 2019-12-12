Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0397211D005
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2019 15:41:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729404AbfLLOlP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Dec 2019 09:41:15 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42474 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729287AbfLLOlP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Dec 2019 09:41:15 -0500
Received: by mail-ot1-f67.google.com with SMTP id 66so2193021otd.9;
        Thu, 12 Dec 2019 06:41:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1MpAVnQXIv8ku6mOOgsViBA0ZgH1Jr6htBIpVf8hv44=;
        b=TmfxLvpiE1YGEOvfsMj4j2KSVOGGvMe7y6y21tDR2a5R2kqs7cP27dib0KhgjIlbZa
         8oAR3gFeXU1le1bcPyK3oWXBUdoxeh8D/i8gDDQxIibE460qAUivtlVigN90XrxHDH2Q
         e5iwpDQAEJY9FY6XihbJLgMVP0jfkVPamLRPB8X82N7D6mGJ6Qm1QdfpVGa50pQ8ji/t
         zi9mniyBKVwnP4PN1yG2VrRD5F1ccYbqKYJQS1vKMA7P/uIXamK8rpqpq8fJ/APnj204
         Krx+X6XHj8VUNU5/DyWfoWmk6NusQiREyuvIo64GwkH5mkr6iOr/ZhvzvI3tUsjrjl+v
         bC6Q==
X-Gm-Message-State: APjAAAWA1tR13HxMItYcRQzOCDOmNn24QhBNWNXsf8Q7pX5ccdwOfQhk
        4Y70Xyq4cH1gZTqIfd70Kwhoe7xN9jsyg1CGA5U=
X-Google-Smtp-Source: APXvYqxjBHOhA2FAx/R9INxJKIh2DYhKaOmC+96fdWuPR9sXbpqz4T1747pPnd9kezYbXhCT9EEkcIi2C43a+mOB/ac=
X-Received: by 2002:a9d:2073:: with SMTP id n106mr8392139ota.145.1576161674382;
 Thu, 12 Dec 2019 06:41:14 -0800 (PST)
MIME-Version: 1.0
References: <20191116005240.15722-1-robh@kernel.org> <20191116005240.15722-3-robh@kernel.org>
In-Reply-To: <20191116005240.15722-3-robh@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 12 Dec 2019 15:41:03 +0100
Message-ID: <CAMuHMdX20LvK2o1cZJ8q83Q08JQzH6L07gmqBm0V0xSc5GHk4A@mail.gmail.com>
Subject: Re: [PATCH 3/3] dt-bindings: PCI: Convert generic host binding to DT schema
To:     Rob Herring <robh@kernel.org>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Will Deacon <will@kernel.org>,
        David Daney <david.daney@cavium.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rob,

On Sat, Nov 16, 2019 at 1:53 AM Rob Herring <robh@kernel.org> wrote:
> Convert the generic PCI host binding to DT schema. The derivative Juno,
> PLDA XpressRICH3-AXI, and Designware ECAM bindings all just vary in
> their compatible strings. The simplest way to convert those to
> schema is just add them into the common generic PCI host schema.
>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Andrew Murray <andrew.murray@arm.com>
> Cc: Zhou Wang <wangzhou1@hisilicon.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: David Daney <david.daney@cavium.com>
> Signed-off-by: Rob Herring <robh@kernel.org>

> index 515b2f9542e5..000000000000
> --- a/Documentation/devicetree/bindings/pci/designware-pcie-ecam.txt
> +++ /dev/null

> -Example:
> -
> -    pcie1: pcie@7f000000 {
> -        compatible = "socionext,synquacer-pcie-ecam", "snps,dw-pcie-ecam";
> -        device_type = "pci";
> -        reg = <0x0 0x7f000000 0x0 0xf00000>;
> -        bus-range = <0x0 0xe>;
> -        #address-cells = <3>;
> -        #size-cells = <2>;
> -        ranges = <0x1000000 0x00 0x00010000 0x00 0x7ff00000 0x0 0x00010000>,
> -                 <0x2000000 0x00 0x70000000 0x00 0x70000000 0x0 0x0f000000>,
> -                 <0x3000000 0x3f 0x00000000 0x3f 0x00000000 0x1 0x00000000>;
> -
> -        #interrupt-cells = <0x1>;
> -        interrupt-map-mask = <0x0 0x0 0x0 0x0>;

An all-zeroes interrupt-map-mask seems to be very common on embedded
SoCs, where all devices are mapped to a single interrupt.

However, schemas/pci/pci-bus.yaml says:

  interrupt-map-mask:
    items:
      - description: PCI high address cell
        minimum: 0
        maximum: 0xf800
      - description: PCI mid address cell
        const: 0
      - description: PCI low address cell
        const: 0
      - description: PCI IRQ cell
        minimum: 1
        maximum: 7

and thus complains about an all-zeroes mask, e.g.

    arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dt.yaml:
pcie@fe000000: interrupt-map-mask:0:3: 0 is less than the minimum of 1

> -        interrupt-map = <0x0 0x0 0x0 0x0 &gic 0x0 0x0 0x0 182 0x4>;
> -        msi-map = <0x0 &its 0x0 0x10000>;
> -        dma-coherent;
> -    };

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
