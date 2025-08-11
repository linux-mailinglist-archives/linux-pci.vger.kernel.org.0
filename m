Return-Path: <linux-pci+bounces-33725-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF8CB20829
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 13:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AE7842203E
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 11:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1E41E5219;
	Mon, 11 Aug 2025 11:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="gOLMyaru"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDEE2D29D1;
	Mon, 11 Aug 2025 11:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754912869; cv=pass; b=M8CE7nN5vKMjI4OwPeVYUKOAiAy5PbrDbphjN1Q4rwrG8Dsut3ytmaKzdbsDlAat2zZNyAwCV1o0Czg6atnsfV0ZEzWfu+8Cc6VqGUwuapax77l3kW2Fm9DaTe8quoIDwHXo5MgAjFB0qfVZuIrbOfM7kB37bw6KJkr2Y5Mf1/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754912869; c=relaxed/simple;
	bh=uUB5DlbuB3NpP/LIqHOjHsiTqb6VpR9WnOLhV9VRXs0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=mLTXNsGcMnO6xkfMxcbIsdKY2Uei3yGGx7Gvtpox1lJyIyoxBGoA1D0/m3Mh/0OtSWs1z/sDcDqdbGYstyFpNk+rDC74AmcFnJIhjU4Fp42am02V0SdXIgfe+sewY+hVTXUKlXcCDSoUjkM5B7CBUYE8mDaBD8g48gLLQbqzloo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=gOLMyaru; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1754912844; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=mLqzje42l9I5mww4ketFAuYHmPzBtnUqwfX2bzWOfLf8ebIT4kbwp++OgbgtIlZZzK2YoesSZ+PibMkGx90qvaMrJdJOLwsO2QfzuizIJU3sl7pxq557EAxNNAoyjUOpDciiULOD1J0T8NvRz6JDt0BG0K0lxfEFTAaxq/k/0bE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1754912844; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=uUB5DlbuB3NpP/LIqHOjHsiTqb6VpR9WnOLhV9VRXs0=; 
	b=iaVyZNyAgT4DL4ORv5QNAEOaytnx1EJFnX7S+hzfEU0JH257o806BjurDSPh5XLYu+gvM2HgFldAYrvmIX3uljDUyOqRixn61LwfzDL9jc9KyC85JYjF8IcuTprkxqN7g/6BMdMsUhH0bGinTDOfKcq8OhFEuhJgPoQJPmtEi9Q=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1754912843;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=uUB5DlbuB3NpP/LIqHOjHsiTqb6VpR9WnOLhV9VRXs0=;
	b=gOLMyarugBtnLDD0JPnwfPGxr3cvnq2BS8KErUsF4FTNv/Co70dm+++o0exl2nMr
	+Ymwn6nmq1D4TApjiiJ7uInBJ1TXDEnGPkXOFyc0iBV2BhYB27vuqJz3nw36HiCwRV8
	ZBaH8J2KGRrvy9fgi7zNUW0jVYGCUS673vHdVXig=
Received: by mx.zohomail.com with SMTPS id 1754912841276255.36837202531228;
	Mon, 11 Aug 2025 04:47:21 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v8 3/6] rust: irq: add support for non-threaded IRQs and
 handlers
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <aJnM1LgUYjTloVwV@google.com>
Date: Mon, 11 Aug 2025 08:47:04 -0300
Cc: Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Bjorn Helgaas <bhelgaas@google.com>,
 =?utf-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Benno Lossin <lossin@kernel.org>,
 linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 linux-pci@vger.kernel.org,
 Joel Fernandes <joelagnelf@nvidia.com>,
 Dirk Behme <dirk.behme@de.bosch.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4EE6F260-5AC9-47AD-9F34-0D6C224A8559@collabora.com>
References: <20250810-topics-tyr-request_irq2-v8-0-8163f4c4c3a6@collabora.com>
 <20250810-topics-tyr-request_irq2-v8-3-8163f4c4c3a6@collabora.com>
 <aJnM1LgUYjTloVwV@google.com>
To: Alice Ryhl <aliceryhl@google.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External

Hi Alice,

> On 11 Aug 2025, at 07:58, Alice Ryhl <aliceryhl@google.com> wrote:
>=20
> On Sun, Aug 10, 2025 at 09:32:16PM -0300, Daniel Almeida wrote:
>> This patch adds support for non-threaded IRQs and handlers through
>> irq::Registration and the irq::Handler trait.
>>=20
>> Registering an irq is dependent upon having a IrqRequest that was
>> previously allocated by a given device. This will be introduced in
>> subsequent patches.
>>=20
>> Tested-by: Joel Fernandes <joelagnelf@nvidia.com>
>> Tested-by: Dirk Behme <dirk.behme@de.bosch.com>
>> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
>=20
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
>=20
>> diff --git a/rust/kernel/irq.rs b/rust/kernel/irq.rs
>> index =
d6306415f561f94a05b1c059eaa937b0b585471d..f7d89a46ad1894dda5a0a0f53683ff97=
f2359a4e 100644
>> --- a/rust/kernel/irq.rs
>> +++ b/rust/kernel/irq.rs
>> @@ -13,5 +13,11 @@
>> /// Flags to be used when registering IRQ handlers.
>> pub mod flags;
>>=20
>> +/// IRQ allocation and handling.
>> +pub mod request;
>=20
> Same comment here about removing `pub` from `mod request`.
>=20
>> #[doc(inline)]
>> pub use flags::Flags;
>> +
>> +#[doc(inline)]
>> +pub use request::{Handler, IrqRequest, IrqReturn, Registration};
>=20
> With `pub` removed above, you don't need doc(inline) here.
>=20
> Alice
>=20

This was not forgotten, i.e.: from the cover letter:

- Re-exported irq::flags::Flags through a "pub use" (Alice).
- Note: left the above as optional as it does not hurt to specify the =
full
path anyway. As a result, no modules were made private.

I chose Boqun=E2=80=99s idea, as we don=E2=80=99t have to enforce access =
through the
re-exports. Also, I was getting tons of =E2=80=9Cunreachable_pub=E2=80=9D =
warnings
otherwise, FYI.

=E2=80=94 Daniel=

