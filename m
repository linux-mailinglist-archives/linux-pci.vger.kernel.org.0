Return-Path: <linux-pci+bounces-17991-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB639EAA01
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 08:47:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBAC4188156F
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 07:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22ABA22B5B9;
	Tue, 10 Dec 2024 07:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UvDwKrsE"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45EC172BD5;
	Tue, 10 Dec 2024 07:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733816828; cv=none; b=HJVvtSQHaxgWicjY03aDKJ6QFAAbnHl5okS+pDoa03UtXYKN+aN7OWn6knsIO6qgw1K6zklZ2TPJ37rYZdERp4tGJ2hDteWjKrEn1l+6p51r5b97CZxveTQmpiKbpG4pfJoumwVui5p9VZxudKoR9x7Go6NWATUDL0MNXSgXwOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733816828; c=relaxed/simple;
	bh=F9fylD2jsc17wp8pFzXmIUwAs+7aQ7ODDoAVqLh4MZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KfATqOvQ152TArEvSMlCD3EBWYXFBCrMGt0vDGhTEsah0kuBhn+HnRhVtQ/4xSX5yF+2V2ggihVfnJmEg/FGCqoi8JVq64wNarAM+BQZ8wtvgvJJjEUpt5rpeAQbhXipMYGY8X9W+D3ICCVkosHyrUWxw+W5gRflWfY9Xbm3tE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UvDwKrsE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A94CDC4CED6;
	Tue, 10 Dec 2024 07:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733816826;
	bh=F9fylD2jsc17wp8pFzXmIUwAs+7aQ7ODDoAVqLh4MZk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UvDwKrsEcogxDYdCEiglfx4I8jpqVva5uswZixExaMCN6z8b9XAoXq7X+Rlk2YfK/
	 ESEMU0Bjq59A590tmXF2qEdEsHKeDO8unbNCHPNMfZSiz/DgXACn+PJNrnA6MBjGuv
	 mlyQawat4Vkovncjl8PvGrXjE/jSe3nRSXBPiSQ0=
Date: Tue, 10 Dec 2024 08:46:29 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Rob Herring <robh@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, rafael@kernel.org,
	bhelgaas@google.com, ojeda@kernel.org, alex.gaynor@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, tmgross@umich.edu, a.hindborg@samsung.com,
	aliceryhl@google.com, airlied@gmail.com, fujita.tomonori@gmail.com,
	lina@asahilina.net, pstanner@redhat.com, ajanulgu@redhat.com,
	lyude@redhat.com, daniel.almeida@collabora.com,
	saravanak@google.com, dirk.behme@de.bosch.com, j@jannau.net,
	fabien.parent@linaro.org, chrisi.schrefl@gmail.com,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 12/13] rust: platform: add basic platform device /
 driver abstractions
Message-ID: <2024121014-rage-sneak-1b25@gregkh>
References: <20241205141533.111830-1-dakr@kernel.org>
 <20241205141533.111830-13-dakr@kernel.org>
 <20241209223706.GF938291-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209223706.GF938291-robh@kernel.org>

