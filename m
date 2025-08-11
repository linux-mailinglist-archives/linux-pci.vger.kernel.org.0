Return-Path: <linux-pci+bounces-33750-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03096B20C39
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 16:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37AFB1903ADA
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 14:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C4E2DBF6E;
	Mon, 11 Aug 2025 14:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="weEn2iwH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4E88248B
	for <linux-pci@vger.kernel.org>; Mon, 11 Aug 2025 14:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754923081; cv=none; b=AXGMzAv+Lz0V71DyeQmrFsX92f/lVCu+SQTgwbJthEjgh6XaEldaeRe+tleVv7E8cps5RT2YzHdvUIIt/nu1HsImr8gLt5q8HXOxQanviGJda9fGfoxfUJBSAXiKQ81U1u+MYG64cqub4hFf14D9HvrDNvFj4GSf9dF/Qz3Z12E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754923081; c=relaxed/simple;
	bh=kO1JB1VmeHgW6zo6ygzZHs1c8xvTe+S4IMczMwehw00=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U7HT4sChssuRxcC8UeTRpEIaMdvb/aWK+UbgBNKBURT5JE1UokggzyhAOhxCFQwze/CPVpaJJAzmhh9HuoA/3s1AwNgukOEvC7NnILCsCS2rVtP6bJPGegpehIID9rr0I6A5NhY3y6ksDE9ShaFmPLqj5Dhg6Rhf10AA+0L6FdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=weEn2iwH; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3b77b8750acso2689569f8f.0
        for <linux-pci@vger.kernel.org>; Mon, 11 Aug 2025 07:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754923077; x=1755527877; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K+z3k6Ua1tsSSnOHatF9KK1NYrriwb9RYvKnWmfP/Fo=;
        b=weEn2iwHXmVMOCm/xOXbwW7nQErwXs7Jye7e/mcjS1oHn5ij+pEE6RKIT43IitWCrc
         123I0llgP/ayBwTJTOD8FVBs4mCwgIOHM9O3vJaEg6MG6yL4vvgIFP0FjaZIFKNkU/XN
         OtTGFDWRkl3R86TAGQUOrt6CBkZ0Cn3EARRk6WHzEpHD/HVLalLri3WYYf/oP0z9igKn
         iD5Ue82W/CP7qVxK0QlSKThI22YrbfWwLcoizn8sQd8sdi1FFZNHccHV5/b1tR5jPTZa
         XIzGSnJ+suyLIY4SXFiBctzjBVobdy8fYHeFKjtEipZk45tS5Gq2G7HgiAjPHGVUpIrO
         QZVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754923077; x=1755527877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K+z3k6Ua1tsSSnOHatF9KK1NYrriwb9RYvKnWmfP/Fo=;
        b=v9jX0AwjdTTeu+YkuJoQc9itHrRe1OeR+iqJsqpNdeNKQ0uIo5F7fI5ECo3ML2QOz3
         BJ5SIlbSzB1OzTXrY5/c9nb543A/nONyyo9Vynk+cOtMKUvPwaOVgfsMb2on3Mcc96AD
         BszQ1dv55bBfbmTlljaWEVnSkCqkVJyn6C/tbvq4iwkroZYi9U8TaOO+Bx++cf5hPWJq
         YiqTf9TpHE8gEbA3jbTXUGGUtQHNAl75GdOeEr5qbhRkaIxmw8YYESBALv4/kIKMGxgV
         LpYy9a8BiNzQn32dUu0xhVl7IOYOMpRZZUGrj3VuJObuLbMUbn61w7lZ6zYBN6Fpaw6Z
         B2qQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZBFFsmqMdBsgPejCjrq3cgiM+OzR9HHZpdy8+vTQmJFKzR8QvjL5iB8BW/fe6kikYXQbrU5BZo8k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJkU5AjpsZmhaR23IN8OEZubOgG+c7V/tJtwBJn4F9K67YCDDu
	nLcji91bNnOx+7/qSINLpNMunrDpQpCiIP8+2qhjOMwfHIMk4ldtIXAuOpusc2agxcoF9MI63Oy
	gSqYAg4noPWmQ3jj/4oy39kyuK5durVlGNAx1ATNY
X-Gm-Gg: ASbGncst2wsRHPmhy4IRa6rDbLLVPbqAmza1vU01W4Pv1jfdx8BTFk99JMDU2w9jdAJ
	qVTdWIMtEFntskDEOF3e22LJefwJhJ5aCVhq5hVOd2kGTTcDi9t+cbwOv7AA7+t+n1ASHBDOfrE
	N2FN2ntRVxnmbnyPDsatfl7SUSBF74U61gG+DWOc9SZsqbo/5akzA5vQiqhL8PsGkVuEU+fw5p5
	r7gMYbC
