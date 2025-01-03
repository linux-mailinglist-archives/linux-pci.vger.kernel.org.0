Return-Path: <linux-pci+bounces-19252-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 434A5A00E36
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 20:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B2613A3EF9
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 19:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C3B1FC7D1;
	Fri,  3 Jan 2025 19:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FP/2iUAU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B121FA8FA;
	Fri,  3 Jan 2025 19:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735930968; cv=none; b=HKAHKGlFqaPwueZJe2R8Zuaelo06WwCy1V7fULb8Gxiz+4TPKVV7b3/q2Ip6IiqGNH/9YhddiaFVl7v0QQLK/rH6sKk/09j8hpBHoTmQ6DoBGdU0ydH2MZTzybDz9bAvariDTiLPcX6pxHESQeWCINxWJXKz55qCLVniIwe3i+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735930968; c=relaxed/simple;
	bh=Gl8y8BFlpRrWQhT3zEKHFDQmjYssrJwQ6kgjlUqJeBY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=V1y3/DzHDuUhj77Ie7M4NkpqfrXTVRGB6w38lUOQqBsPzJ4dzvUxZ2N/ARYKeRSBUed6XvpBIqNERe1f1s9c49N4SBXVm+nmUU1P6579ayNSeUwuu6zxNFDdqUmV+Z+xriy+o+6+qdfr9+qO8jw2FHMvKfHMQePiujRCTxAE6Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FP/2iUAU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2241C4CECE;
	Fri,  3 Jan 2025 19:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735930968;
	bh=Gl8y8BFlpRrWQhT3zEKHFDQmjYssrJwQ6kgjlUqJeBY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=FP/2iUAUQJAkEPy4at/mC0I0yGQE0HwhCEVHA3IY2KvDFvb3r0rkiH9+WtqWJv7FT
	 8dY9Sx5WKgbb5FQvdB/9ht1/K+u3qMUzX5ZbF+21NmN0DWpflt2qVNMIpXkEkHbPvz
	 FRTFPfZ+/heqSC4nT51U9YgXN3sv1t1B3ifZJbQejyrwQhtTSr8B23iJT5BkZ+6oeC
	 E2H7rx1S2XYvqTQWhVbtPl9vd7bpTxASP9J0UVQCFQj38A9Nlzi2KpjImDyBQ3dkyC
	 koSIfCZx7NiHs5Zgs4K2mT2Hmk251mzjqcKR1iCJhYtxJFcfSDbDPvj3oWts31SdBs
	 07mgyjtawzQgg==
Date: Fri, 3 Jan 2025 13:02:45 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jianjun Wang <jianjun.wang@mediatek.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Ryder Lee <ryder.lee@mediatek.com>, linux-pci@vger.kernel.org,
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Xavier Chang <Xavier.Chang@mediatek.com>
Subject: Re: [PATCH 2/5] PCI: mediatek-gen3: Add MT8196 support
Message-ID: <20250103190245.GA4190015@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250103060035.30688-3-jianjun.wang@mediatek.com>

On Fri, Jan 03, 2025 at 02:00:12PM +0800, Jianjun Wang wrote:
> The MT8196 is an ARM platform SoC that has the same PCIe IP as the
> MT8195.
> However, it requires additional settings in the pextpcfg registers.
> Introduce pextpcfg in PCIe driver for these settings.

Add blank lines between paragraphs.

> +	 * The values of some registers are different in RC and EP mode. Therefore,
> +	 * call soc->pre_init after the mode change in case it depends on these registers.

Wrap this to fit in 80 columns like the rest of the file.

> +	/* Adjust SYS_CLK_RDY_TIME ot 10us to avoid glitch */

s/ot/to/

Is this an erratum?  Is there any spec or erratum citation you can
include in the comment?

> +	val = readl_relaxed(pcie->base + PCIE_RESOURCE_CTRL_REG);
> +	val &= ~PCIE_SYS_CLK_RDY_TIME_MASK;
> +	val |= PCIE_SYS_CLK_RDY_TIME_TO_10US;
> +	writel_relaxed(val, pcie->base + PCIE_RESOURCE_CTRL_REG);

