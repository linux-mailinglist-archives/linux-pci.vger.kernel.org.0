Return-Path: <linux-pci+bounces-13716-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B1198DC18
	for <lists+linux-pci@lfdr.de>; Wed,  2 Oct 2024 16:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 113651C21278
	for <lists+linux-pci@lfdr.de>; Wed,  2 Oct 2024 14:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A522C1D3560;
	Wed,  2 Oct 2024 14:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="gHCx2vIV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mv6zbJTO"
X-Original-To: linux-pci@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D91A1D1F4F;
	Wed,  2 Oct 2024 14:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727879498; cv=none; b=VYwSZ+ovkIFbco42OJE57cV2THcOu3wxi1a73MPkJ+aXuMP52GyRPFvwKDonQeADmZToWWNo3nSQ2m74g1mYYhiSa/PHPwmdHJiUnBhGV5TOYqipiEspCLETHWV12ZQKdbGfLFUlIupMKM107wr/JcL0CWi3PpLrm+UrXnOL7NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727879498; c=relaxed/simple;
	bh=NCDxRgu1iK1osuKd5Zm+/2EGnP34AlujI1EbScfYr0Y=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=lwdI/GFDF0cmHnsI/wCT3xBANRVGfxB4FlFQywAssSdqKEhfuwiY472lZ4DN2Y+QZXfXvlGpSnRDpk7jGnu2GCu9Wfa1kHOykdW59UOpPYjqIWPEtoOSMVRPSh76EVjQUGC+cCy2IaQwJH012nJHE5IdA1HBKJcbW8PSqiCNUVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=gHCx2vIV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mv6zbJTO; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 874461380231;
	Wed,  2 Oct 2024 10:31:35 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Wed, 02 Oct 2024 10:31:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1727879495;
	 x=1727965895; bh=rf8by3v4c6wxG2SAfkG+4QnwQIhprVnUb59Vlto1X6A=; b=
	gHCx2vIV9QfuNqjkmEElSCZDvXFYgcB4Q5oB+v7a+6I7jPaJFGMbbHCFfpw0sngl
	7tR7ZVJFoMcCJjHjDpm3WwQBdTxrM4GCxvPikn1tkzMlF7gTmlQINLmJBCjgEuHr
	OhefoKZOdDRY2y9SdX5sZoErlV6T2B6rmE9cgPWkton46yJ8tZPevghDQyFBKspr
	9WFFfhIFVGsGSLhLwnjvGwxOQ45gYQyylVrfiSll6nWrPcKLxKfhLQ66JlePoy+b
	dYFUwLGXgf4bw7wgi4/ZNwHtDHyPGCv+Uev+88bScjrvgxttzmaIc5ih3z2AjUwh
	2XcGYDzKBl4WSF77heYaXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1727879495; x=
	1727965895; bh=rf8by3v4c6wxG2SAfkG+4QnwQIhprVnUb59Vlto1X6A=; b=m
	v6zbJTOVhP/uBzJEIDY9m4jU+6GBUw37ibxpilkl3q4K7m5rDOz81+/mleqTUnvL
	/77Bu8kZJ9l3P71fE7fEau+3a4rSIQkebSoJ0ANG0vAG5bGEXuHg10XrchRXzSr7
	tpByorYv77N9mS5ULxWtWxgaNhH34TPtrcAC6bwwqdJuDM3j6uVf34sUXD1wGeDj
	bljI0abJwiTlVo6YgIg++r7hSkvUhxzD002J39GiFDljnFW9ShF8TwEcV7zui/zf
	qDEt3DKcGLQeQbyil5nD1H8UvB24QExWEddCDxRmjuzGWiYr2gEYeSNlg4bmnnDd
	abcWTB8AVA9ybtcJSjfaQ==
