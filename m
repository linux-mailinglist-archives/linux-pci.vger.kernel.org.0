Return-Path: <linux-pci+bounces-2400-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0D7833525
	for <lists+linux-pci@lfdr.de>; Sat, 20 Jan 2024 16:03:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A7391F22286
	for <lists+linux-pci@lfdr.de>; Sat, 20 Jan 2024 15:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6566B101D5;
	Sat, 20 Jan 2024 15:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k1oQCuF7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91ACFC0A
	for <linux-pci@vger.kernel.org>; Sat, 20 Jan 2024 15:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705762996; cv=none; b=st3xep6SQWBYqhqP4JuI5326S03o64LmCxSZ1kJeNaih0MD32a+vzoT6J/EtuNsiUGpCM0kH3eeOuvGE6nO68aVpRhwiqGldsyNfXGYeWTiEGATIIcRT8ksIsd3snsUT6nAirqcxBuBEFW2iLi4XuexWD3gpvP4KHZdahuFY0Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705762996; c=relaxed/simple;
	bh=9Nc4TyqG+r5zlvwlDzv/990T6nw9lYMWHgz1H2lzc8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YgijabP0vQY6iU33IHnHDE04KqAM+6bFFc9NJsytsTlEP+z5GSZoeRPyOReYHgGKD/OVjLbQdBdj+UPocGLrjlgzzABv9Gf1Dkp0HdkXbTB4M09Xo8wjsN5LE5whpdLS6sNXJFYRIrLQmEKURNoVcMm8wdCm+/it8BVKUjL+ehw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=k1oQCuF7; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2906bd9f2ebso246420a91.0
        for <linux-pci@vger.kernel.org>; Sat, 20 Jan 2024 07:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705762993; x=1706367793; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aqeZN7shB1TWVe9IvpTxqZEMMVop3gcQDbpsLD1ei1I=;
        b=k1oQCuF7VUbfuyx/cjq3lXh/rPXIKV2bYbv8s004C/K5uVQeIK5hnOSpNqq3MBjzyz
         L/ort3QKMBKNVZzmCJctqOyqwJuP5j0tGJvJaVi5l7IPrS/gDYc5o5/4ETSQbuwwKN/x
         a99rcM02DhOYX/Cf0tJ845v8j1nxMyUlJmhn008oMJVvlRbcEhrHiDeq8afn54PjfLfk
         MSOt+J4yakeBavo9yUPGIeGU+TxjsOJKUVdA7dAb+0rw1oyUp3R05jZBmNtvznnJpjpU
         q/LMhF7eNqaPJASUVRUFT16BYxPz+F7JzE6WV1OWnV20vQcNgdnljDiIfzonK21W2YuS
         waXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705762993; x=1706367793;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aqeZN7shB1TWVe9IvpTxqZEMMVop3gcQDbpsLD1ei1I=;
        b=gkvEVWUJo6Tk2QZEJ7JNc/Qe5TXn1V2dzO9gsyNjWx6eKzrjsSZYsThIgFCl+LphPq
         VjNPlnhfCK65LREVWUYgFM0t/5WX5DOsrkGOe7/EaLkFIGb6sa0miAmR7HrtAEBlKwL9
         NA4GpRMQAywIdw6C9tzNLDHW7H7wV6OAb+5GEmUdStnr1gwRIRCx4+RdOK0Om7CRS7n5
         m7R3Hw2xxcm7c61rZ1rvRg+Zkvj07mpaNTizL3rgBZgKW2GL98u7PL928MicDyPflTdL
         u3oZKyWvYZAJ5ClSSW+wNMPV9IIaZbkSmHxonqg67xAMHCtWpxfyr23Qss36Cqn5vrcd
         M1qA==
X-Gm-Message-State: AOJu0Yx0vc9PWEUaB5iIbQMZxBYRVo+soF4BETzg6dp7b683mmxJ5yYW
	75blqiO5ZQrwx2xhmu4KMhdAfS/6FCptj/9lfg72Bkn2nkPGuAS4ymi6mKYAUw==
X-Google-Smtp-Source: AGHT+IF9elycQzObJiXmLQq+7kgsfP/837fqR12nEVd9AChjMfbf9gdfFJ76v0f/vydjEopzP9fHtQ==
X-Received: by 2002:a17:90a:c001:b0:28e:8e78:8ba6 with SMTP id p1-20020a17090ac00100b0028e8e788ba6mr1979052pjt.43.1705762992906;
        Sat, 20 Jan 2024 07:03:12 -0800 (PST)
Received: from thinkpad ([117.202.189.10])
        by smtp.gmail.com with ESMTPSA id sl7-20020a17090b2e0700b0028b6759d8c1sm6219778pjb.29.2024.01.20.07.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jan 2024 07:03:12 -0800 (PST)
Date: Sat, 20 Jan 2024 20:33:03 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Shradha Todi <shradha.t@samsung.com>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, mturquette@baylibre.com,
	sboyd@kernel.org, jingoohan1@gmail.com, lpieralisi@kernel.org,
	kw@linux.com, robh@kernel.org, bhelgaas@google.com,
	krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com,
	linux@armlinux.org.uk, m.szyprowski@samsung.com
Subject: Re: [PATCH v3 1/2] clk: Provide managed helper to get and enable
 bulk clocks
