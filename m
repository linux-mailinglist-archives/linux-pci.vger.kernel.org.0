Return-Path: <linux-pci+bounces-4505-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 292E0871895
	for <lists+linux-pci@lfdr.de>; Tue,  5 Mar 2024 09:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE239B21EBF
	for <lists+linux-pci@lfdr.de>; Tue,  5 Mar 2024 08:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8977C4F1F5;
	Tue,  5 Mar 2024 08:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wgB85y0s"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF8C1EF1A
	for <linux-pci@vger.kernel.org>; Tue,  5 Mar 2024 08:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709628637; cv=none; b=Ikjv6o4Czugj70FYsyJ1SwZyWd3mXLcLnlMURZ15Nxd3zB69p8YYBiQnWdj7ejqh+YhMmTJmD7dUTVyoIARLx4oISv/EbkL/H65X8xSusZKWGeSH/iixDHMcTkMTyQh/jHgDcKrntsXMNtpYL9LvJhzgS1tR8E33a+nSthDh8+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709628637; c=relaxed/simple;
	bh=/qaRgOCPIEFkrZRFeRFcZiqUAPgGaXs8wvM/tEPQzCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lhEQl6L5RZupsndSofzGmfTWtFeXQVjW4x0wn0SGkpVhffpHgqoPYi6ie1RxCGvnOBiiOmhj6fGltHTv2SMo4ayzEiTR0gUCPsrdO39z1yAftrBgSJmK4mAAt4XcvZXumFUh1nD1GRfoc4cBb8dvppcs6bj4FxtBvT9jOZ//QMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wgB85y0s; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a3f893ad5f4so800376866b.2
        for <linux-pci@vger.kernel.org>; Tue, 05 Mar 2024 00:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709628634; x=1710233434; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jT7ZsmNph1HICQhGYk/X5PZRUWWUGk3/PHQvVwvJTOo=;
        b=wgB85y0s6rf4i2vIzrgObujA09hgoBt7adI9IZOTwi6FrRA3PMf5vJ1An2UTkwImsU
         Py6ZjRaJJnJebSDWj3EmZq9+uUAp1+cMTmlyYOCzD5bhdAPTdZpX52Y0BKKIBVD35571
         bOs0aK7sVzcqTsaFRjYipop4g9HDrbo098GQ5TpomE6nI1oHeU6GtT6O3lSrcP0/KAdi
         Ptd3+vHAqD/wd2kngPt9owa7iEyo/yazTT7OnHd8qkKwUrOY7MgIbGdngUs9Lcbaqr40
         PjzUYwxQ1o6T3NfcqPUkMRM5Iwj+bfb621d0+/sLHgbHnVFSgvDRa1PpZ9v51iX9nqt8
         ATrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709628634; x=1710233434;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jT7ZsmNph1HICQhGYk/X5PZRUWWUGk3/PHQvVwvJTOo=;
        b=VNxI/zaKyd4VofJREwVTYcpKjzEi3hL7xmU854rgsfMIlgnVqwnoSSclA+DkcNnjZk
         AZB/6WKm2ocI+H3sQznXmCrZ2lEl67njQJxKGShSyp6FawYov5bnTgJ+uGRzBUAfWAKB
         xEBIdvAXyhEaRPmqaf3Bj+K/fQ84TfoYXtA9wmmELL9mJnxEPS6sji87KWTAu3eNN4T8
         V6APefnQFgrLrwKOpw9WixNL4bdNsFDBqmEISZLvX7cvgSCFTLo5Ha9j1cLwxk/dSTpZ
         CIGZBWtaOl0l93ifPt2B8xBqFLfiiOcz+FnDgC1avqNBlVmNW3zJKLASipawTPES6+iJ
         RzUQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4M8SlZrtLw47WIJ0jwLuyzNE8cu5Ul+ZO7H9VeercA5P8pJpfpboB+w9fiKIRjL7Si/4VKsvzfX6l+fH+C0mo7GY17og0eiyO
X-Gm-Message-State: AOJu0Yzk9odoS5lZ6zJJRMDjVZJN7wYqsNjJxg0QwQIQaj7MkXzspvLj
	+FbWtnS4n6/fvBRpfXHnClYbAintLz7ovK3QkC8k529M5U/2zyunNoUPGaL9g3E=
X-Google-Smtp-Source: AGHT+IHJS+2LhiDD7zxJqHM589abVoaxutSaB3e9mIWp3cLj6gDlecOCLPFEcxg3I6gVnMuHzHEJSQ==
X-Received: by 2002:a17:906:c06:b0:a44:1978:c73f with SMTP id s6-20020a1709060c0600b00a441978c73fmr7660917ejf.61.1709628633846;
        Tue, 05 Mar 2024 00:50:33 -0800 (PST)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id ef5-20020a17090697c500b00a449cb924dbsm4457506ejb.124.2024.03.05.00.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 00:50:33 -0800 (PST)
Date: Tue, 5 Mar 2024 11:50:29 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Shradha Todi <shradha.t@samsung.com>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, mturquette@baylibre.com,
	sboyd@kernel.org, jingoohan1@gmail.com, lpieralisi@kernel.org,
	kw@linux.com, robh@kernel.org, bhelgaas@google.com,
	krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com,
	linux@armlinux.org.uk, m.szyprowski@samsung.com,
	manivannan.sadhasivam@linaro.org, pankaj.dubey@samsung.com,
	gost.dev@samsung.com
Subject: Re: [PATCH v6 1/2] clk: Provide managed helper to get and enable
 bulk clocks
Message-ID: <f00eed31-4baf-4d5c-934d-8223d1ab554d@moroto.mountain>
References: <20240220084046.23786-1-shradha.t@samsung.com>
 <CGME20240220084120epcas5p1e8980539667c3d9da20f49fc645d8f4c@epcas5p1.samsung.com>
 <20240220084046.23786-2-shradha.t@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220084046.23786-2-shradha.t@samsung.com>

On Tue, Feb 20, 2024 at 02:10:45PM +0530, Shradha Todi wrote:
> +int __must_check devm_clk_bulk_get_all_enable(struct device *dev,
> +					      struct clk_bulk_data **clks)
> +{
> +	struct clk_bulk_devres *devres;
> +	int ret;
> +
> +	devres = devres_alloc(devm_clk_bulk_release_all_enable,
> +			      sizeof(*devres), GFP_KERNEL);
> +	if (!devres)
> +		return -ENOMEM;
> +
> +	ret = clk_bulk_get_all(dev, &devres->clks);
> +	if (ret > 0) {

I feel like this should be >= instead of >.  There aren't any callers
of this function yet so we can't see what's in *clks at the start but
it's easy to imagine a situation where it's bad data.

> +		*clks = devres->clks;
> +		devres->num_clks = ret;
> +	} else {
> +		devres_free(devres);
> +		return ret;

When clk_bulk_get_all() returns zero then we return success here.

regards,
dan carpenter

> +	}
> +
> +	ret = clk_bulk_prepare_enable(devres->num_clks, *clks);
> +	if (!ret) {
> +		devres_add(dev, devres);
> +	} else {
> +		clk_bulk_put_all(devres->num_clks, devres->clks);
> +		devres_free(devres);
> +	}
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(devm_clk_bulk_get_all_enable);
> +


