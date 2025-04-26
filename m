Return-Path: <linux-pci+bounces-26838-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0125A9DD33
	for <lists+linux-pci@lfdr.de>; Sat, 26 Apr 2025 23:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 127C39236DA
	for <lists+linux-pci@lfdr.de>; Sat, 26 Apr 2025 21:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883741F4C99;
	Sat, 26 Apr 2025 21:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HHDW/jas"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8BF1D5CDD;
	Sat, 26 Apr 2025 21:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745702649; cv=none; b=NyK/c4duVpb4g/FbK1FSNkQ6qYKOGz4W0qIF2rXnr8oPMt5DHhSCVn3TwDEPVgnGH9tRO4+yJf9YBZz1yLYo+G4IjEF9TAg1V2vo2HLcE9EyYRs/so8RK1jWY656TD254g0EoNv+OGqJVNaz3xrphLIMZUVJMa+8K2Utixwm220=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745702649; c=relaxed/simple;
	bh=KLJnmowEU+MNFxEcyRwWXecaoBq3TaKxQVFB2EjCS64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k6O0CXcFwBntrdengXTBLeMziAPKTL+ZnI677cOLfpwp44VSk4ojmKDxdvHYqA7T8BYbrUtmmgHm0B7G0v87pecueXvX7j/w6vuhOY9MLD9M6eTiammU/djJAwMlEv+MtBUsLb4rLudtaSih1io1WHtNE/1D3naSL2B3yFasLI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HHDW/jas; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FD93C4CEE2;
	Sat, 26 Apr 2025 21:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745702648;
	bh=KLJnmowEU+MNFxEcyRwWXecaoBq3TaKxQVFB2EjCS64=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HHDW/jas22rogQcHXyRbn73zocRA7tKgEeZL6XGO+/fEnn7FZfvQGswBIy7LfayiG
	 eSSfQG+R/XmYm6JOo2OexX5rPOaHH2mQpQhVWEqBjCylWCZTSpRB2SxBJ2/uxz+Ocp
	 Q23DBCsCZeUsjY00sjtGZLTsKDtXUT28KyhacRXxCsuC8lWhufoUPQXwIL8+ECFYnf
	 hRfFSRDr3qqSoOXnNZ+ZksZurGwSWvvvTFuvp7eUtqoc3Kqz7IJtDkErYYcALcpXgB
	 y1w6BnvvNk00dEj4MwhTyNG9PQm2tt8VTpK8Sd6cmBgb5SisnsiTeCtW4Zqclkdwp+
	 nzyj5TkjhH/KA==
Date: Sat, 26 Apr 2025 23:24:01 +0200
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
Subject: Re: [PATCH 2/3] rust: devres: implement Devres::access_with()
Message-ID: <aA1O8Wem1FhyybF5@pollux>
References: <D9GUR8Y08PQ6.2ULV6V4UJAGQB@proton.me>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D9GUR8Y08PQ6.2ULV6V4UJAGQB@proton.me>

On Sat, Apr 26, 2025 at 08:28:30PM +0000, Benno Lossin wrote:
> On Sat Apr 26, 2025 at 3:30 PM CEST, Danilo Krummrich wrote:
> > Implement a direct accessor for the data stored within the Devres for
> > cases where we can proof that we own a reference to a Device<Bound>
> > (i.e. a bound device) of the same device that was used to create the
> > corresponding Devres container.
> >
> > Usually, when accessing the data stored within a Devres container, it is
> > not clear whether the data has been revoked already due to the device
> > being unbound and, hence, we have to try whether the access is possible
> > and subsequently keep holding the RCU read lock for the duration of the
> > access.
> >
> > However, when we can proof that we hold a reference to Device<Bound>
> > matching the device the Devres container has been created with, we can
> > guarantee that the device is not unbound for the duration of the
> > lifetime of the Device<Bound> reference and, hence, it is not possible
> > for the data within the Devres container to be revoked.
> >
> > Therefore, in this case, we can bypass the atomic check and the RCU read
> > lock, which is a great optimization and simplification for drivers.
> >
> > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> > ---
> >  rust/kernel/devres.rs | 35 +++++++++++++++++++++++++++++++++++
> >  1 file changed, 35 insertions(+)
> >
> > diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
> > index 1e58f5d22044..ec2cd9cdda8b 100644
> > --- a/rust/kernel/devres.rs
> > +++ b/rust/kernel/devres.rs
> > @@ -181,6 +181,41 @@ pub fn new_foreign_owned(dev: &Device<Bound>, data: T, flags: Flags) -> Result {
> >  
> >          Ok(())
> >      }
> > +
> > +    /// Obtain `&'a T`, bypassing the [`Revocable`].
> > +    ///
> > +    /// This method allows to directly obtain a `&'a T`, bypassing the [`Revocable`], by presenting
> > +    /// a `&'a Device<Bound>` of the same [`Device`] this [`Devres`] instance has been created with.
> > +    ///
> > +    /// An error is returned if `dev` does not match the same [`Device`] this [`Devres`] instance
> > +    /// has been created with.
> > +    ///
> > +    /// # Example
> > +    ///
> > +    /// ```no_run
> 
> The `no_run` is not necessary, as you don't run any code, you only
> define a function.

Yet, I'd like to keep it to make it obvious that this test isn't supposed to
run.

> > +    /// # use kernel::{device::Core, devres::Devres, pci};
> > +    ///
> > +    /// fn from_core(dev: &pci::Device<Core>, devres: Devres<pci::Bar<0x4>>) -> Result<()> {
> > +    ///     let bar = devres.access_with(dev.as_ref())?;
> > +    ///
> > +    ///     let _ = bar.read32(0x0);
> > +    ///
> > +    ///     // might_sleep()
> > +    ///
> > +    ///     bar.write32(0x42, 0x0);
> > +    ///
> > +    ///     Ok(())
> > +    /// }
> 
> Missing '```'?

Good catch -- interestingly the doctest did compile anyways.

> 
> > +    pub fn access_with<'s, 'd: 's>(&'s self, dev: &'d Device<Bound>) -> Result<&'s T> {
> 
> I don't think that we need the `'d` lifetime here (if not, we should
> remove it).

If the returned reference out-lives dev it can become invalid, since it means
that the device could subsequently be unbound. Hence, I think we indeed need to
require that the returned reference cannot out-live dev.

