Return-Path: <linux-pci+bounces-31996-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F888B02BE2
	for <lists+linux-pci@lfdr.de>; Sat, 12 Jul 2025 18:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31876A45773
	for <lists+linux-pci@lfdr.de>; Sat, 12 Jul 2025 16:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5AD9288CAF;
	Sat, 12 Jul 2025 16:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="XZM72l+n"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C746277C8D;
	Sat, 12 Jul 2025 16:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752337659; cv=pass; b=qWsZ2gOcHjYfdtXONLB+yqEPnmeQ5maRj/xwFshe0+qhORIo19Ny3SkCHIrMl5xRxlMw7/b/EeyzKsYCE/OgU0pGaSPPFRcWw+2ad5wHvhbqg1OXmJ+Qow/OkthIG0WePiJG22DAc0+M00HBtFNRNtFX+8ZABpiJFCGbvPKQpko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752337659; c=relaxed/simple;
	bh=cmm53DOTdwyscPEqSRjwmv4mZIvw1nYR7Ua4IWjUbX0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=QlUPdmuI8webw8xtAP0YagwqDDC+sB1sfNCtMtsXjqdYXgQ/aakAmTPgTTW6Mig8QmLFNrn3NoGuCjXq0ak6FzGbIMCc+gLEWKOufPKwD1dz4WTgx14fdAQamHAZIEcOwsbm2/BT5XxFf3Fo9Hn5B3gTzmAGWW4FqbCV7wWpES0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=XZM72l+n; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1752337631; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=G0O3epiDjil38rQ87refqbx3KSoHb3qzU7/D0YexeNi+D7UzSRtHwGOlYpBI54RVOVuKvInssd+9aq0R2mORBHTgA1IsiMhSqS1dHZ/V+C8+RVtx7mNRCc8c6ao0+3SvrMubnhgB2FjaLfNoHV63Tkxx7mylq024caya+/241VY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1752337631; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ahPGOugGxG/E5vYH46Dw+PAn5bPxIFk9wceQiVsZgc4=; 
	b=kkqMLDNmGZUv4ox2qs74gJpyuSyDCSlGCWpuiNoA7WjrIJj8LmwclPzYg+BpjCYoGIh5rXbZ9rpN/tO83BllSV/bDW6+rdkcdC5lOmEJ/3/WQp/72FZApFSOQeLvTZLtFwJiZdTfT06DqaXNiqH9bw9e5hdCAn5PZjBTFDoVZiE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752337631;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=ahPGOugGxG/E5vYH46Dw+PAn5bPxIFk9wceQiVsZgc4=;
	b=XZM72l+nNx5bBBbL+sXSR4bgxUrW94995cQTUfht63oAcIBoNPuO/l2RdbZ8f+mo
	kkj5ipG69OOVKLZhXmGy/pT3349PoTuh4xsNjJ0mVzKr3hnSqg6Kee1K77yzg543Emb
	MmNRl15nw5QsY8GAfECra+xi0aXVkW/4WIssrwUo=
Received: by mx.zohomail.com with SMTPS id 1752337628723425.6395233683338;
	Sat, 12 Jul 2025 09:27:08 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v6 2/6] rust: irq: add flags module
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <aGeF_W74OfhRbkoR@google.com>
Date: Sat, 12 Jul 2025 13:26:52 -0300
Cc: Daniel Sedlak <daniel@sedlak.dev>,
 Miguel Ojeda <ojeda@kernel.org>,
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
 Benno Lossin <lossin@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 =?utf-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 linux-pci@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <49ABD63B-05C6-4FDC-B825-5AA2ED323F1C@collabora.com>
References: <20250703-topics-tyr-request_irq-v6-0-74103bdc7c52@collabora.com>
 <20250703-topics-tyr-request_irq-v6-2-74103bdc7c52@collabora.com>
 <fcdae3ca-104d-4e8b-8588-2452783ed09a@sedlak.dev>
 <aGeF_W74OfhRbkoR@google.com>
To: Alice Ryhl <aliceryhl@google.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External

Hi Alice,

> On 4 Jul 2025, at 04:42, Alice Ryhl <aliceryhl@google.com> wrote:
>=20
> On Fri, Jul 04, 2025 at 08:14:11AM +0200, Daniel Sedlak wrote:
>> Hi Daniel,
>>=20
>> On 7/3/25 9:30 PM, Daniel Almeida wrote:
>>> +/// Flags to be used when registering IRQ handlers.
>>> +///
>>> +/// They can be combined with the operators `|`, `&`, and `!`.
>>> +#[derive(Clone, Copy, PartialEq, Eq)]
>>> +pub struct Flags(u64);
>>=20
>> Why not Flags(u32)? You may get rid of all unnecessary casts later, =
plus
>> save some extra bytes.
>=20
> It looks like the C methods take an `unsigned long`. In that case, I'd
> probably write the code to match that.
>=20
> pub struct Flags(c_ulong);
>=20
> and git rid of the cast when calling bindings::request_irq.
>=20
> As for all the constants in this file, maybe it would be nice with a
> private constructor that uses the same type as bindings to avoid the
> casts?
>=20
> impl Flags {
>    const fn new(value: u32) -> Flags {
>     ...
>    }
> }


Sure, but what goes here? This has to be "value as c_ulong=E2=80=9D =
anyways so it
doesn=E2=80=99t really reduce the number of casts.

We should probably switch to Flags(u32) as Daniel Sedlak suggested. Then
it=E2=80=99s a matter of casting once for bindings::request_irq().

=E2=80=94 Daniel=

