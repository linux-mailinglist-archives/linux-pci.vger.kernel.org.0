Return-Path: <linux-pci+bounces-10165-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4E992EC58
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2024 18:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0040E1F22B1D
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2024 16:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6FDF16C857;
	Thu, 11 Jul 2024 16:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="rVVHP500"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DA315957E;
	Thu, 11 Jul 2024 16:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720714217; cv=none; b=XUUt/G5D6x7HmmXeqQHnqLg9axlZloKs8nRrQCNhnjK8m1t60gLy/yg+B8T8/JHMQRsuDd24tw1an0PjLDzZjb6L39aTESkr9YG+IFNZ1VseUheA9AiP+UeU5AMmOJIOCrhxbHMMnjCfQfBT9x3hgzHvUdwXGxiHEZlb2CleMQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720714217; c=relaxed/simple;
	bh=toos/atAMxpoRk1QwVzwIn/xX8NOj8ffSwRiozlKcbQ=;
	h=Message-ID:Date:MIME-Version:To:References:Subject:From:Cc:
	 In-Reply-To:Content-Type; b=QlZQ9jCVgFEFIZ5fw0hcJ9oMb6SPOewOg/5KmCC1hI+foJ237eS5SqMtKGNLDE4LXyUwd+Z2wQR+cT0BGyqtowFW0GCAyCfDE99Da/hvfefr4Dv04DoBkR0FoL5vgyjMpQIjXnDQmUHNZMQbklqAYT7GCgN1v2MSJizhZVU1j3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=rVVHP500; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1720714178; x=1721318978; i=markus.elfring@web.de;
	bh=iCA+wBBrDEg85srNLY95LSkrYDhC1QURR+TnrO0mB7U=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:References:
	 Subject:From:Cc:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=rVVHP50064H3+NxqWnBBbLlsmJUgKEtW3UUIn0sX6hPrgvYM1R4yuk2oKp7i+Y+5
	 tyfL1TpDF8L52wT0a3hRXYjVSL1P7ZcSZ7vPvzcfLyS5DEw59Jtw8cIVSRgRVSzlN
	 CaHhrWpMZ4jNl5i9ed3mzjoYKQ0vqzptTWOvLxoTjTEfCATlR8hVF8yD76z2xC2s0
	 WVzDHw/TJNhyVHhgYbXYSDWfZp56x6BVyo0ItJ3AYJ77sOTnOdU66ZnP3gO5BHpl1
	 iYjGfgou8UiPltcWBQPbBV0dTWUdK58OiRCFc87VkdxP4ijB5IyfBJio1AHX5YrPS
	 1lB0UXOYL3SX1hiGYw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MLzn1-1sjsih2sAD-00M8X2; Thu, 11
 Jul 2024 18:09:38 +0200
Message-ID: <91cfc410-744f-49f8-8331-733c41a43121@web.de>
Date: Thu, 11 Jul 2024 18:09:26 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>,
 Herve Codina <herve.codina@bootlin.com>, devicetree@vger.kernel.org,
 linux-pci@vger.kernel.org, netdev@vger.kernel.org,
 UNGLinuxDriver@microchip.com, linux-arm-kernel@lists.infradead.org,
 Andy Shevchenko <andy.shevchenko@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
 Bjorn Helgaas <bhelgaas@google.com>, Conor Dooley <conor+dt@kernel.org>,
 Daniel Machon <daniel.machon@microchip.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Lars Povlsen <lars.povlsen@microchip.com>, Lee Jones <lee@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>,
 Saravana Kannan <saravanak@google.com>, Simon Horman <horms@kernel.org>,
 Steen Hegelund <Steen.Hegelund@microchip.com>
References: <20240627091137.370572-2-herve.codina@bootlin.com>
Subject: Re: [PATCH v3 1/7] mfd: syscon: Add reference counting and device
 managed support
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Allan Nielsen <allan.nielsen@microchip.com>, Andrew Lunn <andrew@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Horatiu Vultur <horatiu.vultur@microchip.com>,
 Jakub Kicinski <kuba@kernel.org>, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Paolo Abeni <pabeni@redhat.com>,
 Steen Hegelund <steen.hegelund@microchip.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
In-Reply-To: <20240627091137.370572-2-herve.codina@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LFxBbBSDsYV2z0yRm6Y6oG29nFJqIo210Cv0lweQhRokoOaMp2c
 5IeyRxm67QFt5Y7Kojegg5OSD8tkKd7cq3tnAlbxWNukHx/4YKeDX3rhdrZ/sKghJaq923J
 O2zNJ9p/wKlhm/m5firh2qWJlH5tKas6Mkctf7fVwpFX3hlLTA6e3Hi5lI7yVgvZQsU50SS
 b8WAsD4LmYcDCTtg6J2lw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:67zTDbbpL1Y=;r8OJ82Rzrd5kNER/6Bwtek2zluy
 EEiPx4/efkk2tspOBTpJqtkZJ7zHi47ROcfdLPW9GPGf0mRGZ/QZ8R+5MgQym8MT/SoaHOhGJ
 VL7y3ItFOn45TFVHkQoKx2MBjG8+vjFle8ksRxHqslQZn4WY1jaBq8gk/smnklDS5XTQNESw4
 ypOUWNNPNicq+wdJcTdqBEjCXCohmB4JIPSJwCRU5ptM6x6X3FaQKLcWgTb6qX9EDF7zXt3IN
 GWukiV7uncVinK648zXKgI8gArw+dK2++f7gtpBf0OLCynRSgvcL7E04S2meNm3Tmct1+e4NC
 CnxyJGxLYkhDm9PPn+4vtArcTJy6jQR+c46dQ+aF7ODGtm6IYKMrhkYdWdMR6UXdyr+EUC0Au
 uDBprMwxw6s0PXckmi3vbZEh0dmz+HQh6lRzYCJqvu0qezIoGoAx81/Ox9H+nt+vxPqNoGHz7
 GI5NkRazUiDO2Fc5UbHkSHYTGpoMP9E+iE3npQ6PsGFjWVcX1P/K6Yf6MhS4Z6HX1YmDbDF7v
 9Y9nLnh30Zhj9RAtlif45fFXEBUskZA4VY/iBduY4881M/U/+3qUt0djrQvwDWYuX322w1xDo
 cLG2s3ac7K75p4qFa4XkJBxolm8J7Id5roCQrYoFwLaWklxaWHkfsqLsohgjKhXr+R/k3gNB5
 1boR3x1dyK4Ngu0YXXt7ZNIqoaID6pQ0Yh19CBo0dnz0MTHhOB3NGbZ0419d+HD8p0rFbne7t
 S13hVp+2Rn5u7xt6sInh0J7frMYrJfBE2NUDT8KX2k2riV53B9Vyu4ErhO01Wic5CooymJUOo
 TRWQsnSINZ3uUaoBpp14nOhg==

=E2=80=A6
> +++ b/drivers/mfd/syscon.c
=E2=80=A6
> +static struct syscon *syscon_from_regmap(struct regmap *regmap)
+{
> +	struct syscon *entry, *syscon =3D NULL;
> +
> +	spin_lock(&syscon_list_slock);
> +
> +	list_for_each_entry(entry, &syscon_list, list)
=E2=80=A6
> +	spin_unlock(&syscon_list_slock);
> +
> +	return syscon;
> +}
=E2=80=A6

Under which circumstances would you become interested to apply a statement
like =E2=80=9Cguard(spinlock)(&syscon_list_slock);=E2=80=9D?
https://elixir.bootlin.com/linux/v6.10-rc7/source/include/linux/spinlock.h=
#L561

Regards,
Markus

