Return-Path: <linux-pci+bounces-36113-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C934B5703C
	for <lists+linux-pci@lfdr.de>; Mon, 15 Sep 2025 08:28:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DF953BD48B
	for <lists+linux-pci@lfdr.de>; Mon, 15 Sep 2025 06:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E80327FD49;
	Mon, 15 Sep 2025 06:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LflDPC5E"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0CB1DED64
	for <linux-pci@vger.kernel.org>; Mon, 15 Sep 2025 06:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757917724; cv=none; b=YClWL9SjBUdnt6o8xCW9vX87LBBCgOPEQWVqSPMjyFNAyhz2/q6C//CUc0VwqclMNZHhVnvbN3qGpDwq/WvL8p4exMWZzHyv8bektdRyXiJi4fQM88h2XpQ/paOQ+SQp00TUm8wxgTZsChxBt89g/Fjm/VmNoti0F7w1iVLz25o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757917724; c=relaxed/simple;
	bh=r/9Kn45ZUStYRhTjTOzLMQUK+ADSzSjvKa97iBsSXfk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W1atF5+Fm/O/MYio52rU+ZuVUaUjp+ZJ0SRwh5LTEscZB/HdihuNm7fznB2QNTP5Mwhy672Jv+OcezaNjIMBEvdzZlsijT4twjWv/gzCu2mwSfwKYbXMwHaPteFGZIwd78C25ehJa0EmDB1HzpBDpOw0DWe3oQgMNiwwpyLaduI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LflDPC5E; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-32e801552ccso8913a91.0
        for <linux-pci@vger.kernel.org>; Sun, 14 Sep 2025 23:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757917722; x=1758522522; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vmqCBgglSH1XFTVmKbDycfFQaWCzr9UXmOQ9aT0xQLg=;
        b=LflDPC5ElrIkFtQIpKiy+aQibJzVNLC+DgkpBILfdx5zRORuFyGIV9g9Jt3NpRyoRv
         K/PAw8B/1A0N6tAjIORmDo7WbbmidEN8L26lBPTRCgo/BEFu+m4zOptkCybotDP7dm3M
         TGsFzfRCILs0Oo/CaF24kGAcMwH63G2aa6fhYRHki/O9pMvYTQtrnZsOOcw+6Ek2nOJZ
         BVbm/TjpmmR/7y6c+jHRVI9j11P5ixvuy8BA+9ZN+VftUb9TNI8RlJFR9AMmMb0T5h6j
         PsSDw7C9f3rSQwlOPPuzjMeUjeoDv0B9LScjfnkj8skAUWGSAP2pOy6kmPBm/em3CIrD
         dqqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757917722; x=1758522522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vmqCBgglSH1XFTVmKbDycfFQaWCzr9UXmOQ9aT0xQLg=;
        b=pDzcoSPE72orlST94HF6orLoj1ChvdckcvwpLACmgSB6tpVqeCPvspwYLyf9myYIcw
         5oRuPOX6WUNBOh+o/OZ+om6YCV3kL2ZHvG/Uj2Xh2b4hX9T6Ol54FCGgwsAEyAMOGwAL
         WKNBbQTtTj60QNpq6/8mvg2prbRmA9kuqwkOjlv9qfZEgl+uTcOB3VtR0c3EaeD5JKi1
         D7ipyCoIqfntvIglBz4e5SVImrzU7bMb4aEG96BXMUGdfXLZN3KyfHoHfed+eyiXcDIi
         PvUj26kq8qAcXR/FyEnuWnmffZpsRXOoXPp0AXjDsdz9pPJt4DkxH9lQz8vP8fiN3Vcb
         BJxg==
