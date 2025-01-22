Return-Path: <linux-pci+bounces-20233-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CCA2A18FB1
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jan 2025 11:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53D257A4746
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jan 2025 10:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACFCD20F970;
	Wed, 22 Jan 2025 10:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="m3wnz0PQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gSN6nQmr"
X-Original-To: linux-pci@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153FE210182;
	Wed, 22 Jan 2025 10:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737541630; cv=none; b=SKifgoYW2OCacuMBUFBzse896pRD4fVma57p447nizLiU5jn1beY38dFV7kMr93jlerSWtaYbf6G32PP7iPdYBUMRbexyH0sgGLb47cDxOXJKZ6O3TGQvyHqLrnD+U/H7JFFHDeH0gxEjrE+lMn2Owlj0btsM9HVfOhQEq+Oedo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737541630; c=relaxed/simple;
	bh=7J0xPIZ8mUgZZDcssZoIAjSddUy9VsI+Lbp4/3hAV/Q=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=YiDMCttik1X1cznFdj5JIaUvOONZEHOUG/muwHGgpYZCV3/D+fF/pOnTbZSQl1KOdkDwBBOuBqVF7/DoXHzYOqufVC5aZdiKQ5iMv7LvTkNp4Dq3liuSOSTYB0CtJxSOkFRMFIjbG4sCPNSjjcaYjOncaq+W85R4hu9nvVVurTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=m3wnz0PQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gSN6nQmr; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id ED52E11400F3;
	Wed, 22 Jan 2025 05:27:06 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Wed, 22 Jan 2025 05:27:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1737541626;
	 x=1737628026; bh=eiUOpdBsr0FKaZdMsZa7RSwQVAkYhLZkXr1SK+XxLB4=; b=
	m3wnz0PQlIGJe9C2kIW8zXexl/AeHssZE2NA/iGffy3NzH/Z3Ck5d5vGyhr0Mmt2
	JLPyn08mOzpWVRQhxeWvJZYC5hhmxLIgbOydNlJjXabGSpQXx5KwGazLWKtEiIGk
	BbcYp+rdNYGk6tW6hp2hFIq7IDfkF7CItvvGwsJhVGVZOe1Y7wdUJIzDhsnAYpGT
	aCVPN7VXfgs3hFQx8GE0X0U9gJJ6/5CA4Z99vxYegTrFgJgI0vm2qwmtXpfiNAvF
	fXOdBxgf2sx9qkzrrPbf72hiYMdzHh0N0xU0wkrnGsT+F8hov18uvl2VmQyXkBU5
	VCtq5pJ7g+yKHq7if/X7Ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1737541626; x=
	1737628026; bh=eiUOpdBsr0FKaZdMsZa7RSwQVAkYhLZkXr1SK+XxLB4=; b=g
	SN6nQmrbQp8UZgviDrqTWL9RNQBpow8VYQppgzDmfinHyu/ID8nu0iB/oetdcri4
	j2ctCC5XZUN26R+EomL1VlVABvzlAXIO5bmwXvUdA/PA6c7RRFPuV6LMC6JxIak7
	A5RY7wtwoeVtWE3yrtzh/Gh+Xx3loKGQ8YyXaAX3lcxwR0vw8/sis0poWaYM8sV2
	0XwaC8gO/GnT8LwewCf2IRNhxPEMxAW0LsN+5GhDmz0cQYFRVWgnjxFF/uBUJ6xF
	6AtfND01WEGZw3hkzaQNrdGn15/i38Yow5IBvRErGyC0HLw1jd1EWXmtoOIm6MWM
	Qtia0ALynmjd6sYqPQiVA==
