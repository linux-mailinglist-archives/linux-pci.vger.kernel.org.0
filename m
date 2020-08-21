Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D097A24E307
	for <lists+linux-pci@lfdr.de>; Sat, 22 Aug 2020 00:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgHUWLg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Aug 2020 18:11:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:41782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726641AbgHUWLf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 21 Aug 2020 18:11:35 -0400
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B61422087D;
        Fri, 21 Aug 2020 22:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598047894;
        bh=fjUhRuQKm8f1fb1XU0Zes6sQDguM9nwNey/Mjg35Qho=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aX8ReITKM/Ta8LYT5WqOhz02VJTGSGvn7Mw8W7e+XUMMiBHEu+OeNJvyK4jVY0VCt
         t6OjIKsIKF7mQtHBI0qaLf9egUKAq+ilN+m34gGKwGuIcfVEyw95MKpCP8mkryPOPG
         +TydynQFsLt1TVnV3Ccq2fAClSMNql6z6T5vvzro=
Received: by mail-oo1-f42.google.com with SMTP id x6so672494ooe.8;
        Fri, 21 Aug 2020 15:11:34 -0700 (PDT)
X-Gm-Message-State: AOAM530JTZVYpnhX4UVs10IrBm4iP2kne9cCAoNTuvjtJped0p8Z94B5
        ++hEIT0ZGdGPniQNSxL425PDmsIWVmMwp9kGVA==
X-Google-Smtp-Source: ABdhPJz4dkPtYZT5tRo0MDTYMZbIAn6jfWvcC3zGyEzPL69zfiWh34FaMbJgoP16he88SIHHwmJAUgsYOZo7pRiG0TM=
X-Received: by 2002:a4a:a60a:: with SMTP id e10mr3730622oom.25.1598047893992;
 Fri, 21 Aug 2020 15:11:33 -0700 (PDT)
MIME-Version: 1.0
References: <1598003509-27896-1-git-send-email-wuht06@gmail.com> <1598003509-27896-2-git-send-email-wuht06@gmail.com>
In-Reply-To: <1598003509-27896-2-git-send-email-wuht06@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 21 Aug 2020 16:11:22 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLtGF57Q3FEjFWhDkdwSwp6S4SERAG9AwuB-eEb=xtMKw@mail.gmail.com>
Message-ID: <CAL_JsqLtGF57Q3FEjFWhDkdwSwp6S4SERAG9AwuB-eEb=xtMKw@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: PCI: sprd: Document Unisoc PCIe RC host controller
To:     Hongtao Wu <wuht06@gmail.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        PCI <linux-pci@vger.kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Billows Wu <billows.wu@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 21, 2020 at 3:52 AM Hongtao Wu <wuht06@gmail.com> wrote:
>
> From: Billows Wu <billows.wu@unisoc.com>
>
> This series adds PCIe bindings for Uisoc SoCs.

typo

> This controller is based on DesignWare PCIe IP.
>
> Signed-off-by: Billows Wu <billows.wu@unisoc.com>
> ---
>  .../devicetree/bindings/pci/sprd-pcie.yaml         | 88 ++++++++++++++++++++++
>  1 file changed, 88 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/sprd-pcie.yaml
>
> diff --git a/Documentation/devicetree/bindings/pci/sprd-pcie.yaml b/Documentation/devicetree/bindings/pci/sprd-pcie.yaml
> new file mode 100644
> index 0000000..6eab4b8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/sprd-pcie.yaml
> @@ -0,0 +1,88 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/sprd-pcie.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: SoC PCIe Host Controller Device Tree Bindings
> +
> +maintainers:
> +  - Billows Wu <billows.wu@unisoc.com>
> +
> +allOf:
> +  - $ref: /schemas/pci/pci-bus.yaml#
> +  - $ref: "sprd-pcie.yaml#"

Drop this. You don't need to include yourself.

> +
> +properties:
> +  compatible:
> +    items:
> +      - const: sprd,pcie
> +      - const: sprd,pcie-ep
> +
> +  reg:
> +    minItems: 2
> +    maxItems: 3
> +    items:
> +      - description: Controller control and status registers.
> +      - description: PCIe shadow registers.
> +      - description: PCIe configuration registers.
> +
> +  reg-names:
> +    items:
> +      - const: dbi
> +      - const: dbi2
> +      - const: cfg

'config' is the standard name.

> +
> +  ranges:
> +    maxItems: 2
> +
> +  num-lanes:
> +    maxItems: 1

maxItems is for arrays and this is not an array. How many lanes are valid?

enum: [ 1, 2, 27?, ... ]


> +    description: Number of lanes to use for this port.
> +
> +  num-ib-windows:
> +    maxItems: 1

Not an array.

> +    description: Number of inbound windows to use for this port.
> +
> +  num-ob-windows:
> +    maxItems: 1

Not an array.

> +    description: Number of outbound windows to use for this port.
> +
> +  bus-range:
> +    description: Range of bus numbers associated with this controller.

Drop if you don't have constraints.

> +
> +  interrupts:
> +    maxItems: 1
> +
> +  interrupt-names:
> +    maxItems: 1

Need to define the name, though you don't really need this with only 1.

> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - num-lanes
> +  - ranges
> +  - bus-range
> +  - interrupts
> +  - interrupt-names
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    pcie0@2b100000 {
> +        compatible = "sprd,pcie", "snps,dw-pcie";

Didn't document "snps,dw-pcie". You'll need a custom 'select' to avoid
selecting all instances of "snps,dw-pcie".

> +        reg = <0x0 0x2b100000 0x0 0x2000>,
> +              <0x2 0x00000000 0x0 0x2000>;
> +        reg-names = "dbi", "config";
> +        #address-cells = <3>;
> +        #size-cells = <2>;
> +        device_type = "pci";
> +        ranges = <0x01000000 0x0 0x00000000 0x2 0x00002000 0x0 0x00010000
> +                  0x03000000 0x0 0x10000000 0x2 0x10000000 0x1 0xefffffff>;
> +        bus-range = <0  15>;
> +        num-lanes = <1>;
> +        num-viewport = <8>;
> +        interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>;
> +        interrupt-names = "msi";
> +    };
> --
> 2.7.4
>
