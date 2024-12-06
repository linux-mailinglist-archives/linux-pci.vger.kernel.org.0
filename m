Return-Path: <linux-pci+bounces-17829-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C92299E68F7
	for <lists+linux-pci@lfdr.de>; Fri,  6 Dec 2024 09:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9849818862D5
	for <lists+linux-pci@lfdr.de>; Fri,  6 Dec 2024 08:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20CBD1D9A48;
	Fri,  6 Dec 2024 08:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JybcPVst"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CBF13C816;
	Fri,  6 Dec 2024 08:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733474018; cv=none; b=m1TMDiEeP6zPVobkXVa8EjfDmmpfI/4pETKvuJ5R2eAMJyoCBovHU/or1ioaefTFvA/zF/zLyb0qpfjUmgvS5N3fGZcc/c610sShC9uHwVCnKjm+zhAUQQL+1N3tI+Z+MQLE2vo2pz7fC6Sbviv1OjXlvnbeGV9cPx5efAoQ9cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733474018; c=relaxed/simple;
	bh=Jj1aQjvKJiwl1l+9B0eUXboN5nIcWwPvvJJmz4xtzaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y1TF0snTx3Ph7K0XZl/TsKDtJHTbAm4B7pC5Zw+iB6/LAUsRnK9qJN7XOgZjAZeGtMlNhpTFq+GpuBiR8VunuianDiAbsfL0RZiILWXVKte8GxsVME2WePzlgCrhO3QmhvdYpterZhM6UNfp4qT58WSG4AmbzMPwHDnAni3O1Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JybcPVst; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A43B4C4CED1;
	Fri,  6 Dec 2024 08:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733474017;
	bh=Jj1aQjvKJiwl1l+9B0eUXboN5nIcWwPvvJJmz4xtzaY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JybcPVsteSqzpfvd6fvQFU4D2ThCjLN86Vtgk55RngInHaIayTYOFRCJcZLiNd5gd
	 ByHII6X1M/x7Ymh+Fnl8l2Ist6j5TVgiuW36dU/s9EDl1F6EnEBou34Vmn5K7nUyBW
	 Lnu9sNY6qKHp99H0xG95iVNAgJilEwAIm5jNQJ3rdaXzGQu12TUEN6sgL2omA7oMj3
	 kWFgoQ9UxSlAfJxUQ9GOh/Em1mPT3ec71c2OviERk6jo94ZVW2U0XsiqsH5HGYwvt1
	 93SK7U5XZ1ya3jz6iqdfNa60jaNmzeKTcIxsI38YoF/VfwRr5y8n2GWwHYsQSwfrIX
	 JBSQPtjLI22wA==
Date: Fri, 6 Dec 2024 09:33:28 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Dirk Behme <dirk.behme@gmail.com>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com,
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	tmgross@umich.edu, a.hindborg@samsung.com, aliceryhl@google.com,
	airlied@gmail.com, fujita.tomonori@gmail.com, lina@asahilina.net,
	pstanner@redhat.com, ajanulgu@redhat.com, lyude@redhat.com,
	robh@kernel.org, daniel.almeida@collabora.com, saravanak@google.com,
	dirk.behme@de.bosch.com, j@jannau.net, fabien.parent@linaro.org,
	chrisi.schrefl@gmail.com, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v4 13/13] samples: rust: add Rust platform sample driver
Message-ID: <Z1K22NjYjwhFnsit@pollux>
References: <20241205141533.111830-1-dakr@kernel.org>
 <20241205141533.111830-14-dakr@kernel.org>
 <e2c202c1-6bbe-4b6c-ae97-185fe2aed0e5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2c202c1-6bbe-4b6c-ae97-185fe2aed0e5@gmail.com>

On Thu, Dec 05, 2024 at 06:09:10PM +0100, Dirk Behme wrote:
> Hi Danilo,
> 
> On 05.12.24 15:14, Danilo Krummrich wrote:
> > Add a sample Rust platform driver illustrating the usage of the platform
> > bus abstractions.
> > 
> > This driver probes through either a match of device / driver name or a
> > match within the OF ID table.
> > 
> > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> 
> Not a review comment, but a question/proposal:
> 
> What do you think to convert the platform sample into an example/test?
> And drop it in samples/rust then? Like [1] below?

