Return-Path: <linux-pci+bounces-22939-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7110A4F6B9
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 06:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE4AF188C4C4
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 05:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994F8193062;
	Wed,  5 Mar 2025 05:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iUFKTHkb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1533043AB7
	for <linux-pci@vger.kernel.org>; Wed,  5 Mar 2025 05:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741154113; cv=none; b=B3lrhcdI45fO4onq8mJBzeqOy3Swt/j97Jpg/o2AS/uQeZgm9s/nv/vnaNKfeTCmT911Rk+FgGX/0vso6gL75DPzc0jn6zAbUKuf/J/vmTwTl8JvfQKLBP7GREGAPcksTuKDqP0xs7TrcYpFpRIv2ueCB6bC/0fFi1RyH/runZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741154113; c=relaxed/simple;
	bh=jhyDVfzF3fePkuuEUFB8b1huYwGrDTDmV4O2DfoRYKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=my3rkBsqQD1daNKdEacoyYzPPo9P0uFUyTrxojNU9LXubnf+SrpB2XZrkHpU6kUwzIlnuBM9nQt2On+c/MfP3rBjuDvwbuwwsEBbWySyA3Rt/QRMr9WQkCY3kqeCnduXEP+XiaEmHcPuMlc+IyyFjORIi1FkzoV1vLN1VzSwhrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iUFKTHkb; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2232b12cd36so88266705ad.0
        for <linux-pci@vger.kernel.org>; Tue, 04 Mar 2025 21:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741154111; x=1741758911; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cs+uBL5lexAJy5uw3bAY6Q6CeCsOrLPFCtzaP1jN1Y0=;
        b=iUFKTHkbj89NX/+3NTYVENOnaYvrccthB6fen33Oj9q49hbR87TYUyAP6fHM5ZDZYm
         LzWvRMoCk/SGNM5NRhCPO61KDB2wgkOqsBwYvfQjY3IeQhLUnX+K0iMUyitGa1r9L7B4
         AazMSmTBeoiL3619bICBlhExOZ+VZ/oLDU80MKtvjjG2Wl2If9tQ8xj3A7jRLXPRcux8
         F1vd+byxrwj5h/obXj1XAn7lbnnoI53FEqKHibB81R2Q6zrOAcIB3RHl9vvkRTsc0yjC
         e6p5Suy2e0+1jwF/ujwrU7D1Z2ihV0uHXGFTNDj4IWzhQYsjvMz0H48Bgr9SpOiX5pOR
         D5iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741154111; x=1741758911;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cs+uBL5lexAJy5uw3bAY6Q6CeCsOrLPFCtzaP1jN1Y0=;
        b=jETf2Y8haeLgfgjtF58mdYbMYxcwAa0HKQqIqbFhy6B/BjgLjiT7EvfTWl2S3fz8pH
         P9AM2FLKnVdCZJy8B7SwqcJ8H34zWAQkJwg61wZsAE+RFRj/2BMVE8S7Ut+M7675wq0C
         Yp+Xf9GJgFxzBRv2urDdyaSMAxNhofBfHMLecah5liLtSOoG7CNLmZgg3uspfMMxGxM1
         FO5njdQJ4GMI2DAH5jHCoA59di6GknN5ha1i2klxjVYUc2aZ7F7+6vtcW7Aob5jrutOt
         NcwjtATavdDp0Uuw2ProFLdzqznV4FSBDgz6pDhRFMZEAxM4bWvvTfplyhgHFmovJMg9
         7PGw==
X-Forwarded-Encrypted: i=1; AJvYcCVevu2N83n9co2ZG/cmqgIijxXirQPrwOdREORrN9tA0e9nKAxD/t9m257DFhF/A7qV5CApicbjEos=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy63eSF3XmhEDfhB8fdoHXrJtsEnDH9oM8Oj3opABpgICvluycr
	Ibm+V1U6WP8Y7/G0ayL9vrN+8eF7HDXdRCC9ywwCrXobR7HnbSLOM1wiSb+I3w==
