Return-Path: <linux-pci+bounces-6231-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 636548A485E
	for <lists+linux-pci@lfdr.de>; Mon, 15 Apr 2024 08:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3862B209B1
	for <lists+linux-pci@lfdr.de>; Mon, 15 Apr 2024 06:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 109231EB30;
	Mon, 15 Apr 2024 06:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TOkocNCN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926621D53F
	for <linux-pci@vger.kernel.org>; Mon, 15 Apr 2024 06:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713163865; cv=none; b=NfEtodWb/KKE2fXdmKLReUp+IPVK2GWLlB9m9Kyhiie79inJ2LbatZkAGw86yW/efffz0l5uXGjbcyUyad6IAh4B9DUVMpGKTvTBq+G6z1w/tUMVcf6C4Vwfj0g0woSMTEQKgOg2mFabM81ivBy+ClVDttqSInN2SmIeedLnsaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713163865; c=relaxed/simple;
	bh=CJqyLObOQ6APeNi1XLwgvfNQ3BSrUovNB0H8kCnOS7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ArzFgBh4xWX/724AzOkGrFm1zUn2mj9tFMgJInlRJ9lgTxiHjhLb/d5VorpQBlV+jqjBad5gMTDarm0V3GG7pwuuO/2EsSKvaMIl6rPSsJsmW67JjMyhTriJij9RckkUia96t7qzaoK6FWObggi3/tB1DW+3GpNDTotYXlxjkcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TOkocNCN; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6ed11782727so2374742b3a.1
        for <linux-pci@vger.kernel.org>; Sun, 14 Apr 2024 23:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713163863; x=1713768663; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PEJxfvpeTL9PwsFNBxOiLehpxuzN2ftOHpkf1xALIpg=;
        b=TOkocNCNuOrKQKPy69WjYNmHN4ZCy7dQkj5PUbsHenXMnHx4aP/l6GypSl+hDSPwhr
         ugYdy9wlzlXyJEEz9liftKj8Pllbq5wrnYumd01sb+XfJwdxs8hwFXmS7Fwgt/0pSDV6
         7b0PHtSawuiEcRGiOB0FqKh+8Cl1N2WkN2hJWqHlQWN703cwZgE3LJOtX3JH/IaQl2ED
         4e/AxDf46fBwkYKllilXFuD9u3C9O5OWPRmNWSX8eYNKqGOKrhqy4hrCHmlT4lmQocXk
         VWQyDIolvyTgj6mFDSmiU3JPZTDp4q5HIUZiasK/lKa+R50mrh6HLXZQma899TeBm9zH
         U6og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713163863; x=1713768663;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PEJxfvpeTL9PwsFNBxOiLehpxuzN2ftOHpkf1xALIpg=;
        b=EhyL4yUcjGEdR9FBRbplks3MGdbBblHDdqEwcG0NK1ZZo6ypTX+ZrD5Ma/GIf3yn7T
         SCfV1grb49oesMnCrROf9A0I43F7qU+v1eDBNLcsI80HgNg5CN7aC10Mu3icA0YnZ5ES
         BATPPF2SbQZgEkbp8BeD3GHGnf4unjFZKWhG57aQes131vtE4Unf3ahN1C+udojabQL7
         VOplElg819GQ9Z9jHl8gcgMXV/sQTFFDmpJpz6pa47X88wjoNeT6qXHXHMWuhYf2L9CD
         T82O+qiFVyRsvna2PThblC8cloEPty71UNu3T3DlCGn5tQeFPQChQ2JwT3quE1V9kjyR
         Jbbg==
X-Forwarded-Encrypted: i=1; AJvYcCUxeKHAbRDHH60JtN8XbbmPmLj+x2TSSBwXjNKfJDlT3FT03ZpukjlQk8Hl3w0tLC2NBSCdtBFZtY1gV6nXOp69ogRP2l20AkXw
X-Gm-Message-State: AOJu0YxCL4dPzSYhr3fIILZR8zRUx/ar0jEJegPsD0BlmZaPRM2JiGdr
	sGfwYRSk6sEclqC2UwWLoOilkclS91rLeSXptgtxZkrhgGTZEP2vehnITF3VvA==
X-Google-Smtp-Source: AGHT+IEAEfajN2yAj/y0OrMWFHmYxxtw5arcoHq58B7ItcGW4hY4E4nE+BGBSQk4MLak5kFXkoAnXg==
X-Received: by 2002:a05:6a21:8881:b0:1a3:ae4a:930 with SMTP id tb1-20020a056a21888100b001a3ae4a0930mr9656451pzc.33.1713163862718;
        Sun, 14 Apr 2024 23:51:02 -0700 (PDT)
Received: from thinkpad ([103.28.246.218])
        by smtp.gmail.com with ESMTPSA id p7-20020a17090a348700b002a21b9805f8sm7237084pjb.17.2024.04.14.23.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Apr 2024 23:51:02 -0700 (PDT)
Date: Mon, 15 Apr 2024 12:20:58 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 2/2] PCI: rockchip-host: Wait 100ms after reset before
 starting configuration
Message-ID: <20240415065058.GD7537@thinkpad>
References: <20240413004120.1099089-1-dlemoal@kernel.org>
 <20240413004120.1099089-3-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240413004120.1099089-3-dlemoal@kernel.org>

On Sat, Apr 13, 2024 at 09:41:20AM +0900, Damien Le Moal wrote:
> The PCI Express Base Specification r6.0, section 6.6.1, states that the
> host should wait for at least 100 msec from the end of a conventional
> reset (PERST# is de-asserted) before sending a configuration request to
> ensure that the device is able to respond with a "Request Retry Status"
> completion.
> 
> Add the PCIE_T_RRS_READY_MS macro to define this wait time and modify
> rockchip_pcie_host_init_port() to add this 100ms sleep after deasserting
> PERST# using the ep_gpio GPIO.
> 
> Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/controller/pcie-rockchip-host.c | 2 ++
>  drivers/pci/pci.h                           | 7 +++++++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
> index fc868251e570..cbec71114825 100644
> --- a/drivers/pci/controller/pcie-rockchip-host.c
> +++ b/drivers/pci/controller/pcie-rockchip-host.c
> @@ -325,6 +325,8 @@ static int rockchip_pcie_host_init_port(struct rockchip_pcie *rockchip)
>  	msleep(PCIE_T_PVPERL_MS);
>  	gpiod_set_value_cansleep(rockchip->ep_gpio, 1);
>  
> +	msleep(PCIE_T_RRS_READY_MS);
> +
>  	/* 500ms timeout value should be enough for Gen1/2 training */
>  	err = readl_poll_timeout(rockchip->apb_base + PCIE_CLIENT_BASIC_STATUS1,
>  				 status, PCIE_LINK_UP(status), 20,
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 17fed1846847..c93ffc5e6e1f 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -16,6 +16,13 @@
>  /* Power stable to PERST# inactive from PCIe card Electromechanical Spec */
>  #define PCIE_T_PVPERL_MS		100
>  
> +/*
> + * End of conventional reset (PERST# de-asserted) to first configuration
> + * request (device able to respond with a "Request Retry Status" completion),
> + * from PCI Express Base Specification r6.0, section 6.6.1.
> + */
> +#define PCIE_T_RRS_READY_MS	100
> +
>  /*
>   * PCIe r6.0, sec 5.3.3.2.1 <PME Synchronization>
>   * Recommends 1ms to 10ms timeout to check L2 ready.
> -- 
> 2.44.0
> 
> 

-- 
மணிவண்ணன் சதாசிவம்

