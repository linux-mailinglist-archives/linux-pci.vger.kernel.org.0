Return-Path: <linux-pci+bounces-25843-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A17A88667
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 17:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 957361897473
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 14:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373E62472B9;
	Mon, 14 Apr 2025 14:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d/2iJnt3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1284F16F8E5
	for <linux-pci@vger.kernel.org>; Mon, 14 Apr 2025 14:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744641360; cv=none; b=QJ+wEFxOc4uJfb3bHfSuj7YGR5phE0D1JtELuuX2IKsIncsYK8zAXacKpheW90m2ped7BMPyXESu0G7disc58XIvW08ii68AMd14x0I4ESF7BIL3sTTwJGNja/ya1LWaoM+9Wxw5x59fcLtXCgcPVyISwA/q5YPaGfQM0WPIKBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744641360; c=relaxed/simple;
	bh=hgrZkekdcnGttIrLxkSswtRQ99stW8nqX8CPr1dL2/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S7h/dXuLQee15P5TTsFn2kKipRZB3xWR0GeWORTl6wKQkN4vx153ZrJYORt2av13II/xcGbx/UxdDY0vTHsxaslPaE6xgsMLq8l3yHImpQfHviV/BHtGg7v9VTF1IVVX+ywPqfty5VTiFLYGsiIG90wVApNAK6h0BhaaFg/KMak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d/2iJnt3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25774C4CEE2;
	Mon, 14 Apr 2025 14:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744641359;
	bh=hgrZkekdcnGttIrLxkSswtRQ99stW8nqX8CPr1dL2/A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d/2iJnt3iJ9RM6F5JKfSe3HNaHGt9qZT9ZQL5zVbC9MfyC5pva0CnRfHgc4cDX+b7
	 xVYpW72W87LodgiP/mflQ4hBFeqL3zhEyr6kmIUCU0LyYxpwKTbEkT4085zWK+Fhtp
	 d9BUPmxaM/FCaBX/YsseXm8HKehnASdYNFguOkRHQeppXlnV0xcTvhJW4kSl75xssK
	 ue9bChUZK+NlGhjkJP5qQR9WFuVXtfUna99kG/SHifCKWkEjpSzjtAFVseKj78V9ZD
	 yTgXtKexGFIsnvsLR+x71mbq9KEtVCj2Aiq4VL92FzRYpC74kAmCJCA9R6YP2lSXFM
	 vuRPtC65EdwSw==
Date: Mon, 14 Apr 2025 16:35:55 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v3 2/2] PCI: dw-rockchip: Move
 rockchip_pcie_ep_hide_broken_ats_cap_rk3588() to .init()
Message-ID: <Z_0dS_sTxQ7Y0d7G@ryzen>
References: <1744594051-209255-1-git-send-email-shawn.lin@rock-chips.com>
 <1744594109-209312-1-git-send-email-shawn.lin@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1744594109-209312-1-git-send-email-shawn.lin@rock-chips.com>

On Mon, Apr 14, 2025 at 09:28:29AM +0800, Shawn Lin wrote:
> Iif there is a core reset, _init() is called again, but _pre_init() is
> not.

I think a better commit message would be:

There is no reason to call rockchip_pcie_ep_hide_broken_ats_cap_rk3588()
from the pre_init() callback, instead of the normal init() callback.

Thus, move the rockchip_pcie_ep_hide_broken_ats_cap_rk3588() call from
the pre_init() callback to the init() callback, as:
1) init() will still be called before link training is enabled, so the
   quirk will still be applied before the host has can see our device.
2) This allows us to remove the pre_init() callback, as it is now unused.
3) It is a more robust design, as the init() callback is called by
 dw_pcie_ep_init_registers(), which will always be called after a core
 reset. The pre_init() callback is only called once, at probe time.

No functional changes.



> 
> Suggested-by: Niklas Cassel <cassel@kernel.org>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Tested-by: Niklas Cassel <cassel@kernel.org>


> ---
> 
> Changes in v3: None
> Changes in v2: None
> 
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> index 922aff0..b45af18 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -278,17 +278,13 @@ static void rockchip_pcie_ep_hide_broken_ats_cap_rk3588(struct dw_pcie_ep *ep)
>  		dev_err(dev, "failed to hide ATS capability\n");
>  }
>  
> -static void rockchip_pcie_ep_pre_init(struct dw_pcie_ep *ep)
> -{
> -	rockchip_pcie_ep_hide_broken_ats_cap_rk3588(ep);
> -}
> -
>  static void rockchip_pcie_ep_init(struct dw_pcie_ep *ep)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>  	enum pci_barno bar;
>  
>  	rockchip_pcie_enable_l0s(pci);
> +	rockchip_pcie_ep_hide_broken_ats_cap_rk3588(ep);
>  
>  	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++)
>  		dw_pcie_ep_reset_bar(pci, bar);
> @@ -359,7 +355,6 @@ rockchip_pcie_get_features(struct dw_pcie_ep *ep)
>  
>  static const struct dw_pcie_ep_ops rockchip_pcie_ep_ops = {
>  	.init = rockchip_pcie_ep_init,
> -	.pre_init = rockchip_pcie_ep_pre_init,
>  	.raise_irq = rockchip_pcie_raise_irq,
>  	.get_features = rockchip_pcie_get_features,
>  };
> -- 
> 2.7.4
> 

