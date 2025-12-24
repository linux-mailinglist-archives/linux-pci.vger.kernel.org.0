Return-Path: <linux-pci+bounces-43658-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 155E0CDC3F3
	for <lists+linux-pci@lfdr.de>; Wed, 24 Dec 2025 13:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 008C1305F305
	for <lists+linux-pci@lfdr.de>; Wed, 24 Dec 2025 12:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CADFC3191AC;
	Wed, 24 Dec 2025 12:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N3UkfxXB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD052F3614
	for <linux-pci@vger.kernel.org>; Wed, 24 Dec 2025 12:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766580091; cv=none; b=nKdlWJU7PxohfPSGT/+r2E4DvlAX3kNbEZCGMlwbC7Jlnc7h5jQfEBhHTHxHQb7P5kxezoox3QXTl2dLNjyh6ij1Bf/0nOT3yjDbLG7AUi5idoC3TS1dlwzLr/dU6rVObcbQ7p8q5rlAWf59jgNj8FO3iQOGzAOJRnE5yNCMK8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766580091; c=relaxed/simple;
	bh=zp9SNrsiDP2rnwAtZED37zEHUggE4bbgtXo1JQ91UDc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nrV/RZ9SQKsRoLWFsfVO1KbAoZ/Gvbk9ZKqagN+R3Sn1zzMQG9Wg+hEF6qk6SDckox+COUJh9ANFh2fZC0k/TqmvzomJsfq45EueCld56j0ScoJoL2hIVHxX3YhlwUEiw/g6KJQJVXT9Cne2cHUW9IS6SzNrnxDjfmFbHInmzBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N3UkfxXB; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-64b92abe63aso8711162a12.0
        for <linux-pci@vger.kernel.org>; Wed, 24 Dec 2025 04:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766580087; x=1767184887; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=h57EtuIujQLC/3TT8y/U1ZZGUxIm0DnoUqvIlTL5TPQ=;
        b=N3UkfxXBl/DdrdADJiZprq9n0Ga5w9BiywqSvdR2HAIFJsYF2ntjgKI0uCtrDqOmOO
         wkt4Dafy7cpcvrzBMmzBkO1ahLjKqVtLvY3TA8w1TDnytmSNqIgk5UzSTyxc4iAPu+pY
         le9/WnwR+54CBqGvhe3lrvaXxpvrtgwCC0f6nzX1twQZo93Au8oUYLsVztGcGdQ8X5/w
         zo+jOHS4gNVsNn+Q01Y7AoLNEXKhs0qt/db4Y6HIdZlS8LtMJ/huVlW2cEwat8LZdbUe
         yfSCEkWC5GLKmdKo1dVbsaa15FL19m+MXGBP8GvgPsYNqv5lguHIRyytcbxa3hHsE/vb
         e4OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766580087; x=1767184887;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h57EtuIujQLC/3TT8y/U1ZZGUxIm0DnoUqvIlTL5TPQ=;
        b=sh11yeoTvw441tSgJVJRrX6RdQopiKxQiacxITJTgkIg8xx7/BJb36JoahbCDYFrDs
         nhzwFoCl494fbRWU2qTag+Fj0vxVEthTl5bMdveuYr8d1coZd6nGsjiQ29+ryZJSCIKo
         REKsdX0JLOvWCW8m+ojKffgQHzwb/VAZIQMUR17aIGBxwJw+R2CF8qnzcetalVW/rPKF
         MoLnkZFgVvvZJNrWzYyPbYr3TQyG6GuuAWCTxOjx/W2aLxuFHkdVhRJjAS7jDcMLmsI5
         +DnPv1KFoP6N9ujNZfILvwb8g5EhuqvkAf5lFZtXxYF5Ld5WXplzL9vqb1GgLNf26JKe
         q0Pg==
X-Forwarded-Encrypted: i=1; AJvYcCXBJ6rzUNwSCi+hcQaURliVOvepZRUcqT0mQ0q++A+lwCvI2IIBmk4NhFeVscHUNTMrL0Sjuh7cNfo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTK3p4d3hadZgfcaaM6dO6zEZfQ654kisR3WelpYAteg9XX4L/
	V46lscvloqj2d0mHRuiy9UiVoot+z1ynuyzzqNo1oeegFbE5xmq5TL1n+Wc4ado5vBiMMSRPTLY
	gBUQV0J9WjcLOGAoJcY8UuIFFz+sYqUE=