On Mon, Dec 09, 2024 at 04:37:06PM -0600, Rob Herring wrote:
> On Thu, Dec 05, 2024 at 03:14:43PM +0100, Danilo Krummrich wrote:
> > Implement the basic platform bus abstractions required to write a basic
> > platform driver. This includes the following data structures:
> > 
> > The `platform::Driver` trait represents the interface to the driver and
> > provides `pci::Driver::probe` for the driver to implement.
> > 
> > The `platform::Device` abstraction represents a `struct platform_device`.
> > 
> > In order to provide the platform bus specific parts to a generic
> > `driver::Registration` the `driver::RegistrationOps` trait is implemented
> > by `platform::Adapter`.
> > 
> > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> > ---
> >  MAINTAINERS                     |   1 +
> >  rust/bindings/bindings_helper.h |   2 +
> >  rust/helpers/helpers.c          |   1 +
> >  rust/helpers/platform.c         |  13 ++
> >  rust/kernel/lib.rs              |   1 +
> >  rust/kernel/platform.rs         | 222 ++++++++++++++++++++++++++++++++
> >  6 files changed, 240 insertions(+)
> >  create mode 100644 rust/helpers/platform.c
> >  create mode 100644 rust/kernel/platform.rs
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 7d6bb4b15d2c..365fc48b7041 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -7034,6 +7034,7 @@ F:	rust/kernel/device.rs
> >  F:	rust/kernel/device_id.rs
> >  F:	rust/kernel/devres.rs
> >  F:	rust/kernel/driver.rs
> > +F:	rust/kernel/platform.rs
> >  
> >  DRIVERS FOR OMAP ADAPTIVE VOLTAGE SCALING (AVS)
> >  M:	Nishanth Menon <nm@ti.com>
> > diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
> > index 6d7a68e2ecb7..e9fdceb568b8 100644
> > --- a/rust/bindings/bindings_helper.h
> > +++ b/rust/bindings/bindings_helper.h
> > @@ -20,9 +20,11 @@
> >  #include <linux/jump_label.h>
> >  #include <linux/mdio.h>
> >  #include <linux/miscdevice.h>
> > +#include <linux/of_device.h>
> >  #include <linux/pci.h>
> >  #include <linux/phy.h>
> >  #include <linux/pid_namespace.h>
> > +#include <linux/platform_device.h>
> >  #include <linux/poll.h>
> >  #include <linux/refcount.h>
> >  #include <linux/sched.h>
> > diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
> > index 3fda33cd42d4..0640b7e115be 100644
> > --- a/rust/helpers/helpers.c
> > +++ b/rust/helpers/helpers.c
> > @@ -20,6 +20,7 @@
> >  #include "kunit.c"
> >  #include "mutex.c"
> >  #include "page.c"
> > +#include "platform.c"
> >  #include "pci.c"
> >  #include "pid_namespace.c"
> >  #include "rbtree.c"
> > diff --git a/rust/helpers/platform.c b/rust/helpers/platform.c
> > new file mode 100644
> > index 000000000000..ab9b9f317301
> > --- /dev/null
> > +++ b/rust/helpers/platform.c
> > @@ -0,0 +1,13 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#include <linux/platform_device.h>
> > +
> > +void *rust_helper_platform_get_drvdata(const struct platform_device *pdev)
> > +{
> > +	return platform_get_drvdata(pdev);
> > +}
> > +
> > +void rust_helper_platform_set_drvdata(struct platform_device *pdev, void *data)
> > +{
> > +	platform_set_drvdata(pdev, data);
> > +}
> > diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> > index 7a0e4c82ad0c..cc8f48aa162b 100644
> > --- a/rust/kernel/lib.rs
> > +++ b/rust/kernel/lib.rs
> > @@ -59,6 +59,7 @@
> >  pub mod of;
> >  pub mod page;
> >  pub mod pid_namespace;
> > +pub mod platform;
> >  pub mod prelude;
> >  pub mod print;
> >  pub mod rbtree;
> > diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
> > new file mode 100644
> > index 000000000000..868cfddb75a2
> > --- /dev/null
> > +++ b/rust/kernel/platform.rs
> > @@ -0,0 +1,222 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +//! Abstractions for the platform bus.
> > +//!
> > +//! C header: [`include/linux/platform_device.h`](srctree/include/linux/platform_device.h)
> > +
> > +use crate::{
> > +    bindings, container_of, device, driver,
> > +    error::{to_result, Result},
> > +    of,
> > +    prelude::*,
> > +    str::CStr,
> > +    types::{ARef, ForeignOwnable},
> > +    ThisModule,
> > +};
> > +
> > +/// An adapter for the registration of platform drivers.
> > +pub struct Adapter<T: Driver>(T);
> > +
> > +impl<T: Driver + 'static> driver::RegistrationOps for Adapter<T> {
> > +    type RegType = bindings::platform_driver;
> > +
> > +    fn register(
> > +        pdrv: &mut Self::RegType,
> > +        name: &'static CStr,
> > +        module: &'static ThisModule,
> > +    ) -> Result {
> > +        pdrv.driver.name = name.as_char_ptr();
> > +        pdrv.probe = Some(Self::probe_callback);
> > +
> > +        // Both members of this union are identical in data layout and semantics.
> > +        pdrv.__bindgen_anon_1.remove = Some(Self::remove_callback);
> > +        pdrv.driver.of_match_table = T::OF_ID_TABLE.as_ptr();
> > +
> > +        // SAFETY: `pdrv` is guaranteed to be a valid `RegType`.
> > +        to_result(unsafe { bindings::__platform_driver_register(pdrv, module.0) })
> > +    }
> > +
> > +    fn unregister(pdrv: &mut Self::RegType) {
> > +        // SAFETY: `pdrv` is guaranteed to be a valid `RegType`.
> > +        unsafe { bindings::platform_driver_unregister(pdrv) };
> > +    }
> > +}
> > +
> > +impl<T: Driver + 'static> Adapter<T> {
> > +    #[cfg(CONFIG_OF)]
> > +    fn of_id_info(pdev: &Device) -> Option<&'static T::IdInfo> {
> > +        let table = T::OF_ID_TABLE;
> > +
> > +        // SAFETY:
> > +        // - `table` has static lifetime, hence it's valid for read,
> > +        // - `dev` is guaranteed to be valid while it's alive, and so is `pdev.as_ref().as_raw()`.
> > +        let raw_id = unsafe { bindings::of_match_device(table.as_ptr(), pdev.as_ref().as_raw()) };
> > +
> > +        if raw_id.is_null() {
> > +            None
> > +        } else {
> > +            // SAFETY: `DeviceId` is a `#[repr(transparent)` wrapper of `struct of_device_id` and
> > +            // does not add additional invariants, so it's safe to transmute.
> > +            let id = unsafe { &*raw_id.cast::<of::DeviceId>() };
> > +
> > +            Some(table.info(<of::DeviceId as crate::device_id::RawDeviceId>::index(id)))
> > +        }
> > +    }
> > +
> > +    #[cfg(not(CONFIG_OF))]
> > +    fn of_id_info(_pdev: &Device) -> Option<&'static T::IdInfo> {
> > +        None
> > +    }
> > +
> > +    // Try to retrieve an `IdInfo` from any of the ID tables; if we can't find one for a particular
> > +    // table, it means we don't have a match in there. If we don't match any of the ID tables, it
> > +    // means we were matched by name.
> > +    fn id_info(pdev: &Device) -> Option<&'static T::IdInfo> {
> > +        let id = Self::of_id_info(pdev);
> > +        if id.is_some() {
> > +            return id;
> > +        }
> > +
> > +        None
> > +    }
> 
> These methods are going to have to be duplicated by every bus type which 
> can do DT matching (and later ACPI). Can't this be moved to be part of 
> the common Driver trait.
> 
> 
> I'll say it again for Greg to comment (doubtful he will look at v3 
> again). Really, I think we should also align the probe method interface 
> across bus types. That means getting rid of the 'id' in the PCI probe 
> (or add it for everyone). Most drivers never need it. The typical case 
> is needing nothing or the matched data. In a quick scan[1], there's 
> only a handful of cases. So I think probe should match the common 
> scenario and make retrieving the id match explicit if needed.

If there's a way for the probe callback to get access to the id that
caused it to match, then it's fine with me to remove it.  But is that
possible?  Many many drivers encode "stuff" in the id that the driver
needs to know (quirks, functions, etc.)

If that's not possible, then it needs to stay.

thanks,

greg k-h

