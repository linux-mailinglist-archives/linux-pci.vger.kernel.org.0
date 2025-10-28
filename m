Return-Path: <linux-pci+bounces-39535-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 567D1C14FA2
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 14:51:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF93C6405A6
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 13:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155D121CA0D;
	Tue, 28 Oct 2025 13:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HyngrGjL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D929B1FE45A;
	Tue, 28 Oct 2025 13:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761659206; cv=none; b=Gg5sY+R+CYxeHEZ9ErRL0XGtMebZHCYwTuCFLoI/gRuxCLIC7WWtdT2WuLFB5virbNVpaLGKnFPzqWbWTd5hoyQKbMQyA6EXf55giYGMpD/nT9SK42pclsTu3T8TBKPvlM+eq3iOWutIc6PuO/G7cJlURA1XgAWgSHNchwIfKJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761659206; c=relaxed/simple;
	bh=gHTXG47ZT83HtioVGkOdOgeWLg99afniblJgeCrheGk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ey9yq7A9MC5AZzaN5Nm84nFwIq0iy/DaIVX4lrpUtpalMj/31FbFvIQ9VAIVrlGQg7YfPDOsR7Sla4Ny+rmKdVULOz4JyrqmtluubS9kd+b+1baFyjPN/YU35a4ahfWUC2YmfqtZvueT3T7KBXWZbqYOIWo4gvpfpeoDpYPpH/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HyngrGjL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4601DC116C6;
	Tue, 28 Oct 2025 13:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761659205;
	bh=gHTXG47ZT83HtioVGkOdOgeWLg99afniblJgeCrheGk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=HyngrGjLb54dCOStOExNIW8Y0NWfQzBXP7/lfZg2CrXY7+IMVLq42u0PG+z1cEhOL
	 M9rvJLEAEy7zeEAWnuV/unlMTMS3/MUsv0ix70sVbD2swTqZWjJ73oXB/FnRpo6ibM
	 5estbSa3g/FRLspY7MtCd9VANbOrV9/5esg2D/G+7NIUhmjdRsQO8xY/aVRcPYRGXb
	 X/UIMn6YkUr50ydC9753IDyWw8dnp67i7nUJy9ediQGszIl+HEj5mZ17iKfEPbiCQI
	 yV1LFP3RB+1kFvEmWfqvRVyp0cXJ70Zaz3/Whr5ecoe3Wqctp9aXbfY9yaLyAIIFK6
	 M+094b4nEUMzQ==
Date: Tue, 28 Oct 2025 08:46:44 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	robh@kernel.org, bhelgaas@google.com, krzk+dt@kernel.org,
	conor+dt@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au,
	vkoul@kernel.org, kishon@kernel.org, linus.walleij@linaro.org,
	p.zabel@pengutronix.de, linux-aspeed@lists.ozlabs.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org, openbmc@lists.ozlabs.org,
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH v4 2/9] dt-bindings: PCI: Add ASPEED PCIe RC support
Message-ID: <20251028134644.GA1506590@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027095825.181161-3-jacky_chou@aspeedtech.com>

On Mon, Oct 27, 2025 at 05:58:18PM +0800, Jacky Chou wrote:
> ASPEED AST2600 provides one PCIe RC for Gen2 and AST2700 provides three
> PCIe RC for two Gen4 and one Gen2. All of these RCs have just one root
> port to connect to PCIe device. And also have Mem, I/O access, legacy
> interrupt and MSI.

> +description:
> +  The ASPEED PCIe Root Complex controller provides PCI Express Root Complex
> +  functionality for ASPEED SoCs, such as the AST2600 and AST2700.
> +  This controller enables connectivity to PCIe endpoint devices, supporting
> +  memory and I/O windows, MSI and legacy interrupts, and integration with
> +  the SoC's clock, reset, and pinctrl subsystems. On AST2600, the PCIe Root
> +  Port device number is always 8.

s/legacy/INTx/

> +properties:
> +  compatible:
> +    enum:
> +      - aspeed,ast2600-pcie
> +      - aspeed,ast2700-pcie
> +
> +  reg:
> +    maxItems: 1
> +
> +  ranges:
> +    minItems: 2
> +    maxItems: 2
> +
> +  interrupts:
> +    maxItems: 1
> +    description: IntX and MSI interrupt

s/IntX/INTx/

> +    pcie0: pcie@1e770000 {
> +      compatible = "aspeed,ast2600-pcie";
> +      device_type = "pci";
> +      reg = <0x1e770000 0x100>;
> +      #address-cells = <3>;
> +      #size-cells = <2>;
> +      interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>;
> +      bus-range = <0x00 0xff>;
> +
> +      ranges = <0x01000000 0x0 0x00018000 0x00018000 0x0 0x00008000
> +                0x02000000 0x0 0x60000000 0x60000000 0x0 0x20000000>;
> +
> +      resets = <&syscon ASPEED_RESET_H2X>;
> +      reset-names = "h2x";
> +      pinctrl-0 = <&pinctrl_pcierc1_default>;
> +      pinctrl-names = "default";
> +
> +      #interrupt-cells = <1>;
> +      msi-controller;
> +
> +      aspeed,ahbc = <&ahbc>;
> +
> +      interrupt-map-mask = <0 0 0 7>;
> +      interrupt-map = <0 0 0 1 &pcie_intc0 0>,
> +                      <0 0 0 2 &pcie_intc0 1>,
> +                      <0 0 0 3 &pcie_intc0 2>,
> +                      <0 0 0 4 &pcie_intc0 3>;
> +      legacy-interrupt-controller {
> +        interrupt-controller;
> +        #address-cells = <0>;
> +        #interrupt-cells = <1>;
> +      };

IIUC, Rob says there's no need for a separate interrupt-controller
stanza and it can be directly in the host bridge [1].

I think that does make interrupt-map a little more verbose because the
parent unit address will use the host bridge #address-cells (3)
instead of the interrupt controller #address-cells (0), e.g., this
from [2]:

  pcie@10e40000 {
      compatible = "renesas,r9a08g045-pcie";
      #address-cells = <3>;
      #interrupt-cells = <1>;
      interrupt-map = <0 0 0 1 &pcie 0 0 0 0>, /* INTA */
                      <0 0 0 2 &pcie 0 0 0 1>, /* INTB */
                      <0 0 0 3 &pcie 0 0 0 2>, /* INTC */
                      <0 0 0 4 &pcie 0 0 0 3>; /* INTD */

[1] https://lore.kernel.org/linux-pci/20250509204905.GA4080349-robh@kernel.org/
[2] https://lore.kernel.org/linux-pci/20251007133657.390523-2-claudiu.beznea.uj@bp.renesas.com/