X-ME-Sender: <xms:-seQZ3GyPyFTyrlg0Te0VbwfDvuxnjjz20gUYfKcU1TyTwcyjwftaA>
    <xme:-seQZ0Wckigc1CFl-eE1hQS1JrsbQwphY9gC6jhRRv65gihGf8RXc_MOuTgeKATb1
    SWQpvDvvlrR1uTR3I0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejfedgudegvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpeefhfehteffuddvgfeigefhjeetvdekteekjeef
    keekleffjeetvedvgefhhfeihfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegr
    rhhnuggsrdguvgdpnhgspghrtghpthhtohepuddupdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopedukedvheehuddujeduheelseduieefrdgtohhmpdhrtghpthhtoheprhho
    tghkshifrghnghejsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptggrshhsvghlsehkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehkihhshhhonheskhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepmhgrnhhivhgrnhhnrghnrdhsrgguhhgrshhivhgrmheslhhinhgrrhhord
    horhhgpdhrtghpthhtohepkhifsehlihhnuhigrdgtohhmpdhrtghpthhtohepghhrvghg
    khhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepjhhonhgrth
    hhrghnhhesnhhvihguihgrrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghl
    sehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:-seQZ5LfztsN7rz4i1_HNa3fhAOO4a63Z8gP8Rl-c08VwoaywNBfYw>
    <xmx:-seQZ1HJbW_b_9JA8PSkTagfPFP1RELTimYd0NtPR11zbcW4cr03Qg>
    <xmx:-seQZ9VBjSVs7hhx8FMg2IzysIFr-GHD__c09pzWHNdeO5NqVnlKbQ>
    <xmx:-seQZwMCjc3-J-MKYnMTWMpDCaqyGLMKcszShQ-MT2ZOScHPvXzFAA>
    <xmx:-seQZ2PzS-j4ErHLLBU5v_R_OrlA-GeCZXCbHlXDG25VYgl_CTMwSWQe>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 721082220072; Wed, 22 Jan 2025 05:27:06 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 22 Jan 2025 11:26:46 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Niklas Cassel" <cassel@kernel.org>
Cc: "Hans Zhang" <18255117159@163.com>,
 "Manivannan Sadhasivam" <manivannan.sadhasivam@linaro.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 "Kishon Vijay Abraham I" <kishon@kernel.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, rockswang7@gmail.com,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 "Jon Hunter" <jonathanh@nvidia.com>
Message-Id: <a5a6677f-f2dd-4ff6-ab46-3a28f1d1487c@app.fastmail.com>
In-Reply-To: <Z5DDZnRX3H7RZR5S@ryzen>
References: <20250109094556.1724663-1-18255117159@163.com>
 <20250109094556.1724663-3-18255117159@163.com>
 <7474af29-2995-48f6-830b-a23dad2d2bd1@nvidia.com> <Z5DDZnRX3H7RZR5S@ryzen>
Subject: Re: [v11 2/2] misc: pci_endpoint_test: Fix overflow of bar_size
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Jan 22, 2025, at 11:07, Niklas Cassel wrote:
> On Tue, Jan 21, 2025 at 05:46:43PM +0000, Jon Hunter wrote:
>> > diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/>> 
>> 
>> This change breaks building the kernel with GCC v7 and I see ...
>> 
>> ERROR: modpost: "__aeabi_uldivmod" [drivers/misc/pci_endpoint_test.ko]
>> undefined!
>> ERROR: modpost: "__aeabi_ldivmod" [drivers/misc/pci_endpoint_test.ko]
>> undefined!
>> 
>> I know that this is an old GCC version, but this is a farm builder and the
>> kernel still indicates that GCC v5.1 is still supported [0].
>
> do you have any idea what is going on here?
>
> I'm a bit puzzled, since looking at other reports of this error,
> e.g.:
> https://lore.kernel.org/all/20241018151016.3496613-1-arnd@kernel.org/
>
> using div_u64() is usually the solution for this problem (for things that
> are not performance critical), not the cause of it... any ideas?

I have tried to look at the email thread, but not tried to reproduce
it yet. I have two ideas about what might be happening:

a) something causes a /different/ division to call into
   __aeabi_uldivmod(), not the one from div_u64().

b) the compiler notices one of the arguments to div_u64() being
   constant in some cases and splits the calling function into
   two special cases, for both the constant and non-constant
   cases. This sometimes confuses the __builtin_constant_p()
   in do_div() that decides to fall back to a 32-bit division.

Try looking at the .s file when you run 
'make drivers/misc/pci_endpoint_test.s' to see where exactly it
calls the two division functions, maybe you see the problem then,
otherwise I can try to reproduce it here.

    Arnd

