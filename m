Return-Path: <linux-pci+bounces-32181-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27550B064C6
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 19:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C27F5672A8
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 17:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E378015B54A;
	Tue, 15 Jul 2025 17:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Zj9mWXMU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8A11DFCE;
	Tue, 15 Jul 2025 17:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752598885; cv=none; b=ZbaS7bcqh4OOBqMD0CSzeiRxtAsYGvFpWrZVXoYbq4lQHL9jyVVGAi+nK+gLz7BXGWAmRGgGYRJ5mku5p0SvP4ZtLoGT70Cz5HCRln6EBvbXSAl3aAvl2LQ4w4712YcLE/FqiUntboZoqQIyTXFjSo/KE8cgT4srlFb+Fd0/suc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752598885; c=relaxed/simple;
	bh=YAgbG08mQ7J/VHIClHqriwrgYCXz+Oibf7DZS2f/O4o=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=s7sLTeluYSd208NLbXABDy+8lIqxAipjN7Y6FmYyWr0BzlLxKVxfb9x9XL3yyuHSo+xUT/iohEUgvEd5Cj+9pbBMgASf7b4shFqI0YAqMYbdzyX2TMab/gFznum9wMe7Jsgl+5ZDZqNm/UdKo76LuWy/XOU64innZXy4TryXJr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Zj9mWXMU; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1752598840; x=1753203640; i=markus.elfring@web.de;
	bh=rGs/l04TD5R/3ve+iKBgA47mAtv6wQTleh/5nWpeFXY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Zj9mWXMUqbHUj5UttK3QGJjbuppTk+KdkSUpZ1PM7Bgeoddv4RJIpmIPnnwUU0xp
	 +VKV3GOju/NjT0///k/+6Z1L1wQPKi+UqO1sQVAHRiDVsOAtPGKAnA69RH6KQlCTs
	 RqD900npnnx7LTslGLgrGAWkKTuJdbALPD+OZElm/Ts41dyLh9ogI0cA3IoqNPfGW
	 dTf4mLS9FbhhzisTlBqYobRTijANMW23+ZQ0RNuldno8d0OgteIQTVbjGTuGZkFNx
	 IieZRsO0Uwu2LzIkNpThM4vMTnZXDBxzHrjrxCjYFtprdX0KLdzvxGgcFSQC2DBCN
	 P2JlXXiz8aSF73FGww==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.1]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MQPdr-1uG5Qf1ZaL-00VKQl; Tue, 15
 Jul 2025 19:00:40 +0200
Message-ID: <8fe0f561-ef44-4ec2-9b93-f73105bd67ed@web.de>
Date: Tue, 15 Jul 2025 19:00:27 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jacky Chou <jacky_chou@aspeedtech.com>, linux-aspeed@lists.ozlabs.org,
 linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Bjorn Helgaas <bhelgaas@google.com>, Conor Dooley <conor+dt@kernel.org>,
 Joel Stanley <joel@jms.id.au>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, openbmc@lists.ozlabs.org,
 BMC-SW@aspeedtech.com
References: <20250715034320.2553837-10-jacky_chou@aspeedtech.com>
Subject: Re: [PATCH v2 09/10] PCI: aspeed: Add ASPEED PCIe RC driver
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250715034320.2553837-10-jacky_chou@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PoiZJ9fSzSlWKLh1vwNyOAzkuNF7hTRNV71wlCsQn9g9VWcuxTx
 nT8JNwaatT96O2Duhbk0shm1AnqD4uQPhFU12ISegzxBQZh3+6CXUa5B7lNmbliSmSeZm8S
 G4xWGpI8d1VQASPeeVwHpTZK5ZBwxPjT7anBgPmC4d2Tui/pGWvOVuFtKIpaPfsuZYgmH0J
 v9SrV1YYB8SF8bevLSxeA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:l7+GOJ6r/JI=;1sd4JOf/kjylVk4WVzZqgERQhZF
 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
 aWM3kKNw0AE8xw=

=E2=80=A6
> +++ b/drivers/pci/controller/pcie-aspeed.c
> @@ -0,0 +1,1137 @@
=E2=80=A6
> +static int aspeed_irq_msi_domain_alloc(struct irq_domain *domain,
> +				       unsigned int virq, unsigned int nr_irqs,
> +				       void *args)
> +{
=E2=80=A6
> +	mutex_lock(&pcie->lock);
> +
> +	bit =3D bitmap_find_free_region(pcie->msi_irq_in_use, MAX_MSI_HOST_IRQ=
S,
> +				      get_count_order(nr_irqs));
> +
> +	mutex_unlock(&pcie->lock);
=E2=80=A6

Under which circumstances would you become interested to apply a statement
like =E2=80=9Cguard(mutex)(&pcie->lock);=E2=80=9D?
https://elixir.bootlin.com/linux/v6.16-rc6/source/include/linux/mutex.h#L2=
25

Regards,
Markus

