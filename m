Return-Path: <linux-pci+bounces-29331-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C758CAD3AEA
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 16:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CFB93A3318
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 14:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F67299AB1;
	Tue, 10 Jun 2025 14:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4ST3VQig"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EF728D8FE
	for <linux-pci@vger.kernel.org>; Tue, 10 Jun 2025 14:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749564933; cv=none; b=L35xKtQAeVwphm7h3GIZWEM5TXqbMN7qhinbWp6mjyCIJW46jTOwY7aY3vSbXY0GzqVrJ/MEyylyTEds9g3Uu2GFXo3Kdv4CV/3Y3fFgCP7VHSECHYPjAY5GPh740m6F7y5e8Pv+eH7MwTfK6kAwlMolYgwbLVfjOfhGJ+96SqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749564933; c=relaxed/simple;
	bh=ge3yCP/EpuKpuiy4jzTLuqiWaqL/+und+D884iis2JA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T+34Y7AMkCh/i6HqaoPuQr8c7OPG1YdaxbVxUv2O6Kq3iu9qakYd7F9YvVxSFXWqvZYSMd562CkLIOfnlXwAasI4kr8EXdycJgN32ZHE4SSBkOzsfLWPCmv7P84AMyJKU64HC1lToTwBfPrPcagZazaObVvdgeDaayOHf30soVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4ST3VQig; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-442f4a3a4d6so29858645e9.0
        for <linux-pci@vger.kernel.org>; Tue, 10 Jun 2025 07:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749564929; x=1750169729; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ywuko/Vi2Gb4rS+WbwhLfqtlhHLHm9Z1txYypp0EudE=;
        b=4ST3VQigNEJANw8ZH3fjbHaSjqYWRpIdbmVPFIyAnsh12X9vop6tee19tz2fKiZudw
         4WFLvDac/UnuX/2zOnchPHU/dJfDJ9Tq4Xt7szeNENa+vZeupD38VYkPC69vPMRQtUBP
         U8hwMqsdj3i9IsNu6szpl3rlzsK76oYDuijxvl2NrkkmAoyQYfOc8gKtwHirN9MGoP6Y
         wwvy76nNnM5mO/0sqHixK8XtaU8Tj/yMeRNDVOkt/sncYatQM7tXbsRUmjZi2A3qRnPw
         QdFkGeNtioFEpU5z3ISvTJ5ayDfglyysuHXhjAaSUpBoQFU6ugOt6iIhhrruJgG1g9et
         2Hnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749564929; x=1750169729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ywuko/Vi2Gb4rS+WbwhLfqtlhHLHm9Z1txYypp0EudE=;
        b=wfymEb7N7wI8L78FfZpXBaI2yBgiZNJbuW8lOtyyHM6uE/laLYPYA7wTZ6/N73C9h7
         33vkwSFVz2Ep2/GS08/m9fJ2v4Owb8PyNHhUDehUmI9h2QvddZF96PEKCCUbF6BxtcPU
         ufmSlM3q5QhveI8Kuc9n25xXR0aCAnWhdJpqgiiPfNCGpf5pFGm3JAB77jOJHcK/d08J
         +fHJ4ytTc1nSY3F+Z00AQqZ3qiaZbSkZCYKhIvjHOkf+rvER+cRAnOloFmdPmY6VuHOu
         T6MmE4UO6b9+AAobSUsEFduJtcDqJhFU10JAGBu8JhUiaNjB3mCFRwZSLZaxWBZ4hYm5
         5Q8g==
X-Forwarded-Encrypted: i=1; AJvYcCVAe3sR3IZEzya/2FNw2tLRI7CBEjeW59ZGw1GMWYjdWaoqdyeBGxV8/H+ITdWjqY3xbabaIHASUr0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTJ1VMFrACyjFzX8VHWGMspe0REZxXMkM8qGedWzb8dfNpwe8g
	ECt9Fqzz37BXQJPG3/d5A4DfNz6lpGtHguYLxLZ/xGp7FOlEXOzPgvrxeBL6vYdCDNiGfenTCUm
	2ecC8t87Ozg7+Rof09yGN/Cl6PotWrQvBSNf8L7IH
