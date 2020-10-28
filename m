Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 691E329DA46
	for <lists+linux-pci@lfdr.de>; Thu, 29 Oct 2020 00:18:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387602AbgJ1XSo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Oct 2020 19:18:44 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:34364 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728362AbgJ1XSn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Oct 2020 19:18:43 -0400
Received: by mail-ua1-f66.google.com with SMTP id x11so216531uav.1;
        Wed, 28 Oct 2020 16:18:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=E8aK3zfWur9jk28M6chy5APBvWt4imEJ55/EsVWjxPg=;
        b=qXLBLRbi344foPy2ySiSVyudmAR5GYlp0LR4KmbVJRGzUTBOie2hpH/JAnUdvg3WDl
         kuxmbTNRbnv4LiPE7cU1mJFMFzMZMfSutuV0z+Ps9mnkaz9OOdMuSsSMZr7zq5F/RI1J
         APSGXwDlD+8gNdOSgHM7In1TQ05R4gvOkoBayHKBD+CUbwk7E/AJtPjyyMhvTWNM1e2L
         DGU41ski70ODCFNTYqEHueHDVuxLFBAjGojlJlL8aEAZviMCba0W+yAtFvBd/DCdUMfw
         RJuNx4wILWSMIXIQu7hnhjBr8wvsCcIv8XLlZHXO+UgepXvGPYQ1lygP60Dcn0C+SR59
         LcoA==
X-Gm-Message-State: AOAM533m3oFIS0IlBI7bYdmnybElDchd8hjtj9dqT8ROuDnyGjHyB432
        2b4aF92EqL2jZ8i7Bert5qmKh7eJJw==
X-Google-Smtp-Source: ABdhPJwJgBDeYYeiE9Q91o3SzmsnBqNzVegZCI2fuha9DmO2xtCh9eQS2ICWSykd5H4yZ1UWmxziHg==
X-Received: by 2002:a9d:2c29:: with SMTP id f38mr3357464otb.245.1603896140778;
        Wed, 28 Oct 2020 07:42:20 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n18sm2061385otk.33.2020.10.28.07.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 07:42:20 -0700 (PDT)
Received: (nullmailer pid 3991748 invoked by uid 1000);
        Wed, 28 Oct 2020 14:42:19 -0000
Date:   Wed, 28 Oct 2020 09:42:19 -0500
From:   Rob Herring <robh@kernel.org>
To:     Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
Cc:     bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, mgross@linux.intel.com,
        lakshmi.bai.raja.subramanian@intel.com
Subject: Re: [PATCH 1/2] dt-bindings: PCI: Add Intel Keem Bay PCIe controller
Message-ID: <20201028144219.GA3966314@bogus>
References: <20201027060011.25893-1-wan.ahmad.zainie.wan.mohamad@intel.com>
 <20201027060011.25893-2-wan.ahmad.zainie.wan.mohamad@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027060011.25893-2-wan.ahmad.zainie.wan.mohamad@intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 27, 2020 at 02:00:10PM +0800, Wan Ahmad Zainie wrote:
> Document DT bindings for PCIe controller found on Intel Keem Bay SoC.
> 
> Signed-off-by: Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
> ---
>  .../bindings/pci/intel,keembay-pcie-ep.yaml   |  86 +++++++++++++
>  .../bindings/pci/intel,keembay-pcie.yaml      | 120 ++++++++++++++++++
>  2 files changed, 206 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/intel,keembay-pcie-ep.yaml
>  create mode 100644 Documentation/devicetree/bindings/pci/intel,keembay-pcie.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/intel,keembay-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/intel,keembay-pcie-ep.yaml
> new file mode 100644
> index 000000000000..11962c205744
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/intel,keembay-pcie-ep.yaml
> @@ -0,0 +1,86 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/pci/intel,keembay-pcie-ep.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Intel Keem Bay PCIe EP controller
> +
> +maintainers:
> +  - Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
> +
> +properties:
> +  compatible:
> +      const: intel,keembay-pcie-ep
> +
> +  reg:
> +    items:
> +      - description: DesignWare PCIe registers
> +      - description: PCIe configuration space
> +      - description: Keem Bay specific registers
> +
> +  reg-names:
> +    items:
> +      - const: dbi
> +      - const: addr_space
> +      - const: apb
> +
> +  interrupts:
> +    items:
> +      - description: PCIe interrupt
> +      - description: PCIe event interrupt
> +      - description: PCIe error interrupt
> +      - description: PCIe memory access interrupt
> +
> +  interrupt-names:
> +    items:
> +      - const: intr
> +      - const: ev_intr
> +      - const: err_intr
> +      - const: mem_access_intr

'_intr' is redundant. Drop it. You'll need a better name for the first 
one though.

