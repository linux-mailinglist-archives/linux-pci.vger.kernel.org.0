Return-Path: <linux-pci+bounces-22533-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 682BEA47BDB
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 12:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA9AD7A7EF4
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 11:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34BB1218AAF;
	Thu, 27 Feb 2025 11:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VfMa5aiP"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E221662EF;
	Thu, 27 Feb 2025 11:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740655070; cv=none; b=Z76OTIIGscv4XGnFKbbjw9dX7SdL4S6X/CdmOwpwnZHDHKPzmiWlhz+0ECWtTQCq4wB1NhBVAKoxjDsKkYn64peqcqM/hHiS07N4zpmCiMVlS7dOKbLSNOCp2pt5o4afdapld/PDLu8HyPNKu12Ov7BK5CcjTgbvNIu6GAMF3b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740655070; c=relaxed/simple;
	bh=qYqZiHbJuRieUik0JSrhAqIJQnyHOkGQHLeCzdGmH8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=InavewTcNQgIOG3qcm8Fh20e7XRRalknfsVDJmPVamhl5NkdVnnBYkmKycw8YlCAJx5Epx2t/4Z8DJGXWYfy0eVrkKEY0ZLoP7YseNnvW4YBDMehZV5byQWYsE1ludhG8ieGziu7cZpNaw8v1aNXXuSnqhn/38vdE2vetJxKnNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VfMa5aiP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55ABCC4CEDD;
	Thu, 27 Feb 2025 11:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740655069;
	bh=qYqZiHbJuRieUik0JSrhAqIJQnyHOkGQHLeCzdGmH8g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VfMa5aiPCbrNQNA82IodjnbUb/6mfhGjfC/4y9+MCd2IR6ZYM7BSMnqhsF9OP7NJO
	 nJ/jhhqOsO/taSNn/Qf0odWFRUl6H5OTlMQFFTYrI9T0bmJZ46GrB5zuEaHJR0/7Dm
	 69D6aFT4bxPoeK3tagQcFpDuDE1IAsV0UKKGLnOA=
Date: Thu, 27 Feb 2025 03:16:40 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Alistair Francis <alistair@alistair23.me>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	lukas@wunner.de, linux-pci@vger.kernel.org, bhelgaas@google.com,
	Jonathan.Cameron@huawei.com, rust-for-linux@vger.kernel.org,
	akpm@linux-foundation.org, boqun.feng@gmail.com,
	bjorn3_gh@protonmail.com, wilfred.mallawa@wdc.com,
	aliceryhl@google.com, ojeda@kernel.org, alistair23@gmail.com,
	a.hindborg@kernel.org, tmgross@umich.edu, gary@garyguo.net,
	alex.gaynor@gmail.com, benno.lossin@proton.me,
	Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [RFC v2 09/20] PCI/CMA: Expose in sysfs whether devices are
 authenticated
Message-ID: <2025022717-dictate-cortex-5c05@gregkh>
References: <20250227030952.2319050-1-alistair@alistair23.me>
 <20250227030952.2319050-10-alistair@alistair23.me>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227030952.2319050-10-alistair@alistair23.me>

On Thu, Feb 27, 2025 at 01:09:41PM +1000, Alistair Francis wrote:
> From: Lukas Wunner <lukas@wunner.de>
> 
> The PCI core has just been amended to authenticate CMA-capable devices
> on enumeration and store the result in an "authenticated" bit in struct
> pci_dev->spdm_state.
> 
> Expose the bit to user space through an eponymous sysfs attribute.
> 
> Allow user space to trigger reauthentication (e.g. after it has updated
> the CMA keyring) by writing to the sysfs attribute.
> 
> Implement the attribute in the SPDM library so that other bus types
> besides PCI may take advantage of it.  They just need to add
> spdm_attr_group to the attribute groups of their devices and amend the
> dev_to_spdm_state() helper which retrieves the spdm_state for a given
> device.
> 
> The helper may return an ERR_PTR if it couldn't be determined whether
> SPDM is supported by the device.  The sysfs attribute is visible in that
> case but returns an error on access.  This prevents downgrade attacks
> where an attacker disturbs memory allocation or DOE communication
> in order to create the appearance that SPDM is unsupported.

