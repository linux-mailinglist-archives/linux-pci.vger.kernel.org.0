Return-Path: <linux-pci+bounces-29435-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7539DAD556A
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 14:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C76F188AAD6
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 12:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB59027EC74;
	Wed, 11 Jun 2025 12:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bDhvnbrL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCD727C173
	for <linux-pci@vger.kernel.org>; Wed, 11 Jun 2025 12:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749644687; cv=none; b=pluL+mc/0FaaVg5bqUBZYJj4iahB4NNUchWXjgdrtlsqGTkw6pf0NS4+yMjEVRhvEi5I6iTGlAJTKdqeZPROM/2XkENC8qV0q4xzm+tlWDfEuuQBZYIXoP5cwUOPEPgB8PUFsm+LkP1Rt99ylIc2XQQKMK4ai3XxpNDjzyz0KN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749644687; c=relaxed/simple;
	bh=R81Vn86n50s95m24RM0OKR5tanCo8I3XjpHOkclODVs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J6991K3p1WscZ/LRx8kj1JxSCQP3FIC2m3Jkiir5yPw22402TRBb3AMHi3Ltvjycynbs1bpQqSSaImOHbT2d3z4sY2p2x5uR4hQnf7uP3hhXgdm9RI4tpxPRbUgP095Uac18S4HuArxlDKJt98HTNfcQV/Swf5qWzd8kqz3hHOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bDhvnbrL; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a4f78ebec8so3993136f8f.0
        for <linux-pci@vger.kernel.org>; Wed, 11 Jun 2025 05:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749644684; x=1750249484; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pntxaWNnDpEM2Le+70ckmhHLBJI/hmInZvYIpD60p58=;
        b=bDhvnbrLizjuLIidAszNSvq6JXlta9/PC3M9ppkmwLwDOtyv7tOyj+3wTguQeCUtdz
         uNukMWzx1xh/G3BMxbIZgI5gAFzSzgfhGgrQ9wz0bVEu09OHr8v89G9tyPSf5M24k0d6
         yoYx37uXK+Bb6nYaaIfPNR7W1cYhcAQRfVWJiTZr0ZCmj9NEocIs5MvXmkPZuqEAJ+tl
         SEH2rKrhhDrnEl8atA/5zczVSCNLjuJHfUiCr3b/aO7563yCLD81OWDyuuzYvOTnvAyQ
         pRsSI6QZu5PhzkBGl6sEXYeJQt6+WcBAbgxsNkSnp1RDF8VEeP1MQbD+hCLJ1jzxT3b+
         F2Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749644684; x=1750249484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pntxaWNnDpEM2Le+70ckmhHLBJI/hmInZvYIpD60p58=;
        b=vVZU4OvD9ozSQ6E8jBEbCFDoKX5/0Yh6ydamr+5IZCFBoTJxi29mtD/GVeraqzKSOY
         HLIzvc+sqbvYge8oexeLUE5GIqkL8rw2+82zUfh0y+6JgCoPtR8cvJeohV/U2m4MkBCp
         GP8xlwEsQ+LD8zDSTA9WOp+DUiXp5XAn5fF/PiioalEE4pWUJcD793jD0DIs3Jn/WfB2
         cpUkVc+LpJiBMiVVzGFPiHG5bsNuhv08vK4Fq7hQ86pRvUMfgftpXVdWss26TNZs0fuC
         E/Z7D5H3OrnerAd+S+cLINjj/6HZtbYGjxN7/T41hgKydyG68l79ycAUcUrDoqvxT3vX
         6bxA==
X-Forwarded-Encrypted: i=1; AJvYcCUocHCUofOls+MR0/rCE0R9UjaWsoaxNjrN43hEWTOtUXiLie4fTBML/2qf1EUWJWAeAW6jQl/p8NA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj+gsvPRFZZfJ6wT4Ii320t2arWVpTkC4IW/N/Pg636u5r+57J
	1P4TabckLFke40g4gjNUgTWmIh9zbPUIH90kDLuzFLxM3bTsleCQ+uZPwuPO+vQtVy7bco0FF2w
	tkw6S6CSR0P3Ws+5XE/dM4UzYOap037rEN/MZY03t
X-Gm-Gg: ASbGncs58RvDYvsN2SMjySSUGfWGo755zNhwvZ6VZooD1oQ2gL0SE68GcLxwD/9xhnX
	GQ4JoP+jY30lnLJE/YuL6leSN/bcwkCNLrVnxAkCEXclp6KME7SnoBOf/keGAXrAfkIdfM2QFMm
	k1ntDAuuOdArfk1GxD9I7XwCmNMfbHl8wNdSOcUYOK7+SxacOAgmcvsW7QBPmh1vIBKokhQPsUG
	g==
