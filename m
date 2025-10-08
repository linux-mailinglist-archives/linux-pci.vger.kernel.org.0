Return-Path: <linux-pci+bounces-37699-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AB584BC3D1B
	for <lists+linux-pci@lfdr.de>; Wed, 08 Oct 2025 10:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 322CA351E98
	for <lists+linux-pci@lfdr.de>; Wed,  8 Oct 2025 08:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ECCA2ECD2B;
	Wed,  8 Oct 2025 08:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="zTDwunbg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MerVP5i+"
X-Original-To: linux-pci@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E0E2EBBAF;
	Wed,  8 Oct 2025 08:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759912019; cv=none; b=tXLQUK6l4ibXb7Z888EEeuhcE9vu3DV+sf0/2JOQ5J9sFT7Kfuut3V6wje+6MjL90kAQeKrdcEEAS42isVNvg0krbMiw7rCfdL0ZWsT4b1fd4ROwxIgIstAkeI62eQhlU1riyrI54bTErvR0nZfrguJxNc68iRAVfOa3utQYIVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759912019; c=relaxed/simple;
	bh=NoCj3PDj/ucFGgOoGoh7zLKQ6F3k/KhvKUWc0JBR6AE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=NnxEHVQ4IgGa0bH1IUkCn92a56xHNSg50U98o4lVyfiIm2iCIkD+kl6XVfhZ3HNHLFztwfmQ/EbRbMKQ5intu8PBQiS/91vI+iQ0lPvI+SBX6xwr6KLaU7MLoRoluAxlLH+Fn1kry+qfjadRSoZOsWrTTuSPyrUliGdypX+5mno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=zTDwunbg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MerVP5i+; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 9C908EC0215;
	Wed,  8 Oct 2025 04:26:56 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Wed, 08 Oct 2025 04:26:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1759912016;
	 x=1759998416; bh=F4g4adTQMUVwYTDDDF3YwmkpD9IuhJi9J7dGpH8tKXI=; b=
	zTDwunbgyiibER+SJRhVJ+wD8TQHC+nS5vN6gnuJkpoCMK14LuJ7xVdZv/FtGJM5
	IYm1EJu0KyvUHx03BsLReaNFEHGmIUj8U1VPHKgG3hFxr3IzJF2NcuDtLkZ8kXTd
	EGb96HO6CvmndsCCo/a3+c6q3cOj3Q6kooj1F6daq9E+rBPJLdcChoDk7NSSr1Kw
	jsGihAdTGM4glkALrJf6HWlgnKiFSaNFDF1B/ZOTwLRuLb6dGjs+1/erTd2rqalt
	XLT/9ikSGBcYqd+Az6PLpMTna1mjlnd5AM3l0pXYhMiyZA0odoAdKrhq6yXLb/EK
	icj927pR6I7LBhY+ZzQwxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759912016; x=
	1759998416; bh=F4g4adTQMUVwYTDDDF3YwmkpD9IuhJi9J7dGpH8tKXI=; b=M
	erVP5i+Y9D4XNXBQRjJOzk1JGwnjOFCsrKtlQZ4+z9LhO95zA1wi3evNak1A0gUb
	ggDDJfrDw5qiM49bGqJXsbKHFreGINqu/YieesKfTcxqmHEsgUtag6pCZiw8FsxT
	bHpmw+LMRXwmqtsy5v3PxEUaWw3QyF2xPtk75Bx6/GPIfKOuh/E/bhsQEv2xf4fH
	mu3PvkZDKJhW6Hmp4+9Se4ldz0v0VzyTv6q0m1Jpr7m8zJjHMN4Fm4ZkePPDFHlq
	H5kU5pzqQA00dI1haKXO8Y/ieM6bqvlVTP1vAVT0jaApi1rt+u1rFzqpAZNbsifN
	nHmU8bZ5cEzlLwn3ddb3w==
