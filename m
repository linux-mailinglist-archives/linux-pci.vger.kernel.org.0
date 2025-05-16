Return-Path: <linux-pci+bounces-27856-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9B3AB9C4A
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 14:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82C957A4A28
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 12:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CAE323E34F;
	Fri, 16 May 2025 12:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ekulgcqJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52031D6DBB;
	Fri, 16 May 2025 12:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747399102; cv=none; b=BZ/VQuS9lT/G8cijWdV47fsqZrUoig1pVsUPdU15hwNgq4/CAEFKXXFu0za8ij1oW7MnjNRIR6/3jUU6LYoBqogCc4XhBcsAjrS+/9T0H54ttVcdIQkGgw62g+V3h/jik0ILEZHzbpfVjUyzl62iaudr7DYOwIeI8Q+7P7o7Byw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747399102; c=relaxed/simple;
	bh=s5z1AekPq4qsObb+dTMVpSUpw5fhzSeIQtzX/HolejU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WdxVUqBo766j6UWEW53Wfys/xMi8n7k2GvGgsme11uivHMenvB+Hzk/qANrjxSRIW3eC9RbRAffHMjAbAY0m8K5qwbuIRy+f++eLL7rFgeKV24nqy87mnkSVzrTrUixDd2Pn3z46TRsnnbKLXjYOZXBhgbrHuEwkMJmRpQKRkbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ekulgcqJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4850AC4CEE4;
	Fri, 16 May 2025 12:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747399101;
	bh=s5z1AekPq4qsObb+dTMVpSUpw5fhzSeIQtzX/HolejU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ekulgcqJp9SSp6G6qhKSBQ8DmP/QSwy+64RwB7G580O7NzcTV+JfQ494R18yZDi92
	 s18G5hKESUfB4ENNjEuk13dfYpDIdWX74Bei0jkQqwT/2Z1kqNcJgP2ZZl9NSYuFlF
	 iRikhgx71/pr1O2VESUxgY+Y7feGao/7jIH+/3ixC0vupk8wi5zumWXc+hnBiXBclK
	 aDsFcjrnLV38r6Lw+B8lO7AlKpT7DevSS487erygNhvRU3jjUD/VpnnefT3mJden/s
	 InFhoJZox34H9YEPt3Vx2khj3U00uH8ESxjnhTNbUmHa8QulNQFH835m9T7pRSzVsQ
	 c4VusfhvhZQDQ==
Message-ID: <b837abbd-8c93-418c-a0e0-5580d3771191@kernel.org>
Date: Fri, 16 May 2025 14:38:15 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] dt-bindings: PCI: eic7700: Add Eswin eic7700 PCIe
 host controller
To: zhangsenchuan@eswincomputing.com, bhelgaas@google.com,
 lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.or,
 linux-kernel@vger.kernel.org, p.zabel@pengutronix.de,
 johan+linaro@kernel.org, quic_schintav@quicinc.com, shradha.t@samsung.com,
 cassel@kernel.org, thippeswamy.havalige@amd.com
Cc: ningyu@eswincomputing.com, linmin@eswincomputing.com
References: <20250516094057.1300-1-zhangsenchuan@eswincomputing.com>
 <20250516094249.1879-1-zhangsenchuan@eswincomputing.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20250516094249.1879-1-zhangsenchuan@eswincomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/05/2025 11:42, zhangsenchuan@eswincomputing.com wrote:
> From: Senchuan Zhang <zhangsenchuan@eswincomputing.com>
> 
> Add Device Tree binding documentation for the ESWIN EIC7700
> PCIe controller module,the PCIe controller enables the core
> to correctly initialize and manage the PCIe bus and connected
> devices.
> 
> Co-developed-by: Yu Ning <ningyu@eswincomputing.com>
> Signed-off-by: Yu Ning <ningyu@eswincomputing.com>
> Signed-off-by: Senchuan Zhang <zhangsenchuan@eswincomputing.com>
> ---
>  .../bindings/pci/eswin,eic7700-pcie.yaml      | 171 ++++++++++++++++++

<form letter>
Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC. It might happen, that command when run on an older
kernel, gives you outdated entries. Therefore please be sure you base
your patches on recent Linux kernel.

