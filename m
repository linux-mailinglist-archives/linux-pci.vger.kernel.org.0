Return-Path: <linux-pci+bounces-38246-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC0DBDFBF6
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 18:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AB2D4070DA
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 16:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E48926980B;
	Wed, 15 Oct 2025 16:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EeCZ+ged"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEA0171C9;
	Wed, 15 Oct 2025 16:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760546854; cv=none; b=LPd7D6lk/8QlIDofHGXYdhzDJG1iqZLu2bD5QBpVTFckBKr51Z+F1KTMXm0oLzlGiI400xE3xhq4uhg0BVlcXHT7q1cQhuo0dtSUrqI7zy9CodHBMMKglr1VNwC1k5F+mXRPhjpTFpNVxM7LpHjbzMavc0Whwpv1azuYHIhSFy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760546854; c=relaxed/simple;
	bh=SYgfDbfizk0X/84j7ocQGVtNofPjS5i2LN9U4BzBYL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D3qc6KpBZR6cTNjwEIoHXa8DaGy96OnFDtgTOn3sh21IKEnQx7OcHJfWK6ccAOCeykMNStXkGuDNMZECdNPmTchKr/Vl7LYx22pj3cdnWgTLqBHoa3TpHNrqGMdk1J5Oyxm9w1dRqDb6RVHp34a/AIOcvF+ZgSYzWnv14chNtqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EeCZ+ged; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F441C4CEF8;
	Wed, 15 Oct 2025 16:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760546852;
	bh=SYgfDbfizk0X/84j7ocQGVtNofPjS5i2LN9U4BzBYL8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EeCZ+gedlVwAatBEieaaUcV2n5mIE/fEI50/OwUwjfo/tOturTyZAdsGckZjqo8Q2
	 5jZYYH8MvUvh5PtRiiSmrWhFabgziuKQdEz0yMI2vYLzmATjNrHTBYKBLOPQDJEt4L
	 NrVlGpCsSYAa0J00/aqVqsx61Tmc7Ois53cHqZtkHP8SlCISXtywyfocWSyqhsagS3
	 NICYMnbQrz88kkIvGDr4o2Mj4sQgBh/Gw7AgGWphebXNvz56mhdjj6rWXM0y+SYW6N
	 +g2wioFnvn6vPmgwQDOQC02ta+peazT5SVVgSlF7zm2/yWAOq+wpzzbFBDUIyLFKUu
	 OBPBLverjqImA==
Date: Wed, 15 Oct 2025 11:47:30 -0500
From: Rob Herring <robh@kernel.org>
To: Alex Elder <elder@riscstar.com>
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, bhelgaas@google.com,
	lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	vkoul@kernel.org, kishon@kernel.org, dlan@gentoo.org,
	guodong@riscstar.com, pjw@kernel.org, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, alex@ghiti.fr, p.zabel@pengutronix.de,
	christian.bruel@foss.st.com, shradha.t@samsung.com,
	krishna.chundru@oss.qualcomm.com, qiang.yu@oss.qualcomm.com,
	namcao@linutronix.de, thippeswamy.havalige@amd.com,
	inochiama@gmail.com, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-phy@lists.infradead.org,
	spacemit@lists.linux.dev, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/7] dt-bindings: pci: spacemit: introduce PCIe host
 controller
Message-ID: <20251015164730.GA4032812-robh@kernel.org>
References: <20251013153526.2276556-1-elder@riscstar.com>
 <20251013153526.2276556-4-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

You expect/need the phy driver and PCIe driver to both reset the PHY? 
You should do that indirectly with the PHY API when you reset the 
controller.

Rob

