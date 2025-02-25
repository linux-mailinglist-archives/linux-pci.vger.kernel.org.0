Return-Path: <linux-pci+bounces-22325-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FD1A43D14
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 12:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6898D7A3CC2
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 11:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17150267B66;
	Tue, 25 Feb 2025 11:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A1UR7qNU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6630264F9D;
	Tue, 25 Feb 2025 11:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740481485; cv=none; b=lKlUHNW4EGbAOILzzS13NPAM4gOP0H4mHT3w4QOnWklZd8TJhd5N+0TGO8b31L4UtFYG7y+XdtU8WeMxSKD6LAFSUvjQRKt7euZnEqsMrmXJpdQ+98Md9CC1Cp6wUzO4jYTPVFkEIPtAmLddSQ4odEqr2R8dIny1K3C5aYRRaz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740481485; c=relaxed/simple;
	bh=yG++BUr1pNW36WEJ6xY32Zg5CTCOUnmylM4FpVv0kMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B24Qxb+deaOrk5zTL29EbeGtmBzxCCtDkWDx8uhjsQwX2eJSpjt5m1ZIZ//JC3vJMPyUvETrxv/XiIlJd3kYY6EZP7So0jZgTrK0VKxkpdd2/89Ia7HACWcaBAltYrw4YQ2d2F4dxp7jclpsD9+RaaxsDDFLTsxjeGYERfWWvY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A1UR7qNU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA153C4CEDD;
	Tue, 25 Feb 2025 11:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740481484;
	bh=yG++BUr1pNW36WEJ6xY32Zg5CTCOUnmylM4FpVv0kMQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A1UR7qNUbDGRyiD1BhKsH5VWnThtZcFC0d27b9VJeHmkHZxNCdC6Ckq8KDmabuyhu
	 L5g08E7PlSDrM54pDhgvaMHfZ09mqWSNccGhPVlc9rG+G/Pzxtbn4U0v4PjUpe8Ppj
	 gF+fG5gJ5z3rnDfLDakSHIpRa9mnNEkPEQP9c5XPXefnzdLkCzk2k+0hN5ht3Ps6ym
	 E5Z6gu8sEAqI6Xfpe/EdrXaSR14kPDAYqZAWoFcVIhFfC25WFfRJQpfuAH5JueBd98
	 ayRBqiZirbr4/LPy8PqGdeSdPtSxZVfcrjBNBto088z/zUVFJm5w8ANmqTbw/CyUD8
	 lZJP6AlKfBcqA==
Date: Tue, 25 Feb 2025 12:04:35 +0100
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
Message-ID: <Z72jw3TYJHm7N242@pollux>
References: <20241219170425.12036-1-dakr@kernel.org>
 <20241219170425.12036-8-dakr@kernel.org>
 <g63h5f3zowy375yutftautqhurflahq3o5nmujbr274c5d7u7u@j5cbqi5aba6k>
 <CANiq72=gZhG8MOCqPi8F0yp3WR1oW77V+MXdLP=RK_R2Jzg-cw@mail.gmail.com>
 <wnzq3vlgawjdchjck7nzwlzmm5qbmactwlhtj44ak7s7kefphd@m7emgjnmnkjn>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wnzq3vlgawjdchjck7nzwlzmm5qbmactwlhtj44ak7s7kefphd@m7emgjnmnkjn>

On Tue, Feb 25, 2025 at 04:50:05PM +1100, Alistair Popple wrote:
> Kind of, but given the current state of build_assert's and the impossiblity of
> debugging them should we avoid adding them until they can be fixed?

If you build the module as built-in the linker gives you some more hints, but
I agree it's still not great.

I think build_assert() is not widely used yet and, until the situation improves,
we could also keep a list of common pitfalls if that helps?

> Unless the code absolutely cannot compile without them I think it would be
> better to turn them into runtime errors that can at least hint at what might
> have gone wrong. For example I think a run-time check would have been much more
> appropriate and easy to debug here, rather than having to bisect my changes.

No, especially for I/O the whole purpose of the non-try APIs is to ensure that
boundary checks happen at compile time.

> I was hoping I could suggest CONFIG_RUST_BUILD_ASSERT_ALLOW be made default yes,
> but testing with that also didn't yeild great results - it creates a backtrace
> but that doesn't seem to point anywhere terribly close to where the bad access
> was, I'm guessing maybe due to inlining and other optimisations - or is
> decode_stacktrace.sh not the right tool for this job?

I was about to suggest CONFIG_RUST_BUILD_ASSERT_ALLOW=y to you, since this will
make the kernel panic when hitting a build_assert().

I gave this a quick try with [1] in qemu and it lead to the following hint,
right before the oops:

[    0.957932] rust_kernel: panicked at /home/danilo/projects/linux/nova/nova-next/rust/kernel/io.rs:216:9:

Seeing this immediately tells me that I'm trying to do out of bound I/O accesses
in my driver, which indeed doesn't tell me the exact line (in case things are
inlined too much to gather it from the backtrace of the oops), but it should be
good enough, no?

[1]

diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_pci.rs
index 1fb6e44f3395..2ff3af11d711 100644
--- a/samples/rust/rust_driver_pci.rs
+++ b/samples/rust/rust_driver_pci.rs
@@ -13,7 +13,7 @@ impl Regs {
     const OFFSET: usize = 0x4;
     const DATA: usize = 0x8;
     const COUNT: usize = 0xC;
-    const END: usize = 0x10;
+    const END: usize = 0x2;
 }

 type Bar0 = pci::Bar<{ Regs::END }>;

