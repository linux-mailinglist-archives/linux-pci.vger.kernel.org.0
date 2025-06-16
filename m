Return-Path: <linux-pci+bounces-29868-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6534ADB211
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jun 2025 15:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9418D16B6A0
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jun 2025 13:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1332877D1;
	Mon, 16 Jun 2025 13:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="01dFRPvR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291412DF3FF
	for <linux-pci@vger.kernel.org>; Mon, 16 Jun 2025 13:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750080804; cv=none; b=SSasDyX7l/5ID6A3yHw0iTsoBYCsN3fJ225AntI81u0Kc5FAbLvsDYKEqNTmUWTU5ldWeP6lpwWkTq287hG7UBQthqP9ddp1MVIhVH14y1LDfoCj8rSdEnMkHfzcFBApVjLhwONQpPa7hSV/9TKpZcEw/ge4ZZ/Z+y1Zd+nMnYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750080804; c=relaxed/simple;
	bh=h61zvk86mIy6HFIKb44/uFTca5tTMXV0Nl9/b3obT20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fWKRRWlkGK5MWC9/MayV65L4sQzd2e45bTlfApcjvx1L7rRZBP9BAFMMIy2K7BnjkW5icsR2nDguIVE8aVRWsyXXqSG33FTL9SFzAV5lGojqC7ZsHOoWopCNxTk9RcSnlSOJ33kE2+NOHAD67diHg67mtMDUr4AxB+YvOjLmnRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=01dFRPvR; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4530921461aso38154835e9.0
        for <linux-pci@vger.kernel.org>; Mon, 16 Jun 2025 06:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750080800; x=1750685600; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+6b4Beq/LXHyQVf4U43/pXx65WWNeVARph73idBSy/s=;
        b=01dFRPvRfjuiD/kMP6K9WP1ziaLZSfdzf4KDPxS0sYi3lY9NFi780B/ohCVUM2mxuc
         secpGGeHJzmOOOQ0lb3N++T5OVfyZ/QweF0Uil238b7sqWzcytNWtv2ZTTvNLvA62Vjc
         gZ4+ilK2nuGkmEpJIh9vUzODYF1LkKdAu9RxKzbzSTPSsbZANNSLYLx5gKpjapef5z0s
         bRhh6nzG4I2BESq8DjX7+N5c/L6fFTrWXA5kad4IvTEQZeSN1Fha9EyVnkAAZQVdEcfH
         393/Fmtg7luiVx/+dHFL6bdI/vqtRgNPahyULOFvjiYZh23EU1gBrR77XTUCmyTn3dTs
         tI2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750080800; x=1750685600;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+6b4Beq/LXHyQVf4U43/pXx65WWNeVARph73idBSy/s=;
        b=CKn0r82iqbkfkV/KhA7UhlgwLcriq7rfHn+SYRjFDaFUjkxCDjQ2BHFvFGcJje9+eZ
         /aNQF+CjKLA048apyriU3SZU+g1WIN0KSmDhm1cVc3RV8n6jdOkewfNwCaIxZnK4L6Hd
         P7Kzxme5i3g7tx35faivram3AxDjbJMX6MtjXbyqDC5H8rgWY8Yr0azrU3l8Hz5Vicw+
         9H9bS8KKcmD5X+QLoS5CyP1hvxauLBhFIwahPsqvOy1qoU8M8uz5o59rLwgXZ+eufPXY
         8DcrtvJZV7wLsAymUZERLfKpDtKRYEZgrrz2wqAEFjk6uu7gbqYR8Vj6A69Apb5mGI6n
         X+dA==
X-Forwarded-Encrypted: i=1; AJvYcCUqgBYqdzcEmxWvRAjXwbZchmdWYrE2q0mAMFoNUS+j5JXkr/XEUHbRC7uuSrKog8QxDuWhYT1PFx0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh3Iw1bGoFZRyRorL88qMbH5IvnVoAqxcVEB17D7SO0kXxjzjK
	vLyd/xhMj5rQ+wTPZwn9qkyLClRqSU564/qX37FzEeeYon38t6+3GEK9JIJA+9IvEiXxQlbUsFh
	XJ+rkwkgvFqCMdWt8X2kPP3pd+ZK6DUqLzFHvlYSk
X-Gm-Gg: ASbGncsnD25EzCTWOqXGq3uK4ea4rWSxEgMJp2nKqr4jnyJMT0c5Sde+P/tlCMm8L2z
	5EeN8NhR0Low/1Zhox8m6bq3Er2/3XSWTKEK3z+zxuT+KQ3vHwaqb660kmpA8QZw4N0/hwXcO8M
	/8jyTsL7bneAy7h11g/c12O89hDboKWd0sR7uXm2vwEhh6
X-Google-Smtp-Source: AGHT+IHoHIQWUh1tsB7VdpSgBe+HOR1+wnpYotOSJnim3yodaLfcWb+HX61Di4FQcFN8L/suGwt1uoWH/7fAgVfvJZs=
X-Received: by 2002:a05:600c:1d9e:b0:453:7bd:2e30 with SMTP id
 5b1f17b1804b1-4533cac455fmr88605775e9.29.1750080800258; Mon, 16 Jun 2025
 06:33:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250608-topics-tyr-request_irq-v4-0-81cb81fb8073@collabora.com>
 <20250608-topics-tyr-request_irq-v4-4-81cb81fb8073@collabora.com>
 <aEbTOhdfmYmhPiiS@pollux> <5B3865E5-E343-4B5D-9BF7-7B9086AA9857@collabora.com>
 <aEckTQ2F-s1YfUdu@pollux.localdomain>
