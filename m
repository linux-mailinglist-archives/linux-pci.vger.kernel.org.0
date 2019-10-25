Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF850E51A5
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2019 18:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502677AbfJYQx4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Oct 2019 12:53:56 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:45018 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502610AbfJYQxz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Oct 2019 12:53:55 -0400
Received: by mail-oi1-f196.google.com with SMTP id s71so2033111oih.11;
        Fri, 25 Oct 2019 09:53:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=icjpLxHFOmLwGX3PIdb6QE5jh9DXyIm3EA+j6DEnq+s=;
        b=Z01QM47ZO3lVzwL+cr6zBorBCvWXLaen+AjfPE7y1tp42V+A689sPAU7mWK5jKQJp/
         1csyHEgXJ4uuNxvWA4hSiGVZ6fYP2yWj8RUjD5HO/hjtg1mtZMjituA865Rsg4Q69sVX
         sAQrGLqeD4nIYYKcsxQGt1dXhUG7IVTPeKzzOdF6aXlrffCa2jnBjKjyWom+6AM1bRj1
         AfhHBupReE64vDv995pow0ad1uEv+l0c2YGnuR0m5QkVhkbXBWVryYmI6PHSOXFADtya
         1iahEP6/uaWnIdedzAzX5tBTHcOBU8G7iy0P6VfhwHURVLtD1wyU6MIdzfe2ufmqfRYE
         2nOA==
X-Gm-Message-State: APjAAAXzIFOmCb67vjnpXcsNyr8AdjkXVzv0js19XohmvKP8yuwVtOfO
        mwkd/QdS7o9M17hD0Uw84A==
X-Google-Smtp-Source: APXvYqwlusvuRVtlD/XuJYr4K4iyWb6z0on18g6/SENicyigu+soJlyojXsozYn5fYjb1Tf38IS1tA==
X-Received: by 2002:aca:210e:: with SMTP id 14mr3904071oiz.62.1572022434687;
        Fri, 25 Oct 2019 09:53:54 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w26sm876453otm.52.2019.10.25.09.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 09:53:53 -0700 (PDT)
Date:   Fri, 25 Oct 2019 11:53:52 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dilip Kota <eswara.kota@linux.intel.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lorenzo.pieralisi@arm.com, andrew.murray@arm.com,
        martin.blumenstingl@googlemail.com, linux-pci@vger.kernel.org,
        hch@infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com
Subject: Re: [PATCH v4 1/3] dt-bindings: PCI: intel: Add YAML schemas for the
 PCIe RC controller
Message-ID: <20191025165352.GA30602@bogus>
References: <cover.1571638827.git.eswara.kota@linux.intel.com>
 <710257e49c4b3d07fa98b3e5a829b807f74b54d7.1571638827.git.eswara.kota@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <710257e49c4b3d07fa98b3e5a829b807f74b54d7.1571638827.git.eswara.kota@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 21, 2019 at 02:39:18PM +0800, Dilip Kota wrote:
> Add YAML shcemas for PCIe RC controller on Intel Gateway SoCs
> which is Synopsys DesignWare based PCIe core.
> 
> changes on v4:
> 	Add "snps,dw-pcie" compatible.
> 	Rename phy-names property value to pcie.
> 	And maximum and minimum values to num-lanes.
> 	Add ref for reset-assert-ms entry and update the
> 	 description for easy understanding.
> 	Remove pcie core interrupt entry.
> 
> changes on v3:
>         Add the appropriate License-Identifier
>         Rename intel,rst-interval to 'reset-assert-us'
>         Add additionalProperties: false
>         Rename phy-names to 'pciephy'
>         Remove the dtsi node split of SoC and board in the example
>         Add #interrupt-cells = <1>; or else interrupt parsing will fail
>         Name yaml file with compatible name
> 
> Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>
> ---
>  .../devicetree/bindings/pci/intel-gw-pcie.yaml     | 135 +++++++++++++++++++++
>  1 file changed, 135 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/intel-gw-pcie.yaml

Fails to validate:

Error: Documentation/devicetree/bindings/pci/intel-gw-pcie.example.dts:38.27-28 syntax error
FATAL ERROR: Unable to parse input tree
scripts/Makefile.lib:321: recipe for target 'Documentation/devicetree/bindings/pci/intel-gw-pcie.example.dt.yaml' failed

Please run 'make -k dt_binding_check' (-k because there are some 
unrelated failures).

> 
> diff --git a/Documentation/devicetree/bindings/pci/intel-gw-pcie.yaml b/Documentation/devicetree/bindings/pci/intel-gw-pcie.yaml
> new file mode 100644
> index 000000000000..49dd87ec1e3d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/intel-gw-pcie.yaml
> @@ -0,0 +1,135 @@
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
> +    description: Ranges for the PCI memory and I/O regions.

How many entries do you expect? Add a 'maxItems' to define.

> +
> +  resets:
> +    maxItems: 1
> +
> +  clocks:
> +    description: PCIe registers interface clock.

How many clocks?

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
> +  num-lanes:
> +    minimum: 1
> +    maximum: 2
> +    description: Number of lanes to use for this port.
> +
> +  linux,pci-domain:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: PCI domain ID.

Just a value of 'true' is fine here.

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

Allowed values? Default?

> +
> +  bus-range:
> +    description: Range of bus numbers associated with this controller.
> +
> +  reset-assert-ms:
> +    $ref: /schemas/types.yaml#/definitions/uint32

Don't need a type for standard units.

> +    description: |
> +      Delay after asserting reset to the PCIe device.
> +      Some devices need an interval upto 500ms. By default it is 100ms.

Express as a schema:

maximum: 500
default: 100

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

Shouldn't be required. It should have a default.

> +  - linux,pci-domain

Is this really required? AIUI, domains are optional and only used if 
you have more than one host.

> +  - interrupt-map
> +  - interrupt-map-mask
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    pcie10:pcie@d0e00000 {

space         ^

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

You need to include any defines you use. That's why the example fails to 
build.

> +      phys = <&cb0phy0>;
> +      phy-names = "pcie";
> +      status = "okay";

Don't show status in examples.

> +      reset-assert-ms = <500>;
> +      reset-gpios = <&gpio0 3 GPIO_ACTIVE_LOW>;
> +      num-lanes = <2>;
> +    };
> -- 
> 2.11.0
> 
