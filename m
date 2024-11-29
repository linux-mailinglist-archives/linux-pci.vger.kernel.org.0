Return-Path: <linux-pci+bounces-17443-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D6E9DC079
	for <lists+linux-pci@lfdr.de>; Fri, 29 Nov 2024 09:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD31E163ADE
	for <lists+linux-pci@lfdr.de>; Fri, 29 Nov 2024 08:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4220A15ECDF;
	Fri, 29 Nov 2024 08:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="KOJA5EBN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KvA6CDJr"
X-Original-To: linux-pci@vger.kernel.org
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0B215D5B8;
	Fri, 29 Nov 2024 08:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732868742; cv=none; b=jPUO9to5wYOm6kyLSrYcR16PB+q3GZFmiiH7KswKmMDcBV1XfpwjSqh6I8vEe9/SeO+uK0+VDnsMmBwWxIsN+Udr4HmDNo/1ZgC7D+gWPxfCtrYM0VTX3qrqCyvnCz0GAElX/2LdgP5U/5soyz2NGM2DCN4Eq6qL8iUAPE5BTDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732868742; c=relaxed/simple;
	bh=ZoxfgOCiNBGvc38i9qoSOF38QGUQoZ7MMsUNaUmc7QI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=RIqc69bC1S7HhUoLLSF3aip/weMrijfs3wqnCvX93/DgqvZ0uLzeTMdu5gR7sOFUka3iY76ekVe5BZEueBKvw+73BYRQN0TgtBw6KGZRFLqxAsWG+G/orwEUq8Nod84SEYDOZycQkDen9cvj1VcpD+6hfaTwkxhHCL4IE8hSpPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=KOJA5EBN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KvA6CDJr; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 207332540185;
	Fri, 29 Nov 2024 03:25:37 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Fri, 29 Nov 2024 03:25:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1732868736;
	 x=1732955136; bh=UkrIkZIR81K+8lZR1jV0EYOCaPxA1tf+i52k5/yQXYE=; b=
	KOJA5EBNlyb8AYL5jSXpuBelBvb73YiE90Wu9UpAMctnOf83Wr1OAy1Ren4m/BV+
	NvXNTcvq4i1mSgTiixSfE1eI5cupRXteGM85a+ULO8rMY2UtiInKXnYmXb2kAGHG
	9H9SKLcsNSeqcfEnhqCPb4ypxAkhk8CPxd2UIN1mAdcQUSjofBfVmgSQZuEMOto5
	+hQIMXRwoV09NYF0hRiqDZQBz8eWRqUIOcpdhaWAZf7LOEeHG9hdxLyaCyKnNh6h
	KNlC4CVkTgsbPI0tkBo7FtLSXZJi1qFfY3W4ssHMR5WySwW5jzWTnGwtrkUeo+6Y
	3GQ2cXRER5DyBj7XC3yDhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732868736; x=
	1732955136; bh=UkrIkZIR81K+8lZR1jV0EYOCaPxA1tf+i52k5/yQXYE=; b=K
	vA6CDJrEiE6pUy3ii7u2JCcRFNVL0TYiIQJsQ7U2DC48SjUIbUlyVWO7bINl3yK3
	S5kRjCvtDyNJi9Xb402bdO2lQSraWPiOF6mmFzAJdzigD+/UgOah81r6XbL3K2O6
	MbPhMzXYuIJ0nbZeZERSj8c0+ooB2KdpwxJ1aCEJ/pcRdqgTkKUeE7IvyLLYGTJi
	Tb70HuKLscGgw200rYY7vsWMlJLfB01LoKSe9un7dLiFD7fFTCR2uSSex6DOP537
	7i0rLd1+xsh9i0pW1o8Oso2MN7gDN3xSj7UHUKOfIfz9jKS6O5GblcYivoITDRox
	b3u9Pg7mGZ3bu3HskIkQw==