Generally, I think doctests are indeed preferrable. In this particular case
though, I think it's better to have a sample module, since this way it can serve
as go-to example of how to write a platform driver in Rust.

Especially for (kernel) folks who do not have a Rust (for Linux) background it's
way more accessible.

> 
> We would have (a) a complete example in the documentation and (b) some
> (KUnit) test coverage and (c) have one patch less in the series and
> (d) one file less to maintain long term.
> 
> I think to remember that it was mentioned somewhere that a
> documentation example / KUnit test is preferred over samples/rust (?).
> 
> Just an idea :)
> 
> Best regards
> 
> Dirk
> 
> [1]
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ae576c842c51..365fc48b7041 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7035,7 +7035,6 @@ F:	rust/kernel/device_id.rs
>  F:	rust/kernel/devres.rs
>  F:	rust/kernel/driver.rs
>  F:	rust/kernel/platform.rs
> -F:	samples/rust/rust_driver_platform.rs
> 
>  DRIVERS FOR OMAP ADAPTIVE VOLTAGE SCALING (AVS)
>  M:	Nishanth Menon <nm@ti.com>
> diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
> index 868cfddb75a2..77aeb6fc2120 100644
> --- a/rust/kernel/platform.rs
> +++ b/rust/kernel/platform.rs
> @@ -142,30 +142,55 @@ macro_rules! module_platform_driver {
>  /// # Example
>  ///
>  ///```
> -/// # use kernel::{bindings, c_str, of, platform};
> +/// # mod mydriver {
> +/// #
> +/// # // Get this into the scope of the module to make the
> assert_eq!() buildable
> +/// # static __DOCTEST_ANCHOR: i32 = core::line!() as i32 - 4;
> +/// #
> +/// # use kernel::{c_str, of, platform, prelude::*};
> +/// #
> +/// struct MyDriver {
> +///     pdev: platform::Device,
> +/// }
>  ///
> -/// struct MyDriver;
> +/// struct Info(u32);
>  ///
>  /// kernel::of_device_table!(
>  ///     OF_TABLE,
>  ///     MODULE_OF_TABLE,
>  ///     <MyDriver as platform::Driver>::IdInfo,
> -///     [
> -///         (of::DeviceId::new(c_str!("test,device")), ())
> -///     ]
> +///     [(of::DeviceId::new(c_str!("test,rust-device")), Info(42))]
>  /// );
>  ///
>  /// impl platform::Driver for MyDriver {
> -///     type IdInfo = ();
> +///     type IdInfo = Info;
>  ///     const OF_ID_TABLE: platform::IdTable<Self::IdInfo> = &OF_TABLE;
>  ///
> -///     fn probe(
> -///         _pdev: &mut platform::Device,
> -///         _id_info: Option<&Self::IdInfo>,
> -///     ) -> Result<Pin<KBox<Self>>> {
> -///         Err(ENODEV)
> +///     fn probe(pdev: &mut platform::Device, info:
> Option<&Self::IdInfo>) -> Result<Pin<KBox<Self>>> {
> +///         dev_dbg!(pdev.as_ref(), "Probe Rust Platform driver
> sample.\n");
> +///
> +///         assert_eq!(info.unwrap().0, 42);
> +///
> +///         let drvdata = KBox::new(Self { pdev: pdev.clone() },
> GFP_KERNEL)?;
> +///
> +///         Ok(drvdata.into())
> +///     }
> +/// }
> +///
> +/// impl Drop for MyDriver {
> +///     fn drop(&mut self) {
> +///         dev_dbg!(self.pdev.as_ref(), "Remove Rust Platform driver
> sample.\n");
>  ///     }
>  /// }
> +///
> +/// kernel::module_platform_driver! {
> +///     type: MyDriver,
> +///     name: "rust_driver_platform",
> +///     author: "Danilo Krummrich",
> +///     description: "Rust Platform driver",
> +///     license: "GPL v2",
> +/// }
> +/// # }
>  ///```
>  pub trait Driver {
>      /// The type holding information about each device id supported
> by the driver.
> diff --git a/samples/rust/Kconfig b/samples/rust/Kconfig
> index 70126b750426..6d468193cdd8 100644
> --- a/samples/rust/Kconfig
> +++ b/samples/rust/Kconfig
> @@ -41,16 +41,6 @@ config SAMPLE_RUST_DRIVER_PCI
> 
>  	  If unsure, say N.
> 
> -config SAMPLE_RUST_DRIVER_PLATFORM
> -	tristate "Platform Driver"
> -	help
> -	  This option builds the Rust Platform driver sample.
> -
> -	  To compile this as a module, choose M here:
> -	  the module will be called rust_driver_platform.
> -
> -	  If unsure, say N.
> -
>  config SAMPLE_RUST_HOSTPROGS
>  	bool "Host programs"
>  	help
> diff --git a/samples/rust/Makefile b/samples/rust/Makefile
> index 761d13fff018..2f5b6bdb2fa5 100644
> --- a/samples/rust/Makefile
> +++ b/samples/rust/Makefile
> @@ -4,7 +4,6 @@ ccflags-y += -I$(src)				# needed for trace events
>  obj-$(CONFIG_SAMPLE_RUST_MINIMAL)		+= rust_minimal.o
>  obj-$(CONFIG_SAMPLE_RUST_PRINT)			+= rust_print.o
>  obj-$(CONFIG_SAMPLE_RUST_DRIVER_PCI)		+= rust_driver_pci.o
> -obj-$(CONFIG_SAMPLE_RUST_DRIVER_PLATFORM)	+= rust_driver_platform.o
> 
>  rust_print-y := rust_print_main.o rust_print_events.o
> 
> diff --git a/samples/rust/rust_driver_platform.rs
> b/samples/rust/rust_driver_platform.rs
> deleted file mode 100644
> index 2f0dbbe69e10..000000000000
> --- a/samples/rust/rust_driver_platform.rs
> +++ /dev/null
> @@ -1,49 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -
> -//! Rust Platform driver sample.
> -
> -use kernel::{c_str, of, platform, prelude::*};
> -
> -struct SampleDriver {
> -    pdev: platform::Device,
> -}
> -
> -struct Info(u32);
> -
> -kernel::of_device_table!(
> -    OF_TABLE,
> -    MODULE_OF_TABLE,
> -    <SampleDriver as platform::Driver>::IdInfo,
> -    [(of::DeviceId::new(c_str!("test,rust-device")), Info(42))]
> -);
> -
> -impl platform::Driver for SampleDriver {
> -    type IdInfo = Info;
> -    const OF_ID_TABLE: platform::IdTable<Self::IdInfo> = &OF_TABLE;
> -
> -    fn probe(pdev: &mut platform::Device, info:
> Option<&Self::IdInfo>) -> Result<Pin<KBox<Self>>> {
> -        dev_dbg!(pdev.as_ref(), "Probe Rust Platform driver sample.\n");
> -
> -        if let Some(info) = info {
> -            dev_info!(pdev.as_ref(), "Probed with info: '{}'.\n",
> info.0);
> -        }
> -
> -        let drvdata = KBox::new(Self { pdev: pdev.clone() },
> GFP_KERNEL)?;
> -
> -        Ok(drvdata.into())
> -    }
> -}
> -
> -impl Drop for SampleDriver {
> -    fn drop(&mut self) {
> -        dev_dbg!(self.pdev.as_ref(), "Remove Rust Platform driver
> sample.\n");
> -    }
> -}
> -
> -kernel::module_platform_driver! {
> -    type: SampleDriver,
> -    name: "rust_driver_platform",
> -    author: "Danilo Krummrich",
> -    description: "Rust Platform driver",
> -    license: "GPL v2",
> -}
> 

