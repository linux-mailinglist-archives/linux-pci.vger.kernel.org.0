Return-Path: <linux-pci+bounces-14270-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3752599A0D4
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 12:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C24C3284D28
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 10:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F5A2101B3;
	Fri, 11 Oct 2024 10:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="L6KYr/Ho"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF98121018F;
	Fri, 11 Oct 2024 10:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728641375; cv=none; b=SxDPmaPbKmd8aKSSnrHTF6LIRBqmP01sCyqlUBK1Wopvx2rBXGXulDL6SQXQdPQl5lWKSlE5M13fBlmzzmciV2F4qO8mUIy0TvHFpHvJTDLzduZ42tEZLSjjIWTFUYwqRfWyY1TkhFYnsDYUcjME3HdkA65hWA7HLQi5nbp1PAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728641375; c=relaxed/simple;
	bh=eoav9wkO+mIe4PV1rHGpqtvnpQN84eRE/FQ5B02sO7M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TDQJOf+iO7tWzyFYto8GKSVyjnSdx8k0QTQ8l9dLjKO3agyfPd+Gx6sDzQAY7HzGbYFi1SyM8cpJzg+t9/z21CYCJCPs6rFlED97IB7lNCMwyic+ZkHeRak+Ih5T30xvVcHKEjMAwC4rKsxchRVOKf+EHc3TTH49w28ImE5LyTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=L6KYr/Ho; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1728641337; x=1729246137; i=wahrenst@gmx.net;
	bh=eoav9wkO+mIe4PV1rHGpqtvnpQN84eRE/FQ5B02sO7M=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=L6KYr/HotO3ODVCzjyupk3DKZ61fWxCKb1v0bpnSZL1CZPvy7oe9/5ir3ZUEuDla
	 VQWvdKwXXPGlxsM2fwdTM3iGQxt416F6V8/MAaLmqwgXIU8XSvWsowxdnKLoUU0GB
	 CD/wcoOy6jmxP7i8LtTkXYXiaHWAZ2usivveAZyQkJXfWpDeyvNJcadue/eAGBvGV
	 ZIHSGPCQUs35ugrNSKiuBVpGKkIWYNuF4h4YOadT+R0/mVIRlBScS5zZisVfeWdRt
	 d63kF6CSHjBdYyXYTmB1BHgLObVmY8yD5i8bW3HJESGrZevaLuqOXoGxSotQ9ivzH
	 2roSznDPT2MecF+oPA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.104] ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N4hzj-1u0UKl2nkF-015B3x; Fri, 11
 Oct 2024 12:08:56 +0200
Message-ID: <a1b72875-6224-47b9-bc68-bcc66343bf46@gmx.net>
Date: Fri, 11 Oct 2024 12:08:52 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/14] pinctrl: rp1: Implement RaspberryPi RP1 gpio
 support
To: Linus Walleij <linus.walleij@linaro.org>,
 Andrea della Porta <andrea.porta@suse.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>, Derek Kiernan <derek.kiernan@amd.com>,
 Dragan Cvetic <dragan.cvetic@amd.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Saravana Kannan <saravanak@google.com>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org,
 Masahiro Yamada <masahiroy@kernel.org>,
 Herve Codina <herve.codina@bootlin.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Andrew Lunn <andrew@lunn.ch>
References: <cover.1728300189.git.andrea.porta@suse.com>
 <199a4994312b120c73c95fa368954ad5a2a8aee6.1728300190.git.andrea.porta@suse.com>
 <CACRpkdb1muovPmKoUw=Q5sNXj3bsCt84LcKVDSLY09_5_1rXZQ@mail.gmail.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <CACRpkdb1muovPmKoUw=Q5sNXj3bsCt84LcKVDSLY09_5_1rXZQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LqY4jNXpUn/szfUlWjhhwIcxwRo5I0Rfv5kZ780LihSoEH5kZEs
 LBEXN1xvXO3oyM2VurBOq0JyQUCUOFbQy01ZamLt5KFsS3mw08WU1N8sDv11Pmmucpg2KuM
 mTFNN1/unuc2aK9/oBJXjQGszv4sUl2x3P9K1Qe72TdIv3JxoYwlOMlkzFcJuYkKYtNMQ9C
 WExkC/oy7cXveyEvXEVWQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:gfvBp+EhPSg=;Krp+Dt4+0xc0T3nyoXq1JLBXS+4
 ssl7ep8XjwEVmqJfN1tBRWWWZWygUXl0AWATC2RYwQpwWy8uFZn2G8A1YS77SobXzuApkCH3T
 gAujAK/+hYi09B6UIUGrxadmCvoXHScVW8fD1EbKql9k4KdtL4QL9STqL8P2WRDb/GObmbna3
 v0X4lbplDs53TY2opRzzoia/hisRmP90PlW0ACs/icw4vs8wCcO2TmrvHCtUpDbkk1q3j+XI6
 /I6m9+q9CiVZERFsOmU/lOOa2nKmYP7XN59T893soEMqrDxmc6pI8onxeFyw2xUqJhGmgVgS7
 56xC/OT5sE1nNh2O5/uFRYkPmsyKVQT935g4W3k4XY6a7PpWZH+W71JjWxPRrzLYuz5P/DlDr
 0PM9tPFSQO6nLkSCi9YvIFdVKCKfT+kPTfFq4cP6LrCu7l4fVq1Ky6uHS4hpPAbVpkIZYlpG7
 2rGZhYKVppBIDMQvcxeIV3wAD/A+66/A2IvW0XYfRc6GbBjwBmm28BTBVSZjVX/MPnohHyws7
 Q3D7k+D+uI0opPMIHGy3fZsVQ8QkZ3vFV5sOWkqlx5u+gkLnUBWgZwKR0xVxzKi/ZOJXG4N57
 PaJAzG7M/e0K9mqrAhQgaavITppLM/Fc9DoUzIwbB0cvpik/tc3qBYW8F9YHgfnZU/pM/4Lb1
 OzFLFVtL/ITPMYrk3lJi9mAPR7jZlBwO5x+48aRf7JhiffhVwBEDOvKxLJT+L44kT5FOSiyzk
 aQggDfZtmYp244brhtEqY7L7zEiDqAKBQBNl9zyh/x1ZedjDMLmbnklzB8Mb9yTd5SjizUpaB
 xr4Mo6Y76DusHmA0f6y8DOKA==

Am 11.10.24 um 11:03 schrieb Linus Walleij:
> On Mon, Oct 7, 2024 at 2:39=E2=80=AFPM Andrea della Porta <andrea.porta@=
suse.com> wrote:
>
>> The RP1 is an MFD supporting a gpio controller and /pinmux/pinctrl.
>> Add minimum support for the gpio only portion. The driver is in
>> pinctrl folder since upcoming patches will add the pinmux/pinctrl
>> support where the gpio part can be seen as an addition.
>>
>> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> This is a nice driver and I find no issues with it, what causes
> an issue is gpiochip_set_names() as pointed out by Bartosz.
> If you can live without the names you can remove that part for
> now and we can merge the driver, then you can add the names
> later when we sorted out how to share that function.
I raised the concerns about missing gpio line names in the first version
of patch, without knowing the real efforts.

So I'm fine with Linus' suggestion, because I don't want to delay the
upstreaming effort unnecessarily.

Regards
>
> Yours,
> Linus Walleij


