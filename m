Return-Path: <linux-pci+bounces-37097-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB287BA4025
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 15:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DE3D621390
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 13:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C6F2FB99F;
	Fri, 26 Sep 2025 13:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V/ZRqGar"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE722FB97E
	for <linux-pci@vger.kernel.org>; Fri, 26 Sep 2025 13:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758894992; cv=none; b=UKyG3//J3hEKwYKZZhuyj208W0lWQani1UyiIjX7JfCaIVO/KdfBdjkabsSDlkZePmWxhvuLdN8jBdS/UVKTCt2lfm4qyjbeFWFSwnXu2CfBWCcltKCu6PARjq08wFR9ty8uzddup1YFS8VHV1ee27e00dIX78cL0l4wWHnHsTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758894992; c=relaxed/simple;
	bh=fnFmx+ig5lobTpxBXaOHgpPg+wwrwW4hzaO99H2eNFo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IoQkuOWL3VBnFeTonYJmw1cJIoGjsp/0LrvgTI7l4z6tVESafcCwUhqJLwu+FPJlw0Og34tInkALlbFnQM6Y1AYeDEPhDoVmC1L9BRLzaGfYdyj098nzjyMZvelX7o6PuguzRleLav0ZOwbgecunc9YPufiiJS8AzzbJnKY1A8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V/ZRqGar; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80D2DC4CEF7
	for <linux-pci@vger.kernel.org>; Fri, 26 Sep 2025 13:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758894992;
	bh=fnFmx+ig5lobTpxBXaOHgpPg+wwrwW4hzaO99H2eNFo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=V/ZRqGarw7YlMYZaOILSSYixS6lH7p6NqDxnDQZotvoVyy/ELD5W9YMuvbShpW8pM
	 KdxExuhqSeesx2jnA7l9fAK5hXaL0IXK+14HuRMt/M33zHIDSBtHt9lMOiyg4FJbSS
	 H/5MW64fH3EwgA0IMh23N2pwOyzUijVNWkj4XWbyxETVpnSWEOBINRyGTYFEJlT2VT
	 fhkqctelyj/hYFWdL59SmlC844kX3WQZnioFTuNInmCEtyqPi45sSdTUzy1ttmmjB6
	 pnY9w7VZVDuMVGP9+fF39i1dXVsI1O084LtFsW84Qp/eCLZbHouhmUl9XQtwf3VjlI
	 8V2497nVgbbAA==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-628f29d68ecso4622089a12.3
        for <linux-pci@vger.kernel.org>; Fri, 26 Sep 2025 06:56:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWejMRdNkX1bB6DNWovU89Ff5OFVH+MKbfHNy6EASUOLDc4/2QrLDekGMHOY0thacFCchxjLF/TP0A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlmYzQFR76GmBKKwBSf99IhCT0P2twMMNurrcn2eoey6Z5Zn0T
	TFXGdO5Rw8040iQFXpiyjE9JazCrLGX5p9PZByM6CAvh2y4JbLxPtzR0kerjAId/evghNmzhrYc
	iXA/JABfc+7fE3bx4dwwaiTdo6LsY8A==
X-Google-Smtp-Source: AGHT+IHeVbmYJ3bMf1bJ3+dbRsHIZF/JSZNoyLliQsfKzibMDRH0Ilnls2P5gXXXNssyIIkoxWg+iETkLY8H1f6OIgk=
X-Received: by 2002:a17:906:dc89:b0:b0d:ff2c:3cd2 with SMTP id
 a640c23a62f3a-b34b74ee790mr936499466b.12.1758894990940; Fri, 26 Sep 2025
 06:56:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926072905.126737-1-linux.amoon@gmail.com> <20250926072905.126737-2-linux.amoon@gmail.com>
In-Reply-To: <20250926072905.126737-2-linux.amoon@gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Fri, 26 Sep 2025 08:56:18 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJr+h7pTvbRR=7eB4ognK70D1pgNXEORGXo=ndND=pMjw@mail.gmail.com>
X-Gm-Features: AS18NWA0TW7TCBuwoHZZyIjBUxLHoOtqfKbpxOYzyWFBbc_WiOpyrZrNwOSeYlE
Message-ID: <CAL_JsqJr+h7pTvbRR=7eB4ognK70D1pgNXEORGXo=ndND=pMjw@mail.gmail.com>
Subject: Re: [PATCH v1 1/5] dt-bindings: PCI: Convert the existing
 nvidia,tegra-pcie.txt bindings documentation into a YAML schema
