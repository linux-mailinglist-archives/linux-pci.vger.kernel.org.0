Return-Path: <linux-pci+bounces-15098-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1959ABF9C
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 09:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 482962823F5
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 07:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1293E14B94B;
	Wed, 23 Oct 2024 06:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bgZs9p1n"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88DF14B06A;
	Wed, 23 Oct 2024 06:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729666797; cv=none; b=q2OwotChTTDZSXpCaXj9BjQHConPOuppwM087pmr7oYC+v3GJl3cvEgsd2mkVL7aaXKRAHiyX/DB6ZovoG7B/rcKX8O4byKvpO+53iW3jX2o+iwFQExWN50w5zI/ypb2NR9xMQ5Gsrdl+4wJEBDM3a9Z/3nsV4wo3UL9OXlW14g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729666797; c=relaxed/simple;
	bh=2YwrmN1vOX3AU19WvgKYIM5K+VsFgsOaRdurY0BNOuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S162dBB/VKyFBZVYEDlOUPMiNsE+AyeWlAWk/uWHlV1XEocGl7r7iK5PRhlht6eIqqSpaLT6WZsEXB2GmETQ9afss99RbcD/BaE61uTxbqjLMuTABoC/WgiYUjm5BH41oCHQfzot2M0jkVmTmGb92uPAd3PJ9Bggze9zrvU4trY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bgZs9p1n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6EC4C4CEC6;
	Wed, 23 Oct 2024 06:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729666796;
	bh=2YwrmN1vOX3AU19WvgKYIM5K+VsFgsOaRdurY0BNOuM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bgZs9p1n4ctArYgqV537sGCnZ2Jdw3HtHIwhL0pGmfjf515BHdTN3eZIeABhSlG0y
	 RekHxuXwy91VdRm9jC7OVdeYfkjgrXkGsKoRj7NjYKAJ4WrT9anzpASgd5ub8SXtei
	 gn0VUdu3YKgCyfONx4u2yIVz6BIXl6SaA1XsR4qBAv1y3AW03yLBg8Rb/uDD1wrnUn
	 QBsiQ67TR/Jzs/OWr+TXme1EWcBHTBxyKQOYu7W+f6f/NJodUBBUuTsjWkuKv3AWSK
	 czIB2+vtIMSN8R0JzLeuMZCzJ5TPBPv1tjUiiHkHTyCHDhYWHxX2B+W1DUuAyGd/OD
	 Ap8oTxlJdBkpA==
Date: Wed, 23 Oct 2024 08:59:48 +0200
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
Subject: Re: [PATCH v3 16/16] samples: rust: add Rust platform sample driver
Message-ID: <Zxie5Lu2z_Xc_RXM@pollux>
References: <20241022213221.2383-1-dakr@kernel.org>
 <20241022213221.2383-17-dakr@kernel.org>
 <20241023000408.GC1848992-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023000408.GC1848992-robh@kernel.org>

On Tue, Oct 22, 2024 at 07:04:08PM -0500, Rob Herring wrote:
> On Tue, Oct 22, 2024 at 11:31:53PM +0200, Danilo Krummrich wrote:
> > Add a sample Rust platform driver illustrating the usage of the platform
> > bus abstractions.
> > 
> > This driver probes through either a match of device / driver name or a
> > match within the OF ID table.
> 
> I know if rust compiles it works, but how does one actually use/test 
> this? (I know ways, but I might be in the minority. :) )

For testing a name match I just used platform_device_register_simple() in a
separate module.

Probing through the OF table is indeed a bit more tricky. Since I was too lazy
to pull out a random ARM device of my cupboard I just used QEMU on x86 and did
what drivers/of/unittest.c does. If you're smart you can also just enable those
unit tests and change the compatible string to "unittest". :)

> 
> The DT unittests already define test platform devices. I'd be happy to 
> add a device node there. Then you don't have to muck with the DT on some 
> device and it even works on x86 or UML.

Sounds good, I'll add one in there for this sample driver -- any preferences?

