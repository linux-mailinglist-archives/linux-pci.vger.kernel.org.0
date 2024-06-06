Return-Path: <linux-pci+bounces-8411-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD198FF594
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jun 2024 21:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E1641F25224
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jun 2024 19:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A3171B40;
	Thu,  6 Jun 2024 19:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VOES39us"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE74171743;
	Thu,  6 Jun 2024 19:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717703918; cv=none; b=nsGlSI55AkWjLlzmH5eBCtsywMidkQmSzx1yJMYGIl0pA2at7w/QtgMewYkBWUjEa7QMLHw/oo4KNhTIcWxM03epAZt71r3N8XUL8PoLDfTcgu7dY3E9OVuuXO9+g2S6vXJpQa1jo98jYmjwTtJBhyXxLvGKaOTVS0ZVXitb23o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717703918; c=relaxed/simple;
	bh=a41q0bUhTB2TfeDoXkXNBNdH5lct9YkYIl4SZkTdPoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=PO7PBSEdd3PJSbgxQEA9afvtJG52CpQlbyYg7u5f7tnYDCnhz8cgg/We1nsUhsYMvM9d8fh9NUxJIjoR8wAh5UbrPuXraoCTLPlA5DpKxLwWlY31cM1rR0+bm/mWERHKZSYsJnGk1YAxPaXTaQ6jpOCnvSNj4YRX1db0jyNWMlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VOES39us; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58BD3C2BD10;
	Thu,  6 Jun 2024 19:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717703917;
	bh=a41q0bUhTB2TfeDoXkXNBNdH5lct9YkYIl4SZkTdPoQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=VOES39usLWYAA0XVRisqwwUHveB0zQXiDWdslluC3Ua17YfZxwEsZI0iqFKIoD/wI
	 +dEEasTL8Xo5iE+LNlbnS7LXaYZ5I3ZeQ5vcNCvpjQcg69EfUEeNBY+7Cwgf1zoFHZ
	 VUbjKYcJ3gKgjqhKU/y3vdQ3ihHj8JLnYVhHvCWuI3rxzi9PsvFrc23r3l8onexnii
	 VvKYSecAoN6Yh3R3Inzdg+J8ehA8XVCMa5ZMEEKTMZjbZYh4CxZOCeZ9pJii4yFte8
	 2JY+HcFumaK8Da2Pllay2FzvBJjsuvgvsvI9nUNfTt56PjfJqmfJfKF+Qls9Nqse5u
	 zpj4AFW2rFDUg==
Date: Thu, 6 Jun 2024 14:58:35 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux@treblig.org
Cc: lpieralisi@kernel.org, robh@kernel.org, thierry.reding@gmail.com,
	linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: tegra: remove unused struct 'tegra_pcie_soc'
Message-ID: <20240606195835.GA816675@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527160118.37069-1-linux@treblig.org>

On Mon, May 27, 2024 at 05:01:18PM +0100, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> 'tegra_pcie_soc' has been unused since the initial
> commit 56e15a238d92 ("PCI: tegra: Add Tegra194 PCIe support").
> 
> Remove it.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Applied with Niklas' reviewed-by to pci/controller/tegra194 for v6.11,
thanks!

> ---
>  drivers/pci/controller/dwc/pcie-tegra194.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 93f5433c5c55..076f040ccc34 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -308,10 +308,6 @@ static inline u32 appl_readl(struct tegra_pcie_dw *pcie, const u32 reg)
>  	return readl_relaxed(pcie->appl_base + reg);
>  }
>  
> -struct tegra_pcie_soc {
> -	enum dw_pcie_device_mode mode;
> -};
> -
>  static void tegra_pcie_icc_set(struct tegra_pcie_dw *pcie)
>  {
>  	struct dw_pcie *pci = &pcie->pci;
> -- 
> 2.45.1
> 

