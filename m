Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E002612671D
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2019 17:32:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfLSQc0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Dec 2019 11:32:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:41380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726855AbfLSQc0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 19 Dec 2019 11:32:26 -0500
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2BA324650;
        Thu, 19 Dec 2019 16:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576773145;
        bh=rn47R6IvO6EmAAUhCrgRqhoSznMNBK9nhnALCSAkwoE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TmCUZc8HC4MsZMytQqpP6YcX2OvrwtIdtdZ6YvP+pdbVGfUu12j+4TI5oBr+en0UT
         m/aJbFqmFebwpo9kyvgy5coWrQWisx3CZz+QjTTgSZdYFahKknGcHO/eomevXqiCw4
         mjN5tcZn7GUMZSZ3eeuKMm1iNWfsp2D4VKOEXeJI=
Received: by mail-qt1-f170.google.com with SMTP id w47so5552286qtk.4;
        Thu, 19 Dec 2019 08:32:25 -0800 (PST)
X-Gm-Message-State: APjAAAVCRj5LYzaqIfyBAYUy2XxbdPdTMhHZt2qKOzvarlBf/U6VTAMz
        6wut6gj4UikkayqCwQuzKV3qLsfOjMEdG928/w==
X-Google-Smtp-Source: APXvYqwZYa0h1s/HCI711yjy0PxWMFYhBrYLpz14TQY1Z//PXZAz3O5cSE1pEV1yX1YSasjOZatClg+LA3n1RvqJ8fA=
X-Received: by 2002:ac8:6747:: with SMTP id n7mr7762290qtp.224.1576773144784;
 Thu, 19 Dec 2019 08:32:24 -0800 (PST)
MIME-Version: 1.0
References: <cover.1575860791.git.eswara.kota@linux.intel.com> <a276c1107d40917901a4265d4d8622dee060e4f5.1575860791.git.eswara.kota@linux.intel.com>
In-Reply-To: <a276c1107d40917901a4265d4d8622dee060e4f5.1575860791.git.eswara.kota@linux.intel.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 19 Dec 2019 10:32:13 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJE=7P3z8AzWUfWu1PCV4EVC1PBJ+ZAu3vmAcq5G5D34g@mail.gmail.com>
Message-ID: <CAL_JsqJE=7P3z8AzWUfWu1PCV4EVC1PBJ+ZAu3vmAcq5G5D34g@mail.gmail.com>
Subject: Re: [PATCH v11 1/3] dt-bindings: PCI: intel: Add YAML schemas for the
 PCIe RC controller
To:     Dilip Kota <eswara.kota@linux.intel.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        PCI <linux-pci@vger.kernel.org>, devicetree@vger.kernel.org,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Andrew Murray <andrew.murray@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Dec 8, 2019 at 9:20 PM Dilip Kota <eswara.kota@linux.intel.com> wrote:
>
> Add YAML schemas for PCIe RC controller on Intel Gateway SoCs
> which is Synopsys DesignWare based PCIe core.
>
> Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Reviewed-by: Andrew Murray <andrew.murray@arm.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/pci/intel-gw-pcie.yaml     | 138 +++++++++++++++++++++
>  1 file changed, 138 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/intel-gw-pcie.yaml
>
> diff --git a/Documentation/devicetree/bindings/pci/intel-gw-pcie.yaml b/Documentation/devicetree/bindings/pci/intel-gw-pcie.yaml
> new file mode 100644
> index 000000000000..db605d8a387d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/intel-gw-pcie.yaml
> @@ -0,0 +1,138 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/intel-gw-pcie.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: PCIe RC controller on Intel Gateway SoCs
> +
> +maintainers:
> +  - Dilip Kota <eswara.kota@linux.intel.com>
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: intel,lgm-pcie
> +      - const: snps,dw-pcie
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
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  phys:
> +    maxItems: 1
> +
> +  phy-names:
> +    const: pcie
> +
> +  reset-gpios:
> +    maxItems: 1
> +
> +  linux,pci-domain: true
> +
> +  num-lanes:
> +    maximum: 2
> +    description: Number of lanes to use for this port.
> +
> +  '#interrupt-cells':
> +    const: 1
> +
> +  interrupt-map-mask:
> +    description: Standard PCI IRQ mapping properties.
> +
> +  interrupt-map:
> +    description: Standard PCI IRQ mapping properties.
> +
> +  max-link-speed:
> +    description: Specify PCI Gen for link capability.
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +      - enum: [ 1, 2, 3, 4 ]
> +      - default: 1
> +
> +  bus-range:
> +    description: Range of bus numbers associated with this controller.
> +
> +  reset-assert-ms:
> +    description: |
> +      Delay after asserting reset to the PCIe device.
> +    maximum: 500
> +    default: 100
> +
> +required:
> +  - compatible
> +  - device_type
> +  - "#address-cells"
> +  - "#size-cells"
> +  - reg
> +  - reg-names
> +  - ranges
> +  - resets
> +  - clocks
> +  - phys
> +  - phy-names
> +  - reset-gpios
> +  - '#interrupt-cells'
> +  - interrupt-map
> +  - interrupt-map-mask
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/clock/intel,lgm-clk.h>

I guess this is applied now as the example fails to build in
linux-next as this header is missing.

At this point I'd settle for just 'make dt_binding_check' passing on
linux-next even though it should pass on maintainer trees too.
However, it doesn't appear the clock driver with this header is close
to being merged. The binding was sent on Aug 28 and not to the DT list
so I hadn't seen it. Given that, I'd suggest a follow-up patch to
remove the header dependency here. Just change LGM_GCLK_PCIE10 to the
value.

> +    pcie10: pcie@d0e00000 {
> +      compatible = "intel,lgm-pcie", "snps,dw-pcie";
> +      device_type = "pci";
> +      #address-cells = <3>;
> +      #size-cells = <2>;
> +      reg = <0xd0e00000 0x1000>,
> +            <0xd2000000 0x800000>,
> +            <0xd0a41000 0x1000>;
> +      reg-names = "dbi", "config", "app";
> +      linux,pci-domain = <0>;
> +      max-link-speed = <4>;
> +      bus-range = <0x00 0x08>;
> +      interrupt-parent = <&ioapic1>;
> +      #interrupt-cells = <1>;
> +      interrupt-map-mask = <0 0 0 0x7>;
> +      interrupt-map = <0 0 0 1 &ioapic1 27 1>,
> +                      <0 0 0 2 &ioapic1 28 1>,
> +                      <0 0 0 3 &ioapic1 29 1>,
> +                      <0 0 0 4 &ioapic1 30 1>;
> +      ranges = <0x02000000 0 0xd4000000 0xd4000000 0 0x04000000>;
> +      resets = <&rcu0 0x50 0>;
> +      clocks = <&cgu0 LGM_GCLK_PCIE10>;
> +      phys = <&cb0phy0>;
> +      phy-names = "pcie";
> +      reset-assert-ms = <500>;
> +      reset-gpios = <&gpio0 3 GPIO_ACTIVE_LOW>;
> +      num-lanes = <2>;
> +    };
> --
> 2.11.0
>
