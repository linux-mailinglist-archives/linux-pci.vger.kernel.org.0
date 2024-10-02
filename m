Return-Path: <linux-pci+bounces-13712-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F2798D209
	for <lists+linux-pci@lfdr.de>; Wed,  2 Oct 2024 13:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A00E9280EB4
	for <lists+linux-pci@lfdr.de>; Wed,  2 Oct 2024 11:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4291E7676;
	Wed,  2 Oct 2024 11:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="VOHboIuZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Hs9n7oVO"
X-Original-To: linux-pci@vger.kernel.org
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DADB1940AA;
	Wed,  2 Oct 2024 11:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727867411; cv=none; b=bftpM6MvHqTLyguFN4/GwHeX/hAjiG0uft8I0sXUtMFr5oCH9Yev2prpi9u4CuArbPCW+4Q0Se2NZcFkC9y037cuklLxymb2zi4ZYj/gnV2wXPTIjod2PanRuPvrvg9hWZHQDwMGZVqfl5zgU09zSAQtLAyHmo6HXB7MZg4+14s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727867411; c=relaxed/simple;
	bh=fH4Py6dX9EFpeg8BO/28sQh8LcY7GSxckrg4ObM+8qU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=JI7lLQNnQY9cF8+yKOiwmyR/ev9ByiIXZnLdCGgwLEmbAxslYROLvyi5GCZEsCsq4MwEsBtg3YVe0vZnUYYu7EEJUxvnNbPyFx1QPEMiKYNNCFtTu8FV1pmz9xArV5vBPhlpXe4nVLXtJDPoRnsDxwyGQuZlops8WljfzsT5jlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=VOHboIuZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Hs9n7oVO; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id C55E413800DE;
	Wed,  2 Oct 2024 07:10:08 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Wed, 02 Oct 2024 07:10:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1727867408;
	 x=1727953808; bh=9OZfhbcZE4pwy66sTyp6QwBP/APePgay17V4KJoXaWk=; b=
	VOHboIuZ+mQJ3u7OXRhPGcFATleC++xxgIm7KQzh8ACERODfjknpqPShyffVDz6R
	qlKyoQZzQUOUDap1Y5eEv990lfxgEp8/6c0n+F9cEQN1zbvQnrysfHOSk7c+2u+c
	nHh80Z1zJdQFZeVjtGimZW7+npHtKnKQt65G5RiKCyDk0pl674rR/3xsgfd3eaZW
	WdoXEq+YkMtoXX9fN9bBQJWn6qKbEIO62/6mK7yVCs9AHMdjAX0jS+A63LFAXbmG
	G1yxNxziHwFADKFm+zNqjq6oStERK1a7LgMV/FlgWLd0q+orxVMyJaoKWhaEPI9a
	CtJnvMdkwC/ct/RV2gL8qw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1727867408; x=
	1727953808; bh=9OZfhbcZE4pwy66sTyp6QwBP/APePgay17V4KJoXaWk=; b=H
	s9n7oVONv8Me1aWdrwGhlxjQ9+bPM2eqxka41E2k5YALGbiwE4CBEbpBWYqO8U1j
	GmcyzPbsUT5cpEVG97/sX+gT28SPOCUEFavp8E4oppnlH+NJiM0ZRRgCy4XX09p6
	OA3rccTWb7BI4ZE3toyskoTYr8Tm4xYaZWYGkJPbhkNW1lrHkhlwZ2NZsPjI41vJ
	Wm7/AxiXhQei/d55fySrotqUafiRYS3WQXOsM4D1onq25/4wA/8Dby0VwUxrBHpb
	iGN6glJTYq6/aBMEAIBsbJSLsBmkN0xSw8m1RDE/ockUvBXJNTMq5mz4YpIWNI0J
	m6GKQxgQCiR3nHy+vMOyg==
X-ME-Sender: <xms:Dyr9Zl8n8KgOICmyf_D32o8VdyhGCVL-6Gv59G5djmWmxhaDY0yBJA>
    <xme:Dyr9Zps5KqejcmMpenUtbQefr7Jk2hx7w-CyKm_VHiIJLXm3n77ljVRfUseBenOfN
    8BbHa5v6_ywxykfHSs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduledgfeegucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:Dyr9ZjAhAJlS38xVtOJCth9satXXyKXlD-LP830u_TLJ6aJt_hfCGw>
    <xmx:Dyr9ZpetAsCHGW-8c4588GfMxDqPxJmEt5l7L86QXedkxIAHQDUDdg>
    <xmx:Dyr9ZqNXkV4eHKUi1QQJ3EQsS7s5PsiWCk8UVfPKq3kqvz6v7TwSpA>
    <xmx:Dyr9ZrleyX1v8PnaKQK2A19e8yEIBdWzfd7Gqt7y120pOvLEKHievg>
    <xmx:ECr9ZmL8vbGnZ_2_RkCcAtoGVVEO9I2QpqboNxPlhwrV8Jr_4Xg81MQb>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D8B362220071; Wed,  2 Oct 2024 07:10:07 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 02 Oct 2024 11:08:15 +0000
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
Message-Id: <b4602de6-bf45-4daf-8b52-f06cc6ff67ef@app.fastmail.com>
In-Reply-To: <20240930121601.172216-4-herve.codina@bootlin.com>
References: <20240930121601.172216-1-herve.codina@bootlin.com>
 <20240930121601.172216-4-herve.codina@bootlin.com>
Subject: Re: [PATCH v6 3/7] misc: Add support for LAN966x PCI device
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Sep 30, 2024, at 12:15, Herve Codina wrote:

> +			pci-ep-bus@0 {
> +				compatible = "simple-bus";
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +
> +				/*
> +				 * map @0xe2000000 (32MB) to BAR0 (CPU)
> +				 * map @0xe0000000 (16MB) to BAR1 (AMBA)
> +				 */
> +				ranges = <0xe2000000 0x00 0x00 0x00 0x2000000
> +				          0xe0000000 0x01 0x00 0x00 0x1000000>;

I was wondering about how this fits into the PCI DT
binding, is this a child of the PCI device, or does the
"pci-ep-bus" refer to the PCI device itself?

Where do the "0x01 0x00 0x00" and "0x00 0x00 0x00" addresses
come from? Shouldn't those be "02000010 0x00 0x00" and
"02000014 0x00 0x00" to refer to the first and second
relocatable 32-bit memory BAR?

     Arnd

