Return-Path: <linux-pci+bounces-35444-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D49CB43B8A
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 14:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E28B83A9EB8
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 12:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB5D2E8B69;
	Thu,  4 Sep 2025 12:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=orca.pet header.i=@orca.pet header.b="hT4WE83t"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtpout7.mo534.mail-out.ovh.net (smtpout7.mo534.mail-out.ovh.net [54.36.140.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950E82EA480
	for <linux-pci@vger.kernel.org>; Thu,  4 Sep 2025 12:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.36.140.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756988863; cv=none; b=AM7tbj+n2KF7zCwlS3CwNeWEWDsYsFL8nSVQzYHpGAo7ORG2YaWuWjtLb/UuJ/u7mdW/DxHtJkDCrwx7CEBWHmNzjVwecv9yWGTXFqWU+WHiX398ed/Di+mI6Cyjs4PsyQSvFmM9h7LO2qgYxrfLqqZNoVX+c/3YANkizRB+ljM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756988863; c=relaxed/simple;
	bh=7X4O6HXlH9iQ1Hsrlwz3r/yjl54fpwY6CM802gdqlPo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UqyfPfqTqfCqETGbM/XPgRimGN/N87G2QoMwD+ubqcar+/ikY8wOiTdzF/kH0of+LI2PArikTTZSw3hpXdEiuLrvd8cQsp0fgAQZDSugTgmmQn9GdmKyG3igvnYPlGzChAcDosDXdUIfuL2SgnuUv850JhNq6qmTBPtGd8e1cDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orca.pet; spf=pass smtp.mailfrom=orca.pet; dkim=pass (2048-bit key) header.d=orca.pet header.i=@orca.pet header.b=hT4WE83t; arc=none smtp.client-ip=54.36.140.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orca.pet
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=orca.pet
Received: from director4.derp.mail-out.ovh.net (director4.derp.mail-out.ovh.net [79.137.60.37])
	by mo534.mail-out.ovh.net (Postfix) with ESMTPS id 4cHdqs29Ytz6FjT;
	Thu,  4 Sep 2025 12:21:13 +0000 (UTC)
Received: from director4.derp.mail-out.ovh.net (director4.derp.mail-out.ovh.net. [127.0.0.1])
        by director4.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
        for <brgl@bgdev.pl>; Thu,  4 Sep 2025 12:21:12 +0000 (UTC)
Received: from mta6.priv.ovhmail-u1.ea.mail.ovh.net (unknown [10.110.118.83])
	by director4.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4cHdqr3Bd0z1xsB;
	Thu,  4 Sep 2025 12:21:12 +0000 (UTC)
Received: from orca.pet (unknown [10.1.6.8])
	by mta6.priv.ovhmail-u1.ea.mail.ovh.net (Postfix) with ESMTPSA id DB2708E337B;
	Thu,  4 Sep 2025 12:21:10 +0000 (UTC)
Authentication-Results:garm.ovh; auth=pass (GARM-97G002c5ec3bc3-e4fe-4836-9217-05bc8e07bcaf,
                    9D83928BDD5912CB49B4BF67D3C99AFCADCD49FA) smtp.auth=marcos@orca.pet
X-OVh-ClientIp:79.117.41.176
Message-ID: <75920526-64f4-4eda-8552-58de165f6597@orca.pet>
Date: Thu, 4 Sep 2025 14:21:11 +0200
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
 linux-pci@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@intel.com>
References: <20250822135816.739582-1-marcos@orca.pet>
 <20250822135816.739582-4-marcos@orca.pet>
 <20250902151828.GU2163762@google.com>
 <45b84c38-4046-4fb0-89af-6a2cc4de99cf@orca.pet>
 <20250903072117.GY2163762@google.com>
 <1d4352b6-c27e-4946-be36-87765f3fb7c3@orca.pet>
 <20250903140115.GC2764654@google.com>
 <b11dcd50-a87e-47ff-b406-776e432f07bd@orca.pet>
 <20250904101705.GH2764654@google.com>
Content-Language: es-ES
From: Marcos Del Sol Vives <marcos@orca.pet>
In-Reply-To: <20250904101705.GH2764654@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 9527365014460520038
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeitddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeforghrtghoshcuffgvlhcuufholhcugghivhgvshcuoehmrghrtghoshesohhrtggrrdhpvghtqeenucggtffrrghtthgvrhhnpeelteejgeejhfdutdelhffgvedtfeffteevgefhgfetueeltddtfeeuveefgefhvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduvdejrddtrddtrddupdejledruddujedrgedurddujeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpehmrghrtghoshesohhrtggrrdhpvghtpdhnsggprhgtphhtthhopeelpdhrtghpthhtohepsghrghhlsegsghguvghvrdhplhdprhgtphhtthhopegshhgvlhhgrggrshesghhoohhglhgvrdgtohhmpdhrtghpthhtoheprghnughrihihrdhshhgvvhgthhgvnhhkohesihhnthgvlhdrtghomhdprhgtphhtthhopehlvggvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmfigrlhhlvgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhushdrfigrlhhlvghijheslhhinhgrrhhordhorhhgpd
 hrtghpthhtoheplhhinhhugidqghhpihhosehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphgtihesvhhgvghrrdhkvghrnhgvlhdrohhrgh
DKIM-Signature: a=rsa-sha256; bh=rJzm0HSs8UGGmqFisPR6K2tkEBXOcV7SXVx5vxgiMRY=;
 c=relaxed/relaxed; d=orca.pet; h=From; s=ovhmo-selector-1; t=1756988473;
 v=1;
 b=hT4WE83tetDttzT70Nyi/9SDmvMZzbXCCUvwY1cC49rEfEvcgYpnTp1o6sBck+m05gH97l91
 IyQT5UWUnS38bAZn69IIpL8CrVEa6SAWqdkvwvFh5GOGE/HFznxFLtCtKA8WQIWi7ZOGI1RbgYo
 6ihH0ZhOcT1M6JGptNQZg78sJaYxctcYzGc/2Y3IBrp0Xxta7uImGmOcpN0GGO5HZ7Oerkh3cEH
 7CIyaS/owdiHqml2ivPVO2agYEwwloSr+2QDaGQGAT48j4Jdrqh6AkF4HdWwoIKYcraf2bLFwKO
 PJ5b1dEpwZzj4VOg6Uh6JXTRMrloznscZJkuEDbjV7h8A==

El 04/09/2025 a las 12:17, Lee Jones escribió:
>> That GPIO is something required to perform the poweroff sequence, a must
>> for any machine, while WDT is just a "nice to have".
>>
>> Implementing now the WDT just because of a linguistic preference means
>> delaying something more important in favour of a "nice to have".
> 
> You use the word "delaying" here.  What's the rush?
> 
> If you only need a GPIO driver, then you don't need the MFD part.
> 

I would honestly like that my machines can turn off properly and pretty
sure others using these platforms would agree on that, as having to yank
out the power cable is far from ideal.

Adding WDT would lengthen even further the review process. That ignoring
I am doing this as a hobby on my spare time and I'd rather spend my
scarce free time implementing the power off driver than the WDT
(something I'd do out of completion, I have absolutely no use for a WDT
in this machine).

The reason I am using an MFD is that I was asked to back in v2
(https://lore.kernel.org/all/aHElavFTptu0q4Kj@smile.fi.intel.com/).
I'll be CC'ing him.

I was told to create a southbridge driver that would match on PCI
and registered other devices exposed by it as platform drivers.
GPIO was the only functionality implemented at the time, and is
the only functionality implemented right now. So I simply delivered was
I was asked for.

