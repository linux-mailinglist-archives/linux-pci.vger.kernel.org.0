Return-Path: <linux-pci+bounces-37183-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E05B5BA844B
	for <lists+linux-pci@lfdr.de>; Mon, 29 Sep 2025 09:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 012E3188C273
	for <lists+linux-pci@lfdr.de>; Mon, 29 Sep 2025 07:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21FE92C0F7F;
	Mon, 29 Sep 2025 07:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BDO2QdI+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D142C2C0F61
	for <linux-pci@vger.kernel.org>; Mon, 29 Sep 2025 07:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759131609; cv=none; b=H6guT8hR0MKnD9qZNmEBR8ZkyQImEi6xJZuLAiUPkNnmhUL7p9X9sQCHyWe5wo0GW8w6HWgdCf3B8tvRtTdY/MQgkXyfvpfmhOaul1qPWfTUKQu3ih7hy6CddrBQkbwLZlnqs/lmUomWC6fPd1N6SvNmI1vpoYtgEx9I81HGJRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759131609; c=relaxed/simple;
	bh=IU736SJHQT3ExduYmttu43Xgi6GnKbPa1vH3hbZruqs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wn8Ya30l5GtumInPsIOmAbscnEYooZ+OzNWcntF0v1Exx3aDbyqdIyh1A0QK2SRVXia/7AxQgPGambv9Um6jl2YVh0hA7CL5bx9ySFimR9QLqn5KfzhyU/7DKZ/eiICLj+6dbcaruSrdlICGXWWj3505k1Bue6af6ZN70J6xbtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BDO2QdI+; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-634b774f135so5151491a12.2
        for <linux-pci@vger.kernel.org>; Mon, 29 Sep 2025 00:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759131605; x=1759736405; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7O96OJRpItyuYZsrVRlTW58CE15W2ryxqNqk3lk3600=;
        b=BDO2QdI+lNj8A3B/omWaO6pWIKBqC0Gy9PCWz9qWj0J8wADJt93u7S7C/t0hPac2ve
         2ES+W2gvIcgRWXEOvM2+yOKqTTEfp7/BaZxanoKSUzHate43hFp3CtIYxozvf8vUtsID
         7WOPoQJ6JDzCKb2DJK0MtrPY32NpLHMEJ5sk9amkxXbRtmKAWviFbOprKoVCAuASNr2b
         sJsL/PJBjk0r6vNeLDfZ3VF499mjBjsY0HUeN3/6T0npIPFJBEG/zbxJ4SVLO1hN2xa2
         3JmjVm8fCG+AeE/yhQClsC1prcEYqoLGgTwcFREEl9qusO9dgbD0Gh2S95FasRQgGEVm
         A87A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759131605; x=1759736405;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7O96OJRpItyuYZsrVRlTW58CE15W2ryxqNqk3lk3600=;
        b=Ab0WjcYmgnvE+mNRW3wkzBQmrHdIPOrOh8IwYMDRAyXyqC2g2w3zofAuWLmroAS0tI
         j4QeAkLmZsBtm6bK9eSo9UYwd/iAlA3TD1LtHYKtoYtVeYaGrBWOhC5h0b4C+dJG3Qy5
         U1t4aFQM8Rq2hE1EBK0qaZp5rAt/rJfzvnaxKW6YlhME0pD8+CovYzERYyJEUMaXrDYG
         ayT0guCo9pgOLkjOr4Po+hQpjLrZd6h2iXHf/Zioj+ko3sas5C+ebZG5Yo1QCPDsVymd
         6yGyrlrFbTbj1120dEDAl+AZrXILyY14MFjwPg06PVntk2OeUrE7/1tDizU9LN76KEJJ
         Z0ww==
X-Forwarded-Encrypted: i=1; AJvYcCURyvibI7UkAP63kL05F9+dT4vHxd9GZn6PV+PeuJ1anF+NAwcDf//p51eCgJpReArxhN2Ty2IgS9w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVIu4w+zwCH1zmlcgS2X8BrdqHhPxB7kqiU18ah5B0gD47WEnH
	LE8Q0dXpmHo/+cVOcld7akx1hM9C8M/TKrjatNweY8aXwrhsZ21WsYxc6eSidG6j94QnI1Ku8Zw
	0E3P9u/SXQOPA/f3IYOJCbF6c7kiOYFw=
X-Gm-Gg: ASbGnct7hcBVEV+elb4F7RYU8sPbgR4FKANxcURH7od58776G6BtOEJuwtvSNEP84kB
	1IY844n+bWuYJFJGW1GraYVhfwFQS0pWtxD0T1vjpRbw6XeAUXXhG/9XNLI5ukvSL8jg7UNi8mb
	w5AvKJAN5ILF26XuJEXXYV5PCWN72rwMXbWTJ4NfYGecyEat89d9Vl8F/yVfasOeCz7+rjD9Hx5
	A8ppC60lS32BW+A7XiW5CJoPNA=