To: Anand Moon <linux.amoon@gmail.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	"open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" <linux-pci@vger.kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, 
	"open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 2:29=E2=80=AFAM Anand Moon <linux.amoon@gmail.com> =
wrote:
>
> Convert the legacy text-based binding documentation for
> nvidia,tegra-pcie into a nvidia,tegra-pcie.yaml YAML schema, following

s/YAML/DT/

> the Devicetree Schema format. This improves validation coverage and enabl=
es
> dtbs_check compliance for Tegra PCIe nodes.

Your subject needs some work too. 'existing' and 'bindings
documentation' are redundant.

>
> Cc: Jon Hunter <jonathanh@nvidia.com>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> v1: new patch in this series.
> ---
>  .../bindings/pci/nvidia,tegra-pcie.yaml       | 651 +++++++++++++++++
>  .../bindings/pci/nvidia,tegra20-pcie.txt      | 670 ------------------
>  2 files changed, 651 insertions(+), 670 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pci/nvidia,tegra-pc=
ie.yaml
>  delete mode 100644 Documentation/devicetree/bindings/pci/nvidia,tegra20-=
pcie.txt
>
> diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra-pcie.yaml=
 b/Documentation/devicetree/bindings/pci/nvidia,tegra-pcie.yaml
> new file mode 100644
> index 000000000000..dd8cba125b53
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/nvidia,tegra-pcie.yaml
> @@ -0,0 +1,651 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/nvidia,tegra-pcie.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NVIDIA Tegra PCIe Controller
> +
> +maintainers:
> +  - Thierry Reding <thierry.reding@gmail.com>
> +  - Jon Hunter <jonathanh@nvidia.com>
> +
> +description: |

Don't need '|'.

> +  PCIe controller found on NVIDIA Tegra SoCs including Tgra20, Tegra30,
> +  Tegra124, Tegra210, and Tegra186. Supports multiple root ports and
> +  platform-specific clock, reset, and power supply configurations.

I would suggest not listing every SoC here unless the list is not going to =
grow.

> +
> +properties:
> +  compatible:
> +    oneOf:

Only 1 entry here, don't need 'oneOf'.

> +      - items:
> +          - enum:
> +              - nvidia,tegra20-pcie
> +              - nvidia,tegra30-pcie
> +              - nvidia,tegra124-pcie
> +              - nvidia,tegra210-pcie
> +              - nvidia,tegra186-pcie
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
> +  device_type:
> +    const: pci

Drop. This is covered by pci-host-bridge.yaml.

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
> +    oneOf:
> +      - items:
> +          - description: PCIe clock
> +          - description: AFI clock
> +          - description: PLL_E clock

Drop this list and add 'minItems: 3'

> +      - items:
> +          - description: PCIe clock
> +          - description: AFI clock
> +          - description: PLL_E clock
> +          - description: CML clock
> +
> +  clock-names:
> +    oneOf:
> +      - items:
> +          - const: pex
> +          - const: afi
> +          - const: pll_e

Same here.

> +      - items:
> +          - const: pex
> +          - const: afi
> +          - const: pll_e
> +          - const: cml
> +
> +  resets:
> +    items:
> +      - description: PCIe reset
> +      - description: AFI reset
> +      - description: PCIe X reset
> +
> +  reset-names:
> +    items:
> +      - const: pex
> +      - const: afi
> +      - const: pcie_x
> +
> +  power-domains:
> +    maxItems: 1
> +    description: |
> +      A phandle to the node that controls power to the respective PCIe
> +      controller and a specifier name for the PCIe controller.

Don't need generic descriptions of common properties. Drop.

> +
> +  interconnects:
> +    minItems: 1
> +    maxItems: 2
> +
> +  interconnect-names:
> +    minItems: 1
> +    maxItems: 2
> +    description:
> +      Should include name of the interconnect path for each interconnect
> +      entry. Consult TRM documentation for information about available
> +      memory clients, see DMA CONTROLLER and MEMORY WRITE sections.

You have to document what the names are.

> +
> +  pinctrl-names:
> +    items:
> +      - const: default
> +      - const: idle
> +
> +  pinctrl-0:
> +    $ref: /schemas/types.yaml#/definitions/phandle

This already has a type. Just 'pinctrl-0: true' is enough.

