Return-Path: <linux-pci+bounces-37779-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D0FBCAE46
	for <lists+linux-pci@lfdr.de>; Thu, 09 Oct 2025 23:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2EFF84E1F8A
	for <lists+linux-pci@lfdr.de>; Thu,  9 Oct 2025 21:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71AF280325;
	Thu,  9 Oct 2025 21:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="AbQFnV+b";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EHmpTDc5"
X-Original-To: linux-pci@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BA227FD5D;
	Thu,  9 Oct 2025 21:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760044590; cv=none; b=BdfFw59ERMLRsaxZ6vL9bLXYE1sCLv1zHDydQ2DEhte1s5+I5XiXltBzI8TyTKD+O2WR+49Lhe7P6gXXkwPqirHiArG0eStiWHy8HLNy1s7kfFWPCxIqnrvHKay6oh0WjG56qsXT7OW8fxg1/V6CwDwoSs5AsOXOwDQIUZQFzEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760044590; c=relaxed/simple;
	bh=j10cHAf5FWRw7VGsF/d4LWqO0kfsTZpy1sJ27u2YnjU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=t8+S66UdGFb6uc2mKuQgcC9WrFMd7LbTpb0B2EIkxy9QvgsqZK8seu/Fv7e3CsBE6Fev7stX29fDoAlC8+zkf1EKsCacXUdy/MgMjswgjHJsluOTNCbnkvTWdK9f5zYSUUFubl/VpwTCe7O91SRfBKsY/X/wxMSTBO/JaeN+3lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=AbQFnV+b; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EHmpTDc5; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 623367A0147;
	Thu,  9 Oct 2025 17:16:23 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Thu, 09 Oct 2025 17:16:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1760044583;
	 x=1760130983; bh=IoNTmFVBWG81Z8jPkjSyUXyeQNMXRWj30MhKaE6XHgs=; b=
	AbQFnV+b8ZYeLCRKItywfYNA5Dd8v+oWv3NUzKZXGytsRishs+OLhi0sA0rm2O/o
	QLd7UDaDvd8hSVJ4vm+iknIVqJYiJSRy7aDqvjQRVL1YYEAOch212aL6JwNzYC/0
	gxoOr7MlqPf9OndJYM+XVVd/SCEai5D8Hmd9XH0su6mw6wDTQgCI/UqePc14Y4mc
	8l5dgwhf7fh2PEgzKEIrwnWeveHotomhZGhLcmjKox3ZfACIvUiTqGgZ1BZKZg5k
	rH6LBuYCn4/idKHrU4eBchO+PsK0YajfUBPApSPEMbB+Or4zJlvTkXukaAV5Kd2e
	eQhZTwql/c0TmVPZyliGyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760044583; x=
	1760130983; bh=IoNTmFVBWG81Z8jPkjSyUXyeQNMXRWj30MhKaE6XHgs=; b=E
	HmpTDc5xRJ3TXz5x2hZeE2MXvOu6IUyw1eg8bbYCxTXKXiYskUZ8DWu4XanWSfTa
	4mVZMnmsQBY8o2zfvCFBca1rM1/2eCf5q8tM3QLU86PUKr1sJDvLj2TOgM9YtXZR
	+m8xhJOj78+h/2q1Pf+vtpReNVod1kjOlnbsN2epZt7czSjLRWu6SO5eH+x2Ek4y
	i0boRPEZvm4rj/WSIeFCAAYmnjQZHxS8ClavA6xWC94QXiGS1AOuZIM0au2FDZbN
	lGV1L+3qFBHljpv16lL9InzoDx1Lb/anPYtyCst08ZZ1yzv4CzC/L8UNRn1pVStm
	YLEG5w9AvqANqTEkTL4jQ==
X-ME-Sender: <xms:JiboaKb-MGLsTLhTj9uJL3sd49TdJmleSY92FhFOjenpgIPzMBR9Pw>
    <xme:JiboaINkPGTacipbSrsOVyfF3NamakhSURWRSrnAtvBf-HqcCAlmziHR2w2MWYwO9
    -vPD3gT_jPzdMKeRah0tHFy5Q2UUYPcpLccxeucBuWWyUW8X7uTJNZ1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdejvdegucetufdoteggodetrf
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
X-ME-Proxy: <xmx:JiboaKzjsKO1_WQG04CIprEGKf71yM5hOy-8anD7RRhtZ7ftpo8Wpw>
    <xmx:JiboaGL3T8rgFBUNlNLoEzdCZmZb9R0h6pwMlMFI1IZxisK1gm-jeg>
    <xmx:JiboaJpnfl2MAFwPgIgtocS8kPtCyPmWKUPr_aeHeEkQm7PzoxtkMw>
    <xmx:JiboaMsvj1UUHlfbYdzbwLI2CqHl_ls__C_Bk6sK0L4tGU7FKgSFWQ>
    <xmx:JyboaDdp-OmcX3EnwEF9gbyqZztZszgw7zUa-4n3H4-3GDfifWvXEoVD>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 47F22700063; Thu,  9 Oct 2025 17:16:22 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AIHrVq-NOQMk