Message-ID: <20240120150303.GB5405@thinkpad>
References: <20240110110115.56270-1-shradha.t@samsung.com>
 <CGME20240110110156epcas5p36bac4093be0fa6eaa501d7eaed4d43d3@epcas5p3.samsung.com>
 <20240110110115.56270-2-shradha.t@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240110110115.56270-2-shradha.t@samsung.com>

On Wed, Jan 10, 2024 at 04:31:14PM +0530, Shradha Todi wrote:
> Provide a managed devm_clk_bulk* wrapper to get and enable all
> bulk clocks in order to simplify drivers that keeps all clocks
> enabled for the time of driver operation.
> 
> Suggested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Shradha Todi <shradha.t@samsung.com>
> ---
>  drivers/clk/clk-devres.c | 41 ++++++++++++++++++++++++++++++++++++++++
>  include/linux/clk.h      | 25 ++++++++++++++++++++++++
>  2 files changed, 66 insertions(+)
> 
> diff --git a/drivers/clk/clk-devres.c b/drivers/clk/clk-devres.c
> index 4fb4fd4b06bd..05b0ff4bc1d4 100644
> --- a/drivers/clk/clk-devres.c
> +++ b/drivers/clk/clk-devres.c
> @@ -102,6 +102,7 @@ EXPORT_SYMBOL_GPL(devm_clk_get_optional_enabled);
>  struct clk_bulk_devres {
>  	struct clk_bulk_data *clks;
>  	int num_clks;
> +	void (*exit)(int num_clks, const struct clk_bulk_data *clks);
>  };
>  
>  static void devm_clk_bulk_release(struct device *dev, void *res)
> @@ -182,6 +183,46 @@ int __must_check devm_clk_bulk_get_all(struct device *dev,
>  }
>  EXPORT_SYMBOL_GPL(devm_clk_bulk_get_all);
>  
> +static void devm_clk_bulk_release_all_enabled(struct device *dev, void *res)
> +{
> +	struct clk_bulk_devres *devres = res;
> +
> +	if (devres->exit)
> +		devres->exit(devres->num_clks, devres->clks);
> +
> +	clk_bulk_put_all(devres->num_clks, devres->clks);
> +}
> +
> +int __must_check devm_clk_bulk_get_all_enabled(struct device *dev,
> +				  struct clk_bulk_data **clks, int *num_clks)

What is the user supposed to do with "num_clks" when you are already handling
the enable part?

> +{
> +	struct clk_bulk_devres *devres;
> +	int ret;
> +
> +	devres = devres_alloc(devm_clk_bulk_release_all_enabled,
> +			      sizeof(*devres), GFP_KERNEL);
> +	if (!devres)
> +		return -ENOMEM;
> +
> +	ret = clk_bulk_get_all(dev, &devres->clks);
> +	if (ret > 0) {
> +		*clks = devres->clks;
> +		devres->num_clks = ret;
> +		*num_clks = ret;
> +		devres_add(dev, devres);

If you move the statements inside this condition to the end of this function,
you could get rid of the exit() callback and directly use
clk_bulk_disable_unprepare() in devm_clk_bulk_release_all_enabled().

> +	} else {
> +		devres_free(devres);
> +		return ret;
> +	}
> +
> +	ret = clk_bulk_prepare_enable(devres->num_clks, *clks);
> +	if (!ret)
> +		devres->exit = clk_bulk_disable_unprepare;

Here you can just do clk_bulk_put_all() and devres_free() directly because you
know that the driver won't proceed after this error.

- Mani

> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(devm_clk_bulk_get_all_enabled);
> +
>  static int devm_clk_match(struct device *dev, void *res, void *data)
>  {
>  	struct clk **c = res;
> diff --git a/include/linux/clk.h b/include/linux/clk.h
> index 1ef013324237..bf3e9bee5754 100644
> --- a/include/linux/clk.h
> +++ b/include/linux/clk.h
> @@ -438,6 +438,24 @@ int __must_check devm_clk_bulk_get_optional(struct device *dev, int num_clks,
>  int __must_check devm_clk_bulk_get_all(struct device *dev,
>  				       struct clk_bulk_data **clks);
>  
> +/**
> + * devm_clk_bulk_get_all_enabled - managed get multiple clk consumers and
> + *					enable all clk
> + * @dev: device for clock "consumer"
> + * @clks: pointer to the clk_bulk_data table of consumer
> + * @num_clks: out parameter to store the number of clk_bulk_data
> + *
> + * Returns success (0) or negative errno.
> + *
> + * This helper function allows drivers to get several clk
> + * consumers and enable all of them in one operation with management.
> + * The clks will automatically be disabled and freed when the device
> + * is unbound.
> + */
> +
> +int __must_check devm_clk_bulk_get_all_enabled(struct device *dev,
> +				struct clk_bulk_data **clks, int *num_clks);
> +
>  /**
>   * devm_clk_get - lookup and obtain a managed reference to a clock producer.
>   * @dev: device for clock "consumer"
> @@ -960,6 +978,13 @@ static inline int __must_check devm_clk_bulk_get_all(struct device *dev,
>  	return 0;
>  }
>  
> +static inline int __must_check devm_clk_bulk_get_all_enabled(struct device *dev,
> +				struct clk_bulk_data **clks, int *num_clks)
> +{
> +
> +	return 0;
> +}
> +
>  static inline struct clk *devm_get_clk_from_child(struct device *dev,
>  				struct device_node *np, const char *con_id)
>  {
> -- 
> 2.17.1
> 

-- 
மணிவண்ணன் சதாசிவம்