X-ME-Sender: <xms:UCDmaL0IImzm_PwDSWna-4KHTqF_cK4_Y_cTVNtaxk4gzR4FuGokPw>
    <xme:UCDmaE5aIm7pFRnzvlVbg172uS3EqNI61R2QrTIlgIbBlMOPd_cvDr5jPnkk7MeV2
    4Vu1L0Rq3sORWcFcPZJHLWN5lo8UqMqPSCIkQ5YcIaIFOU-r2L7QB8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutddvkedvucetufdoteggodetrf
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
X-ME-Proxy: <xmx:UCDmaLOlPWHWdQNn4xwFmfSGyab7IqavwPNkHkbJHvvIlDF412pKvQ>
    <xmx:UCDmaF3eBOY6zZMrPIU2phnPckb9VbQZjihp4ek57JRTeF9RPqLjlA>
    <xmx:UCDmaHlCbkpoXY8N1wP84u7TScth8RLT_OtHiGT6yZXAibJBU3XSTw>
    <xmx:UCDmaL66592w09_8OC5012ug0qgCwMPjzCNBU-Re4z41ccAqlChzFA>
    <xmx:UCDmaPYlOr7WPuRBXF8g9VDKDh-FKa8dFjSczSM3F_4uhgs3VBvXXCwE>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id EB7F6700063; Wed,  8 Oct 2025 04:26:55 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AIHrVq-NOQMk
Date: Wed, 08 Oct 2025 10:26:35 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Manivannan Sadhasivam" <mani@kernel.org>,
 "Lorenzo Pieralisi" <lpieralisi@kernel.org>
Cc: "Vincent Guittot" <vincent.guittot@linaro.org>,
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
Message-Id: <eba7d968-209d-4acb-ba41-4bebf03e96ba@app.fastmail.com>
In-Reply-To: 
 <4rghtk5qv4u7vx4nogctquu3skvxis4npxfukgtqeilbofyclr@nhkrkojv3syh>
References: <20250919155821.95334-1-vincent.guittot@linaro.org>
 <20250919155821.95334-2-vincent.guittot@linaro.org>
 <iom65w7amxqf7miopujxeulyiglhkyjszjc3nd4ivknj5npcz2@bvxej6ymkecd>
 <aOU0w5Brp6uxjZDr@lpieralisi>
 <4rghtk5qv4u7vx4nogctquu3skvxis4npxfukgtqeilbofyclr@nhkrkojv3syh>
Subject: Re: [PATCH 1/3 v2] dt-bindings: PCI: s32g: Add NXP PCIe controller
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Oct 8, 2025, at 00:28, Manivannan Sadhasivam wrote:
> On Tue, Oct 07, 2025 at 05:41:55PM +0200, Lorenzo Pieralisi wrote:
>> On Mon, Sep 22, 2025 at 11:51:07AM +0530, Manivannan Sadhasivam wrote:
>> 
>> [...]
>> 
>> > > +                  /*
>> > > +                   * non-prefetchable memory, with best case size and
>> > > +                   * alignment
>> > > +                   */
>> > > +                  <0x82000000 0x0 0x00000000 0x58 0x00000000 0x7 0xfffe0000>;
>> > 
>> > s/0x82000000/0x02000000
>> > 
>> > And the PCI address really starts from 0x00000000? I don't think so.
>> 
>> Isn't the DWC ATU programmed to make sure that the PCI memory window DT
>> provides _is_ the PCI "bus" memory base address ?
>> 
>> It is a question, I don't know the DWC inner details fully.
>> 
>> I don't get what you mean by "I don't think so". Either the host controller
>> AXI<->PCI translation is programmable, then the PCI base address is what
>> we decide it is or it isn't.
>> 
>
> As per the binding, I/O PCI address already starts from 0x0. How can you have
> two OB mappings with same PCI address?

I/O space and memory space can use the same bus addresses,
since they are disambiguated by the type in the actual PCIe
transactions.

We usually assume that I/O space port numbers start at 0 (as done
here), while PCI memory ranges are identity-mapped to the CPU
physical address they are mapped at, but in this case the physical
address window is outside of the low 4GB range, so an identity map
at 0x58.0x00000000 woulds prevent the use of 32-bit BARs, and
mapping something in the low bus address range is the only
possibility.

On the other hand, what looks like a bug to me is that the CPU
physical address range for the PCI BAR space overlaps with the
the physical addresses for RAM at 0x80000000 and on-chip devices
at 0x40000000. This probably works fine as long as the total
PCI memory space assignment stays below 0x40000000 but would
fail once addresses actually start clashing.

Maybe the memory space can be split into two windows like

 <0x82000000 0x0 0x00000000 0x58 0x00000000 0x0 0x40000000>, //  1GB 32-bit non-pref
 <0xc2000000 0x1 0x00000000 0x59 0x00000000 0x6 0x00000000>; // 24GB 64-bit pref

The 64-bit window could be either prefetchable or
non-prefetchable in this case. If there is only one programmable
window for memory space, that would probably have to be
limited to 1GB non-prefetchable for the normal 32-bit BARs.

       Arnd

