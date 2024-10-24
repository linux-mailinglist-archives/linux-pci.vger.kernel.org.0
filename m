Return-Path: <linux-pci+bounces-15219-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A45139AEE26
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 19:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C81121C20DB4
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 17:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E498E1FC7DC;
	Thu, 24 Oct 2024 17:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="nVD+MJ9t";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lfnsG6Re"
X-Original-To: linux-pci@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEE01EF958;
	Thu, 24 Oct 2024 17:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729791235; cv=none; b=RYGE/iaAr1pIP/qXj6vdyD8kGuwWhyMXCVHjIgqm+ainSSvPeTaUwjPFpSU0OuFi/AfQfdZzwbt6ZGVTKwMohhjado4YPWbLi5rqbpeySKbqo+ZLMEgvEA5m9Y5OhgDpAfVPEQBVMcOKc5q2WsbSHkfHM+4KB/o/2E9CePL+sLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729791235; c=relaxed/simple;
	bh=wdsXoO9P+4ECG9k3lEz3ZPdv+OvACR6i5MKXmbG89RU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=i8qfliA644/Ugp3otNr68Pn0ChfgKvAkMUhH1JUWEj6L+UdqvCOuiiPILpCd2mNa6DcJSsa3nWTU6EWOU0zbY697UVPSKV813akYG/l55odTXCrA6TeWG86Z/AgPUz1ZwqOn6jj7fHxdWgzKsvXPeLYqy9MqI/FljSHO4wCU01w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=nVD+MJ9t; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lfnsG6Re; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 11458114019F;
	Thu, 24 Oct 2024 13:33:52 -0400 (EDT)
Received: from phl-imap-12 ([10.202.2.86])
  by phl-compute-09.internal (MEProxy); Thu, 24 Oct 2024 13:33:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1729791232;
	 x=1729877632; bh=wdsXoO9P+4ECG9k3lEz3ZPdv+OvACR6i5MKXmbG89RU=; b=
	nVD+MJ9tepqVLmz0frFblZ+1jF6ecfXE1ewdsxAJCfWc4jro56qm4evGOKdot/2/
	CBGn7gx+AfHlK2cJ5eDbDd+sevURQo0y/YlNexvu3CUjZsssmg8NjvC5ZmWK+QlG
	jAhaEwDEmeU9cEUXBZ3gW8jxwYGxeFlNIxEtAKUt6a1hN6m9dEwoX51e88M/R/9H
	lw0dXrhVUkxVWUkuVlCJNaqw0r5uvUTG4BrU+FQjCw5sZE5cfK6V6eM5auPE0NmW
	u1N+LEcnsGAAtD6f2+GYei7/AXGIwn+UAiorfaA9c0t045SPYJye3n8kZBpJSbod
	8DTzUvy3HRsZj3oGisi5Xg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1729791232; x=
	1729877632; bh=wdsXoO9P+4ECG9k3lEz3ZPdv+OvACR6i5MKXmbG89RU=; b=l
	fnsG6Rer6jHpC4GUlXtvaxAaD43l3BHgvu2nBBPXFN8qAVWd02ruSaXMim+1Pyd8
	TYvP3gFNDsZTC1fs3fu1KFLcqkZGYMHj0hCL8V+5cpCHQv7X44UXGESVwp/J5SHA
	ubQoDqvDfMQ2p8951sCT15QS2Niev3KnfDECi4GX1nYGKgGh1oiAfNpcnbrMC3x+
	tQDLzcEunFfWr2XR+ADo+CN6S7vuLtNFl8vWQVQwYDyM13YNepj6HP+T2ht/CWwQ
	CmFpIJUszZb+5aYP83sbUu3GjKyaNlVmRmb0UvmWcGSkeWOzjhfFnDM8eSPOrv63
	m+okyTNBC71rmLgyvsnmQ==
