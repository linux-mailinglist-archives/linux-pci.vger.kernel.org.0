Return-Path: <linux-pci+bounces-8286-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD5E8FC4CB
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 09:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA52A1F23960
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 07:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E06818F2C9;
	Wed,  5 Jun 2024 07:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NwD0PToe"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507DF18F2C4;
	Wed,  5 Jun 2024 07:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717573374; cv=none; b=OP6mayzKsk/jJLcHX3TuYgOkJDZZb3z0b7ikrjHLEPwPQUZaWODz30stQ0KsH8oJfh0MVdkNmrdZP2nBn9t1oPsqCmKh5ZIRMkRfgFCX/LI+ujm5MMSe4tAlBOb3Q/x/jpREuMtTTErNLqowECb/tYfuEEnPuqgCHnzSZk5IBUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717573374; c=relaxed/simple;
	bh=HM7m/U7N3NDvThcmwy49Jtde3MbVuHJZ4vKRZbduAu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MA6iIfK51IjmC5nj+laDfz98JX+H9BGW6Em/jmxE3Qc+af5WbtRjYqwcq+inWXC6tMyc1otjTrSgue9E9TNKCHJD8zbhnOncNyjKVaU4ZFXaamKW25OWqW5QeLI5QhLnAv6dcw+rwviSdt9IQN2ozWjThHyqPw8EAgKyXXO8zjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NwD0PToe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C64E9C4AF09;
	Wed,  5 Jun 2024 07:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717573373;
	bh=HM7m/U7N3NDvThcmwy49Jtde3MbVuHJZ4vKRZbduAu0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NwD0PToe3JkMcXF0JbT1Y6kuJoKVzuKGay0y3G2dv6eyIbRdeDMxiGR8jq+iS2uY4
	 rlBhDbQBNXu5GseWNh+RhwQJXDsebtZEZ9bXjUlV7PADrX8SwpD/LUMztRrVGQIJMw
	 WiveEApcQ5wG859qo+9m23XGpKVO/bL6Wgyb+uxhVKgzEG2CS7FD9Wn3/D/VaEFntL
	 AR9+4L1+qd6la7JMwOodCBYFQkCjHqva9FDCSX94ohLICE3hA2jg3O6WwRqqWyMb3S
	 JGQXfllIQ9XgdobS6SL0HLHRHR2V2y/ffhRPY0GyMOtHGsynBjuJ8HoPGirCipk/aQ
	 nqeFZDP1LdRdA==
Date: Wed, 5 Jun 2024 13:12:40 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Damien Le Moal <dlemoal@kernel.org>,
	Jon Lin <jon.lin@rock-chips.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Simon Xue <xxm@rock-chips.com>, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v4 06/13] dt-bindings: rockchip: Add DesignWare based
 PCIe Endpoint controller
Message-ID: <20240605074240.GH5085@thinkpad>
References: <20240529-rockchip-pcie-ep-v1-v4-0-3dc00fe21a78@kernel.org>
 <20240529-rockchip-pcie-ep-v1-v4-6-3dc00fe21a78@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240529-rockchip-pcie-ep-v1-v4-6-3dc00fe21a78@kernel.org>

On Wed, May 29, 2024 at 10:29:00AM +0200, Niklas Cassel wrote:
> Document DT bindings for PCIe Endpoint controller found in Rockchip SoCs.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Couple of nitpicks below. With those fixed,

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../bindings/pci/rockchip-dw-pcie-common.yaml      | 14 ++++
>  .../bindings/pci/rockchip-dw-pcie-ep.yaml          | 95 ++++++++++++++++++++++
>  2 files changed, 109 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie-common.yaml b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie-common.yaml
> index ec5e6a3d048e..cc9adfc7611c 100644
> --- a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie-common.yaml
> +++ b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie-common.yaml
> @@ -39,6 +39,7 @@ properties:
>        - const: ref
>  
>    interrupts:
> +    minItems: 5
>      items:
>        - description:
>            Combined system interrupt, which is used to signal the following
> @@ -63,14 +64,27 @@ properties:
>            interrupts - aer_rc_err, aer_rc_err_msi, rx_cpl_timeout,
>            tx_cpl_timeout, cor_err_sent, nf_err_sent, f_err_sent, cor_err_rx,
>            nf_err_rx, f_err_rx, radm_qoverflow
> +      - description:
> +          eDMA write channel 0 interrupt
> +      - description:
> +          eDMA write channel 1 interrupt
> +      - description:
> +          eDMA read channel 0 interrupt
> +      - description:
> +          eDMA read channel 1 interrupt
>  
>    interrupt-names:
> +    minItems: 5
>      items:
>        - const: sys
>        - const: pmc
>        - const: msg
>        - const: legacy
>        - const: err
> +      - const: dma0
> +      - const: dma1
> +      - const: dma2
> +      - const: dma3
>  
>    num-lanes: true
>  
> diff --git a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie-ep.yaml
> new file mode 100644
> index 000000000000..e0c8668afc01
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie-ep.yaml
> @@ -0,0 +1,95 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/rockchip-dw-pcie-ep.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: DesignWare based PCIe Endpoint controller on Rockchip SoCs
> +
> +maintainers:
> +  - Niklas Cassel <cassel@kernel.org>
> +
> +description: |+
> +  RK3588 SoC PCIe Endpoint controller is based on the Synopsys DesignWare
> +  PCIe IP and thus inherits all the common properties defined in
> +  snps,dw-pcie-ep.yaml.
> +
> +allOf:
> +  - $ref: /schemas/pci/snps,dw-pcie-ep.yaml#
> +  - $ref: /schemas/pci/rockchip-dw-pcie-common.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - rockchip,rk3568-pcie-ep
> +      - rockchip,rk3588-pcie-ep
> +
> +  reg:
> +    items:
> +      - description: Data Bus Interface (DBI) registers
> +      - description: Data Bus Interface (DBI) shadow registers
> +      - description: Rockchip designed configuration registers
> +      - description: Memory region used to map remote RC address space
> +      - description: Address Translation Unit (ATU) registers

