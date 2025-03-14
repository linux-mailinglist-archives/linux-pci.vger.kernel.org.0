Return-Path: <linux-pci+bounces-23725-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C56CA60CA4
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 10:03:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A3277A835F
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 09:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC191E0DB3;
	Fri, 14 Mar 2025 09:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kvh2pmzS"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A254F1DE4D6;
	Fri, 14 Mar 2025 09:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741942990; cv=none; b=qJWjd779CVGQbBxF4u5NSHI/S2nP+9GZdT2bEm+XaCFBS1RtRSavAOLsFXLIM/mGUg/9dIzqC+T4mNuZPturMfw1ELYSrr5jXq8try5VOvx4nl5C90VIhalCSbNU/CM+peW/NqESn9rqbBdbxrohCtsiIxx5VRKyp6wWzHOeTBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741942990; c=relaxed/simple;
	bh=S8YV05/G2s/h65DsiUND3q2T2qUe58pxmugx0ZXN7Jk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CLHURH4d5vXU1NM0lBMf4qF4MwqX4ONEapAEBkAf/iXv2vqbLV3/9315Dy/F0LZxZ49WQW1e+eKwyJrY1rJ2egNuhieMoTRVRely+5bwSB1Z/L8rGw3gw3OmMbxs4lD0V73O1AHCTZsuIJ2D/q6EVsRvKwaSs7eF4Ne5yquHOB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kvh2pmzS; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0737B4415D;
	Fri, 14 Mar 2025 09:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741942985;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IxDTWIZSeguFxII/h+vp4Q/n1issodU5t0n062nhjZ8=;
	b=kvh2pmzSvgV1G8pTOQLE0GER4g7Rg6JnqX+5FCPeATHnu4apFryWeq4h4e99XsPsvRhV+b
	d1e5uo9Xn+ddHKrhTETWynLW0p2V0SLnY6JePKcSnoGBAldlXO/ZmxINYwzlcfm6ERHbHJ
	jZKflPyalMr9ZG+npnqDsie7GBYchMZSaUMkbMFltCFDfL2ykoWdV4wGvHf7I46nq/sDa/
	YuujSxq8by2gqoRijOSTo1JBSFP+XNtM8t8XKpFUcgWljTgbJIKY16AYYFm1goIHnEDuWR
	h1pgDMGoWSIWbCvfJSp/LyAzjcT7NY1HroG2oZvPGCmLoXgpx0kn9EEhgNAbyA==
Message-ID: <88b3ecbe-32b6-4310-afb9-da19a2d0506a@bootlin.com>
Date: Fri, 14 Mar 2025 10:03:01 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] PCI: j721e: Add support to build as a loadable module
To: Siddharth Vadapalli <s-vadapalli@ti.com>, lpieralisi@kernel.org,
 kw@linux.com, manivannan.sadhasivam@linaro.org, robh@kernel.org,
 bhelgaas@google.com, vigneshr@ti.com, kishon@kernel.org, cassel@kernel.org,
 wojciech.jasko-EXT@continental-corporation.com, bwawrzyn@cisco.com
Cc: linux-pci@vger.kernel.org, linux-omap@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 srk@ti.com
References: <20250307103128.3287497-1-s-vadapalli@ti.com>
 <20250307103128.3287497-5-s-vadapalli@ti.com>
Content-Language: en-US
From: Thomas Richard <thomas.richard@bootlin.com>
In-Reply-To: <20250307103128.3287497-5-s-vadapalli@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufedtgedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomhepvfhhohhmrghsucftihgthhgrrhguuceothhhohhmrghsrdhrihgthhgrrhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeeuhefgfeehveeggfeggfekhfehgfffkeeghfeuffeikeekjeehkeetvedthedtieenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepvdgrtddumegtsgdugeemfhegtdemsghftddtmehftdehgeemtgeltgdvmedvudgtfeemudehieeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemfhegtdemsghftddtmehftdehgeemtgeltgdvmedvudgtfeemudehieeipdhhvghloheplgfkrfggieemvdgrtddumegtsgdugeemfhegtdemsghftddtmehftdehgeemtgeltgdvmedvudgtfeemudehieeingdpmhgrihhlfhhrohhmpehthhhomhgrshdrrhhitghhrghrugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudejpdhrtghpthhtohepshdqvhgruggrphgrlhhlihesthhirdgtohhmpdhrtghpthhtoheplhhpihgvrhgrl
 hhishhisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkfieslhhinhhugidrtghomhdprhgtphhtthhopehmrghnihhvrghnnhgrnhdrshgrughhrghsihhvrghmsehlihhnrghrohdrohhrghdprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghhvghlghgrrghssehgohhoghhlvgdrtghomhdprhgtphhtthhopehvihhgnhgvshhhrhesthhirdgtohhmpdhrtghpthhtohepkhhishhhohhnsehkvghrnhgvlhdrohhrgh
X-GND-Sasl: thomas.richard@bootlin.com

> +
> +	if (pcie->reset_gpio) {
> +		msleep(PCIE_T_PVPERL_MS);
> +		gpiod_set_value_cansleep(pcie->reset_gpio, 1);
> +	}
> +
> +	if (pcie->refclk)
> +		clk_disable_unprepare(pcie->refclk);
>  

Hello Siddharth,

I think clk_disable_unprepare() is a no-op if the clock is NULL, so the
if statement is useless.

https://elixir.bootlin.com/linux/v6.14-rc6/source/include/linux/clk.h#L1157
https://elixir.bootlin.com/linux/v6.14-rc6/source/drivers/clk/clk.c#L1237
https://elixir.bootlin.com/linux/v6.14-rc6/source/drivers/clk/clk.c#L1099

Regards,

Thomas



