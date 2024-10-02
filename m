Return-Path: <linux-pci+bounces-13711-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2245B98D1D1
	for <lists+linux-pci@lfdr.de>; Wed,  2 Oct 2024 12:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A5CD1C20E27
	for <lists+linux-pci@lfdr.de>; Wed,  2 Oct 2024 10:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88508200113;
	Wed,  2 Oct 2024 10:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="SEK2BTr1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="evMpYrSi"
X-Original-To: linux-pci@vger.kernel.org
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3126319D07D;
	Wed,  2 Oct 2024 10:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727866718; cv=none; b=sIOjNbxphgbybS/l3aGFZ61foxPrMsdt0V3sCAA58jL9cdnlmsFnyiInv+zPiE1SNtp/ufKPi6Tb9nJxGcXj7wvroWvNkMqQGtrqa6kvi5Hg8y4eS05MxVV3hYb94Ulp6y1YhLg8SFm15T33rW8wqD0WT3lusIRz40kKRxoI0Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727866718; c=relaxed/simple;
	bh=4vFwnNPpmHyTPToeDrBdVgUAamCUW30oGc8DaS53qnw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Fq4qNx9ZE2H8RnoQAHOFOBgYh8arGXW+g30OpyhR8gLwN2ZHcp7L3AEuU9kf5b0bR8MLYWqadHEEZLBN49alC+M2ljfCij/BCp2DK4ZFU0xeNgjJdXwyissetrS2kWe97xkSMM8WGzZktwRnchZXyjLxwCsgVibGWzMlnUxaitE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=SEK2BTr1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=evMpYrSi; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 51E451380554;
	Wed,  2 Oct 2024 06:58:35 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Wed, 02 Oct 2024 06:58:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1727866715;
	 x=1727953115; bh=3PgC2ig0zG3RLRqTe6L/apCO0Mah4/hfhEiKjGfQW7E=; b=
	SEK2BTr1rAX6MfZYSG8+jfPoOFrsnbcImBk8GG9uzHKXKZJuFFIV9WwwrMWYiPn9
	GIfUPXVDmFonvWmjEbYXjLDEHsPjotBcvmYNWJy93vm+l2QtIGzdtiKTpYRE3Rma
	NCMUQhOh9bftY+zmA8zEkg8KqWRnp5yvyiLobV01T1EMjTXfNCQC08CsRwh1g6AV
	Csq5wLgCYJx3gL2jjqYJJ6KHRWySGklgkEkdmh62qt6JtVHqFU1a98+7Ch5aFW0/
	zKuNk1+mVebhUqMrUk1KtxFM+5wmLi+Q9qnnjLtq9x7fFEnUDx6LxfNsKnGZOn1v
	9jeOkZAMSVmLoNYe0Wt1og==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1727866715; x=
	1727953115; bh=3PgC2ig0zG3RLRqTe6L/apCO0Mah4/hfhEiKjGfQW7E=; b=e
	vMpYrSisR0DULODq3UhkXZ5BPP5iEYgMJ0j3/dwxLqLPwIDUG3MuiA7C90cJ4DW4
	moFnBvMA4rJ7SCWQS/F3PpEWD1Dd1oRZhM6Jz6kXH50BA/UBBowmf2qi3ggEdaz6
	Vad6uwAFdq5mhD+sxIsYQ/mqEmLtV7634LpK6nE6P2920oNXCDIeuVQPnNWajLqX
	BnqoBGErzfpTPMPm2DzaPfDJPdJ8e11U1gAAvZbcGq+ySGB5R6WVvpxMTJL8zKA7
	Gr1sFh225lpQlIqJkxJbZJEkmy0bmdw6NXJ8ZVcSY60fLa49ArDvBfiH8CkGx5y0
	HGKCmVJTYfXD8yc0I4wyQ==
X-ME-Sender: <xms:WSf9Zshyyk8bpUIXYuABpHLjqLbVGZlzshgDiVY9VlPZGnEBks4eGw>
    <xme:WSf9ZlCrqGTnyTqesLLGjbMtD3IoTWF2do_akVYLXvjvMe4qvQsGAnGfYc7QFaark
    Z1OL2tUKz_YJvJtTk0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduledgfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefg
    gfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepfedv
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeguvghrvghkrdhkihgvrhhnrghnse
    grmhgurdgtohhmpdhrtghpthhtohepughrrghgrghnrdgtvhgvthhitgesrghmugdrtgho
    mhdprhgtphhtthhopehhvghrvhgvrdgtohguihhnrgessghoohhtlhhinhdrtghomhdprh
    gtphhtthhopehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmpdhrtghp
    thhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhmpdhrtg
    hpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegrnhgu
    hidrshhhvghvtghhvghnkhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepsghhvghlgh
    grrghssehgohhoghhlvgdrtghomhdprhgtphhtthhopegvughumhgriigvthesghhoohhg
    lhgvrdgtohhm
