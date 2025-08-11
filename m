Return-Path: <linux-pci+bounces-33739-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1630DB20B4A
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 16:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B51018C3915
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 14:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E18F21770B;
	Mon, 11 Aug 2025 14:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FZ44mn7y"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7393D1DC9B8
	for <linux-pci@vger.kernel.org>; Mon, 11 Aug 2025 14:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754921150; cv=none; b=pv5tnsCTIbOhAy8tgnhysNrjBE0064t7086WxH3ZKXExnbxlNzhP9QKYic9UGfojM9ngT7pokyf7AmQBXvA7ZdSAZGaLpbqqyOU6j5W9BLYHeGbNoIYeThQRC+2hZPZ/6tDL1JGJPPH/pqXvgFDE8wehQpHlKXd9eR3Xv4vcjLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754921150; c=relaxed/simple;
	bh=6G0CAj8+b3EF/eRMNLWM9xa7DKYNgI3twm4Adwz//Ho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bxzhbzvfdC4dQnRXYSKEDADPjdJUussVNh255+i3UwH4tdkKKQCIqVrbm1wo2JtvtWt9+PmuAK0dcv6w+6OGQOSiuk+wApFWHmg3panWAfk9iytAR/SzdU/LkkTC85YSyf/iX0+x6YiBCqj+uG2b0xgxlWLjiVQIFkguVFhMZ6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FZ44mn7y; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-459e39ee7ccso43788765e9.2
        for <linux-pci@vger.kernel.org>; Mon, 11 Aug 2025 07:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754921147; x=1755525947; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gzcgt7tPIgJiNviWdrYOHkQsKV8L9l0FLco676hE7Vc=;
        b=FZ44mn7y2N6rYacEpbyhmcHRKWs5HLwt2m7DAxodbBHWKdWXeW8EDIXMze3DWv7aPX
         PWOYU+g90TORtUKy+rpDu3xuqpPjy7e/koV0mzzO5INe9qZwbWwrP+Qa7oYEU3ZIGRpm
         4YBA5t0e/B+IgYBCfQMH1LDJP24v/zjx0BSv0NZPULqOP5oqCm7hdO+Qg2ljHcWbOnqu
         GIJB6xUpt1Y7Tmi5fIiWVSb908o3p+sQzz8stuJbu63/ioobgec8dXsq19GbV6y4KWea
         cqqgeFTXFbY1uh40CITAzvQsyrPpGDV6rO8w4cd2D6XrFOAOEkjJXVFiZmK95MzXjgXm
         P13g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754921147; x=1755525947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gzcgt7tPIgJiNviWdrYOHkQsKV8L9l0FLco676hE7Vc=;
        b=QE80q1pjTlRRU2BbSo2bS8FgISkEk2wwQ1HqKG+GF1ylnvVsATWyANJ7OW62349xwP
         meV0iUVEq0Vs1bQV43NEz5oepHq21bpZwsEkNrm2//MXwbXfJ/f3lJmAco3OYmZjClUY
         jCmHjL4IqV33204LGfJpBVwSB934gFiZAMPjXDJjrYMpep4lKIcgmJV7N32ZF5cNPzN0
         CmzEKvAXLP0EdzNXne+B697wItcUMyjWUAVAK6LEI0wWU2CmFFykkg970kuBGk8e5my1
         tbJfLJuwpbFOhYBtvhIkH/7b3DUhKh/jVMvluqOS/hZbTB4g65bNihe+3YzCGQg9Kybn
         8mIw==
X-Forwarded-Encrypted: i=1; AJvYcCU8KGK877bO8RxjVTbb7vvKPRvduYXiRwK/hfN2vgzRKGRWu/VxTnGXsiJ4UPb6Km1NFrG8q/EtBy8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVtszj0rBjTDh/4g73v0H9Wf8SDsa46dcpO6qXBFCMLCR0P7ur
	oGGlHt2QG62AHFgk7sZQDiQm6U/ZVPZP9AfucKoJ7/nGsVhM+vxq5WVzN3bxo3Gce4y3cUY5lSC
	rcbnMR+PS4f0rfkWIFuGFu8fzV0E/vYUw2r1hHKmW
X-Gm-Gg: ASbGnctCtHfmseUykMOB3vsK/XMTxlAgMG9Il8UAnERFffnYTPUPVCxpRjhNQufp5Ah
	aZQwipFE0zPJQx0SIderK+BOh7vwbILWcj7IDR/yrnJmhtlPiQ6B/gSFzr04jEnrMu41HB8Rgxp
	GctupUTpQ+Ukfw/3DfGqrqU4n3H0lOGN37l3OYflUugPV6G9rT9oms1QajCnqYZLwgj2IR0iYD2
	eTcYlfn
