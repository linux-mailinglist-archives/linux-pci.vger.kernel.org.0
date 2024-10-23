Return-Path: <linux-pci+bounces-15126-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DFD59ACFAD
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 18:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90629B220E3
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 15:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF201C304B;
	Wed, 23 Oct 2024 15:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BvbTBSe+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE90136E21;
	Wed, 23 Oct 2024 15:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729699059; cv=none; b=paPq2i674shJN7LM2M2Kr5a/v8/Dh/5vkfHfEOd+rrN2lFqjljdJhnBT61f/tD2MmBDfu5/N/PX4QGaIjbQbU8rIDckP2Q75dgz6j8Et238wyO/X0cp48AtyJGb5bPB+CbJiDdRrUpnLF+VkzrzVUKDIpCPhyzMu8/6vC4mZyxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729699059; c=relaxed/simple;
	bh=B78ryvKF67MiZdQxaBwJo78TUToM4c88TbX4KJ39PiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KDKpYluB5Ec/4YQRMmovH8GcyeFn9h6wEX9XAeSGdV/Qq7pjSYIvNUvgX2LLl6iuWHc/1vIh1kEEU59yl5NncdaBGV0656WNVKAru6l8hhOf+lfq9YRVDremKQTKuVS7Nn+P5UgqwPU6gmJC/gkAeozQGuCNZtOXwk0iBawhKC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BvbTBSe+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA0E8C4CEC6;
	Wed, 23 Oct 2024 15:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729699058;
	bh=B78ryvKF67MiZdQxaBwJo78TUToM4c88TbX4KJ39PiQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BvbTBSe+cBz60GH+b2U9iOa1nt5ktU1nEDrvXTRpBsc+xWsStGex2BnPY7cw8ZXwG
	 dyYV2CNAoJaBFJ8L0HQduJCb1bFYU7N1moDd3Hw0iVUjcQR0JMC8HUJTwgPP5jTk21
	 kFvhS6yr/0maF3qENtDA6vVr7DqZPO8sP2Y3nGQcVvR/MJv7UfCJlFI34GJDgCQrgk
	 z5/bbEWd+R4uioZn7+VZV5YgFy+8eVHsv2RNMyBpMMGYkneWx/v4tUUEmgl/xsnzAg
	 OTcxMs/oa9bZYcMr/UzxW25nXnQL8wj0xBLadtcV5Xg2eCO0w73mzJRRI4JgvNc38T
	 HCE0mf53pUfhA==
Date: Wed, 23 Oct 2024 10:57:37 -0500
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
Subject: Re: [PATCH v3 13/16] samples: rust: add Rust PCI sample driver
Message-ID: <20241023155737.GB1064929-robh@kernel.org>
References: <20241022213221.2383-1-dakr@kernel.org>
 <20241022213221.2383-14-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022213221.2383-14-dakr@kernel.org>

On Tue, Oct 22, 2024 at 11:31:50PM +0200, Danilo Krummrich wrote:
> This commit adds a sample Rust PCI driver for QEMU's "pci-testdev"
> device. To enable this device QEMU has to be called with
> `-device pci-testdev`.

Note that the DT unittests also use this device. So this means we have 2 
drivers that bind to the device. Probably it's okay, but does make 
them somewhat mutually-exclusive.
 
