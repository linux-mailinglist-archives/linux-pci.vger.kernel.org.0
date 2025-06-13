Return-Path: <linux-pci+bounces-29751-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA663AD921E
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 17:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE312188E0B1
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 15:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A75BB18DB29;
	Fri, 13 Jun 2025 15:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gFPoa516"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714991FF1C4;
	Fri, 13 Jun 2025 15:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749830100; cv=none; b=A2VCQPICeoj9kH0MtLNy0UZpPNeE4plJU3WbtVtjZF6fPcHpGE4czzhcBQNCLr0slvuodpAhM91JPa3SYEAGnkW3oiYnmkwNh1Ytu2p0WvJlG56fx+psSNcayX/bEJfSlRFnXjTiw+BVIkgQc5r1kAhbZ8xRRarP5yxtymNXMKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749830100; c=relaxed/simple;
	bh=txoIyDrG2vubdoOdTiTdmcJQb8y7qy5caM50Zd8G8to=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=civ7wAVSSRrQNNQIKVpUL+/GP7hbtxYZ2WfH8rTPjH2gO2Fs1pitLNRMCNsmm4HEsjM0eeN/aOXaatVlD7GfE7touHrF0cidM7uNM1VMeXA6QvaSx8m7znWkRyyQQtxGmIzD5vD3x+chyzoV8zdpIRYJ7oXE1hYDFK+Ev1Ucwko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gFPoa516; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B42EBC4CEED;
	Fri, 13 Jun 2025 15:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749830099;
	bh=txoIyDrG2vubdoOdTiTdmcJQb8y7qy5caM50Zd8G8to=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=gFPoa516Ela1DPXpH0f6/CS5GkNUbZK3nAYpFk07eqEgd3MKAhYJpF0s0lR7On5mh
	 mTRs3hEkjNSmkoYXNNxat0V6bY1VSuL9RUaPNvJuo+3M4NxXHk18J9uIsBuF7BfZSP
	 LT2mpCyuW/nNNqy98L7h2qv/SXJaaEYTKmk9KlAx8hO5gtnc+f8HFC2H9FWk4DGBfW
	 6JdxNAw5ZVa4sVUYSYyFngUyMNeio0PIqep0t3E5XJuUwayNZIlc1Um9AsPD8fsgtD
	 LX9RVvGngHT5S7OMOIWzgnwkmg0oDRjT3tctQgL7cXq2tYr8yGsydjYdO2oCDGOE4x
	 7e6vKtWFkarMA==
Date: Fri, 13 Jun 2025 10:54:58 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au,
	vkoul@kernel.org, kishon@kernel.org, linus.walleij@linaro.org,
	p.zabel@pengutronix.de, linux-aspeed@lists.ozlabs.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org, openbmc@lists.ozlabs.org,
	linux-gpio@vger.kernel.org, elbadrym@google.com, romlem@google.com,
	anhphan@google.com, wak@google.com, yuxiaozhang@google.com,
	BMC-SW@aspeedtech.com
Subject: Re: [PATCH 5/7] ARM: dts: aspeed-g6: Add PCIe RC node
Message-ID: <20250613155458.GA962010@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613033001.3153637-6-jacky_chou@aspeedtech.com>

On Fri, Jun 13, 2025 at 11:29:59AM +0800, Jacky Chou wrote:
> The AST2600 has one PCIe RC, and add the relative configure regmap.

> +			pcie0: pcie@1e7700c0 {
> +				compatible = "aspeed,ast2600-pcie";
> +				device_type = "pci";
> +				reg = <0x1e7700c0 0x40>;
> +				linux,pci-domain = <0>;
> +				#address-cells = <3>;
> +				#size-cells = <2>;
> +				interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>;
> +				bus-range = <0x80 0xff>;
> +
> +				ranges = <0x01000000 0x0 0x00018000 0x00018000 0x0 0x00008000
> +					  0x02000000 0x0 0x70000000 0x70000000 0x0 0x10000000>;
> +
> +				status = "disabled";
> +
> +				resets = <&syscon ASPEED_RESET_H2X>,
> +					 <&syscon ASPEED_RESET_PCIE_RC_O>;
> +				reset-names = "h2x", "perst";

PERST# is clearly a per-Root Port item since it's a signal on the PCIe
connector.  Can you separate this and any other per-Root Port things
into a Root Port stanza to leave open the possibility of future
hardware that supports multiple Root Ports in the RC?

> +				clocks = <&syscon ASPEED_CLK_GATE_BCLK>;
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&pinctrl_pcierc1_default>;
> +
> +				#interrupt-cells = <1>;
> +				msi-parent = <&pcie0>;
> +				msi-controller;
> +				msi_address = <0x1e77005c>;
> +
> +				aspeed,ahbc = <&ahbc>;
> +				aspeed,pciecfg = <&pcie_cfg>;
> +				aspeed,pciephy = <&pcie_phy1>;
> +
> +				interrupt-map-mask = <0 0 0 7>;
> +				interrupt-map = <0 0 0 1 &pcie_intc0 0>,
> +						<0 0 0 2 &pcie_intc0 1>,
> +						<0 0 0 3 &pcie_intc0 2>,
> +						<0 0 0 4 &pcie_intc0 3>;
> +				pcie_intc0: interrupt-controller {
> +					interrupt-controller;
> +					#address-cells = <0>;
> +					#interrupt-cells = <1>;
> +				};
> +			};
> +
>  			gfx: display@1e6e6000 {
>  				compatible = "aspeed,ast2600-gfx", "syscon";
>  				reg = <0x1e6e6000 0x1000>;
> -- 
> 2.43.0
> 

