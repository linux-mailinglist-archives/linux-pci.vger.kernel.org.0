Return-Path: <linux-pci+bounces-27489-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E63FAB0A07
	for <lists+linux-pci@lfdr.de>; Fri,  9 May 2025 07:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 700AB1C05E3A
	for <lists+linux-pci@lfdr.de>; Fri,  9 May 2025 05:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6913E13C816;
	Fri,  9 May 2025 05:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="vrokks9c";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="stGjpmFv"
X-Original-To: linux-pci@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DD117588;
	Fri,  9 May 2025 05:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746770035; cv=none; b=UZo0kL9SQLehmyYyJ8u1hp4mcbX0k/wIWDTjrlnwB8LGiCvYRCIos4RRQz3rrKPGx+zmu0xxXs7PN4NGrbrBPYu/5/fudMXJMNxBtX/+HOalBpEmpAM4KqNsqk2lp7BGHIzwvzmU760kV0tCU5wmTx5r8wR+po70JlMIg7XOTbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746770035; c=relaxed/simple;
	bh=oK8JOP0lWXtZNYpUC/KRKBCxijsLzFQJv7bsx9Ih8Bg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=YQGWZQrtP8UXvwMv2aQ2ikgmtKFUFZJQwqmQIvzUQ8dc4f9RaWNKCJ9ClyHH3h6pTAiKFNHli+DtW0hWDP67OR8THGIifQKIEkBjYN1GfAnctp4wPwbIUP8oBCibfaKlOU/eVmuGKs+nsYb/yiZItCElDMNU991MKE0Rk51Ej+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=vrokks9c; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=stGjpmFv; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id B029E13802A6;
	Fri,  9 May 2025 01:53:52 -0400 (EDT)
Received: from phl-imap-12 ([10.202.2.86])
  by phl-compute-05.internal (MEProxy); Fri, 09 May 2025 01:53:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1746770032;
	 x=1746856432; bh=7hl72E2OIJN47yF5dCchC20sQYVZdiJuH3axvIrqn2E=; b=
	vrokks9cFePzHSvLfvuqIlCUXXSdY848/MIkQyijE7Lt/kq/s58IIKLutrFPQZas
	kHlycHUBnO9scaNn1YafO5feeKp5U+LibATLWx2WIIperaHxYnUZDGmRiTxawzJA
	WDWc3bcH85RLIuyoQhHuLuHhT8LR3yi7pdTK7MepGa9SrKH1lOqkDtbuOhodadVy
	23d0a5RxEyQrjcT4KhCiEmr/m8uVlx+mT8X6Ps/U/6IYgq7bJ8007DrcK0lvDChd
	wgxmMLecGDclnogFjzPBFzm83dCv6TXC/A0k5duBUAwDcHpvpN/xdUfVAvDE1xiY
	hnUWhSWe88UC1IeB3si40g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746770032; x=
	1746856432; bh=7hl72E2OIJN47yF5dCchC20sQYVZdiJuH3axvIrqn2E=; b=s
	tGjpmFvkfGy34RMMgRvTpPTzGxiehkpiMe2fSq53hcbbw9dgP+efddeuUDbFNA9Y
	BxPjISf6kNWaQj6GYwaUIiszlLAZvIjk6HmNJfVJWzLukMDxC5npra1slQVqKskY
	5s7I+Klda7Z1f3pr9jT07i8h/DnGfcjt3iRrLAa/0BIuP8SZxde+i3KyRa1TIdVQ
	IEvCEQzLBuEnis4Ky8vDRRhjmQzKiO/ZemVoHTtXd639sBNoKFYD9HxQpB65nbF5
	GC7ynYNKhgKeJU+yPAekW6+/T5QBAtkLOe02+mxRGzdAG/NKmpMi98cpfofnF3tW
	6CIgSuACFbxSq4/KIBH2A==
X-ME-Sender: <xms:cJgdaKlVU8mFUnO3mczd3O0VYcLbxaoFfkY2cwehktau7wBtq2CBEQ>
    <xme:cJgdaB1rM2VSoEoH1vlGMOcpjpV-xhB6aZTpH_ws0ZI5qN9cGjSHBgz0hO_v_P3Nt
    x5rqebEo9s7A_MpaV8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvledukeefucetufdoteggodetrf
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
X-ME-Proxy: <xmx:cJgdaIoBPSVCQqLjIsCqs5dhCl0aTVXxAhLCpPrIqa92QSIF4L-SVw>
    <xmx:cJgdaOkPdwb87Zwz7XaRR4U4NhjlO2awHiuNpZBzBWRJjBBOFtvVNg>
    <xmx:cJgdaI3gDK6SBVp8YylLJyyDslDhSFpW91-XIut-eaQ5Wr7tc-tuDg>
    <xmx:cJgdaFvmHHauaPIS8aAELHUFHmGQ1TGeiZbhSsWY1VvWNx3Wwv2lQQ>
    <xmx:cJgdaKLR0GZaqUpXNawDFLd1MBEdRODqfU8_-QeBcvjzv2oRnOuFjZY6>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 13F081C20068; Fri,  9 May 2025 01:53:52 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Tfcfb78bcf68431d5
Date: Fri, 09 May 2025 07:53:31 +0200
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
Message-Id: <ff526b49-a033-450d-9e48-699187167712@app.fastmail.com>
In-Reply-To: <20250509031524.2604087-1-andrewjballance@gmail.com>
References: <20250509031524.2604087-1-andrewjballance@gmail.com>
Subject: Re: [PATCH 00/11] rust: add support for Port io
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, May 9, 2025, at 05:15, Andrew Ballance wrote:
> currently the rust `Io` type maps to the c read{b, w, l, q}/write{b, w, l, q}
> functions and have no support for port io.this is a problem for pci::Bar
> because the pointer returned by pci_iomap is expected to accessed with
> the ioread/iowrite api [0].
>
> this patch series splits the `Io` type into `Io`, `PortIo` and `MMIo`.and,
> updates pci::Bar, as suggested in the zulip[1], so that it is generic over
> Io and, a user can optionally give a compile time hint about the type of io. 

Can you describe here why you want to support both "Io" and "PortIo"
cases separately? I don't think we need to micro-optimize for
legacy ISA devices any more, so I'd hope the "Io" path would be
sufficient to cover the common outliers (ata, uart, vga, ipmi, ne2000)
that need the iomap indirection and also the legacy devices that only
need port I/O (floppy, x86 platform devices, ...).

Ideally we'd only need one set of I/O accessors at all, but I suspect
there are x86 specific drivers that actually need readl/writel to be
inline for performance when accessing on-chip registers rather than
slow PCIe registers.

      Arnd

