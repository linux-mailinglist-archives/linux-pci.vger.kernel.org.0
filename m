Return-Path: <linux-pci+bounces-13501-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D55A985498
	for <lists+linux-pci@lfdr.de>; Wed, 25 Sep 2024 09:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0C9A287F24
	for <lists+linux-pci@lfdr.de>; Wed, 25 Sep 2024 07:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E78155CB3;
	Wed, 25 Sep 2024 07:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="CwS0OhQx"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F244147C9B;
	Wed, 25 Sep 2024 07:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727250769; cv=none; b=G8LNwIdInuEnxMl+rBeogMv5J8RyIMArX+U/oNvEq/52L4v7ifwYWJyXwnjqS1wR5BEj8BZaHOYe5Bc78KG0TPJvIoltQRo8nixWAKtEWcqpNbqGKAtPNNiiLOsKR0RawhFXDmKsxXdwWaQeVepDNAW3Dv63dU2x96lpHD/HfOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727250769; c=relaxed/simple;
	bh=HaGjCo2JkmzWG5vS1IbRUjPXbfLtQiEoKu06nA0Sy8E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SuFCnbBjda88CUk6jasLRQiqq9egGUCrmdAKia3BgY8uIWAkX890AypExtdYfL/UOf7/l1nCvbnC69/tGdGsQdXf9ys/fi2FRIWHdjXH6aFN3nkrEFNvlSQJ7Benl8tEHoy1SUECU/T/q2EuORpZIoNhW32UO/oTsuzZiRiMpR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=CwS0OhQx; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1727250765;
	bh=HaGjCo2JkmzWG5vS1IbRUjPXbfLtQiEoKu06nA0Sy8E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CwS0OhQxMMFoCFIS6sWAgehLjs+WK4NyXWcz5SdQxnF2oNJwCpRne9wX7fynkCv8j
	 iPauMQi2R6OYgNdiJWrC7ivCyzeni29NvIX+2iNMItm4zxgeLqMMHFmBlzNt0KDTod
	 0qTbNIOnOFmBAbXWk6uFWt3MGjFIjjJDLY4mseWzeLuvZ/gv1IyMoEKN3eIde1r+8b
	 P9v4oBY1TCCKBxIM8xMKwP4ZE3JJun1fXde27hUjvjb0XhsqPuQAbWG32d5haO4+0S
	 nuk0wGZKjuMb0BPSwBOgCD0ShW8+PZONX5VygD0/n7R0vgLgNgXp/MS/C+o6NdKm79
	 6fQ5I9D047oOA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8408617E1045;
	Wed, 25 Sep 2024 09:52:44 +0200 (CEST)
Message-ID: <70a24964-990b-4606-bdc8-4dd42c44785a@collabora.com>
Date: Wed, 25 Sep 2024 09:52:44 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Provide devm_clk_bulk_get_all_enabled() helper
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Matthias Brugger <matthias.bgg@gmail.com>, Jingoo Han
 <jingoohan1@gmail.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar
 <alim.akhtar@samsung.com>, kernel@collabora.com, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org
References: <20240914-clk_bulk_ena_fix-v1-0-ce3537585c06@collabora.com>
 <20240924143634.pqpdsewoqxn3liqi@thinkpad>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240924143634.pqpdsewoqxn3liqi@thinkpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 24/09/24 16:36, Manivannan Sadhasivam ha scritto:
> On Sat, Sep 14, 2024 at 09:04:53PM +0300, Cristian Ciocaltea wrote:
>> Commit 265b07df758a ("clk: Provide managed helper to get and enable bulk
>> clocks") added devm_clk_bulk_get_all_enable() function, but missed to
>> return the number of clocks stored in the clk_bulk_data table referenced
>> by the clks argument.
>>
>> That is required in case there is a need to iterate these clocks later,
>> therefore I couldn't see any use case of this parameter and should have
>> been simply removed from the function declaration.
>>
> 
> Is there an user that currerntly does this?
> 

Yes and the patch wasn't sent upstream yet, but anyway, regardless of that,
this series is fixing inconsistency with both naming and usage between the
clock (bulk) API functions, with that being the only function acting
different from the others, at best confusing people.

Cheers,
Angelo

> - Mani
> 
>> The first patch in the series provides devm_clk_bulk_get_all_enabled()
>> variant, which is consistent with devm_clk_bulk_get_all() in terms of
>> the returned value:
>>
>>   > 0 if one or more clocks have been stored
>>   = 0 if there are no clocks
>>   < 0 if an error occurred
>>
>> Moreover, the naming is consistent with devm_clk_get_enabled(), i.e. use
>> the past form of 'enable'.
>>
>> The next two patches switch existing users of devm_clk_get_enable() to
>> the new helper - there were only two, as of next-20240913.
>>
>> The last patch drops the now obsolete devm_clk_bulk_get_all_enable()
>> helper.
>>
>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>> ---
>> Cristian Ciocaltea (4):
>>        clk: Provide devm_clk_bulk_get_all_enabled() helper
>>        soc: mediatek: pwrap: Switch to devm_clk_bulk_get_all_enabled()
>>        PCI: exynos: Switch to devm_clk_bulk_get_all_enabled()
>>        clk: Drop obsolete devm_clk_bulk_get_all_enable() helper
>>
>>   drivers/clk/clk-devres.c                | 30 ++++++++++++++++--------------
>>   drivers/pci/controller/dwc/pci-exynos.c |  2 +-
>>   drivers/soc/mediatek/mtk-pmic-wrap.c    |  4 ++--
>>   include/linux/clk.h                     | 12 +++++++-----
>>   4 files changed, 26 insertions(+), 22 deletions(-)
>> ---
>> base-commit: 5acd9952f95fb4b7da6d09a3be39195a80845eb6
>> change-id: 20240912-clk_bulk_ena_fix-16ba77358ddf
>>
> 



