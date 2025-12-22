Return-Path: <linux-pci+bounces-43528-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 530DDCD65C8
	for <lists+linux-pci@lfdr.de>; Mon, 22 Dec 2025 15:25:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C491530019FC
	for <lists+linux-pci@lfdr.de>; Mon, 22 Dec 2025 14:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A942E11BC;
	Mon, 22 Dec 2025 14:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="lAa/34gb"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83CF126BF7;
	Mon, 22 Dec 2025 14:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766413504; cv=pass; b=unR+aSmTZThfrQXd69GA21T+7V3QuxQWgvp6uk126Xird3LcHB/SIW+RIzgZKYQmNgetQFtiT1nahxjr8Fi5Mi+rQUuOYE1qd/P+9BMuRZMQzmwQBL6ODmqA8Egf0T13XeJ1E7OUtmb9SepsFR6vviZBAavA8SMar1mvKW8zbQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766413504; c=relaxed/simple;
	bh=lZJ1CsWiWlxFy5deTa0BEB/sB84cGCyxD7hVe3tJILY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=t66mluAEfffDEB3DmhPOA36D55Ukcn1+xGAAnkYEf9Qftr068LrjcQyjkxiHO201pTdobtvLN/gt7e6R5LKA966vpC5fXQdiEwXKgPmTU1As51x5ug5FxWMo+vY6QSNzxcTwOIAL8nDEEthfMMrtt3CfjJ/2Tf+BDzlczi6LUd0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=lAa/34gb; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1766413488; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Upv+pFyyge9zEZ8CbwQDgoJrCDaPbztIZfmzzuQ6AsAql/55I7jBQNHngKqpSgrqFIVmokQPZjCDZHxa0jF9LcqT8EaFRtfieVzyFKni/3GC9bLodSMDRQ2Mkw2NWaIHwUfnNbswKaYceWoxwjAO/4M2enP+6Xb5GDuVt/5y6d4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1766413488; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=jkSEfADmY/sYGBOwA2dHiEqElzURY2SJAgCkJHTnIMY=; 
	b=At1jaOu1G7QVh4dJxg076XhtR1Py5x89aT6MIp2plhLhaCCNo6r4wEP57v8bv/Jl5z+HKg8yogr5JjOp0uwrBi7Rt/gDBnGiSQV6+MhDUI9KtjiE27n0Bj82gfL50Z3vbnJHiHn4L867UDUmdCB8VrcSFlrbHXS1PywHkBDR+Kg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1766413488;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=jkSEfADmY/sYGBOwA2dHiEqElzURY2SJAgCkJHTnIMY=;
	b=lAa/34gb+Q2DIvEPUAVO4SSpY17B41qqVDc2sPouqCaMvK2ByYPVI120Wa//qBay
	HIwFiGXLlCAiK0RFCksE1bVB5X32tkR81Ze1wcGUrEsWn9K5AfmQQCEttHNrM7q5yKJ
	jM8krL6Osq4Ki5QLPqxCATUk13pkh8T6iUPFKx1g=
Received: by mx.zohomail.com with SMTPS id 1766413484977120.80932932299095;
	Mon, 22 Dec 2025 06:24:44 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH] samples: rust: pci: replace `kernel::c_str!` with
 C-Strings
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20251222-cstr-pci-v1-1-a0397c61bbe4@gmail.com>
Date: Mon, 22 Dec 2025 11:24:27 -0300
Cc: Danilo Krummrich <dakr@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 =?utf-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 linux-pci@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Tamir Duberstein <tamird@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6D6C7BE4-164A-4E0A-A979-00EBB1F9C75A@collabora.com>
References: <20251222-cstr-pci-v1-1-a0397c61bbe4@gmail.com>
To: Tamir Duberstein <tamird@kernel.org>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External



> On 22 Dec 2025, at 09:23, Tamir Duberstein <tamird@kernel.org> wrote:
>=20
> From: Tamir Duberstein <tamird@gmail.com>
>=20
> C-String literals were added in Rust 1.77. Replace instances of
> `kernel::c_str!` with C-String literals where possible.
>=20
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Benno Lossin <lossin@kernel.org>
> Acked-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
> samples/rust/rust_driver_pci.rs | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/samples/rust/rust_driver_pci.rs =
b/samples/rust/rust_driver_pci.rs
> index 5823787bea8e..991cc111fd63 100644
> --- a/samples/rust/rust_driver_pci.rs
> +++ b/samples/rust/rust_driver_pci.rs
> @@ -4,7 +4,7 @@
> //!
> //! To make this driver probe, QEMU must be run with `-device =
pci-testdev`.
>=20
> -use kernel::{c_str, device::Core, devres::Devres, pci, prelude::*, =
sync::aref::ARef};
> +use kernel::{device::Core, devres::Devres, pci, prelude::*, =
sync::aref::ARef};
>=20
> struct Regs;
>=20
> @@ -79,7 +79,7 @@ fn probe(pdev: &pci::Device<Core>, info: =
&Self::IdInfo) -> impl PinInit<Self, Er
>             pdev.set_master();
>=20
>             Ok(try_pin_init!(Self {
> -                bar <- pdev.iomap_region_sized::<{ Regs::END }>(0, =
c_str!("rust_driver_pci")),
> +                bar <- pdev.iomap_region_sized::<{ Regs::END }>(0, =
c"rust_driver_pci"),
>                 index: *info,
>                 _: {
>                     let bar =3D bar.access(pdev.as_ref())?;
>=20
> ---
> base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
> change-id: 20251222-cstr-pci-448ca1f4aa31
>=20
> Best regards,
> -- =20
> Tamir Duberstein <tamird@gmail.com>
>=20
>=20

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>


