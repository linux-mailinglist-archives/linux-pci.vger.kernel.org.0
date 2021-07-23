Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0CC03D432A
	for <lists+linux-pci@lfdr.de>; Sat, 24 Jul 2021 00:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232884AbhGWWPu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Jul 2021 18:15:50 -0400
Received: from mail-il1-f170.google.com ([209.85.166.170]:45018 "EHLO
        mail-il1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231954AbhGWWPu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Jul 2021 18:15:50 -0400
Received: by mail-il1-f170.google.com with SMTP id o7so1764608ilh.11;
        Fri, 23 Jul 2021 15:56:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Nf+qt9aa1rSV4UzSkW75Dv0K2P4ud9e7UDTiA2I8cjw=;
        b=LHw3g99fNWK1QffD9Y6a4ejuVH/nSydDqYo6jySqsYMq+UeRMs81/Pazhx+JfO7wOU
         BzVVQNlslUKqaXJscnPZfJ1L5fHULREMDVdgn12OQcN8WyK4juqwt5hAPE90g5lsZWsC
         Sw1ShMQvLS8ljuhNFcRiOgBQKUYOZ3mC+ZLj0O8YWoL/ISe6/m+tux/fSoUwLQqjGvga
         uPCOOEjyiKVpEyDzc0r8NNPtFJtQE7VciltTDEqxBQUjQ8y6kL7Uwk3RcipuRgwXYfk2
         NTZJpCL6s98VGkyCT6xxCdk7f42kGPcE99UtdSL7rhQ03+Pgt9XfdisVXkuWQFCL6OSv
         jrxw==
X-Gm-Message-State: AOAM532OdPI5jQr7m/HyBOfYnT0hEYiKVNn3zEincgfD5mQOmbbLQr8I
        qwvZZSJTJIFNOYzAVx3ESA==
X-Google-Smtp-Source: ABdhPJxrMlYwMTsx9BussFd45y1mf1OXhr4YfBsrt5IJ9V81f6mHtK7gJpUnGtE1wTTvTrMQ/5KzAw==
X-Received: by 2002:a05:6e02:1aa2:: with SMTP id l2mr4578165ilv.224.1627080982152;
        Fri, 23 Jul 2021 15:56:22 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id t26sm8907513iob.19.2021.07.23.15.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 15:56:21 -0700 (PDT)
Received: (nullmailer pid 2758526 invoked by uid 1000);
        Fri, 23 Jul 2021 22:56:18 -0000
Date:   Fri, 23 Jul 2021 16:56:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        linuxarm@huawei.com, mauro.chehab@huawei.com,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v7 09/10] dt-bindings: PCI: kirin-pcie.txt: Convert it to
 yaml
Message-ID: <20210723225618.GA2750572@robh.at.kernel.org>
References: <cover.1626855713.git.mchehab+huawei@kernel.org>
 <656b8ffe505081b003650f040de4d52131d70b8f.1626855713.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <656b8ffe505081b003650f040de4d52131d70b8f.1626855713.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 21, 2021 at 10:39:11AM +0200, Mauro Carvalho Chehab wrote:
> Convert the file into a JSON description at the yaml format.

And add 970...

> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  .../bindings/pci/hisilicon,kirin-pcie.yaml    | 87 +++++++++++++++++++
>  .../devicetree/bindings/pci/kirin-pcie.txt    | 50 -----------
>  .../devicetree/bindings/pci/snps,dw-pcie.yaml |  2 +-
>  MAINTAINERS                                   |  2 +-
>  4 files changed, 89 insertions(+), 52 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml
>  delete mode 100644 Documentation/devicetree/bindings/pci/kirin-pcie.txt
> 
> diff --git a/Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml b/Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml
> new file mode 100644
> index 000000000000..eabc651c9766
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml
> @@ -0,0 +1,87 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/hisilicon,kirin-pcie.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: HiSilicon Kirin SoCs PCIe host DT description
> +
> +maintainers:
> +  - Xiaowei Song <songxiaowei@hisilicon.com>
> +  - Binghui Wang <wangbinghui@hisilicon.com>
> +
> +description: |
> +  Kirin PCIe host controller is based on the Synopsys DesignWare PCI core.
> +  It shares common functions with the PCIe DesignWare core driver and
> +  inherits common properties defined in
> +  Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml.
> +
> +allOf:
> +  - $ref: /schemas/pci/snps,dw-pcie.yaml#
> +
> +properties:
> +  compatible:
> +    contains:
> +      enum:
> +        - hisilicon,kirin960-pcie
> +        - hisilicon,kirin970-pcie
> +
> +  reg:
> +    description: |
> +      Should contain rc_dbi, apb, config registers location and length.
> +    minItems: 3
> +    maxItems: 4
> +
> +  reg-names:
> +    items:
> +      - const: dbi          # controller configuration registers
> +      - const: apb          # apb Ctrl register defined by Kirin
> +      - const: config       # PCIe configuration space registers
> +      - const: phy          # apb PHY register used on Kirin 960 PHY
> +    minItems: 3
> +    maxItems: 4
> +
> +  reset-gpios:
> +    description: The GPIO(s) to generate PCIe PERST# assert and deassert signal.
> +    minItems: 1
> +    maxItems: 4

I'll apply this, but only with 'maxItems: 1' if you want to separate the 
discussion on that part.

> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    soc {
> +      #address-cells = <2>;
> +      #size-cells = <2>;
> +
> +      pcie: pcie@f4000000 {
> +        compatible = "hisilicon,kirin970-pcie";
> +        reg = <0x0 0xf4000000 0x0 0x1000>,
> +              <0x0 0xff3fe000 0x0 0x1000>,
> +              <0x0 0xf4000000 0 0x2000>;
> +        reg-names = "dbi", "apb", "config";
> +        bus-range = <0x0  0x1>;
> +        #address-cells = <3>;
> +        #size-cells = <2>;
> +        device_type = "pci";
> +        ranges = <0x02000000 0x0 0x00000000 0x0 0xf5000000 0x0 0x2000000>;
> +        num-lanes = <1>;
> +        #interrupt-cells = <1>;
> +        interrupts = <0 283 4>;
> +        interrupt-names = "msi";
> +        interrupt-map-mask = <0xf800 0 0 7>;
> +        interrupt-map = <0x0 0 0 1 &gic GIC_SPI 282 IRQ_TYPE_LEVEL_HIGH>,
> +                        <0x0 0 0 2 &gic GIC_SPI 283 IRQ_TYPE_LEVEL_HIGH>,
> +                        <0x0 0 0 3 &gic GIC_SPI 284 IRQ_TYPE_LEVEL_HIGH>,
> +                        <0x0 0 0 4 &gic GIC_SPI 285 IRQ_TYPE_LEVEL_HIGH>;
> +        reset-gpios = <&gpio7 0 0 >, <&gpio25 2 0 >,
> +                      <&gpio3 1 0 >, <&gpio27 4 0 >;
> +      };
> +    };
