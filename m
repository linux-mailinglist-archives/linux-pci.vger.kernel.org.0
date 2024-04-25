Return-Path: <linux-pci+bounces-6671-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 587FB8B2602
	for <lists+linux-pci@lfdr.de>; Thu, 25 Apr 2024 18:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78CC0B27427
	for <lists+linux-pci@lfdr.de>; Thu, 25 Apr 2024 16:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17FA114C59C;
	Thu, 25 Apr 2024 16:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pGc5UEd7"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B2314C58E;
	Thu, 25 Apr 2024 16:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714061292; cv=none; b=EWzjlVTdQPpZJi+mVZd8MfHdBQc/z3UAAy3AabC3j8x0El2t9KsXOWdWlcf+MXwPy6WnKSxiuBrtvEqGHBAj+qRuJaI2OPvhfgDpzhU1yVMqfYchVocO97H9g+DbOjPCvFTbAN6Jqn3We9SawJ+B0WaVMG51bA2tOZynyRmVMFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714061292; c=relaxed/simple;
	bh=oIgWqDe6+nieD7h1CLyTm0mDgOApEatpXGoBJXAWIJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EUpufCGIaHqsv7R7UNfr2ggIiRuMzYP1ugNJB8RvdeEZe8kVwNqNentz3MAGY+sP8bmc0EXPs4B9Cx72dQFK7JLG8AjNylw+Lr40V1WeewU41UI2UcBXVUWUkhDtITWJQClofFTi12mD3awK3VK9K7EUrFKbax63zSSnNw/TQGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pGc5UEd7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C9DCC113CC;
	Thu, 25 Apr 2024 16:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714061291;
	bh=oIgWqDe6+nieD7h1CLyTm0mDgOApEatpXGoBJXAWIJo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pGc5UEd7PUsxYbMazTYm6EfUQGBt013WyZPHhyUdnjGlUG4dp9+xxZ6WZAYIUIOHQ
	 0h4KrxvhHNot1z9iLEgFlIMArOHzsONYUmpUpjJjEBuzunAgR10uWhyju/ygH71lGM
	 xbE41drSISXbD4WqMdMdRSkTdvDDzSOXhOBl8JXU3lKX/abUNnA1xXclgbjtg9EDHT
	 Ibra4HkK4KBJrFxKuOPF5vdGzEgeUB7JLl1m1iZb2Czb61h+iSsTD0bxlVPzwuqu6s
	 koh4kGVKAsTwdhkX53SVDF0Eh1cCJOmc1WYCL/qCcKy4y0p9ANNo9nF7Utvndp+/jb
	 oICjWdFdEJDdw==
Date: Thu, 25 Apr 2024 11:08:09 -0500
From: Rob Herring <robh@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Damien Le Moal <dlemoal@kernel.org>,
	Jon Lin <jon.lin@rock-chips.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Simon Xue <xxm@rock-chips.com>, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 04/12] dt-bindings: rockchip: Add DesignWare based PCIe
 Endpoint controller
Message-ID: <20240425160809.GA2613935-robh@kernel.org>
References: <20240424-rockchip-pcie-ep-v1-v1-0-b1a02ddad650@kernel.org>
 <20240424-rockchip-pcie-ep-v1-v1-4-b1a02ddad650@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424-rockchip-pcie-ep-v1-v1-4-b1a02ddad650@kernel.org>

On Wed, Apr 24, 2024 at 05:16:22PM +0200, Niklas Cassel wrote:
> Document DT bindings for PCIe Endpoint controller found in Rockchip SoCs.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  .../bindings/pci/rockchip-dw-pcie-ep.yaml          | 192 +++++++++++++++++++++
>  1 file changed, 192 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie-ep.yaml
> new file mode 100644
> index 000000000000..57a6c542058f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie-ep.yaml
> @@ -0,0 +1,192 @@
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
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: rockchip,rk3588-pcie-ep

3568 doesn't support endpoint mode? It would be good to keep the 
bindings aligned.