In-Reply-To: <aEckTQ2F-s1YfUdu@pollux.localdomain>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 16 Jun 2025 15:33:06 +0200
X-Gm-Features: AX0GCFugHkgwu-8fmEBsdYNx2iQ--FaKirwILvqXSQM0todMUtf7WPLfkCI54O0
Message-ID: <CAH5fLgj+za85ajgNwJepoa7PSFkMm+3J2wJJVJ24m6YZoFVmVw@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] rust: irq: add support for threaded IRQs and handlers
To: Danilo Krummrich <dakr@kernel.org>
Cc: Daniel Almeida <daniel.almeida@collabora.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Benno Lossin <lossin@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 9, 2025 at 8:13=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> w=
rote:
>
> On Mon, Jun 09, 2025 at 01:24:40PM -0300, Daniel Almeida wrote:
> > > On 9 Jun 2025, at 09:27, Danilo Krummrich <dakr@kernel.org> wrote:
> > >> +#[pin_data]
> > >> +pub struct ThreadedRegistration<T: ThreadedHandler + 'static> {
> > >> +    inner: Devres<RegistrationInner>,
> > >> +
> > >> +    #[pin]
> > >> +    handler: T,
> > >> +
> > >> +    /// Pinned because we need address stability so that we can pas=
s a pointer
> > >> +    /// to the callback.
> > >> +    #[pin]
> > >> +    _pin: PhantomPinned,
> > >> +}
> > >
> > > Most of the code in this file is a duplicate of the non-threaded regi=
stration.
> > >
> > > I think this would greatly generalize with specialization and an Hand=
lerInternal
> > > trait.
> > >
> > > Without specialization I think we could use enums to generalize.
> > >
> > > The most trivial solution would be to define the Handler trait as
> > >
> > > trait Handler {
> > >   fn handle(&self);
> > >   fn handle_threaded(&self) {};
> > > }
> > >
> > > but that's pretty dodgy.
> >
> > A lot of the comments up until now have touched on somehow having threa=
ded and
> > non-threaded versions implemented together. I personally see no problem=
 in
> > having things duplicated here, because I think it's easier to reason ab=
out what
> > is going on this way. Alice has expressed a similar view in a previous =
iteration.
> >
> > Can you expand a bit more on your suggestion? Perhaps there's a clean w=
ay to do
> > it (without macros and etc), but so far I don't see it.
>
> I think with specialization it'd be trivial to generalize, but this isn't
> stable yet. The enum approach is probably unnecessarily complicated, so I=
 agree
> to leave it as it is.
>
> Maybe a comment that this can be generalized once we get specialization w=
ould be
> good?

Specialization is really far out. I don't think we should try to take
it into account when designing things today. I think that the
duplication in this case is perfectly acceptable and trying to
deduplicate makes things too hard to read.

> > >> +impl<T: ThreadedHandler + 'static> ThreadedRegistration<T> {
> > >> +    /// Registers the IRQ handler with the system for the given IRQ=
 number.
> > >> +    pub(crate) fn register<'a>(
> > >> +        dev: &'a Device<Bound>,
> > >> +        irq: u32,
> > >> +        flags: Flags,
> > >> +        name: &'static CStr,
> > >> +        handler: T,
> > >> +    ) -> impl PinInit<Self, Error> + 'a {
> > >
> > > What happens if `dev`  does not match `irq`? The caller is responsibl=
e to only
> > > provide an IRQ number that was obtained from this device.
> > >
> > > This should be a safety requirement and a type invariant.
> >
> > This iteration converted register() from pub to pub(crate). The idea wa=
s to
> > force drivers to use the accessors. I assumed this was enough to make t=
he API
> > safe, as the few users in the kernel crate (i.e.: so far platform and p=
ci)
> > could be manually checked for correctness.
> >
> > To summarize my point, there is still the possibility of misusing this =
from the
> > kernel crate itself, but that is no longer possible from a driver's
> > perspective.
>
> Correct, you made Registration::new() crate private, such that drivers ca=
n't
> access it anymore. But that doesn't make the function safe by itself. It'=
s still
> unsafe to be used from platform::Device and pci::Device.
>
> While that's fine, we can't ignore it and still have to add the correspon=
ding
> safety requirements to Registration::new().
>
> I think there is a way to make this interface safe as well -- this is als=
o
> something that Benno would be great to have a look at.
>
> I'm thinking of something like
>
>         /// # Invariant
>         ///
>         /// `=C4=9Brq` is the number of an interrupt source of `dev`.
>         struct IrqRequest<'a> {
>            dev: &'a Device<Bound>,
>            irq: u32,
>         }
>
> and from the caller you could create an instance like this:
>
>         // INVARIANT: [...]
>         let req =3D IrqRequest { dev, irq };
>
> I'm not sure whether this needs an unsafe constructor though.

The API you shared would definitely work. It pairs the irq number with
the device it matches. Yes, I would probably give it an unsafe
constructor, but I imagine that most methods that return an irq number
could be changed to just return this type so that drivers do not need
to use said unsafe.

Alice

