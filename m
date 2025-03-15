Return-Path: <linux-pci+bounces-23849-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C56A63148
	for <lists+linux-pci@lfdr.de>; Sat, 15 Mar 2025 19:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8931C1892775
	for <lists+linux-pci@lfdr.de>; Sat, 15 Mar 2025 18:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D2F204F86;
	Sat, 15 Mar 2025 18:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="bCybOOt5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-24416.protonmail.ch (mail-24416.protonmail.ch [109.224.244.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F06B14900B
	for <linux-pci@vger.kernel.org>; Sat, 15 Mar 2025 18:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742061986; cv=none; b=JjNpRETr89Cl0CKvDP1Dmu+yGmCNxm9nPO6wuVcli95m3ejid6m/MagLnsI0rWUC094+2WH/CUAVQIeNqyRqk5E0OqScSo6N0CZzgwDgDNC0DbxUkTOix7/Lr/VQA21cMo0WYWndA/zOvQN7tnS6GTrqg1g1eFxN2Dw5T6ncpd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742061986; c=relaxed/simple;
	bh=83ux7GsQRAgjjlG+gq3dyYD7axH8T/COpDz69itGy60=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K+8EjgQHGUmJPOP1nzc8iVE5/5BMTEB+4DbX9RiRsNtTEvpNlle2ccnf5o/U7edwzau2tW2GZzQDednp3M3ZvTPaXGPuqUV+6iY587Y1uEagk421JCa3fY2GXMvaRN5LnAsLLA6e7RwaUmPZr85BrhC88SSuA0CAiTFGnMMJkZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=bCybOOt5; arc=none smtp.client-ip=109.224.244.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=ex2xmw5vhvdnldae5axehbswa4.protonmail; t=1742061978; x=1742321178;
	bh=eHMVOO8dy0bGHyPqCdhgzieWBEwWHl2axuWPpum4f5U=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=bCybOOt52C5584XztwIQ++wC7EVnTKZBCHim+RN/GfYijeMun48CKK5i1wDS96ld/
	 g//MZ6Kblz4vgRq1HkS7/RwMtN/Z1qSN2r9Hie6BF5kBPTi1IcmVgFFhahV/oKkDNm
	 XQ6UMLyJW54ffHh2l+Xq7IKfsrq45KOPAEBj8Pv1LbbyzPqlNt2s/zqa1P/8KDEK7D
	 dEQDQf0kvUd3bNHbW2sw3R81dYSt1/h/yzJaOgNPEhS7ovK7pGb9N8SpxcOfb9El52
	 fGqS11Ia0ooIwG5XKjgeCEXYgivQXr+nAHVQnwcvLrneTdKmWsd2WCBhHc4TxlWCLt
	 zcS0myQp4KtFg==
Date: Sat, 15 Mar 2025 18:06:13 +0000
To: Tamir Duberstein <tamird@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Bjorn Helgaas <bhelgaas@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/2] rust: workqueue: remove HasWork::OFFSET
Message-ID: <D8H1FFDMNLR3.STRVYQI7J496@proton.me>
In-Reply-To: <CAJ-ks9mUPkP=QDGekbi1PRfpKKigXj87-_a25JBGHVRSiEe_AA@mail.gmail.com>
References: <20250307-no-offset-v1-0-0c728f63b69c@gmail.com> <20250307-no-offset-v1-2-0c728f63b69c@gmail.com> <D8G8DV3PX8VX.2WHSM0TWH8JWV@proton.me> <CAJ-ks9m2ZHguB9N9-WM0EsO5MjaZ9yRamo_9NytAdzaDdb9aWQ@mail.gmail.com> <D8GQGCVTK0IL.16YO67C0IKLHA@proton.me> <CAJ-ks9mUPkP=QDGekbi1PRfpKKigXj87-_a25JBGHVRSiEe_AA@mail.gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 51459de54904159270930fbf4b47c18a6cbba89e
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat Mar 15, 2025 at 4:37 PM CET, Tamir Duberstein wrote:
> On Sat, Mar 15, 2025 at 5:30=E2=80=AFAM Benno Lossin <benno.lossin@proton=
.me> wrote:
>>
>> On Fri Mar 14, 2025 at 9:44 PM CET, Tamir Duberstein wrote:
>> > On Fri, Mar 14, 2025 at 3:20=E2=80=AFPM Benno Lossin <benno.lossin@pro=
ton.me> wrote:
>> >>
>> >> On Fri Mar 7, 2025 at 10:58 PM CET, Tamir Duberstein wrote:
>> >> >      /// Returns a pointer to the struct containing the [`Work<T, I=
D>`] field.
>> >> >      ///
>> >> >      /// # Safety
>> >> >      ///
>> >> >      /// The pointer must point at a [`Work<T, ID>`] field in a str=
uct of type `Self`.
>> >> > -    #[inline]
>> >> > -    unsafe fn work_container_of(ptr: *mut Work<T, ID>) -> *mut Sel=
f
>> >> > -    where
>> >> > -        Self: Sized,
>> >>
>> >> This bound is required in order to allow the usage of `dyn HasWork` (=
ie
>> >> object safety), so it should stay.
>> >>
>> >> Maybe add a comment explaining why it's there.
>> >
>> > I guess a doctest would be better, but I still don't understand why
>> > the bound is needed. Sorry, can you cite something or explain in more
>> > detail please?
>>
>> Here is a link: https://doc.rust-lang.org/reference/items/traits.html#dy=
n-compatibility
>>
>> But I realized that the trait wasn't object safe to begin with due to
>> the `OFFSET` associated constant. So I'm not sure we need this. Alice,
>> do you need `dyn HasWork`?
>
> I wrote a simple test:

[...]

> so I don't think adding the Sized bound makes sense - we'd end up
> adding it on every item in the trait.

Yeah the `Sized` bound was probably to make the cast work, so let's
remove it.

---
Cheers,
Benno


