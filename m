Return-Path: <linux-pci+bounces-22530-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CAD2A479B3
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 11:02:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41C46162BD4
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 10:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0281E833A;
	Thu, 27 Feb 2025 10:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OfrPz2JJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C672C6A3;
	Thu, 27 Feb 2025 10:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740650525; cv=none; b=lx+WnJQZKHmnRFpiXhttsotgfL+mRaX7NVrx/9fbnAHGAFTSjGiD+0IAlRjiw1WmWlzdqUdagFMl2sOgXKcKQfas9H/tHhtSjhLTi9+vMnHrdB2UWqP5Qe+COj4CmnltFGC3EsHFaQzFNxDXnt4k8mb2OFaypiyGL5Syhc6k0ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740650525; c=relaxed/simple;
	bh=WFRK26x5tVbWE7gyjrMMLUCQC1MZqXSZkDzOkUqv5oY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ckhIYCYYL1fpEwgQLYr88DbVy/bOXMcfBlwbTPK3Z01jlF7vmwCbiAclJMPb18UBgO+ZLcrBLTLOhIas4ztaCJwATuDEN//29yUKvcYWnzapSh4EI8g57mujPHJbRljbyeSKw1xRiNXLpfk5mfSMrH6F4Ni4R0altwGv320WHTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OfrPz2JJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AD98C4CEDD;
	Thu, 27 Feb 2025 10:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740650524;
	bh=WFRK26x5tVbWE7gyjrMMLUCQC1MZqXSZkDzOkUqv5oY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OfrPz2JJYBEDgWaFe3BuGfbg3eo3kF2eDRLJsTPndeTB4aLJd5thUDGFyC9NWCkYH
	 2N2bCKSPMaqvYVDFRLyiEXe+NVt4ISgScLzFIH34TkEYDWhp4DfubKBQLfDMUwj7gV
	 FFIJZTOexQVX8Wq6e541mI+MummpB92u4DMWRPaTvhfHrxCvKYruxrxcExyBvjFcAN
	 tI/QsEnO5rLleFbRdBWeBkDMEaFVH38F3cW1c23YTRDGdnORsx2fMOrDRdLw5Twuvk
	 2TemwYoi63k+IPrJtu6WZmYX1wL0nXwBS2MPy8SRocu3iWb/qrQVpeoG336elucQsN
	 nj+/MEBqIGoGg==
Date: Thu, 27 Feb 2025 11:01:55 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Alistair Popple <apopple@nvidia.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com,
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	tmgross@umich.edu, a.hindborg@samsung.com, aliceryhl@google.com,
	airlied@gmail.com, fujita.tomonori@gmail.com, lina@asahilina.net,
	pstanner@redhat.com, ajanulgu@redhat.com, lyude@redhat.com,
	robh@kernel.org, daniel.almeida@collabora.com, saravanak@google.com,
	dirk.behme@de.bosch.com, j@jannau.net, fabien.parent@linaro.org,
	chrisi.schrefl@gmail.com, paulmck@kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	rcu@vger.kernel.org
Subject: Re: [PATCH v7 07/16] rust: add `io::{Io, IoRaw}` base types
Message-ID: <Z8A4E_AyDlSUT5Bq@pollux>
References: <20241219170425.12036-1-dakr@kernel.org>
 <20241219170425.12036-8-dakr@kernel.org>
 <g63h5f3zowy375yutftautqhurflahq3o5nmujbr274c5d7u7u@j5cbqi5aba6k>
 <CANiq72=gZhG8MOCqPi8F0yp3WR1oW77V+MXdLP=RK_R2Jzg-cw@mail.gmail.com>
 <wnzq3vlgawjdchjck7nzwlzmm5qbmactwlhtj44ak7s7kefphd@m7emgjnmnkjn>
 <Z72jw3TYJHm7N242@pollux>
 <nlngenb6udempavyevw62qvdzuo7jr4m5mt4fwvznza347vicl@ynn4c5lojoub>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nlngenb6udempavyevw62qvdzuo7jr4m5mt4fwvznza347vicl@ynn4c5lojoub>

On Thu, Feb 27, 2025 at 11:25:55AM +1100, Alistair Popple wrote:
> On Tue, Feb 25, 2025 at 12:04:35PM +0100, Danilo Krummrich wrote:
> > On Tue, Feb 25, 2025 at 04:50:05PM +1100, Alistair Popple wrote:
> 
> > I think build_assert() is not widely used yet and, until the situation improves,
> > we could also keep a list of common pitfalls if that helps?
> 
> I've asked a few times, but are there any plans/ideas on how to improve the
> situation?

