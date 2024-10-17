Return-Path: <linux-pci+bounces-14833-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB91A9A3153
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2024 01:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 612EE1F22949
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 23:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F420D2296E6;
	Thu, 17 Oct 2024 23:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="a8ExjZa7"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDCA1FF5F5;
	Thu, 17 Oct 2024 23:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729207444; cv=none; b=HWHjKLNgNbpo9Gknxqj8u5JG7B1um8Y5pJ3dOltRFUWbTDrgLbENugWRmsr8XralseW2VVXmrefXIE3mAki1wDvasZ0CDPjs02TDPa9mz+RtMKiPy0TCML7oc5XsW3zWbM5HTOV17dCceCTlY6pPG532oWvhwb7go6+HJZ3XUCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729207444; c=relaxed/simple;
	bh=stynPAKb67QZa/lU7ZIP8zDcPVSvZM4VE/kuZgRvW68=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=be5cl8euHWNeV+qq4quHN+6ny3hep+ym5EUWwu8O0O7RLbGtRLgG9PFXBBp2P7ERM4FsOGFxJY27KHTW50y9Ts1uWFfM2u+44HghYkAinE6YnOvv7XCf2KX+6kmBfcaECi6qpbfTtviMqixL3NMvb6lkKzd4FBE7Y2dIzcFDnSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=a8ExjZa7; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1729207441;
	bh=stynPAKb67QZa/lU7ZIP8zDcPVSvZM4VE/kuZgRvW68=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=a8ExjZa7BXve8hN7bF41EjrnBaIRjB1DZGyLFYJFg5m3YcIb8+01SRWT4XOuSnd1g
	 951q26phmb2PPL+3JnRQbyvLhpoHdGOKwtJIFiIAj0UaCR1uSIVU4LMo/RKPMlC16b
	 zoYykMa8grW3NO3hvmHH3U/PIa6K3YRAhsKQntX4yAnXJr24bMMyBx29558glxL2uZ
	 kdky/hm5Tr3xB3CThNHTnDJtDvSu3MkYd1powH5Xrhaw4tEWzh5QSo8+JJAjuJED7P
	 67Ykrw+4TGTsg9Vh41NW9DjkPofMi25k8i7cDnvFWZ/gKCFbIQMyjQxIjvlTLidC7Y
	 6N1rL2y+qSwTw==
Received: from [192.168.1.90] (unknown [188.24.146.62])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7079317E0ED2;
	Fri, 18 Oct 2024 01:24:00 +0200 (CEST)
Message-ID: <6acaeefe-54f1-4a7f-9e07-bc8b1bfbab08@collabora.com>
Date: Fri, 18 Oct 2024 02:23:59 +0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] clk: Provide devm_clk_bulk_get_all_enabled()
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
References: <20240926-clk_bulk_ena_fix-v2-0-9c767510fbb5@collabora.com>
 <20240926-clk_bulk_ena_fix-v2-1-9c767510fbb5@collabora.com>
 <347771679b3ac765de3f79c26f3d3595.sboyd@kernel.org>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <347771679b3ac765de3f79c26f3d3595.sboyd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/17/24 10:45 PM, Stephen Boyd wrote:
> Quoting Cristian Ciocaltea (2024-09-26 03:43:20)
>> Commit 265b07df758a ("clk: Provide managed helper to get and enable bulk
>> clocks") added devm_clk_bulk_get_all_enable() function, but missed to
>> return the number of clocks stored in the clk_bulk_data table referenced
>> by the clks argument.  Without knowing the number, it's not possible to
>> iterate these clocks when needed, hence the argument is useless and
>> could have been simply removed.
>>
>> Introduce devm_clk_bulk_get_all_enabled() variant, which is consistent
>> with devm_clk_bulk_get_all() in terms of the returned value:
>>
>>  > 0 if one or more clocks have been stored
>>  = 0 if there are no clocks
>>  < 0 if an error occurred
>>
>> Moreover, the naming is consistent with devm_clk_get_enabled(), i.e. use
>> the past form of 'enable'.

[...]

> Instead of duplicating can you make devm_clk_bulk_get_all_enable() use
> the devm_clk_bulk_get_all_enabled() function but not return the number
> of clks all in this patch? It will make the diff much more readable that
> way.

Done in v3 [1].

Thanks for reviewing,
Cristian

[1] https://lore.kernel.org/all/20241018-clk_bulk_ena_fix-v3-0-57e8bb82460c@collabora.com/

