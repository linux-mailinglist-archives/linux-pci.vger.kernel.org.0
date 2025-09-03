Return-Path: <linux-pci+bounces-35381-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DACEAB42048
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 15:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83A133BC254
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 13:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78FF0306497;
	Wed,  3 Sep 2025 13:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=orca.pet header.i=@orca.pet header.b="JWDf6Kky"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtpout7.mo534.mail-out.ovh.net (smtpout7.mo534.mail-out.ovh.net [54.36.140.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A752E30506B;
	Wed,  3 Sep 2025 13:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.36.140.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756904475; cv=none; b=lRKhlNxAxm/F4tGm7D7IyKzO/fGXb9i6W7A21yidzjrtavUaX2neG4e3dOyneoWGuUHLwqialu7j1nQCwV9i5gX9it1w8WdvHeHIhu5qBIdtgIby9tEFzCiF+vtmMw21k2hUD78rlB9jZJGqp1bmM6JOMldSeh/SUr2G78SsW9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756904475; c=relaxed/simple;
	bh=p2F/eIS0QcEmDXwi51oLWoydhQyqbtmNUe1gVZQdqZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HfHmJEArwTxH1ks49+N3+drze1lhnwiFIn04xf+6ZNrWl3dKt/BYTSyoZaONiR5TZ2TUPDJ9+6wWF6D7NxG14mlb3g9oku15k2VUk0NMGOwk6EYvef7iBK7Nwdb2ulv+BrALRpRkzyjUXIJHvE882jgqa+OeWJ1nMdT4/aduCPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orca.pet; spf=pass smtp.mailfrom=orca.pet; dkim=pass (2048-bit key) header.d=orca.pet header.i=@orca.pet header.b=JWDf6Kky; arc=none smtp.client-ip=54.36.140.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orca.pet
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=orca.pet
Received: from director3.derp.mail-out.ovh.net (director3.derp.mail-out.ovh.net [152.228.215.222])
	by mo534.mail-out.ovh.net (Postfix) with ESMTPS id 4cH2mP475nz6G5w;
	Wed,  3 Sep 2025 13:01:09 +0000 (UTC)
Received: from director3.derp.mail-out.ovh.net (director3.derp.mail-out.ovh.net. [127.0.0.1])
        by director3.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
        for <brgl@bgdev.pl>; Wed,  3 Sep 2025 13:01:09 +0000 (UTC)
Received: from mta11.priv.ovhmail-u1.ea.mail.ovh.net (unknown [10.109.254.114])
	by director3.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4cH2mP2VpLz5wDH;
	Wed,  3 Sep 2025 13:01:09 +0000 (UTC)
Received: from orca.pet (unknown [10.1.6.10])
	by mta11.priv.ovhmail-u1.ea.mail.ovh.net (Postfix) with ESMTPSA id 50ED69A3372;
	Wed,  3 Sep 2025 13:01:08 +0000 (UTC)
Authentication-Results:garm.ovh; auth=pass (GARM-102R00448deb2aa-b531-4c52-94ae-66cd8690eed4,
                    FA25AB0AA1A9BF3DCBEBCC83EEB30DB7881EF5C4) smtp.auth=marcos@orca.pet
X-OVh-ClientIp:79.117.41.176
Message-ID: <1d4352b6-c27e-4946-be36-87765f3fb7c3@orca.pet>
Date: Wed, 3 Sep 2025 15:01:08 +0200
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
Content-Language: es-ES
From: Marcos Del Sol Vives <marcos@orca.pet>
In-Reply-To: <20250903072117.GY2163762@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 4329366619220956774
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefvddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeforghrtghoshcuffgvlhcuufholhcugghivhgvshcuoehmrghrtghoshesohhrtggrrdhpvghtqeenucggtffrrghtthgvrhhnpedtgedugfeiudfgkeduhfelgfejgfeuvdejffeiveegteejvddviefhiedujedvheenucfkphepuddvjedrtddrtddruddpjeelrdduudejrdeguddrudejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepmhgrrhgtohhssehorhgtrgdrphgvthdpnhgspghrtghpthhtohepkedprhgtphhtthhopegsrhhglhessghguggvvhdrphhlpdhrtghpthhtohepsghhvghlghgrrghssehgohhoghhlvgdrtghomhdprhgtphhtthhopehlvggvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmfigrlhhlvgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhushdrfigrlhhlvghijheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhinhhugidqghhpihhosehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlse
 hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphgtihesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheefgegmpdhmohguvgepshhmthhpohhuth
DKIM-Signature: a=rsa-sha256; bh=pIcdeBl1BsJ7Lz6IRl88IkXilGWBPO5XQGiMVh354tQ=;
 c=relaxed/relaxed; d=orca.pet; h=From; s=ovhmo-selector-1; t=1756904469;
 v=1;
 b=JWDf6KkyiEx7fYs4PJBjFRlnibM6E4eDNBHH81HwR2FbVSjZYGG+tpsCDnyl1+sPx8SQbHGi
 LgH432kDEPPJBZNM3oMykDjzfFTn+9f49YV/lSaai8EDuk65R6heWYVv5aUmVCRMaiJrtNDy+xx
 vIyY9ETxMFOQCnoHrBgEIQgEaqx8mqS/j0hNEkOC/5RVV9ZjN+oB6ZOttKWb+XBq1HabCoN6+fr
 2/1zi2kHslIK3Ai9Xihfk6bvUsHL3CmDngCoRxEipgAimHHECkL6xpB1Ocbjwg91BxANT200GbC
 QQngbFiHDqbYI2g8Q40xmQ4GGKbtLEeSv3mncYS6ufHCw==

El 03/09/2025 a las 9:21, Lee Jones escribió:
>>>> +static const struct mfd_cell vortex_dx_sb_cells[] = {
>>>> +	{
>>>> +		.name		= "vortex-gpio",
>>>> +		.resources	= vortex_dx_gpio_resources,
>>>> +		.num_resources	= ARRAY_SIZE(vortex_dx_gpio_resources),
>>>> +	},
>>>> +};
>>>
>>> It's not an MFD until you have more than one device.
>>
>> Same as above.
> 
> It will not be accepted with only a single device (SFD?).
> 

I've been working on making all the changes, except this one.

If you prefer, I can either implement the watchdog now, add it on this
patch series and thus make it a proper MFD (at the cost of delaying
even further the GPIO inclusion), or keep the struct mfd_cell array
as a single-element array and implement the watchdog later on another
merge request, using that very same array.

I am however not okay with wasting my time rewriting that to bypass
the MFD API for this, so I can waste even more time later
implementing again the MFD API, just because linguistically
one (right now) is technically not "multi".

That seems very unreasonable, specially when it wouldn't be a first
since at least these other devices are also using MFD with a single
device:

  - 88pm800
  - 88pm805
  - at91-usart
  - stw481x
  - vx855
  - wm8400
  - zynqmp (last changed in 2024, so certainly not legacy!)

And probably others since I did not look too deep into it.

Greetings,
Marcos


