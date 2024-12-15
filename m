Return-Path: <linux-pci+bounces-18458-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8079F23B1
	for <lists+linux-pci@lfdr.de>; Sun, 15 Dec 2024 13:25:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82D3218863A8
	for <lists+linux-pci@lfdr.de>; Sun, 15 Dec 2024 12:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3C017B50F;
	Sun, 15 Dec 2024 12:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LFCMzPLl"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7291D374FF;
	Sun, 15 Dec 2024 12:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734265549; cv=none; b=TS7uYObb248iYo/H6PNclwGTTcZPHElLFGTJr+bXjHsEkhzwt0MTzudOsA9uUTqDYf2+hYAsqv5jfJrSh7s3cvxuB7CKIldyIukCXhkxxYfBkbXPLy2pyPsw3VQMkG7eeORrb38Md1Zc+18/6pia7EBvIln77OtwlqEJmz/2XHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734265549; c=relaxed/simple;
	bh=KeOD3KNWOuUH038iG87RRDiwd2G8jPvxj6Ojj9isRjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HVl5nTavdaIffYuPc4aiH3yUWn6uCK5a6Bc2UVBhFwxn8C4UPnHcFgQDrpEX35QmFNlMXusXTDv7OjbrTUFpI3o5I+TLMRIMK0mUhz61MiwSD2fd9HLPIz0JxC0ovNMf7NFPGJxSr6vGb06Z7xjvcnGM98jyrrC00Zii5xruXY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LFCMzPLl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FBA2C4CECE;
	Sun, 15 Dec 2024 12:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734265549;
	bh=KeOD3KNWOuUH038iG87RRDiwd2G8jPvxj6Ojj9isRjo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LFCMzPLlSGq3cXbaKzaIADY7zM4/V0Yzq5KX/RJH0D059aW+paCYrO2dM0u+y7eSG
	 e1fOFxga6xYxIOD4TOH/IrCWV8/nw7cSm57I9AfMHl+R5gkHv0cmhBDgiDSmL3lEwQ
	 hoqgBDP2cVJ9tgPLfdByh578vSc2fS/77l54VkjM=
Date: Sun, 15 Dec 2024 13:25:45 +0100
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
Subject: Re: [PATCH v6 15/16] samples: rust: add Rust platform sample driver
Message-ID: <2024121550-palpitate-exhume-348c@gregkh>
References: <20241212163357.35934-1-dakr@kernel.org>
 <20241212163357.35934-16-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212163357.35934-16-dakr@kernel.org>

On Thu, Dec 12, 2024 at 05:33:46PM +0100, Danilo Krummrich wrote:
> Add a sample Rust platform driver illustrating the usage of the platform
> bus abstractions.
> 
> This driver probes through either a match of device / driver name or a
> match within the OF ID table.
> 
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  MAINTAINERS                                  |  1 +
>  drivers/of/unittest-data/tests-platform.dtsi |  5 ++
>  samples/rust/Kconfig                         | 10 ++++
>  samples/rust/Makefile                        |  1 +
>  samples/rust/rust_driver_platform.rs         | 49 ++++++++++++++++++++
>  5 files changed, 66 insertions(+)
>  create mode 100644 samples/rust/rust_driver_platform.rs
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fec876068c40..95bd7dc88ad8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7037,6 +7037,7 @@ F:	rust/kernel/device_id.rs
>  F:	rust/kernel/devres.rs
>  F:	rust/kernel/driver.rs
>  F:	rust/kernel/platform.rs
> +F:	samples/rust/rust_driver_platform.rs
>  
>  DRIVERS FOR OMAP ADAPTIVE VOLTAGE SCALING (AVS)
>  M:	Nishanth Menon <nm@ti.com>
> diff --git a/drivers/of/unittest-data/tests-platform.dtsi b/drivers/of/unittest-data/tests-platform.dtsi
> index fa39611071b3..2caaf1c10ee6 100644
> --- a/drivers/of/unittest-data/tests-platform.dtsi
> +++ b/drivers/of/unittest-data/tests-platform.dtsi
> @@ -33,6 +33,11 @@ dev@100 {
>  					reg = <0x100>;
>  				};
>  			};
> +
> +			test-device@2 {
> +				compatible = "test,rust-device";
> +				reg = <0x2>;
> +			};
>  		};
>  	};
>  };
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
> index 2f5b6bdb2fa5..761d13fff018 100644
> --- a/samples/rust/Makefile
> +++ b/samples/rust/Makefile
> @@ -4,6 +4,7 @@ ccflags-y += -I$(src)				# needed for trace events
>  obj-$(CONFIG_SAMPLE_RUST_MINIMAL)		+= rust_minimal.o
>  obj-$(CONFIG_SAMPLE_RUST_PRINT)			+= rust_print.o
>  obj-$(CONFIG_SAMPLE_RUST_DRIVER_PCI)		+= rust_driver_pci.o
> +obj-$(CONFIG_SAMPLE_RUST_DRIVER_PLATFORM)	+= rust_driver_platform.o
>  
>  rust_print-y := rust_print_main.o rust_print_events.o
>  
> diff --git a/samples/rust/rust_driver_platform.rs b/samples/rust/rust_driver_platform.rs
> new file mode 100644
> index 000000000000..8120609e2940
> --- /dev/null
> +++ b/samples/rust/rust_driver_platform.rs
> @@ -0,0 +1,49 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Rust Platform driver sample.

Nit, I think your employer will want a copyright line on these, but hey,
I could be wrong!  Your call...

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
> +    [(of::DeviceId::new(c_str!("test,rust-device")), Info(42))]
> +);
> +
> +impl platform::Driver for SampleDriver {
> +    type IdInfo = Info;
> +    const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = Some(&OF_TABLE);
> +
> +    fn probe(pdev: &mut platform::Device, info: Option<&Self::IdInfo>) -> Result<Pin<KBox<Self>>> {
> +        dev_dbg!(pdev.as_ref(), "Probe Rust Platform driver sample.\n");
> +
> +        if let Some(info) = info {
> +            dev_info!(pdev.as_ref(), "Probed with info: '{}'.\n", info.0);
> +        }
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

That is almost too simple.  Seriously nice work, let's wait a few days
for some others to review the series and I'll be glad to apply it to my
tree!

greg k-h

