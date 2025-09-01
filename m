Return-Path: <linux-pci+bounces-35236-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C360B3D96F
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 08:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA5DC1898FE4
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 06:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8951C84A2;
	Mon,  1 Sep 2025 06:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sK7Mybxc"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E322137C52;
	Mon,  1 Sep 2025 06:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756706700; cv=none; b=q8TjReq+aV9tABnNIJmuU+Ukp+yYxEeyybKpIWlyh8tnP1v3iah8N7vACs2/nBhzvArqHHlr/w3HmEL3TwOthJhDPK3wQLn9NKrQyZ3VQFXnXm7Bqmd9yCMUmlq+JVxkJLpkR8QDPBblFV4n0TVx3sd1sp/+9Qxa/Sz0S1x+Pz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756706700; c=relaxed/simple;
	bh=HW2ZHkXsm0uoCUvmO3U/VArkU7tURowgeKdNZaNGDgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RnGfY+Yb0qKzHXhmQu0cf0Y7O41t/WAh4FAOm286xIHTXMrOYn/8BRCTZru4cDHcl0W3oZQKkkzvaNUqg8+YUqvU+dmX1XkNvRnB2IL5Qi1xAb8Q3iWMarurvXxlbUHzyCN5M+5w97qlFCSP74k2JXs3NNyyo0y7dY53byq+pP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sK7Mybxc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B451C4CEF5;
	Mon,  1 Sep 2025 06:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756706699;
	bh=HW2ZHkXsm0uoCUvmO3U/VArkU7tURowgeKdNZaNGDgI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sK7MybxcgY4jaX7lI1IR2dx9yLu5S1Ac4nw/uV6EDDaJbRqhoqjMLs/mousFsRNo4
	 bUzOdTBmuVeS2oM7HDyst6MrUlvJizoh7N/zwrFy8adrO26PC7GnhQBPM5gGntMgbB
	 iQn4KdLCMNzJ9cSZvciqjB+sTKY9lXMfgwHAyXAlnmcQQiAuvbZSgYD4oVvNBB77RZ
	 u5l+vQoQijnWx1ZkpgmMgqQAWGXswzPwwRbOH+uUHQ0hXSBwY4/6frb7tirFFGqiDL
	 Rh2v2YsA0jPuPlicD8vLJ7xJGM33sJoZMayPRGNFbW7+9icqeMR0yn7R3yGDbc8xal
	 Cv6cGJsmzmRGQ==
Date: Mon, 1 Sep 2025 11:34:50 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: zhangsenchuan@eswincomputing.com
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	p.zabel@pengutronix.de, johan+linaro@kernel.org, quic_schintav@quicinc.com, 
	shradha.t@samsung.com, cassel@kernel.org, thippeswamy.havalige@amd.com, 
	mayank.rana@oss.qualcomm.com, inochiama@gmail.com, ningyu@eswincomputing.com, 
	linmin@eswincomputing.com, pinkesh.vaghela@einfochips.com
Subject: Re: [PATCH v2 1/2] dt-bindings: PCI: eic7700: Add Eswin eic7700 PCIe
 host controller
Message-ID: <nq3xoih7kbjdaxnwoduz3o2nxt2ikahbogqdraibznrlqwqw5r@ovjarka5eagm>
References: <20250829082021.49-1-zhangsenchuan@eswincomputing.com>
 <20250829082237.1064-1-zhangsenchuan@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250829082237.1064-1-zhangsenchuan@eswincomputing.com>

On Fri, Aug 29, 2025 at 04:22:37PM GMT, zhangsenchuan@eswincomputing.com wrote:
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

What? Are these standard INTx or something elese? PCI(e) spec defines only
INT{A-D}.

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

I/O CPU range starts from 0x0

Also, I don't think you need to set the relocatable flag (bit 31) for any
regions.

> +                     <0x82000000 0x0 0x41000000 0x0 0x41000000 0x0 0xf000000>,
> +                     <0xc3000000 0x80 0x00000000 0x80 0x00000000 0x2 0x00000000>;
> +            bus-range = <0x0 0xff>;
> +            clocks = <&clock 562>,
> +                     <&clock 563>,
> +                     <&clock 564>,
> +                     <&clock 565>;

Don't you have clock definitions for these values?

> +            clock-names = "mstr", "dbi", "pclk", "aux";
> +            resets = <&reset 8 (1 << 0)>,
> +                     <&reset 8 (1 << 1)>,
> +                     <&reset 8 (1 << 2)>;

Same here.

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

nit: Most of the bindings define num-lanes as decimal.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