X-ME-Sender: <xms:_4QaZw8qFH6UUy5zbwCzmvsxqyKXzehGwOQ9tQ3GcNRjcW6LCV5bUw>
    <xme:_4QaZ4t-KdwC5DNjuHP69FQl3rUIjXIRY_pgLEPfRNxc4qolBMwfTiUrMDbCPXvO1
    gBgOqbMxwXfPNGUrqQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejtddgkeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
    necuhfhrohhmpedflfhirgiguhhnucgjrghnghdfuceojhhirgiguhhnrdihrghnghesfh
    hlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepffekveettdeuveefhfekhfdu
    gfegteejffejudeuheeujefgleduveekuddtueehnecuffhomhgrihhnpehkvghrnhgvlh
    drohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmpdhnsggprhgtphhtthhope
    eipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigqdhmihhpshesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhptghisehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrhgvnhgvshgrshdqshho
    tgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhsvghrih
    grlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhsphhi
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvthguvghvsehvghgvrh
    drkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:_4QaZ2Ab4C6NIeVOyIAJobYjCggGZQAn1BOn5Q68JVp2H5vhn2mDaQ>
    <xmx:_4QaZwdUZw9ozye8RRmvAHhxmXSZnalD94lt0oR1FQYgToNXUKt2Ng>
    <xmx:_4QaZ1PVNCnzIn0T6rLHzOGL6u4mvvOQTseLKkpM2V65j89FPGs5MA>
    <xmx:_4QaZ6kCkibqZN9rVAh8TZq_Q10kOrUKCwk7Q20_dMeTiuJNgQ5Q1w>
    <xmx:AIUaZ402LMqWJsb5A1dR_GIJO0DuRQCAmi7NoF21RkKFxrF5fcVhuhXO>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C0DD41C20066; Thu, 24 Oct 2024 13:33:51 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 24 Oct 2024 18:33:31 +0100
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "Peter Cai" <peter@typeblog.net>,
 "James Bottomley" <James.Bottomley@hansenpartnership.com>,
 "Serge Semin" <fancer.lancer@gmail.com>, "Jon Mason" <jdmason@kudzu.us>,
 "Dave Jiang" <dave.jiang@intel.com>, "Allen Hubbe" <allenbh@gmail.com>,
 ntb@lists.linux.dev, "Andy Shevchenko" <andy@kernel.org>,
 "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
 "Kory Maincent" <kory.maincent@bootlin.com>,
 "Cai Huoqing" <cai.huoqing@linux.dev>, dmaengine@vger.kernel.org,
 "Mark Brown" <broonie@kernel.org>, linux-spi@vger.kernel.org,
 "Damien Le Moal" <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
 "paulburton@kernel.org" <paulburton@kernel.org>,
 "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
 "Arnd Bergmann" <arnd@arndb.de>,
 "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
 "Bjorn Helgaas" <bhelgaas@google.com>,
 "Manivannan Sadhasivam" <manivannan.sadhasivam@linaro.org>,
 "Yoshihiro Shimoda" <yoshihiro.shimoda.uh@renesas.com>,
 linux-pci <linux-pci@vger.kernel.org>,
 "David S . Miller" <davem@davemloft.net>,
 "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 "Andrew Lunn" <andrew@lunn.ch>, "Russell King" <linux@armlinux.org.uk>,
 "Vladimir Oltean" <olteanv@gmail.com>,
 "Kelvin Cheung" <keguang.zhang@gmail.com>,
 "Yanteng Si" <siyanteng@loongson.cn>, netdev@vger.kernel.org,
 "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk@kernel.org>,
 "Guenter Roeck" <linux@roeck-us.net>, linux-hwmon@vger.kernel.org,
 "Borislav Petkov" <bp@alien8.de>, linux-edac@vger.kernel.org,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 linux-serial@vger.kernel.org
Cc: "Andrew Halaney" <ajhalaney@gmail.com>, "Nikita Travkin" <nikita@trvn.ru>,
 "Ivan Kokshaysky" <ink@jurassic.park.msu.ru>,
 "Alexander Shiyan" <shc_work@mail.ru>, "Dmitry Kozlov" <xeb@mail.ru>,
 "Sergey Shtylyov" <s.shtylyov@omp.ru>,
 "Evgeniy Dushistov" <dushistov@mail.ru>,
 "Geert Uytterhoeven" <geert@linux-m68k.org>,
 "Sergio Paracuellos" <sergio.paracuellos@gmail.com>,
 "Nikita Shubin" <nikita.shubin@maquefel.me>,
 linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Kexy Biscuit" <kexybiscuit@aosc.io>, jeffbai@aosc.io,
 "Linus Torvalds" <torvalds@linux-foundation.org>
Message-Id: <88bd4b6e-d744-4f50-a3ab-34433bbd0ad9@app.fastmail.com>
In-Reply-To: <6beb4070-1946-4387-bd0e-34608a76b19e@typeblog.net>
References: <2m53bmuzemamzc4jzk2bj7tli22ruaaqqe34a2shtdtqrd52hp@alifh66en3rj>
 <e7d548a7fc835f9f3c9cb2e5ed97dfdfa164813f.camel@HansenPartnership.com>
 <6beb4070-1946-4387-bd0e-34608a76b19e@typeblog.net>
Subject: Re: linux: Goodbye from a Linux community volunteer
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



=E5=9C=A82024=E5=B9=B410=E6=9C=8824=E6=97=A5=E5=8D=81=E6=9C=88 =E4=B8=8B=
=E5=8D=885:30=EF=BC=8CPeter Cai=E5=86=99=E9=81=93=EF=BC=9A
> Hi James,
>
> Thanks for your clarification. This sort of non-provocative=20
> clarifications of the regulations you need to comply to has always bee=
n=20
> what the community wants to see. _This_ should have been the first=20
> official statement when anyone raised the concern, instead of Greg's=20
> attempt to "defuse" the situation over private correspondence, or Linu=
s=20
> Torvald's outright defamation and accusing anyone who dares to disagre=
e=20
> of being a "Russian troll". This is not even to mention the _complete=20
> ignorance_ and arrogance shown by his statement on what sending a reve=
rt=20
> patch means.
>
> With sanctions in place, there is no reasonable person who will demand=20
> the LF or the Linux Kernel maintainers to do otherwise. However, as=20
> someone who does rely on Linux for daily work, and as someone who has=20
> contributed to the Linux project and its community, I think seeing the=20
> following should be the minimum:
>
> 1. Linus Torvalds (+Cc) send an apology letter to **everyone** who he=20
> accused of being a Russian troll;
> 2. Linus Torvalds need to **unconditionally retract** his personal=20
> attack on Kexy Biscuit, the person who sent the revert patch in protes=
t=20
> (+Cc), and acknowledge that people who work with AOSC.io aren't=20
> "state-sponsored paid actors";
> 3. This type of statement should be included somewhere public as soon =
as=20
> practically possible should sanction compliance affect kernel=20
> development again in the future;
> 4. No personal attacks should be allowed based on tinfoil-hat reasonin=
g.

I agree those actions and IMHO this should be addressed under Linux's
Code of Conduct enforcement [1] framework.

I also look forward to a formal investigation report on the entire event.
It may eventually result in an overhaul of our governance model.

[1]: https://docs.kernel.org/process/code-of-conduct.html

Thanks
>
> Thanks,
> Peter.
[...]
--=20
- Jiaxun

