Return-Path: <linux-pci+bounces-26820-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E37C0A9DC67
	for <lists+linux-pci@lfdr.de>; Sat, 26 Apr 2025 19:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CBC93A781B
	for <lists+linux-pci@lfdr.de>; Sat, 26 Apr 2025 17:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8A325C816;
	Sat, 26 Apr 2025 17:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RbGzn+B2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012E0256D;
	Sat, 26 Apr 2025 17:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745687337; cv=none; b=qiAACNRDXiTQz0xP8haqV1L/iLDMr6Ef2m5CEoObgjWDZbpPmWyn4GVxLI8wtpueaDmxcLBn/EeVFoQxqjIDhZeXD203SvvkQ1eviV2wy5Wsn35GvTFeQCHnGzMmvJrF4DAzrYypDtOhQxpy+48jQd+zjjucH2OvFgJAZ+f5yrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745687337; c=relaxed/simple;
	bh=9xTpt515mVMexZkpY9oSymik5OAqq+uVThMuFMeNnj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oAfVquoanLEwkoVSrgxNyRF/8390yACKW+KwTxBigQjJKrzs2BV0p/l+AULsqpUeJ7VgJQT4NscxVRF68gZLIbf9coH7GcZkVVW8GALWZnBdkR2vxWVttuiG6Y4KXsbQ4ALA0KI6tGOoJg/TLzCYEo0UDSfJ4fmPS2s6jzniU0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RbGzn+B2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E2E7C4CEE2;
	Sat, 26 Apr 2025 17:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745687336;
	bh=9xTpt515mVMexZkpY9oSymik5OAqq+uVThMuFMeNnj0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RbGzn+B2dPs0ajfjhoXtKJWPLn3TfRAIoiCuRRIHmVGn9aIurFlNvcTC4gRWg0NVZ
	 OplFRy+SlqSBRC88RqcMjJmMvf9wjPJIzWYifsjlcmzCIpiBGGnVL6zRIwm4pZsbtQ
	 LAeaR8gK4NSz9A5Qf1MFpUbedsDm9bSOtzll8NwsNr8Q0QbRjdsXS/myCOwXANnEYG
	 aQzgwwz7gNzBFDAgDAO/XsYmKlMbQDIGY+BgOX8n2S64nRDMp5O2ZgTibG3I+kh7Q+
	 9VDPGx2FeVBTgPY2HiROSgIub9EeXmCu5hmXrERC1+cfLy7uLNj1x8QRg538J4sJGu
	 D+W04vcqywt8A==
Date: Sat, 26 Apr 2025 19:08:49 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Christian Schrefl <chrisi.schrefl@gmail.com>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com,
	kwilczynski@kernel.org, zhiw@nvidia.com, cjia@nvidia.com,
	jhubbard@nvidia.com, bskeggs@nvidia.com, acurrid@nvidia.com,
	joelagnelf@nvidia.com, ttabi@nvidia.com, acourbot@nvidia.com,
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] rust: devres: implement Devres::access_with()
Message-ID: <aA0TIWj50RYogLxj@pollux>
References: <20250426133254.61383-1-dakr@kernel.org>
 <20250426133254.61383-3-dakr@kernel.org>
 <ce224b78-5c26-46d9-9b69-6bceb1bda62d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce224b78-5c26-46d9-9b69-6bceb1bda62d@gmail.com>

On Sat, Apr 26, 2025 at 06:53:10PM +0200, Christian Schrefl wrote:
> On 26.04.25 3:30 PM, Danilo Krummrich wrote:
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
> 
> I would prefer this as a `# Errors` section.

I can make this an # Errors section.

> Also are there any cases where this is actually wanted as an error?
> I'm not very familiar with the `Revocable` infrastructure,
> but I would assume a mismatch here to be a bug in almost every case,
> so a panic here might be reasonable.

Passing in a device reference that doesn't match the device the Devres instance
was created with would indeed be a bug, but a panic isn't the solution, since we
can handle this error just fine.

We never panic the whole kernel unless things go so utterly wrong that we can't
can't recover from it; e.g. if otherwise we'd likely corrupt memory, etc.

> (I would be fine with a reason for using an error here in the 
> commit message or documentation/comments)

I don't think we need this in this commit or the method's documentation, it's a
general kernel rule not to panic unless there's really no other way.

> With that:
> 
> Reviewed-by: Christian Schrefl <chrisi.schrefl@gmail.com>
> 
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
> > +        if self.0.dev.as_raw() != dev.as_raw() {
> > +            return Err(EINVAL);
> > +        }
> > +
> > +        // SAFETY: `dev` being the same device as the device this `Devres` has been created for
> > +        // proofes that `self.0.data` hasn't been revoked and is guaranteed to not be revoked as
> > +        // long as `dev` lives; `dev` lives at least as long as `self`.
> > +        Ok(unsafe { self.deref().access() })
> > +    }
> >  }
> >  
> >  impl<T> Deref for Devres<T> {
> 
> 

