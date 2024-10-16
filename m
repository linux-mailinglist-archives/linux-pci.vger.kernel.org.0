Return-Path: <linux-pci+bounces-14625-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF7C49A0584
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 11:28:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A039E284AD3
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 09:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B89205E0E;
	Wed, 16 Oct 2024 09:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Z2WrxwlF"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67859205E07;
	Wed, 16 Oct 2024 09:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729070922; cv=none; b=HRrQ4+oLfYQl6sphLVJ1EwHrObg6WI3STeD9MKIebpxuTQlHfc9KOW1kgkJ5BzUnIActv86qEa0pN5QyUqy9ysEs8AxY/SF7X8T5BSG4ix5j98DeyzKyPGGWmLP6st7G7q1Rz6HWyeEj5CmTNH1/uGC9KovPpiL1Ea3+Or8hEzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729070922; c=relaxed/simple;
	bh=1J6QfXBg9V1ZgA0yYgTnAj6Ox1PdlYEoRDRtJvp7+yI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=uAChpFy9dmQp0uAbZhHxs0uyw5xJw1C4G6lLkDX/JJ00QqOqqK6zqMIU+vrPnFNzqafBHdK50kofiGrk7fFJiuZvceR4LT7NkV9vY4fb8xo5sOd6R7+ygFXJbdJ3euACIfIIE2Rn0bkSRGtcMMuCH+hQA2IkQo2W59cJYiK36zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Z2WrxwlF; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1729070918;
	bh=1J6QfXBg9V1ZgA0yYgTnAj6Ox1PdlYEoRDRtJvp7+yI=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=Z2WrxwlF/UbdQHHE3PaQ7S2n7qo/CiLPzkdsI3xTOvi2AKewdUkExHRZztiXYWHPI
	 UesLbavjU/KvWScNPW/g3Q0UxtvFsB176XHje9NQbBtCP0HV49M9lVqyvD4BKUKrUt
	 ThVeZukTzs/QEutWPDryjwwccLK4hwHKHEBObU2WmRaEdbWxvM3gPFBrzhBFy4txBr
	 UxEIYy1mO0MPWI+kUSQ+lC9WfAAYjVYsIgo0w5YoM7kJEz3Nytk1FZ90NuQMgXWG4E
	 DB87X6qHxD8Qc6Cu++5/3kumSN6xVdRMJJvqiuXdfR9jCKRhCev+eHYXmCiZIPneWd
	 RobPZ1sJd8dqQ==
Received: from [192.168.1.90] (unknown [188.24.146.62])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id F33B617E121F;
	Wed, 16 Oct 2024 11:28:37 +0200 (CEST)
Message-ID: <9ca2a9dc-b643-40ce-8177-68533d0733d1@collabora.com>
Date: Wed, 16 Oct 2024 12:28:37 +0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] Provide devm_clk_bulk_get_all_enabled() helper
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Jingoo Han <jingoohan1@gmail.com>, Lorenzo Pieralisi
 <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kw@linux.com>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>
Cc: kernel@collabora.com, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org
References: <20240926-clk_bulk_ena_fix-v2-0-9c767510fbb5@collabora.com>
Content-Language: en-US
In-Reply-To: <20240926-clk_bulk_ena_fix-v2-0-9c767510fbb5@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/26/24 1:43 PM, Cristian Ciocaltea wrote:
> Commit 265b07df758a ("clk: Provide managed helper to get and enable bulk
> clocks") added devm_clk_bulk_get_all_enable() function, but missed to
> return the number of clocks stored in the clk_bulk_data table referenced
> by the clks argument.
> 
> That is required in case there is a need to iterate these clocks later,
> therefore I couldn't see any use case of this parameter and should have
> been simply removed from the function declaration.
> 
> The first patch in the series provides devm_clk_bulk_get_all_enabled()
> variant, which is consistent with devm_clk_bulk_get_all() in terms of
> the returned value:
> 
>  > 0 if one or more clocks have been stored
>  = 0 if there are no clocks
>  < 0 if an error occurred
> 
> Moreover, the naming is consistent with devm_clk_get_enabled(), i.e. use
> the past form of 'enable'.
> 
> The next two patches switch existing users of devm_clk_get_enable() to
> the new helper - there were only two, as of next-20240913.
> 
> The last patch drops the now obsolete devm_clk_bulk_get_all_enable()
> helper.
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
> Changes in v2:
> - Dropped references to 'broken' API in commit descriptions, per Mani's
>   suggestion
> - Added R-b tags from Angelo and Mani
> - Link to v1:
>   https://lore.kernel.org/r/20240914-clk_bulk_ena_fix-v1-0-ce3537585c06@collabora.com

[...]

This still applies cleanly on next-20241016 and there are no new users
of devm_clk_bulk_get_all_enable(), hence I wonder if anything else is
missing to get it merged.

Thanks,
Cristian