X-Gm-Gg: AY/fxX50upp+sS4ZJfsD/WU3tBMY8jlMnbhJUql4I45uiFk/8RDT52bBLtD1C8gVDfb
	GPGdwXc4lx3/tn/+zWEBdhjJeoWNl5RhlBb8zZJAUeGSDMO8VGvQ32US5eU1U+GWH1UTHlywoTO
	NOsug+x3+q8G87zhm0tXaUrztdA0bNNbB8WjlhTHpOKmkwrr/Bzo7jnJBCO+04GgixItYq20Z3d
	kydvDygPEG/PEm0AneLqpxHldODCjW5xTb7LMjP72UgX5+YZpBziSf7vBRLeqaXumk=
X-Google-Smtp-Source: AGHT+IGx/yn+/T8zHK48RzMg6PbmkWkp9LVZgl1ZiDszFLj3UTka2lUfIBhT+pc6jA9HDZNTesdwpa66VP5inrXbWLE=
X-Received: by 2002:a05:6402:13d6:b0:64d:521e:15f8 with SMTP id
 4fb4d7f45d1cf-64d521e19c7mr9754216a12.10.1766580086910; Wed, 24 Dec 2025
 04:41:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251215141603.6749-1-linux.amoon@gmail.com> <20251215141603.6749-2-linux.amoon@gmail.com>
 <3cd7943c-4d35-4ec9-8826-c20a5d213626@kernel.org>
In-Reply-To: <3cd7943c-4d35-4ec9-8826-c20a5d213626@kernel.org>
From: Anand Moon <linux.amoon@gmail.com>
Date: Wed, 24 Dec 2025 18:11:09 +0530
X-Gm-Features: AQt7F2qtWybS3yYTJt8QcmL8qChahBGSrigzuYqno2Xmv1WHecx6hqkXOG93U84
Message-ID: <CANAwSgR7UPrPSHB9RL5newKgWksyn4MoP03ykRQcP2eRSK2SXg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: PCI: Convert nvidia,tegra-pcie to DT schema
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, 
	"open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	Mikko Perttunen <mperttunen@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,

Thanks for your review comments.
On Tue, 16 Dec 2025 at 11:08, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 15/12/2025 15:15, Anand Moon wrote:
> > Convert the existing text-based DT bindings documentation for the
> > NVIDIA Tegra PCIe host controller to a DT schema format.
>
> You dropped several properties from the original schema without
> explanation. That's a no-go. I don't see any reason of doing that, but
> if you find such reason you must clearly document any change done to the
> binding with reasoning.
>
Well, I have tried to address the review comments from Rob
[1] https://lkml.org/lkml/2025/9/26/704

Actually  /schemas/pci/pci-pci-bridge.yaml# covers most of the PCIe binding
So I had not included them, as it would duplicate
If I remove this file, I am getting the following warning

alarm@rockpi-5b:/media/nvme0/mainline/linux-tegra-6.y-devel$ make
dt_binding_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/pci/nvidia,tegra-pcie.yaml
  SCHEMA  Documentation/devicetree/bindings/processed-schema.json
  CHKDT   ./Documentation/devicetree/bindings
  LINT    ./Documentation/devicetree/bindings
  DTEX    Documentation/devicetree/bindings/pci/nvidia,tegra-pcie.example.dts
  DTC [C] Documentation/devicetree/bindings/pci/nvidia,tegra-pcie.example.dtb
/media/nvme0/mainline/linux-tegra-6.y-devel/Documentation/devicetree/bindings/pci/nvidia,tegra-pcie.example.dtb:
pcie@80003000 (nvidia,tegra20-pcie): Unevaluated properties are not
allowed ('#address-cells', '#interrupt-cells', '#size-cells',
'bus-range', 'device_type', 'interrupt-map', 'interrupt-map-mask',
'ranges' were unexpected)
        from schema $id:
http://devicetree.org/schemas/pci/nvidia,tegra-pcie.yaml
/media/nvme0/mainline/linux-tegra-6.y-devel/Documentation/devicetree/bindings/pci/nvidia,tegra-pcie.example.dtb:
pcie@1003000 (nvidia,tegra210-pcie): Unevaluated properties are not
allowed ('#address-cells', '#interrupt-cells', '#size-cells',
'bus-range', 'device_type', 'interrupt-map', 'interrupt-map-mask',
'ranges' were unexpected)
        from schema $id:
http://devicetree.org/schemas/pci/nvidia,tegra-pcie.yaml

