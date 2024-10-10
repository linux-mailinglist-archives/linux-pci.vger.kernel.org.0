Return-Path: <linux-pci+bounces-14124-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A73A8997AC0
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 04:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CE2628343D
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 02:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB5118593B;
	Thu, 10 Oct 2024 02:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZCZBVcl+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080C9224CF;
	Thu, 10 Oct 2024 02:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728528767; cv=none; b=nGEarggUeExLlZklyEqZlU6Z8wMoFIMTOgeLgMhwJT2tCViqOg96sJ3i0zIKTQOVtCFgGw1R23g412aNeoRadFvb5KoOjvKAiGb9HOauyK2TRjEQEWyPEQB8cdTr/hcPED9UvYH8I3GoWumpZRy6FJfYTl+gZ1uoFl8s86zztfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728528767; c=relaxed/simple;
	bh=jNUa/nUADGuQ/kbBLvMP9Cp3on/BTO7uQawWJ3unJ1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JqPrqTW5nWElHkSaK9idvEgxc7IKgz/fiqnGhXhXcGtSN/FljCBvBmdFIySdCVlD/mZ59JvArP21v4lJnTdC5K2Rj5hMj+cgFCDskaE2xunCOLuAALuIEEP2X6Hu7B5zIjzOLhuzGvOs2bDcWkoebYLth9h0d6pAzySUVcfFQaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZCZBVcl+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D7A2C4CEC3;
	Thu, 10 Oct 2024 02:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728528765;
	bh=jNUa/nUADGuQ/kbBLvMP9Cp3on/BTO7uQawWJ3unJ1A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZCZBVcl+KuCpQYVQP1WWm3+CwZaVniAk7FaV/Oydqo5MZ93uX/9kGBRJkCRGinZ3f
	 PKKYPW9VZbCcb/INEzAOZbbHIM4NRkDZUK0p19O+oo/+ZpJ19SU2EhCPxMq2nCrMKa
	 6J4jODeBZsnnewWKx5Ci8FqiE4LfG/CtjEmWVn4jol6HzznaRD5JvJTSMchajOr6+V
	 lYNCCnp4foTph3fBLxI1HILKPWWmD7i23TtR5wHuYioyUo0Ok5okrlCvgl2bcKhxEs
	 Tp02GoEt7OmSxciunSfLlOP9SbMd77Jt0102+A8VLdl7NkhMhxqWAYJhqp3PCGUhjj
	 dbehRiwJHkbXA==
Date: Wed, 9 Oct 2024 21:52:44 -0500
From: Rob Herring <robh@kernel.org>
To: Andrea della Porta <andrea.porta@suse.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Saravana Kannan <saravanak@google.com>, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Stefan Wahren <wahrenst@gmx.net>,
	Herve Codina <herve.codina@bootlin.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v2 04/14] dt-bindings: misc: Add device specific bindings
 for RaspberryPi RP1
Message-ID: <20241010025244.GB978628-robh@kernel.org>
References: <cover.1728300189.git.andrea.porta@suse.com>
 <3141e3e7898c1538ea658487923d3446b3d7fd0c.1728300189.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3141e3e7898c1538ea658487923d3446b3d7fd0c.1728300189.git.andrea.porta@suse.com>

On Mon, Oct 07, 2024 at 02:39:47PM +0200, Andrea della Porta wrote:
> The RP1 is a MFD that exposes its peripherals through PCI BARs. This
> schema is intended as minimal support for the clock generator and
> gpio controller peripherals which are accessible through BAR1.
> 
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> ---
>  .../devicetree/bindings/misc/pci1de4,1.yaml   | 110 ++++++++++++++++++
>  MAINTAINERS                                   |   1 +
>  2 files changed, 111 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/pci1de4,1.yaml
> 
> diff --git a/Documentation/devicetree/bindings/misc/pci1de4,1.yaml b/Documentation/devicetree/bindings/misc/pci1de4,1.yaml
> new file mode 100644
> index 000000000000..3f099b16e672
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/pci1de4,1.yaml
> @@ -0,0 +1,110 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/misc/pci1de4,1.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: RaspberryPi RP1 MFD PCI device
> +
> +maintainers:
> +  - Andrea della Porta <andrea.porta@suse.com>
> +
> +description:
> +  The RaspberryPi RP1 is a PCI multi function device containing
> +  peripherals ranging from Ethernet to USB controller, I2C, SPI
> +  and others.
> +  The peripherals are accessed by addressing the PCI BAR1 region.
> +
> +allOf:
> +  - $ref: /schemas/pci/pci-ep-bus.yaml
> +
> +properties:
> +  compatible:
> +    additionalItems: true
> +    maxItems: 3
> +    items:
> +      - const: pci1de4,1
> +
> +patternProperties:
> +  "^pci-ep-bus@[0-2]$":
> +    $ref: '#/$defs/bar-bus'
> +    description:
> +      The bus on which the peripherals are attached, which is addressable
> +      through the BAR.

