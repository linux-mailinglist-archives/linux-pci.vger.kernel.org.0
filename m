Return-Path: <linux-pci+bounces-13233-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DED497A19B
	for <lists+linux-pci@lfdr.de>; Mon, 16 Sep 2024 14:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FDD51C21606
	for <lists+linux-pci@lfdr.de>; Mon, 16 Sep 2024 12:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A475156250;
	Mon, 16 Sep 2024 12:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="cHQxApoQ";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="eLm1vCG0"
X-Original-To: linux-pci@vger.kernel.org
Received: from a7-30.smtp-out.eu-west-1.amazonses.com (a7-30.smtp-out.eu-west-1.amazonses.com [54.240.7.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00751149C57;
	Mon, 16 Sep 2024 12:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.7.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726488510; cv=none; b=fznX599DfgkuN+qWZBVJI52I3J49XHIY5AzwwtjjWHtqDbfDRZWxffoGm2BqW0m/URpq25Zw7spTrHxEx4KmFg/4O4CX07TqkyZYdaYriNNYn6rKwdLcbz8AmHr9qPwbGgJeTLT7tL9D1m1FA4gYGh5m4QauQFeGNdNYun+21Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726488510; c=relaxed/simple;
	bh=GeZRC3FKSHnZDUm77Tw1zAFnloDN+15AGZH8D5IRpc4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N5U/fzUTmddlOVTYBsLSBom6vOs5qWwkdCVbejFLDZgyAhB1J1RLp2P0mpDjOPIPUUWaxumC8g7bp5fDnRf29dfZ3nm1yLYm0cxOYdaKcOj5EO4CNRKLaG1SJJ+sx86oeTIWbSegG+74ad2jKbxHqlSKjLQBhgLnxy7U5v+8yGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=amazonses.collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=cHQxApoQ; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=eLm1vCG0; arc=none smtp.client-ip=54.240.7.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.collabora.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=4232tfv5ebdrjdwkr5zzm7kytdkokgug; d=collabora.com; t=1726488506;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=GeZRC3FKSHnZDUm77Tw1zAFnloDN+15AGZH8D5IRpc4=;
	b=cHQxApoQIGgAvypm4HLanHR64fOyJc8TTRL/xZvPB5pJ15+p1WFW/uFOyFr0eNkX
	W4JvXO1dErqj8Vpl1X6cCv+hFVSXU1lHma0D2Sz4b9LzedzOBROvwlxOyYDZzHmdHL2
	On0/vmDDb/qMfKoLx15bYUX/73ceVqConQiWRigLuCoRGOdVfF7/pIy1dYfyrA3TcQZ
	gv8jp3MThDj9nz/Gy6cshixKHx+aSp+OcJfexV5DkLQGbbRNxyux5gSd06LplvZuLSl
	CuVdOl5gWWiO87Zab9sVVti2XTCoHYpHmzDmoT1cduWnr8KT4GKk8JhJFv8HD2EWSFl
	DxfNsUs08A==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1726488506;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
	bh=GeZRC3FKSHnZDUm77Tw1zAFnloDN+15AGZH8D5IRpc4=;
	b=eLm1vCG0IGgHU4QU4BzURI7bvXhNA8Ab60Ns7Z7/9xHfvUkGO7GND9Oixj3Gu6Yw
	5VcP0yyTYx6bdkCwGOnj/XCAglxCDvYfHou5wkM5V22pzmYAQWhz7N+in2ppI+RnikQ
	W24IuqdhJrMv46pkN65C+J0tw/+1ITvRCee1qT3I=
Message-ID: <01020191fabbefa3-de7a1f68-ce29-4daf-83e4-846e8b80896e-000000@eu-west-1.amazonses.com>
Date: Mon, 16 Sep 2024 12:08:26 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] soc: mediatek: pwrap: Switch to
 devm_clk_bulk_get_all_enabled()
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
 <20240914-clk_bulk_ena_fix-v1-2-ce3537585c06@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240914-clk_bulk_ena_fix-v1-2-ce3537585c06@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Feedback-ID: ::1.eu-west-1.YpP9ZbxnARFfy3Cb5pfsLd/pdsXBCNK0KEM7HforL4k=:AmazonSES
X-SES-Outgoing: 2024.09.16-54.240.7.30

Il 14/09/24 20:04, Cristian Ciocaltea ha scritto:
> The helper devm_clk_bulk_get_all_enable() is partially broken and will
> be dropped since it missed to return the number of clocks stored in the
> clk_bulk_data table referenced by the clks argument.
> 
> Use the newly introduced devm_clk_bulk_get_all_enabled() variant
> instead, which is consistent with devm_clk_bulk_get_all() in terms of
> the returned value:
> 
>   > 0 if one or more clocks have been stored
>   = 0 if there are no clocks
>   < 0 if an error occurred
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   drivers/soc/mediatek/mtk-pmic-wrap.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
> index 9fdc0ef79202..0bcd85826375 100644
> --- a/drivers/soc/mediatek/mtk-pmic-wrap.c
> +++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
> @@ -2518,8 +2518,8 @@ static int pwrap_probe(struct platform_device *pdev)
>   		}
>   	}
>   
> -	ret = devm_clk_bulk_get_all_enable(wrp->dev, &clk);
> -	if (ret)
> +	ret = devm_clk_bulk_get_all_enabled(wrp->dev, &clk);
> +	if (ret < 0)
>   		return dev_err_probe(wrp->dev, ret,
>   				     "failed to get clocks\n");
>   
> 


