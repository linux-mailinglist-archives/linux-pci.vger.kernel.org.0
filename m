Return-Path: <linux-pci+bounces-31954-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A209B025A7
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jul 2025 22:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2494A3BE81D
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jul 2025 20:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62FE61E04BD;
	Fri, 11 Jul 2025 20:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NpoX97CS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B41537F8;
	Fri, 11 Jul 2025 20:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752264882; cv=none; b=ODyi2kjckMpQq4eRTt7Uv1v0/ulXfIh6rE0SVhyW8LiHj6yMuP6a4/UuJ1mMSbPQ3ejEDmR0xHJ0xshg54QR+DOVcsfgQ8XvU7szzHLyOAorfNO0UGtkXa+COqtDjQFO33LLubCSsjU2lkfgTCV2mF0L4ikMVX3sDQf2zJpj8I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752264882; c=relaxed/simple;
	bh=zM57vPoVzM4+A+f+p6wb1uBlHq4cqIDD1g7suopm60g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ivPzodMG8blpunZIBLqzx5a4xx80em4n+9vdljZfXAgkpEkbX1fLCgisA9ytpPsOO41pmxxGi0NEcsit8CoEXbP9lU1O8IvpjIWRiFKqcvbjXyNV+mXSDkCLZwFddbo6Z3hiQDi9sEIAwPbYOh4zsDg0jYE+AsIC5lwYpyvTeG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NpoX97CS; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b31c9132688so214745a12.1;
        Fri, 11 Jul 2025 13:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752264880; x=1752869680; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4PXyZp1MAP49YjBjZ2JLADkSKrbdvIduOuykBH76TeU=;
        b=NpoX97CSrOf2+ouIM1i+eAJ3SM4naG9rQQcMpEROT+cGU7uJOcBFImzj+OwtBhT+s2
         1FWhgIIWm8l7AGXfgK0lcb8rTanUwYrtQkbl8dV2rdMMOytVJ9Tyb+mipP92beUGXZdj
         kXJLDr7pItDo91iKij3Tro9pQy2GJWY5a1q5vtncNW4zIE5uZz43Bs43yJE+WQ2ZKLGk
         pM5yJb2jKg5zbvIFffwOBajKLowpqLoeIMV3slyAPj2CS8cRcv5AIxBRZGzlOIkyfftP
         PQPne9wdmF8vJCZYElSBeJG9M/JTntWM9SdsV/bOK1BsKeqPVQatoO5DL4hmBkKSgkna
         AZgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752264880; x=1752869680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4PXyZp1MAP49YjBjZ2JLADkSKrbdvIduOuykBH76TeU=;
        b=gJsZ9c73hYazoDgvDtEEa/J/HDRXbG2Ex2AnQzXu/J+kuuz3kgL3j05IPXyMObHrWC
         3lk1mnfq2BUKHP3Z3I1p/q0F2gEnqojUKB9fqps3R8QGO1MtbQ0jpCF379oEt1ugtDc0
         KX6Wd+87kfjVhQN4N3JzZjZEti9F7BBRc8Gh71oOC/hn6yS60aRvNb8IeKchm8zizlGZ
         5APCemwfh0u8TfBtqj28/eQCwUje/RVNmS8O9u8bK6EqT1zJUEaDl+AnQuzNlgk0aMzW
         wOPzXUGWZ9j1+Q6V5CPnFFUZxPoL7SA6GUjqFNC72TNGMkj5F2Dh3taz07GiLO+L3M4+
         +5eQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdNsu9nERPLAfQsfT2bQIsY56XA2PRgEHEY1t+pHtiS6VLzVxCn/vHOHaXI8U3HfVUe8MzP0cXPYPj4mmU6FA=@vger.kernel.org, AJvYcCVJvtZNcmqavqoHN/frTI7LEDcW20AE9AvA5rSrVuciweOkrdR6QEgwd/lvkqwbMX2Kikv0lIkrgK9YboQ=@vger.kernel.org, AJvYcCX2w55lNrhh7jIDarRrYDvI/WWPdmgiKQHzMBBCnOlp5aiKBeRec016bVkVT+02riBqTZ/kWRRcP3hH@vger.kernel.org
X-Gm-Message-State: AOJu0YyLfKRcIzDb5MYu4Qaum4bIehs3w+IkJSivhuX1l4FP32dvTI6i
	a/+tToH56L+7EqZg4WRCL4OdfvAIVamnG5UrDsyNl2DN2LuNHgCg6NflSj7IFpp/MJR8ZwleR14
	m3hJ7a5BFGlKACilKM8NgfnitqkJ7Ds3Cd6IDrx8=
X-Gm-Gg: ASbGncuekres6t5nxXd5I95JXLPokcsXRlLCJf4OjqmBis6DUJEWZRR4Iz9NEPoNIGF
	2E5DGxOeMnX7jADV9aZyYqQatTJjHkF1ZgNHpaZZhnIecmTpI67r+680w0prb3XxJ90E+7LuW6Z
	tRIwKLNYYmhUk0S6ENBw2omJnx0e4CazbziqLX+m6WNfjUWYffOMxV3SeksO0EpI7m+no7K5PJK
	1Pm/jO6
