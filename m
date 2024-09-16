Return-Path: <linux-pci+bounces-13232-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22DED97A196
	for <lists+linux-pci@lfdr.de>; Mon, 16 Sep 2024 14:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF2032880BE
	for <lists+linux-pci@lfdr.de>; Mon, 16 Sep 2024 12:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F31155352;
	Mon, 16 Sep 2024 12:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="BiCCPcW7";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="D0+zkQ9J"
X-Original-To: linux-pci@vger.kernel.org
Received: from a7-29.smtp-out.eu-west-1.amazonses.com (a7-29.smtp-out.eu-west-1.amazonses.com [54.240.7.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92001155300;
	Mon, 16 Sep 2024 12:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.7.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726488508; cv=none; b=moyQoJPOET2ic1I+i7s+huV9r+S+OZ03ceAsV0/KBysMYuh8zRquoWD63kzJ3HoenejFJ7vAyuKB5URDIi9NKaOhhO+a0JeBoLaahrz6aUWSd3D3QSOnqzRFnRizaBFQcw0vmWPlwxUysAflQqLV4D6YtLc2vQUDJgvSIIf/P7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726488508; c=relaxed/simple;
	bh=VW9wIzceX735i9yX1DBCBq4IDNjS/8cghksJ8RpmIAs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hrjMy7t4GfSYm5RKOfywTzM702qejHpQJQu6O9b0W65wBGaMv23l0Z6JNc8sWjF3QdZ7MnYX+IJN8neRxEvSIA/JS3VYjwL6otxjA+JvD+Dw2i2VzXwBIxI8FcTWznUA6UbvsBqd4SaQZd9yiuXVdICYQPjaxqnm7HYUC1fi23Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=amazonses.collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=BiCCPcW7; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=D0+zkQ9J; arc=none smtp.client-ip=54.240.7.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.collabora.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=4232tfv5ebdrjdwkr5zzm7kytdkokgug; d=collabora.com; t=1726488505;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=VW9wIzceX735i9yX1DBCBq4IDNjS/8cghksJ8RpmIAs=;
	b=BiCCPcW7FpAQ9cCduF+vD7iu7ISsJXjdWA445Ch7452VshuCOIpIApAaQy8cMBIC
	pXQUxV2vp3KZ+5kmYJYUUFnfdLWh5LvY/RyeDpEPhxao8hrpMvSGkBCWk2Qsc7F8d+g
	WPK3OkXvJcs4UwIPEjtqeegvzC2CnBo5L4D5K55UmdNcOhiC9pDzhD5g4b782q+C5au
	dqEXBSdiRQvA8wEBfBF9O+eoUmIktQvEC2mzW+wVHh20IEa3gjLBs5K4LUisms3hvOD
	3nW0Nh/ImCNiacG+A1CbN6F3q665uf+IGFGxoDKtvYyZ9CZRvTdCSo5kZC0omIMUT9n
	oa2kbvt3OQ==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1726488505;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
	bh=VW9wIzceX735i9yX1DBCBq4IDNjS/8cghksJ8RpmIAs=;
	b=D0+zkQ9JwNw3ps90exTefnChDf6Q6MI3liaa3ZfKUbaUdywcVt1KjhlXOEPgnZL/
	V5uPjAWBrBl45bxrM5a8nPqyOqKkGVGVJvY5QC0VOm5YxPHqO9zqhPHx2qt9TPiQUwP
	BLsDok/7f9aroB4ixEojZ1d2d31QKY//z8BRcnjE=
Message-ID: <01020191fabbea05-14368d2a-b504-4fad-b1a1-48435821d7f1-000000@eu-west-1.amazonses.com>
Date: Mon, 16 Sep 2024 12:08:24 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] clk: Drop obsolete devm_clk_bulk_get_all_enable()
 helper
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, 
	Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	Jingoo Han <jingoohan1@gmail.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>
Cc: kernel@collabora.com, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, linux-pci@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org
References: <20240914-clk_bulk_ena_fix-v1-0-ce3537585c06@collabora.com>
 <20240914-clk_bulk_ena_fix-v1-4-ce3537585c06@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240914-clk_bulk_ena_fix-v1-4-ce3537585c06@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Feedback-ID: ::1.eu-west-1.YpP9ZbxnARFfy3Cb5pfsLd/pdsXBCNK0KEM7HforL4k=:AmazonSES
X-SES-Outgoing: 2024.09.16-54.240.7.29

Il 14/09/24 20:04, Cristian Ciocaltea ha scritto:
> Commit 265b07df758a ("clk: Provide managed helper to get and enable bulk
> clocks") added devm_clk_bulk_get_all_enable() function, but missed to
> return the number of clocks stored in the clk_bulk_data table referenced
> by the clks argument.  Without knowing the number, it's not possible to
> iterate these clocks when needed, hence the argument is useless and
> could have been simply removed.
> 
> A new helper devm_clk_bulk_get_all_enabled() has been introduced, which
> is consistent with devm_clk_bulk_get_all() in terms of the returned
> value.
> 
> Drop the obsolete function since all users switched to the new helper.
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

This should probably be done in two (three?) cycles if we want to avoid
immutable branches... but anyway, for the commit itself:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   drivers/clk/clk-devres.c | 32 --------------------------------
>   include/linux/clk.h      | 22 ----------------------
>   2 files changed, 54 deletions(-)
> 
> diff --git a/drivers/clk/clk-devres.c b/drivers/clk/clk-devres.c
> index 4203aaaa7544..14a657f336fe 100644
> --- a/drivers/clk/clk-devres.c
> +++ b/drivers/clk/clk-devres.c
> @@ -218,38 +218,6 @@ static void devm_clk_bulk_release_all_enable(struct device *dev, void *res)
>   	clk_bulk_put_all(devres->num_clks, devres->clks);
>   }
>   
> -int __must_check devm_clk_bulk_get_all_enable(struct device *dev,
> -					      struct clk_bulk_data **clks)
> -{
> -	struct clk_bulk_devres *devres;
> -	int ret;
> -
> -	devres = devres_alloc(devm_clk_bulk_release_all_enable,
> -			      sizeof(*devres), GFP_KERNEL);
> -	if (!devres)
> -		return -ENOMEM;
> -
> -	ret = clk_bulk_get_all(dev, &devres->clks);
> -	if (ret > 0) {
> -		*clks = devres->clks;
> -		devres->num_clks = ret;
> -	} else {
> -		devres_free(devres);
> -		return ret;
> -	}
> -
> -	ret = clk_bulk_prepare_enable(devres->num_clks, *clks);
> -	if (!ret) {
> -		devres_add(dev, devres);
> -	} else {
> -		clk_bulk_put_all(devres->num_clks, devres->clks);
> -		devres_free(devres);
> -	}
> -
> -	return ret;
> -}
> -EXPORT_SYMBOL_GPL(devm_clk_bulk_get_all_enable);
> -
>   int __must_check devm_clk_bulk_get_all_enabled(struct device *dev,
>   					       struct clk_bulk_data **clks)
>   {
> diff --git a/include/linux/clk.h b/include/linux/clk.h
> index 158c5072852e..b607482ca77e 100644
> --- a/include/linux/clk.h
> +++ b/include/linux/clk.h
> @@ -495,22 +495,6 @@ int __must_check devm_clk_bulk_get_optional(struct device *dev, int num_clks,
>   int __must_check devm_clk_bulk_get_all(struct device *dev,
>   				       struct clk_bulk_data **clks);
>   
> -/**
> - * devm_clk_bulk_get_all_enable - Get and enable all clocks of the consumer (managed)
> - * @dev: device for clock "consumer"
> - * @clks: pointer to the clk_bulk_data table of consumer
> - *
> - * Returns success (0) or negative errno.
> - *
> - * This helper function allows drivers to get all clocks of the
> - * consumer and enables them in one operation with management.
> - * The clks will automatically be disabled and freed when the device
> - * is unbound.
> - */
> -
> -int __must_check devm_clk_bulk_get_all_enable(struct device *dev,
> -					      struct clk_bulk_data **clks);
> -
>   /**
>    * devm_clk_bulk_get_all_enabled - Get and enable all clocks of the consumer (managed)
>    * @dev: device for clock "consumer"
> @@ -1052,12 +1036,6 @@ static inline int __must_check devm_clk_bulk_get_all(struct device *dev,
>   	return 0;
>   }
>   
> -static inline int __must_check devm_clk_bulk_get_all_enable(struct device *dev,
> -						struct clk_bulk_data **clks)
> -{
> -	return 0;
> -}
> -
>   static inline int __must_check devm_clk_bulk_get_all_enabled(struct device *dev,
>   						struct clk_bulk_data **clks)
>   {

