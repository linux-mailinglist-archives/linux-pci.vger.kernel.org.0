Return-Path: <linux-pci+bounces-37209-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79198BA9A40
	for <lists+linux-pci@lfdr.de>; Mon, 29 Sep 2025 16:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DDC57A47D4
	for <lists+linux-pci@lfdr.de>; Mon, 29 Sep 2025 14:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C5C30B509;
	Mon, 29 Sep 2025 14:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z2A2NXZC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C6030B500;
	Mon, 29 Sep 2025 14:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759156824; cv=none; b=EkUyCXlBDbnp8CUQtlJb8l8F8orRcizyh4TgP6p7lherNUpCtUA8tPBA2gyjH/TsOOWGVxQEG5LngTQlCWL93QHv1WdE9gcLG7gMmvb/Q/WZJFxWsx2V+u2hMUu0q9CdOiItR6FJX806D6Me/GSiyZz+bv68gio7im3oJsXr7+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759156824; c=relaxed/simple;
	bh=HPTDRYIkQ98sc0e+r+R4VGK7Iy87o2rFwoVWJNtJgAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TZ4A5IeTpCDXZZR8MSFJVONebBfXG3Uw/e1F5Ddb6utyIrfQY94iy0yNgb79XARNoISkcoXBRgMivkPpaOJTXRuWnPhyDzeOlN35KRea+7GLPSeeoaKk88J+xYs/GH+c+2tZLaozg51WMMvlAV14qu51rSR9LwBwClwQvMsmk2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z2A2NXZC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22704C4CEF7;
	Mon, 29 Sep 2025 14:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759156824;
	bh=HPTDRYIkQ98sc0e+r+R4VGK7Iy87o2rFwoVWJNtJgAY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z2A2NXZCqN5MtuZNW+W12uuSdgwhWSq/PmM06GYl+XIWyAAzW53QOmCe9g+S1Cuj1
	 PC3mSm+BNg+pSH/J8wsDk6tO5RtWCqA7Tv33IuHss1lMqmDJwKeOkx1DEVTiRiyr86
	 wY4qFWEXxvPHyAD91Qy170zF8jMM9fCSfzBnK9wBVIk5eO+1Ue0qfSaSnDPS04dnsF
	 59Sk9KOfzunRJjf0V+vJEFn3q5Eh3jO4KHawZmlvVdxjMJ22ys1fwxPjwBgJLJb4IN
	 0GNcHTG+oGtvR5wmOy7icrsbqIXcq5Ge3h6uOZI1wVIdEz/8o1ZVpSSAP+BA876s45
	 p/oFaWfZQzTRg==
Date: Mon, 29 Sep 2025 09:40:23 -0500
From: Rob Herring <robh@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 3/5] dt-bindings: PCI: mediatek: Add support for
 Airoha AN7583
Message-ID: <20250929144023.GA4111165-robh@kernel.org>
References: <20250929113806.2484-1-ansuelsmth@gmail.com>
 <20250929113806.2484-4-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250929113806.2484-4-ansuelsmth@gmail.com>

On Mon, Sep 29, 2025 at 01:38:02PM +0200, Christian Marangi wrote:
> Introduce Airoha AN7583 SoC compatible in mediatek PCIe controller
> binding.
> 
> Similar to GEN3, the Airoha AN7583 GEN2 PCIe controller require the
> PBUS csr property to permit the correct functionality of the PCIe
> controller.

I guess I didn't get my point across before. Test your crap before 
sending or I'm going to stop reviewing your stuff.

> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  .../bindings/pci/mediatek-pcie.yaml           | 110 ++++++++++++++++++
>  1 file changed, 110 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie.yaml b/Documentation/devicetree/bindings/pci/mediatek-pcie.yaml
> index fca6cb20d18b..b91b13a0220c 100644
> --- a/Documentation/devicetree/bindings/pci/mediatek-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/mediatek-pcie.yaml
> @@ -13,6 +13,7 @@ properties:
>    compatible:
>      oneOf:
>        - enum:
> +          - airoha,an7583-pcie
>            - mediatek,mt2712-pcie
>            - mediatek,mt7622-pcie
>            - mediatek,mt7629-pcie
> @@ -55,6 +56,17 @@ properties:
>    power-domains:
>      maxItems: 1
>  
> +  mediatek,pbus-csr:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    items:
> +      - items:
> +          - description: phandle to pbus-csr syscon
> +          - description: offset of pbus-csr base address register
> +          - description: offset of pbus-csr base address mask register
> +    description:
> +      Phandle with two arguments to the syscon node used to detect if
> +      a given address is accessible on PCIe controller.
> +
>    '#interrupt-cells':
>      const: 1
>  
> @@ -90,6 +102,45 @@ required:
>  allOf:
>    - $ref: /schemas/pci/pci-host-bridge.yaml#
>  
> +  - if:
> +      properties:
> +        compatible:
> +          const: airoha,an7583-pcie
> +    then:
> +      properties:
> +        reg:
> +          maxItems: 1

That's already the maximum. Drop.

> +
> +        reg-names:
> +          const: port1
> +
> +        clocks:
> +          maxItems: 1
> +
> +        clock-names:
> +          const: sys_ck1
> +
> +        reset:
> +          maxItems: 1

That's already the maximum. Drop.

> +
> +        reset-names:
> +          const: pcie-rst1
> +
> +        phys:
> +          maxItems: 1

That's already the maximum. Drop.

> +
> +        phy-names:
> +          const: pcie-phy1
> +
> +        power-domain: false
> +
> +      required:
> +        - resets
> +        - reset-names
> +        - phys
> +        - phy-names
> +        - mediatek,pbus-csr
> +
>    - if:
>        properties:
>          compatible:
> @@ -106,6 +157,8 @@ allOf:
>  
>          power-domains: false
>  
> +        mediatek,pbus-csr: false
> +
>        required:
>          - phys
>          - phy-names
> @@ -123,6 +176,8 @@ allOf:
>  
>          phy-names: false
>  
> +        mediatek,pbus-csr: false
> +
>        required:
>          - power-domains
>  
> @@ -135,6 +190,8 @@ allOf:
>          clocks:
>            minItems: 6
>  
> +        mediatek,pbus-csr: false
> +
>        required:
>          - power-domains
>  
> @@ -157,6 +214,8 @@ allOf:
>  
>          power-domain: false
>  
> +        mediatek,pbus-csr: false
> +
>  unevaluatedProperties: false
>  
>  examples:
> @@ -316,3 +375,54 @@ examples:
>              };
>          };
>      };
> +
> +  # AN7583
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/en7523-clk.h>
> +
> +    soc_3 {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        pcie@1fa92000 {
> +            compatible = "airoha,an7583-pcie";
> +            device_type = "pci";
> +            linux,pci-domain = <1>;
> +            #address-cells = <3>;
> +            #size-cells = <2>;
> +
> +            reg = <0x0 0x1fa92000 0x0 0x1670>;
> +            reg-names = "port1";
> +
> +            clocks = <&scuclk EN7523_CLK_PCIE>;
> +            clock-names = "sys_ck1";
> +
> +            phys = <&pciephy>;
> +            phy-names = "pcie-phy1";
> +
> +            ranges = <0x02000000 0 0x24000000 0x0 0x24000000 0 0x4000000>;
> +
> +            resets = <&scuclk>; /* AN7583_PCIE1_RST */
> +            reset-names = "pcie-rst1";
> +
> +            mediatek,pbus-csr = <&pbus_csr 0x8 0xc>;
> +
> +            interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
> +            interrupt-names = "pcie_irq";
> +            bus-range = <0x00 0xff>;
> +            #interrupt-cells = <1>;
> +            interrupt-map-mask = <0 0 0 7>;
> +            interrupt-map = <0 0 0 1 &pcie_intc1 0>,
> +                            <0 0 0 2 &pcie_intc1 1>,
> +                            <0 0 0 3 &pcie_intc1 2>,
> +                            <0 0 0 4 &pcie_intc1 3>;
> +
> +            pcie_intc1_4: interrupt-controller {
> +                interrupt-controller;
> +                #address-cells = <0>;
> +                #interrupt-cells = <1>;
> +            };
> +        };
> +    };
> -- 
> 2.51.0
> 

