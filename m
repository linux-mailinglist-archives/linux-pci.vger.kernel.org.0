Return-Path: <linux-pci+bounces-34484-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE47AB300BA
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 19:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 031D45C47F5
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 17:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2772FB62C;
	Thu, 21 Aug 2025 17:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=orca.pet header.i=@orca.pet header.b="gT47ww/W"
X-Original-To: linux-pci@vger.kernel.org
Received: from 12.mo534.mail-out.ovh.net (12.mo534.mail-out.ovh.net [46.105.38.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A3E2FB61B
	for <linux-pci@vger.kernel.org>; Thu, 21 Aug 2025 17:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.105.38.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755795923; cv=none; b=k/fndWR2QS4SlOdDxIKw6KWN7T681+d5pWpd6FRTlX7857WK15INuLTInR9c8gLxVGJSvPbLhMZoGxPpptOfZheC7k9SYzhDKfADRWoh8gm/8+4dNRY3uZJsjoGAf2R7J0UkHeOPdMcKZmSSVVg27IlopbUiJ9wo0vzujkRDMfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755795923; c=relaxed/simple;
	bh=QgU9tu/W2io/RCY4ppncl3O2EgTk2wEYw1UC+4Z8TSk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NJM0VZST3d6KyBlUu/9+Jj8K7Swa6vi+/9O1aulSkw70oOxTo3TZIMwYXbookvD4aDhNOb8hDcUHzhvjij7pvgGvyFo16CkWeoBTxzQruxHS6/3YmMDqceSk3Q3TFuRXaYo3IR1FfNVyaa4ALvrHKC5ElqjaY1EDnPdC3dd7tgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orca.pet; spf=pass smtp.mailfrom=orca.pet; dkim=pass (2048-bit key) header.d=orca.pet header.i=@orca.pet header.b=gT47ww/W; arc=none smtp.client-ip=46.105.38.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orca.pet
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=orca.pet
Received: from director4.derp.mail-out.ovh.net (director4.derp.mail-out.ovh.net [79.137.60.37])
	by mo534.mail-out.ovh.net (Postfix) with ESMTPS id 4c78p55kQpz6Fxs;
	Thu, 21 Aug 2025 17:05:17 +0000 (UTC)
Received: from director4.derp.mail-out.ovh.net (director4.derp.mail-out.ovh.net. [127.0.0.1])
        by director4.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
        for <brgl@bgdev.pl>; Thu, 21 Aug 2025 17:05:17 +0000 (UTC)
Received: from mta11.priv.ovhmail-u1.ea.mail.ovh.net (unknown [10.110.0.156])
	by director4.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4c78p53dvWz1xq5;
	Thu, 21 Aug 2025 17:05:17 +0000 (UTC)
Received: from orca.pet (unknown [10.1.6.7])
	by mta11.priv.ovhmail-u1.ea.mail.ovh.net (Postfix) with ESMTPSA id 23CD09A32E5;
	Thu, 21 Aug 2025 17:05:15 +0000 (UTC)
Authentication-Results:garm.ovh; auth=pass (GARM-96R0019a5e68ea-a039-46b1-a0f6-7359794a6edd,
                    684E78C7C579463DAB27E2CA1F9C4E28A39E1181) smtp.auth=marcos@orca.pet
X-OVh-ClientIp:79.117.22.109
Message-ID: <87f12a9e-df99-4308-9d4b-6dd28911bd00@orca.pet>
Date: Thu, 21 Aug 2025 19:05:16 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] gpio: vortex: add new GPIO device driver
To: linux-kernel@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>, Michael Walle <mwalle@kernel.org>,
 Lee Jones <lee@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-gpio@vger.kernel.org, linux-pci@vger.kernel.org
References: <20250821101902.626329-1-marcos@orca.pet>
 <20250821101902.626329-3-marcos@orca.pet>
Content-Language: es-ES
From: Marcos Del Sol Vives <marcos@orca.pet>
In-Reply-To: <20250821101902.626329-3-marcos@orca.pet>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 5894367491258930790
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduiedujeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeforghrtghoshcuffgvlhcuufholhcugghivhgvshcuoehmrghrtghoshesohhrtggrrdhpvghtqeenucggtffrrghtthgvrhhnpedtgedugfeiudfgkeduhfelgfejgfeuvdejffeiveegteejvddviefhiedujedvheenucfkphepuddvjedrtddrtddruddpjeelrdduudejrddvvddruddtleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepmhgrrhgtohhssehorhgtrgdrphgvthdpnhgspghrtghpthhtohepkedprhgtphhtthhopegsrhhglhessghguggvvhdrphhlpdhrtghpthhtohepsghhvghlghgrrghssehgohhoghhlvgdrtghomhdprhgtphhtthhopehlvggvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmfigrlhhlvgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhushdrfigrlhhlvghijheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhinhhugidqghhpihhosehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvg
 hlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphgtihesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheefgegmpdhmohguvgepshhmthhpohhuth
DKIM-Signature: a=rsa-sha256; bh=QgU9tu/W2io/RCY4ppncl3O2EgTk2wEYw1UC+4Z8TSk=;
 c=relaxed/relaxed; d=orca.pet; h=From; s=ovhmo-selector-1; t=1755795918;
 v=1;
 b=gT47ww/WK/fMjYX2DlJdT3n7yhOSJ9EFYWvYDemT+pQ2ZhuTRnb1mTISXHLkkK7TOsucCgjA
 07BK+CbDCs3rfE3AUX8wUMKMNysv9qAmaYEs8G2EQHRBunofa8qApqbjOgt1mb5arLh24QkeAVM
 4rTVzYvJZO/31DDD3IUZtEWW1naZQ39trZ6F6dTYN2LPoHwD5ebpgVgZ8DciaQYe+hCO94YYInj
 CAqrDVfMqXRnf/0QKk6FO9TqBEWFJTEJHRqeop0nvDoDPFfjCpdEFlQthA7656xraUxR6KrIVxI
 x1h2vbunQ4M+wsUb5qvUWRGd5WROetqtwnbOqEdZ7JBJg==

El 21/08/2025 a las 12:18, Marcos Del Sol Vives escribió:
> +#include <linux/types.h>
> +#include <linux/errno.h>
> +#include <linux/module.h>
> +#include <linux/ioport.h>
> +#include <linux/spinlock.h>
> +#include <linux/gpio/driver.h>
> +#include <linux/gpio/regmap.h>
> +#include <linux/regmap.h>
> +#include <linux/ioport.h>
> +#include <linux/types.h>
> +#include <linux/platform_device.h>

I realized now that, despite checking over and over the patches before
sending to the mailing list, I forgot to clean up leftover includes from
previous versions of the driver.

I am fairly new to this procedure of merging patches. Should I later, after
a send a sensible amount of time has passed to let everyone voice their
opinion, send a new v4 version of the patch to fix these (and also clarify
the commit message on the regmap-gpio, as requested in another email),
or if accepted would maybe the person merging it sort this out?

Sorry for the mess,
Marcos

