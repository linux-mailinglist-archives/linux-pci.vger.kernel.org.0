Return-Path: <linux-pci+bounces-3081-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D509A84963E
	for <lists+linux-pci@lfdr.de>; Mon,  5 Feb 2024 10:19:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 061AC1C21919
	for <lists+linux-pci@lfdr.de>; Mon,  5 Feb 2024 09:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E424125B3;
	Mon,  5 Feb 2024 09:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="hSH8rq0v"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDEC9125B7
	for <linux-pci@vger.kernel.org>; Mon,  5 Feb 2024 09:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707124764; cv=none; b=p0P/gwC1Ylu7I6nLsQ77KCmEHj1G++t6SzdneYyLrxW63EE95PfcH3xm/9MfOlQTV2q17mi5ULUrSkYYhDXLQzp8RB7srFi83jiZFBlbc9ULmnPtVRSqkLzzOJmFOjF4CFsdJgVulZasNnXjLbbxzUP5B30LMNQHyt7Zig1ipf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707124764; c=relaxed/simple;
	bh=JOZyY44o3VjmqxPeYm2CxNUhG2xfl45AjDv+Izabiy0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:In-Reply-To:
	 Content-Type:References; b=Cub83/Bw662fEFcJ7nPAeL7jvSjXf/IeTxEXLSoCbmrCdTk6PZdHdmnCd7TUvZ3cSjxAMjqKs9mxGvnn9fuqkVVcasi1Sdcfctbyyf9Xx2hQSo6G/Gka3vQ4/oaui6Pat4RhbdaoRjFXDnElogV5OuP82lF6HyjhLqMyWunk0IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=hSH8rq0v; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240205091919euoutp02484491ade50953c70e88a18db560110c~w7Ox2AN8V1679616796euoutp02S
	for <linux-pci@vger.kernel.org>; Mon,  5 Feb 2024 09:19:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240205091919euoutp02484491ade50953c70e88a18db560110c~w7Ox2AN8V1679616796euoutp02S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1707124759;
	bh=x11oEt2Z68lZhuN1htWEnhx4xVZleMPJJZ1X62idi6Y=;
	h=Date:From:Subject:To:Cc:In-Reply-To:References:From;
	b=hSH8rq0vRLoaSosTYdcEhyDnQ7Szp4iBHuaR11zkwvwT53s+0Lmd8kbnx4lNHlHrw
	 t8Y6bmp2a4cHRG2gEWYju/1i+znVWhRYYg6Qa+nkWeWABV5voRklxJC2c8pPVNmqXA
	 RGZXi/+XWGSWk82PER54NGfkydVJG7mE/bvqv5uk=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240205091918eucas1p23872d9f15a22c9e23103857a5ae2b9c6~w7OxUt-NP1676616766eucas1p2I;
	Mon,  5 Feb 2024 09:19:18 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 43.EC.09539.618A0C56; Mon,  5
	Feb 2024 09:19:18 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240205091917eucas1p2cde1af2ad3532e2e44664132af9ee9ff~w7OwxvkO-1177511775eucas1p2c;
	Mon,  5 Feb 2024 09:19:17 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240205091917eusmtrp10525cabc0eb7cc0ab1e77b90141b186c~w7Oww9zHD0227302273eusmtrp1M;
	Mon,  5 Feb 2024 09:19:17 +0000 (GMT)
X-AuditID: cbfec7f2-515ff70000002543-f6-65c0a8160d53
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 87.70.09146.518A0C56; Mon,  5
	Feb 2024 09:19:17 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240205091916eusmtip2cadae4e7a9f14d4a43acec119e6d566e~w7OvyCn8w2786927869eusmtip2S;
	Mon,  5 Feb 2024 09:19:16 +0000 (GMT)
Message-ID: <8e336720-ce08-4391-ad36-b83fea246cab@samsung.com>
Date: Mon, 5 Feb 2024 10:19:16 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v4 1/2] clk: Provide managed helper to get and enable
 bulk clocks
To: Shradha Todi <shradha.t@samsung.com>, 'Manivannan Sadhasivam'
	<manivannan.sadhasivam@linaro.org>, sboyd@kernel.org,
	mturquette@baylibre.com
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, jingoohan1@gmail.com,
	lpieralisi@kernel.org, kw@linux.com, robh@kernel.org, bhelgaas@google.com,
	krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com,
	linux@armlinux.org.uk, pankaj.dubey@samsung.com
