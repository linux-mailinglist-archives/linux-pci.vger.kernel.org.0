Return-Path: <linux-pci+bounces-24227-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE31FA6A5BD
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 13:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39EAD1889069
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 12:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE5421CFF7;
	Thu, 20 Mar 2025 12:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ICrrUmxl"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D2921B9C5;
	Thu, 20 Mar 2025 12:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742472029; cv=none; b=WV0bfm8vOwVmE8DryL6TIxNOPicotPe+GReDWAye1haexmf8GOJzsN9QoZy9Ryk7NiAA1tjO66HpXzytnMh3LHJt6oTWjwgEa483nW3POL8kV0ndwl+EMQspFsXqACoNxukw1zpjBNdtTpcPWSbzrEagrFH94WCBv3EcS6xsnv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742472029; c=relaxed/simple;
	bh=oN1hZwcug4vQehOxcTXgDUuIltGoxFsTe011Irv16Hg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oVvSWLzrH8x4Ju7kPjRddPsJFB28I/wCHzZu90dkwrNuJAKI2/0afsDNos06dC5QdrvO9v+RnBULy9z35e9i/v4lT64DSEFTRrfmZJOWRXly4iQLqPa3QIGX7izktNFNa9flPraGZyT7xnvWT3I4UYi/l1lAn5K+4K7sNyBPMOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ICrrUmxl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9467C4CEDD;
	Thu, 20 Mar 2025 12:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742472028;
	bh=oN1hZwcug4vQehOxcTXgDUuIltGoxFsTe011Irv16Hg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ICrrUmxl04FjlGxus1Tn21z3qRENtKtrZ3t9I2ANQ2Gp9Ws9KCtUZCPgyp2kbILjo
	 gskhUk+YbWqipI0oLECrUNwiM6ersVfmZqyxUkDqeyJpNU/dU400ZnbqVxj/6atpkT
	 RqfNF2YHh6CsBhd0s11OJ0812WcmbcsBCi1I6LQ1+xLE/jn5EuKC/OgMRP/r5tx+vq
	 789M1kAC/o31EXqrk9FNa09ah8O1hOVzNiZy66BCYiEezUEj4WPlf1XIrzJ8H0UPP9
	 5iAVQ4shUyYWIaIRV4xPe+oqLXemah+XAux80qjYC9r0DSc9xhlN8mvtNyfeAJgfeO
	 QaYQDp3YR8oqQ==
Date: Thu, 20 Mar 2025 13:00:23 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: bhelgaas@google.com, gregkh@linuxfoundation.org, rafael@kernel.org,
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, tmgross@umich.edu, linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] rust: device: implement bus_type_raw()
Message-ID: <Z9wDV7Y0-pwe_A-v@pollux>
References: <20250319203112.131959-1-dakr@kernel.org>
 <20250319203112.131959-3-dakr@kernel.org>
 <Z9vTctFR7QAOa4tn@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9vTctFR7QAOa4tn@google.com>

On Thu, Mar 20, 2025 at 08:36:02AM +0000, Alice Ryhl wrote:
> On Wed, Mar 19, 2025 at 09:30:26PM +0100, Danilo Krummrich wrote:
> > Implement bus_type_raw(), which returns a raw pointer to the device'
> > struct bus_type.
> > 
> > This is useful for bus devices, to implement the following trait.
> > 
> > 	impl TryFrom<&Device> for &pci::Device
> > 
> > With this a caller can try to get the bus specific device from a generic
> > device in a safe way. try_from() will only succeed if the generic
> > device' bus type pointer matches the pointer of the bus' type.
> > 
> > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> > ---
> >  rust/kernel/device.rs | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
> > index 76b341441f3f..e2de0efd4a27 100644
> > --- a/rust/kernel/device.rs
> > +++ b/rust/kernel/device.rs
> > @@ -78,6 +78,13 @@ pub fn parent<'a>(&self) -> Option<&'a Self> {
> >          }
> >      }
> >  
> > +    /// Returns a raw pointer to the device' bus type.
> > +    #[expect(unused)]
> > +    pub(crate) fn bus_type_raw(&self) -> *const bindings::bus_type {
> > +        // SAFETY: By the type invariants, `self.as_raw()` is a valid pointer to a `struct device`.
> 
> Is this field immutable?

dev->bus is a pointer to a const struct bus_type, yes.

> 
> > +        unsafe { (*self.as_raw()).bus }
> > +    }
> > +
> >      /// Convert a raw C `struct device` pointer to a `&'a Device`.
> >      ///
> >      /// # Safety
> > -- 
> > 2.48.1
> > 

