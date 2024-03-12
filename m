Return-Path: <linux-pci+bounces-4749-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5278B8790A5
	for <lists+linux-pci@lfdr.de>; Tue, 12 Mar 2024 10:22:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E53571F245C3
	for <lists+linux-pci@lfdr.de>; Tue, 12 Mar 2024 09:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE087CF38;
	Tue, 12 Mar 2024 09:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FNxE8aax"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7D17CF20;
	Tue, 12 Mar 2024 09:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710235075; cv=none; b=VbW3MTJNn9oWBjRsoUAS9nDxlG9f9nhd33I7HYT1Hnm26tuc902GG+sKTYJrG7iUlWi0YV0sbrUCeBMOZjdvc0C4eZtClETSO/AKRMSDlmuh3AxBQBaZf6IlSFR2V2rYbpRxo4hNSkhGD/bdDFuS9mPqE6sDFreRNBZ/DwaJrCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710235075; c=relaxed/simple;
	bh=n/xyd4RSK51AZo83JsP+jj0gL9V4BBAgGqAGe8AEkg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c3Vg+G/L84oIgZx8kkZqLo9Z7eo+5vDUKSazUeoH3Rj2kck7s0mNJFR+lKhE2/bfujmqztjKsP4pceWPykacF8X7wbxjyskT29zKhlwO1c2SS0oaosILeEguaMsZnVkYqC7R4ReLEikpiHtA0cPDVR/Zd8ouQ4pRAOSCGd1I4d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FNxE8aax; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d27fef509eso86793231fa.3;
        Tue, 12 Mar 2024 02:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710235072; x=1710839872; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BZ6n3LCBgXbzRZ+jOk9gBUl7KDl6UUW0N9+kmdRSwFk=;
        b=FNxE8aaxTE41lxHvEop8BP5yy26v1Bk6wAoqvUWhnDQo2klrkHjK+dKHA5zqp8wyFZ
         WI3DjOE61M885NnfXJ9RhBjz0M8r5jvj5OyTA4rFTVRkEu3/oje6BZ18THm0siahmQLZ
         STrCtLAy8SIiPQzWJmOSCl9QQokoqBM1sE/uY7yGkAvLKF8mTTsv+/UEyugM/s54oA+K
         qPm2BfgPtbNTjygSL+GlKMTxvhFrRdCeklWdbCk5QbYWDhOoiJKsiw7OYhmTCcZ9Cmu0
         PV0CaFMnRI5cAKdkJ6OtRnlfVdzuY2X+gyDkRE0dwqjjBL27yxfdRiNC2luF1Orq4tXm
         lmqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710235072; x=1710839872;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BZ6n3LCBgXbzRZ+jOk9gBUl7KDl6UUW0N9+kmdRSwFk=;
        b=OhLIYnKLjelxIQGcSsolf0P89LISXMdOqdAQT3U1p8uciqVoMol626dxz72lVBG1Ms
         oPpoEFK450xkXPJA18HNnyyiExCDsl2NYhGlyPNkpM1iLnBh/77aJkxqGgXjBM6LgP3y
         337K0PuFgwGjw75KCRtENGHqneWR7vSizmSWTln5ADfYij2Gv6GpDhf9OowoaNnMhH18
         V2odiRMgnRnUVYqxoxcdlUNxDLw9vnW/vmdyUvDu2eEOAQGno/Aqxhfk85+s1SURT5/5
         wtUB7nhcf8jTPoCuOT96hBHVDbUqUqX60uluMeL1L0YtYrdDlaNCHhW6idEnWjbOHrAL
         99iA==