> +
> +  pinctrl-1:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +
> +  nvidia,num-lanes:
> +    description: Number of PCIe lanes used
> +    $ref: /schemas/types.yaml#/definitions/uint32

The examples show this in child nodes.

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
> +          minItems: 3

3 is already the min, so drop.

> +          maxItems: 3
> +        clock-names:
> +          items:
> +            - const: pex
> +            - const: afi
> +            - const: pll_e

Names are already defined, so just 'maxItems: 3'

Same comments apply to the rest...

> +        resets:
> +          minItems: 3
> +          maxItems: 3
> +        reset-names:
> +          items:
> +            - const: pex
> +            - const: afi
> +            - const: pcie_x
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
> +          minItems: 4
> +          maxItems: 4

Just 'minItems' here.

> +        clock-names:
> +          items:
> +            - const: pex
> +            - const: afi
> +            - const: pll_e
> +            - const: cml

And here...

> +        resets:
> +          minItems: 3
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
> +              - nvidia,tegra186-pcie
> +    then:
> +      required:
> +        - power-domains
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
> +  - ranges

Already required by pci-host-bridge.yaml.

> +  - bus-range

Generally, bus-range is only required when there's some h/w issue.

> +  - device_type

Already required by pci-host-bridge.yaml.

> +  - interconnects
> +  - pinctrl-names

Above you said this was conditional.

> +  - nvidia,num-lanes
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    bus {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <1>;
> +
> +        pcie@80003000 {
> +            compatible =3D "nvidia,tegra20-pcie";
> +            device_type =3D "pci";
> +            reg =3D <0x80003000 0x00000800>,
> +                  <0x80003800 0x00000200>,
> +                  <0x90000000 0x10000000>;
> +            reg-names =3D "pads", "afi", "cs";
> +            interrupts =3D <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>;
> +            interrupt-names =3D "intr", "msi";
> +            interrupt-parent =3D <&intc>;
> +
> +            #interrupt-cells =3D <1>;
> +            interrupt-map-mask =3D <0 0 0 0>;
> +            interrupt-map =3D <0 0 0 0 &intc GIC_SPI 98 IRQ_TYPE_LEVEL_H=
IGH>;
> +
> +            bus-range =3D <0x00 0xff>;
> +            #address-cells =3D <3>;
> +            #size-cells =3D <2>;
> +
> +            ranges =3D <0x02000000 0 0x80000000 0x80000000 0 0x00001000>=
,
> +                     <0x02000000 0 0x80001000 0x80001000 0 0x00001000>,
> +                     <0x01000000 0 0          0x82000000 0 0x00010000>,
> +                     <0x02000000 0 0xa0000000 0xa0000000 0 0x08000000>,
> +                     <0x42000000 0 0xa8000000 0xa8000000 0 0x18000000>;
> +
> +            clocks =3D <&tegra_car 70>,
> +                     <&tegra_car 72>,
> +                     <&tegra_car 118>;
> +            clock-names =3D "pex", "afi", "pll_e";
> +            resets =3D <&tegra_car 70>,
> +                     <&tegra_car 72>,
> +                     <&tegra_car 74>;
> +            reset-names =3D "pex", "afi", "pcie_x";
> +            power-domains =3D <&pd_core>;
> +            operating-points-v2 =3D <&pcie_dvfs_opp_table>;
> +
> +            status =3D "disabled";

Examples must be enabled.

> +
> +            pci@1,0 {
> +                device_type =3D "pci";
> +                assigned-addresses =3D <0x82000800 0 0x80000000 0 0x1000=
>;
> +                reg =3D <0x000800 0 0 0 0>;
> +                bus-range =3D <0x00 0xff>;
> +                status =3D "disabled";
> +
> +                #address-cells =3D <3>;
> +                #size-cells =3D <2>;
> +                ranges;
> +
> +                nvidia,num-lanes =3D <2>;

This doesn't match the schema.

> +            };
> +
> +            pci@2,0 {
> +                device_type =3D "pci";
> +                assigned-addresses =3D <0x82001000 0 0x80001000 0 0x1000=
>;
> +                reg =3D <0x001000 0 0 0 0>;
> +                bus-range =3D <0x00 0xff>;
> +                status =3D "disabled";
> +
> +                #address-cells =3D <3>;
> +                #size-cells =3D <2>;
> +                ranges;
> +
> +                nvidia,num-lanes =3D <2>;
> +            };
> +        };
> +    };
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    bus {

I don't think we need 4 examples.

Rob