> 
> And I've started working on DT (fwnode really) property API bindings as 
> well, and this will be great to test them with.
> 
> > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> > ---
> >  MAINTAINERS                          |  1 +
> >  samples/rust/Kconfig                 | 10 +++++
> >  samples/rust/Makefile                |  1 +
> >  samples/rust/rust_driver_platform.rs | 62 ++++++++++++++++++++++++++++
> >  4 files changed, 74 insertions(+)
> >  create mode 100644 samples/rust/rust_driver_platform.rs
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 173540375863..583b6588fd1e 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -6986,6 +6986,7 @@ F:	rust/kernel/device_id.rs
> >  F:	rust/kernel/devres.rs
> >  F:	rust/kernel/driver.rs
> >  F:	rust/kernel/platform.rs
> > +F:	samples/rust/rust_driver_platform.rs
> >  
> >  DRIVERS FOR OMAP ADAPTIVE VOLTAGE SCALING (AVS)
> >  M:	Nishanth Menon <nm@ti.com>
> > diff --git a/samples/rust/Kconfig b/samples/rust/Kconfig
> > index 6d468193cdd8..70126b750426 100644
> > --- a/samples/rust/Kconfig
> > +++ b/samples/rust/Kconfig
> > @@ -41,6 +41,16 @@ config SAMPLE_RUST_DRIVER_PCI
> >  
> >  	  If unsure, say N.
> >  
> > +config SAMPLE_RUST_DRIVER_PLATFORM
> > +	tristate "Platform Driver"
> > +	help
> > +	  This option builds the Rust Platform driver sample.
> > +
> > +	  To compile this as a module, choose M here:
> > +	  the module will be called rust_driver_platform.
> > +
> > +	  If unsure, say N.
> > +
> >  config SAMPLE_RUST_HOSTPROGS
> >  	bool "Host programs"
> >  	help
> > diff --git a/samples/rust/Makefile b/samples/rust/Makefile
> > index b66767f4a62a..11fcb312ed36 100644
> > --- a/samples/rust/Makefile
> > +++ b/samples/rust/Makefile
> > @@ -3,5 +3,6 @@
> >  obj-$(CONFIG_SAMPLE_RUST_MINIMAL)		+= rust_minimal.o
> >  obj-$(CONFIG_SAMPLE_RUST_PRINT)			+= rust_print.o
> >  obj-$(CONFIG_SAMPLE_RUST_DRIVER_PCI)		+= rust_driver_pci.o
> > +obj-$(CONFIG_SAMPLE_RUST_DRIVER_PLATFORM)	+= rust_driver_platform.o
> >  
> >  subdir-$(CONFIG_SAMPLE_RUST_HOSTPROGS)		+= hostprogs
> > diff --git a/samples/rust/rust_driver_platform.rs b/samples/rust/rust_driver_platform.rs
> > new file mode 100644
> > index 000000000000..55caaaa4f216
> > --- /dev/null
> > +++ b/samples/rust/rust_driver_platform.rs
> > @@ -0,0 +1,62 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +//! Rust Platform driver sample.
> > +
> > +use kernel::{c_str, of, platform, prelude::*};
> > +
> > +struct SampleDriver {
> > +    pdev: platform::Device,
> > +}
> > +
> > +struct Info(u32);
> > +
> > +kernel::of_device_table!(
> > +    OF_TABLE,
> > +    MODULE_OF_TABLE,
> > +    <SampleDriver as platform::Driver>::IdInfo,
> > +    [(
> > +        of::DeviceId::new(c_str!("redhat,rust-sample-platform-driver")),
> 
> Perhaps use the same compatible as the commented example. Same comments 
> on that apply to this.
> 
> > +        Info(42)
> 
> Most of the time this is a pointer to a struct. It would be better to 
> show how to do that.

No, this should never be a raw pointer. There is no reason for a driver to
perfom this kind of unsafe operation to store any ID info data. This ID info
data is moved into the `IdArray` on compile time. And the bus abstraction takes
care of providing a reference to this structure in `Driver::probe`.

So, technically, this example is fine. But if you have ideas for more meaningful
data to store there, I happy to change it.

> 
> > +    )]
> > +);
> > +
> > +impl platform::Driver for SampleDriver {
> > +    type IdInfo = Info;
> > +    const ID_TABLE: platform::IdTable<Self::IdInfo> = &OF_TABLE;
> 
> Probably want to name this OF_ID_TABLE for when ACPI_ID_TABLE is added.

Yes, makes sense.

> 
> > +
> > +    fn probe(pdev: &mut platform::Device, info: Option<&Self::IdInfo>) -> Result<Pin<KBox<Self>>> {
> > +        dev_dbg!(pdev.as_ref(), "Probe Rust Platform driver sample.\n");
> > +
> > +        match (Self::of_match_device(pdev), info) {
> 
> That answers my question on being exposed to drivers. This is a big no 
> for me.

Agreed, we don't need it. Please also see my previous reply in the platform bus
abstraction.

> 
> > +            (Some(id), Some(info)) => {
> > +                dev_info!(
> > +                    pdev.as_ref(),
> > +                    "Probed by OF compatible match: '{}' with info: '{}'.\n",
> > +                    id.compatible(),
> 
> As I mentioned, "real" drivers don't need the compatible string.

Same here.

> 
> > +                    info.0
> > +                );
> > +            }
> > +            _ => {
> > +                dev_info!(pdev.as_ref(), "Probed by name.\n");
> > +            }
> > +        };
> > +
> > +        let drvdata = KBox::new(Self { pdev: pdev.clone() }, GFP_KERNEL)?;
> > +
> > +        Ok(drvdata.into())
> > +    }
> > +}
> > +
> > +impl Drop for SampleDriver {
> > +    fn drop(&mut self) {
> > +        dev_dbg!(self.pdev.as_ref(), "Remove Rust Platform driver sample.\n");
> > +    }
> > +}
> > +
> > +kernel::module_platform_driver! {
> > +    type: SampleDriver,
> > +    name: "rust_driver_platform",
> > +    author: "Danilo Krummrich",
> > +    description: "Rust Platform driver",
> > +    license: "GPL v2",
> > +}
> > -- 
> > 2.46.2
> > 
> 

