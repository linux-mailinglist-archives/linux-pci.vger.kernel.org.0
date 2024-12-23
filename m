Return-Path: <linux-pci+bounces-18973-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F0A39FB07D
	for <lists+linux-pci@lfdr.de>; Mon, 23 Dec 2024 16:03:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C90EF162DB3
	for <lists+linux-pci@lfdr.de>; Mon, 23 Dec 2024 15:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F4A1AC8AE;
	Mon, 23 Dec 2024 15:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="HNc46ApH"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401AE14287;
	Mon, 23 Dec 2024 15:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734966226; cv=none; b=J0ydatj84oUPGzFquYa2fgQ5AL0ZKXbPEloHjpQ5bSkX68nnU/t7RppXEcaAQHbc0A5ZU6wD+NMivOYa5DOPCC5KWXC0bnAuZjjtnqZ/uVz+nEsZP2h0L57BUxWcK0IW/kR5b25sQemftU/fATQWtW+INxK989AhwZR/lJolkFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734966226; c=relaxed/simple;
	bh=9Uk4DZGoZgt9jIhyWCEgTSIsBhoNfzlfz6+xrGe7MSY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BLNBUXJJmSFxvvDf4o4oKSSHmvyIiIcM1uk6ty0VZRvEu4IZflVUPQh9pgxh+E85beE24ohWUkVWbRvLXbF0n2Tu/aYSgdkunYOVKWmYx/UDfsuVpA/8v91YUOI7RaQRwVs5WoOaNQbbcPw2evzlp26reYXl41gQdmeWdjP7z6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=HNc46ApH; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1734966220;
	bh=9Uk4DZGoZgt9jIhyWCEgTSIsBhoNfzlfz6+xrGe7MSY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HNc46ApHwR3QSB4UFbizcKOsz1Xw4oJsAmICm5n4kGOlLL/OXztNUVL4ndZWkm5Yy
	 nHRHuY2GvgHbWDgUjKzuf23CYfFnuwbuW7MMpETvm/82pENy6Tk58GtTv1i9Sm/GW8
	 4q1Ki/caz610ZdaNv8y51Bz5fK7gNpKQ72WlxUTuXbqgOtGn7hqi987C8P3ueeNLJN
	 tnVyJtKek3bV0rmzESnWcmSQFPa39SBsJY/g3DksSbTwFbqbn58mANvSdkBE5PvuyG
	 a9UqBawMpZbT+wBI5LeycYh7tc4lH1AZ7AU5YUS+ahnSdDJbZSJcGPP1AImkORCdmv
	 xjexlN++t6Ndg==
Received: from [192.168.1.90] (unknown [84.232.140.38])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 78ABD17E0E2C;
	Mon, 23 Dec 2024 16:03:39 +0100 (CET)
Message-ID: <cbd16df2-4f94-4f66-a00d-e9e972390905@collabora.com>
Date: Mon, 23 Dec 2024 17:03:37 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] PCI: exynos: Switch to
 devm_clk_bulk_get_all_enabled()
To: =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Jingoo Han <jingoohan1@gmail.com>, Lorenzo Pieralisi
 <lpieralisi@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, kernel@collabora.com,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-pci@vger.kernel.org, linux-samsung-soc@vger.kernel.org
References: <20241217-clk_bulk_ena_fix-v5-0-aafbbb245155@collabora.com>
 <20241217-clk_bulk_ena_fix-v5-2-aafbbb245155@collabora.com>
 <19eca5c3-cedb-4c5f-9b70-9c25c8387414@collabora.com>
 <20241223141806.GA1864738@rocinante>
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Content-Language: en-US
In-Reply-To: <20241223141806.GA1864738@rocinante>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/23/24 4:18 PM, Krzysztof Wilczyński wrote:
> Hello,
> 
>>> The helper devm_clk_bulk_get_all_enable() missed to return the number of
>>> clocks stored in the clk_bulk_data table referenced by the clks
>>> argument and, therefore, will be dropped.
>>>
>>> Use the newly introduced devm_clk_bulk_get_all_enabled() variant
>>> instead, which is consistent with devm_clk_bulk_get_all() in terms of
>>> the returned value:
>>>
>>>  > 0 if one or more clocks have been stored
>>>  = 0 if there are no clocks
>>>  < 0 if an error occurred
>>>
>>> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>>
>> In case you missed the previous requests, we need your ack on this patch
>> so that Stephen can apply the entire series to the clk tree and drop the
>> obsolete helper.
> 
> Please, take the following:
> 
>   Acked-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
> 
> Should be sufficient.
> 
> Also, sorry for keeping you both waiting.

Thanks Krzysztof, no worries!

Regards,
Cristian