X-ME-Sender: <xms:Rln9ZtZf5cgQxHmStXMSrLis5BgTaZvCAxiWBXbBP02122_WUHx2qw>
    <xme:Rln9ZkYuAtMSyLFNl21caHz0kNaKHC1VSd8iEhD1LwxYr-nxs4rek6V-zejnsWV8E
    0UTql6lclOFEPjeZVE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduledgjeegucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:Rln9Zv_vaCGx15zWrOqITWuikEoalJdRpR43q_8tYPQh7-mJM-h2rQ>
    <xmx:Rln9Zrq1RCfB7hFitPHtKz7KzaotC-TvuySs5kpPqKl695t_L1XCZw>
    <xmx:Rln9ZopAQoMedU_A2RU5bIGodo42JFIWnCLkxKQQPeykRArv0lQOIg>
    <xmx:Rln9ZhQTUBXwlLKOpmy_cHD2NVBm7QNmCVYD0eQyd2HQ5LHOMJTIPA>
    <xmx:R1n9Zu0cPaNNipONgtasztfjGETuBHU79SnAInW0Mwo97I1TJGRuSgIk>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6899A2220071; Wed,  2 Oct 2024 10:31:34 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 02 Oct 2024 14:31:13 +0000
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
Message-Id: <3e21a3ba-623e-4b75-959b-3cdf906ee1bd@app.fastmail.com>
In-Reply-To: <20241002144119.45c78aa7@bootlin.com>
References: <20240930121601.172216-1-herve.codina@bootlin.com>
 <20240930121601.172216-4-herve.codina@bootlin.com>
 <b4602de6-bf45-4daf-8b52-f06cc6ff67ef@app.fastmail.com>
 <20241002144119.45c78aa7@bootlin.com>
Subject: Re: [PATCH v6 3/7] misc: Add support for LAN966x PCI device
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Oct 2, 2024, at 12:41, Herve Codina wrote:
> On Wed, 02 Oct 2024 11:08:15 +0000
> "Arnd Bergmann" <arnd@arndb.de> wrote:
>> On Mon, Sep 30, 2024, at 12:15, Herve Codina wrote:
>> 
>> > +			pci-ep-bus@0 {
>> > +				compatible = "simple-bus";
>> > +				#address-cells = <1>;
>> > +				#size-cells = <1>;
>> > +
>> > +				/*
>> > +				 * map @0xe2000000 (32MB) to BAR0 (CPU)
>> > +				 * map @0xe0000000 (16MB) to BAR1 (AMBA)
>> > +				 */
>> > +				ranges = <0xe2000000 0x00 0x00 0x00 0x2000000
>> > +				          0xe0000000 0x01 0x00 0x00 0x1000000>;  
>> 
>> I was wondering about how this fits into the PCI DT
>> binding, is this a child of the PCI device, or does the
>> "pci-ep-bus" refer to the PCI device itself?
>
> This is a child of the PCI device.
> The overlay is applied at the PCI device node and so, the pci-ep-bus is
> a child of the PCI device node.

Ok

> 				/*
> 				 * Ranges items allow to reference BAR0,
> 				 * BAR1, ... from children nodes.
> 				 * The property is created by the PCI core
> 				 * during the PCI bus scan.
> 				 */
> 				ranges = <0x00 0x00 0x00 0x82010000 0x00 0xe8000000 0x00 0x2000000
> 					  0x01 0x00 0x00 0x82010000 0x00 0xea000000 0x00 0x1000000
> 					  0x02 0x00 0x00 0x82010000 0x00 0xeb000000 0x00 0x800000

>
> Hope this full picture helped to understand the address translations
> involved.

Right, that makes a lot of sense now, I wasn't aware of those
range properties getting set. Now I have a new question though:

Is this designed to work both on hosts using devicetree and on
those not using it? If this is used on devicetree on a board
that has a hardwired lan966x, we may want to include the
overlay contents in the board dts file itself in order to
describe any possible connections between the lan966x chip
and other onboard components such as additional GPIOs or
ethernet PHY chips, right?

      Arnd