X-Google-Smtp-Source: AGHT+IGn5R7mZe5s/VGCiK+X5y0WXOtQqktNX7eU61f9nIILSoAl8xD03zGmv8uKKu5PdjTLXHPvHIdb5KnwpXouWxY=
X-Received: by 2002:aa7:d588:0:b0:628:7716:357c with SMTP id
 4fb4d7f45d1cf-6349faa99edmr10432021a12.25.1759131604966; Mon, 29 Sep 2025
 00:40:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926072905.126737-1-linux.amoon@gmail.com>
 <20250926072905.126737-2-linux.amoon@gmail.com> <CAL_JsqJr+h7pTvbRR=7eB4ognK70D1pgNXEORGXo=ndND=pMjw@mail.gmail.com>
In-Reply-To: <CAL_JsqJr+h7pTvbRR=7eB4ognK70D1pgNXEORGXo=ndND=pMjw@mail.gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Mon, 29 Sep 2025 13:09:48 +0530
X-Gm-Features: AS18NWChS0qSBpBHCzG5pX2TziLbCoFFXqmaN-oDpWpajtS42CIlXS6QQh6Gw_w
Message-ID: <CANAwSgT3jo35xBvkH4GmQcZuZH=D+SRKJ6e9fSBRz45zwuCmYw@mail.gmail.com>
Subject: Re: [PATCH v1 1/5] dt-bindings: PCI: Convert the existing
 nvidia,tegra-pcie.txt bindings documentation into a YAML schema
To: Rob Herring <robh@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	"open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" <linux-pci@vger.kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, 
	"open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Rob,

Thanks for your review comments

On Fri, 26 Sept 2025 at 19:26, Rob Herring <robh@kernel.org> wrote:
>
> On Fri, Sep 26, 2025 at 2:29=E2=80=AFAM Anand Moon <linux.amoon@gmail.com=
> wrote:
> >
> > Convert the legacy text-based binding documentation for
> > nvidia,tegra-pcie into a nvidia,tegra-pcie.yaml YAML schema, following
>
> s/YAML/DT/
>
Ok,
> > the Devicetree Schema format. This improves validation coverage and ena=
bles
> > dtbs_check compliance for Tegra PCIe nodes.
>
> Your subject needs some work too. 'existing' and 'bindings
> documentation' are redundant.
>
Here is the simplified version

dt-bindings: PCI: Convert the nvidia,tegra-pcie bindings documentation
into a YAML schema

Convert the existing text-based DT bindings documentation for the
NVIDIA Tegra PCIe host controller to a YAML schema format.

> >
> > Cc: Jon Hunter <jonathanh@nvidia.com>
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> > v1: new patch in this series.
> > ---
> >  .../bindings/pci/nvidia,tegra-pcie.yaml       | 651 +++++++++++++++++
> >  .../bindings/pci/nvidia,tegra20-pcie.txt      | 670 ------------------
> >  2 files changed, 651 insertions(+), 670 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/pci/nvidia,tegra-=
pcie.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/pci/nvidia,tegra2=
0-pcie.txt
> >
> > diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra-pcie.ya=
ml b/Documentation/devicetree/bindings/pci/nvidia,tegra-pcie.yaml
> > new file mode 100644
> > index 000000000000..dd8cba125b53
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pci/nvidia,tegra-pcie.yaml
> > @@ -0,0 +1,651 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/pci/nvidia,tegra-pcie.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: NVIDIA Tegra PCIe Controller
> > +
> > +maintainers:
> > +  - Thierry Reding <thierry.reding@gmail.com>
> > +  - Jon Hunter <jonathanh@nvidia.com>
> > +
> > +description: |
>
> Don't need '|'.
>
Ok
> > +  PCIe controller found on NVIDIA Tegra SoCs including Tgra20, Tegra30=
,
> > +  Tegra124, Tegra210, and Tegra186. Supports multiple root ports and
> > +  platform-specific clock, reset, and power supply configurations.
>
> I would suggest not listing every SoC here unless the list is not going t=
o grow.
>
Here is the short format.
  PCIe controller found on NVIDIA Tegra SoCs which supports multiple
  root ports and platform-specific clock, reset, and power supply
  configurations.
Ok
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
>
> Only 1 entry here, don't need 'oneOf'.

I am observing the following warning if I remove this.

 make ARCH=3Darm64 -j$(nproc) dt_binding_check
