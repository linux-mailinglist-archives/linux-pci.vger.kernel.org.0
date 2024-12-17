Return-Path: <linux-pci+bounces-18670-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46CA09F5919
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 22:54:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B88E18819D0
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 21:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7BC41F9AAC;
	Tue, 17 Dec 2024 21:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="A9VWstEz"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBD414A0A3;
	Tue, 17 Dec 2024 21:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734471985; cv=none; b=gsxg48kfO710PAVfHcIx13UkRrHO6a72VwogGNQRE5lxbZaM4slcJR6inu+J96C6zw362yv7KOiVPkY7Y2Cw69V9vG5G9kz4mlYJ1rMMjqrCBbr0mJllTLbInrJh8YF9sqB5aMNAZCVM9fPZeP8t4BW/z215faj3d3QCOgaL/HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734471985; c=relaxed/simple;
	bh=9/SlMqJheV6UBlMdYFEbz4fj4zpzDrak/dbk5Hz2i7E=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Wv9eU97PqZTCYKF/GPaMz/0zsR3yVcnNZejSEIGcERIkCuGWBk8wBUJVwwpu5BtZgrVhu7bNCvJHBxD6dJVL67VbnuX+hR0Cm4dMBS+eYK0T7q/iXr/6HXtlUH5Q0AL/uSbmWa4D9SV9YCNoKvl3XxX05UMHX7EMYk1I1ONJkCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=A9VWstEz; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1734471982;
	bh=9/SlMqJheV6UBlMdYFEbz4fj4zpzDrak/dbk5Hz2i7E=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=A9VWstEzPcXQiWHL0C4j6BVCWeKwPoOtm1T/XMCWve83tkNjkNOyZlAWQSNPm1P30
	 MfQuPMdoNnBDLUZr5DKsIsUnxhmN0UAA89kTnyOB3QCLd7iJ6KVD3AC95iuab7Yn7G
	 Eifiv1gvsW7mBze0HKR+KCIrEnrEfyDHifr+veNHpJrdqbEHf6lz0O6amCY69buCtu
	 Hf7J7YXPCb0WKByKoe9Co8sseE6kTC/wBJjYuZNXfeOuJm9YyYCrvyJEQ8lS2Mr7be
	 b1Mip2WCQ63TvMiqtG1SbGeHOtP3Y7alg3oxNuebUvDeJXuhEbiYCHoZWf+P3Ovq+4
	 ZUPbX6RdIoBWA==
Received: from [192.168.1.90] (unknown [84.232.140.38])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 223D817E381B;
	Tue, 17 Dec 2024 22:46:21 +0100 (CET)
Message-ID: <b13cbeda-79b6-4700-a2e7-083a50541c80@collabora.com>
Date: Tue, 17 Dec 2024 23:46:19 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/3] Provide devm_clk_bulk_get_all_enabled() helper
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
References: <20241217-clk_bulk_ena_fix-v5-0-aafbbb245155@collabora.com>
Content-Language: en-US
In-Reply-To: <20241217-clk_bulk_ena_fix-v5-0-aafbbb245155@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/17/24 11:41 PM, Cristian Ciocaltea wrote:
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
> Changes in v5:
> - Rebased series onto next-20241217
> - Removed the patch introducing the new helper - merged in v6.13-rc1
> - Updated last patch to fix a rebase conflict
> - Link to v4: https://lore.kernel.org/r/20241019-clk_bulk_ena_fix-v4-0-57f108f64e70@collabora.com

@Angelo, Matthias, Bjorn:

Could you please provide an ack for the first two patches so that
Stephen can apply them to the clk tree along with the last one removing
the obsolete helper - there are no other users of it as of next-20241217.

Thanks,
Cristian