X-ME-Proxy: <xmx:Wif9ZkEp26rbnIn2jp59vKVnSxktSsF06cFqvtADU9BS1Nc_TNGNrw>
    <xmx:Wif9ZtRiMFFIBbqQ4s9f1GlxOreH06e9-cGyx-ys_KAEc4QyOMoVrg>
    <xmx:Wif9ZpxQGDo3K98z_zQKtG6fA-6sPc8p-btQrtco4cKehnDG_g6oqA>
    <xmx:Wif9Zr4Wfa1TozUSW8Tpvg0o6Xs3_m9KamAHtbOQo55e18151wai8g>
    <xmx:Wyf9ZjdekCknkTcY6CZYhAy5eQf7KTkgbHY1rwllPpbasfYZjOwyvucb>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E09DA2220072; Wed,  2 Oct 2024 06:58:33 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 02 Oct 2024 10:58:13 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Herve Codina" <herve.codina@bootlin.com>
Cc: "Geert Uytterhoeven" <geert@linux-m68k.org>,
 "Andy Shevchenko" <andy.shevchenko@gmail.com>,
 "Simon Horman" <horms@kernel.org>, "Lee Jones" <lee@kernel.org>,
 "derek.kiernan@amd.com" <derek.kiernan@amd.com>,
 "dragan.cvetic@amd.com" <dragan.cvetic@amd.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Bjorn Helgaas" <bhelgaas@google.com>,
 "Philipp Zabel" <p.zabel@pengutronix.de>,
 "Lars Povlsen" <lars.povlsen@microchip.com>,
 "Steen Hegelund" <Steen.Hegelund@microchip.com>,
 "Daniel Machon" <daniel.machon@microchip.com>,
 UNGLinuxDriver@microchip.com, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>,
 "Saravana Kannan" <saravanak@google.com>,
 "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>,
 "Horatiu Vultur" <horatiu.vultur@microchip.com>,
 "Andrew Lunn" <andrew@lunn.ch>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Netdev <netdev@vger.kernel.org>,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 "Allan Nielsen" <allan.nielsen@microchip.com>,
 "Luca Ceresoli" <luca.ceresoli@bootlin.com>,
 "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>
Message-Id: <3029e115-e5d5-4941-a87e-26bf31341f0d@app.fastmail.com>
In-Reply-To: <20241002121957.1f10bf8e@bootlin.com>
References: <20240930121601.172216-1-herve.codina@bootlin.com>
 <20240930121601.172216-3-herve.codina@bootlin.com>
 <d244471d-b85e-49e8-8359-60356024ce8a@app.fastmail.com>
 <20240930162616.2241e46f@bootlin.com> <20241001183038.1cc77490@bootlin.com>
 <bd40a139-6222-48c5-ab9a-172034ebc0e9@app.fastmail.com>
 <20241002121957.1f10bf8e@bootlin.com>
Subject: Re: [PATCH v6 2/7] reset: mchp: sparx5: Use the second reg item when
 cpu-syscon is not present
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Oct 2, 2024, at 10:19, Herve Codina wrote:
> On Wed, 02 Oct 2024 09:29:35 +0000

> Thanks for this reply.
>
> Exactly, on sparx5 syscon is shared...
> $ git grep 'microchip,sparx5-cpu-syscon'
> ...
> arch/arm64/boot/dts/microchip/sparx5.dtsi:                      
> compatible = "microchip,sparx5-cpu-syscon", "syscon",
> drivers/mmc/host/sdhci-of-sparx5.c:     const char *syscon = 
> "microchip,sparx5-cpu-syscon";
> drivers/power/reset/ocelot-reset.c:     .syscon          = 
> "microchip,sparx5-cpu-syscon",
> drivers/spi/spi-dw-mmio.c:      const char *syscon_name = 
> "microchip,sparx5-cpu-syscon";
> $

Ok, got it. In that case, your suggestion looks fine.

       Arnd

