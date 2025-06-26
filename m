Return-Path: <linux-pci+bounces-30795-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D915AEA2CA
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 17:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74F19189732B
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 15:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E132ED867;
	Thu, 26 Jun 2025 15:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Un47jTgR"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63512ECE84;
	Thu, 26 Jun 2025 15:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750951945; cv=none; b=cIf8n3jIpXVOF+fhV7bTh5am7MXsTfkQ4U8/cXhyqqZomoGvdimaG1+H4Drn5O5Y5yld+7kQ4+BodDzHgLPqKRZZEosZ/9G0Jd+yLmSmfGGwUBnl8O5AqeR48vb9XP6IfzHB6TDTBmWpU7gnUjXKEzTDzWLtlIA29hpkQQ0l7pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750951945; c=relaxed/simple;
	bh=Z4w4SwI3CVBuuj3ceuPnUBHFUEnyZH5LepuOTbMQWBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WHpCSYPuHZvhWIVZBkYukMs1I8VycX2qABOQ3y6fNmBpt+5+JbLBsd5FtRbNztADK5N5boWKNf/eiMFIzZoRwkSUb2P3tpUj4YEhJP4Crrl76gP/LxR9gJ2vVAp2v7ZTHjBHMU2NG2HnaAWjSDxXMFA6NgajsvsbZtpH5kAGZwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Un47jTgR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2A26C4CEEB;
	Thu, 26 Jun 2025 15:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750951945;
	bh=Z4w4SwI3CVBuuj3ceuPnUBHFUEnyZH5LepuOTbMQWBk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Un47jTgRJpjiWJDSi7p/FawFvtKYLTzdSABtv+RRC1JW6fahBhEtiERIv7OSiNS50
	 RFzJYj852Y8saOmhJllXuQDnB3ptSpjtQ5moZyg66dIBGGOdHYru29tNfeXqgXhOHC
	 uNyB0d7JFdlmzmDoDG9lsNbXIgPdLzLsdIM7E4cjKOKqfUn0bt+qG9hEB6ROi4FTSc
	 ds41pWVpr+MvdK0+RviJncZwLteWDZE4nMrzsmgSAZ3VX0HMFC2t0e4UI2TxsOFibE
	 H8grKbUXic1llhP7D6yhoHZANIACaOM/xL6cf49Y8WgmrKlOH8rDXn70Ax2VZD5vgV
	 +BUuX23Ffy/bg==
Date: Thu, 26 Jun 2025 17:32:19 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Benno Lossin <lossin@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, a.hindborg@kernel.org,
	aliceryhl@google.com, tmgross@umich.edu, david.m.ertman@intel.com,
	ira.weiny@intel.com, leon@kernel.org, kwilczynski@kernel.org,
	bhelgaas@google.com, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 4/4] rust: devres: implement register_release()
Message-ID: <aF1oA8jYZGjTs9U4@cassiopeiae>
References: <20250624215600.221167-1-dakr@kernel.org>
 <20250624215600.221167-5-dakr@kernel.org>
 <DAWED7BIC32G.338MXRHK4NSJG@kernel.org>
 <aF0rzzlKgwopOVHV@pollux>
 <aF1TEuotIIwcKODM@cassiopeiae>
 <DAWJL7B9577H.3HY4CULLAHGCU@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DAWJL7B9577H.3HY4CULLAHGCU@kernel.org>

On Thu, Jun 26, 2025 at 04:41:55PM +0200, Benno Lossin wrote:
> On Thu Jun 26, 2025 at 4:02 PM CEST, Danilo Krummrich wrote:
> > On Thu, Jun 26, 2025 at 01:15:34PM +0200, Danilo Krummrich wrote:
> >> On Thu, Jun 26, 2025 at 12:36:23PM +0200, Benno Lossin wrote:
> >> > Or, we could change `Release` to be:
> >> > 
> >> >     pub trait Release {
> >> >         type Ptr: ForeignOwnable;
> >> > 
> >> >         fn release(this: Self::Ptr);
> >> >     }
> >> > 
> >> > and then `register_release` is:
> >> > 
> >> >     pub fn register_release<T: Release>(dev: &Device<Bound>, data: T::Ptr) -> Result
> >> > 
> >> > This way, one can store a `Box<T>` and get access to the `T` at the end.
> >> 
> >> I think this was also the case before? Well, it was P::Borrowed instead.
> >> 
> >> > Or if they store the value in an `Arc<T>`, they have the option to clone
> >> > it and give it to somewhere else.
> >> 
> >> Anyways, I really like this proposal of implementing the Release trait.
> >
> > One downside seems to be that the compiler cannot infer T anymore with this
> > function signature.
> 
> Yeah... That's a bit annoying.
> 
> We might be able to add an associated type to `ForeignOwnable` like
> `Target` or `Inner` or whatever.

I think we already have `PointedTo` [1]? But I remember that I've seen a patch
to remove it again [2].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/rust/kernel/types.rs#n32
[2] https://lore.kernel.org/all/20250612-pointed-to-v3-1-b009006d86a1@kernel.org/

> Then we could do:
> 
>     pub fn register_release<P>(dev: &Device<Bound>, data: P) -> Result
>     where
>         P: ForeignOwnable,
>         P::Inner: Release<Ptr = P>,
> 
> ---
> Cheers,
> Benno