No need for this because pci-ep-bus.yaml already has a schema for the 
child nodes.

> +
> +unevaluatedProperties: false
> +
> +$defs:
> +  bar-bus:
> +    $ref: /schemas/pci/pci-ep-bus.yaml#/$defs/pci-ep-bus
> +    unevaluatedProperties: false
> +
> +    properties:
> +      "#interrupt-cells":
> +        const: 2
> +        description:
> +          Specifies respectively the interrupt number and flags as defined
> +          in include/dt-bindings/interrupt-controller/irq.h.
> +
> +      interrupt-controller: true
> +
> +      interrupt-parent:
> +        description:
> +          Must be the phandle of this 'pci-ep-bus' node. It will trigger
> +          PCI interrupts on behalf of peripheral generated interrupts.


Do you have an interrupt controller per bus? These should be in the 
parent node I think.


> +
> +    patternProperties:
> +      "^clocks(@[0-9a-f]+)?$":
> +        type: object
> +        $ref: /schemas/clock/raspberrypi,rp1-clocks.yaml
> +
> +      "^ethernet(@[0-9a-f]+)?$":
> +        type: object
> +        $ref: /schemas/net/cdns,macb.yaml
> +
> +      "^pinctrl(@[0-9a-f]+)?$":
> +        type: object
> +        $ref: /schemas/pinctrl/raspberrypi,rp1-gpio.yaml

IMO, these child nodes can be omitted. We generally don't define all the 
child nodes in an SoC.

If you do want to define them, then just do:

additionalProperties: true
properties:
  compatible:
    contains: the-child-compatible

> +
> +    required:
> +      - interrupt-parent
> +      - interrupt-controller
> +
> +examples:
> +  - |
> +    pci {
> +        #address-cells = <3>;
> +        #size-cells = <2>;
> +
> +        rp1@0,0 {
> +            compatible = "pci1de4,1";
> +            ranges = <0x01 0x00 0x00000000
> +                      0x82010000 0x00 0x00
> +                      0x00 0x400000>;
> +            #address-cells = <3>;
> +            #size-cells = <2>;
> +
> +            pci_ep_bus: pci-ep-bus@1 {
> +                compatible = "simple-bus";
> +                ranges = <0xc0 0x40000000
> +                          0x01 0x00 0x00000000
> +                          0x00 0x00400000>;
> +                dma-ranges = <0x10 0x00000000
> +                              0x43000000 0x10 0x00000000
> +                              0x10 0x00000000>;
> +                #address-cells = <2>;
> +                #size-cells = <2>;
> +                interrupt-controller;
> +                interrupt-parent = <&pci_ep_bus>;
> +                #interrupt-cells = <2>;
> +
> +                rp1_clocks: clocks@c040018000 {
> +                    compatible = "raspberrypi,rp1-clocks";
> +                    reg = <0xc0 0x40018000 0x0 0x10038>;
> +                    #clock-cells = <1>;
> +                    clocks = <&clk_rp1_xosc>;
> +                    clock-names =  "rp1-xosc";
> +                };
> +            };
> +        };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ccf123b805c8..2aea5a6166bd 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19384,6 +19384,7 @@ RASPBERRY PI RP1 PCI DRIVER
>  M:	Andrea della Porta <andrea.porta@suse.com>
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/clock/raspberrypi,rp1-clocks.yaml
> +F:	Documentation/devicetree/bindings/misc/pci1de4,1.yaml
>  F:	Documentation/devicetree/bindings/pci/pci-ep-bus.yaml
>  F:	Documentation/devicetree/bindings/pinctrl/raspberrypi,rp1-gpio.yaml
>  F:	include/dt-bindings/clock/rp1.h
> -- 
> 2.35.3
> 