X-Google-Smtp-Source: AGHT+IE/Frgb3ZlY2MCzOV2I5cZU+C8DcXR8cxM8f86Ka67fehrhKUAUXkGM5NC5xvbtWIrLzx/eTMLVG4wd/T3IpUE=
X-Received: by 2002:a05:6000:2481:b0:3a5:5130:1c71 with SMTP id
 ffacd0b85a97d-3b910ecf283mr134206f8f.0.1754923076907; Mon, 11 Aug 2025
 07:37:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811-irq-bound-device-v2-1-d73ebb4a50a2@google.com>
 <aJn2ogBSmedhpuCa@Mac.home> <CAH5fLghitfmSOByu4ZRmhwdsOadzJOLei_qrAjNM+V15spq44w@mail.gmail.com>
 <aJn9M3WPcI_ZGems@Mac.home> <CAH5fLgg+1FtiHkXOzKLHFP-gRrq1Dq8yUO4RmyE7tM4aSDYioA@mail.gmail.com>
 <aJn-q-SebbQoyiyy@Mac.home>
In-Reply-To: <aJn-q-SebbQoyiyy@Mac.home>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 11 Aug 2025 16:37:44 +0200
X-Gm-Features: Ac12FXzBwx5G7tLxLwgUz7FQbJ9ALGarXtm0IVz3Ujr5_Yy2TvPeR4j1O5s2IRw
Message-ID: <CAH5fLgicWki8Z+ne9fMn4KbQYYz340FhpOONU5dCCMwfo0wnhg@mail.gmail.com>
Subject: Re: [PATCH v2] rust: irq: add &Device<Bound> argument to irq callbacks
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Daniel Almeida <daniel.almeida@collabora.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?Q?Krzysztof_Wilczy=C2=B4nski?= <kwilczynski@kernel.org>, 
	Benno Lossin <lossin@kernel.org>, Dirk Behme <dirk.behme@gmail.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 4:31=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> On Mon, Aug 11, 2025 at 04:25:50PM +0200, Alice Ryhl wrote:
