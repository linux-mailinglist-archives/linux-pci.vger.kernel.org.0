Return-Path: <linux-pci+bounces-39344-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 178E9C0ADEB
	for <lists+linux-pci@lfdr.de>; Sun, 26 Oct 2025 17:40:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED55018A16E3
	for <lists+linux-pci@lfdr.de>; Sun, 26 Oct 2025 16:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912792550A4;
	Sun, 26 Oct 2025 16:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cMMIMMKf"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5A5242D97;
	Sun, 26 Oct 2025 16:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761496755; cv=none; b=RKF+8eFjyc1rAz9FifKfpFM2t/gQ+Cv2MCAPZ1aWbAI0s10ETpgeMSp8z+mFX+d1xcHdS+8j9YI6fbMDAI5/Gtp7EZrxvIHg75bod0hZNicMZ36MsdgREBk2YLxylapbvhTLk1W5wvGHOl7pEq8Og9vfvstJFc39MPpXGhzFbSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761496755; c=relaxed/simple;
	bh=7EkrJZ5Bwy4dRCDr6B0M5T4s+Zh0OW4bkTvukrJGLIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EVqomgdhWrHWT6wA0vR3Hi4z0gC+3i8JixyNVnGSq87KE9/KhIO8f85CdS7RstSj7rSbyw2R0sMoBXj+8wFsxJl/5Q25feJbbWjlGEfRzdYwUkvPJeFzcOXDEQIgrvCD7O/KeJL/gmJMhOvxp/ai1UGsCnEa7ucwsCTXXGbDUw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cMMIMMKf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D179C4CEE7;
	Sun, 26 Oct 2025 16:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761496754;
	bh=7EkrJZ5Bwy4dRCDr6B0M5T4s+Zh0OW4bkTvukrJGLIQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cMMIMMKfUPNsyKBvzFh0/HGa59WeCmAJvwJXnIrXlgfC/IIfyLFWSdz29j3Y2wzGz
	 9uEmWMdO8WV+g8nkqWUF0hgpDMNJj1Pa2c9CB2mOjleG/OTGpd/deI635Yk73PHvEj
	 vIgVaLQOPonYlwWmwI//qPAI5+onuBWl6EkifuwqsL+B74TCCJtZ5GouB2IuFOYVeg
	 wRxlbZK1YOLs3tsWikEI6/q3mpI2w0zWbtZOd5TM29rRS2Oar1bbbDC8X6XTuHiwNF
	 YvjpD/ftBanV3r7s+TFQD+ltchQOJVWdK9y5tQ76tb7tfDi3sYPoyu7gvSrlOaFvl9
	 YjnxLPMZ9ZvxA==
Date: Sun, 26 Oct 2025 22:08:57 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Alex Elder <elder@riscstar.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org, vkoul@kernel.org, 
	kishon@kernel.org, dlan@gentoo.org, guodong@riscstar.com, pjw@kernel.org, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, p.zabel@pengutronix.de, 
	christian.bruel@foss.st.com, shradha.t@samsung.com, krishna.chundru@oss.qualcomm.com, 
	qiang.yu@oss.qualcomm.com, namcao@linutronix.de, thippeswamy.havalige@amd.com, 
	inochiama@gmail.com, devicetree@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-phy@lists.infradead.org, spacemit@lists.linux.dev, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/7] dt-bindings: pci: spacemit: introduce PCIe host
 controller
Message-ID: <u53qfrubgrcamiz35ox6lcdpp5bbzfwcsic466z5r6yyx6xz3n@c64nw2pegtfe>
References: <20251013153526.2276556-1-elder@riscstar.com>
 <20251013153526.2276556-4-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251013153526.2276556-4-elder@riscstar.com>

