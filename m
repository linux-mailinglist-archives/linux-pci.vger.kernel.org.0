Return-Path: <linux-pci+bounces-43715-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 89FDBCDDA58
	for <lists+linux-pci@lfdr.de>; Thu, 25 Dec 2025 11:19:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4500A300768C
	for <lists+linux-pci@lfdr.de>; Thu, 25 Dec 2025 10:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F1330E822;
	Thu, 25 Dec 2025 10:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W2257oxH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B182DA755
	for <linux-pci@vger.kernel.org>; Thu, 25 Dec 2025 10:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766657955; cv=none; b=jmK4hFymEPVdsRIqgbUESVRoseAiitn+Fd4KAa+ZkistyZQkYvQqkey6syZG2io9oDiTD7Je8artMrLvLL7Ys9NbRVRaOY7cJPq8mZO8Q+wmPUPDHbd3MBdADyiLimRmIrV8kIEb1clSjFrqO5HPUYE7xF69XnEUzPdXjXJ0+6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766657955; c=relaxed/simple;
	bh=kUhEEcyeX+pQXDOvMfwKXPAjHAuScIlJSVDFA+dcEAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ui2ABeEM3fH9q7QnS7wMLVj6IuoQrnvlv133xvTVERe4JRqJvdrvPfalgCWGdtV7QEjNAd6O+kJm1EXJ1nVreydQFKxFjVq5s8EKt8623ie69THKOyQW0XeKzLiEA/6ZLVaY86e+ksdvwnj+g4qTVq95PMereKLvR3vhJ2OF5p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W2257oxH; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8b602811a01so726056285a.2
        for <linux-pci@vger.kernel.org>; Thu, 25 Dec 2025 02:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766657953; x=1767262753; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=miZGUQ6K1J5NwF92QvnAvuWWv/LljifSu/1l61TDgUY=;
        b=W2257oxHdD85K+qc2aC52c7kAbA8akLhnNnreroMR5CnejimyePbx8vVF0je7x214F
         RRvdB6yhqMATULvq9uSm6t83yF8Ias6lml4R1fU+WZCqyfG3iaHE6UG1ud7q3WIoG3Yo
         ivhjQBpzjkFPSa/f7pCME98TGRK3JqOGYZpYPzA8DgOfTNdt3SgySsN6tlUDFMp/Ht3i
         wmhMVAFw9HXRilF82EUp3DoOJBgNAHK3EqP18ksUeDgVQK8PzxQmJuJOgQqpMXwFstTb
         iFMv/+DFNg9rO2Cca9flMWbJAQFppr3w4ijvNT4AuNwKWgI0NjVpES3s0I9lT4oEEN8d
         wqpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766657953; x=1767262753;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=miZGUQ6K1J5NwF92QvnAvuWWv/LljifSu/1l61TDgUY=;
        b=l8n3KTku/i2eEntwPibLx/RYdZQMDQnAT3NZZCSeyfqHNT0PYhb99QsO3YO+vwe0AT
         WwPPd+YrljqZlnj4oxygK0vDpJ0/xypn9j5rU8iE9BnulS5FHvKr43KXmER3Fr7Led3x
         dBmQmqVNWqkvxeGJsr4+qKpZAPzitzasn08KXFqB3ma8Z7JRnZKjujEV0kj6N2/exD1M
         txeXWn4PmQx1//6zRCphnJ9wtS2Y86CylAxPPTQVTdeQ2G6bkr/FBEf93ks+aaQe7wdo
         W3BKoBBt0gOX3e6XZNAtlxDXM4M3iZhfu3ovQ0sIkVSqy1nxJ4q2wPr/TCr6T6Q6xmAp
         Hzww==
