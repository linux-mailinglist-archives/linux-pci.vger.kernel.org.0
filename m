Return-Path: <linux-pci+bounces-13053-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D604E9758D7
	for <lists+linux-pci@lfdr.de>; Wed, 11 Sep 2024 18:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1508A1C231CF
	for <lists+linux-pci@lfdr.de>; Wed, 11 Sep 2024 16:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5421B0131;
	Wed, 11 Sep 2024 16:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EeCFVeoa"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28CB383B1;
	Wed, 11 Sep 2024 16:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726073773; cv=none; b=aHR78Miiy2jRtq0rP1TYqXi+Y+gzdoNDPZlViyPGDLPZ2X0qcb0qnphQP29o3N5GUKU15GRfJQixOML2CBdDsArKVz5Z2Gg7CTkUjzFv6x1axGBCBgWZWpHCmTX9saVmCbmlNrl7GMaISOV1c6aK6AUA5bnEnwvoGhg/sSWS5V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726073773; c=relaxed/simple;
	bh=w5rs/PwnbnPH2WJmKYV5ErVySmPazQWq1znvo203RuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aUmLwscyItJQk/AJ/H8Z0xJKWRb1Y+3WY8n6QR98drZ6GZvPOx9IDNiktoZf4VZ/942VLT9GxZFPngS81fWixc+CfrOUzU0EYle3QuBELyt3kyceXOUtEG86GQvAaLmLiRK1ik/BLRXxliEu3pQR0tpfNoE2KaAbWGFL0kY1QLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EeCFVeoa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51077C4CEC0;
	Wed, 11 Sep 2024 16:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726073772;
	bh=w5rs/PwnbnPH2WJmKYV5ErVySmPazQWq1znvo203RuI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EeCFVeoaqIsPDBQE0cuwny/rnaq2ePK5Qk/s92YTROQQkNHM3nIIgPkWFjDz3zOFN
	 +kfwYV41jho7WPj91L7xWWcJyQdU/33R/YufgZn0ub4Hu7LnArHcDvURjfwIncfBCG
	 /tzYMkDsUzfLpyd13oJaQ64AjE6+O5BKxZTtXvRBONR/bEqqk/FdUmRQvAQ/dH8u+o
	 6FrP/IHp4X4CMlqT++SutuJkcb0Mj8j9p/9b4sZh6me2iEqDtaznp80ghjoBSRuZQo
	 zLHFq2vmhlLj2vg5gtLKmeqflGz+1t5yRTINirAxAuKjXQ3+DlENvGm1zwavw1RJiC
	 GtvjUhjQsy1uQ==
Date: Wed, 11 Sep 2024 11:56:11 -0500
From: Rob Herring <robh@kernel.org>
To: Stanimir Varbanov <svarbanov@suse.de>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jim Quinlan <jim2101024@gmail.com>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>, kw@linux.com,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Andrea della Porta <andrea.porta@suse.com>,
	Phil Elwell <phil@raspberrypi.com>,
	Jonathan Bell <jonathan@raspberrypi.com>
Subject: Re: [PATCH v2 -next 01/11] dt-bindings: interrupt-controller: Add
 bcm2712 MSI-X DT bindings
Message-ID: <20240911165611.GA897131-robh@kernel.org>
References: <20240910151845.17308-1-svarbanov@suse.de>
 <20240910151845.17308-2-svarbanov@suse.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910151845.17308-2-svarbanov@suse.de>

On Tue, Sep 10, 2024 at 06:18:35PM +0300, Stanimir Varbanov wrote:
> Adds DT bindings for bcm2712 MSI-X interrupt peripheral controller.
> 
> Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
> ---
>  .../brcm,bcm2712-msix.yaml                    | 69 +++++++++++++++++++
>  1 file changed, 69 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/brcm,bcm2712-msix.yaml
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm2712-msix.yaml b/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm2712-msix.yaml
> new file mode 100644
> index 000000000000..2b53dfa7c25e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm2712-msix.yaml
> @@ -0,0 +1,69 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interrupt-controller/brcm,bcm2712-msix.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Broadcom bcm2712 MSI-X Interrupt Peripheral support
> +
> +maintainers:
> +  - Stanimir Varbanov <svarbanov@suse.de>
> +
> +description: >

Don't need '>' here.

> +  This interrupt controller is used to provide interrupt vectors to the
> +  generic interrupt controller (GIC) on bcm2712. It will be used as
> +  external MSI-X controller for PCIe root complex.
> +
> +allOf:
> +  - $ref: /schemas/interrupt-controller/msi-controller.yaml#
> +
> +properties:
> +  compatible:
> +    const: brcm,bcm2712-mip
> +
> +  reg:
> +    items:
> +      - description: base registers address
> +      - description: pcie message address
> +
> +  interrupt-controller: true
> +
> +  "#interrupt-cells":
> +    const: 2

What goes in these cells?

But really, what interrupts does an MSI controller handle? Or are we 
just putting "interrupt-controller" in here so that kernel handles this 
with IRQCHIP_DECLARE()?

> +
> +  msi-controller: true

Drop and use 'unevaluatedProperties'.

> +
> +  "#msi-cells":
> +    enum: [0]

const: 0

> +
> +  msi-ranges: true

Drop.

> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupt-controller
> +  - "#interrupt-cells"
> +  - msi-controller
> +  - msi-ranges
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    axi {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        msi-controller@1000130000 {
> +            compatible = "brcm,bcm2712-mip";
> +            reg = <0x10 0x00130000 0x00 0xc0>,
> +                  <0xff 0xfffff000 0x00 0x1000>;
> +            msi-controller;
> +            #msi-cells = <0>;
> +            interrupt-controller;
> +            #interrupt-cells = <2>;
> +            msi-ranges = <&gicv2 GIC_SPI 128 IRQ_TYPE_EDGE_RISING 64>;
> +        };
> +    };
> -- 
> 2.35.3
> 