> I won't be doing extensive review of your code, because you are known of
> wasting my time, thus only few nits further.
>
I will wait for any further comments on the patches
Then try to submit the next version.
> >
> > Cc: Jon Hunter <jonathanh@nvidia.com>
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> > v2: Tried to address the isssue Rob pointed
> > [1] https://lkml.org/lkml/2025/9/26/704
> > improve the $suject and commit message
> > drop few examples only nvidia,tegra20-pcie and nvidia,tegra210-pcie
> >
> > $ make dt_binding_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/pci/nvidia,tegra-pcie.yaml
> > ---
> >  .../bindings/pci/nvidia,tegra-pcie.yaml       | 380 ++++++++++
> >  .../bindings/pci/nvidia,tegra20-pcie.txt      | 670 ------------------
> >  2 files changed, 380 insertions(+), 670 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/pci/nvidia,tegra-pcie.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
> >
> > diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra-pcie.yaml b/Documentation/devicetree/bindings/pci/nvidia,tegra-pcie.yaml
> > new file mode 100644
> > index 000000000000..e542adfe37b4
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pci/nvidia,tegra-pcie.yaml
> > @@ -0,0 +1,380 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/pci/nvidia,tegra-pcie.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: NVIDIA Tegra PCIe Controller
> > +
> > +maintainers:
> > +  - Jon Hunter <jonathanh@nvidia.com>
> > +  - Thierry Reding <treding@nvidia.com>
> > +
> > +description:
> > +  PCIe controller found on NVIDIA Tegra SoCs which supports multiple
> > +  root ports and platform-specific clock, reset, and power supply
> > +  configurations.
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - nvidia,tegra20-pcie
> > +      - nvidia,tegra30-pcie
> > +      - nvidia,tegra124-pcie
> > +      - nvidia,tegra210-pcie
> > +      - nvidia,tegra186-pcie
> > +
> > +  reg:
> > +    items:
> > +      - description: PADS registers
> > +      - description: AFI registers
> > +      - description: Configuration space region
> > +
> > +  reg-names:
> > +    items:
> > +      - const: pads
> > +      - const: afi
> > +      - const: cs
> > +
> > +  interrupts:
> > +    items:
> > +      - description: Controller interrupt
> > +      - description: MSI interrupt
> > +
> > +  interrupt-names:
> > +    items:
> > +      - const: intr
> > +      - const: msi
> > +
> > +  clocks:
> > +    minItems: 3
> > +    items:
> > +      - description: PCIe clock
> > +      - description: AFI clock
> > +      - description: PLL_E clock
> > +      - description: Optional CML clock
> > +
> > +  clock-names:
> > +    description: Names of clocks used by the PCIe controller
> > +    minItems: 3
> > +    items:
> > +      - const: pex
> > +      - const: afi
> > +      - const: pll_e
> > +      - const: cml
> > +
> > +  resets:
> > +    items:
> > +      - description: PCIe reset
> > +      - description: AFI reset
> > +      - description: PCIe-X reset
> > +
> > +  reset-names:
> > +    items:
> > +      - const: pex
> > +      - const: afi
> > +      - const: pcie_x
> > +
> > +  power-domains:
> > +    maxItems: 1
> > +
> > +  interconnects:
> > +    minItems: 1
> > +    maxItems: 2
>
> This does not match the interconnect-names.
Ok, will drop minItems
>
> > +
> > +  interconnect-names:
> > +    items:
> > +      - const: dma-mem
> > +      - const: write
> > +
> > +  pinctrl-names:
> > +    items:
> > +      - const: default
> > +      - const: idle
> > +
> > +  pinctrl-0: true
> > +  pinctrl-1: true
> > +
> > +  operating-points-v2:
> > +    description:
> > +      Should contain freqs and voltages and opp-supported-hw property, which
> > +      is a bitfield indicating SoC speedo ID mask.
>
> Look at other bindings how this field is described.
I have taken this example from nvidia binding.
 operating-points-v2:
  description:
    Defines operating points with required frequency and voltage values,
    and the opp-supported-hw property.

