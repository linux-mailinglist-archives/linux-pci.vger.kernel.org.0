Return-Path: <linux-pci+bounces-33693-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE2EB1FFAC
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 08:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FABE189C28D
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 06:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC2E2D8DC2;
	Mon, 11 Aug 2025 06:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i5/clQyt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9D42D8793
	for <linux-pci@vger.kernel.org>; Mon, 11 Aug 2025 06:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754895259; cv=none; b=SSoSbsiAscRhhU+fUJeDqbw8BTdIlfKq6jSxeV7gJKJ39lAQQg8l5I5c3n2ekbRiwp9XAX54S53QG83Cjr/RPMBj0xMe5hoG6oz8NQ4sRnZDK7QzvdPy/Crk1RZJOstLFxPeJPAFTW9hp3idKU99BfImmRoFVMXsUlP6OcLRRhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754895259; c=relaxed/simple;
	bh=IMF7oxhWWht5Rfg97jPniIkxBcIiuZXkIEqgJK9FhhA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UqiD6YA59QL0/pl/o3nYjIVbhnDpEsK9wxF3HKoGkfGUjjasbqqvhe3ZoXCxk2UAQ9rsG2VG38a1etArg82u4KpZfep/r9fuUMoqzMwh9XTmAguCN4BIqSs3aAmiyVLcndyukoWgvT8vDqQzcAb0dXcHSctAMvqQyammcxIGe6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i5/clQyt; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3b7961cf660so3277367f8f.1
        for <linux-pci@vger.kernel.org>; Sun, 10 Aug 2025 23:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754895255; x=1755500055; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IMF7oxhWWht5Rfg97jPniIkxBcIiuZXkIEqgJK9FhhA=;
        b=i5/clQytAI6aNJ5lAru6FytsDdA1kj8Wj70cqEiMNDyFMW/BSxl2PwfEVO5I93EPeN
         vicnNtheqhW/40qANqgrfzgf0pt6b5uyYYagDM1VuKpnPjJ39GyS8MvwCbpG0fd/IS/6
         TUXCT+N5alEKrgzrHsQs+tW8ANbicIO/BUWXB9kLxhRT74ijwOmIM8HO5cNWpeITV2Gh
         lnL/2h2kqbEIagf9qs9S4ysnD9G5vPfJRfeWGt+bWs0bv0yaWEK1torbz2ihz61Cj1KX
         SzuG95k+vo+ZyCtyUWPk4SAhQJ+IEZijGY8xG5bWb4aOOwVhlmYskSb3gm1XmFPY1qJq
         z2ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754895255; x=1755500055;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IMF7oxhWWht5Rfg97jPniIkxBcIiuZXkIEqgJK9FhhA=;
        b=N0DtNdB3/3O6Fx+yEDfC45EL5GIFBgqftNQzLI7hSt/SNV6fNomq4GOUKJpIWjq6dz
         GUtSvPU2gD5BJLyFahIeW9fb+MQnp+UJObfON/J67MEQY3qpUjbPbtqszzDHMyqaZR2d
         zcJTPa7jQNIXtiXgQCyiL9Cmg1VBL72qwAEs1v6rKaVAkBiCeuBMDrmffMNcrq1kWDP9
         lFAeelbn+5UaQ85hRY3A2DW2wHG//DjIHGBUAp2gYFY/TkGzABmpp84qzJgCvrcAd7bi
         Kn+hML9Phz00SK7EltKwiC155kWx1IBcpld/2bFeEx2n8XaOugl2jIbQX0G642/ua+oa
         2/+g==
X-Forwarded-Encrypted: i=1; AJvYcCXrddlp8WqXiZ8enlnGqLmMMnv6TKHJaj3C3wT4mxERtVv7xG0lgs1dsoE7KH8hWCHpSmu8LeFmHck=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHAS7HCqOlbmDkxLDHmWkRJvPJJnvKeBHjLcV7DWOrY90V2dFT
	J+XxLYx7bbdZMYkKkGsbhGwn7T9GNumP5nK53B642tMyebzMK7kAtWqvHcjCwoL0RbOnHGuqxob
	He770pqh3oO8015Th4uaoEFUsYxDH8eWZGLSDaMsl
