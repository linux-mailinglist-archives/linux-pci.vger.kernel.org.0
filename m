Return-Path: <linux-pci+bounces-29430-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A94AAD535A
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 13:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CF2B3B31D2
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 11:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5522E6119;
	Wed, 11 Jun 2025 11:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E9eGK7eA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A7C2E6109
	for <linux-pci@vger.kernel.org>; Wed, 11 Jun 2025 11:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749640109; cv=none; b=CeJCnLmd/t6j/gtezb28sz80PK8kOInf39XFcvZH1M90qU9An6RQNGi5OvM3QimGh5CMx/YQ1gBUnSli7aEBDrpaatXkxD2X5tLcMHlU+VMwBVVeJ7XZNWw0QNk4e9rLZrfAMBlTuXZq4OnkhKlH+cHDSZUPhkE1hFcIJcLEIf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749640109; c=relaxed/simple;
	bh=nQJgpmtv7zcgAGtn8AlbcuWRPUUGIKAGBeLfuWQzNng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hmzSTeUC3MWuu8gwyZG1M3gyjBrms0ZZqqtlJOHBJZvF6Ppfsju7LRp14hvi+GNBjma/JA9JVxahH74YIek/ZOfW0Sb4EFUiLicc8j+6IfbBC5hIhp29UAtIPPWGQnLmI0Ep8yVczvJZ2FypoGyQihHUYSH7O72Kkl7WvxUuGVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E9eGK7eA; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a4e742dc97so546211f8f.0
        for <linux-pci@vger.kernel.org>; Wed, 11 Jun 2025 04:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749640105; x=1750244905; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fltmcdJR5+uSFB/BOttsMheYiBXzeebgxnOpmYcK9IM=;
        b=E9eGK7eA9VjjXtaaehngukszalr0LpFIRCtLfrNKmqPb01GtBKeGBNdeNJvohjQIyX
         0WAsnJ/M8z8bg9ipmahD5NKeRlcqL+Asb6621D41MHW3hF/9ik9S/wO8nrCnf4ea7eVi
         pom9YEuB8BaRj6rHwN0Fr4xWWzwNw+3GARTpKHKXhC53nGR8n2i/zMgASFF7n6Dtt4CY
         pe7xbir/Y8TRCeVUBcPENZNcaafws3DoZmep8Aw/48cUC29SXEpCh/ZnmDW0d4kisBcO
         GZ4jRTcS+KbFiWL+9Vf042lsFPrYZ0wCSJukFoYgRQhwJZC1h097h6RVEoMZDUCz7Loi
         JuTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749640105; x=1750244905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fltmcdJR5+uSFB/BOttsMheYiBXzeebgxnOpmYcK9IM=;
        b=PbCJWn0kZCad3dPNMzk67+n7PeD7UHr4iMQC0EvW9w6hTHAZORd5kWdwcpnsXEC/lZ
         kZzmXgMN7txhvhVlrWbQd7AR9S7Jo+1FHPc116pKBBp7aLyHMdf8eRatN5TU4glXL00j
         ID32etYYJmxWSMZ0KUz7W2eGrD6iVHcStTPveKUN9qIu9dlZVz37dDrbjhA4TZ+i9aog
         dfEFN9w41/at3CtI2BBAQfPiGqSNafwoX92iteE75QBeIA2wTVmthke7hQysVsobkGrk
         i6Y9H3gwaKDQiQ4OBSmOjgqGFwsNP7Ydlc/8GRsPTJKPCK2nk11lpVw00eGiBXRi6DRL
         UcgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZyitjUlGta6S3tHswThjZJhV2NfqxNu5ZX9DXMamJtYkYQmZsm77kjTwR1bxIqrXZKODFdGXBlus=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI1FiO7VL+V0TT+XxBWpqAAe9VOONd7xqoln/K7UPbxobn/HL6
	vfS8BoQuXcNj1RNQuSbHvgdvDKL9Orrk9awhqSryUQF8OSH9kqlEPt4k/mcYzBxm/k5L0q++Gbc
	RAjpS2pV8N+e6F5Snq95g7EcJf5UfqCITeVdJpijk