X-ME-Sender: <xms:gHpJZ6w2fGfxXS9vV9zMcGq697f78hkVipzcWNWFgb5THIiGOoauCw>
    <xme:gHpJZ2Trh3-Hm_QKXfhvaQSIZuZSqFZDutp_lV3EUN7YmRRYGI3bkufTEfR0wZwUW
    -QgDdRvd-UVyL1E1vs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrhedvgdduudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefg
    gfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepfeef
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeguvghrvghkrdhkihgvrhhnrghnse
    grmhgurdgtohhmpdhrtghpthhtohepughrrghgrghnrdgtvhgvthhitgesrghmugdrtgho
    mhdprhgtphhtthhopehhvghrvhgvrdgtohguihhnrgessghoohhtlhhinhdrtghomhdprh
    gtphhtthhopehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmpdhrtghp
    thhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhmpdhrtg
    hpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegrnhgu
    hidrshhhvghvtghhvghnkhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepsghhvghlgh
    grrghssehgohhoghhlvgdrtghomhdprhgtphhtthhopegvughumhgriigvthesghhoohhg
    lhgvrdgtohhm
X-ME-Proxy: <xmx:gHpJZ8Vp6xl2hBMEgs2JSWypxmN9xxYmWwNzFSblFLDZFN8EUfh2dQ>
    <xmx:gHpJZwhzwiakrGGJbbDZG8Imk_TNKMahRje9dVx4IHugJXrAOPy2JA>
    <xmx:gHpJZ8Dux2uk2NHsdgnCz72FSpxTT8sKEDntUWZQhKhF583xg70uoQ>
    <xmx:gHpJZxLEh56i6QWMewaXnEKyWFaDZW1L95TcX5p_WawB0jy13PKZdw>
    <xmx:gHpJZ0bFHq3GtzEGICp5Hv6ON-0xSNRqOAEy56UGsSJCvhRVmkh2DDD8>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 09DC32220071; Fri, 29 Nov 2024 03:25:35 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 29 Nov 2024 09:25:15 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Herve Codina" <herve.codina@bootlin.com>,
 "Michal Kubecek" <mkubecek@suse.cz>
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
Message-Id: <1a895f7c-bbfc-483d-b36b-921788b07b36@app.fastmail.com>
In-Reply-To: <20241129091013.029fced3@bootlin.com>
References: <20241010063611.788527-1-herve.codina@bootlin.com>
 <20241010063611.788527-2-herve.codina@bootlin.com>
 <dywwnh7ns47ffndsttstpcsw44avxjvzcddmceha7xavqjdi77@cqdgmpdtywol>
 <20241129091013.029fced3@bootlin.com>
Subject: Re: [PATCH v9 1/6] misc: Add support for LAN966x PCI device
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Nov 29, 2024, at 09:10, Herve Codina wrote:
> Hi Michal,
> On Thu, 28 Nov 2024 20:42:53 +0100
> Michal Kubecek <mkubecek@suse.cz> wrote:
>> > --- a/drivers/misc/Kconfig
>> > +++ b/drivers/misc/Kconfig
>> > @@ -610,6 +610,30 @@ config MARVELL_CN10K_DPI
>> >  	  To compile this driver as a module, choose M here: the module
>> >  	  will be called mrvl_cn10k_dpi.
>> >  
>> > +config MCHP_LAN966X_PCI
>> > +	tristate "Microchip LAN966x PCIe Support"
>> > +	depends on PCI
>> > +	select OF
>> > +	select OF_OVERLAY  
>> 
>> Are these "select" statements what we want? When configuring current
>> mainline snapshot, I accidentally enabled this driver and ended up
>> flooded with an enormous amount of new config options, most of which
>> didn't make much sense on x86_64. It took quite long to investigate why.
>> 
>> Couldn't we rather use
>> 
>> 	depends on PCI && OF && OF_OVERLAY
>> 
>> like other drivers?

Agreed.

I would write in two lines as

        depends on PCI
        depends on OF_OVERLAY

since OF_OVERLAY already depends on OF, that can be left out.
The effect is the same as your variant though.
 
>
> I don't have a strong opinion on this 'select' vs 'depends on' for those
> symbols.
>
> I used select because the dependency is not obvious for a user that just
> want the driver for the LAN966x PCI device.

The general rules for picking one over the other are:

- use 'select' for symbols that can not be enabled manually
- prefer 'depends on' for user-visible options
- do whatever other driver do for the same symbol, to avoid
  dependency loops.

     Arnd

