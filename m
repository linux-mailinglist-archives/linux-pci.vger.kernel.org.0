Return-Path: <linux-pci+bounces-30399-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52EE3AE46FA
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 16:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29B4E4A071D
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 14:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744F5239E76;
	Mon, 23 Jun 2025 14:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lK4NzZyb"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEC5230996
	for <linux-pci@vger.kernel.org>; Mon, 23 Jun 2025 14:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750688754; cv=none; b=NBuPBc5b3anDi+6ze/Iq6Lxz2GJtCEX7sGLzAWrCavujkmB36eU38NuhxBGxcmAkuftOpVQFhxo+UIniP0+KjwhdyDvoZkEkWEdT4wxcXtCNFfNExu0WWJiUlcBb75pvyxx99D9xg+iIQPtP6YoRHu7zyw11UbASksANVYwF1ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750688754; c=relaxed/simple;
	bh=wqtKOrmiL3JpO2Y2SIVr4pcAl7mgmV65FohrGrz9zlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UjkKrDxlKsMxSVYDACvBn0GbNYLJM/cgo/XyPDG5pGjXhyYPKDaUJ/IbdA2OQ55GoiUuPDfpQ6OPBlxteQl27D/1pj212M8ANFdoEOP9zUiiM8fMTKvOgMuLWo6B/ZZAk6XDPahJ0undBVz2lRgywVGRwJSPylHAN5CpwpBqtcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lK4NzZyb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B253C4CEF0;
	Mon, 23 Jun 2025 14:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750688753;
	bh=wqtKOrmiL3JpO2Y2SIVr4pcAl7mgmV65FohrGrz9zlQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lK4NzZybEtxBPVkPicenXBcv26helZQ76BwcbNs7/TiRjIlFqpssg+NUb2+znt/Kp
	 iwEHq03Cx5TzL7a70itCG+apUDPO2NUA7QK3T39d9JPkgDyV8eNflv+nhQWAS38OgV
	 dn+e1gQmjyYHYW/iEysLsWFDUwyNEAC9iY9hrej0TFWrCgKBREVh+nqoIFmntcMV4M
	 0c8Fn2ryDkUjGUdwY7/2Opq9EHIwJ6XYiHLFTWHVgKKtlelLD5wUc71lYUEFgd5aF3
	 ZVBk8uRBaDDSw13bmc7tIwDdqZhupn1E6Jw09qlxq9qJ9L5b2PEqTUGK6o1RTUsMZP
	 B83q9B3VdIuog==
Date: Mon, 23 Jun 2025 08:25:50 -0600
From: Manivannan Sadhasivam <mani@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Heiko Stuebner <heiko@sntech.de>, Wilfred Mallawa <wilfred.mallawa@wdc.com>, 
	Damien Le Moal <dlemoal@kernel.org>, Laszlo Fiat <laszlo.fiat@proton.me>, linux-pci@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 2/6] PCI: rockchip-host: Use macro
 PCIE_RESET_CONFIG_WAIT_MS
Message-ID: <ofgbvui2kvnegpj37yhiabxdkehls5euarmo5wqcjkvscwyyxd@ulf7lr7njd6m>
References: <20250613124839.2197945-8-cassel@kernel.org>
 <20250613124839.2197945-10-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250613124839.2197945-10-cassel@kernel.org>

On Fri, Jun 13, 2025 at 02:48:41PM +0200, Niklas Cassel wrote:
> Macro PCIE_RESET_CONFIG_WAIT_MS was added to pci.h in commit d5ceb9496c56

s/PCIE_RESET_CONFIG_WAIT_MS/PCIE_RESET_CONFIG_DEVICE_WAIT_MS

> ("PCI: Add PCIE_RESET_CONFIG_DEVICE_WAIT_MS waiting time value").
> 
> Later, in commit 70a7bfb1e515 ("PCI: rockchip-host: Wait 100ms after reset
> before starting configuration"), PCIE_T_RRS_READY_MS was added to pci.h.
> 
> These macros are duplicates, and represent the exact same delay in the
> PCIe specification.
> 
> Since the comment above PCIE_RESET_CONFIG_WAIT_MS is strictly more correct
> than the comment above PCIE_T_RRS_READY_MS, change rockchip-host to use
> PCIE_RESET_CONFIG_WAIT_MS, and remove PCIE_T_RRS_READY_MS, as
> rockchip-host is the only user of this macro.
> 
> Reviewed-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

LGTM!

- Mani

> ---
>  drivers/pci/controller/pcie-rockchip-host.c | 2 +-
>  drivers/pci/pci.h                           | 7 -------
>  2 files changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
> index b9e7a8710cf0..c11ed45c25f6 100644
> --- a/drivers/pci/controller/pcie-rockchip-host.c
> +++ b/drivers/pci/controller/pcie-rockchip-host.c
> @@ -325,7 +325,7 @@ static int rockchip_pcie_host_init_port(struct rockchip_pcie *rockchip)
>  	msleep(PCIE_T_PVPERL_MS);
>  	gpiod_set_value_cansleep(rockchip->perst_gpio, 1);
>  
> -	msleep(PCIE_T_RRS_READY_MS);
> +	msleep(PCIE_RESET_CONFIG_WAIT_MS);
>  
>  	/* 500ms timeout value should be enough for Gen1/2 training */
>  	err = readl_poll_timeout(rockchip->apb_base + PCIE_CLIENT_BASIC_STATUS1,
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 98d6fccb383e..819833e57590 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -35,13 +35,6 @@ struct pcie_tlp_log;
>   */
>  #define PCIE_T_PERST_CLK_US		100
>  
> -/*
> - * End of conventional reset (PERST# de-asserted) to first configuration
> - * request (device able to respond with a "Request Retry Status" completion),
> - * from PCIe r6.0, sec 6.6.1.
> - */
> -#define PCIE_T_RRS_READY_MS	100
> -
>  /*
>   * PCIe r6.0, sec 5.3.3.2.1 <PME Synchronization>
>   * Recommends 1ms to 10ms timeout to check L2 ready.
> -- 
> 2.49.0
> 

-- 
மணிவண்ணன் சதாசிவம்

