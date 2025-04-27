Return-Path: <linux-pci+bounces-26882-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE22A9E40B
	for <lists+linux-pci@lfdr.de>; Sun, 27 Apr 2025 19:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C86716FE7B
	for <lists+linux-pci@lfdr.de>; Sun, 27 Apr 2025 17:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D557A1DDC2B;
	Sun, 27 Apr 2025 17:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="bB32K6jX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-24417.protonmail.ch (mail-24417.protonmail.ch [109.224.244.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22AC155389;
	Sun, 27 Apr 2025 17:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745774158; cv=none; b=nwZLAVlqAwRsxZj9ZeIah+2t2TdJg//Z4abr1bI0aL/heqKciHMF1gLly+ySC+lwwLjhyIK5J/Hnq66X2Tiyz/f/fkYWGdfWQwP37V7KM0mFh6AyGMHTNWYLaoHWfEHIImEfAlWTAiaCVftlHs86jgHNALubqcA/ohCkhgfyxlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745774158; c=relaxed/simple;
	bh=EY6zshMpHuKMi9GkwPaveoyuujbJdsaKWPi4lc/rwl8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dkJENVDjx4fscd7WTT+B2xmNh2TUD1lAUegC5kUZ/VlsQWbROzB6QL6+k4E+zrPd/PO8qDUa3Ge8JyXvjCwacaBemycurFnTH0+BKi6bqa1i1E5ljgF9E2nN8/cT/SHiAKZ4YXlBfQAtq9uHMma4NjQO4XEWB82jPwgAB/ezkKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=bB32K6jX; arc=none smtp.client-ip=109.224.244.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1745774153; x=1746033353;
	bh=oNY/dnOz3jwg3jimqTTHInVyKqIo/WYcv2VYaSZg94s=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=bB32K6jXAuv1hpvpknBf0RaLcQ8RaIumRfelbDnJwtDdmoBgT2FCQQWttBOn7k9j6
	 h2xrg7+HwLgEjmhtzf4n1rJwFjjh9RErkb318qXPWvZlXKc5UbctUiF4RZsc53vSOd
	 3g/V+v5goAjHlohXK2ap9hy2Lpz/6KImzg4qXyQWKgcfLHx4C0RkRJwstiuQn+8m/3
	 X88y/Wyl7Y5UozgVRca6VDLrkHTG181dAz4IkR18tSJL16o1Gr0MIg2IAtv38gL4Tz
	 fuUxUJhcxngIH14wai1zMmpXvR8mbdGS1+VoifHP2jAiU8jbQYJwffKiWj4tSR/4Rg
	 XjNPNwP54eGUQ==
Date: Sun, 27 Apr 2025 17:15:48 +0000
To: Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com, kwilczynski@kernel.org, zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, bskeggs@nvidia.com, acurrid@nvidia.com, joelagnelf@nvidia.com, ttabi@nvidia.com, acourbot@nvidia.com, ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu, linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] rust: revocable: implement Revocable::access()
Message-ID: <D9HLAAZJRDKB.3CRXXMTLLPQ9J@proton.me>
In-Reply-To: <aA4DNEHgrKMmzxBP@pollux>
References: <D9HA92TSMC3M.2CRRX8P64NGD0@proton.me> <aA4DNEHgrKMmzxBP@pollux>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 6d7e3bccd236afe6b8900c83c52cf8490fcbca62
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun Apr 27, 2025 at 12:13 PM CEST, Danilo Krummrich wrote:
> On Sun, Apr 27, 2025 at 08:37:00AM +0000, Benno Lossin wrote:
>> On Sat Apr 26, 2025 at 11:18 PM CEST, Danilo Krummrich wrote:
>> > On Sat, Apr 26, 2025 at 08:24:14PM +0000, Benno Lossin wrote:
>> >> On Sat Apr 26, 2025 at 3:30 PM CEST, Danilo Krummrich wrote:
>> >> > Implement an unsafe direct accessor for the data stored within the
>> >> > Revocable.
>> >> >
>> >> > This is useful for cases where we can proof that the data stored wi=
thin
>> >> > the Revocable is not and cannot be revoked for the duration of the
>> >> > lifetime of the returned reference.
>> >> >
>> >> > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
>> >> > ---
>> >> > The explicit lifetimes in access() probably don't serve a practical
>> >> > purpose, but I found them to be useful for documentation purposes.
>> >> > ---
>> >> >  rust/kernel/revocable.rs | 12 ++++++++++++
>> >> >  1 file changed, 12 insertions(+)
>> >> >
>> >> > diff --git a/rust/kernel/revocable.rs b/rust/kernel/revocable.rs
>> >> > index 971d0dc38d83..33535de141ce 100644
>> >> > --- a/rust/kernel/revocable.rs
>> >> > +++ b/rust/kernel/revocable.rs
>> >> > @@ -139,6 +139,18 @@ pub fn try_access_with<R, F: FnOnce(&T) -> R>(=
&self, f: F) -> Option<R> {
>> >> >          self.try_access().map(|t| f(&*t))
>> >> >      }
>> >> > =20
>> >> > +    /// Directly access the revocable wrapped object.
>> >> > +    ///
>> >> > +    /// # Safety
>> >> > +    ///
>> >> > +    /// The caller must ensure this [`Revocable`] instance hasn't =
been revoked and won't be revoked
>> >> > +    /// for the duration of `'a`.
>> >>=20
>> >> Ah I missed this in my other email, in case you want to directly refe=
r
>> >> to the lifetime, you should keep it defined. I would still remove the
>> >> `'s` lifetime though.
>> >> > +    pub unsafe fn access<'a, 's: 'a>(&'s self) -> &'a T {
>> >> > +        // SAFETY: By the safety requirement of this function it i=
s guaranteed that
>> >> > +        // `self.data.get()` is a valid pointer to an instance of =
`T`.
>> >>=20
>> >> I don't see how the "not-being revoked" state makes the `data` ptr be
>> >> valid. Is that an invariant of `Revocable`? (it's not documented to h=
ave
>> >> any invariants)
>> >
>> > What else makes it valid?
>>=20
>> IMO an `# Invariants` section with the corresponding invariant that
>> `data` is valid when `is_available` is true.
>
> Yeah, I agree that the # Invariants section is indeed missing and should =
be
> fixed.
>
>> > AFAICS, try_access() and try_access_with_guard() argue the exact same =
way,
>> > except that the reason for not being revoked is the atomic check and t=
he RCU
>> > read lock.
>>=20
>> Just because other code is doing the same mistake doesn't make it
>> correct. If I had reviewed the patch at that time I'm sure I would have
>> pointed this out.
>
> I would say that try_access() and try_access_with_guard() are wrong, they=
 rely

Did you mean to write `wouldn't`? Otherwise the second part doesn't
match IMO.

> on the correct thing, we just missed documenting the corresponding invari=
ant.

Yeah it's not a behavior error, but since you agree that something
should be fixed, there also is something that is 'wrong' :)

>> I opened an issue about this:
>>=20
>>     https://github.com/Rust-for-Linux/linux/issues/1160
>
> Thanks for creating the issue!
>
> What do you suggest for this patch?

I don't mind if you take it with the lifetime changes, so

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

But I'd like the invariant to be documented (maybe we should tag the
issue with good-first-issue -- I don't actually think it is one, but
maybe you disagree).

---
Cheers,
Benno


