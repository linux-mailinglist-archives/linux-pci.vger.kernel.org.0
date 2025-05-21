Return-Path: <linux-pci+bounces-28186-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1356ABF01D
	for <lists+linux-pci@lfdr.de>; Wed, 21 May 2025 11:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12FC51896B12
	for <lists+linux-pci@lfdr.de>; Wed, 21 May 2025 09:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB965248F7B;
	Wed, 21 May 2025 09:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DiQX2a/y"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8E3248F52;
	Wed, 21 May 2025 09:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747820223; cv=none; b=IkBWFSRcOeUPviCKCj/rKl5xURlCyBK2kVG8WoaAdADRFDC99L/GicUVRZzmksE2r8kjmfu0FubozzCjTli27tbIFBb0bk+6MaVrcJkXXfGpQzbMAOEN4HqmNi2noDe++saVOUPNOpei0baysk+BrUqDhBmSxwuHp6JC84WYju0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747820223; c=relaxed/simple;
	bh=R1smjQqKCqBD+gWdTB65+uxqJBq+XDVIA1HiFl2BUto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L/X0N6hEeVDX7dBRdydBa/csF1wwZyToDmpp6sRUBg/f3dvzgX6GAIQgYfZeK2DppVc5y9i3kXsJSqT8N7qbUY0kw6J4aX0FCrmy4rPuD7HqOPDIAeKodrkkqKYDxsmbngsVSXzbFNXzvOgsmxZZplD2K+QzTa6AhEAj4agmyO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DiQX2a/y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C83BC4CEEA;
	Wed, 21 May 2025 09:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747820223;
	bh=R1smjQqKCqBD+gWdTB65+uxqJBq+XDVIA1HiFl2BUto=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DiQX2a/yEYtLcOsrcqsA8mt3vW5BKfAft3rqhXBG1vP+4EHTTVxJy+pWhT00oXw1D
	 3gtkj/T+tQI/0ac2x+yHV7vIM/2L53bgqpUdDnh9tzN/i1RqrF2dwFx4UVlkcB9V5N
	 VGmzEFk2uV24NwbJ282OLOUMY8QYqfxZcaR2NliOFW1RvA1qszcVlMOTWLtIILI5mR
	 pMF86sqaKqqxGDzz9AiHawlngTscobwL0bMO4+C1Bv5SVwW9fz8/iGaes/R6filcuc
	 iTuLyTvv2ub99UqOZ++0ZVLi8rb8ec396YKF5A9tzQGNx+epBTBMBkOoLzqY1YcyQ8
	 vlvfdeQ5dgI2g==
Date: Wed, 21 May 2025 11:37:00 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Shradha Todi <shradha.t@samsung.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.or, linux-kernel@vger.kernel.org, 
	linux-phy@lists.infradead.org, manivannan.sadhasivam@linaro.org, lpieralisi@kernel.org, 
	kw@linux.com, robh@kernel.org, bhelgaas@google.com, jingoohan1@gmail.com, 
	krzk+dt@kernel.org, conor+dt@kernel.org, alim.akhtar@samsung.com, vkoul@kernel.org, 
	kishon@kernel.org, arnd@arndb.de, m.szyprowski@samsung.com, jh80.chung@samsung.com
Subject: Re: [PATCH 06/10] dt-bindings: PCI: Add bindings support for Tesla
 FSD SoC
Message-ID: <20250521-capable-affable-numbat-b0ce84@kuoka>
References: <20250518193152.63476-1-shradha.t@samsung.com>
 <CGME20250518193248epcas5p2543146c715eb249ea6c2ce3c78d03b34@epcas5p2.samsung.com>
 <20250518193152.63476-7-shradha.t@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250518193152.63476-7-shradha.t@samsung.com>

