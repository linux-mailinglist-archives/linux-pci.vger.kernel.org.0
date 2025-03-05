Return-Path: <linux-pci+bounces-22938-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2797CA4F6B8
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 06:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75DC33A9BA5
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 05:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAECC1B041E;
	Wed,  5 Mar 2025 05:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vHFob8Wj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C7843AB7
	for <linux-pci@vger.kernel.org>; Wed,  5 Mar 2025 05:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741154080; cv=none; b=BHl1b2FnWcHqI7Q8LKXBFFF1AVl/9qyZ1gUw/73HV0EEfS7kX1/nCAyX8jZ0NskaTlrn4YVsH+3jmgFG0Y85YvBYsV+gesmilA8/rmK/1uLOtJvlFrdQ76gyeAlBWZAT1wMrOfHMNkpavs1y3ymQuwER0nznMTmkQOLgl33qm1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741154080; c=relaxed/simple;
	bh=Dkc8somJtZPFHmhEVhPSvZLAmlkTpFSjQ0P2uyByQ0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XER/csDjSgfnDXUIkcMeyYOF5pC5+2QzAaa0V70GKHA8ohxmDFHuNXbTGtaMIxc15P2Tb34yjKIo+kCkhvfHyCN6+9qNe6eCXDkWleYJU9+4iKDkA/poKmllXc51XFpPxCXo+gz9urNC5WM1DmIT3DZPXD+mzyNxuBTOEgzHwNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vHFob8Wj; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2232aead377so126374175ad.0
        for <linux-pci@vger.kernel.org>; Tue, 04 Mar 2025 21:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741154078; x=1741758878; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pBaqfuH0nvp0/CKv8FiI3gvMbUBBruTI+b7CxarChdg=;
        b=vHFob8WjxP2llcjKtYVmlFV2YJyGbQF/C0iM5lCTEihoSFWHxG+zaBN0u2sLSNahGN
         R3tPWmCrTi0ykN3APXIKfQ7lTOAA0r/g39jechoIYlHrvkiUDoPuFWij9bez4r1VJbYG
         qfpn6trlseHE+GRJukvslj2uGuTP05hkIkY3+zBEZ01TKcXGYBsOmi9wxo68yWv6ps6t
         lWAhGpBrP9sNYFtThD7OTmazLBj+vRmBXlgpCKf9MtkWHWgmfupXrMAl6UBq+CC38yQO
         SAdXHqUTnV8w3yz3HssXTvncudlrf2yPt8C+8peOfpM00BA0heY3ERHZpbjl0nVgYkVC
         iqcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741154078; x=1741758878;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pBaqfuH0nvp0/CKv8FiI3gvMbUBBruTI+b7CxarChdg=;
        b=OuzMiwAb2RD2JZY7WFzIIanPokJmDrzoMMsJkF9aCUQg8099qBs6Lp8fuUHEtTeFoq
         tQCvDYTqj9mTCnLIn/7wSCk8VB0rtN3IHlPNPf3nVNTVhyWzZQHypiRc6IKPcqdQtlle
         LrxGDuL4NVwhxQiTyl6PuxIfGK2ZGUn+/O/u6rD0rWxq/39mSamWX6QJSmhO4hfS2tg6
         NicZTJ/JcFIxMsIuFjLEnORUpInJmyd7BRMda6WhJNnZpOxX6Yid+8lasRbCHVIyD2aj
         QgQdLhgKCumTQI2vZCN100N1P2iI1Rlt2p2OHtufyzT50wrKWnh1K7LuPjajJTJIZ/xP
         w2hQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlGMs4TqKE3+yYg2QoRFtX/Q18AVh6LkBQELLZFNKJzP4ayVEII9P05L7SA1HIT1KlLevP5maoOzY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCRiVxHnuB9xEopRkASbUyiwfvslz82t7mQYmVEcCjlnvJN8c5
	/o0davbYVfIb19kFoKvH3QRJYDmhnySLR1wezOE+7gop10JGkp00l4zpWH99iOd0t1uygRduhzM
	=
X-Gm-Gg: ASbGncvNpsxoL1T5PCvoW/FXKcj+kmUdjKS+m0dqVZlUCAIuttsjeN7tc4hoiekPREM
	SP0zJJHu9xolvDTClfp7nZ29hFAKun3dg8SUWXwOwhFWf8oWI9ZtWsa2i7yEhsR4RgnsgZ/7+C0
	rtY49tqGveyjAmO9iG9SJKUKClKBWessSG/faM8zFqJRaH/oehFgoeIOXcCePcAn2ySgVlPzcBE
	Kgr5bUNK0JIV2xeP3fI34EL0dHM5XqDI7aeE1EDYnyjs/99C5R+pXJK7abTVTVNMBLVyIV3I+1M
	yxBIyfnd4+ddDY6XLmZQ7S3y5FEsvFERsJwZzvZbAG87ayJBpttt9fkV
