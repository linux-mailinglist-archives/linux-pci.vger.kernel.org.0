Return-Path: <linux-pci+bounces-25139-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D336A78AA7
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 11:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 848BC1892DFE
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 09:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82E323534A;
	Wed,  2 Apr 2025 09:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N9q8Wqx5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882D69444;
	Wed,  2 Apr 2025 09:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743584825; cv=none; b=uGPMzZMxAby7JuhuElmmnOU5iP3P1poNESOE0Wu9AHWbqx7bqtgOtk5ao7bxjdFg6s6cHlJ+pq/drNtmg5GXUiiRXMhWhT/0QbsUgyA+EaT7ZYKwTJy+DzoQjA1+tZjkYZ2hYhSSQ/sQPVFJR2HqL5e0vEHP7rfpNhsQw3Q/yLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743584825; c=relaxed/simple;
	bh=r2rtmCc79vq/OjG5/vXgJGsw5iwUgo0hY/2m6fdooM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hpzTOGxk7ioosX1c4iDDrxKJkOKlSV5VcY6lC+/F0NYqO41xOTMB3sgq+8kS9yqjGyrIgIQB+rAGqHjCa9u2908K20Ip7k4LeBOIf0nYqAZQV353a/B4ZKkpyd5zpkLWq38k357yPuLdqogPpt8ux+Q/VYXTZNw7ZKcuh95lDXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N9q8Wqx5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18BA4C4CEDD;
	Wed,  2 Apr 2025 09:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743584825;
	bh=r2rtmCc79vq/OjG5/vXgJGsw5iwUgo0hY/2m6fdooM0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N9q8Wqx5JMlYZJ6ku4ji1U9b10nIJHClhzMYL9QKU2YvlauYr1aWZWep5qk/Q32m/
	 P0q80HKB3M2nDqxc7bhwgQWB9Dd2JMeiF4YhGVQSIuLwQnXSkbb/dipDQHQenrKHje
	 ZSj/F+QdyKX0rXmMLCg57jv+2c2S3E1eapdBeQ9hGCU6lK7Q5bpl1txn+XWygFP5qj
	 11+rFUMGmJVUm4MFkLbnPtrTrUqz30q7SgHPk/pw9+hzHIgR5G1TjZLAdWiKfBd3xh
	 lfqZfZPhhkHJxoCZ+Xjp18fuT6ynCphiiF+WKq9+UTQY30U+Bywr8Tirw9/y8oxv/e
	 I7N/toVCuSU6g==
Date: Wed, 2 Apr 2025 11:06:59 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Benno Lossin <benno.lossin@proton.me>
Cc: Greg KH <gregkh@linuxfoundation.org>, bhelgaas@google.com,
	rafael@kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] rust: pci: impl TryFrom<&Device> for &pci::Device
Message-ID: <Z-z-M3g3FFz2HbrR@pollux>
References: <20250321214826.140946-1-dakr@kernel.org>
 <Z96MrGQvpVrFqWYJ@pollux>
 <Z-CG01QzSJjp46ad@pollux>
 <D8ON7WC8WMFG.2S2JRK6G9TOSL@proton.me>
 <Z-GNDE68vwhk0gaV@cassiopeiae>
 <D8OOFRRSLHP4.1B2FHQRGH3LKW@proton.me>
 <Z-Ggu_YZBPM2Kf8J@cassiopeiae>
 <D8OPMRYE0SO5.2JQD6ZIYXHP68@proton.me>
 <Z-vvcPfgyaRdd0xQ@pollux>
 <D8VPQ5XL5NJZ.26OGZ3YML4QN3@proton.me>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D8VPQ5XL5NJZ.26OGZ3YML4QN3@proton.me>