X-Forwarded-Encrypted: i=1; AJvYcCXWsS7cadFfXkpt83D2KJW4ooC9BcDDVmlTXDvyzjvUl4ZlU3/hWxpbpMWU79AgKsSdmKqWgjQN6bw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHJbbYg7q4SgED62X9ibfBsIuiRG7nvfzU831MPuD2/XB5sbTO
	Dp7u9KN2+rJtozWhSuUYAJqXpXrK9+YQNz0a2dh2oQPb20lwHSvsQ1BN
X-Gm-Gg: AY/fxX5Fd9z2cy4voBGPdZdatgnEHcZDXy1pbgEE6lrvQ2J1LCUAO39fxJW5TymNRlx
	o2xq2MQ9o3B2B2m1ODR0Aye/ftoDDIJJowK40wgP9EOvQcbzSaU/Q2o1ckbO9GIzBfYyG8A7Kwt
	1G9n7TlBrPupl3y89FaILELeoscfSTd9jrGcTsRvo/dx04wmXv/GSsoYL2fg/1F5e9XwG41N0Ag
	49KIHpGABu0TpByFNzAvRIYnAzFhusBhwwjYYQaHlu3X3otcufgbuFyJvezkxCm5Dca1d03pZya
	7ZVouQ0PA5uvEmvO4mldOu/EniLCou/YhXsbINVSCyK1xB4cdwlkXjONsGAg9cuWIB3dvllJEMF
	T53i0yJYiokOxO/phSqNpmtiYASMktiAJ39gnJca/F9O3aT9WSzqlVTbWQZm/UrRXcQ1c1XUCbE
	KJP6xQ6WmHTTalODOxP3erKCF1vqk+pqtpLMKowlo/mQSDRkKt9p/j40q2+OMf8w2Zl2R1iYk5G
	WLfcGBKIGW1gKZgG+uL5CHkOQ==
X-Google-Smtp-Source: AGHT+IELRx4EtlvFzotPmT4j3ykDSAHpxE8LMB6n3jz+WJQmz7KUPu0AQGuczmt78vVQelUhFbXvrA==
X-Received: by 2002:a05:620a:4556:b0:863:42ea:d687 with SMTP id af79cd13be357-8c08fbb8308mr3496223485a.78.1766657952699;
        Thu, 25 Dec 2025 02:19:12 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c0970f5fcdsm1461045685a.29.2025.12.25.02.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Dec 2025 02:19:12 -0800 (PST)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id BB627F40068;
	Thu, 25 Dec 2025 05:19:11 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 25 Dec 2025 05:19:11 -0500
X-ME-Sender: <xms:nw9NaSLI8rBUYl3awLA0Ikr0EzR-nflKjXU5GXsYUEEr2TBVQDWJUg>
    <xme:nw9NabFAvq5EfgsjW7C7VSSL7B9RGkoMpSdh9LvqdRlC1YesG__kofhNibg5hNSMP
    ofZoW52Z7a-BWqxlByoESkr8x6oiYziBHgsSHnm-_icAQ-qD7on>
X-ME-Received: <xmr:nw9NaTCX-VTFYYSrbvZA1yttz-TwzNYlq6rbc8Con-TztfVRnoawVY5e>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeiheefvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeejhfeikeekffejgeegueevffdtgeefudetleegjeelvdffteeihfelfeehvdeg
    keenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgv
    rhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfh
    gvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthho
    pedujedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepfhhujhhithgrrdhtohhmoh
    hnohhrihesghhmrghilhdrtghomhdprhgtphhtthhopehmihhguhgvlhdrohhjvggurgdr
    shgrnhguohhnihhssehgmhgrihhlrdgtohhmpdhrtghpthhtohepuggrkhhrsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopegshhgvlhhgrggrshesghhoohhglhgvrdgtohhmpdhr
    tghpthhtohepohhjvggurgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghgrrhihse
    hgrghrhihguhhordhnvghtpdhrtghpthhtohepsghjohhrnhefpghghhesphhrohhtohhn
    mhgrihhlrdgtohhmpdhrtghpthhtoheplhhoshhsihhnsehkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegrrdhhihhnuggsohhrgheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:nw9NaV1J3Bk0NAezLUsr0x34VUOdDfCkFHv84Pd9Cpa80h9aqUKmZw>
    <xmx:nw9NaQNtZu6iGHkDwtd6cDsWVBzuoBPz9fJsdPa5ZRRtY4sw7bx7vw>
    <xmx:nw9NaS7blenS2HGYVdB3j_djThInoaK-aAkg0sS4l3yNXzQ3GO9HaA>
    <xmx:nw9NadZCA809QIuB1YJDYXLN72eFAfwjcyhOuhWjZEbXj3he8QuZ5w>
    <xmx:nw9NafGRXYyU_jSRIlX7j6KEKxzY4YYq5-jRG7OsE3boB7EC_VveHP6v>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Dec 2025 05:19:11 -0500 (EST)
