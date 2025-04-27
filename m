Return-Path: <linux-pci+bounces-26884-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A103EA9E414
	for <lists+linux-pci@lfdr.de>; Sun, 27 Apr 2025 19:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C81F23A9F9E
	for <lists+linux-pci@lfdr.de>; Sun, 27 Apr 2025 17:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0611DE3C0;
	Sun, 27 Apr 2025 17:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sWezRnjw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F764142E67;
	Sun, 27 Apr 2025 17:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745774918; cv=none; b=TZ3Znw+4Ijbf2n9pnzay2nAIgnUrJNNtZb59GgcNz7LQ/Sjxt7INC8eSUAxKPhN/piAFZTBpqHSM5mkwru/Rzp4BlYi2eP1Y/CDTFRVseh9WDFDZQ95JVaxfs1vLjCQdZkEDbFkghKBqUW6AL7imfzJ+lXEL58gZTYNDth5tV6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745774918; c=relaxed/simple;
	bh=JrwaRlQRSbsnDWUu8IbBHR4MU4nqMGZK9i4gOpXUCBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AsROD9wA/II3HKTx2diW7VvQejnkPOyjY1JQYd9QYQv8R5VlGkuXeO9i5Nn1Nb3B9QKd3TWdqmZi4wf1jbCB6SjRneXB2KfgxUeS3fgF7lcAxpaxoZo2HaWDYHQScgvt0hoE9VKQHysFXGVaf8I+NKzFg0TAHK0KtmmXTMS3624=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sWezRnjw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1347FC4CEE3;
	Sun, 27 Apr 2025 17:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745774917;
	bh=JrwaRlQRSbsnDWUu8IbBHR4MU4nqMGZK9i4gOpXUCBo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sWezRnjwEwe4W/vTCGZD6EzWc+ng2GZn1SNhcVfbRX2Gt3mGeemTBxqbMV7SEv6V+
	 /qP0OJqTyfuy6UP75avtZVw0bGQz7Z1rY91rXj+yAMl1gByUeX4hpaq3/vrBJMxsZW
	 xKwoaFbyhfWqbKxi/6jglVtDoCGRGNpK6vEkycx95vN/+QqMrYI18iyTBAkx7X7q0x
	 5cY09FA5OjJdck/Way8CiGV76uPDPniHJnwizzQCWQzFfwIAIFycN0jmscNJwgqQOK
	 npf+1TzgDJeX5ozl/tP2GTWbF/bfLSFrSerTrKUXwAYEI/ovTBX5ksEw5x66A8oKpn
	 r8DXZIQLcPYBQ==
Date: Sun, 27 Apr 2025 19:28:30 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Benno Lossin <benno.lossin@proton.me>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com,
	kwilczynski@kernel.org, zhiw@nvidia.com, cjia@nvidia.com,
	jhubbard@nvidia.com, bskeggs@nvidia.com, acurrid@nvidia.com,
	joelagnelf@nvidia.com, ttabi@nvidia.com, acourbot@nvidia.com,
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@kernel.org,
	aliceryhl@google.com, tmgross@umich.edu, linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] rust: revocable: implement Revocable::access()
Message-ID: <aA5pPsMRP-0Vjmgv@pollux>
References: <D9HA92TSMC3M.2CRRX8P64NGD0@proton.me>
 <aA4DNEHgrKMmzxBP@pollux>
 <D9HLAAZJRDKB.3CRXXMTLLPQ9J@proton.me>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D9HLAAZJRDKB.3CRXXMTLLPQ9J@proton.me>