X-Gm-Gg: ASbGnctslM3rzxnua1jHezC0cUo2Vs2zV5mE+Qh6ovfCQXOwRZ4ObGGsfZO8C/IK8td
	dDr3k/rVvkWQSe7TTX56Or1n6B+ceXyhIgTqANVI4Jyx3VOErMSSd0BDakYhYr6prHRapK3UJ9F
	XC4j4rWRdXHqsovlpE4hcxeyRE3EQ/nG6wgyF4SnLowWYu
X-Google-Smtp-Source: AGHT+IHEZWxT8vLb5epoa72haZQMQGOIBDRZJX7TGh1VU1y65oHmN2JLqqZBnn/8FKnCdVfpWAZ8D/yHCKiE8e1W1SU=
X-Received: by 2002:a05:600c:c087:b0:43b:c592:7e16 with SMTP id
 5b1f17b1804b1-4531ce8c02emr28577645e9.3.1749564929419; Tue, 10 Jun 2025
 07:15:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250610-pointed-to-v2-1-fad8f92cf1e5@kernel.org>
 <HCd56HpzAlpsTZWbmM8R3IN8MCXWW-kpIjIt_K1D8ZFN6DLqIGmpNRJdle94PGpHYS86rmmhCPci9TajHZCCrw==@protonmail.internalid>
 <DAIV6MJAJ5R0.3TZ4IC2KO9MOL@kernel.org> <87v7p3znz6.fsf@kernel.org>
In-Reply-To: <87v7p3znz6.fsf@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 10 Jun 2025 16:15:17 +0200
X-Gm-Features: AX0GCFuqgtB8tzHReseQOluZ2wIpAgQISZzJ6tdMFaABhvsx6guDSPD_zbdtZu8
Message-ID: <CAH5fLgi3B_Wyz2OzBLhHHgWrg7hboyFUcQe-+GUrrvXiX9di=w@mail.gmail.com>
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

On Tue, Jun 10, 2025 at 4:10=E2=80=AFPM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
> "Benno Lossin" <lossin@kernel.org> writes:
>
> > On Tue Jun 10, 2025 at 1:30 PM CEST, Andreas Hindborg wrote:
> >> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> >> index 22985b6f6982..0ccef6b5a20a 100644
> >> --- a/rust/kernel/types.rs
> >> +++ b/rust/kernel/types.rs
> >> @@ -21,15 +21,11 @@
> >>  ///
> >>  /// # Safety
> >>  ///
> >> -/// Implementers must ensure that [`into_foreign`] returns a pointer =
which meets the alignment
> >> -/// requirements of [`PointedTo`].
> >> -///
> >> -/// [`into_foreign`]: Self::into_foreign
> >> -/// [`PointedTo`]: Self::PointedTo
> >> +/// Implementers must ensure that [`Self::into_foreign`] returns poin=
ters aligned to
> >> +/// [`Self::FOREIGN_ALIGN`].
> >>  pub unsafe trait ForeignOwnable: Sized {
> >> -    /// Type used when the value is foreign-owned. In practical terms=
 only defines the alignment of
> >> -    /// the pointer.
> >> -    type PointedTo;
> >> +    /// The alignment of pointers returned by `into_foreign`.
> >> +    const FOREIGN_ALIGN: usize;
> >>
> >>      /// Type used to immutably borrow a value that is currently forei=
gn-owned.
> >>      type Borrowed<'a>;
> >> @@ -39,18 +35,20 @@ pub unsafe trait ForeignOwnable: Sized {
> >>
> >>      /// Converts a Rust-owned object to a foreign-owned one.
> >>      ///
> >> +    /// The foreign representation is a pointer to void. Aside from t=
he guarantees listed below,
> >
> > I feel like this reads better:
> >
> > s/guarantees/ones/
> >
> >> +    /// there are no other guarantees for this pointer. For example, =
it might be invalid, dangling
> >
> > We should also mention that it could be null. (or is that assumption
> > wrong?)
>
> It is probably not going to be null, but it is allowed to. I can add it.
>
> The list does not claim to be exhaustive, and a null pointer is just a
> special case of an invalid pointer.

We probably should not allow null pointers. If we do, then
try_from_foreign does not make sense.

Alice

