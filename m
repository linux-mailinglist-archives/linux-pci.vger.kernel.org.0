Return-Path: <linux-pci+bounces-16893-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4969D9CF193
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 17:36:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF9C81F252E5
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 16:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59AAD1D5165;
	Fri, 15 Nov 2024 16:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H99tUUBj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2A21D47A0;
	Fri, 15 Nov 2024 16:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731688566; cv=none; b=ra0hMr9O7DOoH2mBfzJtZSW/xjd43U9gMD+wOsueovBPfmZKeTYue4LSP2McG16K2Inm78tqgWrtQNgh+RkJyTSsb+qiEOHzk+wOLJuZaOQzMxWdXXxIlZ88zXCBZk2L3lyqvjVb8AVUXP1FGV5xImxNZ2Z/4cWzWadZlTF66QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731688566; c=relaxed/simple;
	bh=6yQrzL+pY0s5bWYhKAenvAd4K3vkSdTM9mFizd+1r8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YzBUFPLUuYzGgkOk7bUp/7lu42Y8IfKJA7EEGuU0Pykb35tohhsey+P8GV9z7vNvnH34Hm8iICqCX/cLS1zCXhzRlzqXeCikWhzDGNGQAZU+7RjIXl1aF2qfv6dP4JXFvcDiJSpxVXhiZoxV40toyWuhC1/WviB4OM9qusq+yYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H99tUUBj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E232C4CED5;
	Fri, 15 Nov 2024 16:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731688565;
	bh=6yQrzL+pY0s5bWYhKAenvAd4K3vkSdTM9mFizd+1r8E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H99tUUBjROYIibs7vXroxAi3KXnmtRNRe1yk//et3sKkQZfVPW2DCaDJlHgMsrnAK
	 Y6iuBeAZFRfUzJZcbT2178fMPypgrYxiE/oWrhYWdNN0qbdZA+UsYJjonG5XV9hTnU
	 ELMQnXVNxjU30qSBtvn1KcZyVyrzBjvk0LH6C2LXAMDqTMcdUj5/183weCY3T7jw8L
	 RFds4A3qvgQD2FmsqcARtCjpAig8ANEpgfBcn7kfTUVGl7nS7Id4DXdqaAa7R84K+H
	 yKEcNGIULnpqYwTkfwqboyI1zpC1GvA7Q5bkfAEy+QsJ/aToJ/Zuc4jZxaRvsIdG7E
	 pNnt/nYpycq0Q==
Date: Fri, 15 Nov 2024 10:36:03 -0600
From: Rob Herring <robh@kernel.org>
To: Christian Bruel <christian.bruel@foss.st.com>
Cc: lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org,
	bhelgaas@google.com, krzk+dt@kernel.org, conor+dt@kernel.org,
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	p.zabel@pengutronix.de, cassel@kernel.org,
	quic_schintav@quicinc.com, fabrice.gasnier@foss.st.com,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] dt-bindings: PCI: Add STM32MP25 PCIe root complex
 bindings
Message-ID: <20241115163603.GA3188739-robh@kernel.org>
References: <20241112161925.999196-1-christian.bruel@foss.st.com>
 <20241112161925.999196-2-christian.bruel@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112161925.999196-2-christian.bruel@foss.st.com>

On Tue, Nov 12, 2024 at 05:19:21PM +0100, Christian Bruel wrote:
> Document the bindings for STM32MP25 PCIe Controller configured in
> root complex mode.
> Supports 4 legacy interrupts and MSI interrupts from the ARM
> GICv2m controller.
> 
> Allow tuning to change payload (default 128B) thanks to the
> st,max-payload-size entry.
> Can also limit the Maximum Read Request Size on downstream devices to the
> minimum possible value between 128B and 256B.
> 
> STM32 PCIE may be in a power domain which is the case for the STM32MP25
> based boards.
> Supports wake# from wake-gpios
> 
> Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
> ---
>  .../bindings/pci/st,stm32-pcie-host.yaml      | 149 ++++++++++++++++++
>  1 file changed, 149 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/st,stm32-pcie-host.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/st,stm32-pcie-host.yaml b/Documentation/devicetree/bindings/pci/st,stm32-pcie-host.yaml
> new file mode 100644
> index 000000000000..d7d360b63a08
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/st,stm32-pcie-host.yaml
> @@ -0,0 +1,149 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/st,stm32-pcie-host.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: STM32MP25 PCIe root complex driver
> +
> +maintainers:
> +  - Christian Bruel <christian.bruel@foss.st.com>
> +
> +description:
> +  PCIe root complex controller based on the Synopsys DesignWare PCIe core.
> +
> +select:
> +  properties:
> +    compatible:
> +      const: st,stm32mp25-pcie-rc
> +  required:
> +    - compatible
> +
> +allOf:
> +  - $ref: /schemas/pci/pci-host-bridge.yaml#
> +  - $ref: /schemas/pci/snps,dw-pcie-common.yaml#

