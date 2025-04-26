Return-Path: <linux-pci+bounces-26831-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED969A9DD0D
	for <lists+linux-pci@lfdr.de>; Sat, 26 Apr 2025 22:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43D873BE1B6
	for <lists+linux-pci@lfdr.de>; Sat, 26 Apr 2025 20:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779151C54A2;
	Sat, 26 Apr 2025 20:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="jAcALqYo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D41C17E4;
	Sat, 26 Apr 2025 20:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745698586; cv=none; b=DMGY4iDg1qAMoIyY5BqAkyJVV5l0Vx0xSsH8545GLpjP4Bg+zNC8u8FJysD1MBrfXXZOh1RttNcXSeuSqtOVW+r6ef19Vis88rffEqwqbrfsG69q4m4+CY+cyADL5emjKehqa/GDI3Q+LleQAyQxalN0A8FoaanxyJT7ZQgCxC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745698586; c=relaxed/simple;
	bh=ax2v0J7dfzR1YneEovbkCdIhFdsZ7fhCRCbLv5lqnfA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FVG0kfUlHI5M6mzeLuJ0+0yWwLzNm1MpmfgagBrdGlpJo7Jf93lZORZ/7ChVAO4Du5shIWVuD0Sml9Kk5uBzUsxZf8d24FrnTNYb7R9l/i6W+/qqsGnRIsPLJJBhCineTEBcTVIqgfKFrWRkNDCMflXwjAl4Tuw1og7YglcYLiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=jAcALqYo; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=hrjpr3ctenbj5iyf6xt2mw2wua.protonmail; t=1745698580; x=1745957780;
	bh=fCr6MO2jeMxolSVIhe975fXrm9ILcoSnsr1U9vPDunY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=jAcALqYoD+Bu+zyZenl81XeKT+huwOkqc8CjN2s1mkLRGO16d6Gk+PP3rQS52BvOZ
	 M63pzU31w3pmXOUwHlHA3chNWumKAfx44V+CAdU/YG5htTjgPduCdv3wqZJkdCJY/Q
	 waCr1VW+C22kMkVlL2Vuhr/Dah2METMgsQm2TK8T9nCuhkKFOKYYrIRAL4VhVm+9xj
	 dxdsqy5pe8EWaLnPIVB/YyHi2L7ieam6FSU5neYGCXF5dkaID5E5vzHsvaiG7REaRj
	 EFhXOdjtIFgRazN0zDiEazFRdEmAA0Ot3qHxMbUdvarMAdfXG1bhMks3choT1Y9oNb
	 sKOtGTpHoCZUQ==
Date: Sat, 26 Apr 2025 20:16:14 +0000
To: Christian Schrefl <chrisi.schrefl@gmail.com>, Boqun Feng <boqun.feng@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Danilo Krummrich <dakr@kernel.org>, gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com, kwilczynski@kernel.org, zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, bskeggs@nvidia.com, acurrid@nvidia.com, joelagnelf@nvidia.com, ttabi@nvidia.com, acourbot@nvidia.com, ojeda@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu, linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] rust: revocable: implement Revocable::access()
Message-ID: <D9GUHUN3G7F6.2C5KX11EECKJU@proton.me>
In-Reply-To: <6dbec9b3-b1a2-4fe7-9861-6bc879d7332c@gmail.com>
References: <20250426133254.61383-1-dakr@kernel.org> <20250426133254.61383-2-dakr@kernel.org> <aa747122-fc78-45db-a410-ceb53b4df65e@gmail.com> <aA0P4lr0A2s--5bI@Mac.home> <6dbec9b3-b1a2-4fe7-9861-6bc879d7332c@gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 462ca6cc3dd1ccdf3d4cae64bdfbfe6494d3cf92
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat Apr 26, 2025 at 7:03 PM CEST, Christian Schrefl wrote:
> On 26.04.25 6:54 PM, Boqun Feng wrote:
>> On Sat, Apr 26, 2025 at 06:44:03PM +0200, Christian Schrefl wrote:
>>> On 26.04.25 3:30 PM, Danilo Krummrich wrote:
>>>> Implement an unsafe direct accessor for the data stored within the
>>>> Revocable.
>>>>
>>>> This is useful for cases where we can proof that the data stored withi=
n
>>>> the Revocable is not and cannot be revoked for the duration of the
>>>> lifetime of the returned reference.
>>>>
>>>> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
>>>> ---
>>>> The explicit lifetimes in access() probably don't serve a practical
>>>> purpose, but I found them to be useful for documentation purposes.
>>>> --->  rust/kernel/revocable.rs | 12 ++++++++++++
>>>>  1 file changed, 12 insertions(+)
>>>>
>>>> diff --git a/rust/kernel/revocable.rs b/rust/kernel/revocable.rs
>>>> index 971d0dc38d83..33535de141ce 100644
>>>> --- a/rust/kernel/revocable.rs
>>>> +++ b/rust/kernel/revocable.rs
>>>> @@ -139,6 +139,18 @@ pub fn try_access_with<R, F: FnOnce(&T) -> R>(&se=
lf, f: F) -> Option<R> {
>>>>          self.try_access().map(|t| f(&*t))
>>>>      }
>>>> =20
>>>> +    /// Directly access the revocable wrapped object.
>>>> +    ///
>>>> +    /// # Safety
>>>> +    ///
>>>> +    /// The caller must ensure this [`Revocable`] instance hasn't bee=
n revoked and won't be revoked
>>>> +    /// for the duration of `'a`.
>>>> +    pub unsafe fn access<'a, 's: 'a>(&'s self) -> &'a T {
>>> I'm not sure if the `'s` lifetime really carries much meaning here.
>>> I find just (explicit) `'a` on both parameter and return value is clear=
er to me,
>>> but I'm not sure what others (particularly those not very familiar with=
 rust)
>>> think of this.
>>=20
>> Yeah, I don't think we need two lifetimes here, the following version
>> should be fine (with implicit lifetime):
>>=20
>> =09pub unsafe fn access(&self) -> &T { ... }
>>=20
>> , because if you do:
>>=20
>> =09let revocable: &'1 Revocable =3D ...;
>> =09...
>> =09let t: &'2 T =3D unsafe { revocable.access() };
>>=20
>> '1 should already outlive '2 (i.e. '1: '2).
>
> I understand that implicit lifetimes desugars to=20
> effectively the same code, I just think that keeping
> a explicit 'a makes it a bit more obvious that the
> lifetimes need to be considered here.
>
> But I'm also fine with just implicit lifetimes here.

We elide lifetimes all over the place especially for methods taking
`&self` and returning `&T`. I don't think that it serves a purpose here.

---
Cheers,
Benno


