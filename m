Return-Path: <linux-pci+bounces-30409-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0337AE4877
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 17:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C33F53A8F80
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 15:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49EED279DBC;
	Mon, 23 Jun 2025 15:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jcRyYChw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4951CD1F
	for <linux-pci@vger.kernel.org>; Mon, 23 Jun 2025 15:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750692321; cv=none; b=nQcqo7kaZprUnmkO4oIHOxGmln/xdGxS/YG6elKCWQaSUvqb7Gnz+CPn6yaqY5wSuDbLd+bluDiKsjvtsB4P4Z3R8R3Ruel5hFDlddkN0wQVrFVDqJEgBwGA0uL46RkvfOxdzamVR4H5NUTHjRtOjuXBcjbIMjgq8Iy23POWseg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750692321; c=relaxed/simple;
	bh=rooemphzOqtubFfw/F97wIDqZd1so1tZE56RR6AJh4I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tA6jBVClXe5NxXRTuRc1SslfCJdQXMEPJQslGyxy4TLABkJmR7JH2HBuS6X2KbF94fYIyBxYKumN6mOzRqNh38GULlptt52n4vU9yPbVFQFzns4tFD3cafM1h0aDBsDUgwjJxJ11U3DgoXJe8xFal0Jx5zRTiXHW4E4E+KGUsSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jcRyYChw; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a52874d593so4281786f8f.0
        for <linux-pci@vger.kernel.org>; Mon, 23 Jun 2025 08:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750692318; x=1751297118; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JmXZjjSvv6KRZI/6FKBR1ZLR3DullsuqN4s2MM1/x5M=;
        b=jcRyYChwZ05ZY9W149+v1RAesLOW1R3rb6v9juG24u9Ou6qpjkBuL0bRUXcKL10RET
         Z6TzSf9LPMLE5MfUF1bfTo8Tf+39iarYFUgXYgSq8GZiqoP5E+BN4+7a51Bl7F0N4q2R
         gn2Iq9yxyqCX20fqY6AtWMGAQbdTEq3In+YMieQS+2N4cRpPZIrxkv/YgIwECmxltLIm
         zrHGVGnQHOYkDE6ISWlwjC0XZTDZBSymqrbvwfSyvqxG+CCOcAjuK8ag4pSVA+ypL78u
         CsQIx5+9OF73RlphUQm3x2XjC5vuEjcqK9r/7DcmrfAM9qIvvypuR2SbD3Vr6jPVp2Ux
         aZDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750692318; x=1751297118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JmXZjjSvv6KRZI/6FKBR1ZLR3DullsuqN4s2MM1/x5M=;
        b=De6ISQc9KFCxxnLS269T+kfZYx488/qsyFe7g1cRGXS43yJcGSYlqhNga0TOsQ0FKr
         yi08znX3SDXImZwqZTGp3u25lnR9GBCUo9k70M22PQ8ZrNUtZ7U2eT8x0cR9VvrbHxM6
         qITMjhMU98YW7CzkIatxb9nI9+EzFgxHoXrHAnQUIbPZz0Vj1valJY+qysPd/Zs71rkw
         bFCCMh9Jseag1JQtUlFQmuVAFUbT1OAtn1PiOMIwfcoziY2wSBVgxmVaMm775qYPLCyL
         XrIK3o7e7ThkiyV96Zo2Z5rUzcGjmppdcqqPNgRJfuZHNv+FTvQ4grA22ZGidSmU0kdT
         OfsA==
X-Forwarded-Encrypted: i=1; AJvYcCVSySXdcGTHERvwMUQX4Up0MglaN5vK5dttrtJT/EsZBadbKVrK5wsHjlUwGTTcX9rwVOPLrKDHkuk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkkcllUNgODxuW//H8dkfbfHesJNJnKd4MygeZyuEphfJKqsT9
	/QHKLFri7lOXxoJnf6Yvm2lrvZFLfBeuXuhZmpY0TUHrJpKaXijxbJTGp1OpLkI1LVnaTcqoBjN
	WXQdOp7dRnFDJ6nxm/9wkLng+ZGjNTfupPYPx8e9Q
X-Gm-Gg: ASbGnctK1isQAtq7fqDNhlfjt1S2wndyx0FFMjXWpCqkTLA+trmEQv4uOPQ7TD0kz9Y
	Ea9BQvgeDue0PPe38Qij5qMqEpoPsKcovo6tWtDVV71emtfy7m9Ck3sfXnd0Kp5RoAhCHEK/buu
	V1NoS3Ei3LR/oKlrI7FcNeVOet+7ZsGxIE0X2LjydufDgk9SZQh1qs/+rK7d/t2PiL+m0rQs4=