On Mon, Oct 13, 2025 at 10:35:20AM -0500, Alex Elder wrote:
> Add the Device Tree binding for the PCIe root complex found on the
> SpacemiT K1 SoC.  This device is derived from the Synopsys Designware
> PCIe IP.  It supports up to three PCIe ports operating at PCIe gen 2
> link speeds (5 GT/sec).  One of the ports uses a combo PHY, which is
> typically used to support a USB 3 port.
> 
> Signed-off-by: Alex Elder <elder@riscstar.com>
> ---
> v2: - Renamed the binding, using "host controller"
>     - Added '>' to the description, and reworded it a bit
>     - Added reference to /schemas/pci/snps,dw-pcie.yaml
>     - Fixed and renamed the compatible string
>     - Renamed the PMU property, and fixed its description
>     - Consistently omit the period at the end of descriptions
>     - Renamed the "global" clock to be "phy"
>     - Use interrupts rather than interrupts-extended, and name the
>       one interrupt "msi" to make clear its purpose
>     - Added a vpcie3v3-supply property
>     - Dropped the max-link-speed property
>     - Changed additionalProperties to unevaluatedProperties
>     - Dropped the label and status property from the example
> 
>  .../bindings/pci/spacemit,k1-pcie-host.yaml   | 156 ++++++++++++++++++
>  1 file changed, 156 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/spacemit,k1-pcie-host.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/spacemit,k1-pcie-host.yaml b/Documentation/devicetree/bindings/pci/spacemit,k1-pcie-host.yaml
> new file mode 100644
> index 0000000000000..87745d49c53a1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/spacemit,k1-pcie-host.yaml
> @@ -0,0 +1,156 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/spacemit,k1-pcie-host.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: SpacemiT K1 PCI Express Host Controller
> +
> +maintainers:
> +  - Alex Elder <elder@riscstar.com>
> +
> +description: >
> +  The SpacemiT K1 SoC PCIe host controller is based on the Synopsys
> +  DesignWare PCIe IP.  The controller uses the DesignWare built-in
> +  MSI interrupt controller, and supports 256 MSIs.
> +
> +allOf:
> +  - $ref: /schemas/pci/snps,dw-pcie.yaml#
> +
> +properties:
> +  compatible:
> +    const: spacemit,k1-pcie
> +
> +  reg:
> +    items:
> +      - description: DesignWare PCIe registers
> +      - description: ATU address space
> +      - description: PCIe configuration space
> +      - description: Link control registers
> +
> +  reg-names:
> +    items:
> +      - const: dbi
> +      - const: atu
> +      - const: config
> +      - const: link
> +
> +  spacemit,apmu:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description:
> +      A phandle that refers to the APMU system controller, whose
> +      regmap is used in managing resets and link state, along with
> +      and offset of its reset control register.
> +    items:
> +      - items:
> +          - description: phandle to APMU system controller
> +          - description: register offset
> +
> +  clocks:
> +    items:
> +      - description: DWC PCIe Data Bus Interface (DBI) clock
> +      - description: DWC PCIe application AXI-bus master interface clock
> +      - description: DWC PCIe application AXI-bus slave interface clock
> +
> +  clock-names:
> +    items:
> +      - const: dbi
> +      - const: mstr
> +      - const: slv
> +
> +  resets:
> +    items:
> +      - description: DWC PCIe Data Bus Interface (DBI) reset
> +      - description: DWC PCIe application AXI-bus master interface reset
> +      - description: DWC PCIe application AXI-bus slave interface reset
> +      - description: Global reset; must be deasserted for PHY to function
> +
> +  reset-names:
> +    items:
> +      - const: dbi
> +      - const: mstr
> +      - const: slv
> +      - const: phy
> +
> +  interrupts:
> +    items:
> +      - description: Interrupt used for MSIs
> +
> +  interrupt-names:
> +    const: msi
> +
> +  phys:
> +    maxItems: 1
> +
> +  vpcie3v3-supply:
> +    description:
> +      A phandle for 3.3v regulator to use for PCIe

Could you please move these Root Port specific properties (phy, vpcie3v3-supply)
to the Root Port node?

Reference: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/pci/st,stm32-pcie-host.yaml

For handling the 'vpcie3v3-supply', you can rely on PCI_PWRCTRL_SLOT driver.

> +
> +  device_type:
> +    const: pci
> +

This is part of the PCI bus schema itself.

> +  num-viewport:
> +    const: 8
> +

This property has been deprecated in favor of driver auto-detecting the iATU
regions.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