DT_SCHEMA_FILES=3DDocumentation/devicetree/bindings/pci/nvidia,tegra-pcie.y=
aml
  CHKDT   ./Documentation/devicetree/bindings
/media/nvme0/mainline/linux-tegra-6.y-devel/Documentation/devicetree/bindin=
gs/pci/nvidia,tegra-pcie.yaml:
properties:compatible: [{'items': [{'enum': ['nvidia,tegra20-pcie',
'nvidia,tegra30-pcie', 'nvidia,tegra124-pcie', 'nvidia,tegra210-pcie',
'nvidia,tegra186-pcie']}]}] is not of type 'object', 'boolean'
        from schema $id: http://json-schema.org/draft-07/schema#
/media/nvme0/mainline/linux-tegra-6.y-devel/Documentation/devicetree/bindin=
gs/pci/nvidia,tegra-pcie.yaml:
properties:compatible: [{'items': [{'enum': ['nvidia,tegra20-pcie',
'nvidia,tegra30-pcie', 'nvidia,tegra124-pcie', 'nvidia,tegra210-pcie',
'nvidia,tegra186-pcie']}]}] is not of type 'object', 'boolean'
        from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
>
> > +      - items:
> > +          - enum:
> > +              - nvidia,tegra20-pcie
> > +              - nvidia,tegra30-pcie
> > +              - nvidia,tegra124-pcie
> > +              - nvidia,tegra210-pcie
> > +              - nvidia,tegra186-pcie
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
> > +  device_type:
> > +    const: pci
>
> Drop. This is covered by pci-host-bridge.yaml.
Ok
>
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
> > +    oneOf:
> > +      - items:
> > +          - description: PCIe clock
> > +          - description: AFI clock
> > +          - description: PLL_E clock
>
> Drop this list and add 'minItems: 3'
Ok
>
> > +      - items:
> > +          - description: PCIe clock
> > +          - description: AFI clock
> > +          - description: PLL_E clock
> > +          - description: CML clock
> > +
> > +  clock-names:
> > +    oneOf:
> > +      - items:
> > +          - const: pex
> > +          - const: afi
> > +          - const: pll_e
>
> Same here.
Ok these are dumpicate will remove this.
>
> > +      - items:
> > +          - const: pex
> > +          - const: afi
> > +          - const: pll_e
> > +          - const: cml
> > +
> > +  resets:
> > +    items:
> > +      - description: PCIe reset
> > +      - description: AFI reset
> > +      - description: PCIe X reset
> > +
> > +  reset-names:
> > +    items:
> > +      - const: pex
> > +      - const: afi
> > +      - const: pcie_x
> > +
> > +  power-domains:
> > +    maxItems: 1
> > +    description: |
> > +      A phandle to the node that controls power to the respective PCIe
> > +      controller and a specifier name for the PCIe controller.
>
> Don't need generic descriptions of common properties. Drop.
>
Ok
> > +
> > +  interconnects:
> > +    minItems: 1
> > +    maxItems: 2
> > +
> > +  interconnect-names:
> > +    minItems: 1
> > +    maxItems: 2
> > +    description:
> > +      Should include name of the interconnect path for each interconne=
ct
> > +      entry. Consult TRM documentation for information about available
> > +      memory clients, see DMA CONTROLLER and MEMORY WRITE sections.
>
> You have to document what the names are.
      items:
      - const: dma-mem
      - const: write
Ok.
>
> > +
> > +  pinctrl-names:
> > +    items:
> > +      - const: default
> > +      - const: idle
> > +
> > +  pinctrl-0:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
>
> This already has a type. Just 'pinctrl-0: true' is enough.
>
Ok I will drop pinctrl
> > +
> > +  pinctrl-1:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +
> > +  nvidia,num-lanes:
> > +    description: Number of PCIe lanes used
> > +    $ref: /schemas/types.yaml#/definitions/uint32
>
> The examples show this in child nodes.
yes it patternProperties example I missed this.

patternProperties:
  "^pci@[0-9a-f]+$":
    type: object

    properties:
      reg:
        maxItems: 1

      nvidia,num-lanes:
        description: Number of PCIe lanes used
        $ref: /schemas/types.yaml#/definitions/uint32
        minimum: 1

    unevaluatedProperties: false
