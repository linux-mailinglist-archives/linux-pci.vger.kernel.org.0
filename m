Return-Path: <linux-pci+bounces-4918-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F7838805B5
	for <lists+linux-pci@lfdr.de>; Tue, 19 Mar 2024 20:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1888828428E
	for <lists+linux-pci@lfdr.de>; Tue, 19 Mar 2024 19:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF41155E40;
	Tue, 19 Mar 2024 19:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="gjr08SIu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CymooBuE"
X-Original-To: linux-pci@vger.kernel.org
Received: from wfout6-smtp.messagingengine.com (wfout6-smtp.messagingengine.com [64.147.123.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588204AEF8
	for <linux-pci@vger.kernel.org>; Tue, 19 Mar 2024 19:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710878144; cv=none; b=AzpYuQTP1KEBoDEkXgvxW+riNWiAIxJ6NF6+MmO/uefBaCpP32xMyFJw/ZjNye53e1UYvtn/DWMuLX/MJEY2YsMQbwHW3DL/hlDygt5DQFm1ETYEMSvaznPlGRmq4OeoiI2a68o/UYRrSHiVT9FzOYORe4QhkqOS0mww/+d0BL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710878144; c=relaxed/simple;
	bh=ueU4WPdpfUERgTelSI4u6i/E5gkDEAP8Lc1GCZP/mKw=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=Dxfy1fH6sTFwSLEgiTkZ2lwqkHzATpbPOcaSH+SgD/wtEYF7F7vmzUy66EWT/0hWivB5suUUleGWZOZU4bjfkXJ34HZg50SO7lS8ZJAVMVbrluQ4WS/HSd3+fc9PN0AGDqbfXnrwTHcwvyV7RyIJgAhvkHUS05AjHcsQGo8WHjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=gjr08SIu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CymooBuE; arc=none smtp.client-ip=64.147.123.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id C5AF91C0010D;
	Tue, 19 Mar 2024 15:55:40 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 19 Mar 2024 15:55:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1710878140; x=1710964540; bh=+oEwyqOQjX
	KE+NB0O/nhi+VdSY2NMf7v7iHsue3oiR4=; b=gjr08SIu5n8n8uJCvcKdRCuLOY
	QG66eF+q8XlIigPWiGHkpIbO0OGl6MdLyBn8tRUii7W9WNUjfqFiUpDy9r2vJpMq
	ssqCjdA26fcUHv9WPN/5l+vjU+rxBGhYDD83pkXCpXn5SrR6YAZtzW22aP4wEspm
	j/BojYyV6z4h/osI99eYB6/nHgl3Wfq7ZG4kJlrBqzj3d2Aee2GkdPAYC9dfLoNZ
	hAQAnU0tO+x/e1TqrWfpnxqQSoTlCRnYhmC7HJGiw6N/gLz4pmnWGAVH2sZOMT8k
	hZ/805FAETSJiurWCn7Y1WWzQDPRs7uPVJNcXT3VjFahddMXkOSYz854zW5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1710878140; x=1710964540; bh=+oEwyqOQjXKE+NB0O/nhi+VdSY2N
	Mf7v7iHsue3oiR4=; b=CymooBuEHvavm0rhWEAviWW0A2GGyLb1yGXMRD8oUrEl
	36mW6rlk8Om8brEQydZoJLGNUcTVcg3D0z7lml6WY6x1nCk0ss4GNYGi67yjy5hN
	d4ca+bFPOV5vdn2Z7hky1e7hH9oAKom7OpNcde421gHaUOQIhFCWcVdLwmhV1/rz
	dMBTO+7iirRPfJ/1VtTyMprikPr2Cemw5D8mQJCCKICRZF/7RTAWcXCNd6Mu2c93
	zXZq7Bn4UolZJQaDvKkpGymIWqTlfEf9mUlTmW9Ldsnd9aYHC4Sp4Xjhd9Qwk/wC
	24cx1m/i7QWxBI76CIXzNBAqqSCVRFShsnn6Q+Swqg==
X-ME-Sender: <xms:vO35ZesS_X2VsD0dggRtuAyolCCxGUcioTWKWIajPo1UdJ0AfAqf6A>
    <xme:vO35ZTdMWoZUmVdb_MnAaIu2pgnokCpaVKUoTCNHb3NV3j634ugXXPaVGDVnXyXLV
    M2lmU5JzkkldFfsFcA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrledtgddutdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepjedvvddvudeludehjeeitdehheeivdejgfelleffiefgvefhhfeuudfhgeef
    feehnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:vO35ZZw1AEHDq10DWJIt-iCZtIS0YPeCVnOQ79N8tbevbe3zxZ669A>
    <xmx:vO35ZZNn9NXEvflGEdCQllbT_FETK3g-LGTXRNTdf7cz1RXzg_GQWw>
    <xmx:vO35Ze_v5d-ZKGMORoGJEwkkKv7llC1_ideKQzYyRPyyTH32l9p2fQ>
    <xmx:vO35ZRV_st3E4XDbzttZm5phGumKFcAMB4SVXyjH07JfDaQFmqaxbQ>
    <xmx:vO35ZTNS2-xKJ9ePwdlPMsOFt5SS3AUwUHu8z2mdNyq7GGslF8Hz51tV1K4>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 0FC7CB6008D; Tue, 19 Mar 2024 15:55:39 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-300-gdee1775a43-fm-20240315.001-gdee1775a
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e284c1cc-0258-4363-930f-5b508855c094@app.fastmail.com>
In-Reply-To: <ZfnDHgqJOAVubbke@ryzen>
References: <20240318193019.123795-1-cassel@kernel.org>
 <8194c85c-cdc8-431a-a2fc-50569475b160@app.fastmail.com>
 <ZfnAATqpYlssxrT3@ryzen> <20240319164826.GF3297@thinkpad>
 <ZfnDHgqJOAVubbke@ryzen>
Date: Tue, 19 Mar 2024 20:55:19 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Niklas Cassel" <cassel@kernel.org>,
 "Manivannan Sadhasivam" <manivannan.sadhasivam@linaro.org>
Cc: =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 "Kishon Vijay Abraham I" <kishon@kernel.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Damien Le Moal" <dlemoal@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] misc: pci_endpoint_test: Use memcpy_toio()/memcpy_fromio() for BAR
 tests
Content-Type: text/plain

On Tue, Mar 19, 2024, at 17:53, Niklas Cassel wrote:
> On Tue, Mar 19, 2024 at 10:18:26PM +0530, Manivannan Sadhasivam wrote:
>> > 
>> > I did also see this comment:
>> > https://github.com/torvalds/linux/blob/master/Documentation/memory-barriers.txt#L2785-L2790
>> > 
>> > Do you think that we need to perform any flushing after the memset(),
>> > to ensure that the data written using memcpy_toio() is actually what
>> > we expect it to me?
>> > 
>> 
>> The documentation recommends cache flushing only if the normal memory write and
>> MMIO access are dependent. But here you are just accessing the MMIO. So no
>> explicit ordering or cache flushing is required.
>
> What does dependent mean in this case then?
>
> Since the data that we are writing to the device is the data that was
> just written to memory using memset().

You need a barrier for the case where the memset() writes to
a buffer in RAM and then you write the address of that buffer
into a device register, which triggers a DMA read from the
buffer. Without a barrier, the side effect of the MMIO write
may come before the data in the RAM buffer is visible.

A memcpy_fromio() only involves a single master accessing
the memory (i.e. the CPU executing both the memset() and the
memcpy()), so there is no way this can go wrong.

     Arnd

