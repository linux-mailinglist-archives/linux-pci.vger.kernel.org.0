Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5B37351B99
	for <lists+linux-pci@lfdr.de>; Thu,  1 Apr 2021 20:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234821AbhDASI6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Apr 2021 14:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234914AbhDASBg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Apr 2021 14:01:36 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7977DC03116B;
        Thu,  1 Apr 2021 09:54:16 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id r17-20020a4acb110000b02901b657f28cdcso703126ooq.6;
        Thu, 01 Apr 2021 09:54:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CL6cxNJtKIKQmvSTfzksNAMYKqjon+6PChUUz9zmOJ4=;
        b=WTlh/ItSs7haofddu0vSTF4AYv7kJ2T13HGo4CjcrJO4KSIxEeWC95FL/SCpnAAfdS
         0vR9yUMA3Ot3f9iO3Rn7L1KYBdw6yexBoQnPWjd9zV0vdzSjbhZXA1xztKAclrWyCOBI
         Du+ieCSnSx1vMJlVR2P05s36JkwRRQVaJPJVa7y8zC5XpKMKuXA6ymwIznhi/2LTMqes
         HhXSwyXF15eHB0RaqRUoXz9o/V/9yvxHLpfYHWDVRENwjMnn9YmKtopV6Wya1d8aOX98
         AQurodFZSbwF4/LJcVf8unyEDwkarACJPLCKeM0BkjhNL7RM+KOh46I6h7pYOWuDdcjC
         MIJg==
X-Gm-Message-State: AOAM530uc2tNrHGVfCOEoCVSM3x3UJSqi9J+DuNzCsxNQQJeL1uKUkXS
        oEucHEQphTcUIT5UChBpRg==
X-Google-Smtp-Source: ABdhPJw+gejICHezMAuNryQdqWA8Zve/kSvWD62nMm2wCCAlpKJgdKHwi2th5zEK21YRRtHo5Tw8jA==
X-Received: by 2002:a4a:e615:: with SMTP id f21mr7883695oot.91.1617296055414;
        Thu, 01 Apr 2021 09:54:15 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h17sm1241240otj.38.2021.04.01.09.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 09:54:13 -0700 (PDT)
Received: (nullmailer pid 597920 invoked by uid 1000);
        Thu, 01 Apr 2021 16:54:12 -0000
Date:   Thu, 1 Apr 2021 11:54:12 -0500
From:   Rob Herring <robh@kernel.org>
To:     Greentime Hu <greentime.hu@sifive.com>
Cc:     paul.walmsley@sifive.com, hes@sifive.com, erik.danie@sifive.com,
        zong.li@sifive.com, bhelgaas@google.com, aou@eecs.berkeley.edu,
        mturquette@baylibre.com, sboyd@kernel.org,
        lorenzo.pieralisi@arm.com, p.zabel@pengutronix.de,
        alex.dewar90@gmail.com, khilman@baylibre.com,
        hayashi.kunihiko@socionext.com, vidyas@nvidia.com,
        jh80.chung@samsung.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        helgaas@kernel.org
Subject: Re: [PATCH v4 4/6] dt-bindings: PCI: Add SiFive FU740 PCIe host
 controller
Message-ID: <20210401165412.GB573380@robh.at.kernel.org>
References: <20210401060054.40788-1-greentime.hu@sifive.com>
 <20210401060054.40788-5-greentime.hu@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401060054.40788-5-greentime.hu@sifive.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 01, 2021 at 02:00:52PM +0800, Greentime Hu wrote:
