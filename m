Return-Path: <linux-pci+bounces-4013-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF7668675FD
	for <lists+linux-pci@lfdr.de>; Mon, 26 Feb 2024 14:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFC56B229C3
	for <lists+linux-pci@lfdr.de>; Mon, 26 Feb 2024 12:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9937F7F9;
	Mon, 26 Feb 2024 12:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BrkB64L+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505B3604CC;
	Mon, 26 Feb 2024 12:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708952007; cv=none; b=CsYBEFJk4xbzlzHpNqdqlOb2z2kiyNUra+H+t6Av/iWM81SbnViIkagxxxGgYfD2HJUPskLanX6UV/0kd8h/z/mHQJ8VCrx0L70iWEHCwy8G6OREQe4xSkEHBGJfbVRlocD98DgYcIaisjruuwIX3GfkzL2NmCBVWtBq6dxdfeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708952007; c=relaxed/simple;
	bh=+9bFTdaZN0sNxaXlHrqrWk5lnAZUUQT7AZ/mmZL7Fvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rx7Ke1loZomMfAXInZ6rVxsBC3bxMe/afqPX7UOnBhoR/tru5bqr+iQW03Hu1YagMjYlrf25GoTBT0AZbOS0bXlKf0Uj5Elt0HP+4hDq/20vNrqZ5hZG8YdqoUPV9mFLwSNtL4HdBD2IjP2IPJolbaNS5DyNoqJW16wyr3IkdX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BrkB64L+; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-512f54c81d2so1498205e87.2;
        Mon, 26 Feb 2024 04:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708952003; x=1709556803; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=96ZM0BBE+jJXYNw871lXR/5rqt8HxgCfbVdQRkOIEUw=;
        b=BrkB64L++in9BOacviKlLevM33vrMPefKfGX9ZLGTI7JpauIp9moikwcdpFXnfZ++G
         uYW+C7xPO5961LiQDGUZ9r8X5nRcqftuX/y/CGUr2aUEuNH44vI4aNxU7tChXINQ6DEs
         1EdMyW3BsJE7sHs0oiGISORbl7OpMaeycWKyMxaImMG/Bm53BfVSWjr32V1fADGksasb
         xf4Il7ulFVKGaeGKBWft1uMxzblOq0z8NVhkzrn+ITkQI/DBSacY4AF1FX8ZCKm7U71X
         faJpJaCLPcTnMDOnfHxXYvo8KtCCst9GCQv7CrGScZWOity/3Kvc0s8vnpWTfBvysf57
         D/pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708952003; x=1709556803;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=96ZM0BBE+jJXYNw871lXR/5rqt8HxgCfbVdQRkOIEUw=;
        b=GTqnuOi3QFD9JTF48Uv7VppLYog23BPnNADaoSaT/8lkx1R/o3KZftagiAAiMrbvA+
         nZ31FiRiDJeO9m3xy0+RZMf8M8zvEH6FgVrgnQvv1+foVw2M+7r5quCVt9SuDF6fdVQa
         9gqSP4VwG8pOY2NXc0Oc0px/aJLdUpEDd6INA1MMjWJaT3+iK8mGJTT2It5SIeHGT+1U
         bL/R9cBLbI4RJaqyQqvzutwnGhiVXFAOwln5bs1jX6GAwa5NtuWIaIh17FuTyDjt2jgl
         0B7fBumCi3eW92T8ZeAfW0zoPNS5h77BfT2vIgh+JQY6nuCG5BfrXcegr7S6Q7fQ05iH
         yTyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlslbRbvbc8Ad0dtVr0iLfFgQG50CFA3gQwgzeJweXyK/rgYhLiqhUyWMsgv2lkS2Xb0k5Yx32n9AItz/QuYLqQJCtJIgZyM+usyE10gZTzvxmDQAX774SCeupId2aKY8/bGCsoQUusgBGvWJH11NlnxnnoE/C9cWjOfj9+iKGfBhMJMioCU/XbQRku0sux77dquIOqUxjE8/7tKZKqE4+SwLi8XU9sAgy
