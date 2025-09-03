Return-Path: <linux-pci+bounces-35389-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B98B423FE
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 16:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1145D1BA2E8E
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 14:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C8420408A;
	Wed,  3 Sep 2025 14:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=orca.pet header.i=@orca.pet header.b="VcLFIlxF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtpout4.mo534.mail-out.ovh.net (smtpout4.mo534.mail-out.ovh.net [188.165.54.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181034D8D1
	for <linux-pci@vger.kernel.org>; Wed,  3 Sep 2025 14:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.54.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756910900; cv=none; b=HZUadoqoD7jazsAPxWl7OhJ6lXrOoH9ZgMxfaaeiiN+a4Vsrsm4u0RpqJZ7rlBKvJiABRTYneg93Dm1Lz++es0VqGKto3tmB+jQhgz/WxRdoLcu4KIoxV+Hio+iqLBdQQbkBxngRXROj7bE4Xfc1Bu9+lmYWMm1AkgR67eR408I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756910900; c=relaxed/simple;
	bh=K+tD++mGpOfZH6uzOxNKEeJrECtR+CMAyvWWXnMxo8c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SWMmhKEUjCNRrpGenvI9gu2XmfZnCNJ8JCUznN5jWCbWdsuglKyWH1AzAgOWndjsC1gjU4BGAq9wBjFZjv5yUrOGDh1wmTbRYLAPWwQ7M+mfpPTwntsNqeSEWZqGzZ1YUX45Jg9GaEYCOTFbp4/S7yV8D+SqTAxpAe29FDM4uDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orca.pet; spf=pass smtp.mailfrom=orca.pet; dkim=pass (2048-bit key) header.d=orca.pet header.i=@orca.pet header.b=VcLFIlxF; arc=none smtp.client-ip=188.165.54.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orca.pet
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=orca.pet
Received: from director3.derp.mail-out.ovh.net (director3.derp.mail-out.ovh.net [152.228.215.222])
	by mo534.mail-out.ovh.net (Postfix) with ESMTPS id 4cH5800ZP4z6Bwl;
	Wed,  3 Sep 2025 14:48:16 +0000 (UTC)
Received: from director3.derp.mail-out.ovh.net (director3.derp.mail-out.ovh.net. [127.0.0.1])
        by director3.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
        for <brgl@bgdev.pl>; Wed,  3 Sep 2025 14:48:15 +0000 (UTC)
Received: from mta2.priv.ovhmail-u1.ea.mail.ovh.net (unknown [10.110.168.184])
	by director3.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4cH57z6Kqyz5wFW;
	Wed,  3 Sep 2025 14:48:15 +0000 (UTC)
Received: from orca.pet (unknown [10.1.6.9])
	by mta2.priv.ovhmail-u1.ea.mail.ovh.net (Postfix) with ESMTPSA id C27273E3352;
	Wed,  3 Sep 2025 14:48:14 +0000 (UTC)
Authentication-Results:garm.ovh; auth=pass (GARM-95G001fd61621b-61d5-4f72-a2e6-6405b16da93f,
                    FA25AB0AA1A9BF3DCBEBCC83EEB30DB7881EF5C4) smtp.auth=marcos@orca.pet
X-OVh-ClientIp:79.117.41.176
Message-ID: <b11dcd50-a87e-47ff-b406-776e432f07bd@orca.pet>
Date: Wed, 3 Sep 2025 16:48:15 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] mfd: vortex: implement new driver for Vortex
 southbridges
To: Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>, Michael Walle <mwalle@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-gpio@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20250822135816.739582-1-marcos@orca.pet>
 <20250822135816.739582-4-marcos@orca.pet>
 <20250902151828.GU2163762@google.com>
 <45b84c38-4046-4fb0-89af-6a2cc4de99cf@orca.pet>
 <20250903072117.GY2163762@google.com>
 <1d4352b6-c27e-4946-be36-87765f3fb7c3@orca.pet>
 <20250903140115.GC2764654@google.com>