Content-Language: en-US
In-Reply-To: <08a901da55cf$4ee48000$ecad8000$@samsung.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFKsWRmVeSWpSXmKPExsWy7djP87piKw6kGpy8LG3xYN42NoslTRkW
	K77MZLfY+3oru0VDz29Wi02Pr7FafOy5x2pxedccNouz846zWcw4v4/J4tDUvYwWLX9aWCzu
	tnSyWlw85WqxaOsXdov/e3awW/y7tpHFovdwrYOQx+VrF5k93t9oZffYOesuu8eCTaUem1Z1
	snncubaHzePJlelMHpuX1Hv0bVnF6PF5k1wAVxSXTUpqTmZZapG+XQJXRuOMJSwFu8Qqvs38
	wN7AuEqoi5GTQ0LAROLwkl1sXYxcHEICKxglTm+5C+V8YZR48GciM4TzmVHi6ZItTDAtWy4t
	YQexhQSWM0os/JMPUfSRUaKrcSYrSIJXwE7i2tYOFhCbRUBF4vS8FWwQcUGJkzOfgMVFBeQl
	7t+aATaITcBQouttF1iNsEC4xJeuSWBniAhMZpSY3PYN7AxmgS9MEvufLgDrZhYQl7j1ZD7Y
	SZwCVhKf3/SxQsTlJba/nQPWICFwjlOipasf6m4XiUefFrJB2MISr45vYYewZSROT+5hgWho
	Z5RY8Ps+E4QzgVGi4fktRogqa4k7534BdXMArdCUWL9LH8SUEHCUuPmjDMLkk7jxVhDiBj6J
	SdumM0OEeSU62qCBrSYx6/g6uK0HL1xinsCoNAspXGYh+WwWkm9mIaxdwMiyilE8tbQ4Nz21
	2DAvtVyvODG3uDQvXS85P3cTIzA5nv53/NMOxrmvPuodYmTiYDzEKMHBrCTCO0F4b6oQb0pi
	ZVVqUX58UWlOavEhRmkOFiVxXtUU+VQhgfTEktTs1NSC1CKYLBMHp1QDU0nUqpa9DfIrrHdU
	mVzunrft4vp/IW7fJU3+rL4fKP5ZdYedvt73Y7tckrtaJe4ozDzOG3d/ZenC7Kbv57XEOnTn
	7nV9w/wv96z/n/eP+r20POuk9Z9vP9/0NSrH6khsqOsstmJO1Qe3uq6l8N/kN1ssxGCsf8i3
	5dQiy0SHpGL+9MciXtUtIg+fB3ee6Km9WMrm+vW8z63dr/xUtrxeVbKwUGTdlWnrDv88/mxd
	X4j+V47CfTyXWcpq5lrv7N/ad/rSsxDugoNFAu1Ndru6jR3k+RgbtR9eblf1n7ZKaqZRvft1
	hVzV1m59zaCYIv6PUxu9VuV2O7r/evPbPHuacc6fCKt3nl1dx7c3HctQYinOSDTUYi4qTgQA
	42seRf0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLIsWRmVeSWpSXmKPExsVy+t/xe7qiKw6kGuz5ZGjxYN42NoslTRkW
	K77MZLfY+3oru0VDz29Wi02Pr7FafOy5x2pxedccNouz846zWcw4v4/J4tDUvYwWLX9aWCzu
	tnSyWlw85WqxaOsXdov/e3awW/y7tpHFovdwrYOQx+VrF5k93t9oZffYOesuu8eCTaUem1Z1
	snncubaHzePJlelMHpuX1Hv0bVnF6PF5k1wAV5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJ
	pZ6hsXmslZGpkr6dTUpqTmZZapG+XYJeRuOMJSwFu8Qqvs38wN7AuEqoi5GTQ0LARGLLpSXs
	XYxcHEICSxkl1v99ygyRkJE4Oa2BFcIWlvhzrYsNoug9o8T79n5GkASvgJ3Eta0dLCA2i4CK
	xOl5K9gg4oISJ2c+AYuLCshL3L81gx3EZhMwlOh62wVWIywQLvFx5UlGkKEiApMZJU7N6wfb
	xizwhUni+IkCiG2TmCT6Hk9hh0iIS9x6Mp8JxOYUsJL4/KYPqsFMomtrFyOELS+x/e0c5gmM
	QrOQHDILSfssJC2zkLQsYGRZxSiSWlqcm55bbKhXnJhbXJqXrpecn7uJEZgOth37uXkH47xX
	H/UOMTJxMB5ilOBgVhLhnSC8N1WINyWxsiq1KD++qDQntfgQoykwNCYyS4km5wMTUl5JvKGZ
	gamhiZmlgamlmbGSOK9nQUeikEB6YklqdmpqQWoRTB8TB6dUA5PkjjWT9A/FOopumCVUfuNx
	mVt6krs0/7wst4c5Yn6m8bmBgrPuzPi86PTtTp0Le3d9POozKcAy3js/4uDsedr79llJZ979
	uTR533vbfVfcJyrMCps749bDT/e7vz6erb/oU+zmfJ4dVa/L2wXzFuzbNXPiyijWanXVM2uC
	H3Zqn0wqCetZcy75PV+m9c/CWQK/8na5qYTczk7ReqqtnxezXbNHd/kNA6mvGyTObwrvKX9d
	dO99beuUoMQel9kF7U/ymJyP9cxxiepy+V7Vpt5z4JvsBF8bS9v/hm/SZ8Uy/lGxZYjsuBon
	4vTmk9ixtYvfp1y463qVhY3RZudl69Ys037b+bJPdix22Z5+REmJpTgj0VCLuag4EQBf5msC
	kAMAAA==
