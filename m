Return-Path: <linux-pci+bounces-30526-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 498DEAE6C43
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 18:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EDCD5A46D9
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 16:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF46E1D5CE5;
	Tue, 24 Jun 2025 16:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UZLEobQR"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952E52CA8;
	Tue, 24 Jun 2025 16:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750781743; cv=none; b=PoDyzWKt3b3TsTiZfnlnRQrOdHEQ7u9pl1D8vN8+nfhtiwEZbcAW3vo+eRW1aeYMkO0raHSUM3YyawCS/+UBCB/6j0ByIMNchKr1BvCQDYJJTtP5Y1MU4w5lOpCATNh8CxAJheqMirOhoZK6SCR49xThX7QqvFYNpRWsvCdTyEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750781743; c=relaxed/simple;
	bh=57KGGXFeYzK3SWKuPuzos71t2DB02nUIsE5M3fgI7hw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Usraz2iRleMblEpbSLJGk10IycYfCpk69+1VXy2vb2eX/ZrFUtTm+/CGyXElYxeKi3ua5ndeZiUs8eGpPWLtCq/OukgNa+U6UeBSo2C93JhVzUw2YkHxcqtR0KBcQ99gKGS5ZytaQli/nB3WR+ZEASknB4417GK017JLFZohdtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UZLEobQR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EB27C4CEE3;
	Tue, 24 Jun 2025 16:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750781743;
	bh=57KGGXFeYzK3SWKuPuzos71t2DB02nUIsE5M3fgI7hw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UZLEobQROqAuzu4WGUq3ilnyh0W3kf7mHHZLhm59Bq+kmmatsj9yzu6Vz7vWpQUZ3
	 ZMKHK1O6dphmww8tlmC9n0JJYD7HDSq98/onavbNuW0BKxtI9b2PDfy+hxL1079pLK
	 I825s0pdnz7Ib7A1502mkKCoqocwCD0UZ2hwsBaKJYhraDX4AStrq8UVEhEGDfwONJ
	 Lyro5JtRvr4SjQKVxfI/0ks6LaPXYUE2DSvnu1jKC0SlEvZPZwAxG6+u9ZsWoMEAS0
	 o0Sy1FuogCmKsTUdqWD7lhHltZCF8CD8+NFINHff9hFG0VCjLOpFdvfYQ+AKKb7ERy
	 cbALbi6aTGErg==
Date: Tue, 24 Jun 2025 18:15:36 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org,
	alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
	tmgross@umich.edu, david.m.ertman@intel.com, ira.weiny@intel.com,
	leon@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 3/4] rust: devres: get rid of Devres' inner Arc
Message-ID: <aFrPKAxHfAetcQzz@cassiopeiae>
References: <20250622164050.20358-1-dakr@kernel.org>
 <20250622164050.20358-4-dakr@kernel.org>
 <aFizv7suXTADJU3f@Mac.home>
 <aFrBvwFrUGD45TeF@cassiopeiae>
 <aFrIbRA9b9LOxFQ3@Mac.home>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFrIbRA9b9LOxFQ3@Mac.home>

On Tue, Jun 24, 2025 at 08:46:53AM -0700, Boqun Feng wrote:
> On Tue, Jun 24, 2025 at 05:18:23PM +0200, Danilo Krummrich wrote:
> > On Sun, Jun 22, 2025 at 06:54:07PM -0700, Boqun Feng wrote:
> > > I think you also need to mention that `inner` only remains valid until
> > > `inner.devm.complete_all()` unblocks `Devres::drop()`, because after
> > > `Devres::drop()`'s `devm.wait_for_completion()` returns, `inner` may be
> > > dropped or freed.
> > 
> > I think of it the other way around: The invariant guarantees that `inner` is
> > *always* valid.
> > 
> > The the `drop_in_place(inner)` call has to justify that it upholds this
> > invariant, by ensuring that at the time it is called no other code that accesses
> > `inner` can ever run.
> > 
> > Defining it the other way around would make the `inner()` accessor unsafe.
> 
> Maybe I wasn't clear enough, I meant in the following function:
> 
>     unsafe extern "C" fn devres_callback(ptr: *mut kernel::ffi::c_void) {
> -        let ptr = ptr as *mut DevresInner<T>;
> -        // Devres owned this memory; now that we received the callback, drop the `Arc` and hence the
> -        // reference.
> -        // SAFETY: Safe, since we leaked an `Arc` reference to devm_add_action() in
> -        //         `DevresInner::new`.
> -        let inner = unsafe { Arc::from_raw(ptr) };
> +        // SAFETY: In `Self::new` we've passed a valid pointer to `Inner` to `devm_add_action()`,
> +        // hence `ptr` must be a valid pointer to `Inner`.
> +        let inner = unsafe { &*ptr.cast::<Inner<T>>() };
> 
> ^ this `inner` was constructed by reborrowing from `ptr`, but it should
> only be used before the following `inner.devm.complete_all()`...

Oh, so you meant adding this to the safety comment. Yes, that makes sense. Maybe
ScopeGuard works too, as you say.

