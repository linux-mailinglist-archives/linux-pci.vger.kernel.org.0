Return-Path: <linux-pci+bounces-26871-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CACFEA9E378
	for <lists+linux-pci@lfdr.de>; Sun, 27 Apr 2025 16:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FA641898536
	for <lists+linux-pci@lfdr.de>; Sun, 27 Apr 2025 14:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A367586347;
	Sun, 27 Apr 2025 14:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ADklFkzv"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77ABB23AD;
	Sun, 27 Apr 2025 14:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745763463; cv=none; b=jQENo1Gqk26MSWl9c7v0fILkFkaJ0180A/0Y+VNckxvJFXNbuCZHsrZIaAcMDM2bAzhMx3DP3dJ6htiXRIzCISwq0zafs7hIRc88wkt9LhbQCon58Y8SsUqAjPJsxvnLl+CEZAWqjNl0+e9exHfuNyKCr5cBnUT1OfkeuUtpHS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745763463; c=relaxed/simple;
	bh=MacNpFrVB9lWzT12etspQTBQaCfmPqMr9/4hdD7jTA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=saBYVVSeYDN2u1cZKoha6jvx8AkJ582s9+dah3Kltgvz/2SAXauD/cJLk1ZV2xOT5y2du5LkTHr64dy2audFCdLrYwGckAtWLCv+dFaVaxW0J4d1Eq7G69vmimQzxzYHczq6gwEJaq/yb9YTdFY29300Pwg6f2V80vx12NbMaTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ADklFkzv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AAFFC4CEE3;
	Sun, 27 Apr 2025 14:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745763462;
	bh=MacNpFrVB9lWzT12etspQTBQaCfmPqMr9/4hdD7jTA0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ADklFkzv+4jwcEEx/tTAg0khYw6qhHY7i23kzmvV1iS56dwwV/3mxN7so7Vh44qjG
	 J6V2spXCw6NcJBPE2iRXKfyj/wjUiZbYdGYgow1fsSqHTY/YuOifTzzam1TBWNNC0I
	 hHHKg1KYztcCA65o6MYfSTluy5yIln9ExswXrmsnmB0tnk7gGJUC837ADiSJn95Pca
	 EGD4tbgUIm+PDXZiktZZHSTsUyi4iw16FuVFEd1KIHlHXLr0jvFbfZ2kPF7JNeA+oG
	 CEkMt3wAIVhP+4JPr42dVHVFPHHkqPF4219+folsVha50SVzO8UuDywiv+KmZCIH1z
	 e5wFKxr6lns/w==
Date: Sun, 27 Apr 2025 16:17:35 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com,
	kwilczynski@kernel.org, zhiw@nvidia.com, cjia@nvidia.com,
	jhubbard@nvidia.com, bskeggs@nvidia.com, acurrid@nvidia.com,
	joelagnelf@nvidia.com, ttabi@nvidia.com, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] rust: devres: implement Devres::access_with()
Message-ID: <aA48f5Bbhe6ZXGJX@pollux>
References: <20250426133254.61383-1-dakr@kernel.org>
 <20250426133254.61383-3-dakr@kernel.org>
 <D9HG66ONN8E4.1DK7SLRLD0YJZ@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D9HG66ONN8E4.1DK7SLRLD0YJZ@nvidia.com>

On Sun, Apr 27, 2025 at 10:15:17PM +0900, Alexandre Courbot wrote:
> On Sat Apr 26, 2025 at 10:30 PM JST, Danilo Krummrich wrote:
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
> > +    pub fn access_with<'s, 'd: 's>(&'s self, dev: &'d Device<Bound>) -> Result<&'s T> {
> 
> Coming from `Revocable::try_access_with` (and the standard library in
> general), the name of this method made me think that it would take a
> closure to run while the resource is held. Maybe we should differenciate
> the names a bit more? Maybe just `access` is fine, or
> `access_with_device`?

Seems reasonable -- access() it is then.

