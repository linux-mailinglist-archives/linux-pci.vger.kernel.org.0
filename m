Return-Path: <linux-pci+bounces-35361-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E321B4170C
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 09:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F123E18932C6
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 07:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E86E2DBF6E;
	Wed,  3 Sep 2025 07:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=orca.pet header.i=@orca.pet header.b="aXiXgkj8"
X-Original-To: linux-pci@vger.kernel.org
Received: from 12.mo533.mail-out.ovh.net (12.mo533.mail-out.ovh.net [178.33.248.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B7C2DCBEB
	for <linux-pci@vger.kernel.org>; Wed,  3 Sep 2025 07:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.33.248.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756885447; cv=none; b=cIa7Q3hrRtorov2pF4viDx8+61lDc4DySKTWWYUFcN75+cFKvYSllALb7tL5KeLNTxrwsOmWfDz6wceV1JlVCe35drh85eOSRGkfZmd4DGO+wFMWp7Lwfg9EgFcbYjABMJhff21OJ5zueUM/cdS5dXsNP3wSvXzRe7maVgcruQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756885447; c=relaxed/simple;
	bh=663KoJU1ldM4IAb3QXT68+FeZh2kwq0BYEZ09XzUgbw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VEbXhKFAUn85PoV1oQFNDEXmaa4X98OSrMt2h/+YFi2vXExppt4y3O8c8Z6p+bnnW7444AxcTxEF1SYI30WvviRWC9Uje569VWXAXGU4ILsDo64JxBmq5fmRnByaA5K7dWQDAVk9g/hALvSy8H+hIj6CbkETc0UqR7ae8mNRYuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orca.pet; spf=pass smtp.mailfrom=orca.pet; dkim=pass (2048-bit key) header.d=orca.pet header.i=@orca.pet header.b=aXiXgkj8; arc=none smtp.client-ip=178.33.248.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orca.pet
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=orca.pet
Received: from director1.derp.mail-out.ovh.net (director1.derp.mail-out.ovh.net [51.68.80.175])
	by mo533.mail-out.ovh.net (Postfix) with ESMTPS id 4cGvkM5C5Rz6S7S;
	Wed,  3 Sep 2025 07:43:55 +0000 (UTC)
Received: from director1.derp.mail-out.ovh.net (director1.derp.mail-out.ovh.net. [127.0.0.1])
        by director1.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
        for <brgl@bgdev.pl>; Wed,  3 Sep 2025 07:43:55 +0000 (UTC)
Received: from mta2.priv.ovhmail-u1.ea.mail.ovh.net (unknown [10.110.113.54])
	by director1.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4cGvkM1bbPz5vR1;
	Wed,  3 Sep 2025 07:43:55 +0000 (UTC)
Received: from orca.pet (unknown [10.1.6.5])
	by mta2.priv.ovhmail-u1.ea.mail.ovh.net (Postfix) with ESMTPSA id 11D093E3354;
	Wed,  3 Sep 2025 07:43:54 +0000 (UTC)
Authentication-Results:garm.ovh; auth=pass (GARM-99G0031b4fb290-efa1-475b-aec7-15426595f32d,
                    FA25AB0AA1A9BF3DCBEBCC83EEB30DB7881EF5C4) smtp.auth=marcos@orca.pet
X-OVh-ClientIp:79.117.41.176
Message-ID: <4057768b-82f3-4b5b-b301-afae30bd5bca@orca.pet>
Date: Wed, 3 Sep 2025 09:43:54 +0200
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
X-Ovh-Tracer-Id: 17418515985921168998
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvheejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeforghrtghoshcuffgvlhcuufholhcugghivhgvshcuoehmrghrtghoshesohhrtggrrdhpvghtqeenucggtffrrghtthgvrhhnpedtgedugfeiudfgkeduhfelgfejgfeuvdejffeiveegteejvddviefhiedujedvheenucfkphepuddvjedrtddrtddruddpjeelrdduudejrdeguddrudejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepmhgrrhgtohhssehorhgtrgdrphgvthdpnhgspghrtghpthhtohepkedprhgtphhtthhopegsrhhglhessghguggvvhdrphhlpdhrtghpthhtohepsghhvghlghgrrghssehgohhoghhlvgdrtghomhdprhgtphhtthhopehlvggvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmfigrlhhlvgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhushdrfigrlhhlvghijheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhinhhugidqghhpihhosehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlse
 hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphgtihesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheeffegmpdhmohguvgepshhmthhpohhuth
DKIM-Signature: a=rsa-sha256; bh=SBwCDNG5ruuO0roHhgmwKoJ1Cs1X4uZOY7er01eXoUI=;
 c=relaxed/relaxed; d=orca.pet; h=From; s=ovhmo-selector-1; t=1756885435;
 v=1;
 b=aXiXgkj81uCW4s1t3tuig22XwNhncczb1zlf7lPR+84igv15/kf8LVLteBOQ01F+GJOuDPKm
 hI0ZJaT0nkJzGvFgbt7vS2lnzzNMW9g4mUmfqsTRH7aT7xsw9Mb1LMZW4tkp00mYwDFFizhHY+h
 U9nozsL3rSTFfkkNM/hLQM6pzdT6bvBbubIBCakC8+Yw8ROg2MUA4r9iH0S8GBWH8GDYOwiJlTO
 SCgNcjGmH/PbAP+esraOOWqeMVC95PJRi6uIipBj7Ic6+0/dAGeIomhR7+WfQefFRMp3g+TQiR7
 MomPGPaAMDx7KrUNPSut/VtviZqyI6SXauSVYHejum7ug==

El 03/09/2025 a las 9:21, Lee Jones escribió:
>> vortex_dx_sb are "struct vortex_southbridge" type, not raw MFD API data.
> 
> I like your style, but nope!
> 
> vortex_southbridge contains MFD data and shouldn't exist anyway.

I'm not sure if I follow.

You're suggesting not using driver_data at all and using a big "if" instead,
matching manually myself on the correct cells to register against the PCI
device ID, instead of relying on PCI matching giving me already the cells
structure inside driver_data?

That seems to increase code size and be more error prone for no reason.