Date: Thu, 09 Oct 2025 23:16:02 +0200
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
Message-Id: <839e3878-ae62-4c8b-a74b-ac4f6f060d98@app.fastmail.com>
In-Reply-To: 
 <4kvo2qg2til22hlssv7lt2ugo63emr5c4hfjur5m3vnxvpdekx@jcbhaxb2d2j2>
References: <20250919155821.95334-1-vincent.guittot@linaro.org>
 <20250919155821.95334-2-vincent.guittot@linaro.org>
 <iom65w7amxqf7miopujxeulyiglhkyjszjc3nd4ivknj5npcz2@bvxej6ymkecd>
 <aOU0w5Brp6uxjZDr@lpieralisi>
 <4rghtk5qv4u7vx4nogctquu3skvxis4npxfukgtqeilbofyclr@nhkrkojv3syh>
 <eba7d968-209d-4acb-ba41-4bebf03e96ba@app.fastmail.com>
 <4143977f-1e70-4a63-b23b-78f87d9fdcde@app.fastmail.com>
 <2erycpxudpckmme3k2cpn6wgti4ueyvupo2tzrvmu7aqp7tm6d@itfj7pfrpzzg>
 <3d480f73-15b4-4fb8-8d2b-f9961c1736ca@app.fastmail.com>
 <4kvo2qg2til22hlssv7lt2ugo63emr5c4hfjur5m3vnxvpdekx@jcbhaxb2d2j2>
Subject: Re: [PATCH 1/3 v2] dt-bindings: PCI: s32g: Add NXP PCIe controller
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Oct 9, 2025, at 20:47, Manivannan Sadhasivam wrote:
> On Wed, Oct 08, 2025 at 07:56:44PM +0200, Arnd Bergmann wrote:
>> On Wed, Oct 8, 2025, at 17:19, Manivannan Sadhasivam wrote:
>>
>> That is not my impression from reading the code: At least for
>> the case where both devices are on the same bridge and they
>> use map_type=PCI_P2PDMA_MAP_BUS_ADDR, I would expect the DMA
>> to use the plain PCI bus address, not going through the
>> dma-ranges+ranges translation that would apply when they are
>> on different host bridges.
>> 
>
> Right, but I don't get the overlap issue still. If the P2P client triggers a
> write to a P2P PCI address (let's assume 0x8000_0000), and if that address
> belongs to a an endpoint in a different domain, the host bridge should still
> forward it to the endpoint without triggering write to the RAM.

If 0x8000_0000 is an endpoint in a different domain, I would expect the
DMA transfer to go to the RAM at that address since the DMA has to leave
the PCI host bridge upstream by following its inbound windows.

This is not the problem I'm talking about though, since cross-domain
P2P is not particularly well-defined.

> Atleast, I don't see any concern from the outbound memory translation point of
> view.
>
> Please let me know if there is any gap in my understanding.

To clarify: I don't think that programming the output translation this
way is the problem here, but assigning memory resources to ambiguous
addresses is. The host bridge probe uses the 'ranges' both for
setting up the outbound window and the bus resources. 

If the PCI bus scan assigns address 0x8000_0000 to the memory BAR
of a device, and that device or any other one in the /same/
domain tries to DMA to DRAM at address 0x8000_0000, it would likely
reach the memory BAR instead of DRAM. If for some reason it does reach
DRAM after all, it would be unable to do a P2P DMA into the BAR when
it tries.

If the PCI scan already checks for overlap between the DT "ranges"
and other resources (DRAM or MMIO) before assigning a BAR, this may
be a non-issue, but I haven't found the code that does this.
Looking at pci_bus_allocate_dev_resources() it seems that it would
attempt to assign an overlapping address to a BAR but then fail
to claim it because of the resource conflict. If that is the
case, it would not actually have an ambiguous DMA routing
but instead the device would fail to be probed because of the
conflict.

    Arnd

