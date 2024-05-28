Return-Path: <linux-pci+bounces-7885-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2DB8D1486
	for <lists+linux-pci@lfdr.de>; Tue, 28 May 2024 08:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 670C7283E30
	for <lists+linux-pci@lfdr.de>; Tue, 28 May 2024 06:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8E761FD9;
	Tue, 28 May 2024 06:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p0zM3SW/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80B643AA0;
	Tue, 28 May 2024 06:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716878220; cv=none; b=OfvS3bqbpUhHUlRZqC7E3j2AoTmHafu8WdlqeBx6m8iPBr04vH4R/YNaoFiAivvcvgioI7mOvJ7JZS7teciHNlEBVhKwZ76s+zeBOUhRdbIGbYxMCW1eCNtgYd6ZWTP6DSVsyJz+8zS3EGOiM56kCuGa8iFOqA1Cm0OD/B4sQfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716878220; c=relaxed/simple;
	bh=bicEORD8zXtsreO4EZpzHbdRKrlU/zXeZoYv6iHJDIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dg3irYTafD5yYNpBUJ7roLuGC/8YetdZVrEGu4XEHqZIT+MGUMVe0Jcu/ybXUtnmN9muagfCIYUiQJGieYmG81fRbxTe8MmRbXHHH/Ybft20YLV59ZAz7kTzOdK0lFe/EAS0Mp4j78x5D7KEzWNg6dx8xyt5dDpiKOWN0nm8ZuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p0zM3SW/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 761AAC3277B;
	Tue, 28 May 2024 06:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716878220;
	bh=bicEORD8zXtsreO4EZpzHbdRKrlU/zXeZoYv6iHJDIc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p0zM3SW/5CEmLKb5SBCgVAikZ8HEbbaMNz0nBhrlFqXtFCuJX8iwBcHCTSN4+Tcel
	 /tOW0SsD88iUyIQJAwFfuGWao/amGCg13dA+Gh9BcrWunbEGADa2kTyF6yV1k+6lKI
	 8Xby6njj26AchHlaQcRGuYchlq/M/RfbE8T0cWpbKHy8ocbZql6QaFNnld6rhtr7mB
	 o59rrkjNF/063coLsi2sFWVXULwEG1s4T2l41n2DXaXIGZUZwxZERQ+cF9I7YQ672U
	 xLGvBg6z6wYaO9xfImQEFNV90FeLDaIAGHo5FR0WKq6YC+rZA3QUbfwU1lEIfSQp0F
	 Q9u0PAyfrnwGw==
Date: Tue, 28 May 2024 08:36:55 +0200
From: Niklas Cassel <cassel@kernel.org>
To: linux@treblig.org
Cc: lpieralisi@kernel.org, robh@kernel.org, thierry.reding@gmail.com,
	linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: tegra: remove unused struct 'tegra_pcie_soc'
Message-ID: <ZlV7h8PbvD_bChfY@ryzen.lan>
References: <20240527160118.37069-1-linux@treblig.org>
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

Reviewed-by: Niklas Cassel <cassel@kernel.org>

