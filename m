Return-Path: <linux-pci+bounces-4875-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D14C87E40C
	for <lists+linux-pci@lfdr.de>; Mon, 18 Mar 2024 08:26:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3C31281509
	for <lists+linux-pci@lfdr.de>; Mon, 18 Mar 2024 07:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB70224CC;
	Mon, 18 Mar 2024 07:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="fOIN7cM/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Dmc+5RJr"
X-Original-To: linux-pci@vger.kernel.org
Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247C612B76
	for <linux-pci@vger.kernel.org>; Mon, 18 Mar 2024 07:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710746762; cv=none; b=chy3grfpclqQ4Pmg76oC3zLc+PpE17B6Uq+iapCBGIB/eF9QEh9mttK3MEribTP20IQcV2ZYDXZ+/sfGUTPWSPKg6SffV7wVyPRNFj+MzDnzA8ZUsD7E2WLCdGr6PZ7fY/3G4BSTuBqaMQMymdzJjNBUtoOfR99fKqHg6HHqB6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710746762; c=relaxed/simple;
	bh=dslN9uL0e4grsl3emI/kjAZtvp0LEJcxh7soIQ4HJGw=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=IISF7HSK0oYDomZ9nhvLwjQkDgzI4c5tUYUS/kTR7dyPI9ue6UYpLDjRjYZwEuuQf4N2gLdmZGUCcOuWzNz9hoEkxjjkXG8NInntRGAGh1PZDQG6nk8KcTx2e2pU6MONaYicbOP1fj/d01B5HNhAFXOU8HfXUFVPwKjsC1F9X5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=fOIN7cM/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Dmc+5RJr; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 31A1C11400C8;
	Mon, 18 Mar 2024 03:25:59 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 18 Mar 2024 03:25:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1710746759; x=1710833159; bh=wfbyFOM/Vl
	9fLSGHcpsdFs51qjBYAbVxcIeZsaEEB5U=; b=fOIN7cM/f5nN6gjomOSZAvY+Xk
	ngGHAyFNSbosUt0/qj9j0TC//Z2WgnGe2Qg086BeQa684N48/KeOL0EK/XQ9nlkR
	Gmxv+P1NdrV1XDaFgz+O/L1Qeng9TSAe7toFYXk4BOuM91gbJcCPyIUZeWsdiqHX
	YwU692QhjTkHYHyjw+eCM4we+A109zlqPGRuGgcXj/U9Hxgbpi5z7n2ke/Z3vaXl
	YVYj+xeQwK9169KXuRU16idg0JmEGVtr9NgV/z2g73FiyYjPXQ8C2nbLmX9Je9YB
	/r3srs+tEA1Mj64W7BD9Yn58fFmbAEKMstbV5uiDaqypQqNpQ6GOO8qOfWmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1710746759; x=1710833159; bh=wfbyFOM/Vl9fLSGHcpsdFs51qjBY
	AbVxcIeZsaEEB5U=; b=Dmc+5RJrj7p0oZQK6j62bxEcCmeLzAs+8wdk1XD1FtbC
	7zAFXiu4Pt2FYfqT082w2PzaBb1Kj0ubYH2D2Oh7X7IgQVg0Th5W71QikNP3aKug
	ozk5NKnlKlkrJzNmsa4/wbnog3HVvIbWWt+Psx7p2MS+pXJz0oNAv/C+3XV4IiZK
	aj7IlurzdhGY7VIJ1578oYNZj7bJZDU3wiuc6P+DM95fWzW1zKgvLbf0WRzqGScq
	Qaog080pQkX3qevY+g5hV4rlGAN/y0teo+Y3R49qNHRJRR2aAChrjJnbVqC4VPDx
	p7cHCuUiIxY4nIp2tkobKzE5LEIE6LPR4fuOL0EunA==
X-ME-Sender: <xms:hez3ZaYRln8V5fe6qPnBdEDUsEDwAlSyhE6qCGiR0HXGQNlFo_3PeQ>
    <xme:hez3ZdbDvqdQW_JG9FZ_rA3auEp2nhjywV2dqjyQq7bulTr0_oz5F0HgFx7s1c1Tf
    KiHMHe3ZttyaaZySXg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrkeeigddutdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepiefhteffiedutdevhedutdelhfehkeehgeevteegudegtefghefhhfetudei
    ieefnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpsghoohhtlhhinhdrtghomhenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnuges
    rghrnhgusgdruggv
