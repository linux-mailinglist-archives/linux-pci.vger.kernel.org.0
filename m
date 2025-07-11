Return-Path: <linux-pci+bounces-31953-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 684DDB0256F
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jul 2025 21:56:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C077D5A52A3
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jul 2025 19:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80EA2F3C31;
	Fri, 11 Jul 2025 19:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YWlGpwZC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F041F03C5;
	Fri, 11 Jul 2025 19:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752263669; cv=none; b=Meu9dC1eSpiqsh+Am2+KSgWyFcEJggT37jNTrj46MKpJ+cFIY36dLtNczcVvUwYBtsR7VjgMJowTS9wZ6A+toYDwdvcMXLIVNCf3PRAOQNkvf04YaFKwWuuj7vXyAutkuS6VqKSVAZxJBffb6Aiyk+04j72PY/nxXLunBY3ykYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752263669; c=relaxed/simple;
	bh=PqDZ52E91jh6aD9+8vsMna/zDDeoowu+ExCjFmSk7wc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=fENekiODRHq9XtwVoCoqvpxcjxO8qG/fyEKLr/6qEEOygHnCRKZIUzRgvr3O7Vsy/ouCU4lhmLowOR/l0/TZno6e4FB1uWn3lPdqXOPX47WDtTPFL0B34aOFVeD05ttuN1h12jhi65+K2FI/d8fMlDH3KFEujFzjbplP/BZK3RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YWlGpwZC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C7A4C4CEED;
	Fri, 11 Jul 2025 19:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752263669;
	bh=PqDZ52E91jh6aD9+8vsMna/zDDeoowu+ExCjFmSk7wc=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=YWlGpwZClBvzJvVaJCw7YzJ+MYWL5zdZcqqLskM+hhJbt0OBqNoAAJIVK1vpEguDa
	 UHUDLCBDZ1Ee63MGGjRfE4CPhytedPavAJSOj/fj4w9//csXWpGkBur/UAScUP+shN
	 JV8x/VeqpyUuIL0tAWB37oL0ogigSsxVU9TwVlXFuoSWxbUrLfggA6dwPneGwnubIo
	 3fVVff19lykeddMD2JlejKy9TKTQflc+QqlcJhaArx4lZEVuIcf3Hy7iyTD4b+22ui
	 S4DKipScHhxlwPtbyJlDE1CbfbYnAPA9c8Bh/KZK/lRpqUXOPbnHvTY3mETyzI5PAA
	 xl3tu6Gz9dB9A==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 11 Jul 2025 21:54:23 +0200
Message-Id: <DB9HMM5M24FE.1VR5ZE5YJ66CK@kernel.org>
Subject: Re: [PATCH 2/5] rust: dma: add DMA addressing capabilities
Cc: <abdiel.janulgue@gmail.com>, <daniel.almeida@collabora.com>,
 <robin.murphy@arm.com>, <a.hindborg@kernel.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <aliceryhl@google.com>,
 <tmgross@umich.edu>, <bhelgaas@google.com>, <kwilczynski@kernel.org>,
 <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: "Joel Fernandes" <joelagnelf@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250710194556.62605-1-dakr@kernel.org>
 <20250710194556.62605-3-dakr@kernel.org> <20250711193537.GA935333@joelbox2>
In-Reply-To: <20250711193537.GA935333@joelbox2>

On Fri Jul 11, 2025 at 9:35 PM CEST, Joel Fernandes wrote:
> It looks good to me. A few high-level comments:
>
> 1. If we don't expect the concurrency issue for this in C code, why do we
> expect it to happen in rust?=20

The race can happen in C as well, but people would probably argue that no o=
ne
ever calls the mask setter function concurrently to DMA allocation and mapp=
ing
primitives.

> 2. Since the Rust code is wrapping around the C code, the data race is
> happening entirely on the C side right? So can we just rely on KCSAN to c=
atch
> concurrency issues instead of marking the callers as unsafe? I feel the
> unsafe { } really might make the driver code ugly.

If the function is declared safe in Rust it means that we have to guarantee=
 that
any possible use won't lead to undefined behavior. This isn't the case here
unfortunately.

> 3. Maybe we could document this issue than enforce it via unsafe? My conc=
ern
> is wrapping unsafe { } makes the calling code ugly.

Not possible, that's exactly what unsafe is for. We can't violate the "safe
functions can't cause UB" guarantee.

> 4. Are there other kernel APIs where Rust wraps potentially racy C code a=
s
> unsafe?

Sure, but we usually don't expose those to drivers. We always try to make t=
hings
safe for drivers.

This case is a bit special though. There is a way to avoid unsafe for the D=
MA
mask setter methods, but it would involve at least three new type states fo=
r
device structures and duplicated API interfaces for types that expect certa=
in
type states.

The conclusion was to go with unsafe for now, since introducing this kind o=
f
complexity is not worth for something that is (not entirely, but more of) a
formal problem.

In the long term I'd like to get those setters safe, e.g. by making the DMA=
 mask
fields atomics.

> 5. In theory, all rust bindings wrappers are unsafe and we do mark it aro=
und
> the bindings call, right? But in this case, we're also making the calling
> code of the unsafe caller as unsafe. C code is 'unsafe' obviously from Ru=
st
> PoV but I am not sure we worry about the internal implementation-unsafety=
 of
> the C code because then maybe most bindings wrappers would need to be uns=
afe,
> not only these DMA ones.

No, the key is to design Rust APIs in a way that the abstraction can't call=
 C
functions in a way that potentially causes undefined behavor.

As an example, let's have a look at a PCI device function:

	/// Enable bus-mastering for this device.
	pub fn set_master(&self) {
	    // SAFETY: `self.as_raw` is guaranteed to be a pointer to a valid `str=
uct pci_dev`.
	    unsafe { bindings::pci_set_master(self.as_raw()) };
	}

pci_set_master() is unsafe because it takes a pointer value, so the caller =
can
easily cause UB by passing an invalid pointer.

pci::Device::set_master() is safe, because once you have a pci::Device inst=
ance, there is no way
(other than due to a bug) that you obtain an invalid pointer from it to
subsequently call pci_set_master().

This means for the caller there is no way to call pci::Device::set_master()=
 such
that it can cause UB.

