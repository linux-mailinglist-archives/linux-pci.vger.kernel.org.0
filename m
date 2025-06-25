Return-Path: <linux-pci+bounces-30660-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16163AE8FDA
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 23:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75D861889399
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 21:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3833D20C46D;
	Wed, 25 Jun 2025 21:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fcsXt6oS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27171C84DF;
	Wed, 25 Jun 2025 21:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750885498; cv=none; b=RnadZxYpuRbXYsZEfzZdZjY0gJZ5+IEq/yEAeG0sjP0CPFbMtV43qygdGSQaOHR3M4XA0ZTIUQWTJOh3mpA2slOF3PofkQxRxav6nYwF3eisI7Pi4cLxJkQWSLMXI8p2zGbSZuyVtiwnSIpoD82UgBRH2GYBfsdYjLmd4o4/9Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750885498; c=relaxed/simple;
	bh=TwGs9xcqNKKZwXveR38XoItJjJjoTUCut41NngfDuik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jnOe2mImGgwIgZDR6q7iH/yOUidOx3q4y0IrTLzLw+MRGnRvZXWCFdn7SDWcf35Mha4jlFpl8pZG467tx8NL5aQvcAg6L8V8OWQ3X2xTopo36yPMhkeZFO4eQDtEki/TgQftMLm90OUXnw1rMjUnTRCtZ8LM0QhJzx9xYKAJhvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fcsXt6oS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DDAFC4CEEA;
	Wed, 25 Jun 2025 21:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750885497;
	bh=TwGs9xcqNKKZwXveR38XoItJjJjoTUCut41NngfDuik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fcsXt6oS90PgQatLapdwcdjg5ia5EOeRBAAxyHyXaqEq509DGgKqAH4YB16oiKVbi
	 gCHFaQ6danRokdU3VaXQHaDBpqN/4H24MIIog8UlfyAJYxnzu99ooq2/0+YXRDMXjk
	 a9h+XgpAz6LVGHwkYUTGPmFSqAw6Rfoq3exAjLjg2aU6Zz53xULEhZAIRc0t8jhoT9
	 keXTLpmUQpCKAziaUZLLNRHIFLP9x6Qp6neDgp5c2sLkHaPj7K9hMh7DOMSGfE1WEI
	 Dn4XES7ca5/ZSM6IXyhhIwbx4CwW+gZ1caGsKqpyzW1G/Hnkz0ubIxFbpmYQvQhnkv
	 O3QPMeeYOd9Og==
Date: Wed, 25 Jun 2025 16:04:56 -0500
From: Rob Herring <robh@kernel.org>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	joel@jms.id.au, andrew@codeconstruct.com.au, vkoul@kernel.org,
	kishon@kernel.org, linus.walleij@linaro.org, p.zabel@pengutronix.de,
	linux-aspeed@lists.ozlabs.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
	openbmc@lists.ozlabs.org, linux-gpio@vger.kernel.org,
	elbadrym@google.com, romlem@google.com, anhphan@google.com,
	wak@google.com, yuxiaozhang@google.com, BMC-SW@aspeedtech.com
Subject: Re: [PATCH 3/7] dt-bindings: pci: Add document for ASPEED PCIe RC
Message-ID: <20250625210456.GA2177479-robh@kernel.org>
References: <20250613033001.3153637-1-jacky_chou@aspeedtech.com>
 <20250613033001.3153637-4-jacky_chou@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613033001.3153637-4-jacky_chou@aspeedtech.com>

On Fri, Jun 13, 2025 at 11:29:57AM +0800, Jacky Chou wrote:
> Add device tree binding documentation for the ASPEED PCIe Root Complex
> controller. This binding describes the required and optional properties
> for configuring the PCIe RC node, including support for syscon phandles,
> MSI, clocks, resets, and interrupt mapping. The schema enforces strict
> property validation and provides a comprehensive example for reference.
> 
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
> ---
>  .../devicetree/bindings/pci/aspeed-pcie.yaml  | 159 ++++++++++++++++++
>  1 file changed, 159 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/aspeed-pcie.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/aspeed-pcie.yaml b/Documentation/devicetree/bindings/pci/aspeed-pcie.yaml
> new file mode 100644
> index 000000000000..5b50a9e2d472
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/aspeed-pcie.yaml
> @@ -0,0 +1,159 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/aspeed-pcie.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ASPEED PCIe Root Complex Controller
> +
> +maintainers:
> +  - Jacky Chou <jacky_chou@aspeedtech.com>
> +
> +description: |
> +  Device tree binding for the ASPEED PCIe Root Complex controller.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - aspeed,ast2600-pcie
> +      - aspeed,ast2700-pcie
> +
> +  device_type:
> +    const: pci
> +
> +  reg:
> +    maxItems: 1
> +
> +  ranges:
> +    minItems: 2
> +    maxItems: 2
> +
> +  interrupts:
> +    description: IntX and MSI interrupt
> +
> +  resets:
> +    items:
> +      - description: Module reset
> +      - description: PCIe PERST
> +
> +  reset-names:
> +    items:
> +      - const: h2x
> +      - const: perst
> +
> +  msi-parent: true
> +
> +  msi_address:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: MSI address

What's this for?

> +
> +  aspeed,ahbc:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: Phandle to ASPEED AHBC syscon.
> +
> +  aspeed,pciecfg:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: Phandle to ASPEED PCIe configuration syscon.
> +
> +  aspeed,pciephy:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: Phandle to ASPEED PCIe PHY syscon.

Use the phy binding and make the phy control a separate driver.

Rob