X-Google-Smtp-Source: AGHT+IH+ovXyo6yjdXwbviwtDpf5aE+3ff4e/+thULtZQRmBI8/5waqVYvqpTAav+z3SB/eNqYkcdA==
X-Received: by 2002:a05:6a00:148f:b0:736:3768:6d74 with SMTP id d2e1a72fcca58-73682b8e228mr3338024b3a.7.1741154078371;
        Tue, 04 Mar 2025 21:54:38 -0800 (PST)
Received: from thinkpad ([120.60.140.239])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736446af900sm6351601b3a.73.2025.03.04.21.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 21:54:37 -0800 (PST)
Date: Wed, 5 Mar 2025 11:24:31 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Zhang Zekun <zhangzekun11@huawei.com>
Cc: songxiaowei@hisilicon.com, wangbinghui@hisilicon.com,
	lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	ryder.lee@mediatek.com, jianjun.wang@mediatek.com,
	sergio.paracuellos@gmail.com,
	angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com,
	alyssa@rosenzweig.io, maz@kernel.org, thierry.reding@gmail.com,
	Jonathan.Cameron@Huawei.com
Subject: Re: [PATCH v3 2/6] PCI: kirin: Tidy up _probe() related function
 with dev_err_probe()
Message-ID: <20250305055431.ugiwvydrdw4rszte@thinkpad>
References: <20240831040413.126417-1-zhangzekun11@huawei.com>
 <20240831040413.126417-3-zhangzekun11@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240831040413.126417-3-zhangzekun11@huawei.com>

On Sat, Aug 31, 2024 at 12:04:09PM +0800, Zhang Zekun wrote:
> The combination of dev_err() and the returned error code could be
> replaced by dev_err_probe() in driver's probe function. Let's,
> converting to dev_err_probe() to make code more simple.
> 
> Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
> v3: Wrap the line which is too long.
> 
>  drivers/pci/controller/dwc/pcie-kirin.c | 40 ++++++++++---------------
>  1 file changed, 16 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
> index e9bda1746ca5..3c9d8da3a241 100644
> --- a/drivers/pci/controller/dwc/pcie-kirin.c
> +++ b/drivers/pci/controller/dwc/pcie-kirin.c
> @@ -216,10 +216,9 @@ static int hi3660_pcie_phy_start(struct hi3660_pcie_phy *phy)
>  
>  	usleep_range(PIPE_CLK_WAIT_MIN, PIPE_CLK_WAIT_MAX);
>  	reg_val = kirin_apb_phy_readl(phy, PCIE_APB_PHY_STATUS0);
> -	if (reg_val & PIPE_CLK_STABLE) {
> -		dev_err(dev, "PIPE clk is not stable\n");
> -		return -EINVAL;
> -	}
> +	if (reg_val & PIPE_CLK_STABLE)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "PIPE clk is not stable\n");

I guess this is a timeout issue, so -ETIMEDOUT.

>  
>  	return 0;
>  }
> @@ -371,10 +370,9 @@ static int kirin_pcie_get_gpio_enable(struct kirin_pcie *pcie,
>  	if (ret < 0)
>  		return 0;
>  
> -	if (ret > MAX_PCI_SLOTS) {
> -		dev_err(dev, "Too many GPIO clock requests!\n");
> -		return -EINVAL;
> -	}
> +	if (ret > MAX_PCI_SLOTS)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "Too many GPIO clock requests!\n");
>  
>  	pcie->n_gpio_clkreq = ret;
>  
> @@ -421,16 +419,14 @@ static int kirin_pcie_parse_port(struct kirin_pcie *pcie,
>  			}
>  
>  			pcie->num_slots++;
> -			if (pcie->num_slots > MAX_PCI_SLOTS) {
> -				dev_err(dev, "Too many PCI slots!\n");
> -				return -EINVAL;
> -			}
> +			if (pcie->num_slots > MAX_PCI_SLOTS)
> +				return dev_err_probe(dev, -EINVAL,
> +						     "Too many PCI slots!\n");
>  
>  			ret = of_pci_get_devfn(child);
> -			if (ret < 0) {
> -				dev_err(dev, "failed to parse devfn: %d\n", ret);
> -				return ret;
> -			}
> +			if (ret < 0)
> +				return dev_err_probe(dev, ret,
> +						     "failed to parse devfn\n");
>  
>  			slot = PCI_SLOT(ret);
>  
> @@ -725,16 +721,12 @@ static int kirin_pcie_probe(struct platform_device *pdev)
>  	struct dw_pcie *pci;
>  	int ret;
>  
> -	if (!dev->of_node) {
> -		dev_err(dev, "NULL node\n");
> -		return -EINVAL;
> -	}
> +	if (!dev->of_node)
> +		return dev_err_probe(dev, -EINVAL, "NULL node\n");

This check is pointless, so you should drop it.

>  
>  	data = of_device_get_match_data(dev);
> -	if (!data) {
> -		dev_err(dev, "OF data missing\n");
> -		return -EINVAL;
> -	}
> +	if (!data)
> +		return dev_err_probe(dev, -EINVAL, "OF data missing\n");

-ENODATA

- Mani

-- 
மணிவண்ணன் சதாசிவம்

