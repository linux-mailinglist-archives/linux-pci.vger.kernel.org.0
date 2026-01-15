Return-Path: <linux-pci+bounces-44961-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FDADD25523
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 16:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C514E304A8DF
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 15:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8723B8BCE;
	Thu, 15 Jan 2026 15:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QI7srDK/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB593B8BA3;
	Thu, 15 Jan 2026 15:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768490500; cv=none; b=qRpDCIgeAb5J3RjqtHwtCeS2QMfytcbFra1r5OHtghShM9HJ98voxWXVwHUpIf7CqgA0TrfhtVi/j1C5lWLRTcl3QVLtEA39ofIBsRl3GWlY83m8CD3m9x+9m4nUvMPLMJxIOcThi+4aBc2EVFQDbJO92t5/xgm0vnSyPED+U/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768490500; c=relaxed/simple;
	bh=Tt0EYm72yfv5arwvfEiESNjf8n0aJTfAVjQfOYQykeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BnUIeU711/vD46x0OEDCdx2d0ha+Jp2pL3PGIkmQtKlyIehpfhRb8l54BxanOsLiQDNrGx0pvfkjIGZcMlhVy7d0yDogvUrPF8E+1dwaTwA75ZcQwZqtNY38DKSesSmj1xzrlo33fU3azJirI12xqZcpjf61jq3IP90leCOxmHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QI7srDK/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17EBFC16AAE;
	Thu, 15 Jan 2026 15:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768490498;
	bh=Tt0EYm72yfv5arwvfEiESNjf8n0aJTfAVjQfOYQykeU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QI7srDK/FhDXgZgja3pcyeu8mCCZXuUfO0oaumMkvJLpDBbxgXYV0dL86YPgf3Z0s
	 JS5xTfYR/dI+NP0Ac+z8jTX+Sk/KoKgegd40WfIvfyr6itWJ7nlEgeQVHMtujECjAA
	 9sLrYvJuucxJeRjo3nRQzbbwEUvzk5zZVckQfEWAMZBWPinnu4Me7RXC0Nk18jOM4Q
	 V5xf/4JizZXKaU1UFVxvgUe241yU7L2jzNnBDn2MI9exJ8/7mF565LjjA5rAqffhq1
	 hA1PlVxKRt1vdrt4C8Y6ZwGZAVP2V/m7QsCY3GxHieqrNSmLUdYRDlFLKmnYwh5CLb
	 ijXqpgpnqqKoA==
Date: Thu, 15 Jan 2026 16:21:21 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Koichiro Den <den@valinux.co.jp>, jingoohan1@gmail.com, mani@kernel.org,
	lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org,
	bhelgaas@google.com, vigneshr@ti.com, s-vadapalli@ti.com,
	hongxing.zhu@nxp.com, l.stach@pengutronix.de, shawnguo@kernel.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	minghuan.Lian@nxp.com, mingkai.hu@nxp.com, roy.zang@nxp.com,
	jesper.nilsson@axis.com, heiko@sntech.de,
	srikanth.thokala@intel.com, marek.vasut+renesas@gmail.com,
	yoshihiro.shimoda.uh@renesas.com, geert+renesas@glider.be,
	magnus.damm@gmail.com, christian.bruel@foss.st.com,
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	thierry.reding@gmail.com, jonathanh@nvidia.com,
	hayashi.kunihiko@socionext.com, mhiramat@kernel.org,
	kishon@kernel.org, jirislaby@kernel.org, rongqianfeng@vivo.com,
	18255117159@163.com, shawn.lin@rock-chips.com,
	nicolas.frattaroli@collabora.com, linux.amoon@gmail.com,
	vidyas@nvidia.com, linux-omap@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@axis.com,
	linux-rockchip@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH v8 2/5] PCI: endpoint: Add BAR subrange mapping support
Message-ID: <aWkF6rT0Du7iJwHh@ryzen>
References: <20260115084928.55701-1-den@valinux.co.jp>
 <20260115084928.55701-3-den@valinux.co.jp>
 <aWj/Sr63+hl7CBe/@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWj/Sr63+hl7CBe/@lizhi-Precision-Tower-5810>

On Thu, Jan 15, 2026 at 09:52:58AM -0500, Frank Li wrote:
> > @@ -127,6 +150,10 @@ struct pci_epf_bar {
> >  	size_t		mem_size;
> >  	enum pci_barno	barno;
> >  	int		flags;
> > +
> > +	/* Optional sub-range mapping */
> > +	unsigned int	num_submap;
> > +	struct pci_epf_bar_submap	*submap;
> 
> struct pci_epf_bar_submap submap[] __counted_by(num_submap);
> 
> Not sure if use this simplify alloc/free.

Your suggestion changes the submap from a pointer to a flexible array
member.

A flexible array member must always be last in the struct,
and you can only have one flexible array member per struct.

Additionally, using a flexible array member requires the struct to
always be allocated on the heap. You can't allocate a struct with a
flexible array member on the stack.

So I'm not sure that if your suggestion is something we want.


Kind regards,
Niklas

