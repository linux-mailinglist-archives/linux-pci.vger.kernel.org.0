Return-Path: <linux-pci+bounces-9425-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF2C91C8E5
	for <lists+linux-pci@lfdr.de>; Sat, 29 Jun 2024 00:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B1141C227AF
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jun 2024 22:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A5B7E101;
	Fri, 28 Jun 2024 22:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fnm0n9Pd"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265DB56444;
	Fri, 28 Jun 2024 22:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719612326; cv=none; b=pBER0W+Benieq4864JDAIp3XJ2YkqVRvMYDwPup7b+sA0I8HTlWBClDPSJexbU6TuhHDd30YHPIf1M5L88d9SOJr0HQw2cHVNl1ttW4IUwMmb433c+shN8EEB32y0BYGhxE+g5H2sDomMPPUCicuxwoaiQBZccIME+/hUe8lzHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719612326; c=relaxed/simple;
	bh=dCbnbxqitHnowclFYORCNIf01H5GUcscv/0xyEOMEOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e+6pqqR/Duor3Ao5HNNgQhru1+eb8H5ArxvX9YIdSiEseNblX4C08yEuFMkZicGcnyvl4hDabSVGQqKvYhDrCobO5CT4iH3pMVKrZweuVoyQxIaMG7yoaqoZo0KaniGH2jUveNrlhHy+G6UdgbWODR0wV0k+CEvjfs5R0p7CIGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fnm0n9Pd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E97DC116B1;
	Fri, 28 Jun 2024 22:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719612325;
	bh=dCbnbxqitHnowclFYORCNIf01H5GUcscv/0xyEOMEOs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fnm0n9Pd0KCDyFGG4c0axHmcEhK1HqMMOwxblV+5fo2lw4f6010kKn2/HGY8zNGEt
	 XuWDkUPo20b293L6Hn8Aq/egdWcwa778HPDPNJuRXLzYAvrqUvvbvYkvyj5Mh+n3QM
	 zjc1tlq+fZanp1afh+hSqa1LNqOS+S4TisGQHMfrA4dlR1aYokK5cTWZmZxNqZWo0W
	 tIHJ1be++FApDN1mX3le9yc5+qApwjRTD4bm/xlkIZFP2kMQbIyDdO9IssyTOfJr+H
	 j5U+DCbjcWGBFG5H1gOmJ26V5YXN4oYM/jndZKcB0zUe80G4YWHUwbZtnxBWpc51HF
	 vQPP1RL4ROp/A==
Date: Fri, 28 Jun 2024 16:05:21 -0600
From: Rob Herring <robh@kernel.org>
To: Stanimir Varbanov <svarbanov@suse.de>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jim Quinlan <jim2101024@gmail.com>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>, kw@linux.com,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Andrea della Porta <andrea.porta@suse.com>,
	Phil Elwell <phil@raspberrypi.com>,
	Jonathan Bell <jonathan@raspberrypi.com>
Subject: Re: [PATCH 1/7] dt-bindings: interrupt-controller: Add bcm2712 MSI-X
 DT bindings
Message-ID: <20240628220521.GA274493-robh@kernel.org>
References: <20240626104544.14233-1-svarbanov@suse.de>
 <20240626104544.14233-2-svarbanov@suse.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626104544.14233-2-svarbanov@suse.de>

On Wed, Jun 26, 2024 at 01:45:38PM +0300, Stanimir Varbanov wrote:
> Adds DT bindings for bcm2712 MSI-X interrupt peripheral controller.
> 
> Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
> ---
>  .../brcm,bcm2712-msix.yaml                    | 74 +++++++++++++++++++
>  1 file changed, 74 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/brcm,bcm2712-msix.yaml
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm2712-msix.yaml b/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm2712-msix.yaml
> new file mode 100644
> index 000000000000..ca610e4467d9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm2712-msix.yaml
> @@ -0,0 +1,74 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interrupt-controller/brcm,bcm2712-msix.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Broadcom bcm2712 MSI-X Interrupt Peripheral support
> +
> +maintainers:
> +  - Stanimir Varbanov <svarbanov@suse.de>
> +
> +description: >
> +  This interrupt controller is used to provide intterupt vectors to the

typo

> +  generic interrupt controller (GIC) on bcm2712. It will be used as
> +  external MSI-X controller for PCIe root complex.
> +
> +allOf:
> +  - $ref: /schemas/interrupt-controller/msi-controller.yaml#
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - "brcm,bcm2712-mip-intc"

Don't need quotes. Nor 'items'. And enum can be 'const' 

> +  reg:
> +    maxItems: 1
> +    description: >
> +      Specifies the base physical address and size of the registers

drop. That's *every* reg property.

> +
> +  interrupt-controller: true
> +
> +  "#interrupt-cells":
> +    const: 2
> +
> +  msi-controller: true

Add #msi-cells. The default is 0, but that's legacy.

> +
> +  brcm,msi-base-spi:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: The SGI number that MSIs start.
> +
> +  brcm,msi-num-spis:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: The number of SGIs for MSIs.
> +
> +  brcm,msi-offset:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Shift the allocated MSIs up by N.

If only we had a property that every MSI controller seems to need. Go 
check msi-controller.yaml...

> +
> +  brcm,msi-pci-addr:
> +    $ref: /schemas/types.yaml#/definitions/uint64
> +    description: MSI-X message address.

Why don't other platforms need something like this?

> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupt-controller
> +  - "#interrupt-cells"
> +  - msi-controller
> +
> +examples:
> +  - |
> +    msi-controller@130000 {
> +      compatible = "brcm,bcm2712-mip-intc";
> +      reg = <0x00130000 0xc0>;
> +      msi-controller;
> +      interrupt-controller;
> +      #interrupt-cells = <2>;
> +      brcm,msi-base-spi = <128>;
> +      brcm,msi-num-spis = <64>;
> +      brcm,msi-offset = <0>;
> +      brcm,msi-pci-addr = <0xff 0xfffff000>;
> +    };
> -- 
> 2.43.0
> 

