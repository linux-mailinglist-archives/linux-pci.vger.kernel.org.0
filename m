Return-Path: <linux-pci+bounces-13234-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E0797A1A0
	for <lists+linux-pci@lfdr.de>; Mon, 16 Sep 2024 14:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CC4D281DBC
	for <lists+linux-pci@lfdr.de>; Mon, 16 Sep 2024 12:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E092155336;
	Mon, 16 Sep 2024 12:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Zvt4VME9";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="kNn3ntPk"
X-Original-To: linux-pci@vger.kernel.org
Received: from a7-28.smtp-out.eu-west-1.amazonses.com (a7-28.smtp-out.eu-west-1.amazonses.com [54.240.7.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D21157476;
	Mon, 16 Sep 2024 12:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.7.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726488515; cv=none; b=fQa0ppc6kfWMrYlmKMup04K5xDWBMqFYxbKIn2naUPiQl/VIbKOUfcYIGQqJ/c4lIvv0yY9o9+jvmh4c4FlmKg3dFchP9tKOTsHj9BOeybzojrixYZQkclRv0rChJ7PxLWIixFHR4YIViNk390+5zjcXfowiP5XmROw/MBYNJfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726488515; c=relaxed/simple;
	bh=OooH+41iO90Tusfnqtf1TfTh4krJ+CGZLGsHn5PLQVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jYw2mUZfM7koftxRKyvoDCXWQLGs3JS8YSC8MOzD+2RTsy29Mm0UA8XgQNmkuFEvZGhL9CJbsmlNjUjFN3cNcKkJyNX/VBi+4A0mxLore4Zkn0Uy7qlE95uBtWz0sznXK2W6aNr0nvlAuVBJfVrnKp8KIRZs3vUh22JvcEs6+wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=amazonses.collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Zvt4VME9; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=kNn3ntPk; arc=none smtp.client-ip=54.240.7.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.collabora.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=4232tfv5ebdrjdwkr5zzm7kytdkokgug; d=collabora.com; t=1726488511;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=OooH+41iO90Tusfnqtf1TfTh4krJ+CGZLGsHn5PLQVU=;
	b=Zvt4VME9/g8VE8VKeVXka5X20vim6vdxt3oztuzlpSFQkXdJ5z6XHupvPicLKhCb
	KG2wqpaCFyMzMjOd1IZRAlzW5KKlM//rvNUaAuv1xWW/tq99VgWICsscZuNdCqPHHtn
	l0vZOD7HNHXFVMBOJ+Y13WWaSbkvBoWMgiksoCyyAej5iz9TX3F/vCRf++To3P3VVS2
	xrWfT14bSx6j/gv8BYOyWaenhtg1j2ALkeE02RKhE/WkjPQjF907Do2NY5ld5ILOOS5
	z38WmYPsyZrbDkN1dzF63vVGE1kFe5BeKdn20KogAl2KhLvcLgMRuTmz8FzIlfdUP0k
	qmPLVawi0w==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1726488511;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
	bh=OooH+41iO90Tusfnqtf1TfTh4krJ+CGZLGsHn5PLQVU=;
	b=kNn3ntPkfPdJr9bJeqpk0ifm/Div1qxv04VNfBTSN7j60WxO0IpHTkNgrvYZHncZ
	zq2DHGhlOmQ4XlQFH43Ua3e8SXXlxL/5eHiwxJtkafanppKBAkef5QjbtfR+ggW5JRn
	OobnB2LRRO3igNMbYLDUezdwFwamiMPeFdnpF1+8=
Message-ID: <01020191fabc03c6-26136e10-99af-4efb-97cc-46532280e694-000000@eu-west-1.amazonses.com>
Date: Mon, 16 Sep 2024 12:08:31 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] clk: Provide devm_clk_bulk_get_all_enabled() helper
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
 <20240914-clk_bulk_ena_fix-v1-1-ce3537585c06@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240914-clk_bulk_ena_fix-v1-1-ce3537585c06@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Feedback-ID: ::1.eu-west-1.YpP9ZbxnARFfy3Cb5pfsLd/pdsXBCNK0KEM7HforL4k=:AmazonSES
X-SES-Outgoing: 2024.09.16-54.240.7.28

Il 14/09/24 20:04, Cristian Ciocaltea ha scritto:
> Commit 265b07df758a ("clk: Provide managed helper to get and enable bulk
> clocks") added devm_clk_bulk_get_all_enable() function, but missed to
> return the number of clocks stored in the clk_bulk_data table referenced
> by the clks argument.  Without knowing the number, it's not possible to
> iterate these clocks when needed, hence the argument is useless and
> could have been simply removed.
> 
> Introduce devm_clk_bulk_get_all_enabled() variant, which is consistent
> with devm_clk_bulk_get_all() in terms of the returned value:
> 
>   > 0 if one or more clocks have been stored
>   = 0 if there are no clocks
>   < 0 if an error occurred
> 
> Moreover, the naming is consistent with devm_clk_get_enabled(), i.e. use
> the past form of 'enable'.
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


> ---
>   drivers/clk/clk-devres.c | 34 ++++++++++++++++++++++++++++++++++
>   include/linux/clk.h      | 24 ++++++++++++++++++++++++
>   2 files changed, 58 insertions(+)
> 
> diff --git a/drivers/clk/clk-devres.c b/drivers/clk/clk-devres.c
> index 82ae1f26e634..4203aaaa7544 100644
> --- a/drivers/clk/clk-devres.c
> +++ b/drivers/clk/clk-devres.c
> @@ -250,6 +250,40 @@ int __must_check devm_clk_bulk_get_all_enable(struct device *dev,
>   }
>   EXPORT_SYMBOL_GPL(devm_clk_bulk_get_all_enable);
>   
> +int __must_check devm_clk_bulk_get_all_enabled(struct device *dev,
> +					       struct clk_bulk_data **clks)
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
> +	if (ret <= 0)
> +		goto err_free_devres;
> +
> +	*clks = devres->clks;
> +	devres->num_clks = ret;
> +
> +	ret = clk_bulk_prepare_enable(devres->num_clks, *clks);
> +	if (ret) {
> +		clk_bulk_put_all(devres->num_clks, devres->clks);
> +		goto err_free_devres;
> +	}
> +
> +	devres_add(dev, devres);
> +
> +	return devres->num_clks;
> +
> +err_free_devres:
> +	devres_free(devres);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(devm_clk_bulk_get_all_enabled);
> +
>   static int devm_clk_match(struct device *dev, void *res, void *data)
>   {
>   	struct clk **c = res;
> diff --git a/include/linux/clk.h b/include/linux/clk.h
> index 851a0f2cf42c..158c5072852e 100644
> --- a/include/linux/clk.h
> +++ b/include/linux/clk.h
> @@ -511,6 +511,24 @@ int __must_check devm_clk_bulk_get_all(struct device *dev,
>   int __must_check devm_clk_bulk_get_all_enable(struct device *dev,
>   					      struct clk_bulk_data **clks);
>   
> +/**
> + * devm_clk_bulk_get_all_enabled - Get and enable all clocks of the consumer (managed)
> + * @dev: device for clock "consumer"
> + * @clks: pointer to the clk_bulk_data table of consumer
> + *
> + * Returns a positive value for the number of clocks obtained while the
> + * clock references are stored in the clk_bulk_data table in @clks field.
> + * Returns 0 if there're none and a negative value if something failed.
> + *
> + * This helper function allows drivers to get all clocks of the
> + * consumer and enables them in one operation with management.
> + * The clks will automatically be disabled and freed when the device
> + * is unbound.
> + */
> +
> +int __must_check devm_clk_bulk_get_all_enabled(struct device *dev,
> +					       struct clk_bulk_data **clks);
> +
>   /**
>    * devm_clk_get - lookup and obtain a managed reference to a clock producer.
>    * @dev: device for clock "consumer"
> @@ -1040,6 +1058,12 @@ static inline int __must_check devm_clk_bulk_get_all_enable(struct device *dev,
>   	return 0;
>   }
>   
> +static inline int __must_check devm_clk_bulk_get_all_enabled(struct device *dev,
> +						struct clk_bulk_data **clks)
> +{
> +	return 0;
> +}
> +
>   static inline struct clk *devm_get_clk_from_child(struct device *dev,
>   				struct device_node *np, const char *con_id)
>   {
> 

