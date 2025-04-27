Return-Path: <linux-pci+bounces-26856-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2F1A9E264
	for <lists+linux-pci@lfdr.de>; Sun, 27 Apr 2025 12:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7849189F100
	for <lists+linux-pci@lfdr.de>; Sun, 27 Apr 2025 10:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB852405E5;
	Sun, 27 Apr 2025 10:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="udUSNP0I"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02E61ABEC5;
	Sun, 27 Apr 2025 10:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745748798; cv=none; b=bFOK8Q2vkFcXYPKZXRlqdn6HucFUpPRF+C24MDdyb2C3m0TZrxUPIvPzLeNNWy1D2tBCNlN55VjypoWzRnIrLAEiRZPqoG+gmiz8ffqm2nUcIuMz1j2Y4Uw9CtxfpbeEJbKd1PxNLvehLlkM6FZY10r0gguC+qVqch0mHcqqAak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745748798; c=relaxed/simple;
	bh=yegWmCWPr2oBxNhpO1pLh+k+JNbNoD8FKo7GQBRmCuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mxJ22+zNYkDW6isSR2dNs2H7c4SWyG00GFGvBHMI2AjyPStFVAOuxHTM+XXnYSmnvgow8k5CunuFyNcXR4b+ExlAPWcZbq0/9oX09hsnG0+7aCBa1Gwx10JpiYGoQYiucrU/gOtxogDuqOKvnjZXMnPNxFkzzW5Cn9pn+Dk2bo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=udUSNP0I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 905FEC4CEE3;
	Sun, 27 Apr 2025 10:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745748796;
	bh=yegWmCWPr2oBxNhpO1pLh+k+JNbNoD8FKo7GQBRmCuA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=udUSNP0IT8mcewRV2I8tuq9DP95xYgTlZ7nt+etgUFssGHTIMXDnKCRuAjv6sxKbq
	 MkFWDdM1bWjKLAYoqeqDqxnDw4NJXs3rVA0iFw1YRewHpCYmO7RwPci+IDD2nCr/vj
	 cI++n+TrL7q7SKO5vTKyconTFptAEzbVto57W2cwBLDD9y+dNr0QLgjvR6cHT6EXxS
	 264GbpV6Xwk1W4QinDdw5kweYwCRClDl677vTXzRL+6CIXk2dOHtc0O+TjUxB0CcRN
	 OuAaayF1Zrtw1TdS2B3YjBJXlXf8jUZ1f+L7U92+KULcGWSHioEKU/2X8Q+UPODJbl
	 gwwCBC5hs6rxA==
Date: Sun, 27 Apr 2025 12:13:08 +0200
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
Message-ID: <aA4DNEHgrKMmzxBP@pollux>
References: <D9HA92TSMC3M.2CRRX8P64NGD0@proton.me>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D9HA92TSMC3M.2CRRX8P64NGD0@proton.me>

On Sun, Apr 27, 2025 at 08:37:00AM +0000, Benno Lossin wrote:
> On Sat Apr 26, 2025 at 11:18 PM CEST, Danilo Krummrich wrote:
> > On Sat, Apr 26, 2025 at 08:24:14PM +0000, Benno Lossin wrote:
> >> On Sat Apr 26, 2025 at 3:30 PM CEST, Danilo Krummrich wrote:
> >> > Implement an unsafe direct accessor for the data stored within the
> >> > Revocable.
> >> >
> >> > This is useful for cases where we can proof that the data stored within
> >> > the Revocable is not and cannot be revoked for the duration of the
> >> > lifetime of the returned reference.
> >> >
> >> > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> >> > ---
> >> > The explicit lifetimes in access() probably don't serve a practical
> >> > purpose, but I found them to be useful for documentation purposes.
> >> > ---
> >> >  rust/kernel/revocable.rs | 12 ++++++++++++
> >> >  1 file changed, 12 insertions(+)
> >> >
> >> > diff --git a/rust/kernel/revocable.rs b/rust/kernel/revocable.rs
> >> > index 971d0dc38d83..33535de141ce 100644
> >> > --- a/rust/kernel/revocable.rs
> >> > +++ b/rust/kernel/revocable.rs
> >> > @@ -139,6 +139,18 @@ pub fn try_access_with<R, F: FnOnce(&T) -> R>(&self, f: F) -> Option<R> {
> >> >          self.try_access().map(|t| f(&*t))
> >> >      }
> >> >  
> >> > +    /// Directly access the revocable wrapped object.
> >> > +    ///
> >> > +    /// # Safety
> >> > +    ///
> >> > +    /// The caller must ensure this [`Revocable`] instance hasn't been revoked and won't be revoked
> >> > +    /// for the duration of `'a`.
> >> 
> >> Ah I missed this in my other email, in case you want to directly refer
> >> to the lifetime, you should keep it defined. I would still remove the
> >> `'s` lifetime though.
> >> > +    pub unsafe fn access<'a, 's: 'a>(&'s self) -> &'a T {
> >> > +        // SAFETY: By the safety requirement of this function it is guaranteed that
> >> > +        // `self.data.get()` is a valid pointer to an instance of `T`.
> >> 
> >> I don't see how the "not-being revoked" state makes the `data` ptr be
> >> valid. Is that an invariant of `Revocable`? (it's not documented to have
> >> any invariants)
> >
> > What else makes it valid?
> 
> IMO an `# Invariants` section with the corresponding invariant that
> `data` is valid when `is_available` is true.

Yeah, I agree that the # Invariants section is indeed missing and should be
fixed.

> > AFAICS, try_access() and try_access_with_guard() argue the exact same way,
> > except that the reason for not being revoked is the atomic check and the RCU
> > read lock.
> 
> Just because other code is doing the same mistake doesn't make it
> correct. If I had reviewed the patch at that time I'm sure I would have
> pointed this out.

I would say that try_access() and try_access_with_guard() are wrong, they rely
on the correct thing, we just missed documenting the corresponding invariant.

> I opened an issue about this:
> 
>     https://github.com/Rust-for-Linux/linux/issues/1160

Thanks for creating the issue!

What do you suggest for this patch?

