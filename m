Return-Path: <linux-pci+bounces-18969-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA819FAE83
	for <lists+linux-pci@lfdr.de>; Mon, 23 Dec 2024 13:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6E2116343F
	for <lists+linux-pci@lfdr.de>; Mon, 23 Dec 2024 12:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C4D1B393D;
	Mon, 23 Dec 2024 12:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="PnZjejza"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569B01AF0C5;
	Mon, 23 Dec 2024 12:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734958578; cv=none; b=VTpJidqVxAfa7LRkqhj7cQX/txa+C5swNhzkfk3KHhiIut6A5RRJa6Myl0mXTnRVVaaRrunhILS8VDVq4NIBnlXopjVR0+hfEWoWv91/96FjkLwAQtZKhiMHoua8mvwUo6/X/YDvFCCB1STow8LaClZPM/War32hA4GwcPgGU64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734958578; c=relaxed/simple;
	bh=IM1Q6HaiaXg6oZNGDXEIctOQsVVBIkBbPK450fxHLa4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=how5I0m5HRMkfqQJA1WeKg5THTzI9YT/bf/WhU0xvBM7KSwMLjI1AQ+SlfOsN+nexfdPTUbp2IyDYOhWM1Jv4iFWNnKGANdnfOo4K92EG4deTMwKh+mHTPa90aiBnuevAxacGAQs0Z/plkpGnkIWRDm1sb46uZMz+ZwHcC64ezE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=PnZjejza; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1734958573;
	bh=IM1Q6HaiaXg6oZNGDXEIctOQsVVBIkBbPK450fxHLa4=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=PnZjejzaQNnQKGcHj69QdnLjjYL1KWDohfW64b6PdhFvI8Jef1P+1jMFXi6aoy87O
	 QZN2t/CpxI7TrlVDF0XKymLi2VwstnAqSiG+c6utZIjP0w42MQDuiqyGQ405qxBs2c
	 AP+yTne24M6ncM6uTwMMDti0Eo7auSn5RbsqTpyt8VV3YNNHDKDOH3fYkSBqLBEO6I
	 TgndOBH1RP7S/jlh5bgr0yUgnR7cYS4ckWtIO0QRBlswHEHutgzzpO25flxd2Zco7P
	 yhvSI41OQxRDXL9qZr19qTkV9cOqS1/gZclAOKMk0nE56ep3fqyamFo1Q9K/rNAbf4
	 nm/jcVdC/o+mg==
Received: from [192.168.1.90] (unknown [84.232.140.38])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8869D17E3750;
	Mon, 23 Dec 2024 13:56:12 +0100 (CET)
Message-ID: <19eca5c3-cedb-4c5f-9b70-9c25c8387414@collabora.com>
Date: Mon, 23 Dec 2024 14:56:10 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] PCI: exynos: Switch to
 devm_clk_bulk_get_all_enabled()
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Jingoo Han <jingoohan1@gmail.com>, Lorenzo Pieralisi
 <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kw@linux.com>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: kernel@collabora.com, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org
References: <20241217-clk_bulk_ena_fix-v5-0-aafbbb245155@collabora.com>
 <20241217-clk_bulk_ena_fix-v5-2-aafbbb245155@collabora.com>
Content-Language: en-US
In-Reply-To: <20241217-clk_bulk_ena_fix-v5-2-aafbbb245155@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Bjorn,

On 12/17/24 11:41 PM, Cristian Ciocaltea wrote:
> The helper devm_clk_bulk_get_all_enable() missed to return the number of
> clocks stored in the clk_bulk_data table referenced by the clks
> argument and, therefore, will be dropped.
> 
> Use the newly introduced devm_clk_bulk_get_all_enabled() variant
> instead, which is consistent with devm_clk_bulk_get_all() in terms of
> the returned value:
> 
>  > 0 if one or more clocks have been stored
>  = 0 if there are no clocks
>  < 0 if an error occurred
> 
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

In case you missed the previous requests, we need your ack on this patch
so that Stephen can apply the entire series to the clk tree and drop the
obsolete helper.

Thanks,
Cristian