Content-Language: es-ES
From: Marcos Del Sol Vives <marcos@orca.pet>
In-Reply-To: <20250903140115.GC2764654@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 6138124817232582246
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefgedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeforghrtghoshcuffgvlhcuufholhcugghivhgvshcuoehmrghrtghoshesohhrtggrrdhpvghtqeenucggtffrrghtthgvrhhnpedtgedugfeiudfgkeduhfelgfejgfeuvdejffeiveegteejvddviefhiedujedvheenucfkphepuddvjedrtddrtddruddpjeelrdduudejrdeguddrudejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepmhgrrhgtohhssehorhgtrgdrphgvthdpnhgspghrtghpthhtohepkedprhgtphhtthhopegsrhhglhessghguggvvhdrphhlpdhrtghpthhtohepsghhvghlghgrrghssehgohhoghhlvgdrtghomhdprhgtphhtthhopehlvggvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmfigrlhhlvgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhushdrfigrlhhlvghijheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhinhhugidqghhpihhosehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlse
 hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphgtihesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheefgegmpdhmohguvgepshhmthhpohhuth
DKIM-Signature: a=rsa-sha256; bh=hUaRlYoluP1SLEjFJzymDSSwfKaLIPXTBwU8vyuHXIU=;
 c=relaxed/relaxed; d=orca.pet; h=From; s=ovhmo-selector-1; t=1756910896;
 v=1;
 b=VcLFIlxFp2tMBzDjpw4X+0YZl/XD0X2f0k7u7W1oJX0b5WDR14uL4noiMAnfxBr9rKj3fKOG
 kYa0rABI2W9jJAqDJnR5KLUV6xM4ml0yVRLA+1YnCdr2wXbsPAFYIAuspK1Ob8OsnqfN91kZxwN
 CiH2xeLaooKA7YgPJdqI4IgmQ/UKKoRBbOGT6lw/XevtaBGGE8tI1LVwDgbpkQiA2CxJLdr9P9C
 zew81B5t28KJYDs8p6WMejKIZeLGPgtA4ZGQw+xDd2353DRAIJGHbfqV06J+pihoa5iQCkg+PBM
 +FulApsJtss2dU9mTRkhXzwNoYLGhFfbIbYYpn7S7b+Mw==

El 03/09/2025 a las 16:01, Lee Jones escribió:
>> patch series and thus make it a proper MFD (at the cost of delaying
>> even further the GPIO inclusion), or keep the struct mfd_cell array
>> as a single-element array and implement the watchdog later on another
>> merge request, using that very same array.
>>
>> I am however not okay with wasting my time rewriting that to bypass
>> the MFD API for this, so I can waste even more time later
>> implementing again the MFD API, just because linguistically
>> one (right now) is technically not "multi".
> 
> I don't get this.  If you implement the WDT now, you will be "multi", so
> what are you protesting against?

That GPIO is something required to perform the poweroff sequence, a must
for any machine, while WDT is just a "nice to have".

Implementing now the WDT just because of a linguistic preference means
delaying something more important in favour of a "nice to have".

>> That seems very unreasonable, specially when it wouldn't be a first
>> since at least these other devices are also using MFD with a single
>> device:
>>
>>   - 88pm80
> 
> % grep name drivers/mfd/88pm800.c
> 	.name = "88pm80x-rtc",
> 	.name = "88pm80x-onkey",
> 	.name = "88pm80x-regulator",
> 	.name = "88pm800",

If you open the file, you'll see it uses five single-element arrays.

>>   - 88pm805
> 
> % grep name drivers/mfd/88pm805.c       
> 	.name = "88pm80x-codec",
> 	.name = "88pm805",
> 

Same as above.

>>   - at91-usart
> 
> % grep NAME drivers/mfd/at91-usart.c
> 	MFD_CELL_NAME("at91_usart_spi");
> 	MFD_CELL_NAME("atmel_usart_serial");

Has two single-element arrays. It registers one or the other, never both
(just like my patch does!)

>>   - stw481x
> 
> * Copyright (C) 2013 ST-Ericsson SA
> 
>>   - vx855
> 
> * Copyright (C) 2009 VIA Technologies, Inc.
> 
>>   - wm8400
> 
> * Copyright 2008 Wolfson Microelectronics PLC.
> 

To my knowledge the definition of "multi" has not been changed
since any of those years.


