Return-Path: <linux-pci+bounces-25613-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31522A83D64
	for <lists+linux-pci@lfdr.de>; Thu, 10 Apr 2025 10:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16C911B84200
	for <lists+linux-pci@lfdr.de>; Thu, 10 Apr 2025 08:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AEFF20B803;
	Thu, 10 Apr 2025 08:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SZoAZGzU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E9F202990
	for <linux-pci@vger.kernel.org>; Thu, 10 Apr 2025 08:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744274632; cv=none; b=MYiEHTTQlpJZ7M4G4gJsCqvU3Iy/aKq+f4D32nS9tVqiH8b6sQObdoVM/Q1X1uvDUbT07rnAIlxbWFIWv2bENcM9zJ0lZXlfKsZKZSQFB42s2LNut35tRLCwLEe9J/Q+jwn6S3wDzuOGqzqvqMpTmKWTkoanHoy1EidAHdvWSVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744274632; c=relaxed/simple;
	bh=fS1P8QNmkZJhIWxyz4aVqeR3Vhp5Mv+hh6arbQyM+zw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cbEUsmy25YpBdXtYgS0XZuS+9E+L/j/7Ui+GAfHJDzHSNjTipjBSIQxxv1G7veDa0+NQ6HJHrMcFKispOhPwj+abV16XQvPU94CMbjmcJ6L11CFXuhKDJ0cIq6xTzfjpymsBC65ylZDEpNHVYGc8/YyBDrRWWcMTkFzh5e3uqtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SZoAZGzU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43759C4CEDD;
	Thu, 10 Apr 2025 08:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744274631;
	bh=fS1P8QNmkZJhIWxyz4aVqeR3Vhp5Mv+hh6arbQyM+zw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SZoAZGzUN76NnWts/wDa2IuAFRp1jgkkMR2fsJnO+5sRUYTr2QacXdICJcbFq3PJy
	 FpZ1GEobDEF8uDaQvOrM9GKX30XCXJ9wxG5kbtM1tRpYt0GGJ8uwXyYzHmEdpW/V5q
	 TFgAeu25hRxeg8fxGxgZMgLDsYQDPhOA26Si0so24zXfvsW1abULCII/q2mkx9tqZT
	 rL6EWuOiyd6MMuJImR9XqCXY9lBZZu+wlueJTD0+8NrBi9coMOwQY8lX8TUsil8WjM
	 FhTgaejYEwZ154B39kgJ4gQA+5tXOlKOjtBVV6CHEAP6iNaYcUuFcMJILYyxqI+hlz
	 pDHqB6Af6ENnA==
Date: Thu, 10 Apr 2025 10:43:47 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] PCI: dw-rockchip: Enable L0S capability
Message-ID: <Z_eEw-l6SG-lF_7R@ryzen>
References: <1744248981-43371-1-git-send-email-shawn.lin@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1744248981-43371-1-git-send-email-shawn.lin@rock-chips.com>

Hello Shawn,

On Thu, Apr 10, 2025 at 09:36:21AM +0800, Shawn Lin wrote:
> L0S capability isn't enabled on all SoCs by default, so enabling it
> in order to make ASPM L0S work on Rockchip platforms. We have been
> testing it for quite a long time and the default FTS number provided
> by DWC core is broken since it fits only for DWC PHY IP but not for
> other types of PHY IP from other vendors.

If we take the rk3588 SoC for example,
some PCIe controllers use PHY:
drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
some PCIe controllers use PHY:
drivers/phy/rockchip/phy-rockchip-snps-pcie3.c

This second PHY is obviously a Synopsys PHY.

So, I think the commit message is a bit confusing/misleading,
since IMO the second PHY driver is for a DWC PHY IP.

Is this N_FTS value correct for both of these PHYs?


Having this code in ->start_link() looks incorrect.

rockchip_pcie_configure_rc(), calls dw_pcie_host_init().

dw_pcie_host_init() first calls dw_pcie_setup_rc(), which calls dw_pcie_setup().
dw_pcie_setup() will write pci->n_fts[0] / pci->n_fts[1].

dw_pcie_host_init() then calls dw_pcie_start_link()
(which calls ->start_link()).

So, setting pci->n_fts[0] / pci->n_fts[1] in ->start_link() is thus too late.


Kind regards,
Niklas


> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
> 
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> index 21dc99c..56acfea 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -185,6 +185,20 @@ static int rockchip_pcie_link_up(struct dw_pcie *pci)
>  static int rockchip_pcie_start_link(struct dw_pcie *pci)
>  {
>  	struct rockchip_pcie *rockchip = to_rockchip_pcie(pci);
> +	u32 cap, lnkcap;
> +
> +	/* Enable L0S capability for all SoCs */
> +	cap = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> +	if (cap) {
> +		/* Default fts number(210) is broken, override it */
> +		pci->n_fts[0] = 255; /* Gen1 */
> +		pci->n_fts[1] = 255; /* Gen2+ */
> +		lnkcap = dw_pcie_readl_dbi(pci, cap + PCI_EXP_LNKCAP);
> +		lnkcap |= PCI_EXP_LNKCAP_ASPM_L0S;
> +		dw_pcie_dbi_ro_wr_en(pci);
> +		dw_pcie_writel_dbi(pci, cap + PCI_EXP_LNKCAP, lnkcap);
> +		dw_pcie_dbi_ro_wr_dis(pci);
> +	}
>  
>  	/* Reset device */
>  	gpiod_set_value_cansleep(rockchip->rst_gpio, 0);
> -- 
> 2.7.4
> 

