Return-Path: <linux-pci+bounces-44665-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A9CAD1B17B
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 20:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 70835303ACF6
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 19:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D70536C595;
	Tue, 13 Jan 2026 19:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dYDqMc0p"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E329335E527;
	Tue, 13 Jan 2026 19:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768333485; cv=none; b=IjN9PI42UjnDZE8VV17rpAreAWWL8w7GGTUt9e80mOMCOUXKBYoSHFcwk6jD8EgyFLOVSbqqpeku7eEpkdsxGHoXN1rfDVOjJWv7bRhfeL9bojK05KgOMxNjNlV+Um9renxpxAdlNqeEVwA3dN8cfw0BvAhnoIokRuqbNFBnMrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768333485; c=relaxed/simple;
	bh=xcSIwmUhq35k9I8BYW8bVgi9M0uhdkya0n/w4q+aQ+Q=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=DcqVHcHmuVrm6yICsnV0goOY6pPEs3tUhNAor2d+T6yPF237FQKseZbRJ8yssKwGb5keo6JI96r7vHH7Gpd4dXgA7v0W2vkQLkcN2UI+gp3GxbA2XzLiKkAYYHFzKzVNO89MY+G3UPuUhnQ4MZCCn2COdnhp9I0ad1tOgY6ROqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dYDqMc0p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84534C116C6;
	Tue, 13 Jan 2026 19:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768333484;
	bh=xcSIwmUhq35k9I8BYW8bVgi9M0uhdkya0n/w4q+aQ+Q=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=dYDqMc0p9gZLVQpLWafkmXeJ8n6uauLWhZIt+DQmvg3Kfsx0Kb3SLo28GIcbjnLno
	 P8YjKB/XLQFNOu5O+s15VMXcX3azlGmLgUYhwxPM9+51w7JMnVXZbyAucmEOcA9/6o
	 d/hwhnXbWc6LK36ooL9upMASdsMjqzIo3ULLKhwS6byW8BiEFMJQzqCOiEdhDgqHcT
	 hv2HYJFIN9XgSyFg0tgQd8xqf6l/3WS1+XKBq7Bnma23SV1dxNaadBr/fRdj1tGzmg
	 qYMJ20k8+JwgkitVcGbGw3v354WgWRY4dIsLqGRuZr6wyHfcBHGrRbXisWPnSnYBJU
	 kA/im5TvpE/QQ==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 Jan 2026 20:44:37 +0100
Message-Id: <DFNPWGYVIY66.1HD14G875G8L0@kernel.org>
Subject: Re: [PATCH v8 2/5] rust: io: factor common I/O helpers into Io
 trait
Cc: <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <aliceryhl@google.com>,
 <bhelgaas@google.com>, <kwilczynski@kernel.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <markus.probst@posteo.de>, <helgaas@kernel.org>,
 <cjia@nvidia.com>, <smitra@nvidia.com>, <ankita@nvidia.com>,
 <aniketa@nvidia.com>, <kwankhede@nvidia.com>, <targupta@nvidia.com>,
 <acourbot@nvidia.com>, <joelagnelf@nvidia.com>, <jhubbard@nvidia.com>,
 <zhiwang@kernel.org>
To: "Zhi Wang" <zhiw@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260113092253.220346-1-zhiw@nvidia.com>
 <20260113092253.220346-3-zhiw@nvidia.com>
In-Reply-To: <20260113092253.220346-3-zhiw@nvidia.com>

On Tue Jan 13, 2026 at 10:22 AM CET, Zhi Wang wrote:
>  drivers/gpu/nova-core/gsp/sequencer.rs |   5 +-
>  drivers/gpu/nova-core/regs/macros.rs   |  90 ++++----
>  drivers/gpu/nova-core/vbios.rs         |   1 +
>  rust/kernel/devres.rs                  |  14 +-
>  rust/kernel/io.rs                      | 271 ++++++++++++++++++-------
>  rust/kernel/io/mem.rs                  |  16 +-
>  rust/kernel/io/poll.rs                 |   8 +-
>  rust/kernel/pci/io.rs                  |  12 +-
>  samples/rust/rust_driver_pci.rs        |   2 +
>  9 files changed, 288 insertions(+), 131 deletions(-)

I think you did forget to update the Tyr driver.

> +/// Represents a region of I/O space of a fixed size.
> +///
> +/// Provides common helpers for offset validation and address
> +/// calculation on top of a base address and maximum size.

Maybe you can expand this a bit, i.e. explaining that this is a abstract
representation to be implemented by arbitrary I/O backends pointing out som=
e
examples, such as MMIO, I2C, etc.

> +///

Spurious newline.

