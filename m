Return-Path: <linux-pci+bounces-15445-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A349B3197
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2024 14:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A05171F2267A
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2024 13:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F3B1DAC8C;
	Mon, 28 Oct 2024 13:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PudSzRtk"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F8538396;
	Mon, 28 Oct 2024 13:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730121784; cv=none; b=QHpNzAjF+L/ZxrA1jUNi+hIG3HwOOe0vVKDyhnt9D/IaeazejB1HYlG73HlXS61i7aKFP8GgmwoTc8Dhuca60nfyJsuzsroCh+7G9Vo3iGU8lnLdwNfWDKFC3BkR+0W5ECccnMKeAJBoYAYOnTtWsw622INXeDSXvO04VxAZ/ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730121784; c=relaxed/simple;
	bh=9tECmQTWRmCrctZx1DA72M0oCUbizMBPA+xl+7zZJYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a7iPZFw1JBZbxyzidJOQjssUfxgBGmWu8TtTx2jjbFxJ0+q39wjHLfUwTzVb4gr9mvtS73KccDfZJ6YLKb3+eXMxGl2GU1qNXuH8GX8znxtMshl4kqi+CYdhi3PD3XmzOVIbMcRS8eE9BPXHRk7G7XmUM7tv22taRnwBxqq4mVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PudSzRtk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED931C4CEC3;
	Mon, 28 Oct 2024 13:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730121783;
	bh=9tECmQTWRmCrctZx1DA72M0oCUbizMBPA+xl+7zZJYo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PudSzRtksSiVNKwGVRWY+Dv/cjY6o52UJ0NnBF7zVDLApZAd+3k1U+8KEOalpOQSz
	 POD/7Kbnv5zzk76wsCPMIf0GzShT7MPuShwXhOmvrxsYnXj/H/8UMUCSnH8fHWrJz8
	 fqBbtiavtPcg2WMEWraY9Vozjtw5ejFDYzr62CACQtyvybrbMMo28MQtnYVd4S7Vu/
	 gFF4y9CUyjwEyQXnBnNs+gniZG0KiyXqY+D55Gcivzne0KfVo0RRDyw8lWaxqlrPJV
	 UTO4rZjPzhelBMLEhjQBnbfbQPc0JrbawU9rmefiYtL8ehhGebUyH4kPGwkxWcpUA+
	 JQiK+GV53c/3g==
Date: Mon, 28 Oct 2024 14:22:56 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com,
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	tmgross@umich.edu, a.hindborg@samsung.com, aliceryhl@google.com,
	airlied@gmail.com, fujita.tomonori@gmail.com, lina@asahilina.net,
	pstanner@redhat.com, ajanulgu@redhat.com, lyude@redhat.com,
	daniel.almeida@collabora.com, saravanak@google.com,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 13/16] samples: rust: add Rust PCI sample driver
Message-ID: <Zx-QMBHtWSFkLiKm@pollux>
References: <20241022213221.2383-1-dakr@kernel.org>
 <20241022213221.2383-14-dakr@kernel.org>
 <20241023155737.GB1064929-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023155737.GB1064929-robh@kernel.org>

