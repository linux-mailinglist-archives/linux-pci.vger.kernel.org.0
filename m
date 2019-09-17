Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FBDFB5578
	for <lists+linux-pci@lfdr.de>; Tue, 17 Sep 2019 20:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbfIQSkP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Sep 2019 14:40:15 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44821 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbfIQSkP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Sep 2019 14:40:15 -0400
Received: by mail-ot1-f68.google.com with SMTP id 21so3956024otj.11;
        Tue, 17 Sep 2019 11:40:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9e1bRgasfMuK+lvMJgCeJmJtm+H2C20MdWrSVsoNzwA=;
        b=faKswym0pHzaeG+NXD+1xw8J9iy55GxGr0TezWh71NBQKhHrDsxkff62ssHvyUEAHN
         yB1vUnzD1KgaTXsAO8e72Uc/Wt6eVlNcfPPr40I2PmzYGiDWZPRCGbRWV6zGs/bznj6w
         /ewSZ4EvTOwnvsOyCSb/CwwsrC0Urw59xs78Rwb2fAVnr7k5KWpQze2aag/fAJ6hZWvN
         t+Trwg4grHsClE30OlnnHugDyorcwy/swRf5T+fVBvf7aotlHccj7iOJsypQ2B4tmgFA
         2LCrzxg7L0tLQQ/Z8Ey0UzfwR7csux9aQYZYlA6kVzUs51samjHTv/UF8ga0irKLmXVP
         z2pQ==
X-Gm-Message-State: APjAAAWALsm6CtsAq0nFJUknSjfQ97qjB1/f/VQAnktr1bfTDFcebCcF
        b6r2jZ/eE+P400watw/V0A==
X-Google-Smtp-Source: APXvYqyfSNyh+pWlHLGRJq+OHRFzqu72YnkpL7luxlggoiwAmGC6zq4Dmehdg7SGaUNNA79WCQx3Qw==
X-Received: by 2002:a9d:4b8d:: with SMTP id k13mr215831otf.209.1568745614469;
        Tue, 17 Sep 2019 11:40:14 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i2sm1096710otf.19.2019.09.17.11.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 11:40:13 -0700 (PDT)
Date:   Tue, 17 Sep 2019 13:40:13 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dilip Kota <eswara.kota@linux.intel.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lorenzo.pieralisi@arm.com, martin.blumenstingl@googlemail.com,
        linux-pci@vger.kernel.org, hch@infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@intel.com, cheol.yong.kim@intel.com,
        chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com
Subject: Re: [PATCH v3 1/2] dt-bindings: PCI: intel: Add YAML schemas for the
 PCIe RC controller
Message-ID: <20190917184013.GB24684@bogus>
References: <cover.1567585181.git.eswara.kota@linux.intel.com>
 <fe9549470bc06ea0d0dfc80f46a579baa49b911a.1567585181.git.eswara.kota@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe9549470bc06ea0d0dfc80f46a579baa49b911a.1567585181.git.eswara.kota@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 04, 2019 at 06:10:30PM +0800, Dilip Kota wrote:
> The Intel PCIe RC controller is Synopsys Designware
> based PCIe core. Add YAML schemas for PCIe in RC mode
> present in Intel Universal Gateway soc.
> 
> Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>
> ---
> changes on v3:
> 	Add the appropriate License-Identifier
> 	Rename intel,rst-interval to 'reset-assert-us'
> 	Add additionalProperties: false
> 	Rename phy-names to 'pciephy'
> 	Remove the dtsi node split of SoC and board in the example
> 	Add #interrupt-cells = <1>; or else interrupt parsing will fail
> 	Name yaml file with compatible name
> 
>  .../devicetree/bindings/pci/intel,lgm-pcie.yaml    | 137 +++++++++++++++++++++
>  1 file changed, 137 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/intel,lgm-pcie.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/intel,lgm-pcie.yaml b/Documentation/devicetree/bindings/pci/intel,lgm-pcie.yaml
> new file mode 100644
> index 000000000000..5e5cc7fd66cd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/intel,lgm-pcie.yaml
> @@ -0,0 +1,137 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
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

These all belong in a common schema.

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

And this.

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
> +    const: pciephy
> +
> +  reset-gpios:
> +    maxItems: 1
> +

> +  num-lanes:
> +    description: Number of lanes to use for this port.
> +
> +  linux,pci-domain:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: PCI domain ID.

These 2 also should be common.

> +
> +  interrupts:
> +    description: PCIe core integrated miscellaneous interrupt.

How many? No need for description if there's only 1.

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
> +
> +  bus-range:
> +    description: Range of bus numbers associated with this controller.

All common.

> +
> +  reset-assert-ms:
> +    description: |
> +      Device reset interval in ms.
> +      Some devices need an interval upto 500ms. By default it is 100ms.

This is a property of a device, so it belongs in a device node. How 
would you deal with this without DT?

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
> +additionalProperties: false
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
> +      phy-names = "pciephy";
> +      status = "okay";
> +      reset-assert-ms = <500>;
> +      reset-gpios = <&gpio0 3 GPIO_ACTIVE_LOW>;
> +      num-lanes = <2>;
> +    };
> -- 
> 2.11.0
> 
