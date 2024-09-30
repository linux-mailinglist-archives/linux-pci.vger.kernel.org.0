Return-Path: <linux-pci+bounces-13650-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B324A98A67A
	for <lists+linux-pci@lfdr.de>; Mon, 30 Sep 2024 16:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3726F1F245CE
	for <lists+linux-pci@lfdr.de>; Mon, 30 Sep 2024 14:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717E21917D9;
	Mon, 30 Sep 2024 13:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="TC23zq9t";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mD2kZMYW"
X-Original-To: linux-pci@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784271917D6;
	Mon, 30 Sep 2024 13:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727704646; cv=none; b=ZOy9xbLMRFGbcnsUF4saOz99gXbaufBk43Edcs3hI00QrUb312m37+pPutZdtAylwN/II57nxaEKCPl6hF8Ji2/mTGUiwz6KLOPITTbu97I75+toEkxxmdmAXHcaSsYjmz0W77uHks8uZvUZRKdxRlZgUgjL0gTcfrSvD6719P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727704646; c=relaxed/simple;
	bh=QCBFPxmVRNOK/b5sAejjKo7owEzuauLEMn65u4OcpX4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Gg4KXtlcKZeI+hLZF4R7rv0kjdQzkP8JoOGxQML0ygQwj63ATIy3uWinltiPo1rK01g0Ixh7YRC30ddaSPC/CPtoo4TqUnij7SLMokZLQAGu+YXPyUrufrUKdnYA3+s15qOx4UXk2vwCHP9YTPxu69L7YzCfZCAxG4zdhVVoq3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=TC23zq9t; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mD2kZMYW; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7A1FF114018C;
	Mon, 30 Sep 2024 09:57:22 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Mon, 30 Sep 2024 09:57:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1727704642;
	 x=1727791042; bh=NSoee6bnuXvKPKgroQdbhisM+ZgHsKn6G++bqEuUpII=; b=
	TC23zq9tLXqdZxR06X0WFKYbIy2lR3mJat6QcJZ/MAajqfZXHGuGxe+c1XWI3Pu1
	tpq+3VPIKbc0BeTM2Ushzya6wy+U8i83bQyMrAoXxM4lozwEzrJWHz1hC0EqunmU
	qhJVtHiUBJ5dyXvVbC6ZWcIFqklYqDLiJpQ16FExILkQCJw9/3hfkac6ZP/4iORZ
	cZHT5o6G2fXc8kbnqFIIligMGofkv6iGsmcn7IjSgKZm9UpsRr1G3K90jCo4tGhZ
	NhZdVke7Xk1WZAKhwU84PKgdWYq7qdm7tc+fRhqJh+wPiTbZzd549kR/z/t6L0Hd
	0nfVU3YUYhzgXg7RDlYYIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1727704642; x=
	1727791042; bh=NSoee6bnuXvKPKgroQdbhisM+ZgHsKn6G++bqEuUpII=; b=m
	D2kZMYWXZfVGZrOtcv0kDYhn/14fNJ1OzgERlC6nRndDe9BvQdiVsUUGwvQp8i7e
	KYyRO72YwSJg/8ATl8ra+wzKT505zW1OhQzB9YCPvTWjgUjGdJ33qukTCetPr8Ct
	zghv9YOXom6UbyH6qhQqEbKJ/tDLjcWXACsmiiHraQ3rXTrvZTAgNCKVF6hmDMud
	Hrt/xrbwfv4lvttGRW0CZNE+k6tsniYFoZsAe/rKtDVxNx+fnpzNzlxYU6i7YUYz
	bUh5if0Af19I5z4K41neztAQvG4ch0weCUiyI3W2y+DAPCv30rqU0QDQtqNdAvmC
	3APCmfz6A5F7bAIy6HlFw==