On Wed, Oct 23, 2024 at 10:57:37AM -0500, Rob Herring wrote:
> On Tue, Oct 22, 2024 at 11:31:50PM +0200, Danilo Krummrich wrote:
> > This commit adds a sample Rust PCI driver for QEMU's "pci-testdev"
> > device. To enable this device QEMU has to be called with
> > `-device pci-testdev`.
> 
> Note that the DT unittests also use this device. So this means we have 2 
> drivers that bind to the device. Probably it's okay, but does make 
> them somewhat mutually-exclusive.
>  
> > The same driver shows how to use the PCI device / driver abstractions,
> > as well as how to request and map PCI BARs, including a short sequence of
> > MMIO operations.
> > 
> > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> > ---
> >  MAINTAINERS                     |   1 +
> >  samples/rust/Kconfig            |  11 ++++
> >  samples/rust/Makefile           |   1 +
> >  samples/rust/rust_driver_pci.rs | 109 ++++++++++++++++++++++++++++++++
> >  4 files changed, 122 insertions(+)
> >  create mode 100644 samples/rust/rust_driver_pci.rs
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 2d00d3845b4a..d9c512a3e72b 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -17940,6 +17940,7 @@ F:	include/linux/of_pci.h
> >  F:	include/linux/pci*
> >  F:	include/uapi/linux/pci*
> >  F:	rust/kernel/pci.rs
> > +F:	samples/rust/rust_driver_pci.rs
> >  
> >  PCIE DRIVER FOR AMAZON ANNAPURNA LABS
> >  M:	Jonathan Chocron <jonnyc@amazon.com>
> > diff --git a/samples/rust/Kconfig b/samples/rust/Kconfig
> > index b0f74a81c8f9..6d468193cdd8 100644
> > --- a/samples/rust/Kconfig
> > +++ b/samples/rust/Kconfig
> > @@ -30,6 +30,17 @@ config SAMPLE_RUST_PRINT
> >  
> >  	  If unsure, say N.
> >  
> > +config SAMPLE_RUST_DRIVER_PCI
> > +	tristate "PCI Driver"
> > +	depends on PCI
> > +	help
> > +	  This option builds the Rust PCI driver sample.
> > +
> > +	  To compile this as a module, choose M here:
> > +	  the module will be called driver_pci.
> > +
> > +	  If unsure, say N.
> > +
> >  config SAMPLE_RUST_HOSTPROGS
> >  	bool "Host programs"
> >  	help
> > diff --git a/samples/rust/Makefile b/samples/rust/Makefile
> > index 03086dabbea4..b66767f4a62a 100644
> > --- a/samples/rust/Makefile
> > +++ b/samples/rust/Makefile
> > @@ -2,5 +2,6 @@
> >  
> >  obj-$(CONFIG_SAMPLE_RUST_MINIMAL)		+= rust_minimal.o
> >  obj-$(CONFIG_SAMPLE_RUST_PRINT)			+= rust_print.o
> > +obj-$(CONFIG_SAMPLE_RUST_DRIVER_PCI)		+= rust_driver_pci.o
> >  
> >  subdir-$(CONFIG_SAMPLE_RUST_HOSTPROGS)		+= hostprogs
> > diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_pci.rs
> > new file mode 100644
> > index 000000000000..d24dc1fde9e8
> > --- /dev/null
> > +++ b/samples/rust/rust_driver_pci.rs
> > @@ -0,0 +1,109 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +//! Rust PCI driver sample (based on QEMU's `pci-testdev`).
> > +//!
> > +//! To make this driver probe, QEMU must be run with `-device pci-testdev`.
> > +
> > +use kernel::{bindings, c_str, devres::Devres, pci, prelude::*};
> > +
> > +struct Regs;
> > +
> > +impl Regs {
> > +    const TEST: usize = 0x0;
> > +    const OFFSET: usize = 0x4;
> > +    const DATA: usize = 0x8;
> > +    const COUNT: usize = 0xC;
> > +    const END: usize = 0x10;
> > +}
> > +
> > +type Bar0 = pci::Bar<{ Regs::END }>;
> > +
> > +#[derive(Debug)]
> > +struct TestIndex(u8);
> > +
> > +impl TestIndex {
> > +    const NO_EVENTFD: Self = Self(0);
> > +}
> > +
> > +struct SampleDriver {
> > +    pdev: pci::Device,
> > +    bar: Devres<Bar0>,
> > +}
> > +
> > +kernel::pci_device_table!(
> > +    PCI_TABLE,
> > +    MODULE_PCI_TABLE,
> > +    <SampleDriver as pci::Driver>::IdInfo,
> > +    [(
> > +        pci::DeviceId::new(bindings::PCI_VENDOR_ID_REDHAT, 0x5),
> > +        TestIndex::NO_EVENTFD
> > +    )]
> > +);
> > +
> > +impl SampleDriver {
> > +    fn testdev(index: &TestIndex, bar: &Bar0) -> Result<u32> {
> > +        // Select the test.
> > +        bar.writeb(index.0, Regs::TEST);
> > +
> > +        let offset = u32::from_le(bar.readl(Regs::OFFSET)) as usize;
> 
> The C version of readl takes care of from_le for you. Why not here?

It's just an abstraction around the C readl(), so it does -- good catch.

> 
> Also, can't we do better with rust and make this a generic:
> 
> let offset = bar.read::<u32>(Regs::OFFSET)) as usize;

I think we probably could, but we'd still need to handle the special cases for 1
to 8 bytes type size (always using memcopy_{to,from}io() would lead to
unnecessary overhead). Hence, there's probably not much benefit in that.

Also, what would be the logic for a generic `{read, write}::<T>` in terms of
memory barriers? I think memcopy_{to,from}io() is always "relaxed", isn't it?

I think it's probably best to keep the two separate, the b,w,l,q variants and
a generic one that maps to memcopy_{to,from}io().

> 
> 
> > +        let data = bar.readb(Regs::DATA);
> > +
> > +        // Write `data` to `offset` to increase `count` by one.
> > +        //
> > +        // Note that we need `try_writeb`, since `offset` can't be checked at compile-time.
> > +        bar.try_writeb(data, offset)?;
> > +
> > +        Ok(u32::from_le(bar.readl(Regs::COUNT)))
> > +    }
> > +}
> 

