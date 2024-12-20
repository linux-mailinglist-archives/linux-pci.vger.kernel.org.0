Return-Path: <linux-pci+bounces-18913-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FADA9F96C6
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2024 17:44:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7039A16AA9D
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2024 16:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21070218EAC;
	Fri, 20 Dec 2024 16:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="u+mX9gp0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACAF1C4A1C;
	Fri, 20 Dec 2024 16:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734713076; cv=none; b=COgC2IhxjNwrbY+lvuO4vtSq+GD8+2txsM214WHW/kZV9R/7GekpjLtiR2/JkQsvZk15U52CtwXM+AfJZzmDf38i8pbbwf9mGXs33B2J+9yfDtwRBJhJHjj0cEwu276Ud4LyroeFivAi4dVbURPnMT5Q2xdZPVJXAZQjE9TkcMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734713076; c=relaxed/simple;
	bh=/W6KyWLZlMH11g0ZeGK+Lh6aIPfQrX8kBjIMECm+d5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IPTwFg94V6YDvhy7ZlOeect4AH5Rzi4ybZPuJrqlpQj8eRGFULI9VhRJLi0oAs7uXD3bT/+g09BOUuxCg+NBFe2G90Nw34jZWias1IrN8bE73Ys7x3carwNnesE50u3fe8ogsoaTIZeG8dQhEOJnbRor4JRH6kmRWthq79Wwv+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=u+mX9gp0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1311CC4CECD;
	Fri, 20 Dec 2024 16:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734713075;
	bh=/W6KyWLZlMH11g0ZeGK+Lh6aIPfQrX8kBjIMECm+d5M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u+mX9gp0NI1sL3o4th4djHYK5dBf/0xQlg/OKaDCpAkkl8mPc+JPsPsMk7iEHvjvf
	 KRqSuRlfZUGpDQDYTy3cCL4ZIoh4RY/0jVHHmd0qT7gYwenPiEJvcJaWOCOyMke5A7
	 cJyC18i4ooGBrDaXfc/xGbwcGxM2IvRCtnXHCiEE=
Date: Fri, 20 Dec 2024 17:44:31 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: rafael@kernel.org, bhelgaas@google.com, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
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
Subject: Re: [PATCH v7 00/16] Device / Driver PCI / Platform Rust abstractions
Message-ID: <2024122031-outfit-mop-86d0@gregkh>
References: <20241219170425.12036-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241219170425.12036-1-dakr@kernel.org>

On Thu, Dec 19, 2024 at 06:04:02PM +0100, Danilo Krummrich wrote:
> This patch series implements the necessary Rust abstractions to implement
> device drivers in Rust.
> 
> This includes some basic generalizations for driver registration, handling of ID
> tables, MMIO operations and device resource handling.
> 
> Those generalizations are used to implement device driver support for two
> busses, the PCI and platform bus (with OF IDs) in order to provide some evidence
> that the generalizations work as intended.
> 
> The patch series also includes two patches adding two driver samples, one PCI
> driver and one platform driver.
> 
> The PCI bits are motivated by the Nova driver project [1], but are used by at
> least one more OOT driver (rnvme [2]).
> 
> The platform bits, besides adding some more evidence to the base abstractions,
> are required by a few more OOT drivers aiming at going upstream, i.e. rvkms [3],
> cpufreq-dt [4], asahi [5] and the i2c work from Fabien [6].
> 
> The patches of this series can also be [7], [8] and [9].
> 
> Changes in v7:
> ==============
> - Revocable:
>   - replace `compare_exchange` with `swap`
> 
> - Driver:
>   - fix warning when CONFIG_OF=n
> 
> - I/O:
>   - remove unnecessary return statement in rust_helper_iounmap()
>   - fix cast in doctest for `bindings::ioremap`
> 
> - Devres:
>   - fix cast in doctest for `bindings::ioremap`
> 
> - PCI:
>   - remove `Deref` of `pci::DeviceId`
>   - rename `DeviceId` constructors
>     - `new`       -> `from_id`
>     - `with_class -> `from_class`
> 
> - MISC:
>   - use `kernel::ffi::c_*` instead of `core::ffi::c_*`
>   - rebase onto latest rust-next (0c5928deada15a8d075516e6e0d9ee19011bb000)

Thanks for this last round of changes, looks great to me!  I've added
them all to my driver-core-testing branch, and if 0-day doesn't
complain, will move it to driver-core-next for merging into 6.14-rc1.

Thanks for persisting with this, looks great.  Now the real work starts :)

thanks,

greg k-h

