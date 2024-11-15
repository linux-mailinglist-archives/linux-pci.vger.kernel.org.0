Return-Path: <linux-pci+bounces-16818-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C929CD774
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 07:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DA561F22078
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 06:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55FE518BBBB;
	Fri, 15 Nov 2024 06:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="El6KvHKm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD541898EA
	for <linux-pci@vger.kernel.org>; Fri, 15 Nov 2024 06:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731652880; cv=none; b=kfD+VxvPQfcI6I8NZ2l5ks2+jHGA9usVKJlNyBKWiIf6veU8NjvvzYlcIhA25LQKrTu4zafUQQCNcY8qJY06dzedw09GRrYz4yaRy0kyXQ7W+DHQNjnF11RpDERogGyDo2hN1cyNPxcwxz9UCapgRAdzAG5OMYoKi26DtvKed2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731652880; c=relaxed/simple;
	bh=+YWto08nAzQlfP7Roih16Ol20t5fEagbMxHoY96FEVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q9puofEtZ5XwGEbaFu88Why59xTTw54vPtxAXDiY/OA01hTkuDKJWUyrJppeEIGQliF3ZWEhzpa2BUU//W1aqzJnDk7CNT4DIWkccUO0HxSjJTu5ovvcXRtviGUeH+tgcvj8YCFTWlvdsiVCZat5ydqNz+7/sA8cnvBprYU5RJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=El6KvHKm; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20c8b557f91so15216475ad.2
        for <linux-pci@vger.kernel.org>; Thu, 14 Nov 2024 22:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731652877; x=1732257677; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+9X/wxgCiPevQR8azxljXcXglwxyvUBHBH4k0NcW95s=;
        b=El6KvHKmsxwVaz6fEUkDRNTQgVCXlc2uUgVliom5qc6cPNIQL7l8xdFeoZmz2hcD24
         g7AL7pehyZ4bIVtRW9PVsG3BoXMzmwbqQkp6Olce1co9AezU8ap/2dHXzQZ3fKql6/gt
         CZguZ5Y9ohKfuo5sKCnfprwukC0k6UoQO5GlBW0kxn6AEdnraLt6dAKsm+wwSXc8DnlZ
         bolLElMLa7Y8yw7mBhgNd/FTFlnfxSRL1PWTR+fM+/OwI+N3jDz3LbwF04eM0QzqFfVO
         fDZzEDPG209L0V1yPfjdJtKNQdpHNQpft8KKlnjKsNPp4h37XhKNF66sd1pNdWW8JWAl
         C06A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731652877; x=1732257677;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+9X/wxgCiPevQR8azxljXcXglwxyvUBHBH4k0NcW95s=;
        b=B8iX5Dvhy6ltUzKSr3M5qOxu0BVN2qf9tGZI9AROypteJe59BfHaYuZ1LXSIrMu1Pn
         9erQ5dMPJiGC8e7i0Xy+8GX7070TZe99ty3aGFSz4lEyzXuliRBM8o5ml8UDQRn1xeOx
         57DMnt0lO0jtcK8VcKZ2d3GojwR15EbYXPpNN+0EtRwvy8x1x2v/rACrHNMow44q0B/3
         BkVAN8fUAUZuh2q+wrwxhqGWX+xOucbfVrTMhUUOQbItPmwVdpH10zzAqVqJHNzODbMz
         J35GELEIrr7ltL647z+orxFqO7zYK+E1kQ9b69A9LS2PMnotazqaJUBFSRNZkdhoHzxn
         tNLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWE9S6anPgT3dP6GUGaAizUStSd+iCQC6jlk6ZcQXP21LmO10d2auMLWQnngRPG0TPO9EpOhkYOkGY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaLj3on93/KOypaI7AvJHAGcXvbsundJQQFacwLtjE0fRcI0A1
	EOIaxIS1vyBAMcj3PqbFE2QptoUvAy/DNzWjh9uvyM5qTxc2rvmKzb6Ots+Gmg==
X-Google-Smtp-Source: AGHT+IGabkTqfzJ7F61xnkcjI95zLPKfJGfkK+pvHWTH/TvMDmJ1L9QNKaKVIJTm7qh/u3tDNf6Mrw==
X-Received: by 2002:a17:902:f544:b0:20c:f27f:fbf with SMTP id d9443c01a7336-211d0d7687fmr23670135ad.25.1731652877101;
        Thu, 14 Nov 2024 22:41:17 -0800 (PST)
Received: from thinkpad ([117.193.208.47])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0f56e10sm6129835ad.242.2024.11.14.22.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 22:41:16 -0800 (PST)
Date: Fri, 15 Nov 2024 12:11:06 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: l.stach@pengutronix.de, bhelgaas@google.com, lpieralisi@kernel.org,
	kw@linux.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, shawnguo@kernel.org, frank.li@nxp.com,
	s.hauer@pengutronix.de, festevam@gmail.com, imx@lists.linux.dev,
	kernel@pengutronix.de, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 03/10] PCI: imx6: Fetch dbi2 and iATU base addesses
 from DT
Message-ID: <20241115064106.iwrorgimt6yenalx@thinkpad>
References: <20241101070610.1267391-1-hongxing.zhu@nxp.com>
 <20241101070610.1267391-4-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241101070610.1267391-4-hongxing.zhu@nxp.com>

On Fri, Nov 01, 2024 at 03:06:03PM +0800, Richard Zhu wrote:
> Since dbi2 and atu regs are added for i.MX8M PCIes. Fetch the dbi2 and
> iATU base addresses from DT directly, and remove the useless codes.
> 

It'd be useful to mention where the base addresses were extraced. Like by the
DWC common driver.

> Upsteam dts's have not enabled EP function. So no function broken for
> old upsteam's dtb.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 20 --------------------
>  1 file changed, 20 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index bc8567677a67..462decd1d589 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -1115,7 +1115,6 @@ static int imx_add_pcie_ep(struct imx_pcie *imx_pcie,
>  			   struct platform_device *pdev)
>  {
>  	int ret;
> -	unsigned int pcie_dbi2_offset;
>  	struct dw_pcie_ep *ep;
>  	struct dw_pcie *pci = imx_pcie->pci;
>  	struct dw_pcie_rp *pp = &pci->pp;
> @@ -1125,25 +1124,6 @@ static int imx_add_pcie_ep(struct imx_pcie *imx_pcie,
>  	ep = &pci->ep;
>  	ep->ops = &pcie_ep_ops;
>  
> -	switch (imx_pcie->drvdata->variant) {
> -	case IMX8MQ_EP:
> -	case IMX8MM_EP:
> -	case IMX8MP_EP:
> -		pcie_dbi2_offset = SZ_1M;
> -		break;
> -	default:
> -		pcie_dbi2_offset = SZ_4K;
> -		break;
> -	}
> -
> -	pci->dbi_base2 = pci->dbi_base + pcie_dbi2_offset;
> -
> -	/*
> -	 * FIXME: Ideally, dbi2 base address should come from DT. But since only IMX95 is defining
> -	 * "dbi2" in DT, "dbi_base2" is set to NULL here for that platform alone so that the DWC
> -	 * core code can fetch that from DT. But once all platform DTs were fixed, this and the
> -	 * above "dbi_base2" setting should be removed.
> -	 */
>  	if (device_property_match_string(dev, "reg-names", "dbi2") >= 0)
>  		pci->dbi_base2 = NULL;
>  
> -- 
> 2.37.1
> 

-- 
மணிவண்ணன் சதாசிவம்

