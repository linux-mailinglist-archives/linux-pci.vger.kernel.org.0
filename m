Return-Path: <linux-pci+bounces-36121-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1B8B572A0
	for <lists+linux-pci@lfdr.de>; Mon, 15 Sep 2025 10:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B12921785FC
	for <lists+linux-pci@lfdr.de>; Mon, 15 Sep 2025 08:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D212EBB96;
	Mon, 15 Sep 2025 08:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="peH66S1M"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1593F2EB5C4;
	Mon, 15 Sep 2025 08:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757924116; cv=none; b=n9Nj5lC7wZ3SSdGzGTWxGNC02FDIi9KF/isfI+8YRGSVQB2fmTc9mD1xsxo6qxaTJqZ35elAceS5Z6PZlGI+QKsZxBCzdR+sNTFRGiBVakIeDvMTayLFYmYBaYmbrRmP5V5oc6JK+AJlAv53yFa6jxK2TIXmtL84EPB04h+z1kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757924116; c=relaxed/simple;
	bh=mpw1Kp/ruV8064l6dcTGb8KpE+L8YZqt3SSB47iPlo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IVLGil6Ho832jpSMWk4+Xcx6rpqKW5oLxMt89izFlP5D6n6JqRPt8tvR6YV2qIHJ2k4IPgl6P3JsV1RQual5AIZyLfiyDc7WLo+AaFEbECHeEK3WygCDKBSdo37oHKVuZ/hhc17xFTgXIABreh+Wnr/Lt34kVNtzJzb7iHB531g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=peH66S1M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A93D4C4CEF1;
	Mon, 15 Sep 2025 08:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757924114;
	bh=mpw1Kp/ruV8064l6dcTGb8KpE+L8YZqt3SSB47iPlo0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=peH66S1MaL/o5ItLrB+kDxmnPsq9tk53l1nKj5PFQAY7UlTolv/oeUbJ8dP4CuEwz
	 yVJ2U3mDcclKIL+pJ7MvcHbLaQXVoadr590BASq+j3+XbNQUhTqfRtZ1BEqRiA23i0
	 E6tcSm3VKTTS42rKBMAYqxTQtX1e1UXcsLTfvnwcoy8FtFWnG1TgKD0IfVIhxPHBo3
	 sA7gPahnYjouLq07rtGr/fspDIqe9abSsQ0v6BWtN4J3podytFClcXZQmEyeckPvf8
	 DxslL10q5RDuxRlv8ZcKXSkNbVjDN0ohQXPN6FGEk3JQdjyUJi/fYc/f927/skzN6M
	 9s8wrlhV8nB7A==
Date: Mon, 15 Sep 2025 13:44:58 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Alex Elder <elder@riscstar.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	lpieralisi@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com, vkoul@kernel.org, 
	kishon@kernel.org, dlan@gentoo.org, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, p.zabel@pengutronix.de, tglx@linutronix.de, 
	johan+linaro@kernel.org, thippeswamy.havalige@amd.com, namcao@linutronix.de, 
	mayank.rana@oss.qualcomm.com, shradha.t@samsung.com, inochiama@gmail.com, 
	quic_schintav@quicinc.com, fan.ni@samsung.com, devicetree@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-pci@vger.kernel.org, spacemit@lists.linux.dev, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] dt-bindings: phy: spacemit: introduce PCIe root
 complex
Message-ID: <tmdq6iut5z2bzemduovvyarya6ho2lwlxvvqqhazw6dnnyjpq3@72xrd2pij42h>
References: <20250813184701.2444372-1-elder@riscstar.com>
 <20250813184701.2444372-4-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250813184701.2444372-4-elder@riscstar.com>

On Wed, Aug 13, 2025 at 01:46:57PM GMT, Alex Elder wrote:

Subject should have 'pci' prefix, not 'phy'.

> Add the Device Tree binding for the PCIe root complex found on the
> SpacemiT K1 SoC.  This device is derived from the Synopsys Designware
> PCIe IP.  It supports up to three PCIe ports operating at PCIe gen 2
> link speeds (5 GT/sec).  One of the ports uses a combo PHY, which is
> typically used to support a USB 3 port.
> 
> Signed-off-by: Alex Elder <elder@riscstar.com>
> ---
>  .../bindings/pci/spacemit,k1-pcie-rc.yaml     | 141 ++++++++++++++++++
>  1 file changed, 141 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/spacemit,k1-pcie-rc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/spacemit,k1-pcie-rc.yaml b/Documentation/devicetree/bindings/pci/spacemit,k1-pcie-rc.yaml
> new file mode 100644
> index 0000000000000..6bcca2f91a6fd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/spacemit,k1-pcie-rc.yaml
> @@ -0,0 +1,141 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/spacemit,k1-pcie-rc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: SpacemiT K1 PCI Express Root Complex
> +
> +maintainers:
> +  - Alex Elder <elder@riscstar.com>
> +
> +description:
> +  The SpacemiT K1 SoC PCIe root complex controller is based on the
> +  Synopsys DesignWare PCIe IP.
> +
> +properties:
> +  compatible:
> +    const: spacemit,k1-pcie-rc.yaml
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
> +  clocks:
> +    items:
> +      - description: DWC PCIe Data Bus Interface (DBI) clock
> +      - description: DWC PCIe application AXI-bus Master interface clock
> +      - description: DWC PCIe application AXI-bus Slave interface clock.
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
> +      - description: DWC PCIe application AXI-bus Master interface reset
> +      - description: DWC PCIe application AXI-bus Slave interface reset.
> +      - description: Global reset; must be deasserted for PHY to function
> +
> +  reset-names:
> +    items:
> +      - const: dbi
> +      - const: mstr
> +      - const: slv
> +      - const: global
> +
> +  interrupts-extended:
> +    maxItems: 1

What is the purpose of this property? Is it for MSI or INTx?

> +
> +  spacemit,syscon-pmu:
> +    description:
> +      PHandle that refers to the APMU system controller, whose
> +      regmap is used in managing resets and link state.
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +
> +  device_type:
> +    const: pci
> +
> +  max-link-speed:
> +    const: 2

Why do you need to limit it to 5 GT/s always?

> +
> +  num-viewport:
> +    const: 8
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - resets
> +  - reset-names
> +  - spacemit,syscon-pmu
> +  - "#address-cells"
> +  - "#size-cells"
> +  - device_type
> +  - max-link-speed

Same comment as above.

> +  - bus-range
> +  - num-viewport
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/spacemit,k1-syscon.h>
> +    pcie0: pcie@ca000000 {
> +        compatible = "spacemit,k1-pcie-rc";
> +        reg = <0x0 0xca000000 0x0 0x00001000>,
> +              <0x0 0xca300000 0x0 0x0001ff24>,
> +              <0x0 0x8f000000 0x0 0x00002000>,
> +              <0x0 0xc0b20000 0x0 0x00001000>;
> +        reg-names = "dbi",
> +                    "atu",
> +                    "config",
> +                    "link";
> +
> +        ranges = <0x01000000 0x8f002000 0x0 0x8f002000 0x0 0x100000>,

I/O port CPU address starts from 0.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