X-Google-Smtp-Source: AGHT+IEOtV7sTkKshvEYalxKoehHefKpc2yD0RDp7HyS09wKa5qilnbeuIvoq1D5YrTRe/9DzKFHvMKR2iBlMz70CjQ=
X-Received: by 2002:a17:90b:554f:b0:31c:3871:27ad with SMTP id
 98e67ed59e1d1-31c4f34f822mr2070943a91.0.1752264866538; Fri, 11 Jul 2025
 13:14:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710194556.62605-1-dakr@kernel.org> <20250710194556.62605-3-dakr@kernel.org>
 <20250711193537.GA935333@joelbox2>
In-Reply-To: <20250711193537.GA935333@joelbox2>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 11 Jul 2025 22:14:13 +0200
X-Gm-Features: Ac12FXy9GgEAIqTexqEeXDkbBUHbxnBiZuprJ4dCeAHhrW0NKtZ3h-Gr1tKlFds
Message-ID: <CANiq72nP=u49vhj7+Z_digM+gKk0_=oAWUofbmyntyPsKy=+ew@mail.gmail.com>
Subject: Re: [PATCH 2/5] rust: dma: add DMA addressing capabilities
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Danilo Krummrich <dakr@kernel.org>, abdiel.janulgue@gmail.com, 
	daniel.almeida@collabora.com, robin.murphy@arm.com, a.hindborg@kernel.org, 
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org, 
	aliceryhl@google.com, tmgross@umich.edu, bhelgaas@google.com, 
	kwilczynski@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org, 
	rust-for-linux@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 9:35=E2=80=AFPM Joel Fernandes <joelagnelf@nvidia.c=
om> wrote:
>
> 2. Since the Rust code is wrapping around the C code, the data race is
> happening entirely on the C side right? So can we just rely on KCSAN to c=
atch
> concurrency issues instead of marking the callers as unsafe? I feel the
> unsafe { } really might make the driver code ugly.
>
> 3. Maybe we could document this issue than enforce it via unsafe? My conc=
ern
> is wrapping unsafe { } makes the calling code ugly.

Yeah, this sort of dilemma comes up from time to time, yeah, e.g. see:

    https://lore.kernel.org/rust-for-linux/CANiq72k_NNFsQ=3DGGCsur34CTYhSFC=
0m=3DmHS83mTB8HQCDBcW=3Dw@mail.gmail.com/
    https://lore.kernel.org/rust-for-linux/CANiq72m3WFj9Eb2iRUM3mLFibWW+cup=
AoNQt+cqtNa4O9=3Djq7Q@mail.gmail.com/

In short: that is the job of `unsafe {}` -- if we start to avoid it
just to make code prettier, then it loses its power.

There are few alternatives/notes, though:

  - If there is a way to somehow guarantee or check that something is
safe, perhaps with a tool like Klint, then that could allow us to
avoid `unsafe`.

  - If the blocks are very repetitive in a single user and don't add
any value, then one could consider having users write a single `unsafe
{}` where they promise to uphold X instead of requiring it in further
calls.

  - Worst case, we can promote something to the potential ASH list
idea ("Acknowledged Soundness Holes"): a list where we document things
that do not require `unsafe {}` that should require it but don't for
strong practical reasons.

> 5. In theory, all rust bindings wrappers are unsafe and we do mark it aro=
und
> the bindings call, right? But in this case, we're also making the calling
> code of the unsafe caller as unsafe. C code is 'unsafe' obviously from Ru=
st
> PoV but I am not sure we worry about the internal implementation-unsafety=
 of
> the C code because then maybe most bindings wrappers would need to be uns=
afe,
> not only these DMA ones.

It is orthogonal -- you may have a safe function that uses `unsafe {}`
inside (e.g. to call a C function), but also you will see unsafe
functions with just safe code inside. And, of course, safe functions
with only safe code inside and unsafe functions with `unsafe {}`
blocks inside.

In other words, a safe function does not mean unsafe code is used or
not inside. Similarly, an unsafe function does not mean unsafe code is
used (or not) inside either.

This is the usual "two meaning of `unsafe`" -- that of e.g. functions
(where it means there are safety preconditions for calling a function)
and that of e.g. `unsafe {}` blocks (where it means the caller must
play by the rules, e.g. satisfy the safety preconditions to call an
unsafe function).

So a Rust function that calls C functions (and thus uses `unsafe {}`)
may or may not need to be unsafe -- it all depends on the case. That
is, it depends on whether callers can cause UB or not. And similarly,
a Rust function that does not use unsafe (including not calling C
functions) can still be very much unsafe, because other code may rely
on that code for soundness (e.g. an unsafe method that assigns to an
internal pointer which then other safe methods rely on).

Cheers,
Miguel

