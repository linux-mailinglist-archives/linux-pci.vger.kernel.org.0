Return-Path: <linux-pci+bounces-37723-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E9774BC6378
	for <lists+linux-pci@lfdr.de>; Wed, 08 Oct 2025 19:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 476934ED8E2
	for <lists+linux-pci@lfdr.de>; Wed,  8 Oct 2025 17:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634CF2BEFF3;
	Wed,  8 Oct 2025 17:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="oOQ0AZXB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xYjUaq7U"
X-Original-To: linux-pci@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF972BE05B;
	Wed,  8 Oct 2025 17:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759946228; cv=none; b=s97gcGoyPerotRI8E0WpZEzvZq5sAFsTp9nixXJ8n8bv/SvXeR+/m1G+W2hFUyBWBUtHSQmyNPBLrpw4bwBSJaGqJxk9wjfGniC96eMy8/hnXUBHH8whF7yi05wClyPbIgRRPWOFiG9IwT5/QWDBE8zfzM7wT1uJwwgMgBgtvlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759946228; c=relaxed/simple;
	bh=Cv+nLb8wjgCJYXNzCAf1iJJ/M9qyw5k7KAIDsAxuwB8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=oft3YIoZDXuSUToM0//k1yWxFIiRiG7VT3Q9JTSOBda/6wgchw0TomcMKC7Pj+HtJQD16n1pWrJfdOMXJc07gfKPhZhL7bHqw+gCsWTHpEizLlkoQ99A63coEGGpJH8AElKL9krC8mMJE6v+e7P27qh+3PIvQsytkp9pcFDD6mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=oOQ0AZXB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xYjUaq7U; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3FA341400009;
	Wed,  8 Oct 2025 13:57:05 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Wed, 08 Oct 2025 13:57:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1759946225;
	 x=1760032625; bh=P9ffyoQQV2jOME14ODmiVvONWLYIqARldGSMUGBbO8M=; b=
	oOQ0AZXBE6Th1KoTWR7rg8bM7107U1pFQtunpwoxKfmvrMY4PceSgF88StxS/uAA
	G8aqp5vywasoIkpOlvyDF2cCNgtPRjqMFPn7coUke3QPKvuEFxU9HKT/MghCatMM
	RmWT21b43ZWjzAU6nyPl27TtOdZDumMKtbTGDdfrb/ouH4O+gPfhW1bfw8uIZFYg
	ZTLmzPeuK3Jb5KNEjKd1IMZ/ZF5VGs3cx0BC7WKXta3FmtiHUyN8LmI3tls+sB67
	Q2r3jOQnGUqylCh9kNm9h72anStX1p4wXT2VjwCPyUgyCMoYtN/F9pGeWoxUMgY2
	PbZj0VyGSnXWUPO6GMeKqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759946225; x=
	1760032625; bh=P9ffyoQQV2jOME14ODmiVvONWLYIqARldGSMUGBbO8M=; b=x
	YjUaq7UaXeolq+j075yn1CkvpSJMlXN+GTbMofEF1Qpx2a6oem1mQk1Unc0V7Byj
	+qqMHueQ8Shxx3kFpc/6eziH7ua1YGuyBb737X13AoxzYllvNyns9q3vbQEy6guq
	LqQhFY1asuGtyDV3OUP66ErPlGY/3u1TNbapZ+Xp8/xh1gqyihn5sDmJpIgSfuo2
	Rr8iiKahxqWwFRdLTcaIORPOny7acO48gOWAhFGvRCJbQS/iUrRgMOtqntnSfF4w
	lpU43oc3D+532xmDThPMZ6rTmkl3YzNmV/aWxFA9cqxdy50M+5dAZxaBXnpKrOGY
	XcXmE6sdfQHx6uOtYxFfA==
X-ME-Sender: <xms:8KXmaHfI4aCKyGgA7qPREFU7iBIZe6LfCfMKU-Hj5cG_SJt0bpbYIA>
    <xme:8KXmaIAYgDXt-zII0IctqQt3gGks0cqiaq1VKcGeFFoVw5NM3JeM9KdRcmwUf6oBo
    CKvZ7OyqTmSsf3PrfBgqCVHgkfLCwgaLc3Hj-lGyxAS13RRyiZOCN8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdefleeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefhvdei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepvdehpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopegthhgvshhtvghriedvheduheesghhmrghilhdrtghomhdprhgtph
    htthhopehjihhnghhoohhhrghnudesghhmrghilhdrtghomhdprhgtphhtthhopegshhgv
    lhhgrggrshesghhoohhglhgvrdgtohhmpdhrtghpthhtoheptggrshhsvghlsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepkhhriihkodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhifih
    hltgiihihnshhkiheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhpihgvrhgrlhhi
    shhisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmrghniheskhgvrhhnvghlrdhorh
    hg
