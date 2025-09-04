Return-Path: <linux-pci+bounces-35459-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D47F8B44230
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 18:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B497163C2E
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 16:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E0A287269;
	Thu,  4 Sep 2025 16:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TOeKKfIP"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092891F4262;
	Thu,  4 Sep 2025 16:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757001963; cv=none; b=sdnVrIZyM13aTnUczeKYtSk+XdqQWNbzKX0n6vsVHbt9X+H5XkasUZf8Q/ftr0A2u62MJ3aipvnXJ80KTEHk14T/5Qbd7ckHRxLHhmsDKQsSCYgTC4G1ZsVM0BvotC/Mf+bD1yKeI+TqA8FoMu6RoEQBexHZ4z90LciWoA8E760=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757001963; c=relaxed/simple;
	bh=d4for+WQoYCCURZaNQO+bUjSv8L423bE+qzlhaNgZ+w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=OS2gcLQgWVUeVA/VGukPvvjJB1HkpTlWF44g8tbWhnu5glPpKFnXH97RAgbYOOv0ktIFBhQ8Hpuxvc/En2bcOTuWOvxOk6uxKGUI4+4Fvwtg9us25sTKVTZeImVXBhEwQMu487Nl5nFGSk6BeyvDhl7BGeBe1UgADLkIWKprg0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TOeKKfIP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E1F6C4CEF0;
	Thu,  4 Sep 2025 16:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757001962;
	bh=d4for+WQoYCCURZaNQO+bUjSv8L423bE+qzlhaNgZ+w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=TOeKKfIPisHwrw2KCfdrPm36Vdx/JsF1wSupeYOSSEq/io9Mtuc/867lhZAqhY5Vr
	 vy8SYOGiUC/YRPg2Y9h/21mmkfwJjREdTWBcpSF67/cx2afwEDX74AcOQnOGZOqReS
	 /ZDm9wSDcY6cjFBkwBfuV2JqvIZAWs9S1jNDrJ49V8Eo1mjK2BveDg3TwoDyIF/CPR
	 KsbOhakBtoIwJsmq3FaSe0WZ1JkjRNv5n2los27EPzLMr2yyPDQhBEPuKobggnCGFJ
	 VxdGEA7CHKf1fjYPAp5Hl2/qF4kyVL1xxmOD9mp820Z2MZOeXtV8Zj22voC1kX7Ozj
	 jVHFWNNCDMixQ==
Date: Thu, 4 Sep 2025 11:06:00 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: zhangsenchuan@eswincomputing.com
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	p.zabel@pengutronix.de, johan+linaro@kernel.org,
	quic_schintav@quicinc.com, shradha.t@samsung.com, cassel@kernel.org,
	thippeswamy.havalige@amd.com, mayank.rana@oss.qualcomm.com,
	inochiama@gmail.com, ningyu@eswincomputing.com,
	linmin@eswincomputing.com, pinkesh.vaghela@einfochips.com
Subject: Re: [PATCH v2 1/2] dt-bindings: PCI: eic7700: Add Eswin eic7700 PCIe
 host controller
Message-ID: <20250904160600.GA1264982@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829082237.1064-1-zhangsenchuan@eswincomputing.com>

On Fri, Aug 29, 2025 at 04:22:37PM +0800, zhangsenchuan@eswincomputing.com wrote:
> From: Senchuan Zhang <zhangsenchuan@eswincomputing.com>
> 
> Add Device Tree binding documentation for the ESWIN EIC7700
> PCIe controller module,the PCIe controller enables the core
> to correctly initialize and manage the PCIe bus and connected
> devices.
> 
> Signed-off-by: Yu Ning <ningyu@eswincomputing.com>
> Signed-off-by: Senchuan Zhang <zhangsenchuan@eswincomputing.com>
> ---
>  .../bindings/pci/eswin,eic7700-pcie.yaml      | 142 ++++++++++++++++++
>  1 file changed, 142 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/eswin,eic7700-pcie.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/eswin,eic7700-pcie.yaml b/Documentation/devicetree/bindings/pci/eswin,eic7700-pcie.yaml
> new file mode 100644
> index 000000000000..65f640902b11
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/eswin,eic7700-pcie.yaml
> @@ -0,0 +1,142 @@
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
> +
> +description:
> +  The PCIe controller on EIC7700 SoC.
> +
> +allOf:
> +  - $ref: /schemas/pci/pci-host-bridge.yaml#
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
> +
> +  ranges:
> +    maxItems: 3
> +
> +  num-lanes:
> +    const: 4
> +
> +  '#interrupt-cells':
> +    const: 1
> +
> +  interrupts:
> +    maxItems: 9
> +
> +  interrupt-names:
> +    items:
> +      - const: msi
> +      - const: inta
> +      - const: intb
> +      - const: intc
> +      - const: intd
> +      - const: inte
> +      - const: intf
> +      - const: intg
> +      - const: inth
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
> +      - const: aux
> +
> +  resets:
> +    maxItems: 3
> +
> +  reset-names:
> +    items:
> +      - const: cfg
> +      - const: powerup
> +      - const: pwren
> +
> +required:
> +  - compatible
> +  - reg
> +  - ranges
> +  - num-lanes
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
> +            ranges = <0x81000000 0x0 0x40800000 0x0 0x40800000 0x0 0x800000>,
> +                     <0x82000000 0x0 0x41000000 0x0 0x41000000 0x0 0xf000000>,
> +                     <0xc3000000 0x80 0x00000000 0x80 0x00000000 0x2 0x00000000>;
> +            bus-range = <0x0 0xff>;
> +            clocks = <&clock 562>,
> +                     <&clock 563>,
> +                     <&clock 564>,
> +                     <&clock 565>;
> +            clock-names = "mstr", "dbi", "pclk", "aux";
> +            resets = <&reset 8 (1 << 0)>,
> +                     <&reset 8 (1 << 1)>,
> +                     <&reset 8 (1 << 2)>;
> +            reset-names = "cfg", "powerup", "pwren";
> +            interrupts = <220>, <179>, <180>, <181>, <182>, <183>, <184>, <185>, <186>;
> +            interrupt-names = "msi", "inta", "intb", "intc", "intd",
> +                              "inte", "intf", "intg", "inth";
> +            interrupt-parent = <&plic>;
> +            interrupt-map-mask = <0x0 0x0 0x0 0x7>;
> +            interrupt-map = <0x0 0x0 0x0 0x1 &plic 179>,
> +                            <0x0 0x0 0x0 0x2 &plic 180>,
> +                            <0x0 0x0 0x0 0x3 &plic 181>,
> +                            <0x0 0x0 0x0 0x4 &plic 182>;
> +            device_type = "pci";
> +            num-lanes = <0x4>;

num-lanes and perst are per-Root Port items.  Please put anything
related specifically to the Root Port in its own stanza to make it
easier to support multiple Root Ports in future versions of the
hardware.

See
https://lore.kernel.org/linux-pci/20250625221653.GA1590146@bhelgaas/
for examples of how to do this.

> +        };
> +    };
> --
> 2.25.1
> 

