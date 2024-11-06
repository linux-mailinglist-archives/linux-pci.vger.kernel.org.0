Return-Path: <linux-pci+bounces-16182-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B00349BFA57
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 00:45:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E26E51C22381
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 23:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B45A1DE4C7;
	Wed,  6 Nov 2024 23:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="cTT8TQfj"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746E61D966A;
	Wed,  6 Nov 2024 23:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730936724; cv=pass; b=Uauh3+XaJpJd72NhRdR4poz5Y3GD3O7QwzuLJ5J+7J15Ej637oqRFBm0qDff5VG0FnhesuY+L1kmtJjYRqjXf+I2BDwrUToJszvUtzMbTDfTSo3cnqP+UlZk2RO0pHojsv2G8sfW/dL7oY1Vu3RdM4hne4lWMh/vSSWY8fzlgjk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730936724; c=relaxed/simple;
	bh=w9RBdGBrQqRvP4QVYXJHPuVD77PpiUcpzIMOVebp6nc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=bNBKlThnjCcfs7Wz8afDAV4W0HIFj08nVMG4aXpHPU8wbZoevv+jWTV5k5JHX0rzDyZIBtQ1UOABH4i0i/+qahVXbYqs3opL+1FzUmOFXTY34bVsXFNCj7hTfx06I+Vyff6lL4O24KYSVXM5HByCIWifGuBcrpgbhMxsCxjp7qs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=cTT8TQfj; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1730936695; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=R6HMMUHtc1LGPVEXrD5PNCVUxuA7BNkb7qJL3b0pLjLv8KPrIoadLVYSoabQ3Z+dYr67mzJPDqk/klYxmCyN1pZjEL4TFpbrIa/ruLX0WAV5YTwj4qgQXrVd1NZP9xJ/sg3VtgwMoaE2n2XRNUbiyFJfhoPtoeSxNv7H4Xsf8c8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1730936695; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=w9RBdGBrQqRvP4QVYXJHPuVD77PpiUcpzIMOVebp6nc=; 
	b=RXsjqdDFZQ9QelySvS1PT8h+kkEyaqZOHzHv477RVO68k+djASH4mQZcOoGs4jU7GagDjlOuSd/TDOH6AgQ0wSgDtC60AmAog+s3Ux5EmBnHhhCPpkU3CNN47P9ocdI2umln9L1hWbpG9cqA8CiSj2cAoJ/K2xa2WHvbG58n/nc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1730936695;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=w9RBdGBrQqRvP4QVYXJHPuVD77PpiUcpzIMOVebp6nc=;
	b=cTT8TQfjqYSX70R+jyXBXf3BreIvqkS/bPYdo1zcpQqYXavSLEcTWfuKhcb/sFB/
	c9+YbkfqcF5ndTea00wwVd7HXbcGw7u9YZr3XhaKwno6pflglCl+Kr+3fHn9/GkfQ6x
	IfqTxL1p3uzUoEE0DKAu4CHGUxwEeNcfWMmQdFfU=
Received: by mx.zohomail.com with SMTPS id 1730936692453913.7917799009244;
	Wed, 6 Nov 2024 15:44:52 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.200.121\))
Subject: Re: [PATCH v3 09/16] rust: add `io::Io` base type
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <CAH5fLgjC5Rcq5VJbEFSVP_rE0xjj8CGdqxZexhPVsGcTZ+85HA@mail.gmail.com>
Date: Wed, 6 Nov 2024 20:44:35 -0300
Cc: Danilo Krummrich <dakr@kernel.org>,
 gregkh@linuxfoundation.org,
 rafael@kernel.org,
 bhelgaas@google.com,
 ojeda@kernel.org,
 alex.gaynor@gmail.com,
 boqun.feng@gmail.com,
 gary@garyguo.net,
 bjorn3_gh@protonmail.com,
 benno.lossin@proton.me,
 tmgross@umich.edu,
 a.hindborg@samsung.com,
 airlied@gmail.com,
 fujita.tomonori@gmail.com,
 lina@asahilina.net,
 pstanner@redhat.com,
 ajanulgu@redhat.com,
 lyude@redhat.com,
 robh@kernel.org,
 saravanak@google.com,
 rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <A309C141-E390-44C1-A2B7-A7A9CDB132D7@collabora.com>
References: <20241022213221.2383-1-dakr@kernel.org>
 <20241022213221.2383-10-dakr@kernel.org>
 <CAH5fLggFD7pq0WCfMPYTZcFkvrXajPbxTBtkvSeh-N2isT1Ryw@mail.gmail.com>
 <ZyCo9SRP4aFZ6KsZ@pollux>
 <CAH5fLgjC5Rcq5VJbEFSVP_rE0xjj8CGdqxZexhPVsGcTZ+85HA@mail.gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
X-Mailer: Apple Mail (2.3826.200.121)
X-ZohoMailClient: External

Sorry, I didn=E2=80=99t see this:

> On 29 Oct 2024, at 07:18, Alice Ryhl <aliceryhl@google.com> wrote:
>=20
> What you're doing now is a bit awkward to use. You have to make sure
> that it never escapes the struct it's created for, so e.g. you can't
> give out a mutable reference as the user could otherwise `mem::swap`
> it with another Io. Similarly, the Io can never be in a public field.
> Your safety comment on Io::new really needs to say something like
> "while this struct exists, the `addr` must be a valid I/O region",
> since I assume such regions are not valid forever? Similarly if we

Io is meant to be a private member within a wrapper type that actually
acquires the underlying I/O region, like `pci::Bar` or =
`Platform::IoMem`.

Doesn=E2=80=99t that fix the above?

> look at [1], the I/O region actually gets unmapped *before* the Io is
> destroyed since IoMem::drop runs before the fields of IoMem are
> destroyed, so you really need something like "until the last use of
> this Io" and not "until this Io is destroyed" in the safety comment.
>=20
> If you compare similar cases in Rust, then they also do what I
> suggested. For example, Vec<T> holds a raw pointer, and it uses unsafe
> to assert that it's valid on each use of the raw pointer - it does not
> create e.g. an `&'static mut [T]` to hold in a field of the Vec<T>.
> Having an IoRaw<S> and an Io<'a, S> corresponds to what Vec<T> does
> with IoRaw being like NonNull<T> and Io<'a, S> being like &'a T.
>=20
> [1]: =
https://lore.kernel.org/all/20241024-topic-panthor-rs-platform_io_support-=
v1-1-3d1addd96e30@collabora.com/

What I was trying to say in my last message is that the wrapper type, =
i.e.:
IoMem and so on, should not have a lifetime parameter, but IIUC this is =
not
what you=E2=80=99re suggesting here, right?

=E2=80=94 Daniel=

