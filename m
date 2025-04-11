Return-Path: <linux-pci+bounces-25658-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE47A856FF
	for <lists+linux-pci@lfdr.de>; Fri, 11 Apr 2025 10:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3C257AC392
	for <lists+linux-pci@lfdr.de>; Fri, 11 Apr 2025 08:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8C0285404;
	Fri, 11 Apr 2025 08:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xn+xnlkt"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C539C20B7F1
	for <linux-pci@vger.kernel.org>; Fri, 11 Apr 2025 08:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744361512; cv=none; b=m1PF51eE8b5S+UyirbrJLZcmBw+MW08Bex5APpgErPr3ZxZJ/ux/4qkz/PKxH+PN+GBtzkrJ2FaSJP5vzwxfoBkXG7YRLrVfffHp4/PocMdQOE1haTfBrmEWhB9ol359GQeAh/LiWx/1mjCituAWAtygodDEdpmJx43FsH0gBNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744361512; c=relaxed/simple;
	bh=qHj51DT4gaDYfC3Nzo5S6OJxmFzJOSStKKxG0u5ZzLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uDGpghjJ0xeLm3NjHfOtoGS7deirByP3GEzF8LwZ5i4Ha6c8RtS12D58nJt8HMLDyQcp0iTJ3tXt58a9+hLIL/NrQQ9Kpo8dX/6X3RHDcY1zUspM7mrJ8cfJUk5ViV24mYaBpwL/4kAj28j5HlL8D9XGQvWMBLI+wh35qwpEoy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xn+xnlkt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D113DC4CEE2;
	Fri, 11 Apr 2025 08:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744361512;
	bh=qHj51DT4gaDYfC3Nzo5S6OJxmFzJOSStKKxG0u5ZzLw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xn+xnlktmHWVRACGKgFBHDDhK8HOW1gkoU+BTTARXvf0DJPW0CPeP/U6HlQ4VzLj8
	 P+aK6zcgjwR6MBjk1mY8G8+SAZq85oho3JcsbpxphErE32v5lN1l5oNwpVgQwCjgPo
	 U9E5h0e7hZlecnSxTvdpjaxLzDZLWkznxFQDfTWeNvmctmtoktlrMBiev651dxLIPx
	 3wT7ev4Vx5tKaW3K7HtSnnAsVCzdd1lC1ZtWEa/IyQLifp2wbAEeZ9BZa99yIG+Vgl
	 dlIDGAeKJbOCD1KDi4Peut3CEN7IQL1NBlXyl0nUst72/dkyCyuAtlnzIqCngcvWWP
	 6qrvMPuX9PrJg==
Date: Fri, 11 Apr 2025 10:51:48 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2] PCI: dw-rockchip: Enable L0S capability
Message-ID: <Z_jYJKL9rOGMR0xg@ryzen>
References: <1744332481-143011-1-git-send-email-shawn.lin@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1744332481-143011-1-git-send-email-shawn.lin@rock-chips.com>

Hello Shawn,

On Fri, Apr 11, 2025 at 08:48:01AM +0800, Shawn Lin wrote:
> L0S capability isn't enabled on all SoCs by default, so enabling it
> in order to make ASPM L0S work on Rockchip platforms. We have been
> testing it for quite a long time and found the default FTS number
> provided by DWC core doesn't work stable and make LTSSM switch between
> L0S and Recovery, leading to long exit latency, even fail to link sometimes.
> So override it to the max 255 which seems work fine under test for both PHYs
> used by Rockchip platforms.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
> 
> Changes in v2:
> - Move n_fts to probe function
> - rewrite the commit message
> 
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> index 21dc99c..c397f3a 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -185,6 +185,17 @@ static int rockchip_pcie_link_up(struct dw_pcie *pci)
>  static int rockchip_pcie_start_link(struct dw_pcie *pci)
>  {
>  	struct rockchip_pcie *rockchip = to_rockchip_pcie(pci);
> +	u32 cap, lnkcap;
> +
> +	/* Enable L0S capability for all SoCs */
> +	cap = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> +	if (cap) {
> +		lnkcap = dw_pcie_readl_dbi(pci, cap + PCI_EXP_LNKCAP);
> +		lnkcap |= PCI_EXP_LNKCAP_ASPM_L0S;
> +		dw_pcie_dbi_ro_wr_en(pci);
> +		dw_pcie_writel_dbi(pci, cap + PCI_EXP_LNKCAP, lnkcap);
> +		dw_pcie_dbi_ro_wr_dis(pci);
> +	}

I think it looks wrong to have this in _start_link().
Why not put this code in a new "_enable_l0s() function, and call it from:
rockchip_pcie_ep_init() and rockchip_pcie_host_init().

When looking at this, we probably should also move the
rockchip_pcie_ep_hide_broken_ats_cap_rk3588() call from _pre_init() to _init(),
because if there is a core reset, _init() is called again, but _pre_init() is
not.


>  
>  	/* Reset device */
>  	gpiod_set_value_cansleep(rockchip->rst_gpio, 0);
> @@ -598,6 +609,9 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
>  	rockchip->pci.dev = dev;
>  	rockchip->pci.ops = &dw_pcie_ops;
>  	rockchip->data = data;

Perhaps add a newline here.

> +	/* Default fts number(210) is broken, override it to 255 */

Perhaps add a space between "number" and "(".
Perhaps write it as N_FTS instead of fts.
Perhaps use "value" instead of "number".

ie.

/* Default N_FTS value (210) is broken, ... */



Kind regards,
Niklas

