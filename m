Return-Path: <linux-pci+bounces-43097-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A5BCC1051
	for <lists+linux-pci@lfdr.de>; Tue, 16 Dec 2025 06:38:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 089A23003107
	for <lists+linux-pci@lfdr.de>; Tue, 16 Dec 2025 05:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77539334385;
	Tue, 16 Dec 2025 05:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q8+UOjOM"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FD231A062;
	Tue, 16 Dec 2025 05:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765863503; cv=none; b=RZLFnOfBv7+aST3O4fhx0xEfZ41IUG+y2hAhBn2pqZgYnz+ZGMj9eIVUU0l2dTgnzCPPQErzqs1Mo4mlvW0mb4BISm8JMdQoN+OvruZRqA7gY67Tc5adRngwaNQX9fqL8LgZC14q+xRDX20HeLYf7zjUDuLGJda/J+bCJxnyM1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765863503; c=relaxed/simple;
	bh=F1buwvya74gGcON3baCLsfaqXJ9X4agSHABt0ErTkyc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fHvWX5gtnHmCnEJpZc6OEhgRlsns4BiiM16YqF1zQdj9k9kmVapcwmQkSeKKRwReesSI6v3slwqIfim9j5Pws0MqXXvfOx/ie74E/NRmMGCXJLsZd0cF7o6Iv0iT9EY7Uxv34wkrxQJtaMiyR9zPHrPbr9iCb5XEISVJd1eNbos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q8+UOjOM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7109FC4CEF1;
	Tue, 16 Dec 2025 05:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765863502;
	bh=F1buwvya74gGcON3baCLsfaqXJ9X4agSHABt0ErTkyc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Q8+UOjOMviWKQySD2609A3EaLLsPu3xHaCZpJvdXMkWVpJcjY091MjBjBn+wr6sAl
	 m6o8vAWpNLz4XQq5VjrYqwhdGw3ewIjnS58zRryfC4b3OKQv6v47lRN9Zh5JNby0AR
	 69Gbba/5ZjKHONSqo0xiCHQyu798APjnHSEU3VBkz+u2j88HlC3tTc5IxabIyfddwA
	 TiM5oUZn5EQFqFkf4k3s7hzbunxUG5QJCeHPRmvMSGGkBwTJalh5SRDrxj9eimhrgT
	 szwyKiJruekRDEC6ZMsd8dD1pwGE7JxF/jL3rmU40rHMzLVjdH72eyt8MjFa8lW5RG
	 uvpAirlfStscw==
Message-ID: <3cd7943c-4d35-4ec9-8826-c20a5d213626@kernel.org>
Date: Tue, 16 Dec 2025 06:38:17 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] dt-bindings: PCI: Convert nvidia,tegra-pcie to DT
 schema
To: Anand Moon <linux.amoon@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
Cc: Mikko Perttunen <mperttunen@nvidia.com>
References: <20251215141603.6749-1-linux.amoon@gmail.com>
 <20251215141603.6749-2-linux.amoon@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20251215141603.6749-2-linux.amoon@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/12/2025 15:15, Anand Moon wrote:
> Convert the existing text-based DT bindings documentation for the
> NVIDIA Tegra PCIe host controller to a DT schema format.

You dropped several properties from the original schema without
explanation. That's a no-go. I don't see any reason of doing that, but
if you find such reason you must clearly document any change done to the
binding with reasoning.

I won't be doing extensive review of your code, because you are known of
wasting my time, thus only few nits further.

> 
> Cc: Jon Hunter <jonathanh@nvidia.com>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> v2: Tried to address the isssue Rob pointed
> [1] https://lkml.org/lkml/2025/9/26/704
> improve the $suject and commit message
> drop few examples only nvidia,tegra20-pcie and nvidia,tegra210-pcie
> 
> $ make dt_binding_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/pci/nvidia,tegra-pcie.yaml
> ---
>  .../bindings/pci/nvidia,tegra-pcie.yaml       | 380 ++++++++++
>  .../bindings/pci/nvidia,tegra20-pcie.txt      | 670 ------------------
>  2 files changed, 380 insertions(+), 670 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pci/nvidia,tegra-pcie.yaml
>  delete mode 100644 Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
> 
> diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra-pcie.yaml b/Documentation/devicetree/bindings/pci/nvidia,tegra-pcie.yaml
> new file mode 100644
> index 000000000000..e542adfe37b4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/nvidia,tegra-pcie.yaml
> @@ -0,0 +1,380 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/nvidia,tegra-pcie.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NVIDIA Tegra PCIe Controller
> +
> +maintainers:
> +  - Jon Hunter <jonathanh@nvidia.com>
> +  - Thierry Reding <treding@nvidia.com>
> +
> +description:
> +  PCIe controller found on NVIDIA Tegra SoCs which supports multiple
> +  root ports and platform-specific clock, reset, and power supply
> +  configurations.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - nvidia,tegra20-pcie
> +      - nvidia,tegra30-pcie
> +      - nvidia,tegra124-pcie
> +      - nvidia,tegra210-pcie
> +      - nvidia,tegra186-pcie
> +
> +  reg:
> +    items:
> +      - description: PADS registers
> +      - description: AFI registers
> +      - description: Configuration space region
> +
> +  reg-names:
> +    items:
> +      - const: pads
> +      - const: afi
> +      - const: cs
> +
> +  interrupts:
> +    items:
> +      - description: Controller interrupt
> +      - description: MSI interrupt
> +
> +  interrupt-names:
> +    items:
> +      - const: intr
> +      - const: msi
> +
> +  clocks:
> +    minItems: 3
> +    items:
> +      - description: PCIe clock
> +      - description: AFI clock
> +      - description: PLL_E clock
> +      - description: Optional CML clock
> +
> +  clock-names:
> +    description: Names of clocks used by the PCIe controller
> +    minItems: 3
> +    items:
> +      - const: pex
> +      - const: afi
> +      - const: pll_e
> +      - const: cml
> +
> +  resets:
> +    items:
> +      - description: PCIe reset
> +      - description: AFI reset
> +      - description: PCIe-X reset
> +
> +  reset-names:
> +    items:
> +      - const: pex
> +      - const: afi
> +      - const: pcie_x
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  interconnects:
> +    minItems: 1
> +    maxItems: 2

