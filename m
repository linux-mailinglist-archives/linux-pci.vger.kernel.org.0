Return-Path: <linux-pci+bounces-40087-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5381BC2AA0A
	for <lists+linux-pci@lfdr.de>; Mon, 03 Nov 2025 09:48:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 993E0188AF7F
	for <lists+linux-pci@lfdr.de>; Mon,  3 Nov 2025 08:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90BCE2DFA32;
	Mon,  3 Nov 2025 08:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I+gV+Dyo"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6125122FDFF;
	Mon,  3 Nov 2025 08:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762159687; cv=none; b=EuMjv+wFB+g6m/VAr41aVtfDu3G1rTneDVP5aNXBvf280bTv6Bg6zAzTS8LPTtlk3JglOEpQrVBSSNXQGCTlF3NTIHRc+CN99Mw5+mCnlus3z70HRTJ6KwrkOjoIH313EMkkUSDD5NawNqJrqJ3KNiLpqJrYAk/1Kgc8YMZqxUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762159687; c=relaxed/simple;
	bh=kSK87Lz187SvEv/ezIlPUnK48XBpFCoU39V9dwZOIyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SEyW3E/iPyGWVlz3aVOKdhiLtPIFAW2852BbVHB1MeGAoX5gQgRx19kqsA7SVyASzeZKYHcofoT6LKToDXNyiKgd7wVmqgu6Hz1eI62dBV4aSHRAdchWXJHmZ+WsoCGCK0SmovcGqANbRyEsweGdg1LZZVL4184lmUCEsVvEvBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I+gV+Dyo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A97FC4CEE7;
	Mon,  3 Nov 2025 08:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762159684;
	bh=kSK87Lz187SvEv/ezIlPUnK48XBpFCoU39V9dwZOIyk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I+gV+DyoFI5X6a/znFETi5APlRLYHVCEylajtMPu7Bv2+/yLCx842AhbEGS8QxMmw
	 pROVlJ4PoF3+zuGhZzvLR6z3igjVndq3DaGDy0Aef8tmEEULTpVkMlLL38q7nmfXXa
	 6n9d3wJnnLEKl9j6xVZJ/ttW9mbHoIma9T8GCYCIBqk86/qGS9r0BY/aBLJM9SwK3F
	 0VVO2aVdRbmUpo9w4Wg0Tgh1S4YUoh5FAJyGml+5jpSZWg9I5guTAAzidNoNcpBial
	 VdJNtrZ7sYQ3ZCfhQLngyGQ0ok2I2uzU4/5ipwo7Aj5kAHuHO0tGw9ombCqao+476g
	 F43LRc2NbGdPA==
Date: Mon, 3 Nov 2025 09:48:02 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: zhangsenchuan@eswincomputing.com
Cc: bhelgaas@google.com, mani@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, 
	p.zabel@pengutronix.de, jingoohan1@gmail.com, gustavo.pimentel@synopsys.com, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	christian.bruel@foss.st.com, mayank.rana@oss.qualcomm.com, shradha.t@samsung.com, 
	krishna.chundru@oss.qualcomm.com, thippeswamy.havalige@amd.com, inochiama@gmail.com, 
	ningyu@eswincomputing.com, linmin@eswincomputing.com, pinkesh.vaghela@einfochips.com, 
	ouyanghui@eswincomputing.com
Subject: Re: [PATCH v4 1/2] dt-bindings: PCI: EIC7700: Add Eswin PCIe host
 controller
Message-ID: <20251103-gentle-precise-bloodhound-ef7136@kuoka>
References: <20251030082900.1304-1-zhangsenchuan@eswincomputing.com>
 <20251030083057.1324-1-zhangsenchuan@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251030083057.1324-1-zhangsenchuan@eswincomputing.com>

On Thu, Oct 30, 2025 at 04:30:57PM +0800, zhangsenchuan@eswincomputing.com wrote:
> From: Senchuan Zhang <zhangsenchuan@eswincomputing.com>
> 
> Add Device Tree binding documentation for the Eswin EIC7700 PCIe
> controller module, the PCIe controller enables the core to correctly
> initialize and manage the PCIe bus and connected devices.
> 
> Signed-off-by: Yu Ning <ningyu@eswincomputing.com>
> Signed-off-by: Yanghui Ou <ouyanghui@eswincomputing.com>
> Signed-off-by: Senchuan Zhang <zhangsenchuan@eswincomputing.com>
> ---
>  .../bindings/pci/eswin,eic7700-pcie.yaml      | 166 ++++++++++++++++++
>  .../bindings/pci/snps,dw-pcie-common.yaml     |   2 +-
>  2 files changed, 167 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/pci/eswin,eic7700-pcie.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/eswin,eic7700-pcie.yaml b/Documentation/devicetree/bindings/pci/eswin,eic7700-pcie.yaml
> new file mode 100644
> index 000000000000..e6c05e3a093a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/eswin,eic7700-pcie.yaml
> @@ -0,0 +1,166 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/eswin,eic7700-pcie.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Eswin EIC7700 PCIe host controller
> +
> +maintainers:
> +  - Yu Ning <ningyu@eswincomputing.com>
> +  - Senchuan Zhang <zhangsenchuan@eswincomputing.com>
> +  - Yanghui Ou <ouyanghui@eswincomputing.com>
> +
> +description:
> +  The PCIe controller on EIC7700 SoC.
> +
> +properties:
> +  compatible:
> +    const: eswin,eic7700-pcie
> +
> +  reg:
> +    maxItems: 3
> +
> +  reg-names:
> +    items:
> +      - const: dbi
> +      - const: config
> +      - const: mgmt