Nit: Internal Address Translation Unit (iATU)

> +
> +  reg-names:
> +    items:
> +      - const: dbi
> +      - const: dbi2
> +      - const: apb
> +      - const: addr_space
> +      - const: atu
> +
> +required:
> +  - interrupts
> +  - interrupt-names
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/rockchip,rk3588-cru.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/power/rk3588-power.h>
> +    #include <dt-bindings/reset/rockchip,rk3588-cru.h>
> +
> +    bus {

Even though 'bus' node is also used in many bindings, I prefer 'soc' since it
fits better IMO.

> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        pcie3x4_ep: pcie-ep@fe150000 {
> +            compatible = "rockchip,rk3588-pcie-ep";
> +            clocks = <&cru ACLK_PCIE_4L_MSTR>, <&cru ACLK_PCIE_4L_SLV>,
> +                     <&cru ACLK_PCIE_4L_DBI>, <&cru PCLK_PCIE_4L>,
> +                     <&cru CLK_PCIE_AUX0>, <&cru CLK_PCIE4L_PIPE>;
> +            clock-names = "aclk_mst", "aclk_slv",
> +                          "aclk_dbi", "pclk",
> +                          "aux", "pipe";
> +            interrupts = <GIC_SPI 263 IRQ_TYPE_LEVEL_HIGH 0>,
> +                         <GIC_SPI 262 IRQ_TYPE_LEVEL_HIGH 0>,
> +                         <GIC_SPI 261 IRQ_TYPE_LEVEL_HIGH 0>,
> +                         <GIC_SPI 260 IRQ_TYPE_LEVEL_HIGH 0>,
> +                         <GIC_SPI 259 IRQ_TYPE_LEVEL_HIGH 0>,
> +                         <GIC_SPI 271 IRQ_TYPE_LEVEL_HIGH 0>,
> +                         <GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH 0>,
> +                         <GIC_SPI 269 IRQ_TYPE_LEVEL_HIGH 0>,
> +                         <GIC_SPI 270 IRQ_TYPE_LEVEL_HIGH 0>;
> +            interrupt-names = "sys", "pmc", "msg", "legacy", "err",
> +                              "dma0", "dma1", "dma2", "dma3";
> +            max-link-speed = <3>;
> +            num-lanes = <4>;
> +            phys = <&pcie30phy>;
> +            phy-names = "pcie-phy";
> +            power-domains = <&power RK3588_PD_PCIE>;
> +            reg = <0xa 0x40000000 0x0 0x00100000>,
> +                  <0xa 0x40100000 0x0 0x00100000>,
> +                  <0x0 0xfe150000 0x0 0x00010000>,
> +                  <0x9 0x00000000 0x0 0x40000000>,
> +                  <0xa 0x40300000 0x0 0x00100000>;
> +            reg-names = "dbi", "dbi2", "apb", "addr_space", "atu";

Can you move 'reg' and 'reg-names' below 'compatible' to align with common
convention?

- Mani

> +            resets = <&cru SRST_PCIE0_POWER_UP>, <&cru SRST_P_PCIE0>;
> +            reset-names = "pwr", "pipe";
> +        };
> +    };
> +...
> 
> -- 
> 2.45.1
> 

-- 
மணிவண்ணன் சதாசிவம்

