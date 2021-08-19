Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF1AE3F1302
	for <lists+linux-pci@lfdr.de>; Thu, 19 Aug 2021 08:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbhHSGB4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Aug 2021 02:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbhHSGBz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Aug 2021 02:01:55 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D7EC061764;
        Wed, 18 Aug 2021 23:01:19 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id n18so4850640pgm.12;
        Wed, 18 Aug 2021 23:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iba6xgnqeCs3hleX8P9deyAVhtvMX813Uz/nwVlwors=;
        b=uEkq725fqtCAWq3f4QNMyqZXVsMfnlkrU+lPhr2O3kBTqH0y4Tv1X4Zzir7V3InwDN
         17XDcM9bvLER8uM5fZgm1D4E1df0PKQ0lYmKmF34PdEz+/lQiIxNBxxd3+pJumbqNlMN
         3vKOqQV0Nf4OnT/BGa/HIRTeTNEs5ja9sUqmG5nKEq9k1S7bSTuj1OmIg1Cim1zVJpru
         eUoc43SGTtiwTcgH3/d0g1zlAaqzKCYidBAto8hClJ/9lvmyFR/b56jnxGgycbaPP6vs
         GKkgq9CdFYVC2e+c4ylk8SJaTgSFjmcx/K/nlDIG4crfYnYOJfOjvuccASZEXtPJfrIw
         9E1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iba6xgnqeCs3hleX8P9deyAVhtvMX813Uz/nwVlwors=;
        b=sGvpadGke7aGGZjMG4EIusO+rmyc8dxuW/0Hi3tNdyV5m8Xs2t8CSnzEIueSf7LmY7
         mtWB8VdH8SqSsbTk8dVEN8+8dnkiRVH3YqmHL/zDYY/Pi8Jkp3ghA3buBDWULh11fT8v
         ER0feuPg0xcyxVW6J62jTS1x/wqpMafI9yhprVjUnGD2P6DtaesBDl+LFwtZIG5UmxfS
         3a00ewXcVzQ8FaHRqGwB6Y03CU4btFP/eVDtcI4P1C6TV2J5pdHIZcX7/qLkDrBoyZEx
         ZajQa8OLoF3479Y3MVzT+byVJdDfdn3VRhKHKXH2ZdWZ7AhAgQwGtvitUwspvP6JSonH
         oU3Q==
X-Gm-Message-State: AOAM531S+YyqQmqKH/OwO/9Ir+yivTvfxYZnJ1opEAfSD2tb3MHwFjnP
        n8VD5/z9z6NjAs860fLvgkk=
X-Google-Smtp-Source: ABdhPJzhF0ukSYkEqV3JBKnZFXNwxyeK1CdTCRC9vOT376DixicVObSfGRE4Dm2sFlzKC5J0JfIthQ==
X-Received: by 2002:a63:1b53:: with SMTP id b19mr12500806pgm.160.1629352879097;
        Wed, 18 Aug 2021 23:01:19 -0700 (PDT)
Received: from localhost ([185.230.126.147])
        by smtp.gmail.com with ESMTPSA id b190sm2098931pgc.91.2021.08.18.23.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 23:01:18 -0700 (PDT)
Date:   Thu, 19 Aug 2021 11:31:14 +0530
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v16 0/9] PCI: Expose and manage PCI device reset
Message-ID: <20210819060114.zwdqavj2aoyypznb@archlinux>
References: <20210817180937.3123-1-ameynarkhede03@gmail.com>
 <20210818224603.GA3142002@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210818224603.GA3142002@bjorn-Precision-5520>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21/08/18 05:46PM, Bjorn Helgaas wrote:
