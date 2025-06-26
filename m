Return-Path: <linux-pci+bounces-30747-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60AA7AE9CB6
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 13:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 565897ACC02
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 11:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE833276026;
	Thu, 26 Jun 2025 11:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p/yoG0oj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3035275115;
	Thu, 26 Jun 2025 11:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750938030; cv=none; b=doH6R6t0FPAe1bB0JyoSwT8J4yPoIKK3H1AmS6cmY95nr9NwEeZ+VXGYvs/LIouVElPp9BAFqiscsr2pVCWf70jh4ZcA8EPo4Y86PQFWSdzkVhCbqEKenkod3HdzBjbiJoVb13a3Vso6xqXR0sdzhKYeJ6iSXKpHjlleedgkgiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750938030; c=relaxed/simple;
	bh=vpkGbqYUMukz6V9t3VsChBVMYanG+RJ4SeL/y9Rrtjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fsEQC9h6Xgbmli1f5wiu9e2JwUnms4ulRqrgT5h6MGKINVUW/ESVSk22dR5IoU6/YEJotw9Do2sHWar5ktu6nHZsAWQSSack+8YKtTtguqBsio/RqdYHFaXPnh6cKq/iHz07XHtDR+YHcG5DJWCaBaI6N9q/0dXeL4uOwDdkFtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p/yoG0oj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B645C4CEEB;
	Thu, 26 Jun 2025 11:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750938030;
	bh=vpkGbqYUMukz6V9t3VsChBVMYanG+RJ4SeL/y9Rrtjc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p/yoG0ojiYgvEaGMNpNsb81K5Qz7AtbdguTR/DY2uPDtibazqksDcGmDtscTLuP4G
	 RpPicBuoMjJkSjkYf5kJfRJULHQbZp1gskeV8rc2JQniEmSIXPMPdyYINVsGMQYWcm
	 1XHvS1QwlhB3i3aAnucJSkwP4nZGhOxNh76lqEYDkI5SGKGXCtYtBm0qyUMxwGOJSS
	 g/4mBZpHKGdsk/4pvxhGEqShUIHT6AJvAwDAJSlcxV9gOKL7GbYIt4wCSeXbBaN3Bt
	 ZGNtOYjZmOCwgkSwL3KemD9H65PuC9q66VglZp/eGQnYqtLGyyc36YVYfQAWiVnTDt
	 n3GWOlX0MB98w==
Date: Thu, 26 Jun 2025 13:40:23 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Benno Lossin <lossin@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, gregkh@linuxfoundation.org,
	rafael@kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@kernel.org,
	aliceryhl@google.com, tmgross@umich.edu, david.m.ertman@intel.com,
	ira.weiny@intel.com, leon@kernel.org, kwilczynski@kernel.org,
	bhelgaas@google.com, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 3/4] rust: devres: get rid of Devres' inner Arc
Message-ID: <aF0xp4ZKP_a7cJsc@pollux>
References: <20250624215600.221167-1-dakr@kernel.org>
 <20250624215600.221167-4-dakr@kernel.org>
 <aFzI5L__OcB9hqdG@Mac.home>
 <aF0aiHhCuHjLFIij@pollux>
 <DAWE690DWP9A.10I5FIJSZDSR6@kernel.org>
 <aF0p5vIcL_4PBJCG@pollux>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aF0p5vIcL_4PBJCG@pollux>

On Thu, Jun 26, 2025 at 01:07:25PM +0200, Danilo Krummrich wrote:
> On Thu, Jun 26, 2025 at 12:27:18PM +0200, Benno Lossin wrote:
> > On Thu Jun 26, 2025 at 12:01 PM CEST, Danilo Krummrich wrote:
> > > On Wed, Jun 25, 2025 at 09:13:24PM -0700, Boqun Feng wrote:
> > >> On Tue, Jun 24, 2025 at 11:54:01PM +0200, Danilo Krummrich wrote:
> > >> [...]
> > >> > +#[pin_data(PinnedDrop)]
> > >> > +pub struct Devres<T> {
> > >> 
> > >> It makes me realize: I think we need to make `T` being `Send`? Because
> > >> the devm callback can happen on a different thread other than
> > >> `Devres::new()` and the callback may drop `T` because of revoke(), so we
> > >> are essientially sending `T`. Alternatively we can make `Devres::new()`
> > >> and its friend require `T` being `Send`.
> > >> 
> > >> If it's true, we need a separate patch that "Fixes" this.
> > >
> > > Indeed, that needs a fix.
> > 
> > Oh and we have no `'static` bound on `T` either... We should require
> > that as well.
> 
> I don't think we actually need that, The Devres instance can't out-live a &T
> passed into it. And the &T can't out-live the &Device<Bound>, hence we're
> guaranteed that devres_callback() is never called because Devres::drop() will be
> able successfully unregister the callback given that we're still in the
> &Device<Bound> scope.
> 
> The only thing that could technically out-live the &Device<Bound> would be
> &'static T, but that would obviously be fine.
> 
> Do I miss anything?

Thinking a bit more about it, a similar argumentation is true for not needing
T: Send. The only way to leave the &Device<Bound> scope and hence the thread
would be to stuff the Devres into a ForeignOwnable container, no?

Analogous to Benno asking for ForeignOwnable: 'static, should we also require
ForeignOwnable: Send + Sync?

Alternatively, the safety requirements of ForeignOwnable:::from_foreign() and
ForeignOwnable::borrow() would need to cover this, which they currently they
are not.

