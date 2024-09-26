Return-Path: <linux-pci+bounces-13557-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC949871FF
	for <lists+linux-pci@lfdr.de>; Thu, 26 Sep 2024 12:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5132228C56D
	for <lists+linux-pci@lfdr.de>; Thu, 26 Sep 2024 10:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42FCC1ACE12;
	Thu, 26 Sep 2024 10:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="qMhC3dtQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB861F95C;
	Thu, 26 Sep 2024 10:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727347793; cv=none; b=cOicv7wbYunSMzrFScC0Nrek7hgJp6/kzvifn9/nqGwOeqRqSivOAmXmyB4GcHZyHnn0FBWWbrGOwWPzwrwgJvhRm6v/j1qrqvcuRLNeixbp8uHtYbhiLfqoTaPI7srQGazLoxx3wQ3D9ZMPs6Pd98p2kW9N9VzfnhRnoGdbWew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727347793; c=relaxed/simple;
	bh=5z7SiMhJTEAuTswaoEaoXppBt9EGx2gS7cFSH/7/tow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IFcjc5ZDMAG9moXrH4v+IFPcYntP2vdw9hMoWOxzBmmGGu4/IuvuosZQ4chaZ/IisJWAZKMgKMJBH1VC7B85qLYfCW10IuSC385w5tsICRpjptNq+YSekeuTuRDhslDmeA06PssJXGCykBuudzx8cQlRhfgpLBCloh5FPutquuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=qMhC3dtQ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1727347789;
	bh=5z7SiMhJTEAuTswaoEaoXppBt9EGx2gS7cFSH/7/tow=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qMhC3dtQcM1PnqulvZCIkjIpriv/j4NY6o6x597yg0HfYV+VJRVOQZ162gpZO+OGA
	 OBfpQsR3mRtzjSQcGeTqIiYFxCjWFOKJOYS2N31M1dPN/bm96phcxq4GgpY51KnoSI
	 eEYbb6I8ZALbhUNpH4yOqaa4ytTLa0Cx1iMZJOVSBlN8mlWUbnL1pyZGScI4zVpcp6
	 fENYo3TyyD3YRxff3cd1o6q8OKgOenw6A/0Sbb++RuCML5MkbfNLmnMLN+aYp2YmBF
	 fjHyq95v2p+BEZnJA+hJltFc4qEpxL7trtLhmjTKBTr9JC5+PgUmxPZuN90P4jLxer
	 +aTpTpuNcQ95A==
Received: from [IPV6:2a01:e0a:d1a:1250:792b:136f:2a18:fd70] (unknown [IPv6:2a01:e0a:d1a:1250:792b:136f:2a18:fd70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0E59417E11F6;
	Thu, 26 Sep 2024 12:49:49 +0200 (CEST)
Message-ID: <227a813a-0586-4072-b6de-9dfddfe2d060@collabora.com>
Date: Thu, 26 Sep 2024 13:49:47 +0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Provide devm_clk_bulk_get_all_enabled() helper
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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
 <70a24964-990b-4606-bdc8-4dd42c44785a@collabora.com>
 <20240925075654.f2pefosdspqiakvj@thinkpad>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <20240925075654.f2pefosdspqiakvj@thinkpad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/25/24 10:56 AM, Manivannan Sadhasivam wrote:
> On Wed, Sep 25, 2024 at 09:52:44AM +0200, AngeloGioacchino Del Regno wrote:
>> Il 24/09/24 16:36, Manivannan Sadhasivam ha scritto:
>>> On Sat, Sep 14, 2024 at 09:04:53PM +0300, Cristian Ciocaltea wrote:
>>>> Commit 265b07df758a ("clk: Provide managed helper to get and enable bulk
>>>> clocks") added devm_clk_bulk_get_all_enable() function, but missed to
>>>> return the number of clocks stored in the clk_bulk_data table referenced
>>>> by the clks argument.
>>>>
>>>> That is required in case there is a need to iterate these clocks later,
>>>> therefore I couldn't see any use case of this parameter and should have
>>>> been simply removed from the function declaration.
>>>>
>>>
>>> Is there an user that currerntly does this?
>>>
>>
>> Yes and the patch wasn't sent upstream yet, but anyway, regardless of that,
>> this series is fixing inconsistency with both naming and usage between the
>> clock (bulk) API functions, with that being the only function acting
>> different from the others, at best confusing people.
>>
> 
> I agree with the 'inconsistency' part of the API, but I wouldn't call it as
> *broken* as this series does. Please fix that and you can have my:
> 
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks Angelo and Mani for reviewing this.

I've submitted v2:

https://lore.kernel.org/lkml/20240926-clk_bulk_ena_fix-v2-0-9c767510fbb5@collabora.com/

Regards,
Cristian

