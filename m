Return-Path: <linux-pci+bounces-9849-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B71928BF2
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jul 2024 17:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D48111C21D16
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jul 2024 15:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96F82B9B9;
	Fri,  5 Jul 2024 15:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="FhbVQMul"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677B1175AA;
	Fri,  5 Jul 2024 15:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720194352; cv=none; b=SqZnx2TWq6BtidExDgRZftQXzTX1oS/hqeXI1pYeLUrGzg35vJU7t16xQYbqE970lk4+jvdNaChUAGopIB7y5nKsFFXj1Yx3IdR5sjr0BowKlHSyxCGPlzJW12DsG5sGxHTq0mE1KGnrjd9Rqap7gWEG/iKPSp/rRkUwAjOJsFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720194352; c=relaxed/simple;
	bh=i5mRReK4zhlsS2VbJYS68LtF3lq8knZhHv7N6jX0bg8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SmlVvgvXk7fT+JaABg7urw0M5PAHHB6Hrz5ePl+fJapH4yl0E5cQ3hlIQhFOO1Vd293DxKQdp/v54kcYFiJrhxae1Qtx3BaKtu7H2GqJpJViib+nq1RZmlYGMc/abWrwlx4//YKCXjdGnNQOzpe/YizVikSGizfkAeInGhZ9vkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=FhbVQMul; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1720194305; x=1720799105; i=markus.elfring@web.de;
	bh=+pMBbPA417s0f/+UvCnetAucqbUdHiz+Y2oD4FMRp4U=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=FhbVQMulxO8aSQSfB71huw6YGzmDFWmHF8KzjGi/Gdb4wX4ITVOJQMppHb3M8gOh
	 iihINY5UjlfOtoot4Lkli4E/fx8y/B+XKs0ZApBPiEr+OA3PAqlh12RCONLY4BLCN
	 VJMc335pUjCMc427F+jtL7KOpqo8eEW2l5SZW5zmeaB6Cgl3A/ttWdumZjz2/Ahvu
	 6Sz0cJ62ZWRwUgJmTRmejAUuynSkPl/3qC3A/7mmLMnm/JoFrMAkui5JGhn0x8JQy
	 g8tSvBgHNULiXoBJuHwh5PLm4CCtcj9rXn26RdSk+biHRFNRSUW2QzpCVFphqXdRx
	 Xnhvc/5gUoXTQClawg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MLRUX-1siFk21sA7-00TOfX; Fri, 05
 Jul 2024 17:45:05 +0200
Message-ID: <ba9f5ed8-d548-4ec4-982c-b3f679270c64@web.de>
Date: Fri, 5 Jul 2024 17:45:04 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v2 02/12] PCI: brcmstb: Use "clk_out" error path label
To: Jim Quinlan <james.quinlan@broadcom.com>, linux-pci@vger.kernel.org,
 bcm-kernel-feedback-list@broadcom.com, linux-arm-kernel@lists.infradead.org,
 linux-rpi-kernel@lists.infradead.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, Cyril Brulebois <kibi@debian.org>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Stanimir Varbanov <svarbanov@suse.de>, Jim Quinlan <jim2101024@gmail.com>,
 LKML <linux-kernel@vger.kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>
References: <20240703180300.42959-3-james.quinlan@broadcom.com>
 <54dc90df-fc31-457d-a18d-b2070b055d60@web.de>
 <CA+-6iNxqZRdknUVammcgDC2HUmacZSAkdJNVLba32Ujgsa9vpg@mail.gmail.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CA+-6iNxqZRdknUVammcgDC2HUmacZSAkdJNVLba32Ujgsa9vpg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:K+33K4BZ4Wefh/fedNJiuZBgh5zoqUv7HyEqkV1QGSNELR2PdYU
 C+jjzkUT6Yh5x6+/ukbjxrm3e9vzzy5tj8MajVMCzHdhBpT5I150PVQjgggLPIvgYuCdW82
 mWYgNHiHBg113bGhN12WOdA6gyj96udJ0fCVbTuMzqbeT/ootr1G3P5WWUf5ogzPCf8+7Cu
 f4otHcgiU9LVGW/MJvw5g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:GCUZUb8tmCQ=;AAbmo2OPV6o39t+VV8lJNn0eBcL
 0jvWy6aFuKnwQIpKpqlrH6Ou3S3AyLbkYbmYGB2DLx1kTmTZI5h9uXkNNq6d4ElIuRAXKeUCK
 QAGfe+jbv80d5JrvoT6OrHrqLpmucAfVqT4ateIjoQ4aMSzGPjXMMqY98zVL5Lvxz3YvZbKZj
 m+8yTai6GFxu82ePPYrvXgKWCMC/mpDg5NVr3oJxtmqkrtbdaqFwzjbj40O0Id5Hf+klQkwwZ
 l8wGsOMGZLPyAyiygNgQLZeBoAK0Nuuysn/ljc4ZT73hqwPtWVPwhul0HKAYa3WsYShFizVkm
 sdwoZ1FOjloU+rHKXchxyNATMiJAByEy/cZXTU/wFHirtkIVQnzcakJsxsrpC/ixyOUHY6DBT
 duzTCgEmIpfOr7RqbfyGKpxma2uFS8oYvKtkha1cVG44CC5s/wYEcT2fXuWSizQjS7yCmE7FK
 Bd1nxvsfFnR0kHxwU9EwD5T2SHX0nvZdnwf/k7XO6ooYEA357hxDwTUHo/TV7Y+QTVpB1E2Ca
 KW8x4rHyOOsHBYDTb8iqQqWKf1JtUH5E95C0cKgHKfCsntVnQhFYHcl9iL8XggcRlaqxMqacv
 QzdS5tJJJqSB4j0qyVOfs0L34h/WX1sqW0x04CAFgxYF4fg49QM5Qrl5emXG/W/fqQwESaqxO
 pSmHqQhhdDYF7O1xrSiTSCalFnc1Qcb1nO8Bhphh5Ua2wLG5bMq0bQOMp9vdATpqbr0CY+w+Z
 SDaO6KdDQaaYn8XS1syHZ0Ee0hJxNQ+c4GzplBeIWzZ1LjTawIxz/CU/L8El9XUkFeDO7uHZH
 6Ek3evAisNH5gx6yIez4xJtiTU0h1iE40ehSumuP8ySC8=

>     > [-- Attachment #1: Type: text/plain, Size: 1685 bytes --]
>
>     Can improved adjustments be provided as regular diff data
>     (without an extra attachment)?
>
>
> I'm not sure what you are referring to... I see no attachment in the cop=
y of this email I received, =E2=80=A6

Do I get inappropriate impressions here from published data representation=
s?
https://lore.kernel.org/linux-kernel/20240703180300.42959-3-james.quinlan@=
broadcom.com/

Regards,
Markus