X-Gm-Message-State: AOJu0YyY5ih6JBmOEYWNBACASj0uLHwb+pCaNNkdHHmUoWKspoYyxhUz
	ccTqikZ6uTym/ADzaOcQTqMCmXjSKHJshrdMrmBNQEHA8YswbkfpGvoWZae2
X-Google-Smtp-Source: AGHT+IHUsdLyYMK/hor/+DIL9NkSQYxUsgFEj+2JqEvtgKE+O4rfAVV95OSAVAFGN0KoyPIWi302lw==
X-Received: by 2002:a05:6512:224b:b0:512:f7e3:2ca0 with SMTP id i11-20020a056512224b00b00512f7e32ca0mr3369529lfu.61.1708952003264;
        Mon, 26 Feb 2024 04:53:23 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id e21-20020a196915000000b00512ffb9bae9sm222505lfc.143.2024.02.26.04.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 04:53:22 -0800 (PST)
Date: Mon, 26 Feb 2024 15:53:20 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>, 
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Marek Vasut <marek.vasut+renesas@gmail.com>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev, Siddharth Vadapalli <s-vadapalli@ti.com>
Subject: Re: [PATCH v3 2/5] PCI: dwc: Skip finding eDMA channels count if
 glue drivers have passed them
Message-ID: <5gzkxdpx6u3jhw5twbncjhtozgekmlzxrpj3m6is3ijadm2svb@f6ng4owyakup>
References: <20240226-dw-hdma-v3-0-cfcb8171fc24@linaro.org>
 <20240226-dw-hdma-v3-2-cfcb8171fc24@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226-dw-hdma-v3-2-cfcb8171fc24@linaro.org>

On Mon, Feb 26, 2024 at 05:07:27PM +0530, Manivannan Sadhasivam wrote:
> In the case of Hyper DMA (HDMA) present in DWC controllers, there is no way
> the drivers can auto detect the number of read/write channels as like its
> predecessor embedded DMA (eDMA). So the glue drivers making use of HDMA
> have to pass the channels count during probe.
> 
> To accommodate that, let's skip finding the channels if the channels count
> were already passed by glue drivers. If the channels count passed were
> wrong in any form, then the existing sanity check will catch it.
> 
> Suggested-by: Serge Semin <fancer.lancer@gmail.com>
> Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 193fcd86cf93..ce273c3c5421 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -927,13 +927,15 @@ static int dw_pcie_edma_find_channels(struct dw_pcie *pci)
>  {
>  	u32 val;
>  
> -	if (pci->edma.mf == EDMA_MF_EDMA_LEGACY)
> -		val = dw_pcie_readl_dbi(pci, PCIE_DMA_VIEWPORT_BASE + PCIE_DMA_CTRL);
> -	else
> -		val = dw_pcie_readl_dma(pci, PCIE_DMA_CTRL);
> -
> -	pci->edma.ll_wr_cnt = FIELD_GET(PCIE_DMA_NUM_WR_CHAN, val);
> -	pci->edma.ll_rd_cnt = FIELD_GET(PCIE_DMA_NUM_RD_CHAN, val);

> +	if (!pci->edma.ll_wr_cnt || !pci->edma.ll_rd_cnt) {

Are you sure that the partly initialized case should be considered as
a request for the auto-detection? IMO &&-ing here and letting the
sanity check to fail further would be more correct since thus the
developer would know about improper initialized data.

-Serge(y)

> +		if (pci->edma.mf == EDMA_MF_EDMA_LEGACY)
> +			val = dw_pcie_readl_dbi(pci, PCIE_DMA_VIEWPORT_BASE + PCIE_DMA_CTRL);
> +		else
> +			val = dw_pcie_readl_dma(pci, PCIE_DMA_CTRL);
> +
> +		pci->edma.ll_wr_cnt = FIELD_GET(PCIE_DMA_NUM_WR_CHAN, val);
> +		pci->edma.ll_rd_cnt = FIELD_GET(PCIE_DMA_NUM_RD_CHAN, val);
> +	}
>  
>  	/* Sanity check the channels count if the mapping was incorrect */
>  	if (!pci->edma.ll_wr_cnt || pci->edma.ll_wr_cnt > EDMA_MAX_WR_CH ||
> 
> -- 
> 2.25.1
> 

