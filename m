Return-Path: <linux-pci+bounces-30698-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08BD9AE9AA4
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 12:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63B814E084C
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 10:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42DCD21A440;
	Thu, 26 Jun 2025 10:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G10n5isK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19AB621858A;
	Thu, 26 Jun 2025 10:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750932112; cv=none; b=ReoGOuBAsMBgKSvznye/6nW7YKKILMZHrbmFh9lpE5SNnKERvnwe03cGhxbDw7J3CG/t1BQr14FMIEYHWL9CGUjiFi/FK0+aUkw2t0TPQeWyKmFd9IK9BA3hgDSOfMjawEKxuW4LdnIWVzHJQGdzfugaT4UvVrcYUa3MdjxSQ6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750932112; c=relaxed/simple;
	bh=celi5Quy8J2eAxPMvubiJIyTHstasenQDNv4zGeqqlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OpBBuxTr+Uc6hltugPuw6UJ4y8p7HILHmwN9S3Ex9WVn8dldLYTSi62mSkR/72ZKZYtP5lk06IkBUJQHe7J2hi8OMeAn3F9sMKG8RICj3HxUNQO4OkH7biXC+jx+gQEnv+rbJskl0eg9Uyr7OakzzUbJLDtnfEfGxVejgAnc1vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G10n5isK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1C91C4CEEB;
	Thu, 26 Jun 2025 10:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750932111;
	bh=celi5Quy8J2eAxPMvubiJIyTHstasenQDNv4zGeqqlM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G10n5isK4W0bH3XYMDpsJN8M8qCOpelQH8JUJtnaJbJZ8BmZJP5GjqfOYABkwLStP
	 m4I/Sulaerg6ilQnwkR/HplEt86l9Vu3zQwmis4d4h5jkBlQYwr5a1oyxdhDczYaa5
	 UNcOiKE3yz57xUjkexR3pstmX8WRlFsK4/axblcsgww264/lRgwm4O18OBgN0wB9/8
	 s4k4MXO2kdSo7MChLn0f1RHTUW8Sgdfa1cuwRYSGsBaKdbLwpOQ4Shc+oMBcB+hkER
	 Yv8a3O3G7rK00cWJloDVyMjxbFxOCtg4m4mE+GCDKK2A5aN/412UQRVXelNrBfNQ8d
	 Wi4ut9WxXx1YA==
Date: Thu, 26 Jun 2025 12:01:44 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org,
	alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
	tmgross@umich.edu, david.m.ertman@intel.com, ira.weiny@intel.com,
	leon@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 3/4] rust: devres: get rid of Devres' inner Arc
Message-ID: <aF0aiHhCuHjLFIij@pollux>
References: <20250624215600.221167-1-dakr@kernel.org>
 <20250624215600.221167-4-dakr@kernel.org>
 <aFzI5L__OcB9hqdG@Mac.home>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFzI5L__OcB9hqdG@Mac.home>

On Wed, Jun 25, 2025 at 09:13:24PM -0700, Boqun Feng wrote:
> On Tue, Jun 24, 2025 at 11:54:01PM +0200, Danilo Krummrich wrote:
> [...]
> > +#[pin_data(PinnedDrop)]
> > +pub struct Devres<T> {
> 
> It makes me realize: I think we need to make `T` being `Send`? Because
> the devm callback can happen on a different thread other than
> `Devres::new()` and the callback may drop `T` because of revoke(), so we
> are essientially sending `T`. Alternatively we can make `Devres::new()`
> and its friend require `T` being `Send`.
> 
> If it's true, we need a separate patch that "Fixes" this.

Indeed, that needs a fix.

> (Imagine a Devres<MutexGuard>)
> 
> > +    dev: ARef<Device>,
> > +    /// Pointer to [`Self::devres_callback`].
> > +    ///
> > +    /// Has to be stored, since Rust does not guarantee to always return the same address for a
> > +    /// function. However, the C API uses the address as a key.
> > +    callback: unsafe extern "C" fn(*mut c_void),
> > +    /// Contains all the fields shared with [`Self::callback`].
> > +    // TODO: Replace with `UnsafePinned`, once available.
> 
> nit: Maybe also reference the `drop_in_place()` in Devres::drop() as
> well, because once we use `UnsafePinned`, we don't need that
> `drop_in_place()`. But not a big deal, just trying to help the people
> who would handle that "TODO" ;-)

Makes sense, the same is true for the Send and Sync impls, I think. AFAIK,
UnsafePinned should cover them automatically.