Is this Ok?
>
> > +
> > +patternProperties:
> > +  "^pci@[0-9a-f]+(,[0-9a-f]+)?$":
> > +    type: object
> > +    allOf:
> > +      - $ref: /schemas/pci/pci-pci-bridge.yaml#
> > +
> > +    properties:
> > +      reg:
> > +        maxItems: 1
> > +
> > +      nvidia,num-lanes:
> > +        description: Number of lanes used by this PCIe port
> > +        $ref: /schemas/types.yaml#/definitions/uint32
> > +        enum:
> > +          - 1
> > +          - 2
> > +          - 4
> > +
> > +    required:
> > +      - nvidia,num-lanes
> > +
> > +    unevaluatedProperties: false
> > +
> > +allOf:
> > +  - $ref: /schemas/pci/pci-host-bridge.yaml#
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - nvidia,tegra20-pcie
> > +              - nvidia,tegra186-pcie
> > +    then:
> > +      properties:
> > +        clocks:
> > +          maxItems: 3
> > +        clock-names:
> > +          items:
> > +            - const: pex
> > +            - const: afi
> > +            - const: pll_e
> > +        resets:
> > +          maxItems: 3
> > +        reset-names:
> > +          items:
> > +            - const: pex
> > +            - const: afi
> > +            - const: pcie_x
>
> Blank line
Ok
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - nvidia,tegra30-pcie
> > +              - nvidia,tegra124-pcie
> > +              - nvidia,tegra210-pcie
> > +    then:
> > +      properties:
> > +        clocks:
> > +          maxItems: 4
> > +        clock-names:
> > +          items:
> > +            - const: pex
> > +            - const: afi
> > +            - const: pll_e
> > +            - const: cml
> > +        resets:
> > +          maxItems: 3
> > +        reset-names:
> > +          items:
> > +            - const: pex
> > +            - const: afi
> > +            - const: pcie_x
> > +
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - nvidia,tegra20-pcie
> > +              - nvidia,tegra30-pcie
> > +    then:
> > +      required:
> > +        - power-domains
> > +        - operating-points-v2
> > +
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - nvidia,tegra186-pcie
> > +    then:
> > +      required:
> > +        - interconnects
> > +
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - nvidia,tegra210-pcie
> > +    then:
> > +      required:
> > +        - pinctrl-names
> > +        - pinctrl-0
> > +        - pinctrl-1
> > +
> > +unevaluatedProperties: false
>
> This goes after required.
>
Ok
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - reg-names
> > +  - clocks
> > +  - clock-names
> > +  - resets
> > +  - reset-names
> > +  - interrupts
> > +  - interrupt-map
> > +  - interrupt-map-mask
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +
> > +    bus {
> > +        #address-cells = <1>;
> > +        #size-cells = <1>;
> > +
> > +        pcie@80003000 {
> > +            compatible = "nvidia,tegra20-pcie";
> > +            device_type = "pci";
> > +            reg = <0x80003000 0x00000800>,
> > +                  <0x80003800 0x00000200>,
> > +                  <0x90000000 0x10000000>;
> > +            reg-names = "pads", "afi", "cs";
> > +            interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
> > +                         <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>;
> > +            interrupt-names = "intr", "msi";
> > +            interrupt-parent = <&intc>;
> > +
> > +            #interrupt-cells = <1>;
> > +            interrupt-map-mask = <0 0 0 0>;
> > +            interrupt-map = <0 0 0 0 &intc GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
> > +
> > +            bus-range = <0x00 0xff>;
> > +            #address-cells = <3>;
> > +            #size-cells = <2>;
> > +
> > +            ranges = <0x02000000 0 0x80000000 0x80000000 0 0x00001000>,
> > +                     <0x02000000 0 0x80001000 0x80001000 0 0x00001000>,
> > +                     <0x01000000 0 0          0x82000000 0 0x00010000>,
> > +                     <0x02000000 0 0xa0000000 0xa0000000 0 0x08000000>,
> > +                     <0x42000000 0 0xa8000000 0xa8000000 0 0x18000000>;
> > +
> > +            clocks = <&tegra_car 70>,
> > +                     <&tegra_car 72>,
> > +                     <&tegra_car 118>;
> > +            clock-names = "pex", "afi", "pll_e";
> > +            resets = <&tegra_car 70>,
> > +                     <&tegra_car 72>,
> > +                     <&tegra_car 74>;
> > +            reset-names = "pex", "afi", "pcie_x";
> > +            power-domains = <&pd_core>;
> > +            operating-points-v2 = <&pcie_dvfs_opp_table>;
> > +
> > +            status = "okay";
>
> No statuses in the example. Please look at other files to see how this
> should be written.
>
The "status" property is by default "okay", thus it can be omitted.
Do you want me to remove the status field from the example?
>
> Best regards,
> Krzysztof

Thanks
-Anand