On Wed, Apr 02, 2025 at 12:05:56AM +0000, Benno Lossin wrote:
> On Tue Apr 1, 2025 at 3:51 PM CEST, Danilo Krummrich wrote:
> > On Mon, Mar 24, 2025 at 06:32:53PM +0000, Benno Lossin wrote:
> >> On Mon Mar 24, 2025 at 7:13 PM CET, Danilo Krummrich wrote:
> >> > On Mon, Mar 24, 2025 at 05:36:45PM +0000, Benno Lossin wrote:
> >> >> On Mon Mar 24, 2025 at 5:49 PM CET, Danilo Krummrich wrote:
> >> >> > On Mon, Mar 24, 2025 at 04:39:25PM +0000, Benno Lossin wrote:
> >> >> >> On Sun Mar 23, 2025 at 11:10 PM CET, Danilo Krummrich wrote:
> >> >> >> > On Sat, Mar 22, 2025 at 11:10:57AM +0100, Danilo Krummrich wrote:
> >> >> >> >> On Fri, Mar 21, 2025 at 08:25:07PM -0700, Greg KH wrote:
> >> >> >> >> > Along these lines, if you can convince me that this is something that we
> >> >> >> >> > really should be doing, in that we should always be checking every time
> >> >> >> >> > someone would want to call to_pci_dev(), that the return value is
> >> >> >> >> > checked, then why don't we also do this in C if it's going to be
> >> >> >> >> > something to assure people it is going to be correct?  I don't want to
> >> >> >> >> > see the rust and C sides get "out of sync" here for things that can be
> >> >> >> >> > kept in sync, as that reduces the mental load of all of us as we travers
> >> >> >> >> > across the boundry for the next 20+ years.
> >> >> >> >> 
> >> >> >> >> I think in this case it is good when the C and Rust side get a bit
> >> >> >> >> "out of sync":
> >> >> >> >
> >> >> >> > A bit more clarification on this:
> >> >> >> >
> >> >> >> > What I want to say with this is, since we can cover a lot of the common cases
> >> >> >> > through abstractions and the type system, we're left with the not so common
> >> >> >> > ones, where the "upcasts" are not made in the context of common and well
> >> >> >> > established patterns, but, for instance, depend on the semantics of the driver;
> >> >> >> > those should not be unsafe IMHO.
> >> >> >> 
> >> >> >> I don't think that we should use `TryFrom` for stuff that should only be
> >> >> >> used seldomly. A function that we can document properly is a much better
> >> >> >> fit, since we can point users to the "correct" API.
> >> >> >
> >> >> > Most of the cases where drivers would do this conversion should be covered by
> >> >> > the abstraction to already provide that actual bus specific device, rather than
> >> >> > a generic one or some priv pointer, etc.
> >> >> >
> >> >> > So, the point is that the APIs we design won't leave drivers with a reason to
> >> >> > make this conversion in the first place. For the cases where they have to
> >> >> > (which should be rare), it's the right thing to do. There is not an alternative
> >> >> > API to point to.
> >> >> 
> >> >> Yes, but for such a case, I wouldn't want to use `TryFrom`, since that
> >> >> trait to me is a sign of a canonical way to convert a value.
> >> >
> >> > Well, it is the canonical way to convert, it's just that by the design of other
> >> > abstractions drivers should very rarely get in the situation of needing it in
> >> > the first place.
> >> 
> >> I'd still prefer it though, since one can spot a
> >> 
> >>     let dev = CustomDevice::checked_from(dev)?
> >> 
> >> much better in review than the `try_from` conversion. It also prevents
> >> one from giving it to a generic interface expecting the `TryFrom` trait.
> >
> > (I plan to rebase this on my series introducing the Bound device context [1].)
> >
> > I thought about this for a while and I still think TryFrom is fine here.
> 
> What reasoning do you have?

The concern in terms of abuse is that one could try to randomly guess the
"outer" device type (if any), which obiously indicates a fundamental design
issue.

But that's not specific to devices; it is a common anti-pattern in OOP to
randomly guess the subclass type of an object instance.

So, I don't think the situation here is really that special such that it needs
an extra highlight.

> > At some point I want to replace this implementation with a macro, since the code
> > is pretty similar for bus specific devices. I think that's a bit cleaner with
> > TryFrom compared to with a custom method, since we'd need the bus specific
> > device to call the macro from the generic impl, i.e.
> >
> > 	impl<Ctx: DeviceContext> Device<Ctx>
> >
> > rather than a specific one, which we can't control. We can control it for
> > TryFrom though.
> 
> We could have our own trait for that.

I don't think we should have a trait specific for devices for this. If we really
think the above anti-pattern deserves special attention, then we should have a
generic trait (e.g. FromSuper<T>) instead.

But I'm not sure that we really need to put special attention on that.

