Return-Path: <linux-pci+bounces-19821-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91AEFA119DF
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 07:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 391843A25B5
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 06:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7048622F85F;
	Wed, 15 Jan 2025 06:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WAIS5RJ+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3952222FAE9;
	Wed, 15 Jan 2025 06:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736923323; cv=none; b=T75O4P19THSzJr6UXro+fQNGpYLnrGG1uJu2ka3Hg2sJD1dAODls/LM5Axtqu1ZhfE6NFW7NP9hEyBztWPMSjr9hrTB3C3XV3h5tQcXc0TQJI09Q8unADff3Wh2jlMPGcZVZkVUMJ0efz57NojON8zrEfA//XBc2KeUy2qMLZ5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736923323; c=relaxed/simple;
	bh=bgY+YVYRDmnRUhd9hC0XPzyVCgfpIC4kE0RT+1d1CSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XeWxXINzupzsis8jEJ+WHbXN5/wJUpaLyiDf1lNBSmB8RYis3He0a9/xmxL33TXgIyJ8nd10NMpeLplWnYTOnSNVK5s/Y0HXQ8tC+YoFGVVKAWTNtzU7roue0071c4yFHXBvBSl/c2jYouL9uzxe3Xr4AH3LmPtpZAtqCy24hMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WAIS5RJ+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC216C4CEDF;
	Wed, 15 Jan 2025 06:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736923322;
	bh=bgY+YVYRDmnRUhd9hC0XPzyVCgfpIC4kE0RT+1d1CSg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WAIS5RJ+HciZXjtPxrtNebxVZbWYP1lfFRhP/crDreCXBFfUDrzK0wNb9glRR1qZl
	 LW53WAm4IeNqKEnkKyzUSBnah+iQpY2qOINnoyyWnnZhasfIq5mLTCffq7FrITc8et
	 CHC+MzefHzpBM9jDk7P/AhZJ4sswnjwFIXLYhHxAfs9Di3Nj0tY/o1f1IPZKaoDeaF
	 EqavdYtUzKy9yDL5PrOfLolemyOdXs+Io1rWeiqYb7jiYSMyTVzPMwJcC9ZNhtfrUE
	 /UQK1QoKSCrXiCxQ6/ZLX2Rr14aplknkYmSWbTW1Ra9cB4FiYmkxEuqdan3fBbHjJx
	 8bn90llk/oU1w==
Date: Wed, 15 Jan 2025 07:41:54 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Gary Guo <gary@garyguo.net>, gregkh@linuxfoundation.org
Cc: rafael@kernel.org, bhelgaas@google.com, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me, tmgross@umich.edu,
	a.hindborg@samsung.com, aliceryhl@google.com, airlied@gmail.com,
	fujita.tomonori@gmail.com, lina@asahilina.net, pstanner@redhat.com,
	ajanulgu@redhat.com, lyude@redhat.com, robh@kernel.org,
	daniel.almeida@collabora.com, saravanak@google.com,
	dirk.behme@de.bosch.com, j@jannau.net, fabien.parent@linaro.org,
	chrisi.schrefl@gmail.com, paulmck@kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	rcu@vger.kernel.org
Subject: Re: [PATCH v7 08/16] rust: add devres abstraction
Message-ID: <Z4dYsoKrbP4_Nz_v@pollux>
References: <20241219170425.12036-1-dakr@kernel.org>
 <20241219170425.12036-9-dakr@kernel.org>
 <20241224215323.560f17a9.gary@garyguo.net>
 <Z4aR4OrCQMoF6Boo@pollux>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4aR4OrCQMoF6Boo@pollux>

On Tue, Jan 14, 2025 at 05:33:45PM +0100, Danilo Krummrich wrote:
> > > +impl<T> Drop for Devres<T> {
> > > +    fn drop(&mut self) {
> > > +        // Revoke the data, such that it gets dropped already and the actual resource is freed.
> > > +        //
> > > +        // `DevresInner` has to stay alive until the devres callback has been called. This is
> > > +        // necessary since we don't know when `Devres` is dropped and calling
> > > +        // `devm_remove_action()` instead could race with `devres_release_all()`.
> > 
> > IIUC, the outcome of that race is the `WARN` if
> > devres_release_all takes the spinlock first and has already remvoed the
> > action?
> > 
> > Could you do a custom devres_release here that mimick
> > `devm_remove_action` but omit the `WARN`? This way it allows the memory
> > behind DevresInner to be freed early without keeping it allocated until
> > the end of device lifetime.
> 
> Better late than never, I now remember what's the *actual* race I was preventing
> here:
> 
>   | Task 0                               | Task 1
> --|----------------------------------------------------------------------------
> 1 | Devres::drop() {                     | devres_release_all() {
> 2 |    DevresInner::remove_action() {    |    spin_lock_irqsave();
> 3 |                                      |    remove_nodes(&todo);
> 4 |                                      |    spin_unlock_irqrestore();
> 5 |       devm_remove_action_nowarn();   |
> 6 |       let _ = Arc::from_raw();       |
> 7 |    }                                 |
> 8 | }                                    |
> 9 |                                      |    release_nodes(&todo);
> 10|                                      | }
> 
> So, if devres_release_all() wins the race it stores the devres action within the
> temporary todo list. Which means that in 9 we enter
> DevresInner::devres_callback() even though DevresInner has been freed already.
> 
> Unfortunately, this race can happen with [1], but not with this original version
> of Devres.

Well, actually this can't happen, since obviously we know whether Devres:drop
removed it or whether it will be released by devres_release_all() and we only
free DevresInner conditionally.

So, the code in [1] is fine; I somehow managed to confuse myself.

Sorry for the noise.

- Danilo

> 
> I see two ways to fix it:
> 
> 1) Just revert [1] and stick with the original version.
> 
> 2) Use devm_release_action() instead of devm_remove_action() and don't drop the
>    reference in DevresInner::remove_action() (6). This way the reference is
>    always dropped from the callback.
> 
> With 2) we still have an unnecessary call to revoke() if Devres is dropped
> before the device is detached from the driver, but that's still better than
> keeping DevresInner alive until the device is detached from the driver, which
> the original version did. Hence, I'll go ahead and prepare a patch for this,
> unless there are any concerns.
> 
> - Danilo
> 
> [1] https://lore.kernel.org/rust-for-linux/20250107122609.8135-2-dakr@kernel.org/

