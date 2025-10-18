Return-Path: <linux-pci+bounces-38576-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 56250BECCD1
	for <lists+linux-pci@lfdr.de>; Sat, 18 Oct 2025 11:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 42F0C4E294C
	for <lists+linux-pci@lfdr.de>; Sat, 18 Oct 2025 09:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF9E2749DC;
	Sat, 18 Oct 2025 09:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="ty+6tcBb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A9C354ADC;
	Sat, 18 Oct 2025 09:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760781056; cv=none; b=CNOkju351aQSty8egAfYk9nbGL2nim3DVNhxdak+CUmjON2wKBI6o002+GldKghn2LPCB3EX35sC1s7bmDCQCeuFw4wEJDp/qzXMf9JSy0gebE3Iq2A45GNW7+ZhGL2U70usFPHGbKbjj+MhOC3l53Xl6KQClHB1MP0A3R00slo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760781056; c=relaxed/simple;
	bh=oaoiFdIFB8KKo4efOfzT/A2Bhs/oHi6yLG2xS/Fj57c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M68ntdQegPMRmrhb4cdmgLIzKMW1fCbZcr6LloMV3kWVpJMKyoPGZL35FeMH+CEWc41oyLULi6X3ZYBx/2bpLdjE1haMX+Gz/Fzwmfr36ml6NusJGWjl1V2mKu7ohYIGgsj+qGN4EaQV+bTn9emvwsUAgYj5ajd+kGKdVruMO+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=ty+6tcBb; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1760781038; x=1761385838; i=markus.elfring@web.de;
	bh=KOlMgTRRJg7qXhBzGfRlEX/f1nXHXiKz7BHpATAQz6E=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ty+6tcBbs6EDe5P3edRD3VMCapQfN8Tu1Km/C1Mn5svZUcmtX2ij2tgxKiThLsO3
	 1+YSSTn6IFT7vm0l4ionPT6AYfD78IMXbSlo1wgZDo/765ZV7syZJnwRbK2d5l3Gp
	 /Yz+BKLFuj7vNmRFBKDCr5XA+IOz7vVnq5WmFQFuhuTz98C5NNSjZwDXwhCvDoDFk
	 vVS8iOvRFKVD9OA4Nzzbm/lYTEwLaDKOjzRoXpN1p49BlFzcDVwNH6LBovJ8KjRsX
	 w9WJef1AZL5x/PMK/FNtJnkaUpZhFykpcua0N/VzMoEIR3xEH9QgjpFlNaN9i6xVT
	 kyUZTbvb0SsP0jpOrg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.233]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M8TBS-1v5fry0ZlY-00FRZT; Sat, 18
 Oct 2025 11:50:38 +0200
Message-ID: <c1c65437-a80c-473c-8c93-c7bf947f703a@web.de>
Date: Sat, 18 Oct 2025 11:50:36 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: rockchip: Propagate dev_err_probe return value
To: Anand Moon <linux.amoon@gmail.com>, linux-pci@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?=
 <heiko@sntech.de>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Shawn Lin <shawn.lin@rock-chips.com>, LKML <linux-kernel@vger.kernel.org>,
 kernel-janitors@vger.kernel.org
References: <20251018061127.7352-1-linux.amoon@gmail.com>
 <071f563c-6d09-46ea-870b-a51e0522bfad@web.de>
 <CANAwSgQEqv2a1MGkGtj8CpXSKOXv=_wV3afOgn=iri7uqnj1bw@mail.gmail.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CANAwSgQEqv2a1MGkGtj8CpXSKOXv=_wV3afOgn=iri7uqnj1bw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xQedfjrCuv9ixtxW29pq6KFfrTlDuZAG3h5dKTYme26zIlS9Ivj
 spc1NH8G8o10GFtmYSJp6xVSeFDVn8wLfnYtIRNet6D2Xil9SSCMSgV3a4XcZj3VGfbIIfp
 FrnGrQzo6d1UpW55CnR3xnyAacN7/cog009PeVgNbR05ealnw5cIX8qDEc+q5O3JmlOVmbO
 yQKqfkRO80c5/ya+saxeA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:PVAX5Cf3GbE=;jBHJnBSWcYHyeVj6zI6Cro+2KW3
 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
 q0vunT1wGh3eHqfzlVOHy2OEqyVejnv1SNI=

>> I find the change description improvable.
>>
> Ok, is this ok?

I present other wording preferences.


> When using the dev_err_probe() helper function in rockchip_pcie_init_por=
t(),
> ensure its return value is consistently assigned to the return variable.

I hope that we can achieve consensus on the corresponding source code plac=
es.
https://elixir.bootlin.com/linux/v6.17.1/source/drivers/pci/controller/pci=
e-rockchip.c#L115-L202


> This guarantees that the original error code, whether it's a specific er=
ror
> or -EPROBE_DEFER,
> is correctly propagated up the call stack for proper error handling
> and debugging.

The mentioned programming interface should be applied correctly.


>> Would an other source code variant become more desirable?
>> https://elixir.bootlin.com/linux/v6.17.1/source/drivers/base/core.c#L50=
31-L5075
>>
>>         err =3D dev_err_probe(dev,
>>                             reset_control_bulk_assert(ROCKCHIP_NUM_CORE=
_RSTS, rockchip->core_rsts),
>>                             "Couldn't assert Core resets\n");
>>         if (err)
>>                 goto err_exit_phy;
> No, the correct code ensures that dev_err_probe() is only called when
> an actual error has
> occurred, providing a clear and accurate log entry. =E2=80=A6

Do you think that anything different would happen according to my transfor=
mation suggestion?

Regards,
Markus

