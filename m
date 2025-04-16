Return-Path: <linux-pci+bounces-26039-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C826AA90B32
	for <lists+linux-pci@lfdr.de>; Wed, 16 Apr 2025 20:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D31A616426E
	for <lists+linux-pci@lfdr.de>; Wed, 16 Apr 2025 18:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3209217736;
	Wed, 16 Apr 2025 18:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="Xa4AueY1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02878215F53;
	Wed, 16 Apr 2025 18:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744827517; cv=none; b=DTuq8HP7ClouWBwltVXnjkNJoM+iOxIyY8cUl7o2s3dHyGe8pZrsKX9D4+VQgX1BQ1/EAy/0T9ol1VL2UruGJ4hJXdjP0pU1eAkOjDS9opsAkUXxgyr0j+uWqb9dxHILXeGR8qZz8xcwAMCOzcMJca4kDlHyafIrg83HO+cbGmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744827517; c=relaxed/simple;
	bh=JVCd1sm27Jpjxfncw1+yCQlbL1TfosoxkuQJ5T+cmWw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ohflRLWt0AFoI8Wid8uvEwA7Jrx/sLLfHlr12/K4cT/8bjVPK0EmOCMJCQOACi4aZFUDNU9a3vki/NVkVgso3EATtmUs+HxYzf0X8OqeRCj7Pt6fLEkUN8hM5c698WDiIVAEx0FHj/sVtayMeoNnM7/cnXjrYamWMiMPM935nvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=Xa4AueY1; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1744827489; x=1745432289; i=wahrenst@gmx.net;
	bh=Yx8aTI4JCFi43D7NV+jvG2vo27tYbIsl7r74CSBJ7Vs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Xa4AueY1DJNIzZveXMZu9vuTYQ0UDnNeYb+L+KAOmI7+OBto4UjWX8Yneqt3lp3i
	 QN+7N1Tsh1Hjyhx6b2tn0KXVMjuNochP7u62jWYWzNuujTEFQaDbQe3md6WcegFPB
	 RExGDEzjNWQv2pbDROunB6ma/zb6aPsV3kYclrbp6AMbPmH/9iG+EOdDzNnzciWXV
	 wQQSaNJNKo5z/abdb7DMCF3O744XudCPC690rY7nPK5G4UzgIaCElG+Fk3uyYCAcU
	 sAcG/W1jZ8fn7YVMivr6FGnyQK2rZobZlQjLNlQZHtIiFTwqsc1E87BgGV4toi7Kb
	 75GDxubeBKhkhqbozw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.107] ([37.4.251.153]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mv31W-1tE7Av1MA4-016EO1; Wed, 16
 Apr 2025 20:18:09 +0200
Message-ID: <8da98fc4-f24e-40ba-b705-9faf31766398@gmx.net>
Date: Wed, 16 Apr 2025 20:18:06 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 09/13] arm64: dts: Add board DTS for Rpi5 which
 includes RP1 node
To: Andrea della Porta <andrea.porta@suse.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Krzysztof Wilczynski <kw@linux.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Linus Walleij
 <linus.walleij@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
 Derek Kiernan <derek.kiernan@amd.com>, Dragan Cvetic
 <dragan.cvetic@amd.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Saravana Kannan <saravanak@google.com>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-gpio@vger.kernel.org, Masahiro Yamada <masahiroy@kernel.org>,
 Herve Codina <herve.codina@bootlin.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Andrew Lunn
 <andrew@lunn.ch>, Phil Elwell <phil@raspberrypi.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>, kernel-list@raspberrypi.com
References: <cover.1742418429.git.andrea.porta@suse.com>
 <c6498d8cf8dfade1980b566e99a9a91551fd8b53.1742418429.git.andrea.porta@suse.com>
 <526751d2-c7e8-4097-9454-c9049b880225@gmx.net> <Z__sMg-RJ6B-3OL4@apocalypse>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
Autocrypt: addr=wahrenst@gmx.net; keydata=
 xjMEZ1dOJBYJKwYBBAHaRw8BAQdA7H2MMG3q8FV7kAPko5vOAeaa4UA1I0hMgga1j5iYTTvN
 IFN0ZWZhbiBXYWhyZW4gPHdhaHJlbnN0QGdteC5uZXQ+wo8EExYIADcWIQT3FXg+ApsOhPDN
 NNFuwvLLwiAwigUCZ1dOJAUJB4TOAAIbAwQLCQgHBRUICQoLBRYCAwEAAAoJEG7C8svCIDCK
 JQ4BAP4Y9uuHAxbAhHSQf6UZ+hl5BDznsZVBJvH8cZe2dSZ6AQCNgoc1Lxw1tvPscuC1Jd1C
 TZomrGfQI47OiiJ3vGktBc44BGdXTiQSCisGAQQBl1UBBQEBB0B5M0B2E2XxySUQhU6emMYx
 f5QR/BrEK0hs3bLT6Hb9WgMBCAfCfgQYFggAJhYhBPcVeD4Cmw6E8M000W7C8svCIDCKBQJn
 V04kBQkHhM4AAhsMAAoJEG7C8svCIDCKJxoA/i+kqD5bphZEucrJHw77ujnOQbiKY2rLb0pE
 aHMQoiECAQDVbj827W1Yai/0XEABIr8Ci6a+/qZ8Vz6MZzL5GJosAA==
