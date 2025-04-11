Return-Path: <linux-pci+bounces-25679-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3687A85FF9
	for <lists+linux-pci@lfdr.de>; Fri, 11 Apr 2025 16:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3CEB9A2605
	for <lists+linux-pci@lfdr.de>; Fri, 11 Apr 2025 14:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E11A41F1931;
	Fri, 11 Apr 2025 14:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tXMDgwUf"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDF01F1537
	for <linux-pci@vger.kernel.org>; Fri, 11 Apr 2025 14:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744380251; cv=none; b=qgwM+GtW3m/oGdS9yme/pqbgd9pTkaXRkuR/7yTcoE/2MbKHK/Xbpqxzhz9GacxQbJGVbKq1t4u1Dkb7OYL+Eo7EV83uUvMEj8uXA5J6LZIPc0HGlJvr+UQW9CuYICeJKVwEjy4bG1Ram7vs3sPtLNRj9DgC0KAuQqzvXS/eE/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744380251; c=relaxed/simple;
	bh=Ubbxb2bHjPtTIgxbhNVN9KrZrgvceENegW/Wx+7aLiA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hPm/0p1eSW34wuacJf1WbJa6lIVg0dSBO4lOfueC1pnxodtcqX5eMHYxDMJZ4qwex6Z2Ic4CcjZU5XEZ0DaEa6e0LCJ9A2IGK2HuRybZfO0Jvugs7ldwFhuGCp5WaAVx5zcg7NbM9svqF0fINTL7f48m4Y41HB9wb42gnMLUlGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tXMDgwUf; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43cec5cd73bso14854885e9.3
        for <linux-pci@vger.kernel.org>; Fri, 11 Apr 2025 07:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744380248; x=1744985048; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9NFAq1EfAGe7+mU4CLxqlGsdPDug9rpW5Qn5zNLxhCg=;
        b=tXMDgwUfoPWNF9E55yjFJ1Mj8iaFROohMET7Hp4VnpX0vygX2+ON4jIrOKBAZ7kSf6
         LB7yAKn9Nfq0ZyyrLPbHIF3ueJnrhb+YEKsZqINUOWXDnaMXVI2qup4EKbACGj8pZBih
         8wvxC/4jLC7XGy6JKjy5oZAv55BBT1H2z/CKVKUe+P8m0mbv2VZUwoBaFoUbRywI0gMY
         N8ffhBl0/am0X8cNdGsugweHPCj/toEF8mIBAIQByaU0A75fsBKhhOiRxvlu/z/uk8ej
         3+4/xEhb8rfkgqyB2Yml9/HKSSUrHpjoQUXk0hw93Cb5BGuK/LJyYmWJ/gJq3pDZGXKV
         6nEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744380248; x=1744985048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9NFAq1EfAGe7+mU4CLxqlGsdPDug9rpW5Qn5zNLxhCg=;
        b=e2btHoCIkT6fxT2Lg6XrPecxwaJm1OnQ0ScYX2lPug4HDlAsOsXh3lPHAxXpyCqsqV
         UvpzAGJf+bRbkvKsN+f3n/hsrdLjPs2uDPUN7b98QZLHsT/qWt4wCYtkY3cQoGBOs8qp
         3qFZ6M69pgiazOKkDQ478jktXVSLfGYmfbtSzmvaNCiAfqXW0C1hef+fsoEJOEGqlolv
         Z3TdaJXbsrDn2txNwTzFVH2VKY5YXe7E/XGFB/YTIVKwigRknyTO/td8WpV/8NWLmEwA
         8bW7c0BBUzo1GHwdZSWEo3rpxtQsGbQaWtkbzvHz8yZK066OkEUhLBtgDWS863ghmt7J
         i65g==
X-Forwarded-Encrypted: i=1; AJvYcCUvXZliQX19Kc010mdJL3/9rbzYQ5kO++VUvLEtZ/4bBk0aytjL54tpfgUMUNqnqb1nMkaMzaLiY3w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsNJ20sSC8a6Cu0fi1mFLxb6x0IA3odJpxfO3rp0Wz0SSaMuEX
	Aokw1aZlBMxpj+1UceXKNHeUA/3rs7n5kX7/hbaJ6YcFV3Mmqi/F7QikVQxyZQLrx6Q2p3ismKD
	UWv9YcdcQKYF415mIQLecE946dXh1LKDsGcgY
X-Gm-Gg: ASbGnctpBcSrF/95YpWx7YJQhxrdSUyjQQhCm/S41kVmP3d90D8KLRiqKTaL0/UF1FN
	ef+EzElQmz8yy2m1OdwtibH4SWgR5SDXkQY0Qcj+bQ3SkCjyYWf3G3qBlvk/+J6oMNoIj6GaHhN
	R8fKXAxpsALxAz3z7dNsHg/XA=