On Sun, Apr 27, 2025 at 05:15:48PM +0000, Benno Lossin wrote:
> On Sun Apr 27, 2025 at 12:13 PM CEST, Danilo Krummrich wrote:
> > On Sun, Apr 27, 2025 at 08:37:00AM +0000, Benno Lossin wrote:
> >> On Sat Apr 26, 2025 at 11:18 PM CEST, Danilo Krummrich wrote:
> >> > On Sat, Apr 26, 2025 at 08:24:14PM +0000, Benno Lossin wrote:
> >> >> On Sat Apr 26, 2025 at 3:30 PM CEST, Danilo Krummrich wrote:
> >> >> > Implement an unsafe direct accessor for the data stored within the
> >> >> > Revocable.
> >> >> >
> >> >> > This is useful for cases where we can proof that the data stored within
> >> >> > the Revocable is not and cannot be revoked for the duration of the
> >> >> > lifetime of the returned reference.
> >> >> >
> >> >> > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> >> >> > ---
> >> >> > The explicit lifetimes in access() probably don't serve a practical
> >> >> > purpose, but I found them to be useful for documentation purposes.
> >> >> > ---
> >> >> >  rust/kernel/revocable.rs | 12 ++++++++++++
> >> >> >  1 file changed, 12 insertions(+)
> >> >> >
> >> >> > diff --git a/rust/kernel/revocable.rs b/rust/kernel/revocable.rs
> >> >> > index 971d0dc38d83..33535de141ce 100644
> >> >> > --- a/rust/kernel/revocable.rs
> >> >> > +++ b/rust/kernel/revocable.rs
> >> >> > @@ -139,6 +139,18 @@ pub fn try_access_with<R, F: FnOnce(&T) -> R>(&self, f: F) -> Option<R> {
> >> >> >          self.try_access().map(|t| f(&*t))
> >> >> >      }
> >> >> >  
> >> >> > +    /// Directly access the revocable wrapped object.
> >> >> > +    ///
> >> >> > +    /// # Safety
> >> >> > +    ///
> >> >> > +    /// The caller must ensure this [`Revocable`] instance hasn't been revoked and won't be revoked
> >> >> > +    /// for the duration of `'a`.
> >> >> 
> >> >> Ah I missed this in my other email, in case you want to directly refer
> >> >> to the lifetime, you should keep it defined. I would still remove the
> >> >> `'s` lifetime though.
> >> >> > +    pub unsafe fn access<'a, 's: 'a>(&'s self) -> &'a T {
> >> >> > +        // SAFETY: By the safety requirement of this function it is guaranteed that
> >> >> > +        // `self.data.get()` is a valid pointer to an instance of `T`.
> >> >> 
> >> >> I don't see how the "not-being revoked" state makes the `data` ptr be
> >> >> valid. Is that an invariant of `Revocable`? (it's not documented to have
> >> >> any invariants)
> >> >
> >> > What else makes it valid?
> >> 
> >> IMO an `# Invariants` section with the corresponding invariant that
> >> `data` is valid when `is_available` is true.
> >
> > Yeah, I agree that the # Invariants section is indeed missing and should be
> > fixed.
> >
> >> > AFAICS, try_access() and try_access_with_guard() argue the exact same way,
> >> > except that the reason for not being revoked is the atomic check and the RCU
> >> > read lock.
> >> 
> >> Just because other code is doing the same mistake doesn't make it
> >> correct. If I had reviewed the patch at that time I'm sure I would have
> >> pointed this out.
> >
> > I would say that try_access() and try_access_with_guard() are wrong, they rely
> 
> Did you mean to write `wouldn't`? Otherwise the second part doesn't
> match IMO.

Yes, I meant "wouldn't". :)

> 
> > on the correct thing, we just missed documenting the corresponding invariant.
> 
> Yeah it's not a behavior error, but since you agree that something
> should be fixed, there also is something that is 'wrong' :)
> 
> >> I opened an issue about this:
> >> 
> >>     https://github.com/Rust-for-Linux/linux/issues/1160
> >
> > Thanks for creating the issue!
> >
> > What do you suggest for this patch?
> 
> I don't mind if you take it with the lifetime changes, so
> 
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> 
> But I'd like the invariant to be documented (maybe we should tag the
> issue with good-first-issue -- I don't actually think it is one, but
> maybe you disagree).

Yes, it should be documented; regarding the issue you created, I'd be fine
marking it as good-first-issue.

But I'd also be fine sending a fix for this myself outside the scope of this
series.