In-Reply-To: <Z__sMg-RJ6B-3OL4@apocalypse>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yaTnJqXN2hVC2bQS++P5Kut3+/Yey/QLr+fB/knovzlhQKJWqJc
 AyEgEvkqq3aXU0ZDV6HB3+uKKuHbnKbCfeYyR5pAKk2ZH0R2W+GCG97LS/1tHXuZmmnWh9V
 1Ntt4byibq4JJq1bBKQRXiKvVMBZbhUeW2GXTc6lkToqXAKzhYPho97WTpgfORLsaEdWoZi
 6/ZfMN0Jy8bl+DxkwuPew==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:q5hkUnNaU5M=;bttCGUAApwen1kuInuvdTyhSYVJ
 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

Hi Andrea,

Am 16.04.25 um 19:43 schrieb Andrea della Porta:
> Hi Stefan,
>
> On 13:48 Mon 14 Apr     , Stefan Wahren wrote:
>> Hi Andrea,
>>
>> Am 19.03.25 um 22:52 schrieb Andrea della Porta:
>>> Add the board 'monolithic' DTS for RaspberryPi 5 which includes
>>> the RP1 node definition.  The inclusion treeis as follow (the
>>> arrow points to the includer):
>>>
>>> rp1-common.dtsi ----> rp1-nexus.dtsi ----> bcm2712-rpi-5-b-monolithic.=
dts
>>>                                                  ^
>>>                                                  |
>>>                                              bcm2712-rpi-5-b.dts
>> sorry for the delay. I'm not happy with the monolithic appendix.
>>
>> How about bcm2712-rpi-5-b-rp1.dts or something more self-explaining?Reg=
ards
> Sure, good catch. I'd go even further saying that we can rename (or merg=
e if
> the destination file already exists) as:
>
> bcm2712-rpi-5-b.dts             ->  bcm2712-rpi-5-b-norp1.dts (or some b=
etter suffix other than -norp1)
> bcm2712-rpi-5-b-monolithic.dts  ->  bcm2712-rpi-5-b.dts
>
> so the monolithic one, which seems to be the 'safest' option as of now,
> would be the default dtb. Do you think it could be ok?
i like the idea (include rp1 into default dtb), but not a fan of=20
negative logic in naming. Unfortunately I don't have better idea.

Regards
>
>>> This is designed to maximize the compatibility with downstream DT
>>> while ensuring that a fully defined DT (one which includes the RP1
>>> node as opposed to load it from overlay at runtime) is present
>>> since early boot stage.
>>>
>>> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
>>> ---
>>> Right now bcm2712-rpi-5-b.dts is the overlay-ready DT which will make
>>> the RP1 driver to load the RP1 dtb overlay at runtime, while
>>> bcm2712-rpi-5-b-monolithic.dts is the fully defined one (i.e. it
>>> already contains RP1 node, so no overlay is loaded nor needed).
>>> Depending on which one we want to be considered the default, we can
>>> swap the file names to align with downstream naming convention that
>>> has only the fully defined DT called bcm2712-rpi-5-b.dts.
>> Could you please move some of this good explanation into this dts file =
as
>> comment?
> Sure.
>
> Thanks,
> Andrea
>
>>> ---
>>>    arch/arm64/boot/dts/broadcom/Makefile                     | 1 +
>>>    .../boot/dts/broadcom/bcm2712-rpi-5-b-monolithic.dts      | 8 +++++=
+++
>>>    2 files changed, 9 insertions(+)
>>>    create mode 100644 arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b-mon=
olithic.dts
>>>
>>> diff --git a/arch/arm64/boot/dts/broadcom/Makefile b/arch/arm64/boot/d=
ts/broadcom/Makefile
>>> index 3d0efb93b06d..4836c6da5bee 100644
>>> --- a/arch/arm64/boot/dts/broadcom/Makefile
>>> +++ b/arch/arm64/boot/dts/broadcom/Makefile
>>> @@ -7,6 +7,7 @@ dtb-$(CONFIG_ARCH_BCM2835) +=3D bcm2711-rpi-400.dtb \
>>>    			      bcm2711-rpi-4-b.dtb \
>>>    			      bcm2711-rpi-cm4-io.dtb \
>>>    			      bcm2712-rpi-5-b.dtb \
>>> +			      bcm2712-rpi-5-b-monolithic.dtb \
>>>    			      bcm2712-d-rpi-5-b.dtb \
>>>    			      bcm2837-rpi-3-a-plus.dtb \
>>>    			      bcm2837-rpi-3-b.dtb \
>>> diff --git a/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b-monolithic.d=
ts b/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b-monolithic.dts
>>> new file mode 100644
>>> index 000000000000..3aeee678b0bc
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b-monolithic.dts
>>> @@ -0,0 +1,8 @@
>>> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
>>> +/dts-v1/;
>>> +
>>> +#include "bcm2712-rpi-5-b.dts"
>>> +
>>> +&pcie2 {
>>> +	#include "rp1-nexus.dtsi"
>>> +};


