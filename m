Return-Path: <linux-pci+bounces-37700-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 325EABC3DC7
	for <lists+linux-pci@lfdr.de>; Wed, 08 Oct 2025 10:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFA863ABA5D
	for <lists+linux-pci@lfdr.de>; Wed,  8 Oct 2025 08:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 135D22EBDC2;
	Wed,  8 Oct 2025 08:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="2IwqYrEl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D+kinXt0"
X-Original-To: linux-pci@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E91E2E9743;
	Wed,  8 Oct 2025 08:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759912557; cv=none; b=p8PLujP3KAVafRU4TqKJFLQiyFXn+nwSLlIH/1DiBMXrlIlvv9heqmv9wTCBdzYY7pDFlUhX2s9uTmdOoDSaIdmDh36fX4LSSDY++89CqlCm1W6TeGhPc4AuX5nrApwh7/+fUhrjn577CRkzf/m83+Rp2faHmXQ4vjwxF3kNqmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759912557; c=relaxed/simple;
	bh=Adzd7UoQ5vUNjWRQvEhi7PjsTGLFn60xlIozbT0BOsw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=I/jLg2HfMZe1PAxVUNRPMCY6j7nO0En80PnthxpRFD6qNqaBPl2R78wwkBcpJIoFgIKvcPanz2yBqu5mxnIq0v2PtDQUFZ2bpI6GK6h30C7f/vl1EtFykJVeSdgQeiygnbB3QnO2oJkceKndWCKE6e89hMOKPexyGpBijhQrqMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=2IwqYrEl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D+kinXt0; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 82D71EC0215;
	Wed,  8 Oct 2025 04:35:55 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Wed, 08 Oct 2025 04:35:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1759912555;
	 x=1759998955; bh=zeb5RuY2c0u9ghevJDRFDZqvJ2FDfw5r6+OP/kjAGAA=; b=
	2IwqYrElz1JSAUWV4eJeFCYYGmVkZ4QWTnRvALTaJ7boMLqQaCozT5Gx6cHHg2Yv
	jLAI3C6FZCKUGvoAYGSDtcm33y1LmR4i9GR1se6xQ5R/CUfVzSTw+qb39QoWazEV
	l0JvWbVuv7I7ErnJnDEA5bKQwPxglQ46BQT8S2Re1ptB3lafNmmezsVCi1gDAJnu
	9zILd6c/VNxrlmEUMz5IvXGJByefJEc4/3tpr++5OHZHd9f+THkc5BjFJgsNugtt
	iJloRXzF4yXfmRvSRitHctOwqX3ULZ+xhqVrZ+Vjl/d22JEiHaaWwHNsaS7zumkA
	eI2wbJHkXmJrdpYqPWNrcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759912555; x=
	1759998955; bh=zeb5RuY2c0u9ghevJDRFDZqvJ2FDfw5r6+OP/kjAGAA=; b=D
	+kinXt0zDD+YJVT18JySS322u5WouzXXlD6rtzZ6Sr6g/Tk3lfsBMeKOZM2ZlGbt
	5stS/GcWJEk/AH7BcIy/8REJ8EPLkaPOl3w3R8tmsgN9DmgPc6h3jqOnVA26qTI6
	wwbUe07mwm9sdOS0oP4YohFzaYzcEWXwFAbjI/xIRe/AF02gh9RTOBq4ZudzdcTY
	VRPVUNnfIhjAQk4f9fJqrYrBZCUdYe6DqSsEOJR0gWv53Pq3lcBNMKzC+yuTt8ud
	ND/eFyDaJJP0Z3exH1qi69HtS9NLJfJH19hW3VzTgFSrB31JI56axlZAXC0I8N7u
	MLZjL2GtXetv2YsEy8f5Q==
X-ME-Sender: <xms:aiLmaCq4QgTQtjC1ovRTGObLHAx3Zp9eIothUmkZniPlcRfoXK75gw>
    <xme:aiLmaLf5JNDkBBOjZes9E0KBr9Q1gEyMM1IJ-zxtxgcfPp4MRy4_RcSnscZVh6O_6
    vrE1RcO0QMQhL6slqJZp3FoXNufRJxyBSnH5puGZ0IfhA5K7mejUOs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutddvkeegucetufdoteggodetrf
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
X-ME-Proxy: <xmx:aiLmaNadRkIptaRFWW9MfZ6iZtKQ_3s4hsDZg00OwvNHUC3zGBmQpA>
    <xmx:aiLmaP5-_xVvX5lwD9SmPv4qYunt-9lwAtNlBBo_NWDitU7GvW0KAQ>
    <xmx:aiLmaF_9uSdZUK2sCtqEUJ5WcE09aYzLCeXRp4FDOvGz9NW_He7DrA>
    <xmx:aiLmaJYQ8C-Jhi19pqExUw5gmHePXqvQWgHo9A8mjm5jZYPD8C-3Fg>
    <xmx:ayLmaB0EbV7vcE3XBos2_C1lqAikXKLF6DE3T1fbkCk3NAu3l5Kb0HGw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C1EEF700054; Wed,  8 Oct 2025 04:35:54 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AIHrVq-NOQMk
Date: Wed, 08 Oct 2025 10:35:34 +0200
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
Message-Id: <4143977f-1e70-4a63-b23b-78f87d9fdcde@app.fastmail.com>
In-Reply-To: <eba7d968-209d-4acb-ba41-4bebf03e96ba@app.fastmail.com>
References: <20250919155821.95334-1-vincent.guittot@linaro.org>
 <20250919155821.95334-2-vincent.guittot@linaro.org>
 <iom65w7amxqf7miopujxeulyiglhkyjszjc3nd4ivknj5npcz2@bvxej6ymkecd>
 <aOU0w5Brp6uxjZDr@lpieralisi>
 <4rghtk5qv4u7vx4nogctquu3skvxis4npxfukgtqeilbofyclr@nhkrkojv3syh>
 <eba7d968-209d-4acb-ba41-4bebf03e96ba@app.fastmail.com>
Subject: Re: [PATCH 1/3 v2] dt-bindings: PCI: s32g: Add NXP PCIe controller
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Oct 8, 2025, at 10:26, Arnd Bergmann wrote:
> On Wed, Oct 8, 2025, at 00:28, Manivannan Sadhasivam wrote:
>> On Tue, Oct 07, 2025 at 05:41:55PM +0200, Lorenzo Pieralisi wrote:
>>> On Mon, Sep 22, 2025 at 11:51:07AM +0530, Manivannan Sadhasivam wrote:
> On the other hand, what looks like a bug to me is that the CPU
> physical address range for the PCI BAR space overlaps with the

s/CPU physical/PCI bus/

> the physical addresses for RAM at 0x80000000 and on-chip devices
> at 0x40000000. This probably works fine as long as the total
> PCI memory space assignment stays below 0x40000000 but would
> fail once addresses actually start clashing.

I got confused here myself, but what I should have said is that
having the DMA address for the RAM overlap the BAR space
as seen from PCI is problematic as the PCI host bridge
cannot tell PCI P2P transfers from DMA to RAM, so one
of them will be broken here.

With a bit of luck, the host bridge ends up doing a DMA instead
of a P2P transfer, but I would not want to rely on that.

      Arnd

