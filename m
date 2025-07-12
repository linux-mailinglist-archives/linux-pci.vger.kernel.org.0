Return-Path: <linux-pci+bounces-32001-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A115B02CF4
	for <lists+linux-pci@lfdr.de>; Sat, 12 Jul 2025 22:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4E294A5019
	for <lists+linux-pci@lfdr.de>; Sat, 12 Jul 2025 20:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C38D225A31;
	Sat, 12 Jul 2025 20:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="eWUwlx/f"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AAF1FE44A;
	Sat, 12 Jul 2025 20:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752353354; cv=pass; b=InJKaq6B5TzlFTqloO9kXe9tb85BR7jqQhiEwlr06G7J92JQBpab/HYG+pOFegdIwNaiP2y6Vlm8PEhaE4NFkoyRtDcaNr1BIomVN4k3FWw/aadTuXvVaekrA/FZuCPUO/MsEkWWjG3UkF0PTecydyo3kFvAIOPu/1Q6KErdsd0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752353354; c=relaxed/simple;
	bh=TL1uETJqy6Q+gnh/X/gxtN+JSE8CBbBRlgjUxMM76N4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=qnUPdOYDiTGH2qAuadDiBEfjJs/mFvuCnd7LO7yM3Hq0oc5/Q9tMkUszITSWPEkmzcjmyRUp1V9kRC/kSEkBNRUTxfwwRSBUr9xKRLEyuVujC8zJAwxddG13kPPtCTRxN2DEE7DOxRKg1kxbCmfLbd3mEJMLlS7CdBOgrOYEtF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=eWUwlx/f; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1752353331; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=G4PN9v2G6nmjbE0r7n/AS7V8dgRKefaNXPG2lyZGs0KPP8zKkuIx90QTOiTmhsgCQpL/3mLAaMLRkN9/EGojxhfsStkCKNO0//ErZLMo37EVxhteR/LtgRWDYyt3VZkHP1ExXRttG5OGm5afa/B6OeldUVSaQp1UsCycHTWJHh4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1752353331; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=v9+o1vJleECyihJesPwTdcJPWB9rqVwMoLr4eCv2OiI=; 
	b=HqC+Lae30LTDosuB8PW01uRvMyTYGh7IcpuW4Iprod3KZ6ndtbz6fYifQ8GWNvhsr+ZLhYzXJPzvL6O5/hMoqYYeLbEIFH3HdS8esMVMGQstN3x5x2lmtQWjhNr1XAXoe+Qho0J1AowuTXs0Vx71ileSvlsZ2lZUOTmZ71c7I50=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752353331;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=v9+o1vJleECyihJesPwTdcJPWB9rqVwMoLr4eCv2OiI=;
	b=eWUwlx/fGEDObvCmiTJTEVV8+W20pB6g24vkVVEkaCl0RL87J/hpg4FGfxD5RNnK
	bpAsUJDIqcdGhy0lNYuA1RAU6wJpjUXKxmL7gpoEK3vwWXL3OXaJPL7ATM/P9P4ad8E
	M8fx7HpFmleAsIQCViQcwdFzDpfcCP1cZaOGnSAY=
Received: by mx.zohomail.com with SMTPS id 1752353327967255.49664521348495;
	Sat, 12 Jul 2025 13:48:47 -0700 (PDT)
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
In-Reply-To: <CAH5fLgggM7ZCX7nRz7M=hkxwzcp8UA1=2BQqRFA2CgN9eEUmsA@mail.gmail.com>
Date: Sat, 12 Jul 2025 17:48:30 -0300
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
Message-Id: <82EFFBBD-C6BF-444C-9209-70805E31EE9E@collabora.com>
References: <20250703-topics-tyr-request_irq-v6-0-74103bdc7c52@collabora.com>
 <20250703-topics-tyr-request_irq-v6-2-74103bdc7c52@collabora.com>
 <fcdae3ca-104d-4e8b-8588-2452783ed09a@sedlak.dev>
 <aGeF_W74OfhRbkoR@google.com>
 <49ABD63B-05C6-4FDC-B825-5AA2ED323F1C@collabora.com>
 <CAH5fLgggM7ZCX7nRz7M=hkxwzcp8UA1=2BQqRFA2CgN9eEUmsA@mail.gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External



> On 12 Jul 2025, at 17:03, Alice Ryhl <aliceryhl@google.com> wrote:
>=20
> On Sat, Jul 12, 2025 at 6:27=E2=80=AFPM Daniel Almeida
> <daniel.almeida@collabora.com> wrote:
>>=20
>> Hi Alice,
>>=20
>>> On 4 Jul 2025, at 04:42, Alice Ryhl <aliceryhl@google.com> wrote:
>>>=20
>>> On Fri, Jul 04, 2025 at 08:14:11AM +0200, Daniel Sedlak wrote:
>>>> Hi Daniel,
>>>>=20
>>>> On 7/3/25 9:30 PM, Daniel Almeida wrote:
>>>>> +/// Flags to be used when registering IRQ handlers.
>>>>> +///
>>>>> +/// They can be combined with the operators `|`, `&`, and `!`.
>>>>> +#[derive(Clone, Copy, PartialEq, Eq)]
>>>>> +pub struct Flags(u64);
>>>>=20
>>>> Why not Flags(u32)? You may get rid of all unnecessary casts later, =
plus
>>>> save some extra bytes.
>>>=20
>>> It looks like the C methods take an `unsigned long`. In that case, =
I'd
>>> probably write the code to match that.
>>>=20
>>> pub struct Flags(c_ulong);
>>>=20
>>> and git rid of the cast when calling bindings::request_irq.
>>>=20
>>> As for all the constants in this file, maybe it would be nice with a
>>> private constructor that uses the same type as bindings to avoid the
>>> casts?
>>>=20
>>> impl Flags {
>>>   const fn new(value: u32) -> Flags {
>>>    ...
>>>   }
>>> }
>>=20
>>=20
>> Sure, but what goes here? This has to be "value as c_ulong=E2=80=9D =
anyways so it
>> doesn=E2=80=99t really reduce the number of casts.
>>=20
>> We should probably switch to Flags(u32) as Daniel Sedlak suggested. =
Then
>> it=E2=80=99s a matter of casting once for bindings::request_irq().
>=20
> IMO the advantage of doing it here is that we can fail compilation if
> the cast is out of bounds, whereas the other cast is at runtime so we
> can't do that.
>=20
> Alice

I=E2=80=99m not sure I am following. How is this compile-time checked?

>>> impl Flags {
>>>   const fn new(value: u32) -> Flags {
>>>    Self(value as c_ulong)
>>>   }

Or perhaps I misunderstood you?

=E2=80=94 Daniel



