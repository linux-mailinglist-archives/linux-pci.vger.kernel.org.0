Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47BD696102
	for <lists+linux-pci@lfdr.de>; Tue, 20 Aug 2019 15:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730306AbfHTNod (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Aug 2019 09:44:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:38684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730770AbfHTNnF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Aug 2019 09:43:05 -0400
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 813CC22DD6;
        Tue, 20 Aug 2019 13:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566308583;
        bh=uOe278BjeSCVm0Yvei9g6yy3Td/QVwv+YDoMYSyE7WI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lSKbMSq0zejsWFJB1YSbXkWt+wsyx6hcibSOB+QrXjLDEZe3NefjzgvbnvtzXva5i
         r+3h/HqS1Z1FhE29o+ORgaO9bsvYJH0IlyWcY+v6KOmbra+KbIzZHeOf4nZTD7ctNA
         /Ed6ObdmQCBjAU4kWIwbyzEVCPsUUQpDMT81DJMU=
Received: by mail-qk1-f172.google.com with SMTP id w18so4502334qki.0;
        Tue, 20 Aug 2019 06:43:03 -0700 (PDT)
X-Gm-Message-State: APjAAAWPwI11cDuSS5vWVLFLUfrKFeWFZ9zWwQdzEgg40HvCX8lRCwzC
        CeSs0oyYadUAZzZcYsD1yuJ+Sj2qHiqU8EXBBA==
X-Google-Smtp-Source: APXvYqxwnJs7OpFe00kgqK1JKcgVrR8tZM4OnOWTaEasRUoo9hbARCNCIplqORq2OIAVk3yZ6vHkZYPL4FHNsyPWpMQ=
X-Received: by 2002:a37:6944:: with SMTP id e65mr23792510qkc.119.1566308582630;
 Tue, 20 Aug 2019 06:43:02 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1566208109.git.eswara.kota@linux.intel.com> <5e6ee1245ee53a7726103a8de7c11a37ad99fbd6.1566208109.git.eswara.kota@linux.intel.com>
In-Reply-To: <5e6ee1245ee53a7726103a8de7c11a37ad99fbd6.1566208109.git.eswara.kota@linux.intel.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 20 Aug 2019 08:42:51 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+pvKHtw-ARRbNW-xReQ2MVNan8z3tfJbx4taGDCvEr5g@mail.gmail.com>
Message-ID: <CAL_Jsq+pvKHtw-ARRbNW-xReQ2MVNan8z3tfJbx4taGDCvEr5g@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] dt-bindings: PCI: intel: Add YAML schemas for the
 PCIe RC controller
To:     Dilip Kota <eswara.kota@linux.intel.com>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        linux-pci@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 20, 2019 at 4:40 AM Dilip Kota <eswara.kota@linux.intel.com> wrote:
>
> The Intel PCIe RC controller is Synopsys Designware
> based PCIe core. Add YAML schemas for PCIe in RC mode
> present in Intel Universal Gateway soc.

Run 'make dt_binding_check' and fix all the warnings.

>
> Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>
> ---
>  .../devicetree/bindings/pci/intel-pcie.yaml        | 133 +++++++++++++++++++++
>  1 file changed, 133 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/intel-pcie.yaml
>
> diff --git a/Documentation/devicetree/bindings/pci/intel-pcie.yaml b/Documentation/devicetree/bindings/pci/intel-pcie.yaml
> new file mode 100644
> index 000000000000..80caaaba5e2c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/intel-pcie.yaml
> @@ -0,0 +1,133 @@
> +# SPDX-License-Identifier: GPL-2.0

(GPL-2.0-only OR BSD-2-Clause) is preferred for new bindings.

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/intel-pcie.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Intel AXI bus based PCI express root complex
> +
> +maintainers:
> +  - Dilip Kota <eswara.kota@linux.intel.com>
> +
> +properties:
> +  compatible:
> +    const: intel,lgm-pcie
> +
> +  device_type:
> +    const: pci
> +
> +  "#address-cells":
> +    const: 3
> +
> +  "#size-cells":
> +    const: 2
> +
> +  reg:
> +    items:
> +      - description: Controller control and status registers.
> +      - description: PCIe configuration registers.
> +      - description: Controller application registers.
> +
> +  reg-names:
> +    items:
> +      - const: dbi
> +      - const: config
> +      - const: app
> +
> +  ranges:
> +    description: Ranges for the PCI memory and I/O regions.
> +
> +  resets:
> +    maxItems: 1
> +
> +  clocks:
> +    description: PCIe registers interface clock.
> +
> +  phys:
> +    maxItems: 1
> +
> +  phy-names:
> +    const: phy
> +
> +  reset-gpios:
> +    maxItems: 1
> +
> +  num-lanes:
> +    description: Number of lanes to use for this port.
> +
> +  linux,pci-domain:
> +    description: PCI domain ID.
> +
> +  interrupts:
> +    description: PCIe core integrated miscellaneous interrupt.
> +
> +  interrupt-map-mask:
> +    description: Standard PCI IRQ mapping properties.
> +
> +  interrupt-map:
> +    description: Standard PCI IRQ mapping properties.
> +
> +  max-link-speed:
> +    description: Specify PCI Gen for link capability.
> +
> +  bus-range:
> +    description: Range of bus numbers associated with this controller.
> +
> +  intel,rst-interval:

Use 'reset-assert-us'

> +    description: |
> +      Device reset interval in ms. Some devices need an interval upto 500ms.
> +      By default it is 100ms.
> +
> +required:
> +  - compatible
> +  - device_type
> +  - reg
> +  - reg-names
> +  - ranges
> +  - resets
> +  - clocks
> +  - phys
> +  - phy-names
> +  - reset-gpios
> +  - num-lanes
> +  - linux,pci-domain
> +  - interrupts
> +  - interrupt-map
> +  - interrupt-map-mask
> +
> +examples:
> +  - |
> +    pcie10:pcie@d0e00000 {
> +      compatible = "intel,lgm-pcie";
> +      device_type = "pci";
> +      #address-cells = <3>;
> +      #size-cells = <2>;
> +      reg = <
> +            0xd0e00000 0x1000
> +            0xd2000000 0x800000
> +            0xd0a41000 0x1000
> +            >;
> +      reg-names = "dbi", "config", "app";
> +      linux,pci-domain = <0>;
> +      max-link-speed = <4>;
> +      bus-range = <0x00 0x08>;
> +      interrupt-parent = <&ioapic1>;
> +      interrupts = <67 1>;
> +      interrupt-map-mask = <0 0 0 0x7>;
> +      interrupt-map = <0 0 0 1 &ioapic1 27 1>,
> +                      <0 0 0 2 &ioapic1 28 1>,
> +                      <0 0 0 3 &ioapic1 29 1>,
> +                      <0 0 0 4 &ioapic1 30 1>;
> +      ranges = <0x02000000 0 0xd4000000 0xd4000000 0 0x04000000>;
> +      resets = <&rcu0 0x50 0>;
> +      clocks = <&cgu0 LGM_GCLK_PCIE10>;
> +      phys = <&cb0phy0>;
> +      phy-names = "phy";
> +    };
> +
> +    &pcie10 {

Don't show this soc/board split in examples. Just combine to one node.

> +      status = "okay";
> +      intel,rst-interval = <100>;
> +      reset-gpios = <&gpio0 3 GPIO_ACTIVE_LOW>;
> +      num-lanes = <2>;
> +    };
> --
> 2.11.0
>
