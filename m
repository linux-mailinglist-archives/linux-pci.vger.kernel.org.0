Return-Path: <linux-pci+bounces-26837-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF8F1A9DD31
	for <lists+linux-pci@lfdr.de>; Sat, 26 Apr 2025 23:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D1E81698CB
	for <lists+linux-pci@lfdr.de>; Sat, 26 Apr 2025 21:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8BC1F30B3;
	Sat, 26 Apr 2025 21:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MfburaK5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF3018C01D;
	Sat, 26 Apr 2025 21:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745702331; cv=none; b=ax2rzVB2y1iM8uDQjC96p8yBQ+QVED+W1Ut4D5h3RRoFzTIvu3SRf94xgD/2DI67MruUjlljMkeEQZfmdLovN4rplCUZiaMOgcsf4w67PEZ6mb5c6eTMVRDnw4GK7f8QYzrHgHjvhDZdOdaO1y+CKxKYTa6Y9ty66oQrnOLdQRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745702331; c=relaxed/simple;
	bh=FWU3uRb/BVym7zV1oNgyiAOCm/+1+K1NCZVD2UFQRTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nTwYksvIeflxpKP1er6ie+gPQpZJGKwxgAWoYkQ0I9CYyqNIFv9jOnp2tqBHehg07P0SW+bhmD4p3+efr5Mvb5WBtvIvd1xmU0JMEscXE/0L5AtennMZZgkdkvx4YvXLAO59ZjXH2rP6OQqnmNCYnEAdjS+XYn9bapVrbnOpz9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MfburaK5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30BDEC4CEE2;
	Sat, 26 Apr 2025 21:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745702330;
	bh=FWU3uRb/BVym7zV1oNgyiAOCm/+1+K1NCZVD2UFQRTY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MfburaK5/HqL4wosqJEf6RzRQObnrRIObbxbrKUnFJ5owVmcvRouzoX3laglt0412
	 QEvTL1/+QxaZkjfIdbqEml0YSw9KArNhFNqWJvisWt8pTAG/hs8vCAmC7Y72oq/mnj
	 uiW0/NbWw8FHdSkIRncA/Q3RdoNY6Yg6YdArjLG4MKEEoRddWCRlZCV4h3EThlYu4X
	 wP5whI3R+g0gZT0qpiKxA1B62QByDOsY10R15yJgBJL93+QKo/TTzRBygIUPfwRyBm
	 tkQTBpPMPhy1/+HnL3J+JaSelAIKIQqbhZE9rAT8Oo1lFYWtE73dUJcFGAWWWuR48Z
	 kXPM/jstjjqiw==
Date: Sat, 26 Apr 2025 23:18:43 +0200
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
Message-ID: <aA1Ns2GELPVbEsWV@pollux>
References: <20250426133254.61383-1-dakr@kernel.org>
 <20250426133254.61383-2-dakr@kernel.org>
 <D9GUNZ0PMDA4.AZXA0FWQUSB0@proton.me>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D9GUNZ0PMDA4.AZXA0FWQUSB0@proton.me>

On Sat, Apr 26, 2025 at 08:24:14PM +0000, Benno Lossin wrote:
> On Sat Apr 26, 2025 at 3:30 PM CEST, Danilo Krummrich wrote:
> > Implement an unsafe direct accessor for the data stored within the
> > Revocable.
> >
> > This is useful for cases where we can proof that the data stored within
> > the Revocable is not and cannot be revoked for the duration of the
> > lifetime of the returned reference.
> >
> > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> > ---
> > The explicit lifetimes in access() probably don't serve a practical
> > purpose, but I found them to be useful for documentation purposes.
> > ---
> >  rust/kernel/revocable.rs | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/rust/kernel/revocable.rs b/rust/kernel/revocable.rs
> > index 971d0dc38d83..33535de141ce 100644
> > --- a/rust/kernel/revocable.rs
> > +++ b/rust/kernel/revocable.rs
> > @@ -139,6 +139,18 @@ pub fn try_access_with<R, F: FnOnce(&T) -> R>(&self, f: F) -> Option<R> {
> >          self.try_access().map(|t| f(&*t))
> >      }
> >  
> > +    /// Directly access the revocable wrapped object.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// The caller must ensure this [`Revocable`] instance hasn't been revoked and won't be revoked
> > +    /// for the duration of `'a`.
> 
> Ah I missed this in my other email, in case you want to directly refer
> to the lifetime, you should keep it defined. I would still remove the
> `'s` lifetime though.
> > +    pub unsafe fn access<'a, 's: 'a>(&'s self) -> &'a T {
> > +        // SAFETY: By the safety requirement of this function it is guaranteed that
> > +        // `self.data.get()` is a valid pointer to an instance of `T`.
> 
> I don't see how the "not-being revoked" state makes the `data` ptr be
> valid. Is that an invariant of `Revocable`? (it's not documented to have
> any invariants)

What else makes it valid?

AFAICS, try_access() and try_access_with_guard() argue the exact same way,
except that the reason for not being revoked is the atomic check and the RCU
read lock.

