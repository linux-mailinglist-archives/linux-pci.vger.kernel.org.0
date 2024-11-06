Return-Path: <linux-pci+bounces-16180-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2F49BFA33
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 00:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 911031F22BC6
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 23:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D283220F5A6;
	Wed,  6 Nov 2024 23:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="c23dkm1D"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D14220E303;
	Wed,  6 Nov 2024 23:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730935960; cv=pass; b=TXnkgze0Q9EgLfdlXIEQJU545XiGJZKUloB/MVPIDyxbn4Gb9fASYVtoIBzMSKvJhHtvBC8Rtr7RCwTc6ASn9OshZbS8z7m8rHw3FYVNo4UMmYcLkcEMG08zujo+fjakQYQlEQhaOUcmoq8XBLzqAWtor1D038Ewc8P0B1OjEVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730935960; c=relaxed/simple;
	bh=KIJ3PZEYHZzSKqlk7pSylcibSpSuclteWz3lwPm7zJA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=NTBS+erHzVQrB0IYFIGBTUfIZHijD0uI4xaUAmHsRJjZ/QSWAdlSoza3bHCdYvCI3dd2NHCrKN0KaGyevoUdb36uefnqQ28TR1xoeOLEh64dIIy4al2sfO37XNRq9Vkn8PGooN+5BvngHUJh6qQ3akkDeT4qUMSVSNkNtrwFHkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=c23dkm1D; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1730935925; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=gIxp/k1/AT16DGs/9OuFQuqu4DZfyvzhzu8KIzsQ2ux4cdYB50FV+qfI9PFTR721KkXAQCIQVHWZSuP4dpUeUfphIMZysakBuXIA7pgKJFy1SSnKUasH4f2o/drfXP8KxrN68c2m5qlQFgnd1EmpDVU2Ht/3XNgkYvjqp1KHUv0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1730935925; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=yFsTqCsvyoWKOmvFZ59RIJPhJzOGv5NnUYCSCIgnK6c=; 
	b=KZ8iOWcQHZyUTVZOiIGhvDY9cEdr+DKIHqKMDXlllv6YOaUF0GRMIaAInOvmRT8N+pUh4i4RAnovlbu357vWGulWhPpKi7TdHXX6Bg8eT8pqkTzLeY+5s62v8Z5O/WFtFHgElDbmGuPWQDu60RXa8eFeIK6uSJWG7DNuIIrmr/M=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1730935925;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=yFsTqCsvyoWKOmvFZ59RIJPhJzOGv5NnUYCSCIgnK6c=;
	b=c23dkm1Dw2W5xTizFmk+vWd2IEtJdCM1bZGoA6ugcd3JTE/KPLx2iwJB461yQWIL
	jGo/K/uZNevCCqQUrMj7O9ZpcGaQfwWE/0ibbbImgWiQQtz7m9L9YtJUFxDLTiwaZjQ
	EHN3SvmljdMW7y23egyEzh42cs5U9Qc2cQ5fC8HQ=
Received: by mx.zohomail.com with SMTPS id 1730935922326552.8283967488513;
	Wed, 6 Nov 2024 15:32:02 -0800 (PST)
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
In-Reply-To: <CAH5fLggFD7pq0WCfMPYTZcFkvrXajPbxTBtkvSeh-N2isT1Ryw@mail.gmail.com>
Date: Wed, 6 Nov 2024 20:31:44 -0300
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
Message-Id: <04E0C753-9D96-4D99-992E-63E36C0F1904@collabora.com>
References: <20241022213221.2383-1-dakr@kernel.org>
 <20241022213221.2383-10-dakr@kernel.org>
 <CAH5fLggFD7pq0WCfMPYTZcFkvrXajPbxTBtkvSeh-N2isT1Ryw@mail.gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
X-Mailer: Apple Mail (2.3826.200.121)
X-ZohoMailClient: External

Hi,

> On 28 Oct 2024, at 12:43, Alice Ryhl <aliceryhl@google.com> wrote:
>=20
> On Tue, Oct 22, 2024 at 11:33=E2=80=AFPM Danilo Krummrich =
<dakr@kernel.org> wrote:
>>=20
>> I/O memory is typically either mapped through direct calls to =
ioremap()
>> or subsystem / bus specific ones such as pci_iomap().
>>=20
>> Even though subsystem / bus specific functions to map I/O memory are
>> based on ioremap() / iounmap() it is not desirable to re-implement =
them
>> in Rust.
>>=20
>> Instead, implement a base type for I/O mapped memory, which =
generically
>> provides the corresponding accessors, such as `Io::readb` or
>> `Io:try_readb`.
>>=20
>> `Io` supports an optional const generic, such that a driver can =
indicate
>> the minimal expected and required size of the mapping at compile =
time.
>> Correspondingly, calls to the 'non-try' accessors, support compile =
time
>> checks of the I/O memory offset to read / write, while the 'try'
>> accessors, provide boundary checks on runtime.
>=20
> And using zero works because the user then statically knows that zero
> bytes are available ... ?
>=20
>> `Io` is meant to be embedded into a structure (e.g. pci::Bar or
>> io::IoMem) which creates the actual I/O memory mapping and =
initializes
>> `Io` accordingly.
>>=20
>> To ensure that I/O mapped memory can't out-live the device it may be
>> bound to, subsystems should embedd the corresponding I/O memory type
>> (e.g. pci::Bar) into a `Devres` container, such that it gets revoked
>> once the device is unbound.
>=20
> I wonder if `Io` should be a reference type instead. That is:
>=20
> struct Io<'a, const SIZE: usize> {
>    addr: usize,
>    maxsize: usize,
>    _lifetime: PhantomData<&'a ()>,
> }
>=20
> and then the constructor requires "addr must be valid I/O mapped
> memory for maxsize bytes for the duration of 'a". And instead of
> embedding it in another struct, the other struct creates an `Io` on
> each access?

Please let=E2=80=99s not add a lifetime here. Drivers will usually have =
this mapped
at probe time and it will usually remain mapped until remove(), so I =
think this
works fine the way it is.

>=20
>> Co-developed-by: Philipp Stanner <pstanner@redhat.com>
>> Signed-off-by: Philipp Stanner <pstanner@redhat.com>
>> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
>=20
> [...]
>=20
>> diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
>> new file mode 100644
>> index 000000000000..750af938f83e
>> --- /dev/null
>> +++ b/rust/kernel/io.rs
>> @@ -0,0 +1,234 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +//! Memory-mapped IO.
>> +//!
>> +//! C header: =
[`include/asm-generic/io.h`](srctree/include/asm-generic/io.h)
>> +
>> +use crate::error::{code::EINVAL, Result};
>> +use crate::{bindings, build_assert};
>> +
>> +/// IO-mapped memory, starting at the base address @addr and =
spanning @maxlen bytes.
>> +///
>> +/// The creator (usually a subsystem / bus such as PCI) is =
responsible for creating the
>> +/// mapping, performing an additional region request etc.
>> +///
>> +/// # Invariant
>> +///
>> +/// `addr` is the start and `maxsize` the length of valid I/O mapped =
memory region of size
>> +/// `maxsize`.
>=20
> Do you not also need an invariant that `SIZE <=3D maxsize`?
>=20
> Alice



