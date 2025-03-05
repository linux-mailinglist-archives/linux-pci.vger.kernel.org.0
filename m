Return-Path: <linux-pci+bounces-22940-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 681CEA4F6BC
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 06:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB2523A4B11
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 05:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C84E1C84D2;
	Wed,  5 Mar 2025 05:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JH6Q06A5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627D343AB7
	for <linux-pci@vger.kernel.org>; Wed,  5 Mar 2025 05:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741154220; cv=none; b=ivFknDlYDvjsRhNGx7h0h+vPV+GaAimMXR15Ux2TtM8tGKE6p5amR7dssl6UgPaomS5J2PsGlCK9pEPjJbvmmxtU8ht0XHOWNzukApF6UmMO38uN5yffK/1BXF5nddJFgigPWGAg1gFTKSANX0D0UrCbCf6rbODU3gBRJ5GrT5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741154220; c=relaxed/simple;
	bh=fW/jbIQNXSYYqK/w6NmTym1KiUXx1H3FP7WT6YmNrxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D1+V934vqPiPsduk6bgSsuPoUkTqegtmJe5HPXI7z6I7grMNHS8pNaDB/JsKB+0xVfjucH+4YPmObLzTFLdEjFz3UuCJ3REgfl6B4b6wmGLeR81cImYeikgH1jJ9MKBcRMXUOVsDJg8cW4bJLEgab7uP0gSQaxIZ72Uw+f6egFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JH6Q06A5; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2234daaf269so106037125ad.3
        for <linux-pci@vger.kernel.org>; Tue, 04 Mar 2025 21:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741154218; x=1741759018; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dHA0DOY3hAWEg8KCvRNowrsam0LGHjfqUZhaOer0dx8=;
        b=JH6Q06A5xlVyCSxaGHO5J3paUEm7wmoAewiTtEFX92zs2NqawB460dYnih09NMObYD
         TP9hZiv3cNSYmbS9Iis8U0do3xiGjXeOEPPPd2ECan9Pp9BOb0XkKDlGSpmopXh4ZYQI
         EFKJ7VISJHqYocTWsp9BV3nMwWAcAQlypKCoSttMppBQvRtx1BMlRV40TW/OhuQdiWAr
         svfWY+nw5pG/nh4tiCB/NN3Weyz8BCAKRd+eCtCpRnamkL+VIVd615YkvwqJwEiZx034
         ItZFgr7bJJk3pXv4b24ss4uspzcq8DrWcyzMQxQ4kP0jcv6rl/JnWYIWA7AefvUDQSTu
         WdnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741154218; x=1741759018;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dHA0DOY3hAWEg8KCvRNowrsam0LGHjfqUZhaOer0dx8=;
        b=bLA+q3S+/3KrZbrUzFBvPx671FMaLs7UCnmKOBzf4gEq6BxX9N8zKaJW6p4JSsC90H
         tPkjsvzi4xBlOMIkxqZbloaP+9cEe58FODWMFMmb2yfgTcgWO5IpN/HwPuzo3psRvXLQ
         iA2VE12ewEC6eYDSY46KVRIK3LG56snSOHJrL0LCupMUaklHagGO/JbNezzfDNBBNCAf
         gw8/qh67NZU53MXjb7Dg0jKTeRFdm1efnsSDaQNKSexO3RXZAYDt6/3E8bCDAcU2U/F/
         UfTV0EK490liqCGUouhxuOmiNCxMEeiLoaW7wb/71Kv9ZmwvnWL4ftlp5c4yHRq+rQqB
         4c1Q==
X-Forwarded-Encrypted: i=1; AJvYcCV3GPNo3MFOte1qvdJlTBpLoyHDKRCL/GIYQqzhC6qOgW+FGQ0ZsfIQq33FBvKlyWmILzBNeqGeoTs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK32ddQLtHAuHQY1Kptk5piZwxIBGBu+GQg2n8AyP1PgU8o9Fs
	17YlDM842al/2VHKvAivabjx/AI7ljWx+SvY/xPtqakJgUdCH2JMCQqkn/g6LA==
