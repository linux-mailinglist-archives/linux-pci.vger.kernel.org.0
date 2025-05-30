Return-Path: <linux-pci+bounces-28696-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C49D7AC8818
	for <lists+linux-pci@lfdr.de>; Fri, 30 May 2025 08:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79A387A2196
	for <lists+linux-pci@lfdr.de>; Fri, 30 May 2025 06:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8637C1EE7B9;
	Fri, 30 May 2025 06:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="1RHkxvfZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ie/YWIY8"
X-Original-To: linux-pci@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75AAF155C87;
	Fri, 30 May 2025 06:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748585021; cv=none; b=ps+UyY+FOAYfT0WtXe8Qt6ioQ1ClsIGxhvMJWfdDgWrZEWKwz6FYhySShOLleO+yxE3h0Gju8qTTE81MZtZEk2AH9tAunkFS97FA072hjL1u85jnhVQmBLOOBER7NnW1OARSRPjENrSMXtqmz8bZ/NMnxFk4rORrYoIPVcjsryU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748585021; c=relaxed/simple;
	bh=OZddS4g8nHiT92Hjmd8MP9h8P53X3sIYXOHERf0QsDQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=qLZ/12CHQTbHv8UJ5az7REdqiF8fz+bazR+Wa4L5J5vwA8TUQqQFYD5RsNp+pMo7VYo+daHcgcpueVzBv8MnCp6/D35zYto9ThjclBY7UaKmeppoNqDcpViFP2i8d39JywONeR3pGMU2ip4tXCYplnlaWztN2Jxv9PQoakzsmUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=1RHkxvfZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ie/YWIY8; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 49795114015E;
	Fri, 30 May 2025 02:03:38 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Fri, 30 May 2025 02:03:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1748585018;
	 x=1748671418; bh=i4haqSXLls4cGXCJV0jsL0/1LVmc6rWPImypim9zABc=; b=
	1RHkxvfZRR7Km8IoSd1pTKrCV3lbuBltgiXlAz9CPu/cZM4DaR1rTQcvh+/Q9iQc
	/qV/UpPn2bVRh1TIC3Jv4JiknU5ASCjckII5jnWHlDVfODCwLZ+uFACccUf8ZYJy
	cbY470Oe58LhyVUG+uxY4/boQCUb/5HIkLG8K9R7+Bdk0ySexafuDe4VDgpqlDJ1
	ho/MyP+uu8XpOjjeQ9F+kijniawhTH/7mAC5lWKxPfbfA/oVag0t1V7NpANMdc9I
	KW6CK5NxZrjrRxfFXez+YddLTa/cjFDQAxzLjm2IrLnotIDuEFuRlIDR/sV36//P
	bDXgW3jn0KNoQh3/otcjzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748585018; x=
	1748671418; bh=i4haqSXLls4cGXCJV0jsL0/1LVmc6rWPImypim9zABc=; b=I
	e/YWIY87T+cUEAvQFtppd7cjOR332cAEv+X17P8BwTgZKHIXebSBUPV1a9BEtZ7R
	b5U2BaEPF0H5QsgBj/0WtW/lAInLK1rW84pUo+urcmupFfI7NhvCpquRb3G4rArg
	ahqi8ChDGt9a/AHCW4n82scvtV2J89YxCw5dVt8t/UArIGMJLnbYjxIhxcZ+veL3
	x701C9FG8q4Q+s+bXLnS9UBKsBr4UVrSdzCdKcf/B0IqglFYkSa/BznyqbAkauPc
	lJgZGXHpaIl1EY7BKrVqSp8K6qvCZITGxapyjj4wBPJYnTO9i2RfqBSPkVyVHZGJ
	P8Lz+wWjFQwXWstVnz3EA==
X-ME-Sender: <xms:OEo5aFMSBGzHZtO45qItzUyweRayyBWmiZtmaF1FoqeKZHG0B8rYzw>
    <xme:OEo5aH97rMybNfXNW7BYwlmAOI1LHYHd73OY6mx1Y9PJ_s2BIJkTSRZSU9-Fl0rFY
    Lmpnuo-doxr5lJOLqM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvkedvgeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefk
    jghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfd
    cuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrhhnpeefhfehteffuddv
    gfeigefhjeetvdekteekjeefkeekleffjeetvedvgefhhfeihfenucffohhmrghinhepkh
    gvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepfeejpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopeguvghrvghkrdhkihgvrhhnrghnsegrmhgu
    rdgtohhmpdhrtghpthhtohepughrrghgrghnrdgtvhgvthhitgesrghmugdrtghomhdprh
    gtphhtthhopegtrghtrghlihhnrdhmrghrihhnrghssegrrhhmrdgtohhmpdhrtghpthht
    ohepmhhtuhhrqhhuvghtthgvsegsrgihlhhisghrvgdrtghomhdprhgtphhtthhopegsrh
    hglhessghguggvvhdrphhlpdhrtghpthhtohephhgvrhhvvgdrtghoughinhgrsegsohho
    thhlihhnrdgtohhmpdhrtghpthhtoheplhhutggrrdgtvghrvghsohhlihessghoohhtlh
    hinhdrtghomhdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohht
    lhhinhdrtghomhdprhgtphhtthhopegstghmqdhkvghrnhgvlhdqfhgvvggusggrtghkqd
    hlihhsthessghrohgruggtohhmrdgtohhm
