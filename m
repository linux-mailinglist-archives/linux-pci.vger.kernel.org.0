Return-Path: <linux-pci+bounces-42063-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9F6C85DD3
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 17:05:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CC3274E23AB
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 16:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51119216E24;
	Tue, 25 Nov 2025 16:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EPrVZFqw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B9A20A5F3;
	Tue, 25 Nov 2025 16:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764086735; cv=none; b=uKY5hY/i6R7HJ26mA742vI84885bbGzT7Hy0Qn6xrKYM7SCUUOB+Ef+/GoQVt42lFh7AKgfSZWmU38dlT/oZk2zcTCPp2Wwjbyxvc3uu4mtwSmt/aAebaVXz7ZKy3pYQGlLg8sAuAzcc/gTI9itWBrQnmNBT5hf38U/rZGlR7ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764086735; c=relaxed/simple;
	bh=F1F0mkheavBA6AiSAGY3tqCmWzVHXjgsAAP14vd8hyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sRYC1Hw95jX51ELyTd7KOmiG1MbkCY7HusYa5eS2/POdbwwjanss7WsF3dNNBNihFikJn0t9Gy+kuJKLeDYkz/BZptLrYBrhpX/TRlT2HukHaUCCwBAGj+HV5IsK/WMw9NjOVVuU8MlKpluuXk/NLiSozBbCmdv0EooC+Lgp81A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EPrVZFqw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7359C4CEF1;
	Tue, 25 Nov 2025 16:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764086734;
	bh=F1F0mkheavBA6AiSAGY3tqCmWzVHXjgsAAP14vd8hyA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EPrVZFqw/FJi/khBKS8sPxIDCPkAwy/q3a92we7To8IC0fXMQySVTDDvpBphsqmia
	 5qmR+yB9WOKMOwLy5k+kyYR5gaYZOr0eg+076JexWmk7C7hf6C1y+Q0RwpqP0+xNLV
	 ER7PHdjLfk3RgplQqrQxzo19/djma82FLyjcYA8CQdBIBodKID4b58Mg9FqRAt62z5
	 pvdW2vuowP8JeoN7Yi8lp4jV0fQAE9HOBNoqEVemrAVHqMIgiJfBA/Cv12q7xX7ybH
	 gVncD5TRDK/X+9F8a205PppZUJLKicpC41ohDXn7ATFYvP8i2WYXq+6rtXtCoXcTXa
	 anFYzn2rROvWw==
Date: Tue, 25 Nov 2025 21:35:24 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Hans Zhang <hans.zhang@cixtech.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: PCI_SKY1_HOST should depend on ARCH_CIX
Message-ID: <zu7cgkaqvz3bzuceokmx5jwffrgfpfxxwtmpkufwzj4giac4ro@g5nklrbzhw4a>
References: <6617e95d9e71e04e2e0944819cab32adf585f7c4.1764080169.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6617e95d9e71e04e2e0944819cab32adf585f7c4.1764080169.git.geert+renesas@glider.be>

On Tue, Nov 25, 2025 at 03:17:34PM +0100, Geert Uytterhoeven wrote:
> The CIX SKY1 PCIe controller is only present on Cixtech SKY1 SoCs.
> Hence add a dependency on ARCH_CIX, to prevent asking the user about
> this driver when configuring a kernel without Cixtech SoC family
> support.
> 
> Fixes: 25b3feb70d640158 ("PCI: sky1: Add PCIe host support for CIX Sky1")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Squashed with the offending commit, thanks!

- Mani

> ---
>  drivers/pci/controller/cadence/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/cadence/Kconfig b/drivers/pci/controller/cadence/Kconfig
> index ceff65934e5fabd1..9fa527bad5b7dfc1 100644
> --- a/drivers/pci/controller/cadence/Kconfig
> +++ b/drivers/pci/controller/cadence/Kconfig
> @@ -54,6 +54,7 @@ config PCIE_SG2042_HOST
>  config PCI_SKY1_HOST
>  	tristate "CIX SKY1 PCIe controller (host mode)"
>  	depends on OF
> +	depends on ARCH_CIX || COMPILE_TEST
>  	select PCIE_CADENCE_HOST
>  	select PCI_ECAM
>  	help
> -- 
> 2.43.0
> 

-- 
மணிவண்ணன் சதாசிவம்

