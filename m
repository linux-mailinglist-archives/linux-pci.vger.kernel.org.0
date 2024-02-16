Return-Path: <linux-pci+bounces-3591-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66CA1857BBD
	for <lists+linux-pci@lfdr.de>; Fri, 16 Feb 2024 12:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D47AB1F26099
	for <lists+linux-pci@lfdr.de>; Fri, 16 Feb 2024 11:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF80977F19;
	Fri, 16 Feb 2024 11:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K5Lv258E"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5358D77A0F
	for <linux-pci@vger.kernel.org>; Fri, 16 Feb 2024 11:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708083116; cv=none; b=N4OgZENWnNdd1Ep6xcWCkzmP0oVjsCC3JR3nULqwVxiyB4ChNIp7oly0pH11FMd7iB0brQ6hUNNkfgPqZFFIcp7Y9Czr7Ho7I8k9rroapjLfjaDT46t19mk45DqxZLv8m+U1tvX/Im8OUVuuMwUJuNueATbpT2KGMgfU3nBDKHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708083116; c=relaxed/simple;
	bh=UwV6PP9Dy4l/PHEko/rhazRk7bZ5pWgavF2GNsY4jB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qtb+FSAb42szd+c3zbs7GY00u1/pjnpfhsVGkuSPmAOtta4DuJ64o0Q5RLiZxf7Um66jcttwN0UfwEhdnMpYGBq1Dup3SKcfvhf9tTKaKMmIU+kVBRltseCZcOyyp2HVY9FGlhXSe+LBnytCONDtwbvzpKtdN4ySdgxqiKtNDSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K5Lv258E; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d911c2103aso12470615ad.0
        for <linux-pci@vger.kernel.org>; Fri, 16 Feb 2024 03:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708083114; x=1708687914; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yTLg2p9rvSPRXvNKR+Iv16WduzUd8WzxwmsQxSSHbjw=;
        b=K5Lv258EC7/0q9VDM7mhlj/jvCDy4xaOetbe37QlFvlSvzrmEK/llqd0ztiRn5LJ3p
         j2AMzYvUL7IYFASyPJqKPJhondmmaW4G9T2s1i+URB5EcaqOVV2wfRaGd8R+Mqf1S6MX
         jVA0wx2Gv/4milh3bC9wHZ6TjFkhAd0WvhOoBQdVPz0OQ7EgsFLlOzqchjk1VZF+K+8V
         Jo9yduEPMLBW9TL9/xprWd8uwTilLwALuOqmA/8zU9FwPstdohqSx1aJfxLbjWnkpyk4
         FREpG5Fv/4B/XpbP3+pmjjRIIdbAuQMmNdjQ0koQ3e0R5edm8WbP/bDDjmjcVuUcRD8W
         lRgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708083114; x=1708687914;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yTLg2p9rvSPRXvNKR+Iv16WduzUd8WzxwmsQxSSHbjw=;
        b=o5U0hKk3iMFEQP5GuOCIczH33sM+UDa5dkGT4Epa8hHRO4ikpW8LVOSDwXKMja5SAZ
         5hciiPysq8CWsrGtDzNnpcX98ftwYvjykBST60+40FxZGwn0SE69Sxg9GbUUTvNfdHYu
         ttMOFQXYjvJoXjnTzvAQHO8UT4c+LLTo/+E6CCdWe8kS+txpK0hXunXsdfVliAIPBmW8
         bh/ME+i0Y7ohIwMnE2inPGlbnIWEgHiJYvOQBi9R6Zt0HecB3uMw3run08SPPr5QLUPL
         Ww5oC2SNwOcCKj3spvFLcicrVrSt+K0yCvY7HfN6GN+9TBxQWRX36f3xNf8Q7Eu1QB3n
         4mJA==
X-Forwarded-Encrypted: i=1; AJvYcCWdIHUXuvkBtiPsBt6I8QiVmNaOXEE9/lXQg4HY5oNMHqxYYo9bpgFxkDL2ujaMjg9Hyx0qZFjPxkExHLQagJqwhyAXbalJvrRh
X-Gm-Message-State: AOJu0Yz4GKHCls7LeGRr3Qp0+YARmS8L+/1L3TH1v13ZDH+goMIXXEtz
	Oa2s0ni0a2Okp9Oo0EY0mtygjMGbHTonJmTxKcZ9CEL3C2lBfAKC42JvlG7DIA==