X-ME-Proxy: <xmx:8KXmaA3wDIrJW9ljHhQjqC0rEnLXNwnDneYIzqdFULG53VnitRRbOw>
    <xmx:8KXmaK9iDBrCTA99sfPOd8BMaMdGJxJAzV7okxRVSPR5KGIXodG6JQ>
    <xmx:8KXmaGNFG0quGiFGqFXbnv4Y0Bej8JqGhgFJiBvha3qqWuZ1HFN53A>
    <xmx:8KXmaGA06Mbvpq45lKuGGE8vEsM8IRUFNHNkcgqUQXqIa5zcwXR7LA>
    <xmx:8aXmaCCKsByF2Lxor3unCFpiLI7dvwxNMG8TNND-xpq-CHbdKn6vEuQ5>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8FBA5700054; Wed,  8 Oct 2025 13:57:04 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AIHrVq-NOQMk
Date: Wed, 08 Oct 2025 19:56:44 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Manivannan Sadhasivam" <mani@kernel.org>
Cc: "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
 "Vincent Guittot" <vincent.guittot@linaro.org>,
 "Chester Lin" <chester62515@gmail.com>,
 "Matthias Brugger" <mbrugger@suse.com>,
 "Ghennadi Procopciuc" <ghennadi.procopciuc@oss.nxp.com>,
 "NXP S32 Linux Team" <s32@nxp.com>, bhelgaas@google.com,
 jingoohan1@gmail.com,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 "Rob Herring" <robh@kernel.org>, krzk+dt@kernel.org,
 "Conor Dooley" <conor+dt@kernel.org>, Ionut.Vicovan@nxp.com,
 "Larisa Grigore" <larisa.grigore@nxp.com>,
 "Ghennadi Procopciuc" <Ghennadi.Procopciuc@nxp.com>,
 ciprianmarian.costea@nxp.com, "Bogdan Hamciuc" <bogdan.hamciuc@nxp.com>,
 "Frank Li" <Frank.li@nxp.com>, linux-arm-kernel@lists.infradead.org,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 "Niklas Cassel" <cassel@kernel.org>
Message-Id: <3d480f73-15b4-4fb8-8d2b-f9961c1736ca@app.fastmail.com>
In-Reply-To: 
 <2erycpxudpckmme3k2cpn6wgti4ueyvupo2tzrvmu7aqp7tm6d@itfj7pfrpzzg>
References: <20250919155821.95334-1-vincent.guittot@linaro.org>
 <20250919155821.95334-2-vincent.guittot@linaro.org>
 <iom65w7amxqf7miopujxeulyiglhkyjszjc3nd4ivknj5npcz2@bvxej6ymkecd>
 <aOU0w5Brp6uxjZDr@lpieralisi>
 <4rghtk5qv4u7vx4nogctquu3skvxis4npxfukgtqeilbofyclr@nhkrkojv3syh>
 <eba7d968-209d-4acb-ba41-4bebf03e96ba@app.fastmail.com>
 <4143977f-1e70-4a63-b23b-78f87d9fdcde@app.fastmail.com>
 <2erycpxudpckmme3k2cpn6wgti4ueyvupo2tzrvmu7aqp7tm6d@itfj7pfrpzzg>
Subject: Re: [PATCH 1/3 v2] dt-bindings: PCI: s32g: Add NXP PCIe controller
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Oct 8, 2025, at 17:19, Manivannan Sadhasivam wrote:
> On Wed, Oct 08, 2025 at 10:35:34AM +0200, Arnd Bergmann wrote:
>> On Wed, Oct 8, 2025, at 10:26, Arnd Bergmann wrote:
>> > the physical addresses for RAM at 0x80000000 and on-chip devices
>> > at 0x40000000. This probably works fine as long as the total
>> > PCI memory space assignment stays below 0x40000000 but would
>> > fail once addresses actually start clashing.
>> 
>> I got confused here myself, but what I should have said is that
>> having the DMA address for the RAM overlap the BAR space
>> as seen from PCI is problematic as the PCI host bridge
>> cannot tell PCI P2P transfers from DMA to RAM, so one
>> of them will be broken here.
>> 
>
> No. The IP just sets up the outbound mapping here for the entire 'ranges'. When
> P2P happens, it will use the inbound mapping translation.

That is not my impression from reading the code: At least for
the case where both devices are on the same bridge and they
use map_type=PCI_P2PDMA_MAP_BUS_ADDR, I would expect the DMA
to use the plain PCI bus address, not going through the
dma-ranges+ranges translation that would apply when they are
on different host bridges.

> So your concern would be valid if the 'dma-ranges' (for which inbound
> translation happens) overlapped with the RAM/MMIO range. But that is not the
> case here.

dma-ranges should normally list all the memory controllers, so in
this case at least the 0x80000000..0xffffffff range of PCI bus
addresses must be routed from the host bridge to RAM. If a BAR
is assigned to the same numbers, I would expect a PCI bridge
to direct a DMA transfer downstream to that BAR instead
of upstream to the CPU even before it gets to the host bridge.

      Arnd

