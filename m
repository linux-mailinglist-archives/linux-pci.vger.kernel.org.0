Return-Path: <linux-pci+bounces-32831-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED402B0F7C9
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 18:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3B2B1898B55
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 16:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2111339A4;
	Wed, 23 Jul 2025 16:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="Wr4/+rr5"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDAA4A28;
	Wed, 23 Jul 2025 16:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753286891; cv=pass; b=e3GV+mtPf+F+0CoYEas7bnJp/DsAr5wiW4Ior5Od0jHl6/IFbLSe/UQd0hihacvpfanpZQPdJCGdKHA1M7KbnP4dbFzvWngZXqiERHNqLADUHyT3jjeAOCoHRp4jiHickGJygzSDtVkWLci0iYjXM8Qm2pGqr2pRlAbHoTy7eQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753286891; c=relaxed/simple;
	bh=YsxEQ6Q7Rx0h54CXT9Nux+NoksdOzBkb/yyRR5d++vE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=kem9V73StDFau3T57zeNwxa2DtlYAsw/75+xo6KFmleiKocF2B/jLpblKBbcwUVx0Rvug7TqX4U8iIgy2tCOQCoDkLmNMlHA3aUOtGN1WMEKfzxUGfm84z63X4hTgbvQBLqtVyu8BFA6yvHMJ8aoVi5RAUB8Iv9NqY87fMLNZXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=Wr4/+rr5; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1753286870; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=QfCC2/+a3tzLaozm/pXkaPJx3cvaFYssQh5tenoBh3/0jbMgYv48sLymSJ0H+DPiRROFf0h/2cr468t7FnUc826c0JbzPWChF/omHcUo381QCTwCrHtX9HExwfhQEaTRYhx4zhCVzhyO6AiOt/FRCrOCT6kUhxRKJsO6C+Msp2s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1753286870; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=YsxEQ6Q7Rx0h54CXT9Nux+NoksdOzBkb/yyRR5d++vE=; 
	b=irA3f94516eMpgLkTtEq+f3UDxB/x1yU4niyHWF1gyTF7R9M4e1DCmB7F9jcPBpkk/4GOyFs7kdoKSmuCqxxElCSuS+r31ju9Y/iNKUtr8G3awzJ87cUgnQWAl8EbjyO8hReDF8wETqTVhFDndJY6oytJaDMg2/ucWFa4u3u8Q0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1753286870;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=YsxEQ6Q7Rx0h54CXT9Nux+NoksdOzBkb/yyRR5d++vE=;
	b=Wr4/+rr5m62xvvrILqBHXmNvr9G/vUOnYc31SOcUXyBsPkMudu+HhvurboG9/njD
	pdqWH3Q5EwMZuks59+c+yL4j2y7wSu7/opVHpup3bP/z2baePHh/9XKK+oAy1fUYdmZ
	v4uLg12MbIm8ZZZSyNI4RavlfI8NXZlKCr6FAFPQ=
Received: by mx.zohomail.com with SMTPS id 1753286868381777.8597804313176;
	Wed, 23 Jul 2025 09:07:48 -0700 (PDT)
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
In-Reply-To: <aIEE4Tt7xtaX-9V9@tardis-2.local>
Date: Wed, 23 Jul 2025 13:07:32 -0300
Cc: Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Bjorn Helgaas <bhelgaas@google.com>,
 =?utf-8?Q?Krzysztof_Wilczy=C2=B4nski?= <kwilczynski@kernel.org>,
 Benno Lossin <lossin@kernel.org>,
 linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 linux-pci@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <CF821F27-7F78-4B3E-AF62-887341EAA7BE@collabora.com>
References: <20250715-topics-tyr-request_irq2-v7-0-d469c0f37c07@collabora.com>
 <20250715-topics-tyr-request_irq2-v7-3-d469c0f37c07@collabora.com>
 <aIBl6JPh4MQq-0gu@tardis-2.local>
 <ED19060D-265A-4DEF-A12B-3F5901BBF4F3@collabora.com>
 <aIDxFoQV_fRLjt3h@tardis-2.local>
 <95A7ACD9-8D0D-41FB-A0C0-691B699CBA17@collabora.com>
 <aIEE4Tt7xtaX-9V9@tardis-2.local>
To: Boqun Feng <boqun.feng@gmail.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External

[=E2=80=A6]

>>=20
>>=20
>> Because it is not as explicit. The main thing we should be conveying =
to users
>> here is how to get a &mut or otherwise mutate the data when running =
the
>> handler. When people see AtomicU32, it's a quick jump to "I can make =
this work
>> by using other locks, like SpinLockIrq". Completions hide this, IMHO.
>>=20
>=20
> I understand your argument. However, I'm not sure the example of
> `irq::Registration` is the right place to do this. On one hand, it's =
one
> of the usage of interior mutability as you said, but on the other =
hand,
> for people who are familiar with interior mutability, the difference
> between `AtomicU32` and `Completion` is not that much. That's kinda my
> argument why using `Completion` in the example here is fine.
>=20
> Sounds reasonable?
>=20
>> It's totally possible for someone to see this and say "ok, I can call
>> complete() on this, but how can I mutate the data in some random T =
struct?",
>> even though these are essentially the same thing from an interior =
mutability
>> point of view.
>>=20
>=20
> We probably better assume that interior mutability is commmon =
knowledge
> or we could make an link to some documentation of interior mutability,
> for example [1], in the documentation of `handler`. Not saying your
> effort and consideration is not valid, but at the project level,
> interior mutability should be widely acknowledged IMO.
>=20
> [1]: https://doc.rust-lang.org/reference/interior-mutability.html
>=20
> Regards,
> Boqun
>=20
>> -- Daniel

I do expect mostly everbody (except brand-new newcomers) to be aware of
interior mutability. What I don't expect is for people _immediately_ see =
that
it's being used in Completion, and connect the dots from there.

Keyword here being "immediately", users will naturally realize this in a =
couple
of minutes at max, of course.

Anyways, I guess we can use Completion then. TBH I wasn't aware of the =
UB
thing, so I can see how you also have a point. On top of that, we can =
use the
words "interior mutability" somewhere in the example as well to make it =
even
clearer.

I'll change it for v8.

-- Daniel



