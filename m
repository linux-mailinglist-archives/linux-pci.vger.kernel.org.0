Return-Path: <linux-pci+bounces-6230-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 305098A4858
	for <lists+linux-pci@lfdr.de>; Mon, 15 Apr 2024 08:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA3471F219EC
	for <lists+linux-pci@lfdr.de>; Mon, 15 Apr 2024 06:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D311CFB9;
	Mon, 15 Apr 2024 06:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yOd/1iz8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666DE1D53F
	for <linux-pci@vger.kernel.org>; Mon, 15 Apr 2024 06:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713163746; cv=none; b=XLVd2ihp2e6yOHt2bHFBWzX05NEMP6RHsRCZbEUSIt7UvuFlXU9Z/m9OjTbqWbY52bobpC//NbnOSk1sbu2O8nQuhOvX9BHOpzqlwnmxkAHsvpixt9oGPwjlD6ZF+xvYYFBRlb8CSVPqHDF3g9VLTLqjrlwkqqa5d30huaptqEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713163746; c=relaxed/simple;
	bh=ZGTWmt7VQ+HNU+nhCbLrAteLkGAt9wTCd5mwZqRX45Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aavKAy0kdWupo/7WvrePztIjOByo+A4ki3lFjjIiGKG7ktLl23/VA9IJ2DvMtL0n2XN/Ovo1QyYfKid6Ltw1m/x3Xmz4PL/uu7cj0yET6pD5SLDDoUn/G+vwd1IS9HwbcQNKMjkmFPD9A6JYLMZblFfWxuUFFPcNQIejYhHtnxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yOd/1iz8; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2a2dd2221d3so1969291a91.0
        for <linux-pci@vger.kernel.org>; Sun, 14 Apr 2024 23:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713163745; x=1713768545; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wbma48kMrwhXpK04EVJIgSb7zQnNro8/X2QtwMKJVXw=;
        b=yOd/1iz8jOJNehySnMCwXU8gax63h3htwM5Fc2BMydgJnQHtd1UWMeMyEfaAo5ljdD
         ue+J4aGLKiqb/79tG1875iH6Y4HCa+1WgxHs8Xj/BzoaDZMX2fkL7awqp27wJ5Rk6hGh
         63InB3dO1LNqW68DRTOQPOA2OG7+aMBxVgk6oRCWrbLPSKMR9LE0Db16uJzQtEYtpXE0
         nhG66UkPfefECmN34ATwikBhgD+vykWx8bft54XPvnkVKNKsRIdeoyHiStaHWIDU636V
         UwVoF74MsBUnxxtAzoDDZIF5Ce05qdA096gKb1oX3CpGQGj0WrhyO3PnSg/5iTnSG4Wy
         VV+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713163745; x=1713768545;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wbma48kMrwhXpK04EVJIgSb7zQnNro8/X2QtwMKJVXw=;
        b=vn8jS7u3z0+O8oYVe7Qq+b96io8FoAnOt5oKyhj5q0WYwpWaY95cviV9c41FaqQsqy
         6q5Kv0brH9xeS/uzJWKX6LPhPIczEgxU+I4NeWw3wW7+SNRJvUr5BVrxl548eDNs5Fhv
         8o+Wlu+3stPrGt46/RR3g5WwFyfJ8dzexAC5At6ol7JsCuQWjDjI0tO9f5cAq5923D2K
         RlrA/0M8zuswpE2/ZcUBMgCjlczxFKfwJ8tXxFcorue27YoXzkqOH6pDa0TdDJUt3J50
         7W9Pi5cPoiecEbKnvqQgx0DWlzsX3ZZTjM5RbqXHfQDfvBPnYbuOkhe0naxS/cPW2rdF
         RqwA==
X-Forwarded-Encrypted: i=1; AJvYcCWWUIq6SEpAKtcIc8Jf/Oslaz4ecbxuCNpKRLrN3T5eFCi0/cLCJBV6tPhqgD5ClxNZXi0WqQzI3nhunfQ0k1S6psDQCmN3Gs7u
X-Gm-Message-State: AOJu0Ywt2FnLqF/FF5hYFb96AQbZdoMuyPDC7GHYmY5+o4znZAOAbrKy
	eBR7NsyV6Zy+E6QDrUZSimj1mj2JKuNpCA8EC3tMlyJnID31rl6stc01LtgUrNDEgWADxsIgmH4
	=
X-Google-Smtp-Source: AGHT+IGC8V47YXDa/6cXYpOHnzIDDAqTZinRyZksANZMUlFOAS1daDDExrMfx9Hmclx5tmkYR75Oiw==
X-Received: by 2002:a17:90a:fb82:b0:2a5:3399:b703 with SMTP id cp2-20020a17090afb8200b002a53399b703mr6948189pjb.11.1713163744476;
        Sun, 14 Apr 2024 23:49:04 -0700 (PDT)
Received: from thinkpad ([103.28.246.218])
        by smtp.gmail.com with ESMTPSA id nh14-20020a17090b364e00b002a67b6f4417sm5898986pjb.24.2024.04.14.23.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Apr 2024 23:49:04 -0700 (PDT)
Date: Mon, 15 Apr 2024 12:18:59 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 1/2] PCI: rockchip-host: Fix
 rockchip_pcie_host_init_port() PERST# handling
Message-ID: <20240415064859.GC7537@thinkpad>
References: <20240413004120.1099089-1-dlemoal@kernel.org>
 <20240413004120.1099089-2-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240413004120.1099089-2-dlemoal@kernel.org>

On Sat, Apr 13, 2024 at 09:41:19AM +0900, Damien Le Moal wrote:
> The PCIe specifications (PCIe CEM r5.1, sec 2.9.2) mandate that the
> PERST# signal must remain asserted for at least 100 usec (Tperst-clk)
> after the PCIe reference clock becomes stable (if a reference clock is
> supplied), and for at least 100 msec after the power is stable (Tpvperl,
> defined by the macro PCIE_T_PVPERL_MS).
> 
> Modify rockchip_pcie_host_init_port() to satisfy these constraints by
> adding a sleep period before deasserting PERST# using the ep_gpio GPIO.
> Since Tperst-clk is the shorter wait time, add an msleep() call for the
> longer PCIE_T_PVPERL_MS milliseconds to handle both timing requirements.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/controller/pcie-rockchip-host.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
> index 300b9dc85ecc..fc868251e570 100644
> --- a/drivers/pci/controller/pcie-rockchip-host.c
> +++ b/drivers/pci/controller/pcie-rockchip-host.c
> @@ -322,6 +322,7 @@ static int rockchip_pcie_host_init_port(struct rockchip_pcie *rockchip)
>  	rockchip_pcie_write(rockchip, PCIE_CLIENT_LINK_TRAIN_ENABLE,
>  			    PCIE_CLIENT_CONFIG);
>  
> +	msleep(PCIE_T_PVPERL_MS);
>  	gpiod_set_value_cansleep(rockchip->ep_gpio, 1);
>  
>  	/* 500ms timeout value should be enough for Gen1/2 training */
> -- 
> 2.44.0
> 
> 

-- 
மணிவண்ணன் சதாசிவம்