That's deprecated. Read its description. That's just elbi.

> +
> +  ranges:
> +    maxItems: 3
> +
> +  '#interrupt-cells':
> +    const: 1
> +
> +  interrupt-names:
> +    items:
> +      - const: msi
> +      - const: inta
> +      - const: intb
> +      - const: intc
> +      - const: intd

Thse are legacy signals. Why are you using legacy?

> +
> +  interrupt-map:
> +    maxItems: 4
> +
> +  interrupt-map-mask:
> +    items:
> +      - const: 0
> +      - const: 0
> +      - const: 0
> +      - const: 7
> +
> +  clocks:
> +    maxItems: 4
> +
> +  clock-names:
> +    items:
> +      - const: mstr
> +      - const: dbi
> +      - const: pclk

Deprecated name.

> +      - const: aux
> +
> +  resets:
> +    maxItems: 2
> +
> +  reset-names:
> +    items:
> +      - const: dbi
> +      - const: powerup

No such name.

> +
> +patternProperties:
> +  "^pcie@":
> +    type: object
> +    $ref: /schemas/pci/pci-pci-bridge.yaml#
> +
> +    properties:
> +      reg:
> +        maxItems: 1
> +
> +      num-lanes:
> +        maximum: 4
> +
> +      resets:
> +        maxItems: 1
> +
> +      reset-names:
> +        items:
> +          - const: perst
> +
> +    required:
> +      - reg
> +      - ranges
> +      - num-lanes
> +      - resets
> +      - reset-names
> +
> +    unevaluatedProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - ranges
> +  - interrupts
> +  - interrupt-names
> +  - interrupt-map-mask
> +  - interrupt-map
> +  - '#interrupt-cells'
> +  - clocks
> +  - clock-names
> +  - resets
> +  - reset-names
> +
> +allOf:
> +  - $ref: /schemas/pci/snps,dw-pcie.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        pcie@54000000 {
> +            compatible = "eswin,eic7700-pcie";
> +            reg = <0x0 0x54000000 0x0 0x4000000>,
> +                  <0x0 0x40000000 0x0 0x800000>,
> +                  <0x0 0x50000000 0x0 0x100000>;
> +            reg-names = "dbi", "config", "mgmt";
> +            #address-cells = <3>;
> +            #size-cells = <2>;
> +            #interrupt-cells = <1>;
> +            ranges = <0x01000000 0x0 0x40800000 0x0 0x40800000 0x0 0x800000>,
> +                     <0x02000000 0x0 0x41000000 0x0 0x41000000 0x0 0xf000000>,
> +                     <0x43000000 0x80 0x00000000 0x80 0x00000000 0x2 0x00000000>;
> +            bus-range = <0x00 0xff>;
> +            clocks = <&clock 144>,
> +                     <&clock 145>,
> +                     <&clock 146>,
> +                     <&clock 147>;
> +            clock-names = "mstr", "dbi", "pclk", "aux";
> +            resets = <&reset 97>,
> +                     <&reset 98>;
> +            reset-names = "dbi", "powerup";
> +            interrupts = <220>, <179>, <180>, <181>, <182>, <183>, <184>, <185>, <186>;
> +            interrupt-names = "msi", "inta", "intb", "intc", "intd";
> +            interrupt-parent = <&plic>;
> +            interrupt-map-mask = <0x0 0x0 0x0 0x7>;
> +            interrupt-map = <0x0 0x0 0x0 0x1 &plic 179>,
> +                            <0x0 0x0 0x0 0x2 &plic 180>,
> +                            <0x0 0x0 0x0 0x3 &plic 181>,
> +                            <0x0 0x0 0x0 0x4 &plic 182>;
> +            device_type = "pci";
> +            pcie@0 {
> +                reg = <0x0 0x0 0x0 0x0 0x0>;
> +                #address-cells = <3>;
> +                #size-cells = <2>;
> +                ranges;
> +                device_type = "pci";
> +                num-lanes = <4>;
> +                resets = <&reset 99>;
> +                reset-names = "perst";
> +            };
> +        };
> +    };
> diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
> index 34594972d8db..cff52d0026b0 100644
> --- a/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
> +++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
> @@ -176,7 +176,7 @@ properties:
>              - description: See native 'phy' reset for details
>                enum: [ pciephy, link ]
>              - description: See native 'pwr' reset for details
> -              enum: [ turnoff ]
> +              enum: [ turnoff, powerup ]

NAK, you cannot add more deprecated names. Do you understand what
deprecated/legacy mean?


Best regards,
Krzysztof