> +
> +  reg:
> +    items:
> +      - description: Data Bus Interface (DBI) registers
> +      - description: Data Bus Interface (DBI) shadow registers
> +      - description: Rockchip designed configuration registers
> +      - description: Memory region used to map remote RC address space
> +      - description: Address Translation Unit (ATU) registers
> +
> +  reg-names:
> +    items:
> +      - const: dbi
> +      - const: dbi2
> +      - const: apb
> +      - const: addr_space
> +      - const: atu
> +
> +  clocks:
> +    minItems: 6
> +    items:
> +      - description: AHB clock for PCIe master
> +      - description: AHB clock for PCIe slave
> +      - description: AHB clock for PCIe dbi
> +      - description: APB clock for PCIe
> +      - description: Auxiliary clock for PCIe
> +      - description: PIPE clock
> +      - description: Reference clock for PCIe
> +
> +  clock-names:
> +    minItems: 6
> +    items:
> +      - const: aclk_mst
> +      - const: aclk_slv
> +      - const: aclk_dbi
> +      - const: pclk
> +      - const: aux
> +      - const: pipe
> +      - const: ref
> +
> +  interrupts:
> +    items:
> +      - description:
> +          Combined system interrupt, which is used to signal the following
> +          interrupts - phy_link_up, dll_link_up, link_req_rst_not, hp_pme,
> +          hp, hp_msi, link_auto_bw, link_auto_bw_msi, bw_mgt, bw_mgt_msi,
> +          edma_wr, edma_rd, dpa_sub_upd, rbar_update, link_eq_req, ep_elbi_app
> +      - description:
> +          Combined PM interrupt, which is used to signal the following
> +          interrupts - linkst_in_l1sub, linkst_in_l1, linkst_in_l2,
> +          linkst_in_l0s, linkst_out_l1sub, linkst_out_l1, linkst_out_l2,
> +          linkst_out_l0s, pm_dstate_update
> +      - description:
> +          Combined message interrupt, which is used to signal the following
> +          interrupts - ven_msg, unlock_msg, ltr_msg, cfg_pme, cfg_pme_msi,
> +          pm_pme, pm_to_ack, pm_turnoff, obff_idle, obff_obff, obff_cpu_active
> +      - description:
> +          Combined legacy interrupt, which is used to signal the following
> +          interrupts - tx_inta, tx_intb, tx_intc, tx_intd
> +      - description:
> +          Combined error interrupt, which is used to signal the following
> +          interrupts - aer_rc_err, aer_rc_err_msi, rx_cpl_timeout,
> +          tx_cpl_timeout, cor_err_sent, nf_err_sent, f_err_sent, cor_err_rx,
> +          nf_err_rx, f_err_rx, radm_qoverflow
> +      - description:
> +          eDMA write channel 0 interrupt
> +      - description:
> +          eDMA write channel 1 interrupt
> +      - description:
> +          eDMA read channel 0 interrupt
> +      - description:
> +          eDMA read channel 1 interrupt
> +
> +  interrupt-names:
> +    items:
> +      - const: sys
> +      - const: pmc
> +      - const: msg
> +      - const: legacy
> +      - const: err
> +      - const: dma0
> +      - const: dma1
> +      - const: dma2
> +      - const: dma3
> +
> +  num-lanes: true
> +
> +  phys:
> +    maxItems: 1
> +
> +  phy-names:
> +    const: pcie-phy
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 2
> +
> +  reset-names:
> +    items:
> +      - const: pwr
> +      - const: pipe

Most of this is all duplicated from rockchip-dw-pcie.yaml. Pull out the 
common bits to a separate schema file and reference it from the RC and 
endpoint schemas.

You'll need to add to interrupts/interrupt-names in the common schema 
and then restrict the number of items here and in the RC schema.

> +
> +  vpcie3v3-supply: true

This doesn't make sense for endpoint mode. At least in the sense this 
is supposed to be a standard slot voltage driven from the host side.

> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - clocks
> +  - clock-names
> +  - interrupts
> +  - interrupt-names
> +  - num-lanes
> +  - phys
> +  - phy-names
> +  - power-domains
> +  - resets
> +  - reset-names

A bunch or all? of these can be in the common schema too.

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
> +            resets = <&cru SRST_PCIE0_POWER_UP>, <&cru SRST_P_PCIE0>;
> +            reset-names = "pwr", "pipe";
> +        };
> +    };
> +...
> 
> -- 
> 2.44.0
> 

