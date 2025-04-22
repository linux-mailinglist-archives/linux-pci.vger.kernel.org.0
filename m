Return-Path: <linux-pci+bounces-26381-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1181DA967CE
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 13:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6163B3BF119
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 11:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8F527CB3F;
	Tue, 22 Apr 2025 11:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="amsbijQi"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7448327BF8A;
	Tue, 22 Apr 2025 11:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745321756; cv=none; b=pi8KzbbS8Az2J1E5ybsOQv6L9ubTVo/f/vv+fkzQx7AsRIwlAaagVa4UyVzUBRcnhbLxwBrWrQVGbBGWVfKvhgPYLi6H4qUOfEUIM+7Se4eoyM5jVpE4H3LXjem14N78uBiFTItGxd/xkHXPz4oJSi1SuFd7AYSWSfjLcBFoHoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745321756; c=relaxed/simple;
	bh=G8k1yESAkAoC2QiiUqKx2xBykLNl2jvAEMR/XX9MlZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OnaVGKzABBnIMmVKw5LxAxSIszGmhsdVSDQ8KkdQrbfziPAhgj6gACwlJ1PhwyzsWwLXKB4m0UzeK2WLBpHAolEK2RPZNokaFMOU0ogjxQuPwkl3kts2qshei9x8YTK8LeOy9n0kR0znh3ocBzwEe+YEIGz/ten9G7pw7mgFknI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=amsbijQi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68025C4CEE9;
	Tue, 22 Apr 2025 11:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745321755;
	bh=G8k1yESAkAoC2QiiUqKx2xBykLNl2jvAEMR/XX9MlZA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=amsbijQi5FkfMwBmTqZPiKls6kIoI2HsDOXFFmiGBsXTj1a76q6E+akpUOlIFc9ap
	 42enWZHkH54MltECbR3/SsXKxa1Y3FBhkGE/eyTY5Q8VA/m+CRstiPD0XSEM4cBjWv
	 t/EKOoEaUKKflSsJ+/hx4kfN/WHbonw7rs4SkPlpRYoRev9MkgNUDciApX5BiAmC7e
	 zd4Ma6xmusV9ejKOM70Bt+GVk1MvvyNs3nTQf7pNAOW8IdxZT06+aV6TMh0kYvEiiX
	 cUt4Ni+NeLFVbCa6Qgh52U033cy2Zog7gHbYZPjAgvQ5P2ZTUSD7HD9I2h03jzc5pO
	 gpaGE98vrLEiA==
Date: Tue, 22 Apr 2025 13:35:50 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com,
	heiko@sntech.de, manivannan.sadhasivam@linaro.org, robh@kernel.org,
	jingoohan1@gmail.com, shawn.lin@rock-chips.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 1/3] PCI: dw-rockchip: Remove unused
 PCIE_CLIENT_GENERAL_DEBUG
Message-ID: <aAd_FiWy5F-tK_2i@ryzen>
References: <20250422112830.204374-1-18255117159@163.com>
 <20250422112830.204374-2-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250422112830.204374-2-18255117159@163.com>

On Tue, Apr 22, 2025 at 07:28:28PM +0800, Hans Zhang wrote:
> The PCIE_CLIENT_GENERAL_DEBUG register offset is defined but never
> used in the driver. Its presence adds noise to the register map and
> may mislead future developers.
> 
> Remove this redundant definition to keep the register list minimal
> and aligned with actual hardware usage.
> 
> Signed-off-by: Hans Zhang <18255117159@163.com>
> ---
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> index 0e0c09bafd63..fd5827bbfae3 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -54,7 +54,6 @@
>  #define PCIE_CLIENT_GENERAL_CONTROL	0x0
>  #define PCIE_CLIENT_INTR_STATUS_LEGACY	0x8
>  #define PCIE_CLIENT_INTR_MASK_LEGACY	0x1c
> -#define PCIE_CLIENT_GENERAL_DEBUG	0x104
>  #define PCIE_CLIENT_HOT_RESET_CTRL	0x180
>  #define PCIE_CLIENT_LTSSM_STATUS	0x300
>  #define PCIE_LTSSM_ENABLE_ENHANCE	BIT(4)
> -- 
> 2.25.1
> 

Reviewed-by: Niklas Cassel <cassel@kernel.org>