snps,dw-pcie.yaml instead of these 2.

> +
> +properties:
> +  compatible:
> +    const: st,stm32mp25-pcie-rc
> +
> +  reg:
> +    items:
> +      - description: Data Bus Interface (DBI) registers.
> +      - description: PCIe configuration registers.
> +
> +  reg-names:
> +    items:
> +      - const: dbi
> +      - const: config
> +
> +  resets:
> +    maxItems: 1
> +
> +  reset-names:
> +    const: core

-names with a single entry is kind of pointless.

> +
> +  clocks:
> +    maxItems: 1
> +    description: PCIe system clock
> +
> +  clock-names:
> +    const: core
> +
> +  phys:
> +    maxItems: 1
> +
> +  phy-names:
> +    const: pcie-phy
> +
> +  num-lanes:
> +    const: 1
> +
> +  msi-parent:
> +    maxItems: 1

Just 'msi-parent: true'. It's already only ever 1 entry.

> +
> +  reset-gpios:
> +    description: GPIO controlled connection to PERST# signal
> +    maxItems: 1
> +
> +  wake-gpios:
> +    description: GPIO controlled connection to WAKE# input signal
> +    maxItems: 1
> +

> +  st,limit-mrrs:
> +    description: If present limit downstream MRRS to 256B
> +    type: boolean
> +
> +  st,max-payload-size:
> +    description: Maximum Payload size to use
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [128, 256]
> +    default: 128

IIRC, other hosts have similar restrictions, so you should be able to do 
the same and imply it from the compatible. Though I'm open to a common 
property as Bjorn suggested.

> +
> +  wakeup-source: true
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  access-controllers:
> +    maxItems: 1
> +
> +if:
> +  required:
> +    - wakeup-source
> +then:
> +  required:
> +    - wake-gpios

This can be just:

dependentRequired:
  wakeup-source: [ wake-gpios ]

(dependentRequired supercedes dependencies)

> +
> +required:
> +  - interrupt-map
> +  - interrupt-map-mask
> +  - ranges
> +  - resets
> +  - reset-names
> +  - clocks
> +  - clock-names
> +  - phys
> +  - phy-names
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/st,stm32mp25-rcc.h>
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/phy/phy.h>
> +    #include <dt-bindings/reset/st,stm32mp25-rcc.h>
> +
> +    pcie@48400000 {
> +        compatible = "st,stm32mp25-pcie-rc";
> +        device_type = "pci";
> +        num-lanes = <1>;
> +        reg = <0x48400000 0x400000>,
> +              <0x10000000 0x10000>;
> +        reg-names = "dbi", "config";
> +        #interrupt-cells = <1>;
> +        interrupt-map-mask = <0 0 0 7>;
> +        interrupt-map = <0 0 0 1 &intc 0 0 GIC_SPI 264 IRQ_TYPE_LEVEL_HIGH>,
> +                        <0 0 0 2 &intc 0 0 GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>,
> +                        <0 0 0 3 &intc 0 0 GIC_SPI 266 IRQ_TYPE_LEVEL_HIGH>,
> +                        <0 0 0 4 &intc 0 0 GIC_SPI 267 IRQ_TYPE_LEVEL_HIGH>;
> +        #address-cells = <3>;
> +        #size-cells = <2>;
> +        ranges = <0x01000000 0 0x10010000 0x10010000 0 0x10000>,
> +                 <0x02000000 0 0x10020000 0x10020000 0 0x7fe0000>,
> +                 <0x42000000 0 0x18000000 0x18000000 0 0x8000000>;
> +        bus-range = <0x00 0xff>;

Don't need this unless it's restricted to less than bus 0-255.

> +        clocks = <&rcc CK_BUS_PCIE>;
> +        clock-names = "core";
> +        phys = <&combophy PHY_TYPE_PCIE>;
> +        phy-names = "pcie-phy";
> +        resets = <&rcc PCIE_R>;
> +        reset-names = "core";
> +        msi-parent = <&v2m0>;
> +        wakeup-source;
> +        wake-gpios = <&gpioh 5 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>;
> +        access-controllers = <&rifsc 76>;
> +        power-domains = <&CLUSTER_PD>;
> +    };
> -- 
> 2.34.1
> 

