Return-Path: <linux-pci+bounces-19330-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C619DA0245E
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jan 2025 12:36:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A24FC1646B6
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jan 2025 11:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB6378F20;
	Mon,  6 Jan 2025 11:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MlWRZbjt"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949D54436E;
	Mon,  6 Jan 2025 11:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736163367; cv=none; b=YlU/RJSOiLz8mwTNl2migJCK/gXf11ga5gKX9RObuaZmNS5GyOmrgamQaS6ZNstfjm4Cy0sGDvVxp2mmkjXOyiq1VvHBe8YxZk40V9EovDX06EtoGnKVipp+XEEW3eDfx7PWyNT/btCCbvyILKPIwC0ye72YuC/2+6PLv03ncgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736163367; c=relaxed/simple;
	bh=LBUAxpsmYNXZIFglggMMgniIO0kuiGahee6e3Q3OKnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a3B/sEwfkU3Z5RAy5rvQFWKbCVGyIBQchd5rjVvuSZWM1dCwmGI/G/mNcw+hRVbXZrs4MlwK5PzejA2W0ZJChi+jD34mT8CDezAOg5NHeyeGLwOiGRlNEuIn2iEArQt3SxyD1F9czsjzuETwDEgH02LIiDwv4QNVy9vbJjp1Dvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MlWRZbjt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2479BC4CED2;
	Mon,  6 Jan 2025 11:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736163367;
	bh=LBUAxpsmYNXZIFglggMMgniIO0kuiGahee6e3Q3OKnI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MlWRZbjtf4gKUzYYZH+8KgpJiXwlSsEJyANSob7yODDCDbUlHN+ikT7MdfO22zqZi
	 jcJ1UobMrlmUCNb69sLUOtvqJOqHC2nUfcA3Anx1hsfR76jVeh2fiboToNB3kjhZg/
	 RUT3CqE5oockJapAyDM/wBE/gn2ATj4jLtEfFo/PE0iaOLl++ABclgMkyvZ6nt845z
	 Sb2QBdD6/qk1zOtA2tIXccSGQZlrFMH9DqkItq9uEYtZNdOTOyliWdnlB2E96TbM78
	 3YLF5EVLKT5zaprK7L7Q7cIsW7uzwuX5GFOuvQwG9MIqfgY6AypnYjtwbkRrqi2uGS
	 kfKBU91gKN6rg==
Date: Mon, 6 Jan 2025 12:36:02 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Pei Xiao <xiaopei01@kylinos.cn>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	lpieralisi@kernel.org, kw@linux.com, heiko@sntech.de,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] PCI: dw-rockchip: remove redundant dev_err
Message-ID: <Z3vAIksxz9rVqLF9@ryzen>
References: <327718207d3cd72847c079ff9d56eb246744c182.1736126067.git.xiaopei01@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <327718207d3cd72847c079ff9d56eb246744c182.1736126067.git.xiaopei01@kylinos.cn>

On Mon, Jan 06, 2025 at 04:14:04PM +0800, Pei Xiao wrote:
> dev_err is redundant because platform_get_irq_byname() already prints an
> error.
> 
> cocci warnings:
> 	drivers/pci/controller/dwc/pcie-dw-rockchip.c:454:2-9:line 454 is
> redundant because platform_get_irq() already prints an error
> 
> so remove redundant dev_err.
> 
> Fixes: 8719dbc54668 ("PCI: dw-rockchip: Enumerate endpoints based on dll_link_up irq in the combined sys irq")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202412312343.najrW1Db-lkp@intel.com/
> Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
> ---
> V2:add to pci list
> ---
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> index ce4b511bff9b..a9795866e915 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -458,10 +458,8 @@ static int rockchip_pcie_configure_rc(struct platform_device *pdev,
>  		return -ENODEV;
>  
>  	irq = platform_get_irq_byname(pdev, "sys");
> -	if (irq < 0) {
> -		dev_err(dev, "missing sys IRQ resource\n");
> +	if (irq < 0)
>  		return irq;
> -	}
>  
>  	ret = devm_request_threaded_irq(dev, irq, NULL,
>  					rockchip_pcie_rc_sys_irq_thread,
> @@ -504,10 +502,8 @@ static int rockchip_pcie_configure_ep(struct platform_device *pdev,
>  		return -ENODEV;
>  
>  	irq = platform_get_irq_byname(pdev, "sys");
> -	if (irq < 0) {
> -		dev_err(dev, "missing sys IRQ resource\n");
> +	if (irq < 0)
>  		return irq;
> -	}
>  
>  	ret = devm_request_threaded_irq(dev, irq, NULL,
>  					rockchip_pcie_ep_sys_irq_thread,
> -- 
> 2.25.1
> 

Reviewed-by: Niklas Cassel <cassel@kernel.org>