> +pub trait IoBase {

<snip>

> +/// Types implementing this trait (e.g. MMIO BARs or PCI config
> +/// regions) can share the same KnownSize accessors.

Please expand this a bit and add some more detailed explanation what "known
size" means in this context, i.e. it is the minimum size requested from the=
 I/O
backend, hence we know that we are safe within this boundary.

However, the size of the requested I/O region might still be larger than th=
e
"known size".

> +pub trait IoKnownSize: IoBase {
> +    /// Infallible 8-bit read with compile-time bounds check.
> +    fn read8(&self, offset: usize) -> u8;
> +
> +    /// Infallible 16-bit read with compile-time bounds check.
> +    fn read16(&self, offset: usize) -> u16;
> +
> +    /// Infallible 32-bit read with compile-time bounds check.
> +    fn read32(&self, offset: usize) -> u32;
> +
> +    /// Infallible 8-bit write with compile-time bounds check.
> +    fn write8(&self, value: u8, offset: usize);
> +
> +    /// Infallible 16-bit write with compile-time bounds check.
> +    fn write16(&self, value: u16, offset: usize);
> +
> +    /// Infallible 32-bit write with compile-time bounds check.
> +    fn write32(&self, value: u32, offset: usize);
> +}
> +
> +/// Types implementing this trait (e.g. MMIO BARs or PCI config
> +/// regions) can share the same Io accessors.

Same here, please add some more detail, e.g. how does it differ from
IoKnownSize, in which cases should it be used, etc.

> +pub trait Io: IoBase {
> +    /// Fallible 8-bit read with runtime bounds check.
> +    fn try_read8(&self, offset: usize) -> Result<u8>;
> +
> +    /// Fallible 16-bit read with runtime bounds check.
> +    fn try_read16(&self, offset: usize) -> Result<u16>;
> +
> +    /// Fallible 32-bit read with runtime bounds check.
> +    fn try_read32(&self, offset: usize) -> Result<u32>;
> +
> +    /// Fallible 8-bit write with runtime bounds check.
> +    fn try_write8(&self, value: u8, offset: usize) -> Result;
> +
> +    /// Fallible 16-bit write with runtime bounds check.
> +    fn try_write16(&self, value: u16, offset: usize) -> Result;
> +
> +    /// Fallible 32-bit write with runtime bounds check.
> +    fn try_write32(&self, value: u32, offset: usize) -> Result;
> +}
> +
> +/// Represents a region of I/O space of a fixed size with 64-bit accesso=
rs.
> +/// Types implementing this trait can share the same Infallible accessor=
s.

Please refer to IoKnownSize for details.

> +#[cfg(CONFIG_64BIT)]
> +pub trait IoKnownSize64: IoKnownSize {
> +    /// Infallible 64-bit read with compile-time bounds check.
> +    fn read64(&self, offset: usize) -> u64;
> =20
> -    define_read!(read8, try_read8, readb -> u8);
> -    define_read!(read16, try_read16, readw -> u16);
> -    define_read!(read32, try_read32, readl -> u32);
> +    /// Infallible 64-bit write with compile-time bounds check.
> +    fn write64(&self, value: u64, offset: usize);
> +}
> +
> +/// Types implementing this trait can share the same Fallible accessors.
> +#[cfg(CONFIG_64BIT)]
> +pub trait Io64: Io {

Please refer to Io for details.

> diff --git a/rust/kernel/io/poll.rs b/rust/kernel/io/poll.rs
> index b1a2570364f4..65d5a370ed14 100644
> --- a/rust/kernel/io/poll.rs
> +++ b/rust/kernel/io/poll.rs
> @@ -45,12 +45,12 @@
>  /// # Examples
>  ///
>  /// ```no_run
> -/// use kernel::io::{Io, poll::read_poll_timeout};
> +/// use kernel::io::{Io, Mmio, poll::read_poll_timeout};

Please switch to vertical style while at it, here and below.

>  /// use kernel::time::Delta;
>  ///
>  /// const HW_READY: u16 =3D 0x01;
>  ///
> -/// fn wait_for_hardware<const SIZE: usize>(io: &Io<SIZE>) -> Result {
> +/// fn wait_for_hardware<const SIZE: usize>(io: &Mmio<SIZE>) -> Result {
>  ///     read_poll_timeout(
>  ///         // The `op` closure reads the value of a specific status reg=
ister.
>  ///         || io.try_read16(0x1000),
> @@ -128,12 +128,12 @@ pub fn read_poll_timeout<Op, Cond, T>(
>  /// # Examples
>  ///
>  /// ```no_run
> -/// use kernel::io::{poll::read_poll_timeout_atomic, Io};
> +/// use kernel::io::{poll::read_poll_timeout_atomic, Io, Mmio};
>  /// use kernel::time::Delta;
>  ///
>  /// const HW_READY: u16 =3D 0x01;
>  ///
> -/// fn wait_for_hardware<const SIZE: usize>(io: &Io<SIZE>) -> Result {
> +/// fn wait_for_hardware<const SIZE: usize>(io: &Mmio<SIZE>) -> Result {
>  ///     read_poll_timeout_atomic(
>  ///         // The `op` closure reads the value of a specific status reg=
ister.
>  ///         || io.try_read16(0x1000),

