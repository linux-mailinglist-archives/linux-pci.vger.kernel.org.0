Return-Path: <linux-pci+bounces-45061-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 91AB1D33356
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 16:32:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CCB5030D7655
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 15:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7163F338916;
	Fri, 16 Jan 2026 15:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UsGUOk1J"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA58298CAF;
	Fri, 16 Jan 2026 15:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768577255; cv=none; b=Eg/mkdYl8YIkNplVftJr+QvP/r28nmsJxPkh5WbfoJNC+ZFyAdT8P+KXmxOHxhd5KUh0TPuH7Btc7N+An/7/FuKp/tW4d02fEvjFziPhYKvmSd0cw+/GHzo427FfA5wYmvLnLEu/IfqsHdJNH+cogmsIQR47qXfjHFjvchRFYLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768577255; c=relaxed/simple;
	bh=TXRaMd6yK91g0ToFsaqHL/VMAkwOLt4e/nQgm9PwaIw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=pWHTwvBw6BSn10Qwew2jCjYZE1AR3Cg5GOv1o43Lqpqwq0YD2zvzFraQJLNfmCjuP7vtu7mjnjObjPYsvp47XQ09YN5AS90cLFUW4l7JmopAiLbOoInmjndxKAG4uOFs5kwGIvTKo+qRXriEhaqZCcVU+EL3oeOBhOetQ3j0vic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UsGUOk1J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 804E3C19421;
	Fri, 16 Jan 2026 15:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768577255;
	bh=TXRaMd6yK91g0ToFsaqHL/VMAkwOLt4e/nQgm9PwaIw=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
	b=UsGUOk1Jf5gEUiPKBiFlViVdLgYU3KeL7CL/4/d107LH3lcwecOMHw2ynZg6LCdGZ
	 J1xZ8dKL81i4kJ5+F94bvkbIp4pCJ+OaqH9unDBb3nouUGHCJISeF01Ea2BzxEhAkb
	 eBLHejQyEqVdunwTRP+BnKq9apBW6/SVTyz4F9hmzKzpJUse/t37iESQiBY9EkLqQz
	 ipvDs6BQh2/HZpbFT/9+eEDQqC3ecVNSQUCSVbb5OekyXjpl9HWqdYs39VV0gYAbR9
	 62vXsdg8w86/2x0ZpBlWYOEW4t1kSTFuMtGmDSGTtc+n2CcbuhdnVD+dIyhDABwEd0
	 0N0eT8Vz86aPw==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 16 Jan 2026 16:27:27 +0100
Message-Id: <DFQ4B7CJR5EW.TMEE2YAES7O2@kernel.org>
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
 <boqun.feng@gmail.com>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>, <markus.probst@posteo.de>,
 <helgaas@kernel.org>, <cjia@nvidia.com>, <smitra@nvidia.com>,
 <ankita@nvidia.com>, <aniketa@nvidia.com>, <kwankhede@nvidia.com>,
 <targupta@nvidia.com>, <acourbot@nvidia.com>, <joelagnelf@nvidia.com>,
 <jhubbard@nvidia.com>, <zhiwang@kernel.org>,
 <daniel.almeida@collabora.com>, <markus.probst@posteo.de>
To: "Gary Guo" <gary@garyguo.net>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v9 2/5] rust: io: factor common I/O helpers into Io
 trait
References: <20260115212657.399231-1-zhiw@nvidia.com>
 <20260115212657.399231-3-zhiw@nvidia.com> <aWoWntMxyhBc9Unx@google.com>
 <DFQ481S2NI1S.3HMMZMYEQ9QP8@garyguo.net>
In-Reply-To: <DFQ481S2NI1S.3HMMZMYEQ9QP8@garyguo.net>

(Cc: Markus)

On Fri Jan 16, 2026 at 4:23 PM CET, Gary Guo wrote:
> I wonder if we can keep all methods on `Io` trait. And then have marker t=
rait to
> represent capability on performing Io access.
>
> Something like:
>
> trait IoCapable<T> {}
>
> trait Io {
>      fn read8(&self, offset: usize) -> u8 where Self: IoCapable<u8>;
>      fn read16(&self, offset: usize) -> u16 where Self: IoCapable<u16>;
>      fn read32(&self, offset: usize) -> u32 where Self: IoCapable<u32>;
>      fn read64(&self, offset: usize) -> u64 where Self: IoCapable<u64>;
> }
>
> Then you have a single (non-marker) trait and not a hierachy of them.

I think that is a great idea. I think it will also help with supporting I/O
backends based on regmap.