X-Gm-Gg: ASbGncuk+3ZlqgxV/Jh9Lgq1E7YN9++ZuhlnE4CwXiyejdJv5vrTtCx4ChxwhsIS1ii
	fHTH1CBuJtPcGCB/Pv+5C95X22u6T/ZblDa8FZYmzGQvwOyDElZeQwd2ci3RrEkDS77Ad0hIFpv
	+2+f4Mw2FS+Wo9m52Wkdr9zhbHE/2eFN9UqCZvnH+zMUGyhRkfkNjEBFdI125pIjUgRnF22nFPp
	3tPfnokP7CZrGd5zk0=
X-Google-Smtp-Source: AGHT+IE/b40zkpS05GhNxK8XjZNGAut87hJOzbsMuY++YS8Jo6CClprJ6Pmx87Y6WX+z9WagLq8WqZGJ4Jcedzh3yJU=
X-Received: by 2002:a05:6000:1ac5:b0:3b7:9715:75f1 with SMTP id
 ffacd0b85a97d-3b900b735c9mr8726917f8f.36.1754895254840; Sun, 10 Aug 2025
 23:54:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721-irq-bound-device-v1-1-4fb2af418a63@google.com>
 <DCBBFAC5-A4B4-41BA-8732-32FA96EDE28E@collabora.com> <CAH5fLghRi-QAqGdxOhPPdp6bMyGSuDifnxMFBn3a3NWzN4G4vQ@mail.gmail.com>
 <0303C763-76CC-456D-AB76-215DF253560C@collabora.com>
In-Reply-To: <0303C763-76CC-456D-AB76-215DF253560C@collabora.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 11 Aug 2025 08:54:02 +0200
X-Gm-Features: Ac12FXzMwuxocaFnrrcDOWSm5kfQ5RQ2kLadCTdi78EU3qPMWKi0IrhJ_Ix6Rug
Message-ID: <CAH5fLghPz3UF-yKVt5x3JrMZ8f-mgT2gysRhJG8TK2kmF1ejGw@mail.gmail.com>
Subject: Re: [PATCH] rust: irq: add &Device<Bound> argument to irq callbacks
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Benno Lossin <lossin@kernel.org>, Dirk Behme <dirk.behme@gmail.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 2:49=E2=80=AFAM Daniel Almeida
<daniel.almeida@collabora.com> wrote:
>
>
>
> > On 21 Jul 2025, at 16:33, Alice Ryhl <aliceryhl@google.com> wrote:
> >
> > On Mon, Jul 21, 2025 at 9:14=E2=80=AFPM Daniel Almeida
> > <daniel.almeida@collabora.com> wrote:
> >>
> >> Alice,
> >>
> >>> On 21 Jul 2025, at 11:38, Alice Ryhl <aliceryhl@google.com> wrote:
> >>>
> >>> When working with a bus device, many operations are only possible whi=
le
> >>> the device is still bound. The &Device<Bound> type represents a proof=
 in
> >>> the type system that you are in a scope where the device is guarantee=
d
> >>> to still be bound. Since we deregister irq callbacks when unbinding a
> >>> device, if an irq callback is running, that implies that the device h=
as
> >>> not yet been unbound.
> >>>
> >>> To allow drivers to take advantage of that, add an additional argumen=
t
> >>> to irq callbacks.
> >>>
> >>> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> >>> ---
> >>> This patch is a follow-up to Daniel's irq series [1] that adds a
> >>> &Device<Bound> argument to all irq callbacks. This allows you to use
> >>> operations that are only safe on a bound device inside an irq callbac=
k.
> >>>
> >>> The patch is otherwise based on top of driver-core-next.
> >>>
> >>> [1]: https://lore.kernel.org/r/20250715-topics-tyr-request_irq2-v7-0-=
d469c0f37c07@collabora.com
> >>
> >> I am having a hard time applying this locally.
> >
> > Your irq series currently doesn't apply cleanly on top of
> > driver-core-next and requires resolving a minor conflict. You can find
> > the commits here:
> > https://github.com/Darksonn/linux/commits/sent/20250721-irq-bound-devic=
e-c9fdbfdd8cd9-v1/
>
> Ah, we=E2=80=99ve already discussed this, it seems.

My suggestion is that you pull the tag I shared and cherry-pick it from the=
re.

Alice

