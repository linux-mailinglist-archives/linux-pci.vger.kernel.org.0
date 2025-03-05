Return-Path: <linux-pci+bounces-22937-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF047A4F6B2
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 06:49:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0165A188BD16
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 05:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB2E18D65A;
	Wed,  5 Mar 2025 05:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XSmjaEUb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CB119408C
	for <linux-pci@vger.kernel.org>; Wed,  5 Mar 2025 05:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741153765; cv=none; b=c9U9cM5KFR+sZ9b/1InY4DsTWWaYOQAKFB1WG1/FBeuuf7RJAOUIGWNt6ZxG7SCkY31iMybOOxw1LYucVOAIdRZ8BsiBbwmUOGZvbXI2J31NRYcVOKxqq/uNCvuBNenRWe9WsYJhC46rGOSD17Ra13dh4tyoFD5nPoRCrQJBJ0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741153765; c=relaxed/simple;
	bh=XdkaGt5verB2RLlpnNVHxGMAg8I4AivwwrSdYtdiWc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LAdB9ZjILmEdK/XYfBysy7Fmtjhy2x+Jh5jxkSOuwlddRiceR+h6EnSSIwVhIJq2N+QkHsbAbeFdAgBLXiNF5KQ97KSP5A/DxPIvK4sSy5lmXg6oCNRdvo32Q+VHE+26DxXwkPrurBBWHaoEPhEoecoK69AYsUtveTlwCOgZZH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XSmjaEUb; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22374f56453so119559175ad.0
        for <linux-pci@vger.kernel.org>; Tue, 04 Mar 2025 21:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741153763; x=1741758563; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fnHvI2i9VwERHY3Ce4P1n2c99QtG1cl9blWSKXyJzBc=;
        b=XSmjaEUblIo/0g1fO1RYGQ5jBcEhFVhQUOUFmGeDgqk8ex/ihQqjeRPzM6eY8tie5z
         0UkPXyEzxFisrJw+Aqg6ymqXcvROwZA7ZgVbYr1/5DM1FC8UbILVA/ABJRf238wp9KmA
         VHgCMJMrHJaaRaibB0GyQA3b90i8ptQTEcWoZUmMgE6vD/kg+Ge4/MLiZzgUb7PgnnhL
         sf0wxKXuknVRneWAyG09V29OO4j8mdD//9jN5ZBHmnu4efU6mn42q3iX1LoNSB2gBeSY
         JroRe1ENC1Ul2n6drLM3J4uimvvIEVigKz1MIzcf3NF6bIuUOzz94UPE2U8SePYCzeMq
         p8gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741153763; x=1741758563;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fnHvI2i9VwERHY3Ce4P1n2c99QtG1cl9blWSKXyJzBc=;
        b=uQV7vWRKlbFC5R1qLxzpczcIxAJQiF4vVK0EHomG4uGZNydAs/Ktkw5AEu2wIx4gLL
         BtzOJ2dQ3m8FWEbznqFjbfJBbFjXH7XwaI3Zl/2wej49OTIRE2p530tRWsIVIHRK9Rwr
         +Ve9eQWvsUHXz0bGG+Oh5YFlqi4jzRzliFo5g4WNmy65Cf+kjhntck0smLwsmcRioACL
         A+e7p3HZA8Pm/XKnBc8hQWJjUhOiaJNwRnvM1mw/kuV5HMxIiYUwRuAME2CsDhOUj37F
         VTMmQmM9py8pHArZxTezWlcH3RNtSlyOzo0W87+RIxxgteEyKLAdWBuyIEt6eG7w82Uy
         V/iQ==
X-Forwarded-Encrypted: i=1; AJvYcCUs3eEP1tiRkuSDHIbBb1fzWFyokyvy166g8OLk8+wqRgy9SQBlroYT1VgiyEmDWDoymLqS3v3DbbM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLyDV12Dg4B8jJy9uM61QB2LmpD7nDWzv+qzLXFaMHjaVbkF+a
	PJLvnjog5mx8GyQb7qkkpdMaOS5fDEdxAFvHVAuwuUzqdLpdb3/SvMtpC3KmTA==
X-Gm-Gg: ASbGnctLUF9EWQMh219kGuztFjegLQg9ZbREKokNdJaZ3OP6XjzmruEHTC2aNat37RF
	MS3kgJ6/vymlQ8BJP4i+C4ji2sCdKub5u6W6QCvM7+jDvkIIgiEvEjZRWn1V3+lv55PrudCmmvT
	Em5DiD359LYyUDQDpEshuAWfd0w+obGajtasekOz8xM8u9URVieBmX/ThgAYvlG2hEgbBOZKhmR
	RNTNenuDKRSfoSUh43GciH3g03RM2JZJjcQBsXz4EMeB1rz8eKlGN99EpYA8KGS1Tiwr+WFZl1f
	5KHnQQsGBXIBRQkjqlmbsTImIASto7I5ga49jpOqxQh/O4UJZ0Yw3UAB
X-Google-Smtp-Source: AGHT+IHJGMrxC7Nj7WORCYWfmaz8C+Gr8wA+9ahEWEcgzzO8BBxox+YTb6gg9h50STG9f+NGsU61Lg==
X-Received: by 2002:a05:6a21:33a9:b0:1f3:19ec:8228 with SMTP id adf61e73a8af0-1f34945a1dfmr3762293637.6.1741153763462;
        Tue, 04 Mar 2025 21:49:23 -0800 (PST)
Received: from thinkpad ([120.60.140.239])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af226f76437sm6990529a12.10.2025.03.04.21.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 21:49:22 -0800 (PST)
Date: Wed, 5 Mar 2025 11:19:15 +0530
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
Subject: Re: [PATCH v3 1/6] PCI: kirin: Use helper function
 for_each_available_child_of_node_scoped()
Message-ID: <20250305054915.3o4m6zo3ittkmbho@thinkpad>
References: <20240831040413.126417-1-zhangzekun11@huawei.com>
 <20240831040413.126417-2-zhangzekun11@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240831040413.126417-2-zhangzekun11@huawei.com>

On Sat, Aug 31, 2024 at 12:04:08PM +0800, Zhang Zekun wrote:
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
> Fix spelling error in commit message.
> 
>  drivers/pci/controller/dwc/pcie-kirin.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
> index 0a29136491b8..e9bda1746ca5 100644
> --- a/drivers/pci/controller/dwc/pcie-kirin.c
> +++ b/drivers/pci/controller/dwc/pcie-kirin.c
> @@ -452,7 +452,7 @@ static long kirin_pcie_get_resource(struct kirin_pcie *kirin_pcie,
>  				    struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> -	struct device_node *child, *node = dev->of_node;
> +	struct device_node *node = dev->of_node;
>  	void __iomem *apb_base;
>  	int ret;
>  
> @@ -477,17 +477,13 @@ static long kirin_pcie_get_resource(struct kirin_pcie *kirin_pcie,
>  		return ret;
>  
>  	/* Parse OF children */
> -	for_each_available_child_of_node(node, child) {
> +	for_each_available_child_of_node_scoped(node, child) {
>  		ret = kirin_pcie_parse_port(kirin_pcie, pdev, child);
>  		if (ret)
> -			goto put_node;
> +			return ret;
>  	}
>  
>  	return 0;
> -
> -put_node:
> -	of_node_put(child);
> -	return ret;
>  }
>  
>  static void kirin_pcie_sideband_dbi_w_mode(struct kirin_pcie *kirin_pcie,
> -- 
> 2.17.1
> 

-- 
மணிவண்ணன் சதாசிவம்

