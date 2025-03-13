Return-Path: <linux-pci+bounces-23645-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48AD7A5F81D
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 15:29:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA5EA18992A7
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 14:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61680267B15;
	Thu, 13 Mar 2025 14:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VCWl4GO8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3541726138E;
	Thu, 13 Mar 2025 14:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741876142; cv=none; b=OZbu/Kp+xXjwIsnmEo4uT1UmYDf+g8uAB6XuvKaRemkNtBroVlkpc3LjXESy/afQQEijs6fqALeGhDB2gOAzUxGV4sRW6wgUs2Mdck3m5J0LAzyG25XLyWElfztNY/s+Z2NrSmx4K0bqK/blJFszkntbbjX6wjzM2M7QvuBEYls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741876142; c=relaxed/simple;
	bh=fCokpUlBnQf/exMCVGCrqUeBZAxKhgoIWf+mFn08ScA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T0iKRlL9pT1bIWqEGfY0upCAXTYfWINaxw+TlffmGbbb8Zj5/tkL+jNCyXO5ZbxQbqVQav5Y+rV0KJRScidNslciuR8r4xGiCdnFr+jgLPTMdL4DMyxeq1CX2L7kcT7A5rGiKwlcBNjYQP10kIaOFcb1bPMRBXnAC7wCL+Nveyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VCWl4GO8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D1EEC4CEDD;
	Thu, 13 Mar 2025 14:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741876141;
	bh=fCokpUlBnQf/exMCVGCrqUeBZAxKhgoIWf+mFn08ScA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VCWl4GO8Gdlr9G1aOm5fU1pp3VbqdLWK1M0W1QBeeUob/O/rgpQxPE6kOoon/voAl
	 sGDbx5tBqoaGXvtFg1AuMrNJ/mEm4DBPK9qzhZjJbeCWDx5GgvYXGQALpkKA1nRPu4
	 iVMAJrF5Xsf3SalLbjHA6MPDmIsMLl5Bx50OkLjMtt8VJ8iBeHm6IZ8fdCcgkx8fjH
	 9Jwn7QH9TqHHCpHUWefl+XCvqXQWxjiD89G7/W60zldnYIptTvBMYhIshZvIA9siGm
	 Z5T+n/QWcvcUQHgjuKYxhOlp7UvS8JEdJmH+p6SdfMnjgDIlHDH/siOtTZFbBXlUdF
	 8kmgN6bEf6qhA==
Date: Thu, 13 Mar 2025 15:28:55 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Benno Lossin <benno.lossin@proton.me>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com,
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@kernel.org,
	aliceryhl@google.com, tmgross@umich.edu,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 4/4] rust: platform: fix unrestricted &mut
 platform::Device
Message-ID: <Z9Lrp2fC4b22QkPj@pollux>
References: <20250313021550.133041-1-dakr@kernel.org>
 <20250313021550.133041-5-dakr@kernel.org>
 <D8F2WCIXO6RQ.3OQHU95WZFB61@proton.me>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D8F2WCIXO6RQ.3OQHU95WZFB61@proton.me>

On Thu, Mar 13, 2025 at 10:49:59AM +0000, Benno Lossin wrote:
> On Thu Mar 13, 2025 at 3:13 AM CET, Danilo Krummrich wrote:
> > As by now, platform::Device is implemented as:
> >
> > 	#[derive(Clone)]
> > 	pub struct Device(ARef<device::Device>);
> >
> > This may be convenient, but has the implication that drivers can call
> > device methods that require a mutable reference concurrently at any
> > point of time.
> 
> Similar to the other patch, I didn't find any methods taking `&mut self`
> but I might have missed them.

`platform::Device` does not have any yet. But we still need the pattern. Once we
land the `dma::Device` trait, we'll need:

	impl dma::Device for platform::Device<Core> {}

to derive the DMA methods.

Besides that, I want bus device implementations to be consistent.

> 
> > Instead define platform::Device as
> >
> > 	pub struct Device<Ctx: DeviceContext = Normal>(
> > 		Opaque<bindings::platform_dev>,
> > 		PhantomData<Ctx>,
> > 	);
> >
> > and manually implement the AlwaysRefCounted trait.
> >
> > With this we can implement methods that should only be called from
> > bus callbacks (such as probe()) for platform::Device<Core>. Consequently,
> > we make this type accessible in bus callbacks only.
> >
> > Arbitrary references taken by the driver are still of type
> > ARef<platform::Device> and hence don't provide access to methods that are
> > reserved for bus callbacks.
> >
> > Fixes: 683a63befc73 ("rust: platform: add basic platform device / driver abstractions")
> > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> 
> The same two nits from patch #3 also apply.
> 
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> 
> ---
> Cheers,
> Benno
> 
> > ---
> >  rust/kernel/platform.rs              | 93 ++++++++++++++++++----------
> >  samples/rust/rust_driver_platform.rs | 16 +++--
> >  2 files changed, 74 insertions(+), 35 deletions(-)
> 