I don't like this "if it's present we still don't know if the device
supports this", as that is not normally the "sysfs way" here.  Why must
it be present in those situations?  What is going to happen to suddenly
allow it to come back to be "alive" and working while the device is
still present in the system?

I'd prefer it to be "if the file is there, this is supported by the
device.  If the file is not there, it is not supported", as that makes
things so much simpler for userspace (i.e. you don't want userspace to
have to both test if the file is there AND read all entries just to see
if the kernel knows what is going on or not.)

Also, how will userspace know if the state changes from "unknown" to
"now it might work, try it again"?

> Subject to further discussion, a future commit might add a user-defined
> policy to forbid driver binding to devices which failed authentication,
> similar to the "authorized" attribute for USB.

That user-defined policy belongs in userspace, just like USB has it.
Why would the kernel need this?  Or do you mean that the kernel provides
a default like USB does and then requires userspace to manually enable a
device before binding a driver to the device is allowed?

> Alternatively, authentication success might be signaled to user space
> through a uevent, whereupon it may bind a (blacklisted) driver.

How will that happen?

> A uevent signaling authentication failure might similarly cause user
> space to unbind or outright remove the potentially malicious device.

Again how?  Who will be sending nthose uevents?  Who will be listening
to them?  What in the kernel is going to change to know to send those
events?  Why is any of this needed at all?  :)

> Traffic from devices which failed authentication could also be filtered
> through ACS I/O Request Blocking Enable (PCIe r6.2 sec 7.7.11.3) or
> through Link Disable (PCIe r6.2 sec 7.5.3.7).  Unlike an IOMMU, that
> will not only protect the host, but also prevent malicious peer-to-peer
> traffic to other devices.
> 
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> [ Changes by AF:
>  - Drop lib/spdm changes and replace with Rust implementation
> ]
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  Documentation/ABI/testing/sysfs-devices-spdm | 31 +++++++
>  MAINTAINERS                                  |  3 +-
>  drivers/pci/cma.c                            | 12 ++-
>  drivers/pci/doe.c                            |  2 +
>  drivers/pci/pci-sysfs.c                      |  3 +
>  drivers/pci/pci.h                            |  5 +
>  include/linux/pci.h                          | 12 +++
>  lib/rspdm/Makefile                           |  1 +
>  lib/rspdm/lib.rs                             |  1 +
>  lib/rspdm/req-sysfs.c                        | 97 ++++++++++++++++++++
>  lib/rspdm/sysfs.rs                           | 28 ++++++
>  11 files changed, 190 insertions(+), 5 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-devices-spdm
>  create mode 100644 lib/rspdm/req-sysfs.c
>  create mode 100644 lib/rspdm/sysfs.rs
> 
> diff --git a/Documentation/ABI/testing/sysfs-devices-spdm b/Documentation/ABI/testing/sysfs-devices-spdm
> new file mode 100644
> index 000000000000..2d6e5d513231
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-devices-spdm
> @@ -0,0 +1,31 @@
> +What:		/sys/devices/.../authenticated
> +Date:		June 2024
> +Contact:	Lukas Wunner <lukas@wunner.de>
> +Description:
> +		This file contains 1 if the device authenticated successfully
> +		with SPDM (Security Protocol and Data Model).  It contains 0 if
> +		the device failed authentication (and may thus be malicious).
> +
> +		Writing "re" to this file causes reauthentication.
> +		That may be opportune after updating the device keyring.
> +		The device keyring of the PCI bus is named ".cma"
> +		(Component Measurement and Authentication).
> +
> +		Reauthentication may also be necessary after device identity
> +		has mutated, e.g. after downloading firmware to an FPGA device.
> +
> +		The file is not visible if authentication is unsupported
> +		by the device.