> On Tue, Aug 17, 2021 at 11:39:28PM +0530, Amey Narkhede wrote:
> > PCI and PCIe devices may support a number of possible reset mechanisms
> > for example Function Level Reset (FLR) provided via Advanced Feature or
> > PCIe capabilities, Power Management reset, bus reset, or device specific reset.
> > Currently the PCI subsystem creates a policy prioritizing these reset methods
> > which provides neither visibility nor control to userspace.
> >
> > Expose the reset methods available per device to userspace, via sysfs
> > and allow an administrative user or device owner to have ability to
> > manage per device reset method priorities or exclusions.
> > This feature aims to allow greater control of a device for use cases
> > as device assignment, where specific device or platform issues may
> > interact poorly with a given reset method, and for which device specific
> > quirks have not been developed.
> >
> > Changes in v16:
> > 	- Refactor acpi_pci_bridge_d3() in patch 7/9
> > 	- Fixed consistency issues in patch 9/9
> >
> > Changes in v15:
> > 	- Fix use of uninitialized variable in patch 3/9
> >
> > Changes in v14:
> > 	- Remove duplicate entries from pdev->reset_methods as per
> > 	  Shanker's suggestion
> >
> > Changes in v13:
> > 	- Added "PCI: Cache PCIe FLR capability"
> > 	- Removed memcpy in pci_init_reset_methods() and reset_method_show
> > 	- Moved reset_method sysfs attribute code from pci-sysfs.c to
> > 	  pci.c
> >
> > Changes in v12:
> >         - Corrected subject in 0/8 (cover letter).
> >
> > Changes in v11:
> >         - Alex's suggestion fallback back to other resets if the ACPI RST
> >           fails. Fix "s/-EINVAL/-ENOTTY/" in 7/8 patch.
> >
> > Changes in v10:
> >         - Fix build error on ppc as reported by build bot
> >
> > Changes in v9:
> >         - Renamed has_flr bitfield to has_pcie_flr and restored
> >           use of PCI_DEV_FLAGS_NO_FLR_RESET in quirk_no_flr()
> >         - Cleaned up sysfs code
> >
> > Changes in v8:
> >         - Added has_flr bitfield to struct pci_dev to cache flr
> >           capability
> >         - Updated encoding scheme used in reset_methods array as per
> >           Bjorn's suggestion
> >         - Updated Shanker's ACPI patches
> >
> > Changes in v7:
> >         - Fix the pci_dev_acpi_reset() prototype mismatch
> >           in case of CONFIG_ACPI=n
> >
> > Changes in v6:
> >         - Address Bjorn's and Krzysztof's review comments
> >         - Add Shanker's updated patches along with new
> >           "PCI: Setup ACPI_COMPANION early" patch
> >
> > Changes in v5:
> >         - Rebase the series over pci/reset branch of
> >           Bjorn's pci tree to avoid merge conflicts
> >           caused by recent changes in existing reset
> >           sysfs attribute
> >
> > Changes in v4:
> >         - Change the order or strlen and strim in reset_method_store
> >           function to avoid extra strlen call.
> >         - Use consistent terminology in new
> >           pci_reset_mode enum and rename the probe argument
> >           of reset functions.
> >
> > Changes in v3:
> >         - Dropped "PCI: merge slot and bus reset implementations" which was
> >           already accepted separately
> >         - Grammar fixes
> >         - Added Shanker's patches which were rebased on v2 of this series
> >         - Added "PCI: Change the type of probe argument in reset functions"
> >           and additional user input sanitization code in reset_method_store
> >           function per review feedback from Krzysztof
> >
> > Changes in v2:
> >         - Use byte array instead of bitmap to keep track of
> >           ordering of reset methods
> >         - Fix incorrect use of reset_fn field in octeon driver
> >         - Allow writing comma separated list of names of supported reset
> >           methods to reset_method sysfs attribute
> >         - Writing empty string instead of "none" to reset_method attribute
> >           disables ability of reset the device
> >
> > Amey Narkhede (6):
> >   PCI: Cache PCIe FLR capability
> >   PCI: Add pcie_reset_flr to follow calling convention of other reset
> >     methods
> >   PCI: Add new array for keeping track of ordering of reset methods
> >   PCI: Remove reset_fn field from pci_dev
> >   PCI: Allow userspace to query and set device reset mechanism
> >   PCI: Change the type of probe argument in reset functions
> >
> > Shanker Donthineni (3):
> >   PCI: Define a function to set ACPI_COMPANION in pci_dev
> >   PCI: Setup ACPI fwnode early and at the same time with OF
> >   PCI: Add support for ACPI _RST reset method
> >
> >  Documentation/ABI/testing/sysfs-bus-pci       |  19 ++
> >  drivers/crypto/cavium/nitrox/nitrox_main.c    |   4 +-
> >  .../ethernet/cavium/liquidio/lio_vf_main.c    |   2 +-
> >  drivers/pci/hotplug/pciehp.h                  |   2 +-
> >  drivers/pci/hotplug/pciehp_hpc.c              |   2 +-
> >  drivers/pci/hotplug/pnv_php.c                 |   2 +-
> >  drivers/pci/pci-acpi.c                        |  83 +++---
> >  drivers/pci/pci-sysfs.c                       |   3 +-
> >  drivers/pci/pci.c                             | 279 +++++++++++++-----
> >  drivers/pci/pci.h                             |  24 +-
> >  drivers/pci/pcie/aer.c                        |  12 +-
> >  drivers/pci/probe.c                           |  16 +-
> >  drivers/pci/quirks.c                          |  25 +-
> >  drivers/pci/remove.c                          |   1 -
> >  include/linux/pci.h                           |  14 +-
> >  include/linux/pci_hotplug.h                   |   2 +-
> >  16 files changed, 346 insertions(+), 144 deletions(-)
>
> I applied these to pci/reset for v5.15, thanks!
>
> Of course, I made some edits, mostly trivial, but not all, so please
> take a look and see if I broke something.
>
> The biggest changes are to reset_method_store(), where I made it
> return -EINVAL if the user-supplied string contains an invalid method,
> a method whose probe call says it's unsupported, or too many methods.
> In all these cases, the previous reset_methods[] array is unchanged.
>
> I think this is basically what you originally proposed, Amey, and I
> thought it was too complicated.  But Krzysztof convinced me that
> silently ignoring bad data from the user makes the interface hard to
> use.
>
> Below is the whole diff from the v16 you posted to what's on the
> pci/reset branch.  I'm happy to update that branch before it gets
> merged into v5.15.
>
> Bjorn
>
> diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
> index aefb25e7c8d0..d4ae03296861 100644
> --- a/Documentation/ABI/testing/sysfs-bus-pci
> +++ b/Documentation/ABI/testing/sysfs-bus-pci
> @@ -122,23 +122,21 @@ Description:
>  		from this part of the device tree.
>
>  What:		/sys/bus/pci/devices/.../reset_method
> -Date:		March 2021
> +Date:		August 2021
>  Contact:	Amey Narkhede <ameynarkhede03@gmail.com>
>  Description:
>  		Some devices allow an individual function to be reset
>  		without affecting other functions in the same slot.
>
>  		For devices that have this support, a file named
> -		reset_method will be present in sysfs. Initially reading
> -		this file will give names of the device supported reset
> -		methods and their ordering. After write, this file will
> -		give names and ordering of currently enabled reset methods.
> -		Writing the name or space separated list of names of any of
> -		the device supported reset methods to this file will set
> -		the reset methods and their ordering to be used when
> -		resetting the device. Writing empty string to this file
> -		will disable ability to reset the device and writing
> -		"default" will return to the original value.
> +		reset_method is present in sysfs.  Reading this file
> +		gives names of the supported and enabled reset methods and
> +		their ordering.  Writing a space-separated list of names of
> +		reset methods sets the reset methods and ordering to be
> +		used when resetting the device.  Writing an empty string
> +		disables the ability to reset the device.  Writing
> +		"default" enables all supported reset methods in the
> +		default ordering.
>
>  What:		/sys/bus/pci/devices/.../reset
>  Date:		July 2009
> diff --git a/drivers/pci/hotplug/pnv_php.c b/drivers/pci/hotplug/pnv_php.c
> index 4c17a5dc26cf..f4c2e6e01be0 100644
> --- a/drivers/pci/hotplug/pnv_php.c
> +++ b/drivers/pci/hotplug/pnv_php.c
> @@ -537,7 +537,7 @@ static int pnv_php_reset_slot(struct hotplug_slot *slot, bool probe)
>  	 * which don't have a bridge. Only claim to support
>  	 * reset_slot() if we have a bridge device (for now...)
>  	 */
> -	if (probe == PCI_RESET_PROBE)
> +	if (probe)
>  		return !bridge;
>
>  	/* mask our interrupt while resetting the bridge */
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index 968bf8aa5f15..fe286c861187 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -944,8 +944,7 @@ void pci_set_acpi_fwnode(struct pci_dev *dev)
>  /**
>   * pci_dev_acpi_reset - do a function level reset using _RST method
>   * @dev: device to reset
> - * @probe: If PCI_RESET_PROBE, check whether _RST method is included
> - *         in the acpi_device context.
> + * @probe: if true, return 0 if device supports _RST
>   */
>  int pci_dev_acpi_reset(struct pci_dev *dev, bool probe)
>  {
> @@ -968,7 +967,10 @@ int pci_dev_acpi_reset(struct pci_dev *dev, bool probe)
>  static bool acpi_pci_power_manageable(struct pci_dev *dev)
>  {
>  	struct acpi_device *adev = ACPI_COMPANION(&dev->dev);
> -	return adev ? acpi_device_power_manageable(adev) : false;
> +
> +	if (!adev)
> +		return false;
> +	return acpi_device_power_manageable(adev);
>  }
>
>  static bool acpi_pci_bridge_d3(struct pci_dev *dev)
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index c76451bfeb89..b87bac5e4572 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4627,21 +4627,6 @@ int pci_wait_for_pending_transaction(struct pci_dev *dev)
>  }
>  EXPORT_SYMBOL(pci_wait_for_pending_transaction);
>
> -/**
> - * pcie_has_flr - check if a device supports function level resets
> - * @dev: device to check
> - *
> - * Returns true if the device advertises support for PCIe function level
> - * resets.
> - */
> -static bool pcie_has_flr(struct pci_dev *dev)
> -{
> -	if (dev->dev_flags & PCI_DEV_FLAGS_NO_FLR_RESET)
> -		return false;
> -
> -	return FIELD_GET(PCI_EXP_DEVCAP_FLR, dev->devcap) == 1;
> -}
> -
>  /**
>   * pcie_flr - initiate a PCIe function level reset
>   * @dev: device to reset
> @@ -4673,13 +4658,16 @@ EXPORT_SYMBOL_GPL(pcie_flr);
>  /**
>   * pcie_reset_flr - initiate a PCIe function level reset
>   * @dev: device to reset
> - * @probe: If PCI_RESET_PROBE, only check if the device can be reset this way.
> + * @probe: if true, return 0 if device can be reset this way
>   *
>   * Initiate a function level reset on @dev.
>   */
>  int pcie_reset_flr(struct pci_dev *dev, bool probe)
>  {
> -	if (!pcie_has_flr(dev))
> +	if (dev->dev_flags & PCI_DEV_FLAGS_NO_FLR_RESET)
> +		return -ENOTTY;
> +
> +	if (!(dev->devcap & PCI_EXP_DEVCAP_FLR))
>  		return -ENOTTY;
>
>  	if (probe)
> @@ -4736,7 +4724,7 @@ static int pci_af_flr(struct pci_dev *dev, bool probe)
>  /**
>   * pci_pm_reset - Put device into PCI_D3 and back into PCI_D0.
>   * @dev: Device to reset.
> - * @probe: If PCI_RESET_PROBE, only check if the device can be reset this way.
> + * @probe: if true, return 0 if the device can be reset this way.
>   *
>   * If @dev supports native PCI PM and its PCI_PM_CTRL_NO_SOFT_RESET flag is
>   * unset, it will be reinitialized internally when going from PCI_D3hot to
> @@ -4759,7 +4747,7 @@ static int pci_pm_reset(struct pci_dev *dev, bool probe)
>  	if (csr & PCI_PM_CTRL_NO_SOFT_RESET)
>  		return -ENOTTY;
>
> -	if (probe == PCI_RESET_PROBE)
> +	if (probe)
>  		return 0;
>
>  	if (dev->current_state != PCI_D0)
> @@ -5167,19 +5155,31 @@ static ssize_t reset_method_show(struct device *dev,
>  	return len;
>  }
>
> +static int reset_method_lookup(const char *name)
> +{
> +	int m;
> +
> +	for (m = 1; m < PCI_NUM_RESET_METHODS; m++) {
> +		if (sysfs_streq(name, pci_reset_fn_methods[m].name))
> +			return m;
> +	}
> +
> +	return 0;	/* not found */
> +}
> +
>  static ssize_t reset_method_store(struct device *dev,
>  				  struct device_attribute *attr,
>  				  const char *buf, size_t count)
>  {
>  	struct pci_dev *pdev = to_pci_dev(dev);
> -	int i, m = 0, n = 0;
> -	char *name, *options;
> -
> -	if (count >= (PAGE_SIZE - 1))
> -		return -EINVAL;
> +	char *options, *name;
> +	int m, n;
> +	u8 reset_methods[PCI_NUM_RESET_METHODS] = { 0 };
>
>  	if (sysfs_streq(buf, "")) {
> -		goto exit;
> +		pdev->reset_methods[0] = 0;
> +		pci_warn(pdev, "All device reset methods disabled by user");
> +		return count;
>  	}
>
>  	if (sysfs_streq(buf, "default")) {
> @@ -5191,53 +5191,46 @@ static ssize_t reset_method_store(struct device *dev,
>  	if (!options)
>  		return -ENOMEM;
>
> +	n = 0;
>  	while ((name = strsep(&options, " ")) != NULL) {
>  		if (sysfs_streq(name, ""))
>  			continue;
>
>  		name = strim(name);
>
> -		for (m = 1; m < PCI_NUM_RESET_METHODS; m++) {
> -			if (sysfs_streq(name, pci_reset_fn_methods[m].name))
> -				break;
> +		m = reset_method_lookup(name);
> +		if (!m) {
> +			pci_err(pdev, "Invalid reset method '%s'", name);
> +			goto error;
>  		}
>
> -		if (m == PCI_NUM_RESET_METHODS) {
> -			pci_warn(pdev, "Skip invalid reset method '%s'", name);
> -			continue;
> -		}
> -
> -		for (i = 0; i < n; i++) {
> -			if (pdev->reset_methods[i] == m)
> -				break;
> -		}
> -
> -		if (i < n)
> -			continue;
> -
>  		if (pci_reset_fn_methods[m].reset_fn(pdev, PCI_RESET_PROBE)) {
> -			pci_warn(pdev, "Unsupported reset method '%s'", name);
> -			continue;
> +			pci_err(pdev, "Unsupported reset method '%s'", name);
> +			goto error;
>  		}
>
> -		pdev->reset_methods[n++] = m;
> -		BUG_ON(n == PCI_NUM_RESET_METHODS);
> +		if (n == PCI_NUM_RESET_METHODS - 1) {
> +			pci_err(pdev, "Too many reset methods\n");
> +			goto error;
> +		}
> +
> +		reset_methods[n++] = m;
>  	}
>
> +	reset_methods[n] = 0;
> +
> +	/* Warn if dev-specific supported but not highest priority */
> +	if (pci_reset_fn_methods[1].reset_fn(pdev, PCI_RESET_PROBE) == 0 &&
> +	    reset_methods[0] != 1)
> +		pci_warn(pdev, "Device-specific reset disabled/de-prioritized by user");
> +	memcpy(pdev->reset_methods, reset_methods, sizeof(pdev->reset_methods));
>  	kfree(options);
> -
> -exit:
> -	/* All the reset methods are invalid */
> -	if (n == 0 && m == PCI_NUM_RESET_METHODS)
> -		return -EINVAL;
> -	pdev->reset_methods[n] = 0;
> -	if (pdev->reset_methods[0] == 0) {
> -		pci_warn(pdev, "All device reset methods disabled by user");
> -	} else if ((pdev->reset_methods[0] != 1) &&
> -		   !pci_reset_fn_methods[1].reset_fn(pdev, PCI_RESET_PROBE)) {
> -		pci_warn(pdev, "Device specific reset disabled/de-prioritized by user");
> -	}
>  	return count;
> +
> +error:
> +	/* Leave previous methods unchanged */
> +	kfree(options);
> +	return -EINVAL;
>  }
>  static DEVICE_ATTR_RW(reset_method);
>
> @@ -5296,7 +5289,7 @@ int __pci_reset_function_locked(struct pci_dev *dev)
>  	 * error, we're also finished: this indicates that further reset
>  	 * mechanisms might be broken on the device.
>  	 */
> -	for (i = 0; i <  PCI_NUM_RESET_METHODS; i++) {
> +	for (i = 0; i < PCI_NUM_RESET_METHODS; i++) {
>  		m = dev->reset_methods[i];
>  		if (!m)
>  			return -ENOTTY;
> @@ -5333,7 +5326,6 @@ void pci_init_reset_methods(struct pci_dev *dev)
>  	might_sleep();
>
>  	i = 0;
> -
>  	for (m = 1; m < PCI_NUM_RESET_METHODS; m++) {
>  		rc = pci_reset_fn_methods[m].reset_fn(dev, PCI_RESET_PROBE);
>  		if (!rc)
> @@ -5659,14 +5651,14 @@ static int pci_slot_reset(struct pci_slot *slot, bool probe)
>  	if (!slot || !pci_slot_resetable(slot))
>  		return -ENOTTY;
>
> -	if (probe != PCI_RESET_PROBE)
> +	if (!probe)
>  		pci_slot_lock(slot);
>
>  	might_sleep();
>
>  	rc = pci_reset_hotplug_slot(slot->hotplug, probe);
>
> -	if (probe != PCI_RESET_PROBE)
> +	if (!probe)
>  		pci_slot_unlock(slot);
>
>  	return rc;
> @@ -5726,7 +5718,7 @@ static int pci_bus_reset(struct pci_bus *bus, bool probe)
>  	if (!bus->self || !pci_bus_resetable(bus))
>  		return -ENOTTY;
>
> -	if (probe == PCI_RESET_PROBE)
> +	if (probe)
>  		return 0;
>
>  	pci_bus_lock(bus);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 38db12d05ca0..a46363f29b68 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -52,7 +52,7 @@
>  /* Number of reset methods used in pci_reset_fn_methods array in pci.c */
>  #define PCI_NUM_RESET_METHODS 7
>
> -#define	PCI_RESET_PROBE		true
> +#define PCI_RESET_PROBE		true
>  #define PCI_RESET_DO_RESET	false
>
>  /*
> @@ -339,7 +339,7 @@ struct pci_dev {
>  	struct rcec_ea	*rcec_ea;	/* RCEC cached endpoint association */
>  	struct pci_dev  *rcec;          /* Associated RCEC device */
>  #endif
> -	u32		devcap;		/* PCIe device capabilities */
> +	u32		devcap;		/* PCIe Device Capabilities */
>  	u8		pcie_cap;	/* PCIe capability offset */
>  	u8		msi_cap;	/* MSI capability offset */
>  	u8		msix_cap;	/* MSI-X capability offset */
> @@ -511,10 +511,9 @@ struct pci_dev {
>  	char		*driver_override; /* Driver name to force a match */
>
>  	unsigned long	priv_flags;	/* Private flags for the PCI driver */
> -	/*
> -	 * See pci_reset_fn_methods array in pci.c for ordering.
> -	 */
> -	u8 reset_methods[PCI_NUM_RESET_METHODS];	/* Reset methods ordered by priority */
> +
> +	/* These methods index pci_reset_fn_methods[] */
> +	u8 reset_methods[PCI_NUM_RESET_METHODS]; /* In priority order */
>  };
>
>  static inline struct pci_dev *pci_physfn(struct pci_dev *dev)

Hi Bjorn,
I'm okay with all the changes. Apologies I sent the old patch again so you had
to do extra work removing PCI_RESET_PROBE.

Thanks,
Amey
