Return-Path: <linux-pci+bounces-13031-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4295975467
	for <lists+linux-pci@lfdr.de>; Wed, 11 Sep 2024 15:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7D35286204
	for <lists+linux-pci@lfdr.de>; Wed, 11 Sep 2024 13:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C52A1940B2;
	Wed, 11 Sep 2024 13:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KEVA+Hlg"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DBF1885A7;
	Wed, 11 Sep 2024 13:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726062279; cv=none; b=uhfkLu/9d7Fl/BMK8NNS2ycGP+gXTXFURHgK7z10TNcNVJ9av5tc8l0tv6IYHUWIOxwB42kCIib/lrNAWdI4S++R7hCb+i1UFMOXywH+Gp6rWTneF9ejp5yNmHvR3TmmG9jc4j1OKJnHpFrLaRNAqtYWY2d7JSleTKE+sYxGm/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726062279; c=relaxed/simple;
	bh=QaM152US3SyySUKdVgjeMf2JwNf33Yk4eAWZm3OMSFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=RlriEAwtfJqPxgG9L1UhZM9Xb68KYL459owLTpYDQyuvE2kosQ63sy8nW9Hpqww0p7FphaZZRbW4gOGE8md36/j5ajD5FNwct/fiRx+iwFeuYicsiiTWTdXbW7F8F2lR/6QjLAqMUreSNgx9OXPa0+dVzH8X6nHeYM1x/Myrnlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KEVA+Hlg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61593C4CEC5;
	Wed, 11 Sep 2024 13:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726062278;
	bh=QaM152US3SyySUKdVgjeMf2JwNf33Yk4eAWZm3OMSFQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=KEVA+Hlg2jURXGsaKABygI3xzD7IVrVXB7fMDg9IVlKHNlovpJl4FyFkkSGYr8vxR
	 8Zot7RP+wshcXrOEzvmSSm/VJmy3fMyR24VIbIr2eYX5C1tWNO3i+4oiYVoSPNJuxQ
	 hGkygEKWV7EIqBQGq4Q1ACGYFn0xwq6K8dTOBuxe7k26nxlfMxZ/MZntWRSXI/WO2E
	 egQVAJ98+SBpVhVXNwZ9xGzgDoaLjgYXNEuOhEUyw+Bo0oxdzkK4lMacJgE97/CsKh
	 d9cFuMPEeRk9q5oC3lU7Pa2ygzkBOYbThCTyn1aSEBf3E+lNzWRzpaocQ/psN+dnv8
	 fgQ7ZTIIv4ovg==
Date: Wed, 11 Sep 2024 08:44:36 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Qianqiang Liu <qianqiang.liu@163.com>
Cc: bcm-kernel-feedback-list@broadcom.com, florian.fainelli@broadcom.com,
	james.quinlan@broadcom.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: brcmstb: Fix control flow issue
Message-ID: <20240911134436.GA628842@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911025058.51588-1-qianqiang.liu@163.com>

On Wed, Sep 11, 2024 at 10:50:59AM +0800, Qianqiang Liu wrote:
> The type of "num_inbound_wins" is "u8", so the less-than-zero
> comparison of an unsigned value is never true.

I think this was fixed slightly differently but with the same effect;
please check this to make sure:

https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/tree/drivers/pci/controller/pcie-brcmstb.c?h=controller/brcmstb#n1034

> ---
>  drivers/pci/controller/pcie-brcmstb.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index 55311dc47615..3e4572c3eeb1 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -1090,9 +1090,11 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
>  	u32p_replace_bits(&tmp, 1, PCIE_MISC_MISC_CTRL_PCIE_RCB_64B_MODE_MASK);
>  	writel(tmp, base + PCIE_MISC_MISC_CTRL);
>  
> -	num_inbound_wins = brcm_pcie_get_inbound_wins(pcie, inbound_wins);
> -	if (num_inbound_wins < 0)
> -		return num_inbound_wins;
> +	ret = brcm_pcie_get_inbound_wins(pcie, inbound_wins);
> +	if (ret < 0)
> +		return ret;
> +
> +	num_inbound_wins = (u8)ret;
>  
>  	set_inbound_win_registers(pcie, inbound_wins, num_inbound_wins);
>  
> -- 
> 2.39.2
> 

