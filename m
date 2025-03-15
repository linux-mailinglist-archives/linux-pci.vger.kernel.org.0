Return-Path: <linux-pci+bounces-23847-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDAB6A630CB
	for <lists+linux-pci@lfdr.de>; Sat, 15 Mar 2025 18:31:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A08401897149
	for <lists+linux-pci@lfdr.de>; Sat, 15 Mar 2025 17:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 461A22045A0;
	Sat, 15 Mar 2025 17:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WlL1aS2/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB874A06;
	Sat, 15 Mar 2025 17:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742059908; cv=none; b=sljsO61C/EnjVUwwj1Ix/RxWUKu+hVtIZmlk/PJ38cl1MiH5fBAkVnhbxoQ0FUugBZC7WILvGn4VPUfmO1Ukj9jtmSDYwPQx2mAYU1zXQ0u9rJOofRt/7zhvWpRC7vppeAXMGpdzI38NypA79u05jYFQ7/Uq3SD/wE7oJ08pHX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742059908; c=relaxed/simple;
	bh=8tcoUL902QFT5ZU4stKypQOleAO7xUF1yXjGPSxqvhM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WtEZfwaeWUqkxPgDXTg5BQhmDjB0CDqY52zTvKgsNKSKacveYhwC94xW0Fd+JYqan82eVr7MZnB0S5QCSo9cM0XtwpvhbGfkXeb/ZnsSnu68DvCdX/p3vkZMlxoiXX/o2TA1d/1im33l3j0Bf4NCPvLoFPhhWtH67D1D/JjhHsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WlL1aS2/; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-30761be8fcfso34554911fa.0;
        Sat, 15 Mar 2025 10:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742059904; x=1742664704; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Orv6YEosr3AYZhDZSWaMjOw3nf0XdOGhhUKMHwOlli8=;
        b=WlL1aS2/3Z+im3Z11lWp8Q17tcNV7Nn/CZmHvsNYa4n/xkykedpo3FFQwrByFJu1p9
         g/gLr1qODEfLV3dposrLKI1/0MbVAesNKGdsWy0ToLly2DBVFNIP3Lb3+9rmRGFyBKen
         DLj3wsnDzfpmTKT0xUX9TjCx8wNiNjSkQJSHmFq8LDCRY8Rc+HbQFrNbsq2dM2KAJnTG
         1+1v2xoPJWEIZ54nzf4wl9GPhpxDdvrQ2AqczwzYfLfBtcDUcT48LpnFVwDYJh35JF3V
         x7ZW+tgeVA6MvXPbcUfWzjleOOFZZ8QpLcvC+NPTKX/WpRl30jh4YPdqZGHP6cglhTbz
         PPjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742059904; x=1742664704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Orv6YEosr3AYZhDZSWaMjOw3nf0XdOGhhUKMHwOlli8=;
        b=M+5cBH1M1bRGeSgxpM8KS2nyHIE/YVcLhKfyy/llk/yN9Ev0HGm5zU1ZrwIEoFolNl
         kQO4JdDNfRb14z/3UxMirOZWInY7S4wlRWhOC2pwJKuHr6iq7IlBSyWkmi6nbCFTFPVU
         bEl+0k9b7SMA+bMsSzRA9EDzuYHdvR6ZpFArySxMvDeSmdp28x9xZI2G5fM8vzahA4KP
         za+DogtoXjaRoGQWCA3NePscmY/7cL95fo9z0R2zrig4P0B8GDd41GfR+DSHLpeHV365
         o3/g+Q6Xp2vxo8A9VygjiWFSucv2WRo+x8zLwEtNiSknj/Ln1HN6Pl2xJvFAnWfNUF7f
         LigQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTyB6ms1JFZTlBeb8vFOaG96AEEPOFvXN95sdHnHJM6A1v9u6MJIw+UDQPC2SbFVaajwy9NB6bKJ/C7oqg@vger.kernel.org, AJvYcCVpLkXMLxLOqkB7CA0BSmmhrf5Sybg9UMT1fSBBsvRwx4ZT2pNzcSz/eHPK9Mpe83CApec+7Ni+qGkC@vger.kernel.org, AJvYcCWf3AJHjapYMeQ+02orfv8FnEoES88Qa613+sTjGclxhWEbTDxlHM5zDadjJyb7whH4G2iM@vger.kernel.org, AJvYcCXfoYZptthx9+OL6JYI2B59ZcdQDDYR3J+P2saMspzNQc/bu87PJYF1Ety3HHQAJFV/1j6AgwrZCi6n7dNONRw=@vger.kernel.org, AJvYcCXpXf0yKxH70tTRRMJPsm7d4ZKaowYyiUJYLEYLpdvWeqKxFzQAqRExT/ScvW9oZIVpmkBzygIhFybd@vger.kernel.org
X-Gm-Message-State: AOJu0YwxTCtHcBSvD8tT9M/VWC/rmfTQr/dhYiPy5zDC1t+60ZVi3LvC
	ayuJRvGSX4QBZML0L8rPieoc4uNVKLyqoHucfPr1I/5sMS7mCloVhSvVk296EmfcFJK/3/5BRX8
	ZaIHuBvOlBGyP3x0LDU9xTHVFmrw=