X-ME-Sender: <xms:Qq76ZtcMD1VHOm_5tgmyNUUJTYiHejXNafbh_6vC9t2ZZPAVgClcKA>
    <xme:Qq76ZrO9G01KMxPz2hziRapL4rOTnD3sOKY220otwJf3AMTZM2VdN3ksRbbJdKVjP
    c8pXNeRnbUDTvnjxyM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduhedgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhepfefhheetffduvdfgieeghfejtedvkeetkeejfeek
    keelffejteevvdeghffhiefhnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghr
    nhgusgdruggvpdhnsggprhgtphhtthhopeefvddpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepuggvrhgvkhdrkhhivghrnhgrnhesrghmugdrtghomhdprhgtphhtthhopegu
    rhgrghgrnhdrtghvvghtihgtsegrmhgurdgtohhmpdhrtghpthhtohephhgvrhhvvgdrtg
    houghinhgrsegsohhothhlihhnrdgtohhmpdhrtghpthhtoheplhhutggrrdgtvghrvghs
    ohhlihessghoohhtlhhinhdrtghomhdprhgtphhtthhopehthhhomhgrshdrphgvthgrii
    iiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopegurghvvghmsegurghvvghm
    lhhofhhtrdhnvghtpdhrtghpthhtoheprghnugihrdhshhgvvhgthhgvnhhkohesghhmrg
    hilhdrtghomhdprhgtphhtthhopegshhgvlhhgrggrshesghhoohhglhgvrdgtohhmpdhr
    tghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:Qq76ZmjvotPzzy6o4IjTfEWR1Ae1ZZZZ6nNQSKX7qnPLT0IG38l1SA>
    <xmx:Qq76Zm_LOqj4ciNOWbaMWYb-D0OvO5_n4Ih7TGFh2jhHae1ThBZXCg>
    <xmx:Qq76ZpscZnyHVWm5vJL_KaNhoZQUCYXtiIgim11BL25IToQMXpkyzQ>
    <xmx:Qq76ZlEM-P5HUNSqZ7juqxINfjRi5uysuuE6F8FlFVFYe6WkE5UoGA>
    <xmx:Qq76ZnpXwJQdtwlwl7OqZcRUBrXUnWJ1ApxdtT2tFL4K14X2Po1AFe7b>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id DE1282220071; Mon, 30 Sep 2024 09:57:21 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 30 Sep 2024 13:57:01 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Herve Codina" <herve.codina@bootlin.com>,
 "Geert Uytterhoeven" <geert@linux-m68k.org>,
 "Andy Shevchenko" <andy.shevchenko@gmail.com>,
 "Simon Horman" <horms@kernel.org>, "Lee Jones" <lee@kernel.org>,
 "derek.kiernan@amd.com" <derek.kiernan@amd.com>,
 "dragan.cvetic@amd.com" <dragan.cvetic@amd.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Bjorn Helgaas" <bhelgaas@google.com>,
 "Philipp Zabel" <p.zabel@pengutronix.de>,
 "Lars Povlsen" <lars.povlsen@microchip.com>,
 "Steen Hegelund" <Steen.Hegelund@microchip.com>,
 "Daniel Machon" <daniel.machon@microchip.com>, UNGLinuxDriver@microchip.com,
 "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>,
 "Saravana Kannan" <saravanak@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>,
 "Horatiu Vultur" <horatiu.vultur@microchip.com>,
 "Andrew Lunn" <andrew@lunn.ch>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Netdev <netdev@vger.kernel.org>,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 "Allan Nielsen" <allan.nielsen@microchip.com>,
 "Luca Ceresoli" <luca.ceresoli@bootlin.com>,
 "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>
Message-Id: <d244471d-b85e-49e8-8359-60356024ce8a@app.fastmail.com>
In-Reply-To: <20240930121601.172216-3-herve.codina@bootlin.com>
References: <20240930121601.172216-1-herve.codina@bootlin.com>
 <20240930121601.172216-3-herve.codina@bootlin.com>
Subject: Re: [PATCH v6 2/7] reset: mchp: sparx5: Use the second reg item when
 cpu-syscon is not present
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Sep 30, 2024, at 12:15, Herve Codina wrote:
> In the LAN966x PCI device use case, syscon cannot be used as syscon
> devices do not support removal [1]. A syscon device is a core "system"
> device and not a device available in some addon boards and so, it is not
> supposed to be removed.
>
> In order to remove the syscon usage, use a local mapping of a reg
> address range when cpu-syscon is not present.
>
> Link: https://lore.kernel.org/all/20240923100741.11277439@bootlin.com/ [1]
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---

>>  	err = mchp_sparx5_map_syscon(pdev, "cpu-syscon", &ctx->cpu_ctrl);
> -	if (err)
> +	switch (err) {
> +	case 0:
> +		break;
> +	case -ENODEV:

I was expecting a patch that would read the phandle and map the
syscon node to keep the behavior unchanged, but I guess this one
works as well.

The downside of your approach is that it requires an different
DT binding, which only works as long as there are no other
users of the syscon registers.

     Arnd

