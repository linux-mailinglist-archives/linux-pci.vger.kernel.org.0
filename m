Return-Path: <linux-pci+bounces-26380-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE54EA967AA
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 13:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BCD1178FE4
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 11:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36DDE20B801;
	Tue, 22 Apr 2025 11:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qsd2/Oj8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9151EB1AA;
	Tue, 22 Apr 2025 11:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745321735; cv=none; b=k0bdF0tcfPw1INbrtMHRO6jnFeGl01k/OoNyg9380kLHsfnzTh311NAhTh45dCfpyE/kt9CFK4Fz0YyynNaIWvwlWA2vk8amRV+9ZBI8R7ZIBfJQ606XujQw8ZeGi6cjMg6FNcT4m/oLDxqWJdL9Nbh13C3hQ4PnsJTLtoucrNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745321735; c=relaxed/simple;
	bh=iyIAAmPJNlz3e5gWT5Kk9P9NWMtpV70iP2nADcdxgfw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=SFe9Vu0XcaAB6IIPc13Sl5UEYmYd1j669tLDv1kA5T/pTjOhz6+NxosWegR0Q+LLw1aD1lK4yfEC6kATPP9uO05y3fxl0rzWXXm+va8l+6QxVjxOpbsYz/saMcTltyF1Kd0d1xwoDwmkf8AADWHfMaGc02Ih/mpC6YwgA/ayOLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qsd2/Oj8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 438DDC4CEEC;
	Tue, 22 Apr 2025 11:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745321734;
	bh=iyIAAmPJNlz3e5gWT5Kk9P9NWMtpV70iP2nADcdxgfw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Qsd2/Oj84sxfH8BnbFIuKLhjSmYzFcLJOdoqyUbluLNb/RkJUVIgOpjMvG+7KJyh6
	 sq0cn+MAvwZz4jEl7Lw78rU9TieE+Mhd/wX5KgDiCqP88ymO7ExiCT2r+1DVd+H/zu
	 5+ApLuxwmsphup3ib4DhazauAYACtlis1FE6flSHCxH+PS3C49VwAL/Z53tQxrNlfx
	 OgOTleJOXuFl4brJSwlda6PBP7wKaXMqd2cv5r0zbTnvNBy7WXZ4+nBNG4ZHdxfUn6
	 kJubSLHhTVj58Qx84dWEzw2fdCzRv8VaD30Yn8F8wKfgnGtzWEiGDfuEWEkn6k5bvP
	 1vYK/nFCz6hfg==
Date: Tue, 22 Apr 2025 06:35:32 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jensen Huang <jensenhuang@friendlyarm.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Anand Moon <linux.amoon@gmail.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: rockchip: Fix order of rockchip_pci_core_rsts
Message-ID: <20250422113532.GA321792@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250328105822.3946767-1-jensenhuang@friendlyarm.com>

On Fri, Mar 28, 2025 at 06:58:22PM +0800, Jensen Huang wrote:
> The order of rockchip_pci_core_rsts follows the previous comments suggesting
> to avoid reordering. However, reset_control_bulk_deassert() applies resets in
> reverse, which may lead to the link downgrading to 2.5 GT/s.
> 
> This patch restores the deassert order and comments for core_rsts, introduced in
> commit 58c6990c5ee7 ("PCI: rockchip: Improve the deassert sequence of four reset pins").
> 
> Tested on NanoPC-T4 with Samsung 970 Pro.
> 
> Fixes: 18715931a5c0 ("PCI: rockchip: Simplify reset control handling by using reset_control_bulk*() function")
> Signed-off-by: Jensen Huang <jensenhuang@friendlyarm.com>

Thanks for the fix!  It looks like 18715931a5c0 appeared in v6.14, so
we should probably add a stable tag so it gets backported there?

> ---
>  drivers/pci/controller/pcie-rockchip.h | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/controller/pcie-rockchip.h
> index 11def598534b..4f63a03d535c 100644
> --- a/drivers/pci/controller/pcie-rockchip.h
> +++ b/drivers/pci/controller/pcie-rockchip.h
> @@ -320,11 +320,15 @@ static const char * const rockchip_pci_pm_rsts[] = {
>  	"aclk",
>  };
>  
> +/*
> + * Please don't reorder the deassert sequence of the following
> + * four reset pins.
> + */
>  static const char * const rockchip_pci_core_rsts[] = {
> -	"mgmt-sticky",
> -	"core",
> -	"mgmt",
>  	"pipe",
> +	"mgmt",
> +	"core",
> +	"mgmt-sticky",
>  };
>  
>  struct rockchip_pcie {
> -- 
> 2.49.0-1
> 