X-Google-Smtp-Source: AGHT+IFM///a/o7NHCUrhz8JPaRc40ICRJPP9JISkr8ZSl+zk8SDCl551tho6AamwirxjOCO4tDCa3hYmXK5w6/vb8o=
X-Received: by 2002:a05:6000:1a8e:b0:3a4:eeb5:21cb with SMTP id
 ffacd0b85a97d-3a6d12e5b71mr10700599f8f.26.1750692317667; Mon, 23 Jun 2025
 08:25:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250608-topics-tyr-request_irq-v4-0-81cb81fb8073@collabora.com>
 <20250608-topics-tyr-request_irq-v4-3-81cb81fb8073@collabora.com>
 <aEbJt0YSc3-60OBY@pollux> <CAH5fLghDbrgO2PiKyKZ87UrtouG25xWhVP_YmcgO0fFcnvZRkQ@mail.gmail.com>
 <aFlxVlMYWig1N2Hy@cassiopeiae>
In-Reply-To: <aFlxVlMYWig1N2Hy@cassiopeiae>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 23 Jun 2025 16:25:05 +0100
X-Gm-Features: Ac12FXxyv0kAilreQ5Zm3W4KKmQb04F-9AgepG9LhG7dkMGHyJnrjjLP_SjGXbo
Message-ID: <CAH5fLghr7Z4NGdwZO6MqnYCpwp4pwKVaTq78dnm3PNYYvL8cCA@mail.gmail.com>
Subject: Re: [PATCH v4 3/6] rust: irq: add support for non-threaded IRQs and handlers
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

On Mon, Jun 23, 2025 at 4:23=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> On Mon, Jun 23, 2025 at 04:10:50PM +0100, Alice Ryhl wrote:
> > On Mon, Jun 9, 2025 at 12:47=E2=80=AFPM Danilo Krummrich <dakr@kernel.o=
rg> wrote:
> > >
> > > On Sun, Jun 08, 2025 at 07:51:08PM -0300, Daniel Almeida wrote:
> > > > +        dev: &'a Device<Bound>,
> > > > +        irq: u32,
> > > > +        flags: Flags,
> > > > +        name: &'static CStr,
> > > > +        handler: T,
> > > > +    ) -> impl PinInit<Self, Error> + 'a {
> > > > +        let closure =3D move |slot: *mut Self| {
> > > > +            // SAFETY: The slot passed to pin initializer is valid=
 for writing.
> > > > +            unsafe {
> > > > +                slot.write(Self {
> > > > +                    inner: Devres::new(
> > > > +                        dev,
> > > > +                        RegistrationInner {
> > > > +                            irq,
> > > > +                            cookie: slot.cast(),
> > > > +                        },
> > > > +                        GFP_KERNEL,
> > > > +                    )?,
> > > > +                    handler,
> > > > +                    _pin: PhantomPinned,
> > > > +                })
> > > > +            };
> > > > +
> > > > +            // SAFETY:
> > > > +            // - The callbacks are valid for use with request_irq.
> > > > +            // - If this succeeds, the slot is guaranteed to be va=
lid until the
> > > > +            // destructor of Self runs, which will deregister the =
callbacks
> > > > +            // before the memory location becomes invalid.
> > > > +            let res =3D to_result(unsafe {
> > > > +                bindings::request_irq(
> > > > +                    irq,
> > > > +                    Some(handle_irq_callback::<T>),
> > > > +                    flags.into_inner() as usize,
> > > > +                    name.as_char_ptr(),
> > > > +                    slot.cast(),
> > > > +                )
> > > > +            });
> > > > +
> > > > +            if res.is_err() {
> > > > +                // SAFETY: We are returning an error, so we can de=
stroy the slot.
> > > > +                unsafe { core::ptr::drop_in_place(&raw mut (*slot)=
.handler) };
> > > > +            }
> > > > +
> > > > +            res
> > > > +        };
> > > > +
> > > > +        // SAFETY:
> > > > +        // - if this returns Ok, then every field of `slot` is ful=
ly
> > > > +        // initialized.
> > > > +        // - if this returns an error, then the slot does not need=
 to remain
> > > > +        // valid.
> > > > +        unsafe { pin_init_from_closure(closure) }
> > >
> > > Can't we use try_pin_init!() instead, move request_irq() into the ini=
tializer of
> > > RegistrationInner and initialize inner last?
> >
> > We need a pointer to the entire struct when calling
> > bindings::request_irq. I'm not sure this allows you to easily get one?
> > I don't think using container_of! here is worth it.
>
> Would `try_pin_init!(&this in Self { ...` work?

Ah, could be. If that works, then that's fine with me.

Alice