> The same driver shows how to use the PCI device / driver abstractions,
> as well as how to request and map PCI BARs, including a short sequence of
> MMIO operations.
> 
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  MAINTAINERS                     |   1 +
>  samples/rust/Kconfig            |  11 ++++
>  samples/rust/Makefile           |   1 +
>  samples/rust/rust_driver_pci.rs | 109 ++++++++++++++++++++++++++++++++
>  4 files changed, 122 insertions(+)
>  create mode 100644 samples/rust/rust_driver_pci.rs
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2d00d3845b4a..d9c512a3e72b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17940,6 +17940,7 @@ F:	include/linux/of_pci.h
>  F:	include/linux/pci*
>  F:	include/uapi/linux/pci*
>  F:	rust/kernel/pci.rs
> +F:	samples/rust/rust_driver_pci.rs
>  
>  PCIE DRIVER FOR AMAZON ANNAPURNA LABS
>  M:	Jonathan Chocron <jonnyc@amazon.com>
> diff --git a/samples/rust/Kconfig b/samples/rust/Kconfig
> index b0f74a81c8f9..6d468193cdd8 100644
> --- a/samples/rust/Kconfig
> +++ b/samples/rust/Kconfig
> @@ -30,6 +30,17 @@ config SAMPLE_RUST_PRINT
>  
>  	  If unsure, say N.
>  
> +config SAMPLE_RUST_DRIVER_PCI
> +	tristate "PCI Driver"
> +	depends on PCI
> +	help
> +	  This option builds the Rust PCI driver sample.
> +
> +	  To compile this as a module, choose M here:
> +	  the module will be called driver_pci.
> +
> +	  If unsure, say N.
> +
>  config SAMPLE_RUST_HOSTPROGS
>  	bool "Host programs"
>  	help
> diff --git a/samples/rust/Makefile b/samples/rust/Makefile
> index 03086dabbea4..b66767f4a62a 100644
> --- a/samples/rust/Makefile
> +++ b/samples/rust/Makefile
> @@ -2,5 +2,6 @@
>  
>  obj-$(CONFIG_SAMPLE_RUST_MINIMAL)		+= rust_minimal.o
>  obj-$(CONFIG_SAMPLE_RUST_PRINT)			+= rust_print.o
> +obj-$(CONFIG_SAMPLE_RUST_DRIVER_PCI)		+= rust_driver_pci.o
>  
>  subdir-$(CONFIG_SAMPLE_RUST_HOSTPROGS)		+= hostprogs
> diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_pci.rs
> new file mode 100644
> index 000000000000..d24dc1fde9e8
> --- /dev/null
> +++ b/samples/rust/rust_driver_pci.rs
> @@ -0,0 +1,109 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Rust PCI driver sample (based on QEMU's `pci-testdev`).
> +//!
> +//! To make this driver probe, QEMU must be run with `-device pci-testdev`.
> +
> +use kernel::{bindings, c_str, devres::Devres, pci, prelude::*};
> +
> +struct Regs;
> +
> +impl Regs {
> +    const TEST: usize = 0x0;
> +    const OFFSET: usize = 0x4;
> +    const DATA: usize = 0x8;
> +    const COUNT: usize = 0xC;
> +    const END: usize = 0x10;
> +}
> +
> +type Bar0 = pci::Bar<{ Regs::END }>;
> +
> +#[derive(Debug)]
> +struct TestIndex(u8);
> +
> +impl TestIndex {
> +    const NO_EVENTFD: Self = Self(0);
> +}
> +
> +struct SampleDriver {
> +    pdev: pci::Device,
> +    bar: Devres<Bar0>,
> +}
> +
> +kernel::pci_device_table!(
> +    PCI_TABLE,
> +    MODULE_PCI_TABLE,
> +    <SampleDriver as pci::Driver>::IdInfo,
> +    [(
> +        pci::DeviceId::new(bindings::PCI_VENDOR_ID_REDHAT, 0x5),
> +        TestIndex::NO_EVENTFD
> +    )]
> +);
> +
> +impl SampleDriver {
> +    fn testdev(index: &TestIndex, bar: &Bar0) -> Result<u32> {
> +        // Select the test.
> +        bar.writeb(index.0, Regs::TEST);
> +
> +        let offset = u32::from_le(bar.readl(Regs::OFFSET)) as usize;

The C version of readl takes care of from_le for you. Why not here?

Also, can't we do better with rust and make this a generic:

let offset = bar.read::<u32>(Regs::OFFSET)) as usize;


> +        let data = bar.readb(Regs::DATA);
> +
> +        // Write `data` to `offset` to increase `count` by one.
> +        //
> +        // Note that we need `try_writeb`, since `offset` can't be checked at compile-time.
> +        bar.try_writeb(data, offset)?;
> +
> +        Ok(u32::from_le(bar.readl(Regs::COUNT)))
> +    }
> +}