I just proposed a few ones. If the limitation can be resolved I don't know.

There are two different cases.

	(1) build_assert() is evaluated in const context to false
	(2) the compiler can't guarantee that build_assert() is evaluated to
	    true at compile time

For (1) you get a proper backtrace by the compiler. For (2) there's currently
only the option to make the linker fail, which doesn't produce the most useful
output.

If we wouldn't do (2) we'd cause a kernel panic on runtime, which can be
enforced with CONFIG_RUST_BUILD_ASSERT_ALLOW=y.

> I'm kind of suprised we're building things on top of a fairly broken
> feature without an idea of how we might make that feature work. I'd love to
> help, but being new to R4L no immediately useful ideas come to mind.

The feature is not broken at all, it works perfectly fine. It's just that for
(2) it has an ergonomic limitation.

> > > Unless the code absolutely cannot compile without them I think it would be
> > > better to turn them into runtime errors that can at least hint at what might
> > > have gone wrong. For example I think a run-time check would have been much more
> > > appropriate and easy to debug here, rather than having to bisect my changes.
> > 
> > No, especially for I/O the whole purpose of the non-try APIs is to ensure that
> > boundary checks happen at compile time.
> 
> To be honest I don't really understand the utility here because the compile-time
> check can't be a definitive check. You're always going to have to fallback to
> a run-time check because at least for PCI (and likely others) you can't know
> for at compile time if the IO region is big enough or matches the compile-time
> constraint.

That's not true, let me explain.

When you write a driver, you absolutely have to know the register layout. This
means that you also know what the minimum PCI bar size has to be for your driver
to work. If it would be smaller than what your driver expects, it can't function
anyways. In Rust we make use of this fact.

When you map  a PCI bar through `pdev.iomap_region_sized` you pass in a const
generic (`SIZE`) representing the *expected* PCI bar size. This can indeed fail
on run-time, but that's fine, as mentioned, if the bar is smaller than what your
driver expect, it's useless anyways.

If the call succeeds, it means that the actual PCI bar size is greater or equal
to `SIZE`. Since `SIZE` is known at compile time all subsequent I/O operations
can be boundary checked against `SIZE` at compile time, which additionally makes
the call infallible. This works for most I/O operations drivers do.

However, sometimes we need to do I/O ops at a PCI bar offset that is only known
at run-time. In this case you can use the `try_*` variants, such as
`try_read32()`. Those do boundary checks against the actual size of the PCI bar,
which is only known at run-time and hence they're fallible.

> 
> So this seems more like a quiz for developers to check if they really do want
> to access the given offset. It's not really doing any useful compile-time bounds
> check that is preventing something bad from happening, becasue that has to
> happen at run-time. Especially as the whole BAR is mapped anyway.

See the explanation above.

> 
> Hence why I think an obvious run-time error instead of an obtuse and difficult
> to figure out build error would be better. But maybe I'm missing some usecase
> here that makes this more useful.

No, failing the boundary check at compile time (if possible) is always better
than failing it at run-time for obvious reasons.

> 
> > > I was hoping I could suggest CONFIG_RUST_BUILD_ASSERT_ALLOW be made default yes,
> > > but testing with that also didn't yeild great results - it creates a backtrace
> > > but that doesn't seem to point anywhere terribly close to where the bad access
> > > was, I'm guessing maybe due to inlining and other optimisations - or is
> > > decode_stacktrace.sh not the right tool for this job?
> > 
> > I was about to suggest CONFIG_RUST_BUILD_ASSERT_ALLOW=y to you, since this will
> > make the kernel panic when hitting a build_assert().
> > 
> > I gave this a quick try with [1] in qemu and it lead to the following hint,
> > right before the oops:
> > 
> > [    0.957932] rust_kernel: panicked at /home/danilo/projects/linux/nova/nova-next/rust/kernel/io.rs:216:9:
> > 
> > Seeing this immediately tells me that I'm trying to do out of bound I/O accesses
> > in my driver, which indeed doesn't tell me the exact line (in case things are
> > inlined too much to gather it from the backtrace of the oops), but it should be
> > good enough, no?
> 
> *smacks forehead*
> 
> Yes. So to answer this question:
> 
> > or is decode_stacktrace.sh not the right tool for this job?
> 
> No, it isn't. Just reading the kernel logs properly would have been a better
> option! I guess coming from C I'm just too used to jumping straight to the stack
> trace in the case of BUG_ON(), etc. Thanks for point that out.

Happy I could help.

