Return-Path: <linux-pci+bounces-24654-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D15DA6EDF0
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 11:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A19941682B8
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 10:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA26254869;
	Tue, 25 Mar 2025 10:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GkWCOgPD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC4D1C84A7;
	Tue, 25 Mar 2025 10:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742899388; cv=none; b=VjhWJx7BIgCVzRcqZXZCdO3eRcyoYTSywWaLrPuqOSOYqYj0fxaQQDij/CE3ioZKuMbF6TZfPlqW4u7KAgOjlgwSLkjUcUJImMrOKO/nr/OG+z/BAQvVFHmZWieFxI9wiyy44yDmDJS99l2Z0GlZH48JdM2OKzjzPSYB7BkoKB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742899388; c=relaxed/simple;
	bh=/c3CjXG1Swyt/wD6IMBpN2c7HTr+1ZT0GUM20XgTU2E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h2IugkYdkm97S7FfXUpAgKQau6CeNISHRTONbPdk0ItYugUjomcCZb3v11r+/kDBiX6NtFM1iVfBGEP71xz6p2+y64bzYRQMTL9HfRbIrjXxqLJuy4kfyButQaLJPV7+8qKd90ZqdrE7rV6QETnCHFSdAnxur26eMRp5+Y9V4RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GkWCOgPD; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5493b5bc6e8so5697708e87.2;
        Tue, 25 Mar 2025 03:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742899385; x=1743504185; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G8Sshxxvwc2uBLvUYSBC6XZDdk/tekBp/ZA9yuvM01Q=;
        b=GkWCOgPDSFIvxHaPJokH216X+AGzEM9E7HVbJNgKetvVMTTCb9n2T7rTU2X1JIjviQ
         t9v8gaGCBHskN1iLpeWvBLLesQ+sA+Y0nwetXy9nG8V4VyE4opmt3Ld/VFQ231phOF1w
         L/TQGcYk5umhdSMDoyaTxBjL55Y8fud2cQnYCaFq2a4ugNxEfBAoAGKa0HHnfrkzjOFl
         VM6rtimg9SZTh6H7N35aP3FRkHICtKQ75PbD4G1n9IAklt4tgAJ+drNsZn6XGgZo6Ltn
         hybUvDnw8RHpJXvPrRT2x6IPiZIW6Y+96AH7MXxgHATnl35Uoj4EqJjF/kXPmrXL4tJ+
         t5Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742899385; x=1743504185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G8Sshxxvwc2uBLvUYSBC6XZDdk/tekBp/ZA9yuvM01Q=;
        b=vyiVXtK+KiD6NIh86/zoDAqPYSZKkm9pZtoKLklbWT7wEoKGsb+y9Et6wzKKA6bh+f
         dK+PdjpBGxNNJmULe7NqqQ5wiGjLOpRjniTGTjOUwv9TlxZN3LODFts1lkgjThML8xll
         n0VO5k5anwGTDXM530WdNHL8bxhULOk1eCQvWkyEk8CUI2DepSL0gfqXNCPwr310Y7n1
         gM/Zh51yt+QUX1FJ5gyCfRXy9f6SYbjJGHxtG3JKwNG3ykQv51Jydb1P1UAoJUsenVs4
         OGezIs7HdfhTate2VlTUkX2osRCma1pv1F+gasKOfdmCtmhZLSHFmwLO7ZYv/39JlozT
         Vo0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUsaZTGW+2Sn8CxHn35R2gX8/1ew/35+wL65NGCZowABZOY/to9jake8MDnrPyYTuxCo07p8lzs29pFCNYM40Y=@vger.kernel.org, AJvYcCV7I19XV4XwP7KsyiEfftPnb6d3yd+6Hy5LNmlGEMZXIOA9wHwBLe0nODIgogHlh0jGxxLNiAcK6Smk@vger.kernel.org, AJvYcCXKR1j18rRPC1K4w0dlXU3BLVqJH486d3J1M/ln6mnB5zhGS2R4rxcW+30alCnaOMhVwC5NeTBkHXYxRcY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7wjlHETfU59r8QrFwKbIvqoZUBRtA3iCzYDOi+6DvUwb4ogSK
	E3OdDQnXQ3+B3VA5AalQRdTPXBsfOaoQY2aJ2m6VuvkNl3B7IVwC/JWuaF6Y9+JxEbqmAtjibeQ
	+1BTf5T6vc42Ngs4kfY6Yt22r2/Y=
X-Gm-Gg: ASbGncue543+nQb+SHKt1s69jeldJ4P3uteCyFSn7zFbwN4pRrmaoF2fqV9PnqLoWar
	8KsL51iAuz/EYJ6EMmjKLPIiGUCPcRyhFULu4UAOGl/nRjA2CquHtlrc5FQknqh3qr3HlsUy9mP
	+CXiZxHOql29uWUppv9s4dWOHBQREI8wKkV2Yi56NNHyLVipRmXORF7R6tpYQ=
