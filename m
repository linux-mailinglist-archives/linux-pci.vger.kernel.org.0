Return-Path: <linux-pci+bounces-43710-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86AD3CDD9AF
	for <lists+linux-pci@lfdr.de>; Thu, 25 Dec 2025 10:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4612A3086CBB
	for <lists+linux-pci@lfdr.de>; Thu, 25 Dec 2025 09:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB526319606;
	Thu, 25 Dec 2025 09:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bYB4Kp3d"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7452F616E
	for <linux-pci@vger.kernel.org>; Thu, 25 Dec 2025 09:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766655438; cv=none; b=TsC04n8+D4nCUQdxFtmzMp2JSbcSKk4HGyLO6zQBR48grcZBw/lX6Q0UaOe11k4yVWxc2MgQMApl0p2FgcN8E1yhFMk3Pl5HOl82F1A6M4ASCz6T69du0BmSloaO1/N3CQSGvFDlWfziPoDOFgT6KfMrJv4d/FHs1c+nmUTrrgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766655438; c=relaxed/simple;
	bh=VxBqnPDdnIHjfcuIiI4D7oNyQ73l/jfjo2YNl08bqJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MYBN2SGwNXSbXRY6e6gjd0FJ0IzmQyfRzux6kojKNEpcoDmjGCw57wHY1W1aiFrywWF6YaUDL0rfaxjR3e0IXuFYAD3DGoy4o0GCmSFfbQ912dzOCeU9k8B7uTV1JFeGGnN7TG7TZqcaQZdxXKllSsEotv39Sjgk8A9NWL9VE2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bYB4Kp3d; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8ba4197fbd4so689670485a.2
        for <linux-pci@vger.kernel.org>; Thu, 25 Dec 2025 01:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766655435; x=1767260235; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nVJof1x/tXOVIVA84B6vueb8075E7eaQsUaC6CPaNX4=;
        b=bYB4Kp3dOCIKNZUpZacJP3WH3RWh6xfO55jGEMS21uqATakjZbASrCK4Dkil01nui1
         w+Hvviky4beOmYefTkqi2qQb9qaGV4+VOU46bybMMdiZ6iq1/T9+jU4f9cXBS+15qEmT
         EsFu6gNn++hM83JqlLhZI8qYNOmxzYoMZmx8brw7i3A+bmSbn1lJLbGhs/59CI8rjDM4
         IvljAzzuFGW9PkWfZZlMAzqmn4zz1CewJFFBFQiu32iAZHbFtYtH8QwwrIZsFVM3Kt35
         BjdtlH3EgTH8Ay9vhIS8muTxxRapDQi3dnj2dnXQtt1j7KZtYr2ebGu7j4x/hi+9w0Tq
         rt0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766655435; x=1767260235;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nVJof1x/tXOVIVA84B6vueb8075E7eaQsUaC6CPaNX4=;
        b=V7nu6LoMyBCRKsrAzKx3yzWwRh0BHWlmy68NjElGFjWRPhSQ0+Fjova+0xGJBcCvez
         mil7RWySfJaqKZ0ZdZQJX/BkJ7LPegVSLSIFtCLHQkdsQsXpFXAn2k9TuGb27knsgoap
         wqB6tRH3s8GSwfFc3XDDMH66vrVKJUgbxQ/KrtO8MDSlX61buZIu4g4VxGLOTX0GRjtR
         ZKS496t16KNeCr/26NV2D4I5yIRMv9YAjwdqKo+mE/jH53CSv4HMdv33lBmaalYxBw27
         qUX0DmeH3DiqBO8qCSWPbo/yZW19bB+m9a5bKh3SzhhD6OrjuZkvef71zRnBFxL0FZ42
         5WMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfaijwZBF8Jc2mFtLAFKbK081wqjzFXDqHGwHti6g++is+OjY7EaqiwDFT/wTxu8ILMiRB96AalrY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZLZc/QkR/ElsAPQ+MJtgiy6tIsymZHa2tENYp2XLGbwoOiCfO
	y84wx/+nw096/RKEEtOhdxZLvX2n4C7P9dR6eHAa+41IQKFR7gVATANk
X-Gm-Gg: AY/fxX4L41TH3ee4ZWOTIA0gTcELc1OTiFFtehYbnhcdBIceXPTEopJP81h+xau6tk+
	w7n6/nREHVhaUdpWcKo7stvWRTepuaooowHhYtbDUJ5kld3n2xZ/TR3kmuLjlEAb700hyVrpTsa
	MqJvM0H1Cj8tI7YeoXv30eaYyShfeQbeoxzPkkdXHfV80yKia+RpGXICttcJHzuJDnm7vqiX8fh
	GRZiLTyG2npioEQ4Cp4HVtaSkBz/cdnyfty+xYsJ2ceVVGW6xvoCKHZdlltxRVrxxgoZI+8NWY+
	d6mnS41WwMHxTA99L2TWabpKGaFSNwX212haXSCgk7EsuRfap8nQoeZeWdqKFe3F98zfewLc5UZ
	YYZvJWKFIQbHzaXjRiHgCbchkNx5znqesZb+Wtzzeb9Oxt7awbBwjO8m6DJy4CW265XJ02KUMS9
	AxxUXg/mlcfRIaoiukKOGGJdep1jTfhzK8cPtHq4yW3LuEJ7gODymKVpMSoP6pn2YvCeMEV4Tde
	hbj0R0iKz70Mp8=