X-Google-Smtp-Source: AGHT+IGWbyuFgLyBBkSn2JnfS5Eii6UcbRVMG2tY5fW3W6SXX7EsRbsX6BvuGls1wI0u9Sa3y9sGMeYXibm1nZC9qwA=
X-Received: by 2002:a05:600c:154d:b0:459:d780:3604 with SMTP id
 5b1f17b1804b1-459f4f3cf5dmr129632055e9.3.1754921146509; Mon, 11 Aug 2025
 07:05:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811-irq-bound-device-v2-1-d73ebb4a50a2@google.com> <aJn2ogBSmedhpuCa@Mac.home>
In-Reply-To: <aJn2ogBSmedhpuCa@Mac.home>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 11 Aug 2025 16:05:31 +0200
X-Gm-Features: Ac12FXwqIWuXoxPu_skZcwNvETuBNDT2V1LLiDQ414ymWpGTUya_c_eHQiX2Jnc
Message-ID: <CAH5fLghitfmSOByu4ZRmhwdsOadzJOLei_qrAjNM+V15spq44w@mail.gmail.com>
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

On Mon, Aug 11, 2025 at 3:56=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> On Mon, Aug 11, 2025 at 12:33:51PM +0000, Alice Ryhl wrote:
> [...]
> > @@ -207,8 +207,8 @@ pub fn new<'a>(
> >              inner <- Devres::new(
> >                  request.dev,
> >                  try_pin_init!(RegistrationInner {
> > -                    // SAFETY: `this` is a valid pointer to the `Regis=
tration` instance
> > -                    cookie: unsafe { &raw mut (*this.as_ptr()).handler=
 }.cast(),
> > +                    // INVARIANT: `this` is a valid pointer to the `Re=
gistration` instance
> > +                    cookie: this.as_ptr().cast::<c_void>(),
>
> At this moment the `Regstration` is not fully initialized...
>
> >                      irq: {
> >                          // SAFETY:
> >                          // - The callbacks are valid for use with requ=
est_irq.
> > @@ -221,7 +221,7 @@ pub fn new<'a>(
> >                                  Some(handle_irq_callback::<T>),
> >                                  flags.into_inner(),
> >                                  name.as_char_ptr(),
> > -                                (&raw mut (*this.as_ptr()).handler).ca=
st(),
> > +                                this.as_ptr().cast::<c_void>(),
> >                              )
>
> ... and interrupt can happen right after request_irq() ...
>
> >                          })?;
> >                          request.irq
> > @@ -258,9 +258,13 @@ pub fn synchronize(&self, dev: &Device<Bound>) -> =
Result {
> >  ///
> >  /// This function should be only used as the callback in `request_irq`=
.
> >  unsafe extern "C" fn handle_irq_callback<T: Handler>(_irq: i32, ptr: *=
mut c_void) -> c_uint {
> > -    // SAFETY: `ptr` is a pointer to T set in `Registration::new`
> > -    let handler =3D unsafe { &*(ptr as *const T) };
> > -    T::handle(handler) as c_uint
> > +    // SAFETY: `ptr` is a pointer to `Registration<T>` set in `Registr=
ation::new`
> > +    let registration =3D unsafe { &*(ptr as *const Registration<T>) };
>
> ... hence it's not correct to construct a reference to `Registration`
> here, but yes, both `handler` and the `device` part of `inner` has been
> properly initialized. So
>
>         let registration =3D ptr.cast::<Registration<T>>();
>
>         // SAFETY: The `data` part of `Devres` is `Opaque` and here we
>         // only access `.device()`, which has been properly initialized
>         // before `request_irq()`.
>         let device =3D unsafe { (*registration).inner.device() };
>
>         // SAFETY: The irq callback is removed before the device is
>         // unbound, so the fact that the irq callback is running implies
>         // that the device has not yet been unbound.
>         let device =3D unsafe { device.as_bound() };
>
>         // SAFETY: `.handler` has been properly initialized before
>         // `request_irq()`.
>         T::handle(unsafe { &(*registration).handler }, device) as c_uint
>
> Thoughts? Similar for the threaded one.

This code is no different. It creates a reference to `inner` before
the `irq` field is written. Of course, it's also no different in that
since data of a `Devres` is in `Opaque`, this is not actually UB.

What I can offer you is to use the closure form of pin-init to call
request_irq after initialization has fully completed.

Alice