> > On Mon, Aug 11, 2025 at 4:24=E2=80=AFPM Boqun Feng <boqun.feng@gmail.co=
m> wrote:
> > >
> > > On Mon, Aug 11, 2025 at 04:05:31PM +0200, Alice Ryhl wrote:
> > > > On Mon, Aug 11, 2025 at 3:56=E2=80=AFPM Boqun Feng <boqun.feng@gmai=
l.com> wrote:
> > > > >
> > > > > On Mon, Aug 11, 2025 at 12:33:51PM +0000, Alice Ryhl wrote:
> > > > > [...]
> > > > > > @@ -207,8 +207,8 @@ pub fn new<'a>(
> > > > > >              inner <- Devres::new(
> > > > > >                  request.dev,
> > > > > >                  try_pin_init!(RegistrationInner {
> > > > > > -                    // SAFETY: `this` is a valid pointer to th=
e `Registration` instance
> > > > > > -                    cookie: unsafe { &raw mut (*this.as_ptr())=
.handler }.cast(),
> > > > > > +                    // INVARIANT: `this` is a valid pointer to=
 the `Registration` instance
> > > > > > +                    cookie: this.as_ptr().cast::<c_void>(),
> > > > >
> > > > > At this moment the `Regstration` is not fully initialized...
> > > > >
> > > > > >                      irq: {
> > > > > >                          // SAFETY:
> > > > > >                          // - The callbacks are valid for use w=
ith request_irq.
> > > > > > @@ -221,7 +221,7 @@ pub fn new<'a>(
> > > > > >                                  Some(handle_irq_callback::<T>)=
,
> > > > > >                                  flags.into_inner(),
> > > > > >                                  name.as_char_ptr(),
> > > > > > -                                (&raw mut (*this.as_ptr()).han=
dler).cast(),
> > > > > > +                                this.as_ptr().cast::<c_void>()=
,
> > > > > >                              )
> > > > >
> > > > > ... and interrupt can happen right after request_irq() ...
> > > > >
> > > > > >                          })?;
> > > > > >                          request.irq
> > > > > > @@ -258,9 +258,13 @@ pub fn synchronize(&self, dev: &Device<Bou=
nd>) -> Result {
> > > > > >  ///
> > > > > >  /// This function should be only used as the callback in `requ=
est_irq`.
> > > > > >  unsafe extern "C" fn handle_irq_callback<T: Handler>(_irq: i32=
, ptr: *mut c_void) -> c_uint {
> > > > > > -    // SAFETY: `ptr` is a pointer to T set in `Registration::n=
ew`
> > > > > > -    let handler =3D unsafe { &*(ptr as *const T) };
> > > > > > -    T::handle(handler) as c_uint
> > > > > > +    // SAFETY: `ptr` is a pointer to `Registration<T>` set in =
`Registration::new`
> > > > > > +    let registration =3D unsafe { &*(ptr as *const Registratio=
n<T>) };
> > > > >
> > > > > ... hence it's not correct to construct a reference to `Registrat=
ion`
> > > > > here, but yes, both `handler` and the `device` part of `inner` ha=
s been
> > > > > properly initialized. So
> > > > >
> > > > >         let registration =3D ptr.cast::<Registration<T>>();
> > > > >
> > > > >         // SAFETY: The `data` part of `Devres` is `Opaque` and he=
re we
> > > > >         // only access `.device()`, which has been properly initi=
alized
> > > > >         // before `request_irq()`.
> > > > >         let device =3D unsafe { (*registration).inner.device() };
> > > > >
> > > > >         // SAFETY: The irq callback is removed before the device =
is
> > > > >         // unbound, so the fact that the irq callback is running =
implies
> > > > >         // that the device has not yet been unbound.
> > > > >         let device =3D unsafe { device.as_bound() };
> > > > >
> > > > >         // SAFETY: `.handler` has been properly initialized befor=
e
> > > > >         // `request_irq()`.
> > > > >         T::handle(unsafe { &(*registration).handler }, device) as=
 c_uint
> > > > >
> > > > > Thoughts? Similar for the threaded one.
> > > >
> > > > This code is no different. It creates a reference to `inner` before
> > > > the `irq` field is written. Of course, it's also no different in th=
at
> > > > since data of a `Devres` is in `Opaque`, this is not actually UB.
> > > >
> > >
> > > Well, I think we need at least mentioning that it's safe because we
> > > don't access .inner.inner here, but..
> > >
> > > > What I can offer you is to use the closure form of pin-init to call
> > > > request_irq after initialization has fully completed.
> > > >
> > >
> > > .. now you mention this, I think we can just move the `request_irq()`
> > > to the initializer of `_pin`:
> > >
> > > ------>8
> > > diff --git a/rust/kernel/irq/request.rs b/rust/kernel/irq/request.rs
> > > index ae5d967fb9d6..3343964fc1ab 100644
> > > --- a/rust/kernel/irq/request.rs
> > > +++ b/rust/kernel/irq/request.rs
> > > @@ -209,26 +209,26 @@ pub fn new<'a>(
> > >                  try_pin_init!(RegistrationInner {
> > >                      // INVARIANT: `this` is a valid pointer to the `=
Registration` instance
> > >                      cookie: this.as_ptr().cast::<c_void>(),
> > > -                    irq: {
> > > -                        // SAFETY:
> > > -                        // - The callbacks are valid for use with re=
quest_irq.
> > > -                        // - If this succeeds, the slot is guarantee=
d to be valid until the
> > > -                        //   destructor of Self runs, which will der=
egister the callbacks
> > > -                        //   before the memory location becomes inva=
lid.
> > > -                        to_result(unsafe {
> > > -                            bindings::request_irq(
> > > -                                request.irq,
> > > -                                Some(handle_irq_callback::<T>),
> > > -                                flags.into_inner(),
> > > -                                name.as_char_ptr(),
> > > -                                this.as_ptr().cast::<c_void>(),
> > > -                            )
> > > -                        })?;
> > > -                        request.irq
> > > -                    }
> > > +                    irq: request.irq
> > >                  })
> > >              ),
> > > -            _pin: PhantomPinned,
> > > +            _pin: {
> > > +                // SAFETY:
> > > +                // - The callbacks are valid for use with request_ir=
q.
> > > +                // - If this succeeds, the slot is guaranteed to be =
valid until the
> > > +                //   destructor of Self runs, which will deregister =
the callbacks
> > > +                //   before the memory location becomes invalid.
> > > +                to_result(unsafe {
> > > +                    bindings::request_irq(
> > > +                        request.irq,
> > > +                        Some(handle_irq_callback::<T>),
> > > +                        flags.into_inner(),
> > > +                        name.as_char_ptr(),
> > > +                        this.as_ptr().cast::<c_void>(),
> > > +                    )
> > > +                })?;
> > > +                PhantomPinned
> > > +            },
> > >          })
> > >      }
> > >
> > >
> > > Thoughts?
> >
> > That calls free_irq if request_irq fails, which is illegal.
> >
>
> Ah, right. I was missing that. Then back to the "we have to mention that
> we are not accessing the data of Devres" suggestion, which I think is
> more appropriate for this case.

I will add:

// - When `request_irq` is called, everything that `handle_irq_callback`
//   will touch has already been initialized, so it's safe for the callback
//   to be called immediately.

Will you offer your Reviewed-by ?

Alice

