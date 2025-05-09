Return-Path: <linux-pci+bounces-27486-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 349A3AB09B8
	for <lists+linux-pci@lfdr.de>; Fri,  9 May 2025 07:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A4FC1BA1FE4
	for <lists+linux-pci@lfdr.de>; Fri,  9 May 2025 05:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F9D22D9F4;
	Fri,  9 May 2025 05:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="R6sjU6tF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YXvGc1pL"
X-Original-To: linux-pci@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BFC255F4B;
	Fri,  9 May 2025 05:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746768802; cv=none; b=jZFw/B4fYPRS7+9Cn+hXAm2O31kYRxRiOpWKFcjY5UCe98p7dhm/Oir2U8KrzTDOTZarUm90/Cw62vwCbWgtJKuYHDfT28RWYI/tmh9Y2yQpfk8JJSLe0XyC7LxZ3GNLhykzZ/vBxWF0OqJiZFqNkfettjZMvUdHNQErZmHGBjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746768802; c=relaxed/simple;
	bh=lBRFBwR/1VtW0uBXyryFcybhU0Cc0BFhJXuoEgbaaZ4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=iPjsFdnQN3GLUs+ddbpniZOsCh8F+2jPh80kEUmsaPqTphq2b86SfltHLIk1SNfAai3XtcuEJok8hb2f+O0fo0Q91O6HKUQMxf9EYrbxDdmxxLyo4lzmi1onWiW/dpiwWDZGAHeuiYZxfw3qxWf4Ga7vbU45/cpzYEiRd4LopO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=R6sjU6tF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YXvGc1pL; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 68F9513801A1;
	Fri,  9 May 2025 01:33:17 -0400 (EDT)
Received: from phl-imap-12 ([10.202.2.86])
  by phl-compute-05.internal (MEProxy); Fri, 09 May 2025 01:33:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1746768797;
	 x=1746855197; bh=t2YxXFKHFDywTnpUVPJ2WSZTl8hvqzllpyuVsk0jAuc=; b=
	R6sjU6tFTpOfJG4k3gLp1wcTPGbj18BrjUfj1fIabbdxBRuO0oX+dTTGeJv6IVir
	jZEk9BeeqVnaE80M69zNZRKn+mxIIEU1gxFxax3mxf7slPp78Q9cDrBLwyfL/JC9
	IfCF54uYZaXdZ2dRvz9/I7APa5SDxrqbatSqO0GdbEdIlDi/kCQQBt/fRedjpfvh
	BfY9vmVBoEPi9kS4OVZXqwgSaMLQjQ+C7BnbLP2bbLpLNSW7pI0c/TTZ1ZF9OOGP
	IEnWhLNpAxdwBcDtbkTcEcL+6VJXU8AlDdePk3syNygKpJZymoJMq64mfFqGI+Lu
	fWbZ8SrGFNJv0LfH/pPgXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746768797; x=
	1746855197; bh=t2YxXFKHFDywTnpUVPJ2WSZTl8hvqzllpyuVsk0jAuc=; b=Y
	XvGc1pLR5fFzN8xpl6qJ+RnAjHdnDrP8wQ+PQqfndcSLU2NYgrqTA1/IUQlkCZ/g
	jB1bkLooScSswalrESzZsF72oiB+0tzePI2FyeUnkSyp3SSxtNGCd6OWVr8srVVg
	LWT0Ek/OANNUXNOO26ArfOempMkSOWye2TOrcNJjTolyADzlcU6tkwvyB3PEz5bn
	QX/bC7aubZdPvFOp9lWf5Jd4EOnrMwD5IxFoc/eQfOmWI/c1AgR+XIBwTnvdakyA
	ylri/rV6xpx8dzy1HgSwBUmn4gn54NTkhDuKwUwqtMF4Ej8WcP2s5kczQUMjrQDc
	pNRPp+isGW8u8ySCGTeuA==
X-ME-Sender: <xms:nJMdaN1nkBySxnjS6RmPn6nI4BgVcb6BfVZ5L-EcWRPnJ4htar8D0Q>
    <xme:nJMdaEHjfpS9fdjaxFH4wxOosm6W3uzJs9LQSlQ5RdtRw3iRhWrTEVq0JQRA3s0w1
    zAeGImK1pbFegibzzA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvledujeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertder
    tddtnecuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnug
    gsrdguvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeet
    fefggfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohep
    vdekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegurghnihgvlhdrrghlmhgvih
    gurgestgholhhlrggsohhrrgdrtghomhdprhgtphhtthhopehsihhmohhnrgesfhhffihl
    lhdrtghhpdhrtghpthhtohepghgrrhihsehgrghrhihguhhordhnvghtpdhrtghpthhtoh
    eprghirhhlihgvugesghhmrghilhdrtghomhdprhgtphhtthhopegrlhgvgidrghgrhihn
    ohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghnughrvgifjhgsrghllhgrnhgtvg
    esghhmrghilhdrtghomhdprhgtphhtthhopegsohhquhhnrdhfvghnghesghhmrghilhdr
    tghomhdprhgtphhtthhopehfuhhjihhtrgdrthhomhhonhhorhhisehgmhgrihhlrdgtoh
    hmpdhrtghpthhtoheprghlihgtvghrhihhlhesghhoohhglhgvrdgtohhm
X-ME-Proxy: <xmx:nJMdaN6Afw_HKylIEZOLZXbXPZ73KMByF2kl6GM4PRgSP-Y5JVyQEg>
    <xmx:nJMdaK2-nLwcpQYJoqLRN0mRVbxfbdQcp5INSrjavKi5cK22h9KZIw>
    <xmx:nJMdaAFizCudYEYizsO_kAUifwWFZTj9cZ_YoHuCS263Tva0GUvUNQ>
    <xmx:nJMdaL885f0IlJ_fIQgdr5wlXv-wnGAryqZ57BTtW2T4QIdzy_0lGg>
    <xmx:nZMdaJEQnTgiXXTlR7IQZhL5iujo-h3-3TICG1ZaLIUMVjtBky07ppv0>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 256701C20068; Fri,  9 May 2025 01:33:16 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T9369d7ce4b07c959
Date: Fri, 09 May 2025 07:32:55 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Andrew Ballance" <andrewjballance@gmail.com>,
 "Danilo Krummrich" <dakr@kernel.org>, "Dave Airlie" <airlied@gmail.com>,
 "Simona Vetter" <simona@ffwll.ch>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>,
 "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 "Benno Lossin" <benno.lossin@proton.me>,
 "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, bhelgaas@google.com,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 "Raag Jadav" <raag.jadav@intel.com>,
 "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>, me@kloenk.dev,
 "FUJITA Tomonori" <fujita.tomonori@gmail.com>, daniel.almeida@collabora.com
Cc: "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-pci@vger.kernel.org
Message-Id: <99c535a7-a9fc-41a3-8cca-0a329fc68b8f@app.fastmail.com>
In-Reply-To: <20250509031524.2604087-2-andrewjballance@gmail.com>
References: <20250509031524.2604087-1-andrewjballance@gmail.com>
 <20250509031524.2604087-2-andrewjballance@gmail.com>
Subject: Re: [PATCH 01/11] rust: helpers: io: use macro to generate io accessor
 functions
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, May 9, 2025, at 05:15, Andrew Ballance wrote:
> +
> +define_rust_mmio_read_helper(readb, u8);
> +define_rust_mmio_read_helper(readw, u16);
> +define_rust_mmio_read_helper(readl, u32);

This makes it harder to grep for the definitions when trying
to follow the code flow. Can you find a way to have keep the actual
function body in source form, using the name of the generated
symbol?

     Arnd