X-ME-Proxy: <xmx:huz3ZU_-0-RzxfDDCu1ZPgketAs942b10vO1Mjo8SmN7sPMCR2lLWQ>
    <xmx:huz3ZcqtdRxDm6BCPARya7VSz0rbdJT9S2QIhAHG3g6yUtcFH4u-Kg>
    <xmx:huz3ZVo_unZxFd0yL0DLCm34wRBh_Nrnc2Fb1JYE8icxcqDrK4RSKA>
    <xmx:huz3ZaRxFtYQiEFg5Eiy2duoEJ5CdHMsmJJXsBel57WOYBn9wpOKLw>
    <xmx:h-z3ZShc9553J47eSeJkS3mO9gQniYb9x8eP6afIxduzWe6XEMdMUw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id D7B15B6008D; Mon, 18 Mar 2024 03:25:57 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-300-gdee1775a43-fm-20240315.001-gdee1775a
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <7003f4e3-fe3c-43d7-8562-efaacc3d65d3@app.fastmail.com>
In-Reply-To: <ZfbZ45-ZWZG6Wkcv@ryzen>
References: <20240313105804.100168-1-cassel@kernel.org>
 <20240313105804.100168-10-cassel@kernel.org> <20240315064408.GI3375@thinkpad>
 <9173aa22-4c15-40ec-bf70-39d25eebe4c2@app.fastmail.com>
 <ZfbZ45-ZWZG6Wkcv@ryzen>
Date: Mon, 18 Mar 2024 08:25:36 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Niklas Cassel" <cassel@kernel.org>
Cc: "Manivannan Sadhasivam" <manivannan.sadhasivam@linaro.org>,
 "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 "Kishon Vijay Abraham I" <kishon@kernel.org>,
 "Bjorn Helgaas" <bhelgaas@google.com>,
 "Shradha Todi" <shradha.t@samsung.com>,
 "Damien Le Moal" <dlemoal@kernel.org>, linux-pci@vger.kernel.org,
 "Christoph Hellwig" <hch@lst.de>
Subject: Re: [PATCH v3 9/9] PCI: endpoint: Set prefetch when allocating memory for
 64-bit BARs
Content-Type: text/plain

On Sun, Mar 17, 2024, at 12:54, Niklas Cassel wrote:
> On Fri, Mar 15, 2024 at 06:29:52PM +0100, Arnd Bergmann wrote:
>> On Fri, Mar 15, 2024, at 07:44, Manivannan Sadhasivam wrote:
>> 
>> I think there are three separate questions here when talking about
>> a scenario where a PCI master accesses memory behind a PCI endpoint:
>
> I think the question is if the PCI epf-core, which runs on the endpoint
> side, and which calls dma_alloc_coherent() to allocate backing memory for
> a BAR, can set/mark the Prefetchable bit for the BAR (if we also set/mark
> the BAR as a 64-bit BAR).
>
> The PCIe 6.0 spec, 7.5.1.2.1 Base Address Registers (Offset 10h - 24h),
> states:
> "Any device that has a range that behaves like normal memory should mark
> the range as prefetchable. A linear frame buffer in a graphics device is
> an example of a range that should be marked prefetchable."
>
> Does not backing memory allocated for a specific BAR using
> dma_alloc_coherent() on the EP side behave like normal memory from the
> host's point of view?

I'm not sure I follow this logic: If the device wants the
buffer to act like "normal memory", then it can be marked
as prefetchable and mapped into the host as write-combining,
but I think in this case you *don't* want it to be coherent
on the endpoint side either but use a streaming mapping with
explicit cache management instead.

Conversely, if the endpoint side requires a coherent mapping,
then I think you will want a strictly ordered (non-wc,
non-frefetchable) mapping on the host side as well.

It would be helpful to have actual endpoint function drivers
in the kernel rather than just the test drivers to see what type
of serialization you actually want for best performance on
both sides.

Can you give a specific example of an endpoint that you are
actually interested in, maybe just one that we have a host-side
device driver for in tree?

> On the host side, this will mean that the host driver sees the
> Prefetchable bit, and as according to:
> https://docs.kernel.org/driver-api/device-io.html
> The host might map the BAR using ioremap_wc().
>
> Looking specifically at drivers/misc/pci_endpoint_test.c, it maps the
> BARs using pci_ioremap_bar():
> https://elixir.bootlin.com/linux/v6.8/source/drivers/pci/pci.c#L252
> which will not map it using ioremap_wc().
> (But the code we have in the PCI epf-core must of course work with host
> side drivers other than pci_endpoint_test.c as well.)

It is to some degree architecture specific here. On powerpc
and i386 with MTTRs, any prefetchable BAR will be mapped as
write-combining IIRC, but on arm and arm64 it only depends on
whether the host side driver uses ioremap() or ioremap_wc().

>> - The local CPU on the endpoint side may access the same buffer as
>>   the endpoint device. On low-end SoCs the DMA from the PCI
>>   endpoint is not coherent with the CPU caches, so the CPU may
>
> I don't follow. When doing DMA *from* the endpoint, then the DMA HW
> on the EP side will read or write data to a buffer allocated on the
> host side (most likely using dma_alloc_coherent()), but what does
> that got to do with how the EP configures the BARs that it exposes?

I meant doing DMA to the memory of the endpoint side, not the
host side. DMA to the host side memory is completely separate
from this question.

     Arnd

