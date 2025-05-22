Return-Path: <linux-pci+bounces-28256-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2C8AC049D
	for <lists+linux-pci@lfdr.de>; Thu, 22 May 2025 08:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAEA34A057A
	for <lists+linux-pci@lfdr.de>; Thu, 22 May 2025 06:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D7B1B21AD;
	Thu, 22 May 2025 06:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="auLSngXo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QKxg8xq+"
X-Original-To: linux-pci@vger.kernel.org
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31211A5BA2;
	Thu, 22 May 2025 06:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747895593; cv=none; b=qFc4xLzwjnBeELN+LRdWvyGKFYgyWxDDRSLpfVkN1p9Wgmi7CYdsL8o8SJBlDPZgE7Cm5Aw0S9ATh05LgLIn2jR87QRBfCEJ9aPKOMOnfanL5U2qy7cVV2Lmru2YolTLqsTYneZ+osa3GhtrFD14yXm88g68tKtxoiHsBjl0V4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747895593; c=relaxed/simple;
	bh=ntk5Ubl42GNcRLeUmofXZQYlp86nlzOBOGux945yP5I=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=KXQeYIna/wNB+NpZSA/kW84CEBWkGqw820YL6Liz1mtKUbgqgsyp7b6q7DGA3QaKETj1ByCq/Qzplkl941tsnbIM/nq771RkBVAnY7fIAfVDOo9Whxu59NvlmlOLODdnN+9xLPjC+WyJjSm2tDPAuYf/zkjqv2HFJp+ThUL10vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=auLSngXo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QKxg8xq+; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 8D448138045A;
	Thu, 22 May 2025 02:33:07 -0400 (EDT)
Received: from phl-imap-12 ([10.202.2.86])
  by phl-compute-05.internal (MEProxy); Thu, 22 May 2025 02:33:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1747895587;
	 x=1747981987; bh=vMGUoZzGgqy12ZDjUuXY6i1U+XhJq0NsYCP29BFtS7g=; b=
	auLSngXoC44z/CnF2qGq6nzaBq75DsiePdpeRoW2P+46L69um6K5qWoAiSliD57z
	Kdo1koXaAzJgoBqScd4QkuwnpaAFxWUN4xpvm+bXwxyJY1iNSWXW8U6WA5xqzrOt
	mW50YgUl70nXStPTlqAKKZi2haq+7hYgmXEijpCvzC0bgQKUjDesLpTqGj1hDksX
	G9efGBJWyPilPle7EFm/aosekG6HD6pz0LXr7Z+GGPWUoWQ2w2s8jYmOXrdelTb0
	bHoZcpeYdXPWcNKT7VtTtcaFqQVVrALP3tfxsqyv8umc9xwDnWj7ekVOdX3LacJz
	aABqpcPd9NUKDuQ2NoA7Fg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1747895587; x=
	1747981987; bh=vMGUoZzGgqy12ZDjUuXY6i1U+XhJq0NsYCP29BFtS7g=; b=Q
	Kxg8xq+5a4dzwEObu1vdpZUgrBu5QTbqr0ojZ7AcmxqpcVeyUVYgPt/PON+iu7zV
	UpvlsWH2qrZcWDH1csqlJNsChDocipkAaCIyJezPPuVfnPFaFYXb+nHzbK4qeA0/
	EWksBpL6Nc/WPWJFAVakYgEQVUFl4yhkVqPKU1OuJ4NrRppLc+mGDy5SzMwf3sEJ
	TUZ9y/EawoGLCJLYaJwj5jVCU8tKD5aIvIfV6nZIvjvI27wL76GGMcPhQG0k2qHH
	4Cw9471EiWDtqgY2xAJYiAAWAMyb65uKJy8oACd2u+RqNPgE8dItfbHp2Yna01qF
	xZtzm9cvtiPUGW5RSucyQ==
X-ME-Sender: <xms:I8UuaEUovyb_wGOoCBRUQfAGSgZj9OAxFjsvBnegT-BSz68E9KEYxA>
    <xme:I8UuaIk_JHuR48hr4r0XHISEmhdFvx-1GKf4ICz_6y7JyX574jbLdnyhqUAtKETUT
    4A58miSxeBirE5Xauw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdehvdehucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgj
    fhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuc
    eorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedu
    keetgefggffhjeeggeetfefggfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdp
    nhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsghhvg
    hlghgrrghssehgohhoghhlvgdrtghomhdprhgtphhtthhopehjohihtggvrdhoohhisehi
    nhhtvghlrdgtohhmpdhrtghpthhtoheprghrnhgusehkvghrnhgvlhdrohhrghdprhgtph
    htthhopehjihhrihhslhgrsgihsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehtghhl
    gieslhhinhhuthhrohhnihigrdguvgdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlh
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhptghisehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:I8UuaIZ7MFfyOeKVSz5qL7N-eJfmK_mUSSKO6yGk7bvP-W2tYRPmQw>
    <xmx:I8UuaDVoCgcjAbyLwRag84XWpRBZj4M1I_6RQTqLWEUPyge_GpbAcw>
    <xmx:I8UuaOnALZxH_94VjHKNMSVwQ55i8XgZk6xBayfbogln-0VL7QaIcg>
    <xmx:I8UuaIcVfwCuU6Qxu26bJVpx_9Qi_f2oRsknADVI55zp8oSDOuW-Fw>
    <xmx:I8UuaPmn7PppwHlSQdS1micjhNbwhZgnl89Ss6fF1sHVZNSc8jsvmF5U>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 134901060061; Thu, 22 May 2025 02:33:07 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Te25cda601bfc812c
Date: Thu, 22 May 2025 08:32:46 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jiri Slaby" <jirislaby@kernel.org>, "Arnd Bergmann" <arnd@kernel.org>,
 "Thomas Gleixner" <tglx@linutronix.de>
Cc: "Joyce Ooi" <joyce.ooi@intel.com>, "Bjorn Helgaas" <bhelgaas@google.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <beb25d1b-e7d9-4de9-83f6-4b6bf6616bda@app.fastmail.com>
In-Reply-To: <e926d3ba-5ed2-4942-b928-a969ca085f63@kernel.org>
References: <20250521163329.2137973-1-arnd@kernel.org>
 <e926d3ba-5ed2-4942-b928-a969ca085f63@kernel.org>
Subject: Re: [PATCH] pci: altera: remove unused 'node' variable
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, May 22, 2025, at 07:53, Jiri Slaby wrote:
> On 21. 05. 25, 18:29, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>> 
>> This variable is only used when CONFIG_OF is enabled:
>> 
>> drivers/pci/controller/pcie-altera.c: In function 'altera_pcie_init_irq_domain':
>> drivers/pci/controller/pcie-altera.c:855:29: error: unused variable 'node' [-Werror=unused-variable]
>>    855 |         struct device_node *node = dev->of_node;
>> 
>> Use dev_fwnode() in place of of_node_to_fwnode() to avoid this.
>
> Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
>
> Right, this reminds me that my dev_fwnode() patches (in my local queue 
> -- they were supposed to be in v3) are not only cleanup, but also fix 
> warnings.
>
> I was thinking to send those after the merge window (so that I can route 
> through subsys maintainers and not bother Thomas, as they touch many 
> files [1]), but I will send them when I am back from a conf.

Ok. As far as I can tell, my two patches (mfd and pci) touching
four of those files are sufficient to address all the warnings
I see on x86, arm64 and arm. I came to the same conclusion about
being able to do more as cleanups but not needing them before the
merge window.

I also checked the power and mips specific files in your list
and they should be warning-free as far as I can tell.

       Arnd

