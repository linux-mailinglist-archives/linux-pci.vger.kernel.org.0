Return-Path: <linux-pci+bounces-26850-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E47DEA9E107
	for <lists+linux-pci@lfdr.de>; Sun, 27 Apr 2025 10:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3BFD3BE05A
	for <lists+linux-pci@lfdr.de>; Sun, 27 Apr 2025 08:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE76925290F;
	Sun, 27 Apr 2025 08:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="lsY6Qfr6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-10630.protonmail.ch (mail-10630.protonmail.ch [79.135.106.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721E324C077;
	Sun, 27 Apr 2025 08:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745743037; cv=none; b=firW6sRr4nBRvuhuOcP4WWjtHUOKDlyJxmWkOjxahKpaO8jgomL3fReol/2Qr9FjtN4smLMJC4h/TqLYGfTFmczj5+58mCjncj6/IawNRfl6Q3UT6DK2jTSv84X4N4dEPMZ1ZacUd+TqlFLTB4ALvZ83Uix9k0HOdNFOWwPw+sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745743037; c=relaxed/simple;
	bh=3Px0MEQtR9pmWCHl3+ClVKKPuBwA62IQu64NZmT05dI=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=R3CiPv0BY7UaRLOfdsNn8PAVVFZS+G+mK4kpGcfICM8bbCbniJsrh4s95j/OW2exFL+ZUqo1akdBB4ksU0t/haJkGkHxHCnm43O3qAM/EcmbGNVE9wZSpotEzuqtYdIQtQAWxoQuyU0mLygww17WAzNlNG9mO+AK6UDwa4PCTdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=lsY6Qfr6; arc=none smtp.client-ip=79.135.106.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1745743026; x=1746002226;
	bh=UQy/H52Qu/1a0jKVAIzkrKssCMVETGtHhAIFXGrHKfo=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=lsY6Qfr6Z7aEnmTFD5JGeaCXkfWdXo6qxVAAGXWCaqzFK378Xkmu6NAG5X0sn1yAf
	 81hChRaYgDsGHFNY1UMii5IseInp8vQT0gIUkeevlTjUvG84yzPYLgDFL4Htb38QnM
	 YxGe6u466EjL2ZtguZ5TYqBam8XCdxkV6+/erb9DvRhpOBfm6tVkNTNUN11kmcl+Qv
	 aJ/WrL1lQtOws85sbri/nTQcVevFv93gVc9hdIeqGFTVyS7ohuHAjn1f1SiAba5smM
	 4o8173AEpj1kETLVj3l/l1h0QduOcr+AvOQTxpdsbCLgbkE+Gf1He6ZsHxY73vndFL
	 7t/hCOP6oAxlw==
Date: Sun, 27 Apr 2025 08:37:00 +0000
To: Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com, kwilczynski@kernel.org, zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, bskeggs@nvidia.com, acurrid@nvidia.com, joelagnelf@nvidia.com, ttabi@nvidia.com, acourbot@nvidia.com, ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu, linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] rust: revocable: implement Revocable::access()
Message-ID: <D9HA92TSMC3M.2CRRX8P64NGD0@proton.me>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: e8cb9f6d9b1b54e92293cb7e4b81efeaa8de43ef
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat Apr 26, 2025 at 11:18 PM CEST, Danilo Krummrich wrote:
> On Sat, Apr 26, 2025 at 08:24:14PM +0000, Benno Lossin wrote:
>> On Sat Apr 26, 2025 at 3:30 PM CEST, Danilo Krummrich wrote:
>> > Implement an unsafe direct accessor for the data stored within the
>> > Revocable.
>> >
>> > This is useful for cases where we can proof that the data stored withi=
n
>> > the Revocable is not and cannot be revoked for the duration of the
>> > lifetime of the returned reference.
>> >
>> > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
>> > ---
>> > The explicit lifetimes in access() probably don't serve a practical
>> > purpose, but I found them to be useful for documentation purposes.
>> > ---
>> >  rust/kernel/revocable.rs | 12 ++++++++++++
>> >  1 file changed, 12 insertions(+)
>> >
>> > diff --git a/rust/kernel/revocable.rs b/rust/kernel/revocable.rs
>> > index 971d0dc38d83..33535de141ce 100644
>> > --- a/rust/kernel/revocable.rs
>> > +++ b/rust/kernel/revocable.rs
>> > @@ -139,6 +139,18 @@ pub fn try_access_with<R, F: FnOnce(&T) -> R>(&se=
lf, f: F) -> Option<R> {
>> >          self.try_access().map(|t| f(&*t))
>> >      }
>> > =20
>> > +    /// Directly access the revocable wrapped object.
>> > +    ///
>> > +    /// # Safety
>> > +    ///
>> > +    /// The caller must ensure this [`Revocable`] instance hasn't bee=
n revoked and won't be revoked
>> > +    /// for the duration of `'a`.
>>=20
>> Ah I missed this in my other email, in case you want to directly refer
>> to the lifetime, you should keep it defined. I would still remove the
>> `'s` lifetime though.
>> > +    pub unsafe fn access<'a, 's: 'a>(&'s self) -> &'a T {
>> > +        // SAFETY: By the safety requirement of this function it is g=
uaranteed that
>> > +        // `self.data.get()` is a valid pointer to an instance of `T`=
.
>>=20
>> I don't see how the "not-being revoked" state makes the `data` ptr be
>> valid. Is that an invariant of `Revocable`? (it's not documented to have
>> any invariants)
>
> What else makes it valid?

IMO an `# Invariants` section with the corresponding invariant that
`data` is valid when `is_available` is true.

> AFAICS, try_access() and try_access_with_guard() argue the exact same way=
,
> except that the reason for not being revoked is the atomic check and the =
RCU
> read lock.

Just because other code is doing the same mistake doesn't make it
correct. If I had reviewed the patch at that time I'm sure I would have
pointed this out.

I opened an issue about this:

    https://github.com/Rust-for-Linux/linux/issues/1160

Feel free to comment any additional information.

---
Cheers,
Benno


