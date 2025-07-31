Return-Path: <linux-pci+bounces-33258-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09845B1765D
	for <lists+linux-pci@lfdr.de>; Thu, 31 Jul 2025 21:02:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AC447B687B
	for <lists+linux-pci@lfdr.de>; Thu, 31 Jul 2025 19:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EFED19F48D;
	Thu, 31 Jul 2025 19:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GxcrQpeF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA87198E9B;
	Thu, 31 Jul 2025 19:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753988500; cv=none; b=nVtvi2VGS4drsy4zcS1KERDMoqf/M+/oPK8ZHUO7wbEojGDnudEna3xwSGDUK/WZ1LImYoDzUepTof40DzI1QfpdKI1f8br1PnroLBS11PT1A0Ml3/AnL/pCPpBlhiREls40gm4fsTcWIHFtQbJNz7RkYA5zzTysA/mcvND00bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753988500; c=relaxed/simple;
	bh=jFRy8D/uMyEpm99e7t7mFshpQp5ReIy/WWIZ0D9wB5E=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=qpxPfvXkphB2EMBDUg2xZd4TWxcArrno85iZYWc8o4tLS/ZR619itGQ1dJu5NlD5Qn5AQZgZ6ht8PZq6MAvIo+hnKA1WK+/Dke6c3NQcBol5WbX90U0/VxLg61b1Bbaid26naLTT5/UuolXUShgiBJV7qcoB/yX8W89xNWuRfks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GxcrQpeF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1207BC4CEF6;
	Thu, 31 Jul 2025 19:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753988499;
	bh=jFRy8D/uMyEpm99e7t7mFshpQp5ReIy/WWIZ0D9wB5E=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=GxcrQpeFvQ01BQYfW/Ts2DfMDAiqT1yZFMlIaYidMMkTiD89OayIUVD78ownNWnTh
	 Sll6yxnXBZClj9F9tV3msDJXmzAh+cxNAvTZBNhfqV6iaqQb8xdYfQrzdRyRHdRP/k
	 QspkzRv2Hc/s1EIyOGuT51BrTg65fCMwQG1hU28YzSs1oe+cZirbLeeLVmLEYeZFrz
	 G9qctKtdu7Stns49ztn6kDAMMkDF+Ns1GTbmmc6No4n1HyEEgbPtNCST7U6/QCygVo
	 sONoWkSYecih28PnBOxTqL7Ts6Do2ekCyTCwD56IhKaZGKZqkwduYdwe3Yu0uMGmWW
	 WLlMRQu6kzi2w==
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 1518DF40066;
	Thu, 31 Jul 2025 15:01:38 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Thu, 31 Jul 2025 15:01:38 -0400
X-ME-Sender: <xms:kb2LaMPdhEyW64fyqp1VO8RHIpFvuzzJNgnjenLlxT7kHEpx92Tn2w>
    <xme:kb2LaC-6icXJS7UWZNeLmNBEp32qiyf5RcUNAIh4w0Q9u_b28ew8hjo4JIOyfxSXs
    rleM8XIA5Sc-zBDzj0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutdduiedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusehkvghrnhgvlhdrohhrgheqnecuggftrfgrth
    htvghrnhepjeejffetteefteekieejudeguedvgfeffeeitdduieekgeegfeekhfduhfel
    hfevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhguodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduvdekhedujedtvdeg
    qddvkeejtddtvdeigedqrghrnhgupeepkhgvrhhnvghlrdhorhhgsegrrhhnuggsrdguvg
    dpnhgspghrtghpthhtohepudejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopedu
    kedvheehuddujeduheelseduieefrdgtohhmpdhrtghpthhtohepjhhinhhgohhohhgrnh
    dusehgmhgrihhlrdgtohhmpdhrtghpthhtohepsghhvghlghgrrghssehgohhoghhlvgdr
    tghomhdprhgtphhtthhopehhvghlghgrrghssehkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehkfihilhgtiiihnhhskhhisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlphhi
    vghrrghlihhsiheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgrnhhisehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthht
    oheprghgohhruggvvghvsehlihhnuhigrdhisghmrdgtohhm
X-ME-Proxy: <xmx:kb2LaINGGnQ7DvuKpwF_i4KfxlJVEYjnrCK4aerUN_Gthw1WyL_lew>
    <xmx:kr2LaAYKPVf3w585Yo30KFi9BxRZh74HuzyV9cHu_gmJkX1G8u8umw>
    <xmx:kr2LaKrgPJLD-On5iCdpVaVJAQ48EXh-Q_FVuE9bxVxVIwYJ_Oxltw>
    <xmx:kr2LaNxY25iszNoqnYxqMyUteItYl8Y_tfJ_RoyeiZAJvIWYECoMXQ>
    <xmx:kr2LaCJV3FaR3I0DI_lj9e-l6dcyYaqr-jXVpQpAVaH-Q4qU_HKbH4IB>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id CB4FB700068; Thu, 31 Jul 2025 15:01:37 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Tea76caf5b1f73f76
Date: Thu, 31 Jul 2025 21:01:17 +0200
From: "Arnd Bergmann" <arnd@kernel.org>
To: "Bjorn Helgaas" <helgaas@kernel.org>, "Gerd Bayer" <gbayer@linux.ibm.com>
Cc: "Hans Zhang" <18255117159@163.com>, bhelgaas@google.com,
 "Alexander Gordeev" <agordeev@linux.ibm.com>,
 "Christian Borntraeger" <borntraeger@linux.ibm.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 jingoohan1@gmail.com,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-next <linux-next@vger.kernel.org>, linux-pci@vger.kernel.org,
 "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
 "Manivannan Sadhasivam" <mani@kernel.org>, "Rob Herring" <robh@kernel.org>,
 "Niklas Schnelle" <schnelle@linux.ibm.com>
Message-Id: <6e34b4af-dff9-4360-b3da-c95ca7c740c9@app.fastmail.com>
In-Reply-To: <20250731183944.GA3424583@bhelgaas>
References: <20250731183944.GA3424583@bhelgaas>
Subject: Re: [PATCH] PCI: Fix endianness issues in pci_bus_read_config()
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Jul 31, 2025, at 20:39, Bjorn Helgaas wrote:
> On Thu, Jul 31, 2025 at 07:38:58PM +0200, Gerd Bayer wrote:
>>  
>> -	if (size == 1)
>> -		return pci_bus_read_config_byte(bus, devfn, where, (u8 *)val);
>> -	else if (size == 2)
>> -		return pci_bus_read_config_word(bus, devfn, where, (u16 *)val);
>> -	else if (size == 4)
>> -		return pci_bus_read_config_dword(bus, devfn, where, val);
>> -	else
>> -		return PCIBIOS_BAD_REGISTER_NUMBER;
>> +	if (size == 1) {
>> +		rc = pci_bus_read_config_byte(bus, devfn, where, (u8 *)val);
>> +#if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN))
>> +		*val = ((*val >> 24) & 0xff);
>> +#endif
>
> Yeah, this is all pretty ugly.  Obviously the previous code in
> __pci_find_next_cap_ttl() didn't need this.  My guess is that was
> because the destination for the read data was always the correct type
> (u8/u16/u32), but here we always use a u32 and cast it to the
> appropriate type.  Maybe we can use the correct types here instead of
> the casts?

Agreed, the casts here just add more potential for bugs.

The pci_bus_read_config() interface itself may have been a
mistake, can't the callers just use the underlying helpers
directly?

      Arnd