X-Gm-Gg: ASbGncv/Wo5hzs68eucb4Fhvf8tNKvr7MV/1PX67eGKRIj9IuwX4J2CeJ2RlRPkrfey
	u7fRSD+Bxwa8mBJJkgjIkznPYtyYOAMiMa2suwwiFJ8IxwgzyRgTCG6PrMKRBOjdc0YpgFguB3A
	VfvUymHYhMtAfr3O/F6nk4dlSZYUpVARtaKnLz2sl9VyrNWXa0OKas1CT3YpfX
X-Google-Smtp-Source: AGHT+IEb0Cej4ABZBlp0purrTkZq2uroGZ83nzzW9Ef8zA8wIcZNdCr8wuQavsc3pt2rTRmaGANVPLtpRHigWqs4HI0=
X-Received: by 2002:a05:651c:1541:b0:30b:efa5:69a2 with SMTP id
 38308e7fff4ca-30c4a876bd6mr24351061fa.19.1742059904122; Sat, 15 Mar 2025
 10:31:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241219170425.12036-1-dakr@kernel.org> <20241219170425.12036-4-dakr@kernel.org>
 <CAJ-ks9nnQU4ryR1mbaWqNqcH+b=-s8Y0xKxTF-TQvfNGsWO7+w@mail.gmail.com> <Z9Wx53fSQw39nHpx@pollux>
In-Reply-To: <Z9Wx53fSQw39nHpx@pollux>
From: Tamir Duberstein <tamird@gmail.com>
Date: Sat, 15 Mar 2025 13:31:07 -0400
X-Gm-Features: AQ5f1JpkLN1T1jVY6VYw9mpuL87fUuUWklFGBf2j7crPWlF-zdPyfsXFJtHjK48
Message-ID: <CAJ-ks9kodrpkG=CE7BCGaHZDv6YfSpEUAWTM=NhyEp0hSNi4TQ@mail.gmail.com>
Subject: Re: [PATCH v7 03/16] rust: implement `IdArray`, `IdTable` and `RawDeviceId`
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com, 
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me, 
	tmgross@umich.edu, a.hindborg@samsung.com, aliceryhl@google.com, 
	airlied@gmail.com, fujita.tomonori@gmail.com, lina@asahilina.net, 
	pstanner@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, robh@kernel.org, 
	daniel.almeida@collabora.com, saravanak@google.com, dirk.behme@de.bosch.com, 
	j@jannau.net, fabien.parent@linaro.org, chrisi.schrefl@gmail.com, 
	paulmck@kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, rcu@vger.kernel.org, 
	Wedson Almeida Filho <wedsonaf@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 15, 2025 at 12:59=E2=80=AFPM Danilo Krummrich <dakr@kernel.org>=
 wrote:
>
> On Sat, Mar 15, 2025 at 12:52:27PM -0400, Tamir Duberstein wrote:
> > On Thu, Dec 19, 2024 at 12:08=E2=80=AFPM Danilo Krummrich <dakr@kernel.=
org> wrote:
> > >
> > > +/// Marker trait to indicate a Rust device ID type represents a corr=
esponding C device ID type.
> > > +///
> > > +/// This is meant to be implemented by buses/subsystems so that they=
 can use [`IdTable`] to
> > > +/// guarantee (at compile-time) zero-termination of device id tables=
 provided by drivers.
> > > +///
> > > +/// # Safety
> > > +///
> > > +/// Implementers must ensure that:
> > > +///   - `Self` is layout-compatible with [`RawDeviceId::RawType`]; i=
.e. it's safe to transmute to
> > > +///     `RawDeviceId`.
> > > +///
> > > +///     This requirement is needed so `IdArray::new` can convert `Se=
lf` to `RawType` when building
> > > +///     the ID table.
> > > +///
> > > +///     Ideally, this should be achieved using a const function that=
 does conversion instead of
> > > +///     transmute; however, const trait functions relies on `const_t=
rait_impl` unstable feature,
> > > +///     which is broken/gone in Rust 1.73.
> > > +///
> > > +///   - `DRIVER_DATA_OFFSET` is the offset of context/data field of =
the device ID (usually named
> > > +///     `driver_data`) of the device ID, the field is suitable sized=
 to write a `usize` value.
> > > +///
> > > +///     Similar to the previous requirement, the data should ideally=
 be added during `Self` to
> > > +///     `RawType` conversion, but there's currently no way to do it =
when using traits in const.
> > > +pub unsafe trait RawDeviceId {
> > > +    /// The raw type that holds the device id.
> > > +    ///
> > > +    /// Id tables created from [`Self`] are going to hold this type =
in its zero-terminated array.
> > > +    type RawType: Copy;
> > > +
> > > +    /// The offset to the context/data field.
> > > +    const DRIVER_DATA_OFFSET: usize;
> > > +
> > > +    /// The index stored at `DRIVER_DATA_OFFSET` of the implementor =
of the [`RawDeviceId`] trait.
> > > +    fn index(&self) -> usize;
> > > +}
> >
> > Very late to the game here, but have a question about the use of
> > OFFSET here. Why is this preferred to a method that returns a pointer
> > to the field?
>
> We need it from const context, trait methods can't be const (yet).

Thanks for explaining!

