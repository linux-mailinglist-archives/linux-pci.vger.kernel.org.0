Return-Path: <linux-pci+bounces-20306-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D43FA1ABFD
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jan 2025 22:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 004843ADD6F
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jan 2025 21:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66BF71CBE94;
	Thu, 23 Jan 2025 21:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i0Gl7ZvI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3744B16EC19;
	Thu, 23 Jan 2025 21:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737668300; cv=none; b=WAWetgBCxO39z08Bj98n6WJLAsMfk6HDqY4uu9NMxXqk31qnPHYb4fdf107BT4w3nh4qyEFkstm+pQN+hWil6mg6zou8D8HZjiMU9dSIpEBjly7Ppro7EHc9vm7KejLBARBjBRUI5rbCfGjE5sXDXrhwFkPDMIdUEjJyNlul/bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737668300; c=relaxed/simple;
	bh=kIg09Min6QwFaovmaca18U9kozBuMZ1yuBDBVGZHNLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I34qNNqjq1AxcsoEqOjUqtO2+IZjH3V4XFvPBhA/byMcsjkec+lZo0MVPFUgIKey1esx+ra223by+QpVS6KXyZ9V4jJPeaNQd0hIf1dGjYQ5KoHh00n5aSH7pT08PcHE8kQ+P/CpiCyx7ZSDioE2k3Yj/Nrcs35IsX28JKpzQo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i0Gl7ZvI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62AEAC4CED3;
	Thu, 23 Jan 2025 21:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737668299;
	bh=kIg09Min6QwFaovmaca18U9kozBuMZ1yuBDBVGZHNLw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i0Gl7ZvIuWU4RspKumbfgiP3PSD4xH0Ac1OIpaIVQ7wbHfcXEC3xzHjRNNUWHhdT7
	 EyaW8WmYu/8mNAO0/UoTeo6doKEkdNDD9Rwhr+0mXjYlAFMtI+gGkREM23XdLPIMjU
	 nEJwGXzJPx7O+coBGU9aYtBGVTHO5ooI48pAiSQNTNuursXmYsfpOWgotEDgdA9Zf0
	 CRwFe4bPhNhsE7BYcKc40iZpgKIgU6+jhC4JASdjys8GdiIjCvve0I63E564CgLPeE
	 f9zGCoQGzFUV/QcOaJh87AfD2PYRljR8v2eQlYCVTW3G6PngfnG4Bv8L5ad7rCBpI6
	 57cW6lsfZqCnw==
Date: Thu, 23 Jan 2025 15:38:18 -0600
From: Rob Herring <robh@kernel.org>
To: Christian Bruel <christian.bruel@foss.st.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	manivannan.sadhasivam@linaro.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, jingoohan1@gmail.com,
	p.zabel@pengutronix.de, johan+linaro@kernel.org,
	quic_schintav@quicinc.com, cassel@kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	fabrice.gasnier@foss.st.com
Subject: Re: [PATCH v3 01/10] dt-bindings: PCI: Add STM32MP25 PCIe Root
 Complex bindings
Message-ID: <20250123213818.GA401153-robh@kernel.org>
References: <20250115092134.2904773-1-christian.bruel@foss.st.com>
 <20250115092134.2904773-2-christian.bruel@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115092134.2904773-2-christian.bruel@foss.st.com>

On Wed, Jan 15, 2025 at 10:21:25AM +0100, Christian Bruel wrote:
> Document the bindings for STM32MP25 PCIe Controller configured in
> root complex mode.
> 
> Supports 4 INTx and MSI interrupts from the ARM GICv2m controller.
> 
> STM32 PCIe may be in a power domain which is the case for the STM32MP25
> based boards.
> 
> Supports WAKE# from wake-gpios
> 
> Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
> ---
>  .../bindings/pci/st,stm32-pcie-common.yaml    |  43 +++++++
>  .../bindings/pci/st,stm32-pcie-host.yaml      | 120 ++++++++++++++++++
>  2 files changed, 163 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/st,stm32-pcie-common.yaml
>  create mode 100644 Documentation/devicetree/bindings/pci/st,stm32-pcie-host.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/st,stm32-pcie-common.yaml b/Documentation/devicetree/bindings/pci/st,stm32-pcie-common.yaml
> new file mode 100644
> index 000000000000..9ee25bb25aac
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/st,stm32-pcie-common.yaml
> @@ -0,0 +1,43 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/st,stm32-pcie-common.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: STM32MP25 PCIe RC/EP controller
> +
> +maintainers:
> +  - Christian Bruel <christian.bruel@foss.st.com>
> +
> +description:
> +  STM32MP25 PCIe RC/EP common properties
> +
> +properties:
> +  clocks:
> +    maxItems: 1
> +    description: PCIe system clock
> +
> +  resets:
> +    maxItems: 1
> +
> +  phys:
> +    maxItems: 1