> +
> +  num-ib-windows:
> +    description: Number of inbound address translation windows
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  num-ob-windows:
> +    description: Number of outbound address translation windows
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  num-lanes:
> +    description: Number of lanes to use.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [ 1, 2, 4, 8 ]
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - interrupts
> +  - interrupt-names
> +  - num-ib-windows
> +  - num-ob-windows
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +  - |
> +    pcie-ep@37000000 {
> +          compatible = "intel,keembay-pcie-ep";
> +          reg = <0x37000000 0x00800000>,
> +                <0x36000000 0x01000000>,
> +                <0x37800000 0x00000200>;
> +          reg-names = "dbi", "addr_space", "apb";
> +          interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>,
> +                       <GIC_SPI 108 IRQ_TYPE_EDGE_RISING>,
> +                       <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
> +                       <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
> +          interrupt-names = "intr", "ev_intr", "err_intr",
> +                       "mem_access_intr";
> +          num-ib-windows = <4>;
> +          num-ob-windows = <4>;
> +          num-lanes = <2>;
> +    };
> diff --git a/Documentation/devicetree/bindings/pci/intel,keembay-pcie.yaml b/Documentation/devicetree/bindings/pci/intel,keembay-pcie.yaml
> new file mode 100644
> index 000000000000..49e5d3d35bd4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/intel,keembay-pcie.yaml
> @@ -0,0 +1,120 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/pci/intel,keembay-pcie.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Intel Keem Bay PCIe RC controller
> +
> +maintainers:
> +  - Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
> +
> +allOf:
> +  - $ref: /schemas/pci/pci-bus.yaml#
> +
> +properties:
> +  compatible:
> +      const: intel,keembay-pcie

> +
> +  device_type:
> +    const: pci
> +
> +  "#address-cells":
> +    const: 3
> +
> +  "#size-cells":
> +    const: 2

Can drop these 3 as pci-bus.yaml defines them.

> +
> +  ranges:
> +    maxItems: 1
> +
> +  reset-gpios:
> +    maxItems: 1
> +
> +  reg:
> +    items:
> +      - description: DesignWare PCIe registers
> +      - description: PCIe configuration space
> +      - description: Keem Bay specific registers
> +
> +  reg-names:
> +    items:
> +      - const: dbi
> +      - const: config
> +      - const: apb
> +
> +  clocks:
> +    items:
> +      - description: bus clock
> +      - description: auxiliary clock

The EP doesn't have clocks? You should have roughly the same resources 
for RC and EP modes.

> +
> +  clock-names:
> +    items:
> +      - const: master
> +      - const: aux
> +
> +  interrupts:
> +    items:
> +      - description: PCIe interrupt
> +      - description: PCIe event interrupt
> +      - description: PCIe error interrupt
> +
> +  interrupt-names:
> +    items:
> +      - const: intr
> +      - const: ev_intr
> +      - const: err_intr
> +
> +  num-lanes:
> +    description: Number of lanes to use.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [ 1, 2, 4, 8 ]
> +
> +  num-viewport:
> +    description: Number of view ports configured in hardware.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    default: 2

Pretty sure it's not 2 if num-ib-windows and num-ob-windows are 4.

> +
> +required:
> +  - compatible

> +  - device_type
> +  - "#address-cells"
> +  - "#size-cells"

Can drop these too.

> +  - reg
> +  - reg-names
> +  - ranges
> +  - clocks
> +  - interrupts
> +  - interrupt-names
> +  - reset-gpios
> +
> +additionalProperties: false

Use 'unevaluatedProperties: false' instead.

> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/gpio/gpio.h>
> +    #define KEEM_BAY_A53_PCIE
> +    #define KEEM_BAY_A53_AUX_PCIE
> +    pcie@37000000 {
> +          compatible = "intel,keembay-pcie";
> +          reg = <0x37000000 0x00800000>,
> +                <0x36e00000 0x00200000>,
> +                <0x37800000 0x00000200>;
> +          reg-names = "dbi", "config", "apb";
> +          #address-cells = <3>;
> +          #size-cells = <2>;
> +          device_type = "pci";
> +          ranges = <0x02000000 0 0x36000000 0x36000000 0 0x00e00000>;
> +          interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>,
> +                       <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>,
> +                       <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>;
> +          interrupt-names = "intr", "ev_intr", "err_intr";
> +          clocks = <&scmi_clk KEEM_BAY_A53_PCIE>,
> +                   <&scmi_clk KEEM_BAY_A53_AUX_PCIE>;
> +          clock-names = "master", "aux";
> +          reset-gpios = <&pca2 9 GPIO_ACTIVE_LOW>;
> +          num-viewport = <4>;
> +          num-lanes = <2>;
> +    };
> -- 
> 2.17.1
> 
