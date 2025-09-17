Return-Path: <linux-pci+bounces-36381-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0153B81E98
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 23:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B70F3ABA21
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 21:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080AF19F40A;
	Wed, 17 Sep 2025 21:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eAFvS4Aj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC2610F1;
	Wed, 17 Sep 2025 21:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758143907; cv=none; b=OZjhohn4bDxOaPB4rU0WKXf99DdRPE9KKSbT2rCbw7nBXg8TSbc0SyK05HvAsjgYznf/d1ArlrCV/hJF3cNwJf71RzJRsL3aiv9KtZsxJl+WXr3v8Ib6FqfwQ8XnTydwUAJGWAXttd0iLQqptB1dUUYVn8y71Etr8/8amFwg/Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758143907; c=relaxed/simple;
	bh=Dkf08spIxA201bgB3U6VQQ/RiMff9Y1iizvcrMd6Ipw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=JT5m/XqCV4fp8idzWbVvXAah0RRoccijXt9Ldrh924OKAXBux8fdOamRqumUrsu7a8bxiwaOP3uanQ9Nzvh9jBIT3m0hTOCWFtoKpCqWuLmhjDCwWXnVylXr1cmeGi+csz1cmMoJ08fsY42IIRWrRPwIEmhTaWm0WEImfe/M0qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eAFvS4Aj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29A0DC4CEE7;
	Wed, 17 Sep 2025 21:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758143907;
	bh=Dkf08spIxA201bgB3U6VQQ/RiMff9Y1iizvcrMd6Ipw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=eAFvS4Ajgc6dGXw+wpqk+89BbU6NxbLokTy88t5guS8V8kgaePfP/jBJ9cMNWnzG/
	 91uRTY7+56XLBLzDMi+MfWFAb3cKziHq8Op1EUnuPj7A5jt0cIc3zH1+MaH0t2bxoy
	 M74PI70kJJ7TH38wdUF0G+WuPgFK81TNHc4Iypc1a+5+uKmFR4i3hTg55ScwFiEZ3j
	 ZKFZaL31t7v6IGmdDn6taTUJugECvKCNJL3iIt0iPM53wtdsq9KCFY/mBl0oRNGXmD
	 1SXJ1JaF5aAGcpUWX6X2mSPDX1qEd4rjAiduq1luH+E/zBu70acdYR1EGl4uJaJIga
	 SwMvK40TkXXpg==
Date: Wed, 17 Sep 2025 16:18:25 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: chester62515@gmail.com, mbrugger@suse.com,
	ghennadi.procopciuc@oss.nxp.com, s32@nxp.com, lpieralisi@kernel.org,
	kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, Ionut.Vicovan@nxp.com,
	larisa.grigore@nxp.com, Ghennadi.Procopciuc@nxp.com,
	ciprianmarian.costea@nxp.com, bogdan.hamciuc@nxp.com,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: pcie: Add the NXP PCIe controller
Message-ID: <20250917211825.GA1874549@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912141436.2347852-2-vincent.guittot@linaro.org>

Suggest following convention for subject lines (run "git log --oneline
Documentation/devicetree/bindings/pci/"), e.g.,

  dt-bindings: PCI: s32g: Add NXP PCIe controller

On Fri, Sep 12, 2025 at 04:14:33PM +0200, Vincent Guittot wrote:
> Describe the PCIe controller available on the S32G platforms.

> +        pcie0: pcie@40400000 {
> +            compatible = "nxp,s32g3-pcie",
> +                         "nxp,s32g2-pcie";
> +            dma-coherent;
> +            reg = <0x00 0x40400000 0x0 0x00001000>,   /* dbi registers */
> +                  <0x00 0x40420000 0x0 0x00001000>,   /* dbi2 registers */
> +                  <0x00 0x40460000 0x0 0x00001000>,   /* atu registers */
> +                  <0x00 0x40470000 0x0 0x00001000>,   /* dma registers */
> +                  <0x00 0x40481000 0x0 0x000000f8>,   /* ctrl registers */
> +                  /* RC configuration space, 4KB each for cfg0 and cfg1
> +                   * at the end of the outbound memory map
> +                   */
> +                  <0x5f 0xffffe000 0x0 0x00002000>,
> +                  <0x58 0x00000000 0x0 0x40000000>; /* 1GB EP addr space */
> +                  reg-names = "dbi", "dbi2", "atu", "dma", "ctrl",
> +                              "config", "addr_space";

Looks like an indentation error.  Shouldn't "reg-names" and subsequent
properties be aligned under "reg"?

> +                  #address-cells = <3>;
> +                  #size-cells = <2>;
> +                  device_type = "pci";
> +                  ranges =
> +                  /* downstream I/O, 64KB and aligned naturally just
> +                   * before the config space to minimize fragmentation
> +                   */
> +                  <0x81000000 0x0 0x00000000 0x5f 0xfffe0000 0x0 0x00010000>,
> +                  /* non-prefetchable memory, with best case size and
> +                  * alignment
> +                   */
> +                  <0x82000000 0x0 0x00000000 0x58 0x00000000 0x7 0xfffe0000>;
> +
> +                  nxp,phy-mode = "crns";

If "nxp,phy-mode" goes with "phys", should it be adjacent to it?

> +                  bus-range = <0x0 0xff>;
> +                  interrupts =  <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>,
> +                                <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
> +                                <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
> +                                <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>,
> +                                <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>,
> +                                <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>,
> +                                <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>,
> +                                <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>;
> +                  interrupt-names = "link_req_stat", "dma", "msi",
> +                                    "phy_link_down", "phy_link_up", "misc",
> +                                    "pcs", "tlp_req_no_comp";
> +                  #interrupt-cells = <1>;
> +                  interrupt-map-mask = <0 0 0 0x7>;
> +                  interrupt-map = <0 0 0 1 &gic 0 0 0 128 4>,
> +                                  <0 0 0 2 &gic 0 0 0 129 4>,
> +                                  <0 0 0 3 &gic 0 0 0 130 4>,
> +                                  <0 0 0 4 &gic 0 0 0 131 4>;
> +                  msi-parent = <&gic>;
> +
> +                  num-lanes = <2>;
> +                  phys = <&serdes0 PHY_TYPE_PCIE 0 0>;
> +        };
> +    };

