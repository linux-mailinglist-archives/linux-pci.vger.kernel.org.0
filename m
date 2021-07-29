Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7733DA6D6
	for <lists+linux-pci@lfdr.de>; Thu, 29 Jul 2021 16:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbhG2Ou3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Jul 2021 10:50:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:49654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237779AbhG2Ou1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 29 Jul 2021 10:50:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4555460EC0;
        Thu, 29 Jul 2021 14:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627570224;
        bh=XKY5u0bJ0B2fRF4cBxdfCIrb0OGQzonKKoO795Xgo9g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RcHHfDNr+N5GfVElx2ARm+V1D6/WXteoAS5srn7ibnU+95jvLFM47yr/X4uuralwI
         CEMnd+b2pjHXACptGqSmo8iS9Oap2ck0uqGgR+Xey7nPUN9bDsZte3ZGrKDPp388A9
         /xWDVobjH1jmp/SpN9pde1Mu+IOTNy7MS1kkwtMHKKB7/L6AczxZgffQOQX7pBcl3l
         KX5Wh8JZ+hZR1/MOjWKunlm2zahnCUlk2KWl7IWtJk73h0ByNQnmem6qlz54zMvXQp
         BT7os1idhAU6j4NnI304O7716UMnwfSB+6qc1+Kc4I7D78xHM9rAaVw1BNHF/TbxrD
         QeTLvnMSMTlYQ==
Received: by mail-ed1-f42.google.com with SMTP id p21so8559513edi.9;
        Thu, 29 Jul 2021 07:50:24 -0700 (PDT)
X-Gm-Message-State: AOAM531D7YZOJ2k1ocxrRf9BzeMv7pD80x6w16/zAQ70spV7kWjF8qTl
        FG9GhWxoPlNmzdso05SfOUKZERm7Zx5uRBN/yg==
X-Google-Smtp-Source: ABdhPJw3ygJAkZ4ht4GjoVI/NQA/HWHfXCRKB5L4L2V65JZswoBAhU1tRjae+rErWf0dH6UZKtJiXEfjzfHORM7yZjY=
X-Received: by 2002:aa7:d8d4:: with SMTP id k20mr6317360eds.373.1627570222829;
 Thu, 29 Jul 2021 07:50:22 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1627559126.git.mchehab+huawei@kernel.org> <2cf7bd80d0b54f7658a64febf79d3a36e70aba86.1627559126.git.mchehab+huawei@kernel.org>
In-Reply-To: <2cf7bd80d0b54f7658a64febf79d3a36e70aba86.1627559126.git.mchehab+huawei@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 29 Jul 2021 08:50:10 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLhxGFV9iBhbYj7QNct54Se7pBhhTgFyqRYO0uLvoPnmg@mail.gmail.com>
Message-ID: <CAL_JsqLhxGFV9iBhbYj7QNct54Se7pBhhTgFyqRYO0uLvoPnmg@mail.gmail.com>
Subject: Re: [PATCH 3/5] dt-bindings: PCI: kirin: Add support for Kirin970
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linuxarm <linuxarm@huawei.com>, mauro.chehab@huawei.com,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 29, 2021 at 5:56 AM Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> Add a new compatible, plus the new bindings needed by
> HiKey970 board.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  .../bindings/pci/hisilicon,kirin-pcie.yaml    | 61 ++++++++++++++++++-
>  1 file changed, 60 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml b/Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml
> index 90cab09e8d4b..bb0c3a081d68 100644
> --- a/Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml
> @@ -24,11 +24,13 @@ properties:
>      contains:
>        enum:
>          - hisilicon,kirin960-pcie
> +        - hisilicon,kirin970-pcie
>
>    reg:
>      description: |
>        Should contain dbi, apb, config registers location and length.
> -      For HiKey960, it should also contain phy.
> +      For HiKey960, it should also contain phy. All other devices
> +      should use a separate phy driver.
>      minItems: 3
>      maxItems: 4
>
> @@ -47,6 +49,7 @@ examples:
>    - |
>      #include <dt-bindings/interrupt-controller/arm-gic.h>
>      #include <dt-bindings/clock/hi3660-clock.h>
> +    #include <dt-bindings/clock/hi3670-clock.h>
>
>      soc {
>        #address-cells = <2>;
> @@ -83,4 +86,60 @@ examples:
>          clock-names = "pcie_phy_ref", "pcie_aux", "pcie_apb_phy",
>                        "pcie_apb_sys", "pcie_aclk";
>        };
> +
> +      pcie@f5000000 {
> +        compatible = "hisilicon,kirin970-pcie";
> +        reg = <0x0 0xf4000000 0x0 0x1000000>,
> +              <0x0 0xfc180000 0x0 0x1000>,
> +              <0x0 0xf5000000 0x0 0x2000>;
> +        reg-names = "dbi", "apb", "config";
> +        bus-range = <0x0  0x1>;
> +        msi-parent = <&its_pcie>;
> +        #address-cells = <3>;
> +        #size-cells = <2>;
> +        device_type = "pci";
> +        phys = <&pcie_phy>;
> +        ranges = <0x02000000 0x0 0x00000000
> +                  0x0 0xf6000000
> +                  0x0 0x02000000>;
> +        num-lanes = <1>;
> +        #interrupt-cells = <1>;
> +        interrupts = <GIC_SPI 283 IRQ_TYPE_LEVEL_HIGH>;
> +        interrupt-names = "msi";
> +        interrupt-map-mask = <0 0 0 7>;
> +        interrupt-map = <0x0 0 0 1 &gic GIC_SPI 282 IRQ_TYPE_LEVEL_HIGH>,
> +                        <0x0 0 0 2 &gic GIC_SPI 283 IRQ_TYPE_LEVEL_HIGH>,
> +                        <0x0 0 0 3 &gic GIC_SPI 284 IRQ_TYPE_LEVEL_HIGH>,
> +                        <0x0 0 0 4 &gic GIC_SPI 285 IRQ_TYPE_LEVEL_HIGH>;
> +        pcie@4,0 { // Lane 4: M.2

You are missing a level here. You need the upstream bridge device. I
figured this out for you, why am I having to correct it?

Isn't this supposed to be Device 1 as 1 and 4 are swapped in terms of
lane number and device number.

> +          reg = <0 0 0 0 0>;

Not the right address. I would have expected a dtc warning on this.

> +          compatible = "pciclass,0604";
> +          device_type = "pci";
> +          reset-gpios = <&gpio7 1 0>;
> +          clkreq-gpios = <&gpio27 3 0 >;
> +          #address-cells = <3>;
> +          #size-cells = <2>;
> +          ranges;
> +        };
> +        pcie@5,0 { // Lane 5: Mini PCIe

It's device 5 not lane 5.


> +          reg = <0 0 0 0 0>;
> +          compatible = "pciclass,0604";
> +          device_type = "pci";
> +          reset-gpios = <&gpio7 2 0>;
> +          clkreq-gpios = <&gpio17 0 0 >;
> +          #address-cells = <3>;
> +          #size-cells = <2>;
> +          ranges;
> +        };
> +        pcie@7,0 { // Lane 7: Ethernet
> +          reg = <0 0 0 0 0>;
> +          compatible = "pciclass,0604";
> +          device_type = "pci";
> +          reset-gpios = <&gpio7 3 0>;
> +          clkreq-gpios = <&gpio20 0 0 >;
> +          #address-cells = <3>;
> +          #size-cells = <2>;
> +          ranges;
> +        };
> +      };
>      };
> --
> 2.31.1
>