X-Google-Smtp-Source: AGHT+IFA1agukbluKMaNAK8/Nzo2zAHxJ+1B9VH4QUSarYItlzRNIQQWZBJ1lw2yIq9o5G3ylfA1vyQ5gZ4J7p9hwUA=
X-Received: by 2002:a05:600c:4f12:b0:43d:24d:bbe2 with SMTP id
 5b1f17b1804b1-43f3a9b02e3mr21068765e9.28.1744380247946; Fri, 11 Apr 2025
 07:04:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409-no-offset-v2-0-dda8e141a909@gmail.com>
 <20250409-no-offset-v2-2-dda8e141a909@gmail.com> <Z_eMe7y0ixrBrHaz@google.com>
 <CAJ-ks9kms_jFEAHX9MnW1pUOyTeuFuyWwXk-A+qhCPQQNfJdAw@mail.gmail.com>
 <Z_jcjEtKZRpRi9Yn@google.com> <CAJ-ks9ka0sASqBdhFSv6Ftbd7p1KCBuy6v-2jNd98gDpyAgQGA@mail.gmail.com>
In-Reply-To: <CAJ-ks9ka0sASqBdhFSv6Ftbd7p1KCBuy6v-2jNd98gDpyAgQGA@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 11 Apr 2025 16:03:55 +0200
X-Gm-Features: ATxdqUG8hC_u__HK8-CW3gNS0gPxgHK6AdZX6UOb7LflknvLRFcPY7MceIw6q8A
Message-ID: <CAH5fLghSWJKDYae+oDsbkQHSWLVyAS6fqGYt7whHWaA6PXox_w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] rust: workqueue: remove HasWork::OFFSET
To: Tamir Duberstein <tamird@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Bjorn Helgaas <bhelgaas@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 11, 2025 at 3:57=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> On Fri, Apr 11, 2025 at 5:10=E2=80=AFAM Alice Ryhl <aliceryhl@google.com>=
 wrote:
> >
> > On Thu, Apr 10, 2025 at 10:15:53AM -0400, Tamir Duberstein wrote:
> > > On Thu, Apr 10, 2025 at 5:16=E2=80=AFAM Alice Ryhl <aliceryhl@google.=
com> wrote:
> > > >
> > > > On Wed, Apr 09, 2025 at 06:03:22AM -0400, Tamir Duberstein wrote:
> > > > > Implement `HasWork::work_container_of` in `impl_has_work!`, narro=
wing
> > > > > the interface of `HasWork` and replacing pointer arithmetic with
> > > > > `container_of!`. Remove the provided implementation of
> > > > > `HasWork::get_work_offset` without replacement; an implementation=
 is
> > > > > already generated in `impl_has_work!`. Remove the `Self: Sized` b=
ound on
> > > > > `HasWork::work_container_of` which was apparently necessary to ac=
cess
> > > > > `OFFSET` as `OFFSET` no longer exists.
> > > > >
> > > > > A similar API change was discussed on the hrtimer series[1].
> > > > >
> > > > > Link: https://lore.kernel.org/all/20250224-hrtimer-v3-v6-12-rc2-v=
9-1-5bd3bf0ce6cc@kernel.org/ [1]
> > > > > Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> > > > > Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> > > > > Tested-by: Alice Ryhl <aliceryhl@google.com>
> > > > > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> > > > > ---
> > > > >  rust/kernel/workqueue.rs | 45 ++++++++++++----------------------=
-----------
> > > > >  1 file changed, 12 insertions(+), 33 deletions(-)
> > > > >
> > > > > diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
> > > > > index f98bd02b838f..1d640dbdc6ad 100644
> > > > > --- a/rust/kernel/workqueue.rs
> > > > > +++ b/rust/kernel/workqueue.rs
> > > > > @@ -429,51 +429,23 @@ pub unsafe fn raw_get(ptr: *const Self) -> =
*mut bindings::work_struct {
> > > > >  ///
> > > > >  /// # Safety
> > > > >  ///
> > > > > -/// The [`OFFSET`] constant must be the offset of a field in `Se=
lf` of type [`Work<T, ID>`]. The
> > > > > -/// methods on this trait must have exactly the behavior that th=
e definitions given below have.
> > > > > +/// The methods on this trait must have exactly the behavior tha=
t the definitions given below have.
> > > >
> > > > This wording probably needs to be rephrased. You got rid of the
> > > > definitions that sentence refers to.
> > >
> > > I don't follow. What definitions was it referring to? I interpreted i=
t
> > > as having referred to all the items: constants *and* methods.
> >
> > I meant for it to refer to the default implementations of the methods.
> >
> > > Could you propose an alternate phrasing?
> >
> > I guess the requirements are something along the lines of raw_get_work
> > must return a value pointer, and it must roundtrip with
> > raw_container_of.
>
> What is a value pointer?

Sorry, I meant "valid".

