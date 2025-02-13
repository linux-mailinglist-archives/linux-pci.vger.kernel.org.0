Return-Path: <linux-pci+bounces-21378-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92005A34E22
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 19:59:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17FCA3A8B99
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 18:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DEB7245AF2;
	Thu, 13 Feb 2025 18:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="IJZKY+63"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB8F28A2D4
	for <linux-pci@vger.kernel.org>; Thu, 13 Feb 2025 18:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739473192; cv=none; b=OoVBMMr/DM0ZSQ1WAh9nVO92Jgr+RYjFIaoFXr6runsSzyIgp5R/FpD917THUnQ4uHxNDCBH8qpVIPv9qAENiWh5l9rB+BKK0h24T830XzR0HeFAA+U7Wh+mWykuW5w1ux0QgpA3ygabkYjtC8U2shL9O6RJNlr+Lu1/WZD+4vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739473192; c=relaxed/simple;
	bh=/nd/5gfXcMU1IUa5W8s/miB7hQlVuT4WVhzTKPTuK1Y=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Ryg2THxj7x6T8aFBEKosaGtSA8267Q+KolDFYJHSMydX9RYTYMvlmE1ESl4uxShz44prQDExXgTPOamLKadfKS45dhJTtiqc79uXtc2XTvmodolH/tpUcx5m8PYNhWuFOrevNfpcc6VIynAb6/dlbeJ6BSQilKqO82t6leFUal4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=IJZKY+63; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1739473179; x=1740077979; i=wahrenst@gmx.net;
	bh=/nd/5gfXcMU1IUa5W8s/miB7hQlVuT4WVhzTKPTuK1Y=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=IJZKY+63kgenIcB6bFyBILvnueIhQvgLOrQBJBRC2GMfX8pN/eGJ8XybU4aB7v6U
	 57Zr2P+gUFqHYrAZvP98sZkLp4GuOYFJvbkkVymhQ0oAQmBOk5RR7q29P8wTy3lWY
	 qENZS0ZYLrE9SflHRHD+ALuVnCg8j2eR9thZjmxtRhBHdZnZ30ayZz2riVH2LG1/Y
	 oDCnkPPNLDMxmXU5AKgr/Y+FuV+F1Fe3snD4WZiL+ieDZarL9qu4IEUcTHZLcOdQo
	 cn4qXRbZJWFYVuDdnRDtPwTJ0t7Yk0mPKgihkUuIb6z8w20W7WDcg2a9uJX+8tRP0
	 bxCcyzu2BHeawGoESg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.107] ([37.4.251.153]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MdvqW-1t7wq530Ao-00h3kX; Thu, 13
 Feb 2025 19:59:39 +0100
Message-ID: <9d7ddfdd-4355-4566-a160-770c661281a0@gmx.net>
Date: Thu, 13 Feb 2025 19:59:38 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: brcmstb: Adjust message if L23 cannot be entered
From: Stefan Wahren <wahrenst@gmx.net>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Jim Quinlan <jim2101024@gmail.com>,
 Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org,
 bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
 Jonathan Bell <jonathan@raspberrypi.com>
References: <20250201121420.32316-1-wahrenst@gmx.net>
 <20250208102748.2aytlzgzbvm6u4vi@thinkpad>
 <32e74c11-d6cb-4c42-b9e0-a52bab608c16@gmx.net>
Content-Language: en-US
Autocrypt: addr=wahrenst@gmx.net; keydata=
 xjMEZ1dOJBYJKwYBBAHaRw8BAQdA7H2MMG3q8FV7kAPko5vOAeaa4UA1I0hMgga1j5iYTTvN
 IFN0ZWZhbiBXYWhyZW4gPHdhaHJlbnN0QGdteC5uZXQ+wo8EExYIADcWIQT3FXg+ApsOhPDN
 NNFuwvLLwiAwigUCZ1dOJAUJB4TOAAIbAwQLCQgHBRUICQoLBRYCAwEAAAoJEG7C8svCIDCK
 JQ4BAP4Y9uuHAxbAhHSQf6UZ+hl5BDznsZVBJvH8cZe2dSZ6AQCNgoc1Lxw1tvPscuC1Jd1C
 TZomrGfQI47OiiJ3vGktBc44BGdXTiQSCisGAQQBl1UBBQEBB0B5M0B2E2XxySUQhU6emMYx
 f5QR/BrEK0hs3bLT6Hb9WgMBCAfCfgQYFggAJhYhBPcVeD4Cmw6E8M000W7C8svCIDCKBQJn
 V04kBQkHhM4AAhsMAAoJEG7C8svCIDCKJxoA/i+kqD5bphZEucrJHw77ujnOQbiKY2rLb0pE
 aHMQoiECAQDVbj827W1Yai/0XEABIr8Ci6a+/qZ8Vz6MZzL5GJosAA==
In-Reply-To: <32e74c11-d6cb-4c42-b9e0-a52bab608c16@gmx.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4rWendT3pV7M7NlsNAN6t6aKca3ubIAEt/gYl9HBqnf2VCkrBSl
 yexGxnSIMbufue+3tAxCAAUFgT4eoUp/2AKETSSjIeBi5npSYdae4u/ibJFGlLLAKFKUzbg
 mMB8+5lIgf42PdEabSlVZjEjouAiVgKwXnzW3BU9AQJnROhpkJoFM7Pc6UeMXT8rLNwWUPz
 Rh8IggHkAI6DzytaDUTyw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ziQnUMDK6VI=;usnJPMjAZ4M8E1i6bsX5Dh0+juY
 K/XFRbPPbx/qLKsiXSQpzdKwT/QofqwBW636Y8nLkYh/kN4h2Qg3aCYfmChII8gVzfBiD6aX4
 /Vh4QQHrX57poaL3MGIZjcbvMdDPXISbk9wEZzq+bns8Ex3UajZh/A94XtC/1mfvCKSNCyUXK
 USFNWpU7a2jePenVmOr7YtbuKrmb1iaVTq9zG3oJd/Ry8iVKcNsYpZXa2HI3qrawVKeQS2nhM
 5yIzw0ety6oKtdv2RCGuhq9xyhRJ4bD7OeRzxBxZFutbQQC602Jsnyq1QfJTh+jf9CsDjcdF4
 bxtwx7BlzPcOlSfdNl66aIV9+x28XGw/NK9kauoAZ7ejp4XTLoCBtb0v9bXw4QUdw11tg/Eol
 sySMnlLWBdcLe8uhN8S1Wi+I9ZAU0dO1my5TWp1yXzlrNwZxb4WoQKPKTKipYTWIhXCdVsJ9k
 qsPSVsty4rBBVcEZnHiOFhYscOfXlGyQkjjyScllJnIRfIoiTddSNr+g5Tl0zDVGa+IjOcg1x
 YacJtraeIJZUPt2lOgkzMino9aBu9FnAgj03WSkQ33LAy3A+CImFn3VEBkXVKhrpMfzIWawB7
 fp5lcuIXmBiKe0eleWlD0jtUhNpSjOOtTMBapc28h/nLtd0L9L8Hsvdy8glAHRuo+3WAGZnEh
 PNIUhTwXGQVd61ylaqtXQJemro5cRGFO6wP+ZEuuegE8zJ0gK4hbj/O/z5IjX2PzMu5OjJAhT
 fZi3Ol04ld3Flx2uvvF5YWGEw5nYAxy1cwCTWRnoJQAt7B9kT8Vr9rpfMLf4z1QvZJIOwazGT
 fZXPgW4pxdIRmB0ZCu8g1IFY4mQMLDxNvqtRgQfZADmKf7SHCwrP5uRbxUWDqCnqMEuARboDA
 9o4vTtpR9wwVbHQtKK4PuIp+HpxDDIckWJvM+lVO3shK7yoMHlGgQJaTkREn99PBPYXpmoQ54
 5JMsGHzyle1N1EAEYNGEXrsGpzzUTujTXnqsqmBlQHjoWO1Of9YkWhgeTylTRPF27HbFWW1mw
 sOoz3IYppaq00X4ijuqo+VHWpDbVLtniSbksLzUvd20el+PpRp4RcEnNbzFlMSY26iOI2Gb5P
 BCMHpSpm781zsv0bRxpYorpLsXmhjfjF5JB/di1dfrvLPuqgR1zY7Stc/QfPx9VHxidzrUC8m
 +cxRl7x5Tq1Xln0ffdDP0kTD7KHctL7oY96/PbiycHfQnZjn0PII1a4tNrD/FY343HeaiOQL9
 T1VCQI9ab8azDi1m9e6oBXBgCq/e6eb3MwmL4r784zvoLIqULo2TWvysoelwIystLBrQdkA3u
 8KH3BMDra2j7l0G3WgmuBkHTPtC6FpA6qFtj41drXWjMgot3KmdYZCZ+OCR69zXnKzlWWjo5S
 8Es8b7laOLuxUhYbQBHouGd9B3kVP6Oza62EqubL6JXY165BBD6+jZm4TA

Hi Mani,

Am 08.02.25 um 14:22 schrieb Stefan Wahren:
> Hi Mani,
>
> Am 08.02.25 um 11:27 schrieb Manivannan Sadhasivam:
>> On Sat, Feb 01, 2025 at 01:14:20PM +0100, Stefan Wahren wrote:
>>> The entering of L23 lower-power state is optional, because the
>>> connected endpoint might doesn't support it. So pcie-brcmstb shouldn't
>>> print an error if it fails.
>>>
>> Which part of the PCIe spec states that the L23 Ready state is optional=
?
> tbh i don't have access to the PCIe spec, so my statement based on
> this comment [1].
Please tell, how can we proceed here? In case L23 is required by the
specs the driver also need adjustment.

Best regards
>
> Thanks
>
> [1] -
> https://lore.kernel.org/all/CADQZjwcjLMTLZB1tzp+PYKK9rm=3DKe7a-KoGKMKb9z=
oWodcRK-A@mail.gmail.com/
>>
>> - Mani
>>

