Return-Path: <linux-pci+bounces-14908-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BEFA9A4D11
	for <lists+linux-pci@lfdr.de>; Sat, 19 Oct 2024 13:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8F3EB21CEA
	for <lists+linux-pci@lfdr.de>; Sat, 19 Oct 2024 11:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E061DF993;
	Sat, 19 Oct 2024 11:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="XhIhRl1W"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9B1190688;
	Sat, 19 Oct 2024 11:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729336823; cv=none; b=sftefAHADwKfD6qrVKx8gt2WEYfZZqXmz1Go7hEb5Un3uBDhIX1L9yFBd/DGxIqFtdsF5K+5325HJvFLJ+Nb6F/xM6OQq6YpuXr7NGgLLMYj2yroYyjNfsKfnAYYkzvEa05gnEQ84R4W+FfJhgO8KYQnxmXnDUI+CopwbJ2CUHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729336823; c=relaxed/simple;
	bh=fgM8dTXtogJtNbM27u29QltmLJFMCoLsfeW9/uhqMqM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mf/28mKW9zY25vh2LTYanTYQM4a6WdTJ5iDfdESfyijAL3u/9Io9sihHm6lZ1v+s+j+haoqkyYTPz9Z9OX16cUCP+g1HfCTrYpJxDvS8i0q8AruuWohd5B7+VqK9WnHyzdVKOzAHcCJQRdWL9q6hBQKuvtW7f0T1c15sj8Kq2gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=XhIhRl1W; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1729336819;
	bh=fgM8dTXtogJtNbM27u29QltmLJFMCoLsfeW9/uhqMqM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XhIhRl1WjbKZQ+6IgcdASB3u6DRcer54NStItAFOZjmoAll1fvPNLoyB4DXDNkBs4
	 aBvU8QCX6v+fuWSeAsMn0iW3pGIV0yNxpivb/CkuO0PwSK67EWkS0LDd/kKIa3CaFt
	 sji7AM/Bbvqx97vGIijbg8vPrq/DWfcUGlSIPIeFdcXkHjEfOeJtPjhKNKLccpbWJT
	 XAmRQkDj5w7rSO1WkS2TC8E5YOVgsMCkXeAue2+KUcK3WIazSoVOIQyJ+tQrkxDWPk
	 UoZeM1zjOa50zZFaiT27nRbhvmr5sPruDdJoY+QpObAl8Ck+lsofSgeQ5RBXEpyXCL
	 RUK0Lhe583A1Q==
Received: from [192.168.1.90] (unknown [188.24.146.62])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3759717E1411;
	Sat, 19 Oct 2024 13:20:19 +0200 (CEST)
Message-ID: <9455cce5-af97-48cb-8042-24b714f29401@collabora.com>
Date: Sat, 19 Oct 2024 14:20:18 +0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] clk: Provide devm_clk_bulk_get_all_enabled()
 helper
To: Stephen Boyd <sboyd@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kw@linux.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh@kernel.org>,
 Russell King <linux@armlinux.org.uk>
Cc: kernel@collabora.com, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org
References: <20241018-clk_bulk_ena_fix-v3-0-57e8bb82460c@collabora.com>
 <20241018-clk_bulk_ena_fix-v3-1-57e8bb82460c@collabora.com>
 <c0afdf9f8c9773ef83274cb119d14c90.sboyd@kernel.org>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <c0afdf9f8c9773ef83274cb119d14c90.sboyd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/19/24 8:56 AM, Stephen Boyd wrote:
> Quoting Cristian Ciocaltea (2024-10-17 16:17:29)
>> diff --git a/drivers/clk/clk-devres.c b/drivers/clk/clk-devres.c
>> index 82ae1f26e634572b943d18b8d86267f0a69911a6..0d0fe364b66a8590d5e7c63dc6c1e70c59d53e89 100644
>> --- a/drivers/clk/clk-devres.c
>> +++ b/drivers/clk/clk-devres.c
>> @@ -230,25 +239,27 @@ int __must_check devm_clk_bulk_get_all_enable(struct device *dev,
>>                 return -ENOMEM;
>>  
>>         ret = clk_bulk_get_all(dev, &devres->clks);
>> -       if (ret > 0) {
>> -               *clks = devres->clks;
>> -               devres->num_clks = ret;
>> -       } else {
>> -               devres_free(devres);
>> -               return ret;
>> -       }
>> +       if (ret <= 0)
>> +               goto err_free_devres;
> 
> Please don't use goto so that the diff is minimized.

Done in v4:

https://lore.kernel.org/all/20241019-clk_bulk_ena_fix-v4-0-57f108f64e70@collabora.com/

Regards,
Cristian

