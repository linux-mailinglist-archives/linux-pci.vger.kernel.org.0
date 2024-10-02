Return-Path: <linux-pci+bounces-13708-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B9E98D022
	for <lists+linux-pci@lfdr.de>; Wed,  2 Oct 2024 11:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1177D1C2167D
	for <lists+linux-pci@lfdr.de>; Wed,  2 Oct 2024 09:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073741C68AA;
	Wed,  2 Oct 2024 09:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="fgAVgRu/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B0Jzg89B"
X-Original-To: linux-pci@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E7C1C2DBE;
	Wed,  2 Oct 2024 09:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727861411; cv=none; b=GFiuDKY0raax611dSgmVYTcJpFp+nsEsiEhrLKc0cxD+Er7PSCEsNBX4OC4nU4rZhJHjrb7U9CV+VmqN3vH8efpcB9/QTWfHejuTH7rL4l/IZt+EQbKExjlETLzVOL9SSGr44MM5sd7IlLJqmdU+RiuegrdgSqNXQ6H1nxisdKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727861411; c=relaxed/simple;
	bh=F4uPivEyvqmkg6qk17zm92vr+Ef3iWGqwQwnGh0igRQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=l1BR1iwKx1afh+GQTsJFtLLtwPC0R7xRBoSWgbdnQHvjKIYOgnTKmF0F1ZnX6ILGoGnHz1HqTbmx3hQKp24zZJ9b9J6RqfbZitY9QpiUHv0p6FOP8Jwti0xTxDB4BYIMwP7kvC5PAgRRUkhs5yjjnwYLZmb/iiw1t6TeK73K38w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=fgAVgRu/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B0Jzg89B; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 811A71140206;
	Wed,  2 Oct 2024 05:30:08 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Wed, 02 Oct 2024 05:30:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1727861408;
	 x=1727947808; bh=6ZaWIYHqvT0trQqwJl3ZdMtJTTyJ1btUIeNi3HbNeug=; b=
	fgAVgRu/VUQIL4YZtZuzBdiFaeoz3UW6cC7LmRVM8T+OlEbJHGLY1i0CrTo6CJw5
	TuUWSH8WM2OB1q652bkIDHhhUdo0GLYLEY443Wt+7J8Jmzf1HPlZG0PNRzOdUuto
	0lMTrJPQR917Z5ln9n0io9ZtkjUgjr+h1Fkk1NG3X9XI2LdSLKR/4c83MpyqhNk6
	hv6/tuZgHNqeUMZDvsacfU0SwC0W4RXcEU0FMgYRC+lFkcCg+nc2d9q6dofGh5AE
	7cH1w7Eu3wcAb+39Q65/sZPjDO9TzOLsPMlYelpNuzPRt8At/mVqniE0JbzOWdXo
	K0zIRzc25TUuf20qEdPTGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1727861408; x=
	1727947808; bh=6ZaWIYHqvT0trQqwJl3ZdMtJTTyJ1btUIeNi3HbNeug=; b=B
	0Jzg89BPUPIBWeZB3g4Ne4Wmf9+BiU59cdYm8JRlfd0EMBr4Bt+EOLgqCu74kr6K
	x2CVBGXJGdXkIdS44rk6A5T0gPWPE2rmPi9CSCj6Tyl2aQ1cFB6MAg+DJE9ymLfj
	IEWYZlqqQfS0S4vaEogzhEltfI1Mwp7bPFQ9tO2CfN0Nm2vJ34d9gcrTgwCNjcIN
	3QV8mL7CM5AhODdrYk58l73LQ1p9oqc40E68seNLfJmZfsvlBQAu9RdtzHclrOdl
	h4UFl418uBDjLTc5KCdDRryNEvjxAi3pcw74YhZGdQcTSA63kV5nIY5c3OHzuCdq
	zhIzsN7ABzwlpuDdi4nCw==
X-ME-Sender: <xms:nxL9ZoT_CgYCUfSRQJsgX-S-8_CGEH4M-pC79GqeoGRRkHGZKENrqA>
    <xme:nxL9Zlx_5cHSFIIK51Vz7UDLtM24UvdGIBh52r6tzUIeLGaPMF4ML9yO73Ha6lHUm
    3IvlZ2smgDeWEjviHk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduledgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhepvdfhvdekueduveffffetgfdvveefvdelhedvvdeg
    jedvfeehtdeggeevheefleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
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
X-ME-Proxy: <xmx:nxL9Zl06VOcrBeoF6pwyXEozUaLhRo5uaN-WsJ-r_zeQd1nvOOc9Yw>
    <xmx:nxL9ZsDT6-MQasEkI4Gr0_eD215kT0GxDEPm-JXQyGxZdlROfLuMvA>
    <xmx:nxL9Zhht69zyf2l6upRWSDQlUtb7VYlG5oHIrIyXe85wQtxpBVjYQQ>
    <xmx:nxL9ZoqfR3cVJRIK4tsYrtczQ7WvNJZ9MkBLXLJQHt9dLuhoVIQUhw>
    <xmx:oBL9ZsPdlsnGTgWuo_6eKK1tH3TkpfLhEVyZ1nS4p-m9m0BMxVBxUtn->
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 2881B2220071; Wed,  2 Oct 2024 05:30:07 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 02 Oct 2024 09:29:35 +0000
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
Message-Id: <bd40a139-6222-48c5-ab9a-172034ebc0e9@app.fastmail.com>
In-Reply-To: <20241001183038.1cc77490@bootlin.com>
References: <20240930121601.172216-1-herve.codina@bootlin.com>
 <20240930121601.172216-3-herve.codina@bootlin.com>
 <d244471d-b85e-49e8-8359-60356024ce8a@app.fastmail.com>
 <20240930162616.2241e46f@bootlin.com> <20241001183038.1cc77490@bootlin.com>
Subject: Re: [PATCH v6 2/7] reset: mchp: sparx5: Use the second reg item when
 cpu-syscon is not present
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024, at 16:30, Herve Codina wrote:
> On Mon, 30 Sep 2024 16:26:16 +0200
> Herve Codina <herve.codina@bootlin.com> wrote:
> --- 8< ---
>
> In mchp_sparx5_map_syscon(), I will call the syscon API or the local
> function based on the device compatible string:
> 	--- 8< ---
> 	if (of_device_is_compatible(pdev->dev.of_node,=20
> "microchip,lan966x-switch-reset"))
> 		regmap =3D mchp_lan966x_syscon_to_regmap(&pdev->dev, syscon_np);
> 	else
> 		regmap =3D syscon_node_to_regmap(syscon_np);
> 	--- 8< ---
>
> Is this kind of solution you were expecting?
> If you have thought about something different, can you give me some po=
inters?

Hi Herv=C3=A9,

The way I had imagined this was to not need an if() check
at all but unconditionally map the syscon registers in the
reset driver.

The most important part here is to have sensible bindings
that don't need to describe the difference between PCI
and SoC mode. This seems fine for the lan966x case, but
I'm not sure why you need to handle sparx5 differently here.
Do you expect the syscon to be shared with other drivers
on sparx5 but not lan966x?

I don't thinkt this bit matters too much and what you suggest
works fine, I just want to be sure I understand what you are
doing.

      Arnd