You have phys in host bridge and the root ports?

> +
> +  phy-names:
> +    const: pcie-phy

-names is unless when there is only 1 entry. We already know it's a 
'phy' for 'pcie', so the whole string adds nothing.

> +
> +  power-domains:
> +    maxItems: 1
> +
> +  access-controllers:
> +    maxItems: 1
> +
> +  reset-gpios:
> +    description: GPIO controlled connection to PERST# signal
> +    maxItems: 1

You have multiple root ports, but only one PERST# signal?

> +
> +required:
> +  - clocks
> +  - resets
> +
> +additionalProperties: true
> diff --git a/Documentation/devicetree/bindings/pci/st,stm32-pcie-host.yaml b/Documentation/devicetree/bindings/pci/st,stm32-pcie-host.yaml
> new file mode 100644
> index 000000000000..b5b8c92522e0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/st,stm32-pcie-host.yaml
> @@ -0,0 +1,120 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/st,stm32-pcie-host.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: STMicroelectronics STM32MP25 PCIe Root Complex
> +
> +maintainers:
> +  - Christian Bruel <christian.bruel@foss.st.com>
> +
> +description:
> +  PCIe root complex controller based on the Synopsys DesignWare PCIe core.
> +
> +allOf:
> +  - $ref: /schemas/pci/snps,dw-pcie.yaml#
> +  - $ref: /schemas/pci/st,stm32-pcie-common.yaml#
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
> +  msi-parent:
> +    maxItems: 1
> +
> +  wake-gpios:
> +    description: GPIO used as WAKE# input signal
> +    maxItems: 1
> +
> +  wakeup-source: true
> +
> +dependentRequired:
> +  wakeup-source: [ wake-gpios ]
> +
> +patternProperties:
> +  '^pcie@[0-2],0$':
> +    type: object
> +    $ref: /schemas/pci/pci-pci-bridge.yaml#
> +
> +    properties:
> +      reg:
> +        maxItems: 1
> +
> +      phys:
> +        maxItems: 1
> +
> +      phy-names:
> +        const: pcie-phy
> +
> +    required:
> +      - phys
> +      - phy-names
> +      - ranges
> +
> +    unevaluatedProperties: false
> +
> +required:
> +  - interrupt-map
> +  - interrupt-map-mask
> +  - ranges
> +  - dma-ranges
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
> +        ranges = <0x01000000 0x0 0x00000000 0x10010000 0x0 0x10000>,
> +                 <0x02000000 0x0 0x10020000 0x10020000 0x0 0x7fe0000>,
> +                 <0x42000000 0x0 0x18000000 0x18000000 0x0 0x8000000>;
> +        dma-ranges = <0x42000000 0x0 0x80000000 0x80000000 0x0 0x80000000>;
> +        clocks = <&rcc CK_BUS_PCIE>;
> +        resets = <&rcc PCIE_R>;
> +        msi-parent = <&v2m0>;
> +        wakeup-source;
> +        wake-gpios = <&gpioh 5 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>;
> +        reset-gpios = <&gpioj 8 GPIO_ACTIVE_LOW>;
> +        access-controllers = <&rifsc 68>;
> +        power-domains = <&CLUSTER_PD>;
> +
> +        pcie@0,0 {
> +          device_type = "pci";
> +          reg = <0x0 0x0 0x0 0x0 0x0>;
> +          phys = <&combophy PHY_TYPE_PCIE>;
> +          phy-names = "pcie-phy";
> +          #address-cells = <3>;
> +          #size-cells = <2>;
> +          ranges;
> +        };
> +
> +    };
> -- 
> 2.34.1
> 