X-ME-Proxy: <xmx:OEo5aEQH2Q6JkkQH-Mlv0t1AMoGS16Ov8O8B30zEuqzVmPS6okklKg>
    <xmx:OEo5aBucgj621crqtYvLM-vDiDsAUtyFBxlpmn2KDBs-BWsGvxW41g>
    <xmx:OEo5aNd9BIUZkutK3ua0dDcK95tdzyAXLq6yuQIGKaAKzADNQwuc5g>
    <xmx:OEo5aN1aE6H6kxyxHxd0clkYHHcMNSvW3A6L6TujH5b7Wplg8PK8MA>
    <xmx:Oko5aPQ2arYbS3SdyF_6oXUPjPShCgul_31qN6OgSnW-bIWEuAIVFICC>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 9918B700062; Fri, 30 May 2025 02:03:36 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Tc6bcdd190696c0ef
Date: Fri, 30 May 2025 08:03:16 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Andrea della Porta" <andrea.porta@suse.com>,
 "Krzysztof Kozlowski" <krzk@kernel.org>
Cc: "Michael Turquette" <mturquette@baylibre.com>,
 "Stephen Boyd" <sboyd@kernel.org>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>,
 "Florian Fainelli" <florian.fainelli@broadcom.com>,
 "Broadcom internal kernel review list"
 <bcm-kernel-feedback-list@broadcom.com>,
 "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 "Manivannan Sadhasivam" <manivannan.sadhasivam@linaro.org>,
 "Bjorn Helgaas" <bhelgaas@google.com>,
 "Linus Walleij" <linus.walleij@linaro.org>,
 "Catalin Marinas" <catalin.marinas@arm.com>,
 "Will Deacon" <will@kernel.org>, "Bartosz Golaszewski" <brgl@bgdev.pl>,
 "derek.kiernan@amd.com" <derek.kiernan@amd.com>,
 "dragan.cvetic@amd.com" <dragan.cvetic@amd.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Saravana Kannan" <saravanak@google.com>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 "Masahiro Yamada" <masahiroy@kernel.org>,
 "Stefan Wahren" <wahrenst@gmx.net>,
 "Herve Codina" <herve.codina@bootlin.com>,
 "Luca Ceresoli" <luca.ceresoli@bootlin.com>,
 "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>,
 "Andrew Lunn" <andrew@lunn.ch>, "Phil Elwell" <phil@raspberrypi.com>,
 "Dave Stevenson" <dave.stevenson@raspberrypi.com>,
 kernel-list@raspberrypi.com, "Matthias Brugger" <mbrugger@suse.com>
Message-Id: <7934ae2a-3fc5-4ea2-b79a-ecbe668fd032@app.fastmail.com>
In-Reply-To: <aDholLnKwql-jHm1@apocalypse>
References: <cover.1748526284.git.andrea.porta@suse.com>
 <0580b026-5139-4079-b1a7-464224a7d239@kernel.org>
 <aDholLnKwql-jHm1@apocalypse>
Subject: Re: [PATCH v12 0/13] Add support for RaspberryPi RP1 PCI device using a DT
 overlay
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, May 29, 2025, at 16:00, Andrea della Porta wrote:
> Hi Krzysztof,
>
> On 15:50 Thu 29 May     , Krzysztof Kozlowski wrote:
>> On 29/05/2025 15:50, Andrea della Porta wrote:
>> > *** RESENDING PATCHSET AS V12 SINCE LAST ONE HAS CLOBBERED EMAIL Message-Id ***
>> > 
>> Can you slow down please? It's merge window and you keep sending the
>> same big patchset third time today.
>
> Sorry for that, I was sending it so Florian can pick it up for this
> merge window, and I had some trouble with formatting. Hopefully
> this was the last one.

That's not how the merge window works, you missed 6.16 long ago:

Florian sent his pull requests for 6.16 in early may, see
https://lore.kernel.org/linux-arm-kernel/20250505165810.1948927-1-florian.fainelli@broadcom.com/

and he needed time to test the contents before sending them to me.

If the driver is ready to be merged now, Florian can pick it up
after -rc1 is out, and then include it in the 6.17 pull requests
so I can include them in the next merge window.

      Arnd