Good.

> +		If the kernel could not determine whether authentication is
> +		supported because memory was low or communication with the
> +		device was not working, the file is visible but accessing it
> +		fails with error code ENOTTY.

Not good.  So this means that userspace can not trust that if the file
is there it actually works, so it has to do more work to determine if it
is working (as mentioned above).  Just either have the file if it works,
or not if it does not please.

> +		This prevents downgrade attacks where an attacker consumes
> +		memory or disturbs communication in order to create the
> +		appearance that a device does not support authentication.

If an attacker can consume kernel memory to cause this to happen you
have bigger problems.  That's not the kernel's issue here at all.

And "disable communication" means "we just don't support it as the
device doesn't say it does", so again, why does that matter?

> +		The reason why authentication support could not be determined
> +		is apparent from "dmesg".  To re-probe authentication support
> +		of PCI devices, exercise the "remove" and "rescan" attributes.

Don't make userspace parse kernel logs for this type of thing.  And
asking userspace to rely on remove and recan is a mess, either show it
works or not.

> diff --git a/MAINTAINERS b/MAINTAINERS
> index abb3b603299f..03e1076f915a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21385,7 +21385,8 @@ L:	linux-cxl@vger.kernel.org
>  L:	linux-pci@vger.kernel.org
>  S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/devsec/spdm.git
> -F:	drivers/pci/cma.c
> +F:	Documentation/ABI/testing/sysfs-devices-spdm
> +F:	drivers/pci/cma*
>  F:	include/linux/spdm.h
>  F:	lib/rspdm/
>  
> diff --git a/drivers/pci/cma.c b/drivers/pci/cma.c
> index f2c435b04b92..59558714f143 100644
> --- a/drivers/pci/cma.c
> +++ b/drivers/pci/cma.c
> @@ -171,8 +171,10 @@ void pci_cma_init(struct pci_dev *pdev)
>  {
>  	struct pci_doe_mb *doe;
>  
> -	if (IS_ERR(pci_cma_keyring))
> +	if (IS_ERR(pci_cma_keyring)) {
> +		pdev->spdm_state = ERR_PTR(-ENOTTY);

Why ENOTTY?

>  		return;
> +	}
>  
>  	if (!pci_is_pcie(pdev))
>  		return;
> @@ -185,8 +187,10 @@ void pci_cma_init(struct pci_dev *pdev)
>  	pdev->spdm_state = spdm_create(&pdev->dev, pci_doe_transport, doe,
>  				       PCI_DOE_MAX_PAYLOAD, pci_cma_keyring,
>  				       pci_cma_validate);
> -	if (!pdev->spdm_state)
> +	if (!pdev->spdm_state) {
> +		pdev->spdm_state = ERR_PTR(-ENOTTY);

Again, why ENOTTY?  This isn't a tty device :)

>  		return;
> +	}
>  
>  	/*
>  	 * Keep spdm_state allocated even if initial authentication fails
> @@ -204,7 +208,7 @@ void pci_cma_init(struct pci_dev *pdev)
>   */
>  void pci_cma_reauthenticate(struct pci_dev *pdev)
>  {
> -	if (!pdev->spdm_state)
> +	if (IS_ERR_OR_NULL(pdev->spdm_state))

Why does this matter, it should either be NULL or not, adding an error
value just makes it more complex and if you make the changes I mention
above, I don't think it's needed, right?

> --- a/lib/rspdm/lib.rs
> +++ b/lib/rspdm/lib.rs
> @@ -24,6 +24,7 @@
>  
>  mod consts;
>  mod state;
> +pub mod sysfs;

Hey, a sysfs binding!

Well, not really, it's a hack as mentioned below, that I do not think
you really want to do just yet.


>  mod validator;
>  
>  /// spdm_create() - Allocate SPDM session
> diff --git a/lib/rspdm/req-sysfs.c b/lib/rspdm/req-sysfs.c
> new file mode 100644
> index 000000000000..11bacb04f08f
> --- /dev/null
> +++ b/lib/rspdm/req-sysfs.c
> @@ -0,0 +1,97 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Rust implementation of the DMTF Security Protocol and Data Model (SPDM)
> + * https://www.dmtf.org/dsp/DSP0274
> + *
> + * Requester role: sysfs interface
> + *
> + * Copyright (C) 2023-24 Intel Corporation
> + * Copyright (C) 2024 Western Digital
> + */
> +
> +#include <linux/pci.h>
> +
> +int rust_authenticated_show(void *spdm_state, char *buf);

Don't put externs in a .c file, didn't checkpatch catch this?  More on
this below...

> +
> +/**
> + * dev_to_spdm_state() - Retrieve SPDM session state for given device
> + *
> + * @dev: Responder device
> + *
> + * Returns a pointer to the device's SPDM session state,
> + *	   %NULL if the device doesn't have one or
> + *	   %ERR_PTR if it couldn't be determined whether SPDM is supported.
> + *
> + * In the %ERR_PTR case, attributes are visible but return an error on access.
> + * This prevents downgrade attacks where an attacker disturbs memory allocation
> + * or communication with the device in order to create the appearance that SPDM
> + * is unsupported.  E.g. with PCI devices, the attacker may foil CMA or DOE
> + * initialization by simply hogging memory.
> + */
> +static void *dev_to_spdm_state(struct device *dev)
> +{
> +	if (dev_is_pci(dev))
> +		return pci_dev_to_spdm_state(to_pci_dev(dev));
> +
> +	/* Insert mappers for further bus types here. */
> +
> +	return NULL;
> +}
> +
> +/* authenticated attribute */
> +
> +static umode_t spdm_attrs_are_visible(struct kobject *kobj,
> +				      struct attribute *a, int n)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	void *spdm_state = dev_to_spdm_state(dev);
> +
> +	if (IS_ERR_OR_NULL(spdm_state))
> +		return SYSFS_GROUP_INVISIBLE;
> +
> +	return a->mode;
> +}
> +
> +static ssize_t authenticated_store(struct device *dev,
> +				   struct device_attribute *attr,
> +				   const char *buf, size_t count)
> +{
> +	void *spdm_state = dev_to_spdm_state(dev);
> +	int rc;
> +
> +	if (IS_ERR_OR_NULL(spdm_state))
> +		return PTR_ERR(spdm_state);
> +
> +	if (sysfs_streq(buf, "re")) {

I don't like sysfs files that when reading show a binary, but require a
"magic string" to be written to them to have them do something else.
that way lies madness.  What would you do if each sysfs file had a
custom language that you had to look up for each one?  Be consistant
here.  But again, I don't think you need a store function at all, either
the device supports this, or it doesn't.

> +		rc = spdm_authenticate(spdm_state);

Call into Rust code?  More on that below...

> +		if (rc)
> +			return rc;
> +	} else {
> +		return -EINVAL;
> +	}
> +
> +	return count;
> +}
> +
> +static ssize_t authenticated_show(struct device *dev,
> +				  struct device_attribute *attr, char *buf)
> +{
> +	void *spdm_state = dev_to_spdm_state(dev);
> +
> +	if (IS_ERR_OR_NULL(spdm_state))
> +		return PTR_ERR(spdm_state);

Again, this check can go away if the file just isn't there.


> +
> +	return rust_authenticated_show(spdm_state, buf);

Here you have C code calling into Rust code.  I'm not complaining about
it, but I think it will be the first use of this, and I didn't think
that the rust maintainers were willing to do that just yet.

Has that policy changed?

The issue here is that the C signature for this is not being
auto-generated, you have to manually keep it in sync (as you did above),
with the Rust side.  That's not going to scale over time at all, you
MUST have a .h file somewhere for C to know how to call into this and
for the compiler to check that all is sane on both sides.

And you are passing a random void * into the Rust side, what could go
wrong?  I think this needs more thought as this is fragile-as-f***.

thanks,

greg k-h