> Add PCIe host controller DT bindings of SiFive FU740.
> 
> Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
> ---
>  .../bindings/pci/sifive,fu740-pcie.yaml       | 109 ++++++++++++++++++
>  1 file changed, 109 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/sifive,fu740-pcie.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/sifive,fu740-pcie.yaml b/Documentation/devicetree/bindings/pci/sifive,fu740-pcie.yaml
> new file mode 100644
> index 000000000000..ccb58e5f06d4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/sifive,fu740-pcie.yaml
> @@ -0,0 +1,109 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/sifive,fu740-pcie.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: SiFive FU740 PCIe host controller
> +
> +description: |+
> +  SiFive FU740 PCIe host controller is based on the Synopsys DesignWare
> +  PCI core. It shares common features with the PCIe DesignWare core and
> +  inherits common properties defined in
> +  Documentation/devicetree/bindings/pci/designware-pcie.txt.
> +
> +maintainers:
> +  - Paul Walmsley <paul.walmsley@sifive.com>
> +  - Greentime Hu <greentime.hu@sifive.com>
> +
> +allOf:
> +  - $ref: /schemas/pci/pci-bus.yaml#
> +
> +properties:
> +  compatible:
> +    const: sifive,fu740-pcie
> +
> +  reg:
> +    maxItems: 3
> +
> +  reg-names:
> +    items:
> +      - const: dbi
> +      - const: config
> +      - const: mgmt
> +
> +  num-lanes:
> +    const: 8
> +
> +  msi-parent: true
> +
> +  interrupt-names:
> +    items:
> +      - const: msi
> +      - const: inta
> +      - const: intb
> +      - const: intc
> +      - const: intd
> +
> +  resets:
> +    description: A phandle to the PCIe power up reset line.

How many (maxItems)?

> +
> +  pwren-gpios:
> +    description: Should specify the GPIO for controlling the PCI bus device power on.
> +    maxItems: 1

Still need to list 'reset-gpios' here.

> +
> +required:
> +  - dma-coherent
> +  - num-lanes
> +  - interrupts
> +  - interrupt-names
> +  - interrupt-parent
> +  - interrupt-map-mask
> +  - interrupt-map
> +  - clock-names
> +  - clocks
> +  - resets
> +  - pwren-gpios
> +  - reset-gpios
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    bus {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +        #include <dt-bindings/clock/sifive-fu740-prci.h>
> +
> +        pcie@e00000000 {
> +            compatible = "sifive,fu740-pcie";
> +            #address-cells = <3>;
> +            #size-cells = <2>;
> +            #interrupt-cells = <1>;
> +            reg = <0xe 0x00000000 0x0 0x80000000>,
> +                  <0xd 0xf0000000 0x0 0x10000000>,
> +                  <0x0 0x100d0000 0x0 0x1000>;
> +            reg-names = "dbi", "config", "mgmt";
> +            device_type = "pci";
> +            dma-coherent;
> +            bus-range = <0x0 0xff>;
> +            ranges = <0x81000000  0x0 0x60080000  0x0 0x60080000 0x0 0x10000>,      /* I/O */
> +                     <0x82000000  0x0 0x60090000  0x0 0x60090000 0x0 0xff70000>,    /* mem */
> +                     <0x82000000  0x0 0x70000000  0x0 0x70000000 0x0 0x1000000>,    /* mem */
> +                     <0xc3000000 0x20 0x00000000 0x20 0x00000000 0x20 0x00000000>;  /* mem prefetchable */
> +            num-lanes = <0x8>;
> +            interrupts = <56>, <57>, <58>, <59>, <60>, <61>, <62>, <63>, <64>;
> +            interrupt-names = "msi", "inta", "intb", "intc", "intd";
> +            interrupt-parent = <&plic0>;
> +            interrupt-map-mask = <0x0 0x0 0x0 0x7>;
> +            interrupt-map = <0x0 0x0 0x0 0x1 &plic0 57>,
> +                            <0x0 0x0 0x0 0x2 &plic0 58>,
> +                            <0x0 0x0 0x0 0x3 &plic0 59>,
> +                            <0x0 0x0 0x0 0x4 &plic0 60>;
> +            clock-names = "pcie_aux";
> +            clocks = <&prci PRCI_CLK_PCIE_AUX>;
> +            resets = <&prci 4>;
> +            pwren-gpios = <&gpio 5 0>;
> +            reset-gpios = <&gpio 8 0>;
> +        };
> +    };
> -- 
> 2.30.2
> 
