Return-Path: <linux-pci+bounces-39841-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF59C21A38
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 19:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB1C6426258
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 18:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D309336E34D;
	Thu, 30 Oct 2025 17:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oNnsiej4"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42F736E34A;
	Thu, 30 Oct 2025 17:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761847195; cv=none; b=NQ+gN8uEu3x6huk5cPop5/xb54h04zu5emWMz6McSwOG+G8mDhNS3XYuEFkmCj6ZD9YQYh6aYS5VDIXZe+IfGOAZuB7ovfjoHoIuzIO9iVFnTm6yjYsIsMpkZYnrqwpyokqf9AuvGw8Q5FdrThlFYyhu1hXY7yipuUE4k6C8iDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761847195; c=relaxed/simple;
	bh=h0ipM/BWZPsQCfO25zxjboY03nvD5uWK03JE4hkZA8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mBb+cyLy+RENKUkKKLn6DNe2Ah1is1XvQQCuoLEF96EYJkIx0PYpVR99nCIVqI1QW/wq1y85gbWbhSU7fA1S2gmD3yVo/5T3lj56YKRj2/rCyUDYTEFTN8XV0wiwk+NiRVtDUh18TrEunMsSoRZQwyf8C4IBTaHvCGdr+SreQzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oNnsiej4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDB53C4CEF1;
	Thu, 30 Oct 2025 17:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761847195;
	bh=h0ipM/BWZPsQCfO25zxjboY03nvD5uWK03JE4hkZA8Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oNnsiej4SXmm7oiLxoIflx7LxfGiKJNA8E6KTHpNm2wSoaAcfDRCYt/7DV4cQ3tfV
	 Q8fwwNYdp6u4etsjCWWHFC8NmLRuhvUzFiEWsxiQAq4USfR6NOz2gL5yyBMe+r3Bsv
	 mjQAes7cAZnlEv2gu8r1NcfxQYy+oZ6OaeINg5vopVBM6cp6McS1qbCgq6GRbgdZLI
	 gN1RHDXAamY1Mi9VzThn5txxR+xB0/kZMOfKGFbDU5lqVdEMJbaOVkKlyWKcHoQcQ4
	 1o1RERVdqosikwyE4KB99ifAHQJSsEOYZwloQcL6kcwpJ2RL+xNwhL6V3sEQv/v9Mx
	 jqRG6B1GNcC+Q==
Date: Thu, 30 Oct 2025 12:59:52 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: magnus.damm@gmail.com, mani@kernel.org, geert+renesas@glider.be,
	linux-renesas-soc@vger.kernel.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	kwilczynski@kernel.org, lpieralisi@kernel.org,
	linux-pci@vger.kernel.org, bhelgaas@google.com,
	p.zabel@pengutronix.de, krzk+dt@kernel.org
Subject: Re: [PATCH v6 1/6] dt-bindings: PCI: renesas,r9a08g045s33-pcie: Add
 Renesas RZ/G3S
Message-ID: <176184719160.107873.6758057982027005813.robh@kernel.org>
References: <20251029133653.2437024-1-claudiu.beznea.uj@bp.renesas.com>
 <20251029133653.2437024-2-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029133653.2437024-2-claudiu.beznea.uj@bp.renesas.com>


On Wed, 29 Oct 2025 15:36:48 +0200, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> The PCIe IP available on the Renesas RZ/G3S complies with the PCI Express
> Base Specification 4.0. It is designed for root complex applications and
> features a single-lane (x1) implementation. Add documentation for it.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
> 
> Changes in v6:
> - updated the patch title
> - described the functionalites that system controller has for PCIe
> - dropped /schemas/pci/pci-device.yaml# from allOf section
> - dropped max-link-speed from example
> - dropped pcie_port0 label from example
> 
> Changes in v5:
> - dropped Tb tag
> - style updates to the dma-ranges and ranges properties from
>   examples section
> - re-enabled the node from examples section
> 
> Changes in v4:
> - dropped "s33" string from compatible name
> - added port node documentation; due to this dropped Rob's Rb tag
> - reorderded properties
> - dropped spaces b/w "INT" and "A", "B", "C", "D" in comments
> 
> Changes in v3:
> - collected tags
> - updated the flags of ranges property from example
> 
> Changes in v2:
> - update the interrupt names by dropping "int" and "rc" string; due
>   to this the patch description was adjusted
> - added "interrupt-controller" and made it mandatory
> - s/clkl1pm/pm/g
> - dropped the legacy-interrupt-controller node; with this the gic
>   interrupt controller node was dropped as well as it is not needed
>   anymore
> - updated interrupt-map in example and added interrupt-controller
> - added clock-names as required property as the pm clock is not
>   handled though PM domains; this will allow the driver to have
>   the option to request the pm clock by its name when implementation
>   will be adjusted to used the pm clock
> - adjusted the size of dma-ranges to reflect the usage on
>   SMARC module board
> - moved "renesas,sysc" at the end of the node in example to align
>   with dts coding style
> 
>  .../bindings/pci/renesas,r9a08g045-pcie.yaml  | 249 ++++++++++++++++++
>  1 file changed, 249 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/renesas,r9a08g045-pcie.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