>
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
> > +          minItems: 3
>
> 3 is already the min, so drop.
>
> > +          maxItems: 3
> > +        clock-names:
> > +          items:
> > +            - const: pex
> > +            - const: afi
> > +            - const: pll_e
>
> Names are already defined, so just 'maxItems: 3'
>
> Same comments apply to the rest...
>
Ok correct.
> > +        resets:
> > +          minItems: 3
> > +          maxItems: 3
> > +        reset-names:
> > +          items:
> > +            - const: pex
> > +            - const: afi
> > +            - const: pcie_x
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
> > +          minItems: 4
> > +          maxItems: 4
>
> Just 'minItems' here.
>
Ok,
> > +        clock-names:
> > +          items:
> > +            - const: pex
> > +            - const: afi
> > +            - const: pll_e
> > +            - const: cml
>
> And here...
>
> > +        resets:
> > +          minItems: 3
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
> > +              - nvidia,tegra186-pcie
> > +    then:
> > +      required:
> > +        - power-domains
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
> > +  - ranges
>
> Already required by pci-host-bridge.yaml.
>
> > +  - bus-range
>
Ok
> Generally, bus-range is only required when there's some h/w issue.
>
> > +  - device_type
>
> Already required by pci-host-bridge.yaml.
Ok
>
> > +  - interconnects
> > +  - pinctrl-names
>
> Above you said this was conditional.
>
Ok, I will drop this.
> > +  - nvidia,num-lanes
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +
> > +    bus {
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <1>;
> > +
> > +        pcie@80003000 {
> > +            compatible =3D "nvidia,tegra20-pcie";
> > +            device_type =3D "pci";
> > +            reg =3D <0x80003000 0x00000800>,
> > +                  <0x80003800 0x00000200>,
> > +                  <0x90000000 0x10000000>;
> > +            reg-names =3D "pads", "afi", "cs";
> > +            interrupts =3D <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
> > +                         <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>;
> > +            interrupt-names =3D "intr", "msi";
> > +            interrupt-parent =3D <&intc>;
> > +
> > +            #interrupt-cells =3D <1>;
> > +            interrupt-map-mask =3D <0 0 0 0>;
> > +            interrupt-map =3D <0 0 0 0 &intc GIC_SPI 98 IRQ_TYPE_LEVEL=
_HIGH>;
> > +
> > +            bus-range =3D <0x00 0xff>;
> > +            #address-cells =3D <3>;
> > +            #size-cells =3D <2>;
> > +
> > +            ranges =3D <0x02000000 0 0x80000000 0x80000000 0 0x0000100=
0>,
> > +                     <0x02000000 0 0x80001000 0x80001000 0 0x00001000>=
,
> > +                     <0x01000000 0 0          0x82000000 0 0x00010000>=
,
> > +                     <0x02000000 0 0xa0000000 0xa0000000 0 0x08000000>=
,
> > +                     <0x42000000 0 0xa8000000 0xa8000000 0 0x18000000>=
;
> > +
> > +            clocks =3D <&tegra_car 70>,
> > +                     <&tegra_car 72>,
> > +                     <&tegra_car 118>;
> > +            clock-names =3D "pex", "afi", "pll_e";
> > +            resets =3D <&tegra_car 70>,
> > +                     <&tegra_car 72>,
> > +                     <&tegra_car 74>;
> > +            reset-names =3D "pex", "afi", "pcie_x";
> > +            power-domains =3D <&pd_core>;
> > +            operating-points-v2 =3D <&pcie_dvfs_opp_table>;
> > +
> > +            status =3D "disabled";
>
> Examples must be enabled.
Ok
>
> > +
> > +            pci@1,0 {
> > +                device_type =3D "pci";
> > +                assigned-addresses =3D <0x82000800 0 0x80000000 0 0x10=
00>;
> > +                reg =3D <0x000800 0 0 0 0>;
> > +                bus-range =3D <0x00 0xff>;
> > +                status =3D "disabled";
> > +
> > +                #address-cells =3D <3>;
> > +                #size-cells =3D <2>;
> > +                ranges;
> > +
> > +                nvidia,num-lanes =3D <2>;
>
> This doesn't match the schema.
I will try to validate it as a child node with patternProperties.
>
> > +            };
> > +
> > +            pci@2,0 {
> > +                device_type =3D "pci";
> > +                assigned-addresses =3D <0x82001000 0 0x80001000 0 0x10=
00>;
> > +                reg =3D <0x001000 0 0 0 0>;
> > +                bus-range =3D <0x00 0xff>;
> > +                status =3D "disabled";
> > +
> > +                #address-cells =3D <3>;
> > +                #size-cells =3D <2>;
> > +                ranges;
> > +
> > +                nvidia,num-lanes =3D <2>;
> > +            };
> > +        };
> > +    };
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +
> > +    bus {
>
> I don't think we need 4 examples.
Ok nvidia,tegra20-pcie and nvidia,tegra210-pcie should be valid
>
> Rob
Thanks
-Anand