This does not match the interconnect-names.

> +
> +  interconnect-names:
> +    items:
> +      - const: dma-mem
> +      - const: write
> +
> +  pinctrl-names:
> +    items:
> +      - const: default
> +      - const: idle
> +
> +  pinctrl-0: true
> +  pinctrl-1: true
> +
> +  operating-points-v2:
> +    description:
> +      Should contain freqs and voltages and opp-supported-hw property, which
> +      is a bitfield indicating SoC speedo ID mask.

Look at other bindings how this field is described.

> +
> +patternProperties:
> +  "^pci@[0-9a-f]+(,[0-9a-f]+)?$":
> +    type: object
> +    allOf:
> +      - $ref: /schemas/pci/pci-pci-bridge.yaml#
> +
> +    properties:
> +      reg:
> +        maxItems: 1
> +
> +      nvidia,num-lanes:
> +        description: Number of lanes used by this PCIe port
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        enum:
> +          - 1
> +          - 2
> +          - 4
> +
> +    required:
> +      - nvidia,num-lanes
> +
> +    unevaluatedProperties: false
> +
> +allOf:
> +  - $ref: /schemas/pci/pci-host-bridge.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - nvidia,tegra20-pcie
> +              - nvidia,tegra186-pcie
> +    then:
> +      properties:
> +        clocks:
> +          maxItems: 3
> +        clock-names:
> +          items:
> +            - const: pex
> +            - const: afi
> +            - const: pll_e
> +        resets:
> +          maxItems: 3
> +        reset-names:
> +          items:
> +            - const: pex
> +            - const: afi
> +            - const: pcie_x

Blank line

> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - nvidia,tegra30-pcie
> +              - nvidia,tegra124-pcie
> +              - nvidia,tegra210-pcie
> +    then:
> +      properties:
> +        clocks:
> +          maxItems: 4
> +        clock-names:
> +          items:
> +            - const: pex
> +            - const: afi
> +            - const: pll_e
> +            - const: cml
> +        resets:
> +          maxItems: 3
> +        reset-names:
> +          items:
> +            - const: pex
> +            - const: afi
> +            - const: pcie_x
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - nvidia,tegra20-pcie
> +              - nvidia,tegra30-pcie
> +    then:
> +      required:
> +        - power-domains
> +        - operating-points-v2
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - nvidia,tegra186-pcie
> +    then:
> +      required:
> +        - interconnects
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - nvidia,tegra210-pcie
> +    then:
> +      required:
> +        - pinctrl-names
> +        - pinctrl-0
> +        - pinctrl-1
> +
> +unevaluatedProperties: false

This goes after required.

> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - clocks
> +  - clock-names
> +  - resets
> +  - reset-names
> +  - interrupts
> +  - interrupt-map
> +  - interrupt-map-mask
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    bus {
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +
> +        pcie@80003000 {
> +            compatible = "nvidia,tegra20-pcie";
> +            device_type = "pci";
> +            reg = <0x80003000 0x00000800>,
> +                  <0x80003800 0x00000200>,
> +                  <0x90000000 0x10000000>;
> +            reg-names = "pads", "afi", "cs";
> +            interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>;
> +            interrupt-names = "intr", "msi";
> +            interrupt-parent = <&intc>;
> +
> +            #interrupt-cells = <1>;
> +            interrupt-map-mask = <0 0 0 0>;
> +            interrupt-map = <0 0 0 0 &intc GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
> +
> +            bus-range = <0x00 0xff>;
> +            #address-cells = <3>;
> +            #size-cells = <2>;
> +
> +            ranges = <0x02000000 0 0x80000000 0x80000000 0 0x00001000>,
> +                     <0x02000000 0 0x80001000 0x80001000 0 0x00001000>,
> +                     <0x01000000 0 0          0x82000000 0 0x00010000>,
> +                     <0x02000000 0 0xa0000000 0xa0000000 0 0x08000000>,
> +                     <0x42000000 0 0xa8000000 0xa8000000 0 0x18000000>;
> +
> +            clocks = <&tegra_car 70>,
> +                     <&tegra_car 72>,
> +                     <&tegra_car 118>;
> +            clock-names = "pex", "afi", "pll_e";
> +            resets = <&tegra_car 70>,
> +                     <&tegra_car 72>,
> +                     <&tegra_car 74>;
> +            reset-names = "pex", "afi", "pcie_x";
> +            power-domains = <&pd_core>;
> +            operating-points-v2 = <&pcie_dvfs_opp_table>;
> +
> +            status = "okay";

No statuses in the example. Please look at other files to see how this
should be written.


Best regards,
Krzysztof