Date: Thu, 25 Dec 2025 18:19:08 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: miguel.ojeda.sandonis@gmail.com, dakr@kernel.org, bhelgaas@google.com,
	ojeda@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com,
	lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
	tmgross@umich.edu, joelagnelf@nvidia.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	Liang Jie <buaajxlj@163.com>
Subject: Re: [PATCH] PCI: Provide pci_free_irq_vectors() for CONFIG_PCI=n
Message-ID: <aU0PnCV69l7lV2aS@tardis-2.local>
References: <20251215025444.65544-1-boqun.feng@gmail.com>
 <CANiq72n1SX4OGFR4wNzurNX2RQki_ZmD13bBfywxxOEmw6cGZg@mail.gmail.com>
 <20251225.183631.866118259815088053.fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251225.183631.866118259815088053.fujita.tomonori@gmail.com>

On Thu, Dec 25, 2025 at 06:36:31PM +0900, FUJITA Tomonori wrote:
> On Thu, 25 Dec 2025 10:10:04 +0100
> Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> wrote:
> 
> > On Mon, Dec 15, 2025 at 3:54 AM Boqun Feng <boqun.feng@gmail.com> wrote:
> >>
> >> Commit 473b9f331718 ("rust: pci: fix build failure when CONFIG_PCI_MSI
> >> is disabled") fixed a build error by providing rust helpers when
> >> CONFIG_PCI_MSI=n. However the rust helpers rely on the
> >> pci_alloc_irq_vectors() function is defined, which is not true when
> >> CONFIG_PCI=n. There are multiple ways to fix this, e.g. a possible fix
> >> could be just remove the calling of pci_alloc_irq_vectors() since it's
> >> empty when CONFIG_PCI_MSI=n anyway. However, since PCI irq APIs, such as
> >> pci_alloc_irq_vectors(), are already defined even when CONFIG_PCI=n, the
> >> more reasonable fix is to define pci_alloc_irq_vectors() when
> >> CONFIG_PCI=n and this aligns with the situations of other primitives as
> >> well.
> >>
> >> Fixes: 473b9f331718 ("rust: pci: fix build failure when CONFIG_PCI_MSI is disabled")
> >> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > 
> > Related: https://lore.kernel.org/rust-for-linux/20251209014312.575940-1-fujita.tomonori@gmail.com/
> > 
> > I guess it counts as a report, so we may want a Reported-by (Cc'ing Tomo).
> 
> Since pci.rs is only compiled when CONFIG_PCI is enabled. So it seems
> consistent to treat the PCI helpers the same way. That said, this
> approach is also fine by me: it's already inconsistent that
> pci_alloc_irq_vectors() has a stuf definition, while
> pci_free_irq_vectors does not.

Yes, I think providing a stub pci_free_irq_vectors() is the way to go.
If you are OK with it, I could send a v2 with your and Liang Jie's
Reported-by. Alternatively, since you're the first one sending the fix,
and I would have replied that with the suggestion if I didn't miss that,
feel free to send a v2 (providing the stub pci_free_irq_vectors()) from
you ;-)

Regards,
Boqun

