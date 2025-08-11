Return-Path: <linux-pci+bounces-33731-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74655B2096E
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 14:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD40E620667
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 12:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162982D6632;
	Mon, 11 Aug 2025 12:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="RH8tub5M"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5B22D3A71;
	Mon, 11 Aug 2025 12:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754916976; cv=pass; b=tNdEwqtw/3K1nHMhN512MeSRuGUT8dVSpBnyx+W2tWZhS5nh8Ux1sFFYKKmu0O/v7x5VQuh6kEFIH1bWTeUw2f5qbAN+S/YA4Vq+4uxTcFBqJJYE4bDHoaZqfxwa+Bx/g0HvvruucurBL+t4ZYHqjpabWb53s9l/q4bi5kDbHOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754916976; c=relaxed/simple;
	bh=tqTp9yVpcdT4vXKwkCs7JMmSn2cfWp5BI746F/8NzMM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=MnWnPtBcc2hVAmopZS7+o0X92H5OuwnKnf0WpdSP5NgP5xeRAWDxyPpVI912KZKW8LgOklu1s81nks9uc6TCbzzYt8iVvq5wR/IQW+dRx1ZndecbLreF/V5oK0BDHjPbtq1mLofU5qXPZD/PvoAT8/03P5zBazLh57CAC9v1+08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=RH8tub5M; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1754916949; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=DdJ4aUf2InT4dryqfStAX/Aw5xYE93/JQrEAAkYfjyRL0yDQ+3k4PcMVW9CKSkrT7ZWlbDp0l+7hY2JLGK2Ef8jigQlSJXvTv1uQaGXd2fTfzxTfsfYVeKvgA131jIeg/ZcLvew8tR5QZ6mEWGpDEGDn1NPM/BaP/o/s7JQhUH0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1754916949; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=M9GGVyNyOKdJ+YkHugnVzHXtWsO7h0KXofaHhZwbK/0=; 
	b=T2omoj56lBrIM0wz1sw+nvwG9yjwbV36VXjpKApRDdfQ/j/vcTLI3lSEq4D+IZnkcGyzevfzHYMSpbSjLyJh+LZvHvYXJF5eMP077LVt7nSXumKIkc1aH0HrtfzAEyMr5zKYCB2kZm8NO/sOrGo3Jp8480Gv3P1y6mqttBtQf04=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1754916949;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=M9GGVyNyOKdJ+YkHugnVzHXtWsO7h0KXofaHhZwbK/0=;
	b=RH8tub5MmJN8gtOodZ+GYR5hlZm0EiLVafm/w5ZEUu7zior5xgzlnuNkrjetMcsG
	GfKOGhA8uBy/3rcKLfM6cKahf+e2vGXL4Lg8iv23Tgjf6mq/wlXvcA153R5zMYF4cDZ
	u0xvpryqjU/vPYRNKTTyYoSYiMmrP/X5F5paS01I=
Received: by mx.zohomail.com with SMTPS id 1754916946139376.6117182445307;
	Mon, 11 Aug 2025 05:55:46 -0700 (PDT)
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
In-Reply-To: <CAH5fLggOqsrob-h2v8c5hsnMquJZhXJ2euAub2ia2fjj=NY8Vg@mail.gmail.com>
Date: Mon, 11 Aug 2025 09:55:29 -0300
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
Message-Id: <77FB27DB-ACE0-4AC4-A3D9-CCF1EB4A34D2@collabora.com>
References: <20250810-topics-tyr-request_irq2-v8-0-8163f4c4c3a6@collabora.com>
 <20250810-topics-tyr-request_irq2-v8-3-8163f4c4c3a6@collabora.com>
 <aJnM1LgUYjTloVwV@google.com>
 <4EE6F260-5AC9-47AD-9F34-0D6C224A8559@collabora.com>
 <CAH5fLghV0aVZBBEmjf9CF9gFyG08dH7nFzKHnHM6RiANuSZaMw@mail.gmail.com>
 <AF48133C-BD57-4EEF-8E4A-ABEECB8A5C49@collabora.com>
 <CAH5fLggOqsrob-h2v8c5hsnMquJZhXJ2euAub2ia2fjj=NY8Vg@mail.gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External



> On 11 Aug 2025, at 09:43, Alice Ryhl <aliceryhl@google.com> wrote:
>=20
> On Mon, Aug 11, 2025 at 2:38=E2=80=AFPM Daniel Almeida
> <daniel.almeida@collabora.com> wrote:
>>=20
>>=20
>>>> Also, I was getting tons of =E2=80=9Cunreachable_pub=E2=80=9D =
warnings
>>>> otherwise, FYI.
>>>=20
>>> If you got unreachable_pub warnings, then you are missing =
re-exports.
>>>=20
>>> Alice
>>=20
>> The re-exports are as-is in the current patch, did I miss anything? =
Because I
>> don=E2=80=99t think so.
>>=20
>> In particular, should the irq module itself be private?
>=20
> No, the end-user should be able to write
>=20
>    use kernel::irq::Flags;
>=20
> so the irq module needs to be public.
>=20
> Alice

Ah, maybe this is the issue then, i.e [0]:

```
(This requires a re-export in the irq module if you don't have one
already. Also, I would make the irq module private so that end-users
import everything via the irq:: path without a sub-module.)
```

Fine, let me try this again.

=E2=80=94 Daniel

[0]: https://lore.kernel.org/all/aH5TMzJGqzg3wNjK@google.com/=

