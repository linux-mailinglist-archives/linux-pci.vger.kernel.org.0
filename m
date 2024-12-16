Return-Path: <linux-pci+bounces-18525-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2DD9F3631
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 17:36:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 083561885DDB
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 16:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA21204C3C;
	Mon, 16 Dec 2024 16:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AK/A71FI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8574E18E20;
	Mon, 16 Dec 2024 16:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734366712; cv=none; b=Dp0SyZJMhQDGtNOCnYEe2SraSjywJdRruGlv9WIP/hSzDKCXFtNxbjTcKYXZYW1JyL9CjuvDMVt7n1xmjbnwf2Ibuw3Iuu21EKF6dvefVXiQ5Lf5pv5yKEHSRJGOiribbqGCcvwL7b0AaeRIuS20NTpr2TQmh39g//RtFZwruz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734366712; c=relaxed/simple;
	bh=XuEu2yKRBnN7di01QWuD5/XFrrX9h+SK+cN2RLJvjJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cOxKbDOlmaGzt/XgG6HectO13Rz6np0JwqgaVPuVTF6pxcleC5i15JLL/yTptwko67uUO/DjFwv9J3NEAkMPr7dmL7lM/MB8oHZf2pqGG09mhCrXj5c5X0uEeQJCThc//p1Jzw8GuSXV73NsJWy1vVLz68+/KkD1VymQNVrR+7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AK/A71FI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 202D0C4CEDD;
	Mon, 16 Dec 2024 16:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734366712;
	bh=XuEu2yKRBnN7di01QWuD5/XFrrX9h+SK+cN2RLJvjJ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AK/A71FI4T6JapaKWA3M8LWSwGXh1Jkkuwi0a0nE6HXTxBudENHWqZ7ioeHA//KNg
	 KY8WSUwLH0OHUiOoxb1iSnQlKFZRmaZ6tVWv2TjmM4HrTOcH3kIR1AiJjQXrTkrZZK
	 V2PxAS4Zzsw2sLEtz6MUOg9T4msDn6Zr91DTNuYcrECPlUZzHRyzauwJAKsIEf8dBu
	 ixFs9PSG5OrgD2aMTvbSY9pBKAtHLI6BkyoqVaAe7jnZtmFuJ3LXbf4P+gcJUa3G2a
	 nim5RfdY4Lnx/cWaAGIBOnRhfGQLMxMeMi2ZFsdUPZEvSF3KKPCkJVUOgUplThC2N0
	 hIoratayX7J9w==
Date: Mon, 16 Dec 2024 17:31:43 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
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
Message-ID: <Z2BV72LDOFvS2p8h@pollux.localdomain>
References: <20241212163357.35934-1-dakr@kernel.org>
 <20241212163357.35934-16-dakr@kernel.org>
 <2024121550-palpitate-exhume-348c@gregkh>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024121550-palpitate-exhume-348c@gregkh>

On Sun, Dec 15, 2024 at 01:25:45PM +0100, Greg KH wrote:
> On Thu, Dec 12, 2024 at 05:33:46PM +0100, Danilo Krummrich wrote:
> > Add a sample Rust platform driver illustrating the usage of the platform
> > bus abstractions.
> > 
> > This driver probes through either a match of device / driver name or a
> > match within the OF ID table.
> > 
> > Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> > ---
> >  MAINTAINERS                                  |  1 +
> >  drivers/of/unittest-data/tests-platform.dtsi |  5 ++
> >  samples/rust/Kconfig                         | 10 ++++
> >  samples/rust/Makefile                        |  1 +
> >  samples/rust/rust_driver_platform.rs         | 49 ++++++++++++++++++++
> >  5 files changed, 66 insertions(+)
> >  create mode 100644 samples/rust/rust_driver_platform.rs
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index fec876068c40..95bd7dc88ad8 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -7037,6 +7037,7 @@ F:	rust/kernel/device_id.rs
> >  F:	rust/kernel/devres.rs
> >  F:	rust/kernel/driver.rs
> >  F:	rust/kernel/platform.rs
> > +F:	samples/rust/rust_driver_platform.rs
> >  
> >  DRIVERS FOR OMAP ADAPTIVE VOLTAGE SCALING (AVS)
> >  M:	Nishanth Menon <nm@ti.com>
> > diff --git a/drivers/of/unittest-data/tests-platform.dtsi b/drivers/of/unittest-data/tests-platform.dtsi
> > index fa39611071b3..2caaf1c10ee6 100644
> > --- a/drivers/of/unittest-data/tests-platform.dtsi
> > +++ b/drivers/of/unittest-data/tests-platform.dtsi
> > @@ -33,6 +33,11 @@ dev@100 {
> >  					reg = <0x100>;
> >  				};
> >  			};
> > +
> > +			test-device@2 {
> > +				compatible = "test,rust-device";
> > +				reg = <0x2>;
> > +			};
> >  		};
> >  	};
> >  };
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
> > index 2f5b6bdb2fa5..761d13fff018 100644
> > --- a/samples/rust/Makefile
> > +++ b/samples/rust/Makefile
> > @@ -4,6 +4,7 @@ ccflags-y += -I$(src)				# needed for trace events
> >  obj-$(CONFIG_SAMPLE_RUST_MINIMAL)		+= rust_minimal.o
> >  obj-$(CONFIG_SAMPLE_RUST_PRINT)			+= rust_print.o
> >  obj-$(CONFIG_SAMPLE_RUST_DRIVER_PCI)		+= rust_driver_pci.o
> > +obj-$(CONFIG_SAMPLE_RUST_DRIVER_PLATFORM)	+= rust_driver_platform.o
> >  
> >  rust_print-y := rust_print_main.o rust_print_events.o
> >  
> > diff --git a/samples/rust/rust_driver_platform.rs b/samples/rust/rust_driver_platform.rs
> > new file mode 100644
> > index 000000000000..8120609e2940
> > --- /dev/null
> > +++ b/samples/rust/rust_driver_platform.rs
> > @@ -0,0 +1,49 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +//! Rust Platform driver sample.
> 
> Nit, I think your employer will want a copyright line on these, but hey,
> I could be wrong!  Your call...
> 
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
> > +    [(of::DeviceId::new(c_str!("test,rust-device")), Info(42))]
> > +);
> > +
> > +impl platform::Driver for SampleDriver {
> > +    type IdInfo = Info;
> > +    const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = Some(&OF_TABLE);
> > +
> > +    fn probe(pdev: &mut platform::Device, info: Option<&Self::IdInfo>) -> Result<Pin<KBox<Self>>> {
> > +        dev_dbg!(pdev.as_ref(), "Probe Rust Platform driver sample.\n");
> > +
> > +        if let Some(info) = info {
> > +            dev_info!(pdev.as_ref(), "Probed with info: '{}'.\n", info.0);
> > +        }
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
> 
> That is almost too simple.  Seriously nice work, let's wait a few days
> for some others to review the series and I'll be glad to apply it to my
> tree!

Thanks! If nothing else comes up, I'll send you a v7 end of this week addressing
the two minor things I just replied to (remove wrong return statement in
iounmap() helper, `pci::DeviceId` naming and `Deref` impl).

- Danilo

> 
> greg k-h