X-Gm-Gg: ASbGncui9z//G5sJgpCUti1EzwSU4fT8P9uJnCqkVVu1G9m17UyY/bzmL7vsBj38Eek
	Ne6PA9wqHJuWFy3kbBx+uXWgyVoFnvzos0vIGxWJgRkA8pUyc+L/It57aa1zrQqCxPz0sJWTD9D
	OBC88mcVgGAdGFy/60BDIJ/z1mdAvjDBBz+Jlu3ezqYiAtn4jYxPi864yzJ9YWXo7mOb0qzvUXB
	mdMDyVwFR8S
X-Google-Smtp-Source: AGHT+IGbgTDC9R5k+26NNyosxwCjQqzml5rbQBFSYZpq9MUeODCnOy4mDCQ40C2g4MXpjTSoeBZdpdGGzwYy9Bv8Tos=
X-Received: by 2002:a05:6000:230f:b0:3a4:e63d:2f2d with SMTP id
 ffacd0b85a97d-3a5581e7502mr2734468f8f.6.1749640105328; Wed, 11 Jun 2025
 04:08:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250605-pointed-to-v1-1-ee1e262912cc@kernel.org>
 <Was3UIiWcTBx58JEfoXMB908QEUOWeRMrekA9TD0VWTsA5KU20VwFE9Vo_xefwi_U4UOa5BggjbBby92lP96pg==@protonmail.internalid>
 <CAH5fLggzYQcMhcscuODR7cu__LLKAXhZ0A-tsBGc7gGyAA6Ofg@mail.gmail.com> <87ecvqzhcr.fsf@kernel.org>
In-Reply-To: <87ecvqzhcr.fsf@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 11 Jun 2025 13:08:11 +0200
X-Gm-Features: AX0GCFum2Poedya3OpC0KXmOTz2XUTZUwzK2xJUUdfTin56X1ZcOGgOs4wrlE0A
Message-ID: <CAH5fLgjRd5S4owRrZS7ONeb=-Tzq+xQDtWtqii1tCgEoqzr+bw@mail.gmail.com>
Subject: Re: [PATCH] rust: types: add FOREIGN_ALIGN to ForeignOwnable
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Tamir Duberstein <tamird@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 12:46=E2=80=AFPM Andreas Hindborg <a.hindborg@kerne=
l.org> wrote:
>
> "Alice Ryhl" <aliceryhl@google.com> writes:
>
> > On Thu, Jun 5, 2025 at 10:00=E2=80=AFPM Andreas Hindborg <a.hindborg@ke=
rnel.org> wrote:
> >>
> >> The current implementation of `ForeignOwnable` is leaking the type of =
the
> >> opaque pointer to consumers of the API. This allows consumers of the o=
paque
> >> pointer to rely on the information that can be extracted from the poin=
ter
> >> type.
> >>
> >> To prevent this, change the API to the version suggested by Maira
> >> Canal (link below): Remove `ForeignOwnable::PointedTo` in favor of a
> >> constant, which specifies the alignment of the pointers returned by
> >> `into_foreign`.
> >>
> >> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> >> Suggested-by: Ma=C3=ADra Canal <mcanal@igalia.com>
> >> Link: https://lore.kernel.org/r/20240309235927.168915-3-mcanal@igalia.=
com
> >> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> >
> > One nit below. With that and things other folks mentioned fixed, you ma=
y add:
> >
> > Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> >
> >> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> >> index 22985b6f6982..025c619a2195 100644
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
> >> +/// Implementers must ensure that [`Self::into_foreign`] return point=
ers with alignment that is an
> >> +/// integer multiple of [`Self::FOREIGN_ALIGN`].
> >
> > We should require non-null:
>
> What is your rationale for this?

The rationale is that the implementation of XArray assumes that the
pointers are non-null. If we allow null pointers, we will need to fix
the XArray.

Alice

