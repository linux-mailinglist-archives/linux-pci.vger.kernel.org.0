Return-Path: <linux-pci+bounces-8284-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C540E8FC4A4
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 09:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 503E51F22154
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 07:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E009213AD26;
	Wed,  5 Jun 2024 07:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vEntOEHv"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B715C1922D6;
	Wed,  5 Jun 2024 07:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717572918; cv=none; b=eU28iyx0fgKN1fzP1UMp/oRATaQBfVF6fDe/AlQDpg+C59TQDmcGLlvrxiSEd/SWcoohqvlizbKEaCHET613X1uvyuZMkn3hJ8z75ozoWlL9pZGsh/mc7O4GiKvwtQBcwHwdzqSYiT7GBUa4OTswoxmqqbPBMfVUbwgtIc57Mew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717572918; c=relaxed/simple;
	bh=SfFb7aDkIs4Pp93zMF9itMqBrnCKtHbQoRZPY8lZiYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nzRTwHFzZafbr3w16WZ+D8IQAm0gWI7LpceNJB2KBvWizGVt+MaX0fPveRs3QPu4GTgZ4gCSB5r+AeD9sM6xJpjRBzvGU/ojBOUlkhbPbxnmjRIQn/7dc0RN6ojQKddaCcl5I6xqyO2tXjmSpM6LPk2QLZ0zr+SAe8mtICTMeFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vEntOEHv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F34ACC4AF07;
	Wed,  5 Jun 2024 07:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717572918;
	bh=SfFb7aDkIs4Pp93zMF9itMqBrnCKtHbQoRZPY8lZiYk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vEntOEHvlAHauzbNF17TBTEkdNKzKfeGYYoTdq0m8+cu89hbOgcWcI31+Yx87ZsWK
	 l2cFWIUR3rHy8hOCi+wRdx+UNN6gvIX5tZTccATjZhVa8SbtGItPQVemyO2HdTMsVi
	 N1S37blAEz1jOoiqC18N1mzGoKd8mWXttkbJCnB9CmR/d1cPtXzVVxhYTEeVUX/oyH
	 Vob8OuDh9GWqDOkO6ZVo8+q2d/zCHHAst4Gy400wJFWj4gKNOMM+87LidiGNx1Bbac
	 Bm9F4sCGnDc9mD7AwyWFVMugCsE3Cidyo/g6jN0aLYhb3gn1tTK8aIs8B1FuMW2Uiw
	 bBhAQBj469p1A==
Date: Wed, 5 Jun 2024 13:05:06 +0530
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
Subject: Re: [PATCH v4 04/13] dt-bindings: PCI: rockchip-dw-pcie: Prepare for
 Endpoint mode support
Message-ID: <20240605073506.GF5085@thinkpad>
References: <20240529-rockchip-pcie-ep-v1-v4-0-3dc00fe21a78@kernel.org>
 <20240529-rockchip-pcie-ep-v1-v4-4-3dc00fe21a78@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240529-rockchip-pcie-ep-v1-v4-4-3dc00fe21a78@kernel.org>

