Return-Path: <linux-pci+bounces-8916-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF4790D7B3
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2024 17:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3311B289E5
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2024 14:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C2A80624;
	Tue, 18 Jun 2024 14:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="WspiMbRv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uSdJsRMC"
X-Original-To: linux-pci@vger.kernel.org
Received: from wflow4-smtp.messagingengine.com (wflow4-smtp.messagingengine.com [64.147.123.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F93F2139AC;
	Tue, 18 Jun 2024 14:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718722436; cv=none; b=UKuzgySjuOxw5gurUeId6BMOt+1Np0GCurZp3/telG3nQy6+aOnY/c3GiD2uCqcRdrLAkD2JJ5jvsACqHCWhHQffgn9S4Cl+tJR5UeWO05/IkGleMcyVC6zRWMzM5lnz8BGNezbAGVLasGCl+pP6tLz+GQCA6MxkHcZ5lM9eH4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718722436; c=relaxed/simple;
	bh=0UMGObr4c/PBQHn9Sn0+mxPAO48JSjyOWOHPtEQMc6w=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=ZlM1WlOxsLwntvlEXf9Y6KN6qtiIyxVHKPl4INpDgRNmWQxZ9hxh28bamMmGM8s7c5dmjaadPVxGeE1X4TdBCsoXCqUcUO6cy6exg0RNKOHYFQ5mNl1o/80eQeF3GPo7xXpVEOdGrjBOlXZAvDE1jTkx+4qTi1tPBqgfFZ8NkKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=WspiMbRv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uSdJsRMC; arc=none smtp.client-ip=64.147.123.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailflow.west.internal (Postfix) with ESMTP id 2BF1B2CC008B;
	Tue, 18 Jun 2024 10:53:52 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 18 Jun 2024 10:53:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1718722431;
	 x=1718729631; bh=kcbpkU2iZLW5TZK6Y8fCG83H86YT8jkb38ChT7Si83Q=; b=
	WspiMbRvMrVrg++N2gk/7bMfurwgpyJQrB/7lc+1YEwlRfvr4+qL9B0ikSP8MiwZ
	bOf/1288yHNN7pUb2/ZXFD8tcsgG1tOO4q93G+RKxziKKZTHDaaWUaMkeyMGJgHP
	VC+llVVnYIIO81/+4OHhhqHZXKu2vrLiTwlfOEgPZsaAijneWDt4g2DkxVByalVf
	vVcCURoBNMdgH7jsLAbvCzVHSD1HBJ5VsfqEA5CQlFBwkPSgQFN60dbdGKHQ502k
	lbLmzPIY5v8Rf5CKlUcCbyCB5BvQawKfsyPQz4zHMfHmtwDYwfuJtvP8xv2gkstM
	Jwx6N0nhZNqHpbSlbg2t9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1718722431; x=
	1718729631; bh=kcbpkU2iZLW5TZK6Y8fCG83H86YT8jkb38ChT7Si83Q=; b=u
	SdJsRMCljw9dO6nRoqCRSbf3v1s9J8J5tOv4uHC2y8Cq6yNQu9DuoFSmo+hn8+27
	Gnjf7YDeIpmK+v6RVeRnUVrWpVHDzDec8Vnn7OcYN4GGhV43IAW4ZzM8Lu80yqpc
	FLoBRsdIjjQUvYiKUXlcAxocWkX5woTqsidcHIN/LCV6x+oOQm4Vs/Z7S5Rbc8Uu
	+lTlCMygk0vqoy0R6aXMtxUDDSxPBgPf0XpPrgKlvSFD0TUH/3U15WeoPxKn0cJl
	uuN2liSFCvgABbntR+rfWipIQYpwtix+ygKcBSDlhxdw+2yjXkWRy1hcwjO61/Nh
	a946buU4gjAzI+icNiv7g==
X-ME-Sender: <xms:f59xZgWKesXdDDG9K0Vrq96WT5Oy7q7o8pUvafCCOmZ43RoRB0UvNQ>
    <xme:f59xZklevwcfy6odWy_nPKhGPoibZW-_74-6smhGai-UNWVe1R-YdGsvvvT-KxJrT
    Gy_Gths9f98TOTfu-k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedvkedghedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:f59xZkYT3Wv9xpWIF_mEBkOGqxDRYSAjUTMUVwrEsnCGtHPFZBtUNg>
    <xmx:f59xZvWE3UnO86LAHE9USvBALm8vQFXpk_cY9ZN0D_LcK8RUHCnJJQ>
    <xmx:f59xZql-5bziqCYF6a0PJwLdsUXs224hiyD-x4D2I_NuvMLZjO4HMA>
    <xmx:f59xZkdgNXCSsGCNxjscUkN_nfCuq7Y3_NWXXZB5RqmJHufWP3VRew>
    <xmx:f59xZqt7fQC9zayGrAg38J0AEHme73ZScxYPO6YvwoTaBdM6eYpM1Jjl>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 25A2AB60092; Tue, 18 Jun 2024 10:53:50 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-522-ga39cca1d5-fm-20240610.002-ga39cca1d
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b685d5e5-09d3-4916-ad0b-d329c166e149@app.fastmail.com>
In-Reply-To: <20240527161450.326615-2-herve.codina@bootlin.com>
References: <20240527161450.326615-1-herve.codina@bootlin.com>
 <20240527161450.326615-2-herve.codina@bootlin.com>
Date: Tue, 18 Jun 2024 16:53:30 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Herve Codina" <herve.codina@bootlin.com>,
 "Simon Horman" <horms@kernel.org>,
 "Sai Krishna Gajula" <saikrishnag@marvell.com>,
 "Thomas Gleixner" <tglx@linutronix.de>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>,
 "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Lee Jones" <lee@kernel.org>,
 "Horatiu Vultur" <horatiu.vultur@microchip.com>,
 UNGLinuxDriver@microchip.com, "Andrew Lunn" <andrew@lunn.ch>,
 "Heiner Kallweit" <hkallweit1@gmail.com>,
 "Russell King" <linux@armlinux.org.uk>,
 "Saravana Kannan" <saravanak@google.com>,
 "Bjorn Helgaas" <bhelgaas@google.com>,
 "Philipp Zabel" <p.zabel@pengutronix.de>,
 "Lars Povlsen" <lars.povlsen@microchip.com>,
 "Steen Hegelund" <Steen.Hegelund@microchip.com>,
 "Daniel Machon" <daniel.machon@microchip.com>,
 "Alexandre Belloni" <alexandre.belloni@bootlin.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Netdev <netdev@vger.kernel.org>, linux-pci@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 "Allan Nielsen" <allan.nielsen@microchip.com>,
 "Luca Ceresoli" <luca.ceresoli@bootlin.com>,
 "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>,
 "Clement Leger" <clement.leger@bootlin.com>
Subject: Re: [PATCH v2 01/19] mfd: syscon: Add reference counting and device managed
 support
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, May 27, 2024, at 18:14, Herve Codina wrote:
> From: Cl=C3=A9ment L=C3=A9ger <clement.leger@bootlin.com>
>
> Syscon releasing is not supported.
> Without release function, unbinding a driver that uses syscon whether
> explicitly or due to a module removal left the used syscon in a in-use
> state.
>
> For instance a syscon_node_to_regmap() call from a consumer retrieve a
> syscon regmap instance. Internally, syscon_node_to_regmap() can create
> syscon instance and add it to the existing syscon list. No API is
> available to release this syscon instance, remove it from the list and
> free it when it is not used anymore.
>
> Introduce reference counting in syscon in order to keep track of syscon
> usage using syscon_{get,put}() and add a device managed version of
> syscon_regmap_lookup_by_phandle(), to automatically release the syscon
> instance on the consumer removal.
>
> Signed-off-by: Cl=C3=A9ment L=C3=A9ger <clement.leger@bootlin.com>
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

This all looks correct from an implementation perspective,
but it does add a lot of complexity if now every syscon user
feels compelled to actually free up their resources again,
while nothing else should actually depend on this.

The only reference I found in your series here is the
reset controller, and it only does a single update to
the regmap in the probe function.

Would it be possible to just make the syscon support in
the reset driver optional and instead poke the register
in the mfd driver itself when this is used as a pci device?
Or do you expect to see the syscon get used in other
places in the future for the PCI case?

      Arnd

