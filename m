Return-Path: <linux-pci+bounces-15079-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 286F29ABA57
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 02:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 789D0B230A9
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 00:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E4E175B1;
	Wed, 23 Oct 2024 00:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jXK3ZBl3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26991798C;
	Wed, 23 Oct 2024 00:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729641849; cv=none; b=ncKQxFKshkBjcLimSf9d9/uM2ftjFmJsieEFXEcwk9grsu34KgPropBbhyOXbE7vyeeN5QA29n7z5mclncBBwfab1v/riUSYU0v728QDkgLYPO8cCn0lqwpaaFtb53Dv7SkmYVQMSwmtwRdJ+OYHajNp3ifKBno6+XT2hY9ik3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729641849; c=relaxed/simple;
	bh=lp+qOB2AsGXn3zORPru0TEAo87RI1MyOJb9mTrSMdWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RE3MiBJVfYSBzXzlNo/b3RUbERURrn9A+B+yeznddkb3Hst7azXcf7JTAGOGAEwqjc+K+FV1nWifKCGKpX0e49Yd88xYlFLER4FwU5yQVHnXmlVYzJnAtLhkR36lQRmlnZpBdjuhEgemkUrQAJy0WCx4kxR4FyHDQSRiVXPDNdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jXK3ZBl3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14756C4CEE7;
	Wed, 23 Oct 2024 00:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729641849;
	bh=lp+qOB2AsGXn3zORPru0TEAo87RI1MyOJb9mTrSMdWI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jXK3ZBl3KW9rfPcw7U0EoPj5+z8C2qWD5+sQxr2ptHDzUelYirfjUhbN6q5T9hLZd
	 2r+iV8vy6JlEGdPBZbwMFCCHljH4fSg9rBU/bcSxKEZvyVGBrnGAbMC58rLA5KGU/F
	 kN6zKxos2jfMzYb4zZDqSl1vh/RXLtKiFNMFp7hZ1/npSfNl/MSRq2iPQK3audE2Bi
	 GSsC0GLX7qsVCy0bRTqjuzw/fPP1RaBgKMaxGNcIEZknAkvNjOXRvL1r2CdQbdEm47
	 WJvzNER/IjE+Rr1NS8bGFCqcAKB3j3yEJ55gPNSw4IQkoA+suB2rwOG+yCNK69DAAg
	 O6K4qc5Ii+b2A==
Date: Tue, 22 Oct 2024 19:04:08 -0500
From: Rob Herring <robh@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com,
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	tmgross@umich.edu, a.hindborg@samsung.com, aliceryhl@google.com,
	airlied@gmail.com, fujita.tomonori@gmail.com, lina@asahilina.net,
	pstanner@redhat.com, ajanulgu@redhat.com, lyude@redhat.com,
	daniel.almeida@collabora.com, saravanak@google.com,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 16/16] samples: rust: add Rust platform sample driver
Message-ID: <20241023000408.GC1848992-robh@kernel.org>
References: <20241022213221.2383-1-dakr@kernel.org>
 <20241022213221.2383-17-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022213221.2383-17-dakr@kernel.org>

On Tue, Oct 22, 2024 at 11:31:53PM +0200, Danilo Krummrich wrote:
> Add a sample Rust platform driver illustrating the usage of the platform
> bus abstractions.
> 
> This driver probes through either a match of device / driver name or a
> match within the OF ID table.

I know if rust compiles it works, but how does one actually use/test 
this? (I know ways, but I might be in the minority. :) )

The DT unittests already define test platform devices. I'd be happy to 
add a device node there. Then you don't have to muck with the DT on some 
device and it even works on x86 or UML.

And I've started working on DT (fwnode really) property API bindings as 
well, and this will be great to test them with.

> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  MAINTAINERS                          |  1 +
>  samples/rust/Kconfig                 | 10 +++++
>  samples/rust/Makefile                |  1 +
>  samples/rust/rust_driver_platform.rs | 62 ++++++++++++++++++++++++++++
>  4 files changed, 74 insertions(+)
>  create mode 100644 samples/rust/rust_driver_platform.rs
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 173540375863..583b6588fd1e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6986,6 +6986,7 @@ F:	rust/kernel/device_id.rs
>  F:	rust/kernel/devres.rs
>  F:	rust/kernel/driver.rs
>  F:	rust/kernel/platform.rs
> +F:	samples/rust/rust_driver_platform.rs
>  
>  DRIVERS FOR OMAP ADAPTIVE VOLTAGE SCALING (AVS)
>  M:	Nishanth Menon <nm@ti.com>
> diff --git a/samples/rust/Kconfig b/samples/rust/Kconfig
> index 6d468193cdd8..70126b750426 100644
> --- a/samples/rust/Kconfig
> +++ b/samples/rust/Kconfig
> @@ -41,6 +41,16 @@ config SAMPLE_RUST_DRIVER_PCI
>  
>  	  If unsure, say N.
>  
> +config SAMPLE_RUST_DRIVER_PLATFORM
> +	tristate "Platform Driver"
> +	help
> +	  This option builds the Rust Platform driver sample.
> +
> +	  To compile this as a module, choose M here:
> +	  the module will be called rust_driver_platform.
> +
> +	  If unsure, say N.
> +
>  config SAMPLE_RUST_HOSTPROGS
>  	bool "Host programs"
>  	help
> diff --git a/samples/rust/Makefile b/samples/rust/Makefile
> index b66767f4a62a..11fcb312ed36 100644
> --- a/samples/rust/Makefile
> +++ b/samples/rust/Makefile
> @@ -3,5 +3,6 @@
>  obj-$(CONFIG_SAMPLE_RUST_MINIMAL)		+= rust_minimal.o
>  obj-$(CONFIG_SAMPLE_RUST_PRINT)			+= rust_print.o
>  obj-$(CONFIG_SAMPLE_RUST_DRIVER_PCI)		+= rust_driver_pci.o
> +obj-$(CONFIG_SAMPLE_RUST_DRIVER_PLATFORM)	+= rust_driver_platform.o
>  
>  subdir-$(CONFIG_SAMPLE_RUST_HOSTPROGS)		+= hostprogs
> diff --git a/samples/rust/rust_driver_platform.rs b/samples/rust/rust_driver_platform.rs
> new file mode 100644
> index 000000000000..55caaaa4f216
> --- /dev/null
> +++ b/samples/rust/rust_driver_platform.rs
> @@ -0,0 +1,62 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Rust Platform driver sample.
> +
> +use kernel::{c_str, of, platform, prelude::*};
> +
> +struct SampleDriver {
> +    pdev: platform::Device,
> +}
> +
> +struct Info(u32);
> +
> +kernel::of_device_table!(
> +    OF_TABLE,
> +    MODULE_OF_TABLE,
> +    <SampleDriver as platform::Driver>::IdInfo,
> +    [(
> +        of::DeviceId::new(c_str!("redhat,rust-sample-platform-driver")),

Perhaps use the same compatible as the commented example. Same comments 
on that apply to this.

> +        Info(42)

Most of the time this is a pointer to a struct. It would be better to 
show how to do that.

> +    )]
> +);
> +
> +impl platform::Driver for SampleDriver {
> +    type IdInfo = Info;
> +    const ID_TABLE: platform::IdTable<Self::IdInfo> = &OF_TABLE;

Probably want to name this OF_ID_TABLE for when ACPI_ID_TABLE is added.

> +
> +    fn probe(pdev: &mut platform::Device, info: Option<&Self::IdInfo>) -> Result<Pin<KBox<Self>>> {
> +        dev_dbg!(pdev.as_ref(), "Probe Rust Platform driver sample.\n");
> +
> +        match (Self::of_match_device(pdev), info) {

That answers my question on being exposed to drivers. This is a big no 
for me.

> +            (Some(id), Some(info)) => {
> +                dev_info!(
> +                    pdev.as_ref(),
> +                    "Probed by OF compatible match: '{}' with info: '{}'.\n",
> +                    id.compatible(),

As I mentioned, "real" drivers don't need the compatible string.

> +                    info.0
> +                );
> +            }
> +            _ => {
> +                dev_info!(pdev.as_ref(), "Probed by name.\n");
> +            }
> +        };
> +
> +        let drvdata = KBox::new(Self { pdev: pdev.clone() }, GFP_KERNEL)?;
> +
> +        Ok(drvdata.into())
> +    }
> +}
> +
> +impl Drop for SampleDriver {
> +    fn drop(&mut self) {
> +        dev_dbg!(self.pdev.as_ref(), "Remove Rust Platform driver sample.\n");
> +    }
> +}
> +
> +kernel::module_platform_driver! {
> +    type: SampleDriver,
> +    name: "rust_driver_platform",
> +    author: "Danilo Krummrich",
> +    description: "Rust Platform driver",
> +    license: "GPL v2",
> +}
> -- 
> 2.46.2
> 

