Return-Path: <linux-pci+bounces-32665-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E42B0C7D0
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 17:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A241167A27
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 15:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA342DE70A;
	Mon, 21 Jul 2025 15:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="ANGCruJu"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B837170A2B;
	Mon, 21 Jul 2025 15:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753112413; cv=pass; b=fBssNIAl3LV5ZSeGVT8hf82blqLpeRyWHMHvhf+a5RxXWI9hN+01zS84ntFBHNLp6HSiSr7ofOjLHFWE4O7rBSzRjjIa64Gse5LYsUKmvTtCDCszv90vni2YU6NuUx4emGAtfGkuOr+zPSQGNlXCplI/yrCMPQSiIyeguhx5k4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753112413; c=relaxed/simple;
	bh=Oa3E9DZrZKrWi0b6xMSB/3xGFv+yRLURj6f7V19Xm20=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=rxby3PlK1ho6+YV3cKslLtJSlqqwOJ+sLdMZwCh2NKSJeKlgiLYlA84hOZk1YpgQMYO3zsaP9eFfLI4Qvxb6M+opg41+V8PE17TCHbENbyEYh++viaSNcN6AAU1Nz6fqSlfXnV9P5KJRzv2g3thxukaZml5S+LAkRgMkNN6EN5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=ANGCruJu; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1753112391; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ObAS1cVnZe4GtB2Mw58Ew1pSljyXZYtNLhEh6Ahm5C0U2v5+fMUe6lkHaznuZKNG0VnnDRwiCniVdd66+WEeyWkImBGBX5KR843rOMOPby1+nv8VLzMGdSYZ/F3sldtGUSeblRzG/omRF2BLu4g8GNynVL1dDooShmBrAW+zjK8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1753112391; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Oa3E9DZrZKrWi0b6xMSB/3xGFv+yRLURj6f7V19Xm20=; 
	b=AZWcEnijkohVF4EG77WEsv379buoFNd32uQNLnnelafKsyObKhn5A2JkInWukWcPNOeEqGr0blCZMRbBbVIQlw9qxQ8qGeQ6tIjkNHf4FMYiUB31n9hXgi4L7XPg+/UQpieXu4OiMB1ypRmdkfyyea0mMkSfqDdas7KKhIwd+Aw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1753112391;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=Oa3E9DZrZKrWi0b6xMSB/3xGFv+yRLURj6f7V19Xm20=;
	b=ANGCruJuodraWt9UzBZXqIRB2mcysZOiU7jsXetJbzpB+XxhTTxqVLuN0qKfddDc
	HJicDM4XzIe+DEQljZ0NlFJgaUXuJrZQDYLcFZGouE4rcLtjtzyHK5KYfLYBSK3YAdo
	b3RnVAW/8tseLkArYpI3U3d3RRzKWWoYxBMrZ44E=
Received: by mx.zohomail.com with SMTPS id 1753112390371703.9991459836481;
	Mon, 21 Jul 2025 08:39:50 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v7 3/6] rust: irq: add support for non-threaded IRQs and
 handlers
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <DBHU8JNG1P7I.NNDX9ZDT9DNU@kernel.org>
Date: Mon, 21 Jul 2025 12:39:33 -0300
Cc: Alice Ryhl <aliceryhl@google.com>,
 Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Bjorn Helgaas <bhelgaas@google.com>,
 =?utf-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Benno Lossin <lossin@kernel.org>,
 linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 linux-pci@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <17DE1CFA-11D2-43B0-8710-A55983E2E918@collabora.com>
References: <20250715-topics-tyr-request_irq2-v7-0-d469c0f37c07@collabora.com>
 <20250715-topics-tyr-request_irq2-v7-3-d469c0f37c07@collabora.com>
 <aH5SiKFESpnD4jvZ@google.com>
 <1CC4638E-C682-4F68-A616-553169BB677C@collabora.com>
 <DBHU8JNG1P7I.NNDX9ZDT9DNU@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External



> On 21 Jul 2025, at 12:28, Danilo Krummrich <dakr@kernel.org> wrote:
>=20
> On Mon Jul 21, 2025 at 5:10 PM CEST, Daniel Almeida wrote:
>> Hi Alice, thanks for looking into this again :)
>>=20
>>=20
>> [=E2=80=A6]
>>=20
>>>> diff --git a/rust/kernel/irq/request.rs =
b/rust/kernel/irq/request.rs
>>>> new file mode 100644
>>>> index =
0000000000000000000000000000000000000000..2f4637d8bc4c9fda23cbc83076870359=
57b0042a
>>>> --- /dev/null
>>>> +++ b/rust/kernel/irq/request.rs
>>>> @@ -0,0 +1,267 @@
>>>> +// SPDX-License-Identifier: GPL-2.0
>>>> +// SPDX-FileCopyrightText: Copyright 2025 Collabora ltd.
>>>> +
>>>> +//! This module provides types like [`Registration`] which allow =
users to
>>>> +//! register handlers for a given IRQ line.
>>>> +
>>>> +use core::marker::PhantomPinned;
>>>> +
>>>> +use crate::alloc::Allocator;
>>>> +use crate::device::Bound;
>>>> +use crate::device::Device;
>>>=20
>>> The usual style is to write this as:
>>>=20
>>> use crate::device::{Bound, Device};
>>=20
>> I dislike this syntax because I think it is a conflict magnet. =
Moreover, when
>> you get conflicts, they are harder to solve than they are when each =
import
>> is in its own line, at least IMHO. =20
>=20
> Intuitively, I would agree. However, I think practically it's not that =
bad.
>=20
> While it's true that Rust has generally more conflict potential - =
especially in
> the current phase - my feeling hasn't been that includes produce =
significantly
> more conflicts then any other code so far.

Hmm, I faced lots of conflicts for the platform I/O stuff, for example. =
They
were all on the imports and it was a bit hard to fix it by hand. i.e.: =
it=E2=80=99s
much simpler to discard the modifications and then ask rust-analyzer to =
figure
out what should be grouped where on the new code. This is a bit =
undesirable.


>=20
>> In any case, I don't think we have a guideline for imports at the =
moment?
>=20
> No, but I think we should try to be as consistent as possible (at =
least within a
> a certain logical unit, e.g. subsystem, module, etc.). Not sure where =
exactly
> the IRQ stuff will end up yet. :)


Sure, I just think we should discuss this at the kernel crate level at a =
future
point then, at least IMHO. I think it's something that Andreas had =
already
commented on, by the way.

=E2=80=94 Daniel