On Wed, May 29, 2024 at 10:28:58AM +0200, Niklas Cassel wrote:
> Refactor the rockchip-dw-pcie binding to move generic properties to a new
> rockchip-dw-pcie-common binding that can be shared by both RC and EP mode.
> 
> No functional change intended.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../bindings/pci/rockchip-dw-pcie-common.yaml      | 111 +++++++++++++++++++++
>  .../devicetree/bindings/pci/rockchip-dw-pcie.yaml  |  93 +----------------
>  2 files changed, 114 insertions(+), 90 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie-common.yaml b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie-common.yaml
> new file mode 100644
> index 000000000000..60d190a77580
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie-common.yaml
> @@ -0,0 +1,111 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/rockchip-dw-pcie-common.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: DesignWare based PCIe RC/EP controller on Rockchip SoCs
> +
> +maintainers:
> +  - Shawn Lin <shawn.lin@rock-chips.com>
> +  - Simon Xue <xxm@rock-chips.com>
> +  - Heiko Stuebner <heiko@sntech.de>
> +
> +description: |+
> +  Generic properties for the DesignWare based PCIe RC/EP controller on Rockchip
> +  SoCs.
> +
> +properties:
> +  clocks:
> +    minItems: 5
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
> +    minItems: 5
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
> +          interrupts - inta, intb, intc, intd
> +      - description:
> +          Combined error interrupt, which is used to signal the following
> +          interrupts - aer_rc_err, aer_rc_err_msi, rx_cpl_timeout,
> +          tx_cpl_timeout, cor_err_sent, nf_err_sent, f_err_sent, cor_err_rx,
> +          nf_err_rx, f_err_rx, radm_qoverflow
> +
> +  interrupt-names:
> +    items:
> +      - const: sys
> +      - const: pmc
> +      - const: msg
> +      - const: legacy
> +      - const: err
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
> +    minItems: 1
> +    maxItems: 2
> +
> +  reset-names:
> +    oneOf:
> +      - const: pipe
> +      - items:
> +          - const: pwr
> +          - const: pipe
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - clocks
> +  - clock-names
> +  - num-lanes
> +  - phys
> +  - phy-names
> +  - power-domains
> +  - resets
> +  - reset-names
> +
> +additionalProperties: true
> +
> +...
> diff --git a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> index 5f719218c472..550d8a684af3 100644
> --- a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> @@ -4,7 +4,7 @@
>  $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
> -title: DesignWare based PCIe controller on Rockchip SoCs
> +title: DesignWare based PCIe Root Complex controller on Rockchip SoCs
>  
>  maintainers:
>    - Shawn Lin <shawn.lin@rock-chips.com>
> @@ -12,12 +12,13 @@ maintainers:
>    - Heiko Stuebner <heiko@sntech.de>
>  
>  description: |+
> -  RK3568 SoC PCIe host controller is based on the Synopsys DesignWare
> +  RK3568 SoC PCIe Root Complex controller is based on the Synopsys DesignWare
>    PCIe IP and thus inherits all the common properties defined in
>    snps,dw-pcie.yaml.
>  
>  allOf:
>    - $ref: /schemas/pci/snps,dw-pcie.yaml#
> +  - $ref: /schemas/pci/rockchip-dw-pcie-common.yaml#
>  
>  properties:
>    compatible:
> @@ -40,61 +41,6 @@ properties:
>        - const: apb
>        - const: config
>  
> -  clocks:
> -    minItems: 5
> -    items:
> -      - description: AHB clock for PCIe master
> -      - description: AHB clock for PCIe slave
> -      - description: AHB clock for PCIe dbi
> -      - description: APB clock for PCIe
> -      - description: Auxiliary clock for PCIe
> -      - description: PIPE clock
> -      - description: Reference clock for PCIe
> -
> -  clock-names:
> -    minItems: 5
> -    items:
> -      - const: aclk_mst
> -      - const: aclk_slv
> -      - const: aclk_dbi
> -      - const: pclk
> -      - const: aux
> -      - const: pipe
> -      - const: ref
> -
> -  interrupts:
> -    items:
> -      - description:
> -          Combined system interrupt, which is used to signal the following
> -          interrupts - phy_link_up, dll_link_up, link_req_rst_not, hp_pme,
> -          hp, hp_msi, link_auto_bw, link_auto_bw_msi, bw_mgt, bw_mgt_msi,
> -          edma_wr, edma_rd, dpa_sub_upd, rbar_update, link_eq_req, ep_elbi_app
> -      - description:
> -          Combined PM interrupt, which is used to signal the following
> -          interrupts - linkst_in_l1sub, linkst_in_l1, linkst_in_l2,
> -          linkst_in_l0s, linkst_out_l1sub, linkst_out_l1, linkst_out_l2,
> -          linkst_out_l0s, pm_dstate_update
> -      - description:
> -          Combined message interrupt, which is used to signal the following
> -          interrupts - ven_msg, unlock_msg, ltr_msg, cfg_pme, cfg_pme_msi,
> -          pm_pme, pm_to_ack, pm_turnoff, obff_idle, obff_obff, obff_cpu_active
> -      - description:
> -          Combined legacy interrupt, which is used to signal the following
> -          interrupts - inta, intb, intc, intd
> -      - description:
> -          Combined error interrupt, which is used to signal the following
> -          interrupts - aer_rc_err, aer_rc_err_msi, rx_cpl_timeout,
> -          tx_cpl_timeout, cor_err_sent, nf_err_sent, f_err_sent, cor_err_rx,
> -          nf_err_rx, f_err_rx, radm_qoverflow
> -
> -  interrupt-names:
> -    items:
> -      - const: sys
> -      - const: pmc
> -      - const: msg
> -      - const: legacy
> -      - const: err
> -
>    legacy-interrupt-controller:
>      description: Interrupt controller node for handling legacy PCI interrupts.
>      type: object
> @@ -119,47 +65,14 @@ properties:
>  
>    msi-map: true
>  
> -  num-lanes: true
> -
> -  phys:
> -    maxItems: 1
> -
> -  phy-names:
> -    const: pcie-phy
> -
> -  power-domains:
> -    maxItems: 1
> -
>    ranges:
>      minItems: 2
>      maxItems: 3
>  
> -  resets:
> -    minItems: 1
> -    maxItems: 2
> -
> -  reset-names:
> -    oneOf:
> -      - const: pipe
> -      - items:
> -          - const: pwr
> -          - const: pipe
> -
>    vpcie3v3-supply: true
>  
>  required:
> -  - compatible
> -  - reg
> -  - reg-names
> -  - clocks
> -  - clock-names
>    - msi-map
> -  - num-lanes
> -  - phys
> -  - phy-names
> -  - power-domains
> -  - resets
> -  - reset-names
>  
>  unevaluatedProperties: false
>  
> 
> -- 
> 2.45.1
> 

-- 
மணிவண்ணன் சதாசிவம்