X-Google-Smtp-Source: AGHT+IGzzB3CZY+eFUxwaYk3A0Y61jWXkplYq/KLhvIEpW+nxXkKlOGV+SrMXaeb83oUKr8wcRsBmXk8kZsF8sxCWVg=
X-Received: by 2002:a05:6512:3e23:b0:545:22ec:8b6c with SMTP id
 2adb3069b0e04-54ad64b311cmr6004267e87.35.1742899384720; Tue, 25 Mar 2025
 03:43:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250324-list-no-offset-v1-0-afd2b7fc442a@gmail.com>
 <20250324-list-no-offset-v1-3-afd2b7fc442a@gmail.com> <67e1d1b3.050a0220.4c4ff.6e89@mx.google.com>
 <CAJ-ks9moCO83cGkKuONR-2JMN61x18T2UVO98jhspDR=uyaVqw@mail.gmail.com>
 <CAJ-ks9kPhb00-Dv8KucYGOVjLFMVYvfpBnqrV87M+eJmODAmyw@mail.gmail.com>
 <Z-Iq6Okk1j3ImH1u@Mac.home> <CAJ-ks9n66_vVg3ww58VqfXV6+phng8Bhq9C=NNn854gXK0KAHg@mail.gmail.com>
 <D8PA5CKNMCGA.UODS331S36EG@proton.me>
In-Reply-To: <D8PA5CKNMCGA.UODS331S36EG@proton.me>
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 25 Mar 2025 06:42:28 -0400
X-Gm-Features: AQ5f1JpUWGdrl0VmBVTq2r6QOrcMyS5cb4ylDEIRr4yLL9rMhb12hHtyHw30R4Y
Message-ID: <CAJ-ks9kOFk2GGwjX_Eo7Kuxoh5eziGSKRpLE8oVjEs7pRnWyRw@mail.gmail.com>
Subject: Re: [PATCH 3/5] rust: list: use consistent type parameter names
To: Benno Lossin <benno.lossin@proton.me>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025 at 6:37=E2=80=AFAM Benno Lossin <benno.lossin@proton.m=
e> wrote:
>
> On Tue Mar 25, 2025 at 10:52 AM CET, Tamir Duberstein wrote:
> > On Tue, Mar 25, 2025 at 12:02=E2=80=AFAM Boqun Feng <boqun.feng@gmail.c=
om> wrote:
> >> On Mon, Mar 24, 2025 at 05:56:57PM -0400, Tamir Duberstein wrote:
> >> > On Mon, Mar 24, 2025 at 5:51=E2=80=AFPM Tamir Duberstein <tamird@gma=
il.com> wrote:
> >> > > On Mon, Mar 24, 2025 at 5:42=E2=80=AFPM Boqun Feng <boqun.feng@gma=
il.com> wrote:
> >> > > > On Mon, Mar 24, 2025 at 05:33:45PM -0400, Tamir Duberstein wrote=
:
> >> > > > >              #[inline]
> >> > > > > @@ -81,16 +81,16 @@ pub unsafe trait HasSelfPtr<T: ?Sized, con=
st ID: u64 =3D 0>
> >> > > > >  /// Implements the [`HasListLinks`] and [`HasSelfPtr`] traits=
 for the given type.
> >> > > > >  #[macro_export]
> >> > > > >  macro_rules! impl_has_list_links_self_ptr {
> >> > > > > -    ($(impl$({$($implarg:tt)*})?
> >> > > > > +    ($(impl$({$($generics:tt)*})?
> >> > > >
> >> > > > While you're at it, can you also change this to be
> >> > > >
> >> > > >         ($(impl$(<$($generics:tt)*>)?
> >> > > >
> >> > > > ?
> >> > > >
> >> > > > I don't know why we chose <> for impl_has_list_links, but {} for
> >> > > > impl_has_list_links_self_ptr ;-)
> >> > >
> >> > > This doesn't work in all cases:
> >> > >
> >> > > error: local ambiguity when calling macro `impl_has_work`: multipl=
e
> >> > > parsing options: built-in NTs tt ('generics') or 1 other option.
> >> > >    --> ../rust/kernel/workqueue.rs:522:11
> >> > >     |
> >> > > 522 |     impl<T> HasWork<Self> for ClosureWork<T> { self.work }
> >> > >
> >> > > The reason that `impl_has_list_links` uses <> and all others use {=
} is
> >> > > that `impl_has_list_links` is the only one that captures the gener=
ic
> >> > > parameter as an `ident`, the rest use `tt`. So we could change
> >>
> >> Why impl_has_list_links uses generics at `ident` but rest use `tt`? I'=
m
> >> a bit curious.
> >
> > I think it's because `ident` cannot deal with lifetimes or const
> > generics - or at least I was not able to make it work with them.
>
> If you use `ident`, you can use the normal `<>` as the delimiters of
> generics. For `tt`, you have to use `{}` (or `()`/`[]`).

Yes I know. But with `ident` you cannot capture lifetimes or const generics=
.