X-Google-Smtp-Source: AGHT+IHqqDzqPqrx+jJdaiStqcmQC5PY9s0h0hv9Nc7By7zX4EjpLulqZbtZUXuN16xlgP3QnLCnsqEL3ZVHwdnGryk=
X-Received: by 2002:a05:6000:40ce:b0:3a4:f52d:8b05 with SMTP id
 ffacd0b85a97d-3a558af421bmr2451602f8f.35.1749644684234; Wed, 11 Jun 2025
 05:24:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250610-pointed-to-v2-1-fad8f92cf1e5@kernel.org>
 <HCd56HpzAlpsTZWbmM8R3IN8MCXWW-kpIjIt_K1D8ZFN6DLqIGmpNRJdle94PGpHYS86rmmhCPci9TajHZCCrw==@protonmail.internalid>
 <DAIV6MJAJ5R0.3TZ4IC2KO9MOL@kernel.org> <87v7p3znz6.fsf@kernel.org>
 <CAH5fLgi3B_Wyz2OzBLhHHgWrg7hboyFUcQe-+GUrrvXiX9di=w@mail.gmail.com>
 <GHUD6hpYDty0s_oTLGC6owDPKqrNepeGOL9F-XlvY6G50K8Zptjp4f8kVVnyoTjf-E_0QVeHfmUUvcN-p1i24Q==@protonmail.internalid>
 <DAJHVMM9DND0.2FM0FJYN0XEFV@kernel.org> <87jz5izhg3.fsf@kernel.org>
 <WXoNAlTJvpteJEAZ3TkYKk2QWHBC0oID8Dy3AHGxLEwiZwBPdSLZB4MpdbObLtFvqiN9re3q6OQpiua2uiv1Hw==@protonmail.internalid>
 <DAJOKFHW96XZ.2ANYSSFQO03ZL@kernel.org> <878qlyzd9a.fsf@kernel.org>
In-Reply-To: <878qlyzd9a.fsf@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 11 Jun 2025 14:24:31 +0200
X-Gm-Features: AX0GCFsGrjiahNqXYN_wK3WpFvBjlZuqs41dAS1mQAczR2z1DIFyvKRDh3iJ50o
Message-ID: <CAH5fLgiNikpTfm6nvyEJaEspPkMNRQSX2XmBXvXktpXQLutDPg@mail.gmail.com>
Subject: Re: [PATCH v2] rust: types: add FOREIGN_ALIGN to ForeignOwnable
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Benno Lossin <lossin@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Trevor Gross <tmgross@umich.edu>, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Tamir Duberstein <tamird@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 2:14=E2=80=AFPM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
> "Benno Lossin" <lossin@kernel.org> writes:
>
> > On Wed Jun 11, 2025 at 12:43 PM CEST, Andreas Hindborg wrote:
> >> "Benno Lossin" <lossin@kernel.org> writes:
> >>
> >>> On Tue Jun 10, 2025 at 4:15 PM CEST, Alice Ryhl wrote:
> >>>> On Tue, Jun 10, 2025 at 4:10=E2=80=AFPM Andreas Hindborg <a.hindborg=
@kernel.org> wrote:
> >>>>>
> >>>>> "Benno Lossin" <lossin@kernel.org> writes:
> >>>>>
> >>>>> > On Tue Jun 10, 2025 at 1:30 PM CEST, Andreas Hindborg wrote:
> >>>>> >> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> >>>>> >> index 22985b6f6982..0ccef6b5a20a 100644
> >>>>> >> --- a/rust/kernel/types.rs
> >>>>> >> +++ b/rust/kernel/types.rs
> >>>>> >> @@ -21,15 +21,11 @@
> >>>>> >>  ///
> >>>>> >>  /// # Safety
> >>>>> >>  ///
> >>>>> >> -/// Implementers must ensure that [`into_foreign`] returns a po=
inter which meets the alignment
> >>>>> >> -/// requirements of [`PointedTo`].
> >>>>> >> -///
> >>>>> >> -/// [`into_foreign`]: Self::into_foreign
> >>>>> >> -/// [`PointedTo`]: Self::PointedTo
> >>>>> >> +/// Implementers must ensure that [`Self::into_foreign`] return=
s pointers aligned to
> >>>>> >> +/// [`Self::FOREIGN_ALIGN`].
> >>>>> >>  pub unsafe trait ForeignOwnable: Sized {
> >>>>> >> -    /// Type used when the value is foreign-owned. In practical=
 terms only defines the alignment of
> >>>>> >> -    /// the pointer.
> >>>>> >> -    type PointedTo;
> >>>>> >> +    /// The alignment of pointers returned by `into_foreign`.
> >>>>> >> +    const FOREIGN_ALIGN: usize;
> >>>>> >>
> >>>>> >>      /// Type used to immutably borrow a value that is currently=
 foreign-owned.
> >>>>> >>      type Borrowed<'a>;
> >>>>> >> @@ -39,18 +35,20 @@ pub unsafe trait ForeignOwnable: Sized {
> >>>>> >>
> >>>>> >>      /// Converts a Rust-owned object to a foreign-owned one.
> >>>>> >>      ///
> >>>>> >> +    /// The foreign representation is a pointer to void. Aside =
from the guarantees listed below,
> >>>>> >
> >>>>> > I feel like this reads better:
> >>>>> >
> >>>>> > s/guarantees/ones/
> >>>>> >
> >>>>> >> +    /// there are no other guarantees for this pointer. For exa=
mple, it might be invalid, dangling
> >>>>> >
> >>>>> > We should also mention that it could be null. (or is that assumpt=
ion
> >>>>> > wrong?)
> >>>>>
> >>>>> It is probably not going to be null, but it is allowed to. I can ad=
d it.
> >>>>>
> >>>>> The list does not claim to be exhaustive, and a null pointer is jus=
t a
> >>>>> special case of an invalid pointer.
> >>>>
> >>>> We probably should not allow null pointers. If we do, then
> >>>> try_from_foreign does not make sense.
> >>>
> >>> That's a good point. Then let's add that as a safety requirement for =
the
> >>> trait.
> >>
> >> I disagree. It does not matter for the safety of the trait.
> >>
> >> From the point of the user, the pointer is opaque and can be any value=
.
> >> In fact, one could do a safe implementation where the returned value i=
s
> >> a key into some mapping structure. Probably not super fast, but the us=
er
> >> should not care.
> >
> > Then we'll have to remove `try_from_foreign`.
>
> Oh, I see. OK, it is a safety requirement. Should I just add it to this p=
atch?

Sure, this patch is fine.

