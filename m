Return-Path: <linux-pci+bounces-7174-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D27A18BE76A
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2024 17:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 738B61F2366F
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2024 15:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3431635C2;
	Tue,  7 May 2024 15:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ueI4Ffa2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B671635AD;
	Tue,  7 May 2024 15:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715095689; cv=none; b=Sa7GcNPwTs/IwFpJt1OG3nPd6cOr3utVJ2VYRTnExW1JEYypBx3AFeLzQOIKNfxL0m+pIkMa8d+EYwdQ/g14fZMNRUNChcQYQopKbiL1nWNC+DTdxniI01tvxT24Y/8kCyjF0SlWKnbOLQeqpsyrElv4MTXK9XZAbAWIdD+XnjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715095689; c=relaxed/simple;
	bh=bUcqpluJn/Rz13IlYVuaIwusJC716KhD/mfqB0Uebho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OpSvBdD1bBUACfp0tr0J3wRUGLtJIkC9dtKCvyPul1y0m+iV0zrG69csmSoQVH8B8IFGpBJMbLCI++UIgMKgnlWiI2pLcK+csoklT1FU0snQwmxD6mqf6fKB1QP3qIE6XZpjIpYXiVrkwZ+Kra7XWtmUFOYhymQcD7VoTCWp53o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ueI4Ffa2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FB01C2BBFC;
	Tue,  7 May 2024 15:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715095688;
	bh=bUcqpluJn/Rz13IlYVuaIwusJC716KhD/mfqB0Uebho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ueI4Ffa2UP/l8ER+d2ogio+WDRRKPi8HfM/T1vAO/4bCgScbT+r9DNYauzo5C1MYL
	 pdK6e/VzyCPDazoPTSfT1LpEialTvuMiK3CrcnqCq57AgkcPodnFTWkpJMAvVOSW/F
	 7kqPyPZa1lv0tC3TDxcTtrs1Pt4kMUPZfRu6SM7gr6cvSShrAyaGeZEFY4V8ezGARB
	 e+Vcd1/IgP/OcvC1dAq048A4mpqAWJL9mzXU0sGPJ9ozqZTaTHZMlkTxwFMskI+OXH
	 259bXKgnoOYyd3YRgBSfU0A5OhiBSnKntiSjClNfnQKCjkFfClrI3CfU+Bus1iCHQs
	 ceTCaQQUGq9wQ==
Date: Tue, 7 May 2024 10:28:06 -0500
From: Rob Herring <robh@kernel.org>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Lee Jones <lee@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	UNGLinuxDriver@microchip.com, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Saravana Kannan <saravanak@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Lars Povlsen <lars.povlsen@microchip.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	netdev@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 09/17] dt-bindings: interrupt-controller: Add support for
 Microchip LAN966x OIC
Message-ID: <20240507152806.GA505222-robh@kernel.org>
References: <20240430083730.134918-1-herve.codina@bootlin.com>
 <20240430083730.134918-10-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430083730.134918-10-herve.codina@bootlin.com>

On Tue, Apr 30, 2024 at 10:37:18AM +0200, Herve Codina wrote:
> The Microchip LAN966x outband interrupt controller (OIC) maps the
> internal interrupt sources of the LAN966x device to an external
> interrupt.
> When the LAN966x device is used as a PCI device, the external interrupt
> is routed to the PCI interrupt.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
>  .../microchip,lan966x-oic.yaml                | 55 +++++++++++++++++++
>  1 file changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/microchip,lan966x-oic.yaml
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/microchip,lan966x-oic.yaml b/Documentation/devicetree/bindings/interrupt-controller/microchip,lan966x-oic.yaml
> new file mode 100644
> index 000000000000..b2adc7174177
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/microchip,lan966x-oic.yaml
> @@ -0,0 +1,55 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interrupt-controller/microchip,lan966x-oic.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip LAN966x outband interrupt controller
> +
> +maintainers:
> +  - Herve Codina <herve.codina@bootlin.com>
> +
> +allOf:
> +  - $ref: /schemas/interrupt-controller.yaml#
> +
> +description: |
> +  The Microchip LAN966x outband interrupt controller (OIC) maps the internal
> +  interrupt sources of the LAN966x device to an external interrupt.
> +  When the LAN966x device is used as a PCI device, the external interrupt is
> +  routed to the PCI interrupt.
> +
> +properties:
> +  compatible:
> +    const: microchip,lan966x-oic
> +
> +  '#interrupt-cells':
> +    const: 2
> +
> +  interrupt-controller: true
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - '#interrupt-cells'
> +  - interrupt-controller
> +  - interrupts
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    interrupt-controller@e00c0120 {
> +        compatible = "microchip,lan966x-oic";
> +        reg = <0xe00c0120 0x190>;

Looks like this is part of some larger block?

> +        #interrupt-cells = <2>;
> +        interrupt-controller;
> +        interrupts = <0>;
> +        interrupt-parent = <&intc>;
> +    };
> +...
> -- 
> 2.44.0
> 