X-Gm-Gg: ASbGncsHK7Jpx8d0JLtEw9iMihT3x1NlMw7Aycw0qurxumSg9L/uZ01mjy2yIjxfZKG
	vF7A6ZSyl3RJ1R0enN+QQrBb0tanp7vzfXCQOpUwxTbpmq1v3U3uUeq4rybDZoX6qhOVCp/bGKZ
	CATkfflROHYT0dwZ9RWOViGsFvgUBq7vM55uQB/9JpJ79/3mpkXXOOLgWLXrD9zakYF8bBHgUcD
	LDNFp5j40TnI18s/BRBgnwL5oH+SMOLqTyfiMpzkkN+A6Wh/EASg3t1Zwmt7TbYM0rqfJwSkqlH
	oHmVB9BCxIYxrOqVPB2TJkrFr/aZ5O6fd3mWqYIaoWXcoYDuExTfMkkC
X-Google-Smtp-Source: AGHT+IHG45yD79tJ8beGaoE+7dGOgFm5YbZIbczT5s5FglE8ZFnQoBYsfJdjuvCMzBJe+dheJDUpFQ==
X-Received: by 2002:a17:902:e80b:b0:220:c143:90a0 with SMTP id d9443c01a7336-223f1ca4f90mr34270705ad.24.1741154218681;
        Tue, 04 Mar 2025 21:56:58 -0800 (PST)
Received: from thinkpad ([120.60.140.239])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2235050ceb0sm105865155ad.203.2025.03.04.21.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 21:56:58 -0800 (PST)
Date: Wed, 5 Mar 2025 11:26:51 +0530
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
Subject: Re: [PATCH v3 4/6] PCI: mt7621: Use helper function
 for_each_available_child_of_node_scoped()
Message-ID: <20250305055651.ul6k5qaxakpy3b22@thinkpad>
References: <20240831040413.126417-1-zhangzekun11@huawei.com>
 <20240831040413.126417-5-zhangzekun11@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240831040413.126417-5-zhangzekun11@huawei.com>

On Sat, Aug 31, 2024 at 12:04:11PM +0800, Zhang Zekun wrote:
> for_each_available_child_of_node_scoped() provides a scope-based cleanup
> functionality to put the device_node automatically, and we don't need to
> call of_node_put() directly.  Let's simplify the code a bit with the use
> of these functions.
> 
> Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> Reviewed-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
> v3: Fix spelling error in commit message.
> 
> v2: Use dev_perr_probe to simplify code.
> 
>  drivers/pci/controller/pcie-mt7621.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-mt7621.c b/drivers/pci/controller/pcie-mt7621.c
> index 9b4754a45515..354d401428f0 100644
> --- a/drivers/pci/controller/pcie-mt7621.c
> +++ b/drivers/pci/controller/pcie-mt7621.c
> @@ -258,30 +258,25 @@ static int mt7621_pcie_parse_dt(struct mt7621_pcie *pcie)
>  {
>  	struct device *dev = pcie->dev;
>  	struct platform_device *pdev = to_platform_device(dev);
> -	struct device_node *node = dev->of_node, *child;
> +	struct device_node *node = dev->of_node;
>  	int err;
>  
>  	pcie->base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(pcie->base))
>  		return PTR_ERR(pcie->base);
>  
> -	for_each_available_child_of_node(node, child) {
> +	for_each_available_child_of_node_scoped(node, child) {
>  		int slot;
>  
>  		err = of_pci_get_devfn(child);
> -		if (err < 0) {
> -			of_node_put(child);
> -			dev_err(dev, "failed to parse devfn: %d\n", err);
> -			return err;
> -		}
> +		if (err < 0)
> +			return dev_err_probe(dev, err, "failed to parse devfn\n");
>  
>  		slot = PCI_SLOT(err);
>  
>  		err = mt7621_pcie_parse_port(pcie, child, slot);
> -		if (err) {
> -			of_node_put(child);
> +		if (err)
>  			return err;
> -		}
>  	}
>  
>  	return 0;
> -- 
> 2.17.1
> 

-- 
மணிவண்ணன் சதாசிவம்