X-Google-Smtp-Source: AGHT+IEbRRGZzGujWcSUy0xGCmvJO9s2DIM/tr5qJ7KrDMoaQ6oVqoSAy936oz6+khGEi3m+dJtBJg==
X-Received: by 2002:a05:620a:31a8:b0:8b1:adfd:f850 with SMTP id af79cd13be357-8c08f657bddmr3283688685a.18.1766655434938;
        Thu, 25 Dec 2025 01:37:14 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c096783922sm1491700085a.7.2025.12.25.01.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Dec 2025 01:37:14 -0800 (PST)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 081C8F40068;
	Thu, 25 Dec 2025 04:37:14 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 25 Dec 2025 04:37:14 -0500
X-ME-Sender: <xms:yQVNaa9gqC8xP3THqdxzxmukKh3HUKGi8emT874iWgZpND_VACX0VQ>
    <xme:yQVNaWjsM4lK2eGHNg2XLD5mpvPSh7pdaWPRkf4t_jvoV5a3fp3W2ZqEd4FPTzEp_
    uG7qhSYukof2Sy9Xl2K_UiUoSGLajvIegcTYOQoOyHUv14dGnPN0w>
X-ME-Received: <xmr:yQVNaVhW5xAU0gXRIiniTb3fKy2XwvhESYmWhbcG6v4-zEe0L_lNFgXi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeihedvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeejhfeikeekffejgeegueevffdtgeefudetleegjeelvdffteeihfelfeehvdeg
    keenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgv
    rhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfh
    gvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthho
    peduiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhhighhuvghlrdhojhgvug
    grrdhsrghnughonhhishesghhmrghilhdrtghomhdprhgtphhtthhopehfuhhjihhtrgdr
    thhomhhonhhorhhisehgmhgrihhlrdgtohhmpdhrtghpthhtohepuggrkhhrsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopegshhgvlhhgrggrshesghhoohhglhgvrdgtohhmpdhr
    tghpthhtohepohhjvggurgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghgrrhihse
    hgrghrhihguhhordhnvghtpdhrtghpthhtohepsghjohhrnhefpghghhesphhrohhtohhn
    mhgrihhlrdgtohhmpdhrtghpthhtoheplhhoshhsihhnsehkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegrrdhhihhnuggsohhrgheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:yQVNaU7vLmlvz_TmzcKK8_GzqdrLXemwappQh8-qIqvrOgvxqbAxIQ>
    <xmx:yQVNafRDSgXhWrIjhsyh9Pp9n7AKTBJNjr6RAnvc-4qgnv0QQP4NRA>
    <xmx:yQVNab9kmwaFvijLW-Wef3zNk7ScOIt4bUHFqW-lXEvbLT50IfbPMw>
    <xmx:yQVNaYr9-SoXJgDtCavVte9R-z2AUlbCpZo1Gv7JzqP8QmEJcM1OuA>
    <xmx:ygVNaZX1HyyMaSe9_UxDPloPJKxV-eCNV6w9Smr60iJ45shfJfqdHfmq>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Dec 2025 04:37:13 -0500 (EST)
Date: Thu, 25 Dec 2025 17:37:11 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Joel Fernandes <joelagnelf@nvidia.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH] PCI: Provide pci_free_irq_vectors() for CONFIG_PCI=n
Message-ID: <aU0Fx_w6ZSi-I7UQ@tardis-2.local>
References: <20251215025444.65544-1-boqun.feng@gmail.com>
 <CANiq72n1SX4OGFR4wNzurNX2RQki_ZmD13bBfywxxOEmw6cGZg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72n1SX4OGFR4wNzurNX2RQki_ZmD13bBfywxxOEmw6cGZg@mail.gmail.com>

On Thu, Dec 25, 2025 at 10:10:04AM +0100, Miguel Ojeda wrote:
> On Mon, Dec 15, 2025 at 3:54 AM Boqun Feng <boqun.feng@gmail.com> wrote:
> >
> > Commit 473b9f331718 ("rust: pci: fix build failure when CONFIG_PCI_MSI
> > is disabled") fixed a build error by providing rust helpers when
> > CONFIG_PCI_MSI=n. However the rust helpers rely on the
> > pci_alloc_irq_vectors() function is defined, which is not true when
> > CONFIG_PCI=n. There are multiple ways to fix this, e.g. a possible fix
> > could be just remove the calling of pci_alloc_irq_vectors() since it's
> > empty when CONFIG_PCI_MSI=n anyway. However, since PCI irq APIs, such as
> > pci_alloc_irq_vectors(), are already defined even when CONFIG_PCI=n, the
> > more reasonable fix is to define pci_alloc_irq_vectors() when
> > CONFIG_PCI=n and this aligns with the situations of other primitives as
> > well.
> >
> > Fixes: 473b9f331718 ("rust: pci: fix build failure when CONFIG_PCI_MSI is disabled")
> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> 
> Related: https://lore.kernel.org/rust-for-linux/20251209014312.575940-1-fujita.tomonori@gmail.com/
> 

Thanks! I was missing that, and I should have replied Tomo's patch.

> I guess it counts as a report, so we may want a Reported-by (Cc'ing Tomo).
> 

Tomo, how do you feel about two fix approaches? I think providing dummy
pci_free_irq_vectors() is better because it's easier and aligned with
other pci_*() APIs.

Regards,
Boqun

> Cheers,
> Miguel