X-Gm-Gg: ASbGnctWR/JmZCMWlyMF3cqzpg12dBvd3sxME2Hl3wedsHD/JL4Vj3+/FMR/x+XorkI
	yhwStRCMdbftam7AkdSIkdjOpx1BGjQo9iPWnEJfyNz6t+86J54hbZdjI3zFhbPiztW5N2GHfvy
	9MvnjpWrszNVH6zDz6tmGZ2cP0wtbwRTXcOHWvyXTzXLkegYkI1cQq7kQkOXg58q9pbl4j0ezaV
	ZdsoUw2xXhzVPzAAa2ZBUyg9bvMyWT3/Qm3ESWX0E6kks+yp6ZIliHWQD0CXexNSpoAUv01dlcA
	smoxTXKSvmalI9CQLx4MSCyrMbpknstdaZR9cR+lQsijTLGF7ZGvredh
X-Google-Smtp-Source: AGHT+IFq93IgDq2NTS911OxQs3gUelURGw5jEY7f0Yo4F+PheNyBVEsvS4YWtx2x3YVnK1l/6zk8IQ==
X-Received: by 2002:a17:90a:d644:b0:2fe:b9be:216 with SMTP id 98e67ed59e1d1-2ff4981f6e7mr2926770a91.31.1741154111247;
        Tue, 04 Mar 2025 21:55:11 -0800 (PST)
Received: from thinkpad ([120.60.140.239])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff4e81d5d4sm452123a91.40.2025.03.04.21.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 21:55:10 -0800 (PST)
Date: Wed, 5 Mar 2025 11:25:03 +0530
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
Subject: Re: [PATCH v3 3/6] PCI: mediatek: Use helper function
 for_each_available_child_of_node_scoped()
Message-ID: <20250305055503.qbcouvc7zwxesx32@thinkpad>
References: <20240831040413.126417-1-zhangzekun11@huawei.com>
 <20240831040413.126417-4-zhangzekun11@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240831040413.126417-4-zhangzekun11@huawei.com>

On Sat, Aug 31, 2024 at 12:04:10PM +0800, Zhang Zekun wrote:
> for_each_available_child_of_node_scoped() provides a scope-based cleanup
> functionality to put the device_node automatically, and we don't need to
> call of_node_put() directly.  Let's simplify the code a bit with the use
> of these functions.
> 
> Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
> v2:
> - Use dev_err_probe() to simplify code.
> - Fix spelling error in commit message.
> 
>  drivers/pci/controller/pcie-mediatek.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
> index 9be3cebd862e..0457b9d0ad8b 100644
> --- a/drivers/pci/controller/pcie-mediatek.c
> +++ b/drivers/pci/controller/pcie-mediatek.c
> @@ -1042,24 +1042,22 @@ static int mtk_pcie_subsys_powerup(struct mtk_pcie *pcie)
>  static int mtk_pcie_setup(struct mtk_pcie *pcie)
>  {
>  	struct device *dev = pcie->dev;
> -	struct device_node *node = dev->of_node, *child;
> +	struct device_node *node = dev->of_node;
>  	struct mtk_pcie_port *port, *tmp;
>  	int err, slot;
>  
>  	slot = of_get_pci_domain_nr(dev->of_node);
>  	if (slot < 0) {
> -		for_each_available_child_of_node(node, child) {
> +		for_each_available_child_of_node_scoped(node, child) {
>  			err = of_pci_get_devfn(child);
> -			if (err < 0) {
> -				dev_err(dev, "failed to get devfn: %d\n", err);
> -				goto error_put_node;
> -			}
> +			if (err < 0)
> +				return dev_err_probe(dev, err, "failed to get devfn\n");
>  
>  			slot = PCI_SLOT(err);
>  
>  			err = mtk_pcie_parse_port(pcie, child, slot);
>  			if (err)
> -				goto error_put_node;
> +				return err;
>  		}
>  	} else {
>  		err = mtk_pcie_parse_port(pcie, node, slot);
> @@ -1080,9 +1078,6 @@ static int mtk_pcie_setup(struct mtk_pcie *pcie)
>  		mtk_pcie_subsys_powerdown(pcie);
>  
>  	return 0;
> -error_put_node:
> -	of_node_put(child);
> -	return err;
>  }
>  
>  static int mtk_pcie_probe(struct platform_device *pdev)
> -- 
> 2.17.1
> 

-- 
மணிவண்ணன் சதாசிவம்

