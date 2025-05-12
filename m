Return-Path: <linux-pci+bounces-27600-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A08AAB458A
	for <lists+linux-pci@lfdr.de>; Mon, 12 May 2025 22:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8D3419E766A
	for <lists+linux-pci@lfdr.de>; Mon, 12 May 2025 20:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02A229710B;
	Mon, 12 May 2025 20:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X1XChO32"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62BD1B6CF1;
	Mon, 12 May 2025 20:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747082333; cv=none; b=qWmx4uqfCpewz0EE9C1fb3OvbH+Rdgf0HoLU5IVDvd1G2vBWQMjvqLgRZ7z5L+xilYzuW9mMJGMCvDQrSVdLiUltjzvaTzgtdV0Th3n6Me4Q2kFDN6tSLVY5vWj2s0ocGHIo+wAZzAwe68fNzlSYzKM0ZoIrMVZxtIrSeqOXa7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747082333; c=relaxed/simple;
	bh=kg9NkMy5B4dPI9xo/pe0LzyIjCV0NLlaNIUzv5DOXcg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=aaAerYhmXZM/Kj2IxT2hODyE0JjminQemFrZ4YNrnQsbSqHaltOV9gLRiavSRjzqHLea9lfHIyN/WVVhpJD4Rm1CatI0QahKnt6FDnAdYDZxaNsFc0CtvLEhkeuaIB5gNEC+CKZpj8vYl3oX7SgcU0gsBtM306ZcCGQOsvyNsKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X1XChO32; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC5DBC4CEE7;
	Mon, 12 May 2025 20:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747082333;
	bh=kg9NkMy5B4dPI9xo/pe0LzyIjCV0NLlaNIUzv5DOXcg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=X1XChO32f0KRB15Adrdya0tZA9RsWZyHi2OyQM90f2f/DxA6HtAIgEERcssph1xl+
	 G3aHwg214YRXq5YCiyZnqaO2iHunQAmi4DFZlpNulNG0jItWntZFyXyIUKnqtV5MJz
	 nCOAb8aSdo1iTQ/vL7nM+j5svpuy9h6AQwiV7C5nZAtbyS1uZ1sWOYO5eZnOgmyqO1
	 GQmz9jpyeCjzc+G1dqd18yFN9PuOL5ojTAgLQfAeg+lcifseYw1r0lAMDVH06EP4LE
	 rFDf3QFMwq+rOz/Obx6SZ0Kp+5u2PEfUpjkEAYD24Z0ItIPu4LYYhRf6iXYhTqrJIn
	 I2NOY1KOmJQ6g==
Date: Mon, 12 May 2025 15:38:51 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, geert+renesas@glider.be,
	magnus.damm@gmail.com, mturquette@baylibre.com, sboyd@kernel.org,
	saravanak@google.com, p.zabel@pengutronix.de,
	linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH 5/8] PCI: rzg3s-host: Add Initial PCIe Host Driver for
 Renesas RZ/G3S SoC
Message-ID: <20250512203851.GA1127434@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <869269a7-8267-45f3-9e4d-678de18c0888@tuxon.dev>

On Fri, May 09, 2025 at 01:29:40PM +0300, Claudiu Beznea wrote:
> On 05.05.2025 14:26, Claudiu Beznea wrote:
> > On 01.05.2025 23:12, Bjorn Helgaas wrote:
> >> On Wed, Apr 30, 2025 at 01:32:33PM +0300, Claudiu wrote:
> >>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >>>
> >>> The Renesas RZ/G3S features a PCIe IP that complies with the PCI Express
> >>> Base Specification 4.0 and supports speeds of up to 5 GT/s. It functions
> >>> only as a root complex, with a single-lane (x1) configuration. The
> >>> controller includes Type 1 configuration registers, as well as IP
> >>> specific registers (called AXI registers) required for various adjustments.
> >>>
> >>> Other Renesas RZ SoCs (e.g., RZ/G3E, RZ/V2H) share the same AXI registers
> >>> but have both Root Complex and Endpoint capabilities. As a result, the PCIe
> >>> host driver can be reused for these variants with minimal adjustments.
> ...

> >>> +static void rzg3s_pcie_update_bits(void __iomem *base, u32 offset, u32 mask, u32 val)
> >>> +{
> >>> +	u32 tmp;
> >>> +
> >>> +	tmp = readl(base + offset);
> >>> +	tmp &= ~mask;
> >>> +	tmp |= val & mask;
> >>> +	writel(tmp, base + offset);
> >>> +}
> >>
> >> Nothing rzg3s-specific here.
> >>
> >> I think u32p_replace_bits() (include/linux/bitfield.h) is basically this.
> > 
> > I wasn't aware of it. I'll use it in the next version. Thank for pointing it.
> 
> I look into changing to u32p_replace_bits() but this one needs a mask that
> can be verified at build time. It cannot be used directly in this function.
> Would you prefer me to replace all the calls to rzg3s_pcie_update_bits() with:
> 
> tmp = readl();
> u32p_replace_bits(&tmp, ...)
> writel(tmp);

It seems like this is the prevailing way it's used.

You have ~20 calls, so it seems like it might be excessive to replace
each with readl/u32p_replace_bits/writel.

But maybe you could use u32p_replace_bits() inside
rzg3s_pcie_update_bits().

Bjorn