X-Forwarded-Encrypted: i=1; AJvYcCVNrLwWA/SeLCuRtyaYQo/lQHVSCVzqvPhighPQpzsAGSrnq2J7Kgs9Ms5jnyhytL/EjuoKLARoH/I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxga9zbAML53Z6BuamhRq0JJkcKPU6ajh4FVB4PQP8r6TI/Q2uN
	eoCU7SXBIRpZ7JhYrZXdxfzC8KOvUKjK/ihI63YupmkHZ2m/inoQbY4jswjIo1iPrpQUz6vp/2e
	MGjWfRNE04nRHwhb8/nA53m2+T2quvig=
X-Gm-Gg: ASbGnctiX0tAiWSuZPPF4rm1NPzgDb6DtFQ75q0keouN55295XMknLYyukWh6Ad24Af
	4zdjdabN66R413f2ctMRqfpOOKy0uaIqlCwUs9hM1hTgJ2NH3eJAkeXUxmlNEsyJyzD5gwp6d/G
	f+XIOVFA1smBSrmT067v1WSjUnCXr7/2kM0DhoORID50jIsg4NvoX3eVzG0EoHarwm7Na+rR8Ic
	ssxfkkxyB2Pq6GFaozPbv7IGgFXdvSEo6buZGpPGBUk2So/aDImOcEFg9ls80MmXyzcyuinPzlY
	PvKzb3lsLczvVdbl2gj/0NmcJKmQngPB/u6w
X-Google-Smtp-Source: AGHT+IEchiEsGjMEl1Hm6ui7MHlyoHtVT9JbiNr8xFHt1Dh/GCG2aVZ9Mc9Wk0rDlBUnhgEKt0EkP1bILsFTHX+KRrs=
X-Received: by 2002:a17:90b:3804:b0:32d:e980:7a70 with SMTP id
 98e67ed59e1d1-32de9807ddfmr6262491a91.0.1757917722224; Sun, 14 Sep 2025
 23:28:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250913172557.19074-1-sergeantsagara@protonmail.com>
 <CANiq72msM5PT2mYKrX_RPXYtA4vapMRO=iSex1gQZqiXdpvvDA@mail.gmail.com> <26oqasrlptl5v4ymfkrlznltbwqx5rfi4dworhri3msme4wlmm@cclnphvwur6r>
In-Reply-To: <26oqasrlptl5v4ymfkrlznltbwqx5rfi4dworhri3msme4wlmm@cclnphvwur6r>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 15 Sep 2025 08:28:30 +0200
X-Gm-Features: AS18NWCkmdX2sBHMEVZOaZAumYceYyW3PCH1MqnX3I-KTdnLVgDBS3-v3ItVfN8
Message-ID: <CANiq72mpQO0v-acGOWUcYaBmETSTAjkJUDN4MT498imVGboYQQ@mail.gmail.com>
Subject: Re: [PATCH] rust: pci: fix incorrect platform references in doc comments
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Rahul Rameshbabu <sergeantsagara@protonmail.com>, rust-for-linux@vger.kernel.org, 
	linux-pci@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 7:29=E2=80=AFAM Manivannan Sadhasivam <mani@kernel.=
org> wrote:
>
> Why should a spelling fix be backported to stable? The stable kernel rule=
s
> explicitly states that these kind of fixes should *not* be backported:
>
>   - No "trivial" fixes without benefit for users (spelling changes, white=
space
>     cleanups, etc).

I am aware, but the stable team has autoselected a similar fix in the
past (and I asked them about it, precisely because of the rules
above).

For typos outside doc comments, I wouldn't tag it (but they may still
autoselect it).

For typos in rendered docs like this one, especially one that is not
just a spelling one (like this one), I think it is OK either way, and
a bit more worth it since these are meant to be rendered unlike
implementation comments.

Thus, since this one was in the fuzzy line, I suggested it so that the
contributor avoided Greg's bot when detecting the missing tag.

As for noautosel, I wouldn't do that -- they want them sometimes,
after all. Instead, I would reserve it for things that really
shouldn't be picked for a given reason.

I hope that clarifies a bit.

Cheers,
Miguel

