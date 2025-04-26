Return-Path: <linux-pci+bounces-26818-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 110B8A9DC5A
	for <lists+linux-pci@lfdr.de>; Sat, 26 Apr 2025 19:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9089189E855
	for <lists+linux-pci@lfdr.de>; Sat, 26 Apr 2025 17:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CAC925CC62;
	Sat, 26 Apr 2025 17:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qnZm/dRe"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F80F1CAA76;
	Sat, 26 Apr 2025 17:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745686920; cv=none; b=KW3fXc9Jq7C81iT4OqFuVN99WRF5IERYuhzXKH07npVgrsE1mjbl6TiVb5WFiH0WvUj4u5eHMSne/1jJDcX15g5vEInshUEJI2Tof4iQQPznlSypVy9KisvUpKpf5tAZVq7NlE3DGvzo/bBonCTeHBOkCzMWPIsn4NYX7VGrFJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745686920; c=relaxed/simple;
	bh=hvrz2uwnGlKsmzVeQ9Y+XaSecVGgqpeRchSHNjiI4w8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mHw+dhr4BYNN96riB/+F29FfGrNvrRz+qsTi7bo4oit1IrEt62ICCj+VOOUVhpWTRwGI/EF9AF8Of6Kbv4+CdrYmSGNv7Lev9shr0QJ5hDexBxiC1AteBgQcDQrpCwBr7Rh81OKa+ZPNnUQXuGCU/nhNDTzoy6v8SjdjifVvEdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qnZm/dRe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5A6EC4CEE2;
	Sat, 26 Apr 2025 17:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745686919;
	bh=hvrz2uwnGlKsmzVeQ9Y+XaSecVGgqpeRchSHNjiI4w8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qnZm/dRecBoiRyVCytzDzwHr3sEwp4g2qM3Op0Fr0E0Mtz/mDYIbZPV9C8JcQyMrG
	 Rt5zVE92udlKBHqVEF4S8AtysIZf0QTTPDRjCfeGGDtyw6ZeuO2BhZH9MAaTIrqhx7
	 LTCqZfiuhm65/17YS1Crt4S0qvdTO8efqsm+b/7P/xYLRgtoL/b104N5IKJfyGv7rL
	 k/7DX1UwVpKywkJ6mLKx7zZG2V6TC4P52HryY69WwpxqZrpDAD7wpB7W2P/gIzZ9wR
	 /fP8G37Sg1aWc172Ykf0hUscotOWfL7goku33CcRI9zooMwMbQdVqr2jUL71XCPQaI
	 aPunVHxsb1e2w==
Date: Sat, 26 Apr 2025 19:01:52 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Christian Schrefl <chrisi.schrefl@gmail.com>,
	gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com,
	kwilczynski@kernel.org, zhiw@nvidia.com, cjia@nvidia.com,
	jhubbard@nvidia.com, bskeggs@nvidia.com, acurrid@nvidia.com,
	joelagnelf@nvidia.com, ttabi@nvidia.com, acourbot@nvidia.com,
	ojeda@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] rust: revocable: implement Revocable::access()
Message-ID: <aA0RgOL09bBa0M19@pollux>
References: <20250426133254.61383-1-dakr@kernel.org>
 <20250426133254.61383-2-dakr@kernel.org>
 <aa747122-fc78-45db-a410-ceb53b4df65e@gmail.com>
 <aA0P4lr0A2s--5bI@Mac.home>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aA0P4lr0A2s--5bI@Mac.home>

On Sat, Apr 26, 2025 at 09:54:58AM -0700, Boqun Feng wrote:
> On Sat, Apr 26, 2025 at 06:44:03PM +0200, Christian Schrefl wrote:
> > On 26.04.25 3:30 PM, Danilo Krummrich wrote:
> > > Implement an unsafe direct accessor for the data stored within the
> > > Revocable.
> > > 
> > > This is useful for cases where we can proof that the data stored within
> > > the Revocable is not and cannot be revoked for the duration of the
> > > lifetime of the returned reference.
> > > 
> > > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> > > ---
> > > The explicit lifetimes in access() probably don't serve a practical
> > > purpose, but I found them to be useful for documentation purposes.
> > > --->  rust/kernel/revocable.rs | 12 ++++++++++++
> > >  1 file changed, 12 insertions(+)
> > > 
> > > diff --git a/rust/kernel/revocable.rs b/rust/kernel/revocable.rs
> > > index 971d0dc38d83..33535de141ce 100644
> > > --- a/rust/kernel/revocable.rs
> > > +++ b/rust/kernel/revocable.rs
> > > @@ -139,6 +139,18 @@ pub fn try_access_with<R, F: FnOnce(&T) -> R>(&self, f: F) -> Option<R> {
> > >          self.try_access().map(|t| f(&*t))
> > >      }
> > >  
> > > +    /// Directly access the revocable wrapped object.
> > > +    ///
> > > +    /// # Safety
> > > +    ///
> > > +    /// The caller must ensure this [`Revocable`] instance hasn't been revoked and won't be revoked
> > > +    /// for the duration of `'a`.
> > > +    pub unsafe fn access<'a, 's: 'a>(&'s self) -> &'a T {
> > I'm not sure if the `'s` lifetime really carries much meaning here.
> > I find just (explicit) `'a` on both parameter and return value is clearer to me,
> > but I'm not sure what others (particularly those not very familiar with rust)
> > think of this.
> 
> Yeah, I don't think we need two lifetimes here, the following version
> should be fine (with implicit lifetime):
> 
> 	pub unsafe fn access(&self) -> &T { ... }
> 
> , because if you do:
> 
> 	let revocable: &'1 Revocable = ...;
> 	...
> 	let t: &'2 T = unsafe { revocable.access() };
> 
> '1 should already outlive '2 (i.e. '1: '2).

Yes, this is indeed sufficient, that's why I wrote

	"The explicit lifetimes in access() probably don't serve a practical
	purpose, but I found them to be useful for documentation purposes."

below the commit message. :)

Any opinions in terms of documentation purposes?

> > 
> > Either way:
> > 
> > Reviewed-by: Christian Schrefl <chrisi.schrefl@gmail.com>
> > 
> > > +        // SAFETY: By the safety requirement of this function it is guaranteed that
> > > +        // `self.data.get()` is a valid pointer to an instance of `T`.
> > > +        unsafe { &*self.data.get() }
> > > +    }
> > > +
> > >      /// # Safety
> > >      ///
> > >      /// Callers must ensure that there are no more concurrent users of the revocable object.
> > 