On Mon, May 19, 2025 at 01:01:48AM GMT, Shradha Todi wrote:
> Document the PCIe controller device tree bindings for Tesla FSD
> SoC for both RC and EP.
> 
> Signed-off-by: Shradha Todi <shradha.t@samsung.com>
> ---
>  .../bindings/pci/samsung,exynos-pcie-ep.yaml  |  66 ++++++
>  .../bindings/pci/samsung,exynos-pcie.yaml     | 199 ++++++++++++------
>  2 files changed, 198 insertions(+), 67 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pci/samsung,exynos-pcie-ep.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/samsung,exynos-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/samsung,exynos-pcie-ep.yaml
> new file mode 100644
> index 000000000000..5d4a9067f727
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/samsung,exynos-pcie-ep.yaml

Filename matching compatible.

> @@ -0,0 +1,66 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/samsung,exynos-pcie-ep.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Samsung SoC series PCIe Endpoint Controller
> +
> +maintainers:
> +  - Shradha Todi <shradha.t@samsung.co>
> +
> +description: |+
> +  Samsung SoCs PCIe endpoint controller is based on the Synopsys DesignWare
> +  PCIe IP and thus inherits all the common properties defined in
> +  snps,dw-pcie-ep.yaml.
> +
> +properties:
> +  compatible:
> +    oneOf:

Drop

> +      - enum:
> +          - tesla,fsd-pcie-ep
> +
> +allOf:
> +  - $ref: /schemas/pci/snps,dw-pcie-ep.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - tesla,fsd-pcie-ep

What is the point of this if:? There are no other variants.

Also, missing constraints for all the properties. This is really
incomplete.

> +    then:
> +      properties:
> +        samsung,syscon-pcie:
> +          description: phandle for system control registers, used to
> +                       control signals at system level

Where is the type defined? Look how such properties are described -
there are plenty of examples.

> +
> +      required:
> +        - samsung,syscon-pcie
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/fsd-clk.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    bus {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +        pcieep0: pcie-ep@16a00000 {
> +            compatible = "tesla,fsd-pcie-ep";
> +            reg = <0x0 0x168b0000 0x0 0x1000>,
> +                  <0x0 0x16a00000 0x0 0x2000>,
> +                  <0x0 0x16a01000 0x0 0x80>,
> +                  <0x0 0x17000000 0x0 0xff0000>;
> +            reg-names = "elbi", "dbi", "dbi2", "addr_space";
> +            clocks = <&clock_fsys1 PCIE_LINK0_IPCLKPORT_AUX_ACLK>,
> +                     <&clock_fsys1 PCIE_LINK0_IPCLKPORT_DBI_ACLK>,
> +                     <&clock_fsys1 PCIE_LINK0_IPCLKPORT_MSTR_ACLK>,
> +                     <&clock_fsys1 PCIE_LINK0_IPCLKPORT_SLV_ACLK>;
> +            clock-names = "aux", "dbi", "mstr", "slv";
> +            num-lanes = <4>;
> +            samsung,syscon-pcie = <&sysreg_fsys1 0x50c>;
> +            phys = <&pciephy1>;
> +        };
> +    };
> +...
> diff --git a/Documentation/devicetree/bindings/pci/samsung,exynos-pcie.yaml b/Documentation/devicetree/bindings/pci/samsung,exynos-pcie.yaml
> index f20ed7e709f7..a3803bf0ef84 100644
> --- a/Documentation/devicetree/bindings/pci/samsung,exynos-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/samsung,exynos-pcie.yaml
> @@ -11,78 +11,113 @@ maintainers:
>    - Jaehoon Chung <jh80.chung@samsung.com>
>  
>  description: |+
> -  Exynos5433 SoC PCIe host controller is based on the Synopsys DesignWare
> +  Samsung SoCs PCIe host controller is based on the Synopsys DesignWare
>    PCIe IP and thus inherits all the common properties defined in
>    snps,dw-pcie.yaml.
>  
> -allOf:
> -  - $ref: /schemas/pci/snps,dw-pcie.yaml#
> -
>  properties:
>    compatible:
> -    const: samsung,exynos5433-pcie
> -
> -  reg:
> -    items:
> -      - description: Data Bus Interface (DBI) registers.
> -      - description: External Local Bus interface (ELBI) registers.
> -      - description: PCIe configuration space region.
> -

No, I do not understand any of this change. Properties are defined in
top-level. Why all this is being removed?


Best regards,
Krzysztof