X-Google-Smtp-Source: AGHT+IGSaTOg2dt+FTkxvX5Wl5p6EaLyGySJFive4sWTF+xzn0NGHSw3oNW6LvNQq58PkNw1txprjQ==
X-Received: by 2002:a17:902:e84e:b0:1da:2a3e:4c62 with SMTP id t14-20020a170902e84e00b001da2a3e4c62mr6071696plg.14.1708083114435;
        Fri, 16 Feb 2024 03:31:54 -0800 (PST)
Received: from thinkpad ([120.138.12.48])
        by smtp.gmail.com with ESMTPSA id r10-20020a170902c60a00b001db817b956bsm2811849plr.259.2024.02.16.03.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 03:31:54 -0800 (PST)
Date: Fri, 16 Feb 2024 17:01:47 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Shradha Todi <shradha.t@samsung.com>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, mturquette@baylibre.com,
	sboyd@kernel.org, jingoohan1@gmail.com, lpieralisi@kernel.org,
	kw@linux.com, robh@kernel.org, bhelgaas@google.com,
	krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com,
	linux@armlinux.org.uk, m.szyprowski@samsung.com,
	pankaj.dubey@samsung.com, gost.dev@samsung.com
Subject: Re: [PATCH v5 1/2] clk: Provide managed helper to get and enable
 bulk clocks
Message-ID: <20240216113147.GF2559@thinkpad>
References: <20240213132751.46813-1-shradha.t@samsung.com>
 <CGME20240213132806epcas5p43e394aea91c61797a8cc3a901e0cf574@epcas5p4.samsung.com>
 <20240213132751.46813-2-shradha.t@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240213132751.46813-2-shradha.t@samsung.com>

On Tue, Feb 13, 2024 at 06:57:50PM +0530, Shradha Todi wrote:
> Provide a managed devm_clk_bulk* wrapper to get and enable all
> bulk clocks in order to simplify drivers that keeps all clocks
> enabled for the time of driver operation.
> 
> Suggested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>
> Signed-off-by: Shradha Todi <shradha.t@samsung.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/clk/clk-devres.c | 40 ++++++++++++++++++++++++++++++++++++++++
>  include/linux/clk.h      | 23 +++++++++++++++++++++++
>  2 files changed, 63 insertions(+)
> 
> diff --git a/drivers/clk/clk-devres.c b/drivers/clk/clk-devres.c
> index 4fb4fd4b06bd..cbbd2cc339c3 100644
> --- a/drivers/clk/clk-devres.c
> +++ b/drivers/clk/clk-devres.c
> @@ -182,6 +182,46 @@ int __must_check devm_clk_bulk_get_all(struct device *dev,
>  }
>  EXPORT_SYMBOL_GPL(devm_clk_bulk_get_all);
>  
> +static void devm_clk_bulk_release_all_enable(struct device *dev, void *res)
> +{
> +	struct clk_bulk_devres *devres = res;
> +
> +	clk_bulk_disable_unprepare(devres->num_clks, devres->clks);
> +	clk_bulk_put_all(devres->num_clks, devres->clks);
> +}
> +
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
> +		*clks = devres->clks;
> +		devres->num_clks = ret;
> +	} else {
> +		devres_free(devres);
> +		return ret;
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
>  static int devm_clk_match(struct device *dev, void *res, void *data)
>  {
>  	struct clk **c = res;
> diff --git a/include/linux/clk.h b/include/linux/clk.h
> index 1ef013324237..85a9330d5a5a 100644
> --- a/include/linux/clk.h
> +++ b/include/linux/clk.h
> @@ -438,6 +438,22 @@ int __must_check devm_clk_bulk_get_optional(struct device *dev, int num_clks,
>  int __must_check devm_clk_bulk_get_all(struct device *dev,
>  				       struct clk_bulk_data **clks);
>  
> +/**
> + * devm_clk_bulk_get_all_enable - Get and enable all clocks of the consumer (managed)
> + * @dev: device for clock "consumer"
> + * @clks: pointer to the clk_bulk_data table of consumer
> + *
> + * Returns success (0) or negative errno.
> + *
> + * This helper function allows drivers to get all clocks of the
> + * consumer and enables them in one operation with management.
> + * The clks will automatically be disabled and freed when the device
> + * is unbound.
> + */
> +
> +int __must_check devm_clk_bulk_get_all_enable(struct device *dev,
> +					      struct clk_bulk_data **clks);
> +
>  /**
>   * devm_clk_get - lookup and obtain a managed reference to a clock producer.
>   * @dev: device for clock "consumer"
> @@ -960,6 +976,13 @@ static inline int __must_check devm_clk_bulk_get_all(struct device *dev,
>  	return 0;
>  }
>  
> +static inline int __must_check devm_clk_bulk_get_all_enable(struct device *dev,
> +						struct clk_bulk_data **clks)
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