Tools like b4 or scripts/get_maintainer.pl provide you proper list of
people, so fix your workflow. Tools might also fail if you work on some
ancient tree (don't, instead use mainline) or work on fork of kernel
(don't, instead use mainline). Just use b4 and everything should be
fine, although remember about `b4 prep --auto-to-cc` if you added new
patches to the patchset.

You missed at least devicetree list (maybe more), so this won't be
tested by automated tooling. Performing review on untested code might be
a waste of time.

Please kindly resend and include all necessary To/Cc entries.
</form letter>

Limited review follows.

>  1 file changed, 171 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/eswin,eic7700-pcie.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/eswin,eic7700-pcie.yaml b/Documentation/devicetree/bindings/pci/eswin,eic7700-pcie.yaml
> new file mode 100644
> index 000000000000..e1d150c7c81a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/eswin,eic7700-pcie.yaml
> @@ -0,0 +1,171 @@
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
> +description: |

Do not need '|' unless you need to preserve formatting.

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
> +
> +  "#address-cells":
> +    const: 3
> +  "#size-cells":
> +    const: 2
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

Does not match interrupts.

> +
> +  interrupt-controller:
> +    type: object
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
> +    description: handles to clock for the pcie controller.

Drop description, obvious.

> +
> +  clock-names:
> +    items:
> +      - const: pcie_aclk
> +      - const: pcie_cfg_clk
> +      - const: pcie_cr_clk
> +      - const: pcie_aux_clk

Drop all _clk
Drop all pcie_

> +    description: the name of each clock.

Drop description

> +
> +  resets:
> +    description: resets to be used by the controller.
> +
> +  reset-names:
> +    items:
> +      - const: pcie_cfg
> +      - const: pcie_powerup
> +      - const: pcie_pwren

Drop all pcie_

> +    description: names of the resets listed in resets property in the same order.

What did you use as starting point / example?

> +
> +  bus-range:
> +    items:
> +      - const: 0
> +      - const: 0xff
> +
> +  device_type:
> +    const: pci
> +
> +  ranges: true
> +
> +  dma-noncoherent: true
> +
> +  num-lanes:
> +    maximum: 4
> +
> +  numa-node-id:
> +    maximum: 0

This is confusing.

> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - interrupts
> +  - interrupt-names
> +  - interrupt-parent
> +  - interrupt-map-mask
> +  - interrupt-map
> +  - '#address-cells'
> +  - '#size-cells'
> +  - '#interrupt-cells'
> +  - clocks
> +  - clock-names
> +  - resets
> +  - reset-names
> +  - bus-range
> +  - dma-noncoherent
> +  - num-lanes
> +  - ranges
> +  - numa-node-id

Missing ref to pci schemas. Look at other bindings.

> +
> +additionalProperties: false

And then this will be changed as well.

> +
> +examples:
> +  - |
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        pcie: pcie@54000000 {
> +          compatible = "eswin,eic7700-pcie";

Messed indentation. Use 4 spaces for example indentation.

> +          clocks = <&clock 562>,

Wrong property order. Follow DTS coding style.

> +                   <&clock 563>,
> +                   <&clock 564>,
> +                   <&clock 565>;
> +          clock-names = "pcie_aclk", "pcie_cfg_clk", "pcie_cr_clk", "pcie_aux_clk";
> +
> +          reset-names = "pcie_cfg", "pcie_powerup", "pcie_pwren";
> +          resets = <&reset 8 (1 << 0)>,
> +                   <&reset 8 (1 << 1)>,
> +                   <&reset 8 (1 << 2)>;
> +
> +          #address-cells = <3>;
> +          #size-cells = <2>;
> +          #interrupt-cells = <1>;
> +
> +          reg = <0x0 0x54000000 0x0 0x4000000>,
> +                <0x0 0x40000000 0x0 0x800000>,
> +                <0x0 0x50000000 0x0 0x100000>;
> +          reg-names = "dbi", "config", "mgmt";
> +          device_type = "pci";
> +
> +          bus-range = <0x0 0xff>;
> +          ranges = <0x81000000 0x0 0x40800000 0x0 0x40800000 0x0 0x800000>,
> +                  <0x82000000 0x0 0x41000000 0x0 0x41000000 0x0 0xf000000>,
> +                  <0xc3000000 0x80 0x00000000 0x80 0x00000000 0x2 0x00000000>;
> +
> +          num-lanes = <0x4>;
> +          interrupts = <220>, <179>, <180>, <181>, <182>, <183>, <184>, <185>, <186>;
> +          interrupt-names = "msi", "inta", "intb", "intc", "intd";
> +          interrupt-parent = <&plic>;
> +          interrupt-map-mask = <0x0 0x0 0x0 0x7>;
> +          interrupt-map = <0x0 0x0 0x0 0x1 &plic 179>,
> +                          <0x0 0x0 0x0 0x2 &plic 180>,
> +                          <0x0 0x0 0x0 0x3 &plic 181>,
> +                          <0x0 0x0 0x0 0x4 &plic 182>;
> +          status = "disabled";

Drop. Look at other bindings how this is written. There is no binding
with status disabled. It makes just no sense.

> +          numa-node-id = <0>;
> +          dma-noncoherent;
> +        };
> +    };
> --
> 2.25.1
> 


Best regards,
Krzysztof