X-Forwarded-Encrypted: i=1; AJvYcCUW6updcz66nF2r0+YZCCCuZApbM9gZRSxiSiipiUn5DrG3MS9eageIUYhfjrmvNoBDL/wESqKORoUiYU5odEHgmbGhwU56AQmScWwNtWSzVT4DmyDT6JM3/CRXM2TjMdsLQdq+Nn9MV/a2xo8V2+l2QVYj3sK/zrJ6IFx8GuuL2ehVLcHNhxs0vgGULiXYP4Z8IOZbHm/PERQDdwtRv8h4sKYDmInQ64HA
X-Gm-Message-State: AOJu0YwopXVHxULAjUDqcZyNif27uxgES2ixJFPyDXdLc14gyrV1h4Ai
	q3o8ctVjbkNepousnSfi6Rt1w19/erfOaaiU9Ea/HU/EjboFtAeq
X-Google-Smtp-Source: AGHT+IFm7+AOiUOnzjOZiIaCXRd9rxISYVnr31Yubo08D3ay+vXSLHfTEBCY79LtjUa86DxxV5qF6A==
X-Received: by 2002:a2e:be8d:0:b0:2d4:59bd:bc87 with SMTP id a13-20020a2ebe8d000000b002d459bdbc87mr790603ljr.4.1710235071652;
        Tue, 12 Mar 2024 02:17:51 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id f9-20020a05651c02c900b002d2a710f864sm1521827ljo.24.2024.03.12.02.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 02:17:51 -0700 (PDT)
Date: Tue, 12 Mar 2024 12:17:48 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>, 
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Marek Vasut <marek.vasut+renesas@gmail.com>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev, Siddharth Vadapalli <s-vadapalli@ti.com>, 
	Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v4 2/5] PCI: dwc: Skip finding eDMA channels count for
 HDMA platforms
Message-ID: <kqztfm6ri54pkxcmsmngldmlf22mt2vn5cgxxfhjqxujx3qkq2@us6rc2sof7gk>
References: <20240306-dw-hdma-v4-0-9fed506e95be@linaro.org>
 <20240306-dw-hdma-v4-2-9fed506e95be@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306-dw-hdma-v4-2-9fed506e95be@linaro.org>

On Wed, Mar 06, 2024 at 03:51:58PM +0530, Manivannan Sadhasivam wrote:
> In the case of Hyper DMA (HDMA) present in DWC controllers, there is no way
> the drivers can auto detect the number of read/write channels as like its
> predecessor embedded DMA (eDMA). So the glue drivers making use of HDMA
> have to pass the channels count during probe.
> 
> To accommodate that, let's skip the existing auto detection of channels
> count procedure for HDMA based platforms. If the channels count passed by
> the glue drivers were wrong in any form, then the existing sanity check
> will catch it.
> 
> Suggested-by: Serge Semin <fancer.lancer@gmail.com>
> Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

Please find a tiny nitpick further below.

> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 3a26dfc5368f..599991b7ffb2 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -927,13 +927,18 @@ static int dw_pcie_edma_find_channels(struct dw_pcie *pci)
>  {
>  	u32 val;
>  
> -	if (pci->edma.mf == EDMA_MF_EDMA_LEGACY)
> -		val = dw_pcie_readl_dbi(pci, PCIE_DMA_VIEWPORT_BASE + PCIE_DMA_CTRL);
> -	else

> +	/*
> +	 * Autodetect the read/write channels count only for non-HDMA platforms.
> +	 * HDMA platforms doesn't support autodetect, so the glue drivers should've
> +	 * passed the valid count already. If not, the below sanity check will
> +	 * catch it.
> +	 */

This is correct for the _native_ HDMA CSRs mapping. I suggest to emphasize
that in the note above.

-Serge(y)

> +	if (pci->edma.mf != EDMA_MF_HDMA_NATIVE) {
>  		val = dw_pcie_readl_dma(pci, PCIE_DMA_CTRL);
>  
> -	pci->edma.ll_wr_cnt = FIELD_GET(PCIE_DMA_NUM_WR_CHAN, val);
> -	pci->edma.ll_rd_cnt = FIELD_GET(PCIE_DMA_NUM_RD_CHAN, val);
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

