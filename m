Return-Path: <linux-pci+bounces-38404-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 687FBBE598E
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 23:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CF0BF4F0FC0
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 21:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18CA02E62A4;
	Thu, 16 Oct 2025 21:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S3pgPtJ/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFFA2E612E;
	Thu, 16 Oct 2025 21:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760651313; cv=none; b=lYUd0+v11pfUKRcx1aV1v7wQj4V0OhypAIzG1TDwz1blE4HLBv+fD7oteNiPolGGV+QnKioia1Xtf4yZa6+eE0B5Lu5FjGApt8NbHs2fNqY04AC1Jz/MTFwWkGpxvx6S7zAgHdQTS49SvgdVX56A5VxZShWIrBXUd5jtwJUzB/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760651313; c=relaxed/simple;
	bh=az2P0BtWOdbNV9GVnUGrbuYR+gFXF+qCpHSYxeMG9Y0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=IMQ+SLcuM1hfMoGEwU3bcCt63DbyjOZ9HNKnM+/VV412M5c8D0LDgeenOuZWTuKYk5Zk/pQxoDZk9cum47Vwda5uXziJWin7/Jhf6FEj5r/8hWpBK2IzO9CIRBbtXFwRlcJcE4Y6K4cUtb1rXJJqGgtDTfHpkL9Ve28qOgxmDmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S3pgPtJ/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CBCCC4CEF1;
	Thu, 16 Oct 2025 21:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760651312;
	bh=az2P0BtWOdbNV9GVnUGrbuYR+gFXF+qCpHSYxeMG9Y0=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=S3pgPtJ/dxSC0vCGR7QZtHL8vtSOJDzsapuk50mdbYa2Bzph4QxYTLe4mdrOb9VOS
	 EPbPLvQvJ8E4OoEQDjLcCVqxfP/crT4q5rweC/WxdiUod3jm1woACovGDOkofs9ZfZ
	 SIXHZQo+9gXCQtFPlTX4B43idgOIAFf8PsiQbkOnYM1CuIrRT3eT06BcTXsAqk7Y1R
	 rcZYL1+MnGfTxb1NxkMV/Lno9/7/axlaD9bnhNDTbfrXdXtJak7x7pYpVwQ5Dgiqd5
	 507EJO3k6eqIES5q9RdHzE+7koQyPPY0w7yIhd1yrXMbM6iflC8NPB6cPRnVI5E1nC
	 9drphuLbHu6xw==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 16 Oct 2025 23:48:25 +0200
Message-Id: <DDK2SRUF7OG7.1HEZXR1V4ND8Z@kernel.org>
Cc: <viresh.kumar@linaro.org>, <acourbot@nvidia.com>, <ira.weiny@intel.com>,
 <leon@kernel.org>, <daniel.almeida@collabora.com>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <abdiel.janulgue@gmail.com>,
 <robin.murphy@arm.com>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
 <boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <a.hindborg@kernel.org>, <aliceryhl@google.com>, <tmgross@umich.edu>,
 <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-pm@vger.kernel.org>, <nouveau@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rust: driver: let probe() return impl PinInit<Self,
 Error>
From: "Benno Lossin" <lossin@kernel.org>
To: "Danilo Krummrich" <dakr@kernel.org>, <gregkh@linuxfoundation.org>,
 <rafael@kernel.org>
X-Mailer: aerc 0.21.0
References: <20251016125544.15559-1-dakr@kernel.org>
In-Reply-To: <20251016125544.15559-1-dakr@kernel.org>

On Thu Oct 16, 2025 at 2:55 PM CEST, Danilo Krummrich wrote:
> The driver model defines the lifetime of the private data stored in (and
> owned by) a bus device to be valid from when the driver is bound to a
> device (i.e. from successful probe()) until the driver is unbound from
> the device.
>
> This is already taken care of by the Rust implementation of the driver
> model. However, we still ask drivers to return a Result<Pin<KBox<Self>>>
> from probe().
>
> Unlike in C, where we do not have the concept of initializers, but
> rather deal with uninitialized memory, drivers can just return an
> impl PinInit<Self, Error> instead.
>
> This contributed to more clarity to the fact that a driver returns it's
> device private data in probe() and the Rust driver model owns the data,
> manages the lifetime and - considering the lifetime - provides (safe)
> accessors for the driver.
>
> Hence, let probe() functions return an impl PinInit<Self, Error> instead
> of Result<Pin<KBox<Self>>>.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
> Depends on a minor pin-init patch [1] (Benno will send it to the list
> soon). A branch with this patch and the pin-init dependency is available
> in [2].

I sent the patch to the list:

    https://lore.kernel.org/all/20251016210541.650056-1-lossin@kernel.org

---
Cheers,
Benno

>
> [1] https://github.com/Rust-for-Linux/pin-init/pull/86/commits
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/dakr/linux.git/log/?h=
=3Dprobe_return
> ---
>  drivers/cpufreq/rcpufreq_dt.rs        |  4 +-
>  drivers/gpu/drm/nova/driver.rs        |  4 +-
>  drivers/gpu/drm/tyr/driver.rs         |  4 +-
>  drivers/gpu/nova-core/driver.rs       | 34 +++++++----------
>  rust/kernel/auxiliary.rs              |  6 +--
>  rust/kernel/cpufreq.rs                |  4 +-
>  rust/kernel/device.rs                 |  9 ++++-
>  rust/kernel/driver.rs                 |  4 +-
>  rust/kernel/io/mem.rs                 |  8 ++--
>  rust/kernel/pci.rs                    |  8 ++--
>  rust/kernel/platform.rs               | 12 +++---
>  rust/kernel/usb.rs                    |  4 +-
>  samples/rust/rust_debugfs.rs          | 21 ++++++-----
>  samples/rust/rust_dma.rs              | 37 +++++++++----------
>  samples/rust/rust_driver_auxiliary.rs | 25 +++++--------
>  samples/rust/rust_driver_pci.rs       | 53 +++++++++++++--------------
>  samples/rust/rust_driver_platform.rs  |  6 +--
>  samples/rust/rust_driver_usb.rs       |  5 +--
>  18 files changed, 117 insertions(+), 131 deletions(-)