X-CMS-MailID: 20240205091917eucas1p2cde1af2ad3532e2e44664132af9ee9ff
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240124103855epcas5p27400bd95df42f36b9547a4e28aa26f5d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240124103855epcas5p27400bd95df42f36b9547a4e28aa26f5d
References: <20240124103838.32478-1-shradha.t@samsung.com>
	<CGME20240124103855epcas5p27400bd95df42f36b9547a4e28aa26f5d@epcas5p2.samsung.com>
	<20240124103838.32478-2-shradha.t@samsung.com>
	<20240129065448.GC2971@thinkpad>
	<08a901da55cf$4ee48000$ecad8000$@samsung.com>

On 02.02.2024 12:59, Shradha Todi wrote:
>> -----Original Message-----
>> From: Manivannan Sadhasivam<manivannan.sadhasivam@linaro.org>
>> Sent: 29 January 2024 12:25
>> To: Shradha Todi<shradha.t@samsung.com>
>> Subject: Re: [PATCH v4 1/2] clk: Provide managed helper to get and enable bulk
>> clocks
>>
>> On Wed, Jan 24, 2024 at 04:08:37PM +0530, Shradha Todi wrote:
>>> Provide a managed devm_clk_bulk* wrapper to get and enable all bulk
>>> clocks in order to simplify drivers that keeps all clocks enabled for
>>> the time of driver operation.
>>>
>>> Suggested-by: Marek Szyprowski<m.szyprowski@samsung.com>
>>> Signed-off-by: Shradha Todi<shradha.t@samsung.com>
>>> ---
>>>   drivers/clk/clk-devres.c | 40
>> ++++++++++++++++++++++++++++++++++++++++
>>>   include/linux/clk.h      | 24 ++++++++++++++++++++++++
>>>   2 files changed, 64 insertions(+)
>>>
>>> diff --git a/drivers/clk/clk-devres.c b/drivers/clk/clk-devres.c index
>>> 4fb4fd4b06bd..cbbd2cc339c3 100644
>>> --- a/drivers/clk/clk-devres.c
>>> +++ b/drivers/clk/clk-devres.c
>>> @@ -182,6 +182,46 @@ int __must_check devm_clk_bulk_get_all(struct
>>> device *dev,  }  EXPORT_SYMBOL_GPL(devm_clk_bulk_get_all);
>>>
>>> +static void devm_clk_bulk_release_all_enable(struct device *dev, void
>>> +*res) {
>>> +	struct clk_bulk_devres *devres = res;
>>> +
>>> +	clk_bulk_disable_unprepare(devres->num_clks, devres->clks);
>>> +	clk_bulk_put_all(devres->num_clks, devres->clks); }
>>> +
>>> +int __must_check devm_clk_bulk_get_all_enable(struct device *dev,
>>> +					      struct clk_bulk_data **clks) {
>>> +	struct clk_bulk_devres *devres;
>>> +	int ret;
>>> +
>>> +	devres = devres_alloc(devm_clk_bulk_release_all_enable,
>>> +			      sizeof(*devres), GFP_KERNEL);
>>> +	if (!devres)
>>> +		return -ENOMEM;
>>> +
>>> +	ret = clk_bulk_get_all(dev, &devres->clks);
>>> +	if (ret > 0) {
>>> +		*clks = devres->clks;
>>> +		devres->num_clks = ret;
>>> +	} else {
>>> +		devres_free(devres);
>>> +		return ret;
>>> +	}
>> How about:
>>
>> 	ret = clk_bulk_get_all(dev, &devres->clks);
>> 	if (ret <= 0) {
>> 		devres_free(devres);
>> 		return ret;
>> 	}
>>
>> 	*clks = devres->clks;
>> 	devres->num_clks = ret;
>>
>> Even though this patch follows the pattern used by the rest of the APIs in the
>> driver, IMO above makes it more readable.
>>
> Since I have usually seen that maintainers suggest to maintain the coding style of the file, I followed the same.
> If you have a stronger reason to change this, please let me know
> Marek, Michael, Stephen please let us know what do you think about this?

I suggest to keep the same style as is used in the modified file (if it 
doesn't conflict with the rules enforced by checkpatch and kernel's 
coding style).

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


