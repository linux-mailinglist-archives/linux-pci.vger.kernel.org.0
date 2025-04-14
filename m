Return-Path: <linux-pci+bounces-25816-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61244A87E3C
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 12:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 923B618969A6
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 10:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469F827E1A7;
	Mon, 14 Apr 2025 10:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LI5eC+fZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7C527D79E;
	Mon, 14 Apr 2025 10:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744628224; cv=none; b=cHmuTzGAHKNB2a82+4JyDkRtVFAViXHLm7tAaP806yIMo8yDnbkBYEQxJhT2fV+Il52cq216WL1ipuh8UAKLTMlyLSm7Jdl1x3TzdwPADhZOgftJ+Ogr3IO9vMfziUc1dPEPLZP1D2CJbO7TScacw4YfJV7nwxOnKxYsXP+QMAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744628224; c=relaxed/simple;
	bh=R3xwTXKuf5QwIrRarHqKkm0PSMH3ZydknPTp7+3MCps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y3vDkDASQtmWkitDLq3kvm0QGHPfGfcEjoTihh4UiGFJ+miZ/C8UxwDahqSc2/tvd7c7sOK8uI8jV4pJdNOHyTEDaKyX4odVF683H84ymdT9ko1Sh16SJKfX37eXXuDbuaKo0VbRc7CVZbFOAPnUEUpKf9tl0yWYFo11s3aAo7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LI5eC+fZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB22DC4CEE2;
	Mon, 14 Apr 2025 10:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744628223;
	bh=R3xwTXKuf5QwIrRarHqKkm0PSMH3ZydknPTp7+3MCps=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LI5eC+fZiNWy7i030iKL6KaQjSZFpKRXu8wsfwJ1s2GxbG8vMfNIg6YPTE1XPBJg4
	 GPH9/3NzX95nlcB+hoUVJF3V+hd0FCbOWhvH6Oxa/B8/lJLWsVjf+lZB946fuzvTm+
	 EzSsf4C85Slw1BI8YX/To5NE0Kh3gDq0+DE6yxNjnlfRIYSuJbjp4O7PFs3xJTNsiA
	 cSBloqUjK95ErfkQmzyiiduDJlj3xin9cpuAaRJ+eloba+8gtBjLrDq6eWEMkWEO2c
	 0GQjzZycNKyI1r4Xspobj1PSz+SjhKsix9b2RGVpN7NFMHJ4R+ckzFTkwVkMLWusrg
	 5GRRjJT+4figg==
Date: Mon, 14 Apr 2025 12:56:56 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Benno Lossin <benno.lossin@proton.me>
Cc: bhelgaas@google.com, kwilczynski@kernel.org, gregkh@linuxfoundation.org,
	rafael@kernel.org, abdiel.janulgue@gmail.com, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, a.hindborg@kernel.org,
	aliceryhl@google.com, tmgross@umich.edu,
	daniel.almeida@collabora.com, robin.murphy@arm.com,
	linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/9] rust: device: implement Bound device context
Message-ID: <Z_zp-AvQ6FMv0ZRK@pollux>
References: <20250413173758.12068-1-dakr@kernel.org>
 <20250413173758.12068-7-dakr@kernel.org>
 <D96AXNJRUAA0.3E5KYNM5PZZPG@proton.me>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D96AXNJRUAA0.3E5KYNM5PZZPG@proton.me>

On Mon, Apr 14, 2025 at 10:49:49AM +0000, Benno Lossin wrote:
> On Sun Apr 13, 2025 at 7:37 PM CEST, Danilo Krummrich wrote:
> > The Bound device context indicates that a device is bound to a driver.
> > It must be used for APIs that require the device to be bound, such as
> > Devres or dma::CoherentAllocation.
> >
> > Implement Bound and add the corresponding Deref hierarchy, as well as the
> > corresponding ARef conversion for this device context.
> >
> > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> > ---
> >  rust/kernel/device.rs | 16 +++++++++++++++-
> >  1 file changed, 15 insertions(+), 1 deletion(-)
> >
> > diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
> > index 487211842f77..585a3fcfeea3 100644
> > --- a/rust/kernel/device.rs
> > +++ b/rust/kernel/device.rs
> > @@ -232,13 +232,19 @@ pub trait DeviceContext: private::Sealed {}
> >  /// any of the bus callbacks, such as `probe()`.
> >  pub struct Core;
> >  
> > +/// The [`Bound`] context is the context of a bus specific device reference when it is guranteed to
> > +/// be bound for the duration of its lifetime.
> > +pub struct Bound;
> 
> One question about this: is it possible for me to
> 1. have access to a `ARef<Device<Bound>>` (or `Core`) via some callback,
> 2. store a clone of the `ARef` in some datastructure,
> 3. wait for the device to become unbound,
> 4. use a `Bound`-only context function and blow something up?

You can never get an ARef<Device> that has a different device context than
Normal.

A device must only ever implement AlwaysRefCounted for Device (i.e.
Device<Normal>).

This is why patch 2 ("rust: device: implement impl_device_context_into_aref!")
implements conversions from Device<Ctx> to ARef<Device>.

