Return-Path: <linux-pci+bounces-32246-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18AA4B07062
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 10:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28E944E229B
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 08:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999702EAB7B;
	Wed, 16 Jul 2025 08:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OsuSqHmD"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696AC2EA727;
	Wed, 16 Jul 2025 08:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752654221; cv=none; b=k8V2HnJhGSOBMWc5GbczBC1UbV2aYp6lbdBH9JPYPJXV1SE88T/jpRtbi3gGh7+GB3DXe5uaG9JIJKrHzN8wwSW9582Fua1cSBx4zl6UCerOva0QxQE1iNAiYzX8TUQADtNDFU5RLZOCSUi2CBGTqJ/7qi5HMzjHUxPJVGJvUi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752654221; c=relaxed/simple;
	bh=cp2m1cQPpeNT2d53wsl0tGzY5ODL2sh/xGBe89ivRr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TDeWA8hOYse2zp7wBL9zaaPzxBG0CzsX/JfIzj8qk+0bTiQZ0siGG300jtotrVWWBH0jm3hNqJfPwLSRLIAo+ZfX+U7A9O9bHv9DFnQmTMOvq+LHoLEjneUTUIiwbszmLGgUGYMN7u+jBfkc2X7MfF2dZr3XKoFjmbhOPH0o1Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OsuSqHmD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A6F9C4CEF0;
	Wed, 16 Jul 2025 08:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752654218;
	bh=cp2m1cQPpeNT2d53wsl0tGzY5ODL2sh/xGBe89ivRr4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OsuSqHmDg5QaUkjKR88pXkBRjXFiGTJmpqIR2xTr5Z9U1Ok9P/L5vM+a06yTG3toz
	 at3wk0tkzeoEdt0BukhNBUIqcbPqs732/P+an+XUDciRV3hHnaPzyNPpyHmN8OXYWc
	 BfRruYWHr+/kBdTkHGaGdfGb+meDtFsBpDNxR8r2f82JlPhK7gakGM2tsl+l0OjIcU
	 sPZL6T47LdaQ43C70ikZe6EPoBxS36V78shXEYhmf5W5W03iRjAkjgrj8TRd3Atm+c
	 WmPx1C5+9MA91F/pTTKGPiALFC+YTLSWiyrLEBh89IIL12Ks8wyLQ+BJCGLvU8rGQb
	 MpkLR0taXi9CA==
Date: Wed, 16 Jul 2025 10:23:36 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org, 
	mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	joel@jms.id.au, andrew@codeconstruct.com.au, linux-aspeed@lists.ozlabs.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org, linux-gpio@vger.kernel.org, 
	linus.walleij@linaro.org, p.zabel@pengutronix.de, BMC-SW@aspeedtech.com
Subject: Re: [PATCH v2 02/10] dt-bindings: soc: aspeed: Add ASPEED PCIe PHY
 support
Message-ID: <20250716-innocent-satisfied-pug-9ecc15@krzk-bin>
References: <20250715034320.2553837-1-jacky_chou@aspeedtech.com>
 <20250715034320.2553837-3-jacky_chou@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250715034320.2553837-3-jacky_chou@aspeedtech.com>

On Tue, Jul 15, 2025 at 11:43:12AM +0800, Jacky Chou wrote:
> This PHY is used by many modules. In our design, our
> PCIe has RC and EP funcitons. On the different function,
> each driver will use configure and get some information
> from the PHY interface to do somting that it wants to.
> Getting link status, setting syscon credits and so on.
> Therefore, define it as syscon for all modules.
> 
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
> ---
>  .../bindings/soc/aspeed/aspeed,pcie-phy.yaml  | 44 +++++++++++++++++++
>  1 file changed, 44 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/aspeed/aspeed,pcie-phy.yaml

Phys go to phy, not soc directory. Soc is not a dumping ground.

> 
> diff --git a/Documentation/devicetree/bindings/soc/aspeed/aspeed,pcie-phy.yaml b/Documentation/devicetree/bindings/soc/aspeed/aspeed,pcie-phy.yaml
> new file mode 100644
> index 000000000000..5fa585d63ca6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/aspeed/aspeed,pcie-phy.yaml
> @@ -0,0 +1,44 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/aspeed/aspeed,pcie-phy.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ASPEED PCIe PHY
> +
> +maintainers:
> +  - Jacky Chou <jacky_chou@aspeedtech.com>
> +
> +description:
> +  The ASPEED PCIe PHY provides the physical layer interface for PCIe
> +  controllers in the SoC. This node represents the register block for the PCIe
> +  PHY, which is typically accessed by PCIe Root Complex or Endpoint drivers
> +  via syscon. It is used to configure and get the status of the PCIe PHY
> +  hardware, including power management, link training, and other PHY-specific
> +  operations.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - aspeed,pcie-phy

No, see writing bindings.

> +      - const: syscon

It's not a syscon, but phy. I don't think you understood previous
feedback. Go back to v1. You just send something to pass the review
instead of reworking to make it correct.

> +
> +  reg:
> +    maxItems: 1
> +
> +  "#phy-cells":
> +    const: 0
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    syscon@1e6ed200 {

wrong name, that's a phy

> +      compatible = "aspeed,pcie-phy", "syscon";
> +      reg = <0x1e6ed200 0x100>;

Incomplete

> +    };
> -- 
> 2.43.0
> 

