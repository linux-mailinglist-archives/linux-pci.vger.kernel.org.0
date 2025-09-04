Return-Path: <linux-pci+bounces-35454-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F075B43FE9
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 17:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C04F01C84274
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 15:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473D9306487;
	Thu,  4 Sep 2025 15:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ruhLRAUQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A09304BCE;
	Thu,  4 Sep 2025 15:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756998189; cv=none; b=hXVcV3SMdQtH44bXJ5Su0Ml4DGs+8OJ/n+JEQYpZZkNTCmtvsKbTrqBkb5UqUKCKTTGx4FHGxuiuGs5yobN4QRM0IC9I5aVcrPwUzuHbAvdszuzzdsIYCy8tCS0lnWsi5rmUUXv7Z0HcH/TRRNf1Po/S5hSuxSZMIVXOX3vDuFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756998189; c=relaxed/simple;
	bh=B9Z8w17gm0h4eiv5qhGBuPzWcH13vlN6cBjLz3C9WKg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GEpOVbHC82TmSC8IMVEX9xkzoUSJQZxVv4KPq30pq3pxmfCdH54TzDGTkPXaUcZHLuCYXiYnscg4nhSimdWygMa72BYEQBoaHnPrTYdbrp/5tIDpmdVrVoCK3ljm5Ur1Hni+/3DHk5IesATNagspq1qEEiKeB9igGNIGyvmDRcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ruhLRAUQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58A25C4CEF0;
	Thu,  4 Sep 2025 15:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756998188;
	bh=B9Z8w17gm0h4eiv5qhGBuPzWcH13vlN6cBjLz3C9WKg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ruhLRAUQLMKt7CLJh/Le94weoxK1FRLYvFlZyk0/OlECP0I31Ag3MYfDg1nqeeqna
	 FGwNnODg5K9t20ScN8gERsrwcDnlnp+Lp/VEy0essMZIfYn8yOgFJhQXOe6ZglLfy9
	 kQ2cwnJfu5CWy487AuFpuYj3hxDTOtMnwfunFK9No0QiCWODoN0Pn5DcyJwu3P5p+y
	 Qi0k70rwH93ynWnc8AOdPZNHUM9uIh01cbyg5PydCVKPZ9l0gWj6IjpEczER/teFOa
	 TS46v7wjac+QdcOpJNYOLj4xOFPyGwXcTv6Leky4N3qFhy+gEugQQdCBzaAi3A81SD
	 yRh8hjPgVdUvw==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org
Cc: gregkh@linuxfoundation.org, bhelgaas@google.com, yilun.xu@linux.intel.com,
	aik@amd.com
Subject: Re: [PATCH 5/7] PCI/TSM: Add Device Security (TVM Guest) operations
 support
In-Reply-To: <20250827035259.1356758-6-dan.j.williams@intel.com>
References: <20250827035259.1356758-1-dan.j.williams@intel.com>
 <20250827035259.1356758-6-dan.j.williams@intel.com>
Date: Thu, 04 Sep 2025 20:32:59 +0530
Message-ID: <yq5aplc61crg.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dan Williams <dan.j.williams@intel.com> writes:

> PCIe Trusted Execution Environment Device Interface Security Protocol
> (TDISP) has two distinct sets of operations. The first, currently enabled
> in driver/pci/tsm.c, enables the VMM to authenticate the physical function
> (PCIe Component Measurement and Authentication (CMA)), establish a secure
> message passing session (DMTF SPDM), and establish physical link security
> (PCIe Integrity and Data Encryption (IDE)). The second set lets the TVM
> manage the security state of assigned devices (TEE Device Interfaces
> (TDIs)). Enable the latter with three new 'struct pci_tsm_ops' operations:
>
>  - lock(): Transition the device to the TDISP state. In this mode
>    the device is responsible for validating that it is in a secure
>    configuration and will transition to the TDISP ERROR state if those
>    settings are modified. Device Security Manager (DSM) and the TEE
>    Security Manager (TSM) enforce that the device is not permitted to issue
>    T=1 traffic in this mode.
>
>  - accept(): After validating device measurements, the launch state of the
>    TVM, or any other pertinent information about the state of the TVM or
>    TDI a relying party authorizes a device to enter the TEE. Transition the
>    device to the TDISP RUN state and mark its PCI MMIO ranges as "encrypted".
>
>  - unlock(): From the RUN state the only other TDISP states that can be moved to
>    are ERROR or UNLOCKED. Voluntarily move the device to the UNLOCKED
>    state.
>
> Only the mechanism for these operations is included, all of the policy and
> infrastructure to support making the 'accept' decision are left to
> follow-on work.
>
> Co-developed-by: Xu Yilun <yilun.xu@linux.intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> Co-developed-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-pci   |  46 ++-
>  Documentation/ABI/testing/sysfs-class-tsm |  19 ++
>  drivers/pci/Kconfig                       |   2 +
>  drivers/pci/tsm.c                         | 358 +++++++++++++++++++++-
>  drivers/virt/coco/tsm-core.c              |  41 +++
>  include/linux/device.h                    |   1 +
>  include/linux/pci-tsm.h                   |  25 +-
>  7 files changed, 482 insertions(+), 10 deletions(-)
>
> diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
> index e0c8dad8d889..38b8ec34c4a3 100644
> --- a/Documentation/ABI/testing/sysfs-bus-pci
> +++ b/Documentation/ABI/testing/sysfs-bus-pci
> @@ -638,13 +638,16 @@ Description:
>  		Encryption) establishment. Reads from this attribute return the
>  		name of the connected TSM or the empty string if not
>  		connected. A TSM device signals its readiness to accept PCI
> -		connection via a KOBJ_CHANGE event.
> +		connection via a KOBJ_CHANGE event. This is a "link" TSM
> +		attribute, see Documentation/ABI/testing/sysfs-class-tsm.
>  
>  What:		/sys/bus/pci/devices/.../tsm/disconnect
>  Contact:	linux-coco@lists.linux.dev
>  Description:
>  		(WO) Write the name of the TSM device that was specified
> -		to 'connect' to teardown the connection.
> +		to 'connect' to teardown the connection. This is a
> +		"link" TSM attribute, see
> +		Documentation/ABI/testing/sysfs-class-tsm.
>  
>  What:		/sys/bus/pci/devices/.../authenticated
>  Contact:	linux-pci@vger.kernel.org
> @@ -663,3 +666,42 @@ Description:
>  		When present and the tsm/ attribute directory is present, the
>  		authenticated attribute is an alias for the device 'connect'
>  		state. See the 'tsm/connect' attribute for more details.
> +		This is a "link" TSM attribute, see
> +		Documentation/ABI/testing/sysfs-class-tsm.
> +
> +What:		/sys/bus/pci/devices/.../tsm/lock
> +Contact:	linux-coco@lists.linux.dev
> +Description:
> +		(RW) Write the name of a TSM (TEE Security Manager) device from
> +		/sys/class/tsm to this file to request that TSM lock th device
> +		device. This puts the device in a state where it can not accept
> +		or issue secure memory cycles (T=1 in the PCIe TLP), and
> +		security sensitive configuration setting can not be changed
> +		without transitioning the device the PCIe TDISP ERROR state.
> +		Reads from this attribute return the name of the lock-holding
> +		TSM or the empty string if not locked. A TSM device signals its
> +		readiness for lock requests via a KOBJ_CHANGE event. Writes fail
> +		with EBUSY if this device is bound to a driver. This is a
> +		"devsec" TSM attribute, see
> +		Documentation/ABI/testing/sysfs-class-tsm.
> +
> +What:		/sys/bus/pci/devices/.../tsm/unlock
> +Contact:	linux-coco@lists.linux.dev
> +Description:
> +		(WO) Write the name of the TSM device that was specified to
> +		'lock' to teardown the connection. Writes fail with EBUSY if
> +		this device is bound to a driver. This is a "devsec" TSM
> +		attribute, see Documentation/ABI/testing/sysfs-class-tsm.
> +
> +What:		/sys/bus/pci/devices/.../tsm/accept
> +Contact:	linux-coco@lists.linux.dev
> +Description:
> +		(RW) Write "1" (or any boolean "true" string) to this file to
> +		request that TSM transition the device from the TDISP LOCKED
> +		state to the RUN state and arrange the for the secure IOMMU to
> +		accept requests with T=1 in the PCIe packet header (TLP)
> +		targeting private memory. Per TDISP the only exits from the RUN
> +		state are via an explicit unlock request or an event that
> +		transitions the device to the ERROR state. Writes fail with
> +		EBUSY if this device is bound to a driver. This is a "devsec"
> +		TSM attribute, see Documentation/ABI/testing/sysfs-class-tsm.
> diff --git a/Documentation/ABI/testing/sysfs-class-tsm b/Documentation/ABI/testing/sysfs-class-tsm
> index 6fc1a5ac6da1..d1bcc1a266ca 100644
> --- a/Documentation/ABI/testing/sysfs-class-tsm
> +++ b/Documentation/ABI/testing/sysfs-class-tsm
> @@ -17,3 +17,22 @@ Description:
>  		across host bridges. The link points to the endpoint PCI device
>  		and matches the same link published by the host bridge. See
>  		Documentation/ABI/testing/sysfs-devices-pci-host-bridge.
> +
> +What:		/sys/class/tsm/tsmN/pci_mode
> +Contact:	linux-coco@lists.linux.dev
> +Description:
> +		(RO) A TSM with PCIe TDISP capability can be in one of two
> +		modes.
> +
> +		    "link": typically for a hypervisor (VMM) to authenticate,
> +			    establish a secure session, and setup link
> +			    encryption.
> +
> +		    "devsec": typically for a confidential guest (TVM) to
> +			      transition assigned devices through the TDISP
> +			      state machine UNLOCKED->LOCKED->RUN.
> +
> +		See the "tsm/" entries in
> +		Documentation/ABI/testing/sysfs-bus-pci for the available PCI
> +		device attributes when a TSM with the given "pci_mode" is
> +		registered.
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index 0183ca6f6954..d595e8fd8c3d 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -138,6 +138,8 @@ config PCI_IDE_STREAM_MAX
>  
>  config PCI_TSM
>  	bool "PCI TSM: Device security protocol support"
> +	depends on ARCH_HAS_CC_PLATFORM
> +	select CONFIDENTIAL_DEVICES
>  	select PCI_IDE
>  	select PCI_DOE
>  	select TSM
> diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
> index 3143558373e3..948300f0ce92 100644
> --- a/drivers/pci/tsm.c
> +++ b/drivers/pci/tsm.c
> @@ -9,6 +9,7 @@
>  #define dev_fmt(fmt) "PCI/TSM: " fmt
>  
>  #include <linux/bitfield.h>
> +#include <linux/ioport.h>
>  #include <linux/pci.h>
>  #include <linux/pci-doe.h>
>  #include <linux/pci-tsm.h>
> @@ -35,6 +36,11 @@ static inline bool is_dsm(struct pci_dev *pdev)
>  	return pdev->tsm && pdev->tsm->dsm == pdev;
>  }
>  
> +static inline bool has_tee(struct pci_dev *pdev)
> +{
> +	return pdev->devcap & PCI_EXP_DEVCAP_TEE;
> +}
> +
>  /* 'struct pci_tsm_pf0' wraps 'struct pci_tsm' when ->dsm == ->pdev (self) */
>  static struct pci_tsm_pf0 *to_pci_tsm_pf0(struct pci_tsm *pci_tsm)
>  {
> @@ -48,6 +54,24 @@ static struct pci_tsm_pf0 *to_pci_tsm_pf0(struct pci_tsm *pci_tsm)
>  	return container_of(pci_tsm, struct pci_tsm_pf0, base);
>  }
>  
> +static inline bool is_devsec(struct pci_dev *pdev)
> +{
> +	return pdev->tsm && pdev->tsm->dsm == NULL && pdev->tsm->tdi == NULL;
> +}
> +
> +/* 'struct pci_tsm_devsec' wraps 'struct pci_tsm' when ->tdi == ->dsm == NULL */
> +static struct pci_tsm_devsec *to_pci_tsm_devsec(struct pci_tsm *pci_tsm)
> +{
> +	struct pci_dev *pdev = pci_tsm->pdev;
> +
> +	if (!is_devsec(pdev) || !has_tee(pdev)) {
> +		dev_WARN_ONCE(&pdev->dev, 1, "invalid context object\n");
> +		return NULL;
> +	}
> +
> +	return container_of(pci_tsm, struct pci_tsm_devsec, base);
> +}
> +
>  static void tsm_remove(struct pci_tsm *tsm)
>  {
>  	struct pci_dev *pdev;
> @@ -453,6 +477,265 @@ static ssize_t disconnect_store(struct device *dev,
>  }
>  static DEVICE_ATTR_WO(disconnect);
>  
> +static struct resource **alloc_encrypted_resources(struct pci_dev *pdev,
> +						   struct resource **__res)
> +{
> +	int i;
> +
> +	memset(__res, 0, sizeof(struct resource *) * PCI_NUM_RESOURCES);
> +
> +	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
> +		unsigned long flags = pci_resource_flags(pdev, i);
> +		resource_size_t len = pci_resource_len(pdev, i);
> +
> +		if (!len || !(flags & IORESOURCE_MEM))
> +			continue;
> +
> +
> +		__res[i] = kzalloc(sizeof(struct resource), GFP_KERNEL);
> +		if (!__res[i])
> +			break;
> +
> +		*__res[i] = DEFINE_RES_NAMED_DESC(pci_resource_start(pdev, i),
> +						  len, "PCI MMIO Encrypted",
> +						  flags, IORES_DESC_ENCRYPTED);
> +
>

Not all resources are secure/encrypted. For example, if secure
interrupts are not supported, then the MSI-X table and PBA BARs remain
shared resources between the guest and the hypervisor.

In ARM CCA, the interface report is used to determine the nature of each
region. When ioremap() is called, it relies on the Realm IPA state of
the guest physical address to decide whether the mapping should be
treated as shared or private [1], [2].

With this change we report the msix table and pba range as encrypted in
/proc/iomem

 50012000-50012fff : PCI MMIO Encrypted
    50012000-50012fff : 0000:00:01.0
      50012000-50012fff : ahci
  50013000-50013fff : PCI MMIO Encrypted
    50013000-50013fff : 0000:00:01.0
      50013000-50013fff : ahci


[1] https://lore.kernel.org/all/20240830130150.8568-6-will@kernel.org
[2] https://lore.kernel.org/all/20240819131924.372366-12-steven.price@arm.com

> +		if (insert_resource(&iomem_resource, __res[i]) != 0) {
> +			kfree(__res[i]);
> +			__res[i] = NULL;
> +			break;
> +		}
> +	}
> +
> +	if (i >= PCI_NUM_RESOURCES)
> +		return __res;
> +
> +	for (; i >= 0; i--) {
> +		if (!__res[i])
> +			continue;
> +
> +		remove_resource(__res[i]);
> +		kfree(__res[i]);
> +		__res[i] = NULL;
> +	}
> +
> +	return NULL;
> +}
> +
> +static void set_encrypted_resources(struct pci_tsm_devsec *tsm,
> +				    struct resource **res)
> +{
> +	memcpy(tsm->resource, res, sizeof(tsm->resource));
> +}
> +
> +static void free_encrypted_resources(struct resource **res)
> +{
> +	for (int i = PCI_NUM_RESOURCES - 1; i >= 0; i--) {
> +		if (!res[i])
> +			continue;
> +		remove_resource(res[i]);
> +		kfree(res[i]);
> +		res[i] = NULL;
> +	}
> +}
> +
> +DEFINE_FREE(free_encrypted_resources, struct resource **,
> +	    if (_T) free_encrypted_resources(_T))
> +
> +/**
> + * pci_tsm_accept() - accept a device for private MMIO+DMA operation
> + * @pdev: PCI device to accept
> + *
> + * "Accept" transitions a device to the run state, it is only suitable to make
> + * that transition from a known DMA-idle (no active mappings) state. The "driver
> + * detached" state is a coarse way to assert that requirement.
> + */
> +static int pci_tsm_accept(struct pci_dev *pdev)
> +{
> +	struct resource *__res[PCI_NUM_RESOURCES];
> +	int rc;
> +
> +	ACQUIRE(rwsem_read_intr, lock)(&pci_tsm_rwsem);
> +	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &lock)))
> +		return rc;
> +
> +	if (!pdev->tsm)
> +		return -EINVAL;
> +
> +	ACQUIRE(device_intr, dev_lock)(&pdev->dev);
> +	if ((rc = ACQUIRE_ERR(device_intr, &dev_lock)))
> +		return rc;
> +
> +	if (pdev->dev.driver)
> +		return -EBUSY;
> +
> +	struct resource **res __free(free_encrypted_resources) =
> +		alloc_encrypted_resources(pdev, __res);
> +	if (!res)
> +		return -ENOMEM;
> +
> +	rc = pdev->tsm->ops->accept(pdev);
> +	if (rc)
> +		return rc;
> +	device_cc_accept(&pdev->dev);
> +	set_encrypted_resources(to_pci_tsm_devsec(pdev->tsm), no_free_ptr(res));
> +
> +	return 0;
> +}
> +
> +static ssize_t accept_store(struct device *dev, struct device_attribute *attr,
> +			    const char *buf, size_t len)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	bool accept;
> +	int rc;
> +
> +	rc = kstrtobool(buf, &accept);
> +	if (rc)
> +		return rc;
> +
> +	/*
> +	 * TDISP can only go from RUN to UNLOCKED/ERROR, so there is no
> +	 * 'unaccept' verb.
> +	 */
> +	if (!accept)
> +		return -EINVAL;
> +
> +	rc = pci_tsm_accept(pdev);
> +	if (rc)
> +		return rc;
> +
> +	return len;
> +}
> +
> +static ssize_t accept_show(struct device *dev, struct device_attribute *attr,
> +			   char *buf)
> +{
> +	return sysfs_emit(buf, "%d\n", device_cc_accepted(dev));
> +}
> +static DEVICE_ATTR_RW(accept);
> +
> +/**
> + * pci_tsm_unlock() - Transition TDI from LOCKED/RUN to UNLOCKED
> + * @pdev: TDI device to unlock
> + *
> + * Returns void, requires all callers to have satisfied dependencies like making
> + * sure the device is locked and detached from its driver.
> + */
> +static void pci_tsm_unlock(struct pci_dev *pdev)
> +{
> +	struct pci_tsm_devsec *tsm = to_pci_tsm_devsec(pdev->tsm);
> +
> +	lockdep_assert_held_write(&pci_tsm_rwsem);
> +	lockdep_assert_held(&pdev->dev.mutex);
> +
> +	if (dev_WARN_ONCE(&pdev->dev, pdev->dev.driver,
> +			  "unlock attempted on driver attached device\n"))
> +		return;
> +
> +	free_encrypted_resources(tsm->resource);
> +	device_cc_reject(&pdev->dev);
> +	pdev->tsm->ops->unlock(pdev);
> +	pdev->tsm = NULL;
> +}
> +
> +static int pci_tsm_lock(struct pci_dev *pdev, struct tsm_dev *tsm_dev)
> +{
> +	const struct pci_tsm_ops *ops = tsm_pci_ops(tsm_dev);
> +	struct pci_tsm *tsm;
> +	int rc;
> +
> +	ACQUIRE(device_intr, lock)(&pdev->dev);
> +	if ((rc = ACQUIRE_ERR(device_intr, &lock)))
> +		return rc;
> +
> +	if (pdev->dev.driver)
> +		return -EBUSY;
> +
> +	tsm = ops->lock(pdev);
> +	if (IS_ERR(tsm))
> +		return PTR_ERR(tsm);
> +
> +	pdev->tsm = tsm;
> +	return 0;
> +}
> +
> +static ssize_t lock_store(struct device *dev, struct device_attribute *attr,
> +			  const char *buf, size_t len)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	struct tsm_dev *tsm_dev;
> +	int rc, id;
> +
> +	rc = sscanf(buf, "tsm%d\n", &id);
> +	if (rc != 1)
> +		return -EINVAL;
> +
> +	ACQUIRE(rwsem_write_kill, lock)(&pci_tsm_rwsem);
> +	if ((rc = ACQUIRE_ERR(rwsem_write_kill, &lock)))
> +		return rc;
> +
> +	if (pdev->tsm)
> +		return -EBUSY;
> +
> +	tsm_dev = find_tsm_dev(id);
> +	if (!is_devsec_tsm(tsm_dev))
> +		return -ENXIO;
> +
> +	rc = pci_tsm_lock(pdev, tsm_dev);
> +	if (rc)
> +		return rc;
> +	return len;
> +}
> +
> +static ssize_t lock_show(struct device *dev, struct device_attribute *attr,
> +			 char *buf)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	int rc;
> +
> +	ACQUIRE(rwsem_read_intr, lock)(&pci_tsm_rwsem);
> +	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &lock)))
> +		return rc;
> +
> +	if (!pdev->tsm)
> +		return sysfs_emit(buf, "\n");
> +
> +	return sysfs_emit(buf, "%s\n", tsm_name(pdev->tsm->ops->owner));
> +}
> +static DEVICE_ATTR_RW(lock);
> +
> +static ssize_t unlock_store(struct device *dev, struct device_attribute *attr,
> +			  const char *buf, size_t len)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	const struct pci_tsm_ops *ops;
> +	int rc;
> +
> +	ACQUIRE(rwsem_write_kill, lock)(&pci_tsm_rwsem);
> +	if ((rc = ACQUIRE_ERR(rwsem_write_kill, &lock)))
> +		return rc;
> +
> +	if (!pdev->tsm)
> +		return -EINVAL;
> +
> +	ops = pdev->tsm->ops;
> +	if (!sysfs_streq(buf, tsm_name(ops->owner)))
> +		return -EINVAL;
> +
> +	ACQUIRE(device_intr, dev_lock)(&pdev->dev);
> +	if ((rc = ACQUIRE_ERR(device_intr, &dev_lock)))
> +		return rc;
> +
> +	if (pdev->dev.driver)
> +		return -EBUSY;
> +
> +	pci_tsm_unlock(pdev);
> +
> +	return len;
> +}
> +static DEVICE_ATTR_WO(unlock);
> +
>  /* The 'authenticated' attribute is exclusive to the presence of a 'link' TSM */
>  static bool pci_tsm_link_group_visible(struct kobject *kobj)
>  {
> @@ -462,6 +745,13 @@ static bool pci_tsm_link_group_visible(struct kobject *kobj)
>  }
>  DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE(pci_tsm_link);
>  
> +static bool pci_tsm_devsec_group_visible(struct kobject *kobj)
> +{
> +	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
> +
> +	return pci_tsm_devsec_count && has_tee(pdev);
> +}
> +
>  /*
>   * 'link' and 'devsec' TSMs share the same 'tsm/' sysfs group, so the TSM type
>   * specific attributes need individual visibility checks.
> @@ -475,18 +765,29 @@ static umode_t pci_tsm_attr_visible(struct kobject *kobj,
>  			return attr->mode;
>  	}
>  
> +	if (pci_tsm_devsec_group_visible(kobj)) {
> +		if (attr == &dev_attr_accept.attr ||
> +		    attr == &dev_attr_lock.attr ||
> +		    attr == &dev_attr_unlock.attr)
> +			return attr->mode;
> +	}
> +
>  	return 0;
>  }
>  
>  static bool pci_tsm_group_visible(struct kobject *kobj)
>  {
> -	return pci_tsm_link_group_visible(kobj);
> +	return pci_tsm_link_group_visible(kobj) ||
> +	       pci_tsm_devsec_group_visible(kobj);
>  }
>  DEFINE_SYSFS_GROUP_VISIBLE(pci_tsm);
>  
>  static struct attribute *pci_tsm_attrs[] = {
>  	&dev_attr_connect.attr,
>  	&dev_attr_disconnect.attr,
> +	&dev_attr_accept.attr,
> +	&dev_attr_lock.attr,
> +	&dev_attr_unlock.attr,
>  	NULL
>  };
>  
> @@ -598,6 +899,29 @@ int pci_tsm_link_constructor(struct pci_dev *pdev, struct pci_tsm *tsm,
>  }
>  EXPORT_SYMBOL_GPL(pci_tsm_link_constructor);
>  
> +/**
> + * pci_tsm_devsec_constructor() - devsec TSM context initialization
> + * @pdev: The PCI device
> + * @tsm: context to initialize
> + * @ops: PCI devsec operations provided by the TSM
> + */
> +int pci_tsm_devsec_constructor(struct pci_dev *pdev, struct pci_tsm_devsec *tsm,
> +			       const struct pci_tsm_ops *ops)
> +{
> +	struct pci_tsm *pci_tsm = &tsm->base;
> +
> +	if (!is_devsec_tsm(ops->owner))
> +		return -EINVAL;
> +
> +	pci_tsm->dsm = NULL;
> +	pci_tsm->tdi = NULL;
> +	pci_tsm->pdev = pdev;
> +	pci_tsm->ops = ops;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(pci_tsm_devsec_constructor);
> +
>  /**
>   * pci_tsm_pf0_constructor() - common 'struct pci_tsm_pf0' (DSM) initialization
>   * @pdev: Physical Function 0 PCI device (as indicated by is_pci_tsm_pf0())
> @@ -637,6 +961,13 @@ static void pf0_sysfs_enable(struct pci_dev *pdev)
>  	sysfs_update_group(&pdev->dev.kobj, &pci_tsm_attr_group);
>  }
>  
> +static void devsec_sysfs_enable(struct pci_dev *pdev)
> +{
> +	pci_dbg(pdev, "TEE I/O Device capability detected (TDISP)\n");
> +
> +	sysfs_update_group(&pdev->dev.kobj, &pci_tsm_attr_group);
> +}
> +
>  int pci_tsm_register(struct tsm_dev *tsm_dev)
>  {
>  	struct pci_dev *pdev = NULL;
> @@ -664,8 +995,10 @@ int pci_tsm_register(struct tsm_dev *tsm_dev)
>  		for_each_pci_dev(pdev)
>  			if (is_pci_tsm_pf0(pdev))
>  				pf0_sysfs_enable(pdev);
> -	} else if (is_devsec_tsm(tsm_dev)) {
> -		pci_tsm_devsec_count++;
> +	} else if (is_devsec_tsm(tsm_dev) && pci_tsm_devsec_count++ == 0) {
> +		for_each_pci_dev(pdev)
> +			if (has_tee(pdev))
> +				devsec_sysfs_enable(pdev);
>  	}
>  
>  	return 0;
> @@ -693,6 +1026,9 @@ static void __pci_tsm_destroy(struct pci_dev *pdev, struct tsm_dev *tsm_dev)
>  		sysfs_update_group(&pdev->dev.kobj, &pci_tsm_attr_group);
>  	}
>  
> +	if (is_devsec_tsm(tsm_dev) && !pci_tsm_devsec_count)
> +		sysfs_update_group(&pdev->dev.kobj, &pci_tsm_attr_group);
> +
>  	if (!tsm)
>  		return;
>  
> @@ -701,10 +1037,18 @@ static void __pci_tsm_destroy(struct pci_dev *pdev, struct tsm_dev *tsm_dev)
>  	else if (tsm_dev != tsm->ops->owner)
>  		return;
>  
> -	if (is_link_tsm(tsm_dev) && is_pci_tsm_pf0(pdev))
> -		pci_tsm_disconnect(pdev);
> -	else
> -		tsm_remove(pdev->tsm);
> +	/* Disconnect DSMs, unlock assigned TDIs, or cleanup DSM subfunctions */
> +	if (is_link_tsm(tsm_dev)) {
> +		if (is_pci_tsm_pf0(pdev))
> +			pci_tsm_disconnect(pdev);
> +		else
> +			tsm_remove(pdev->tsm);
> +	}
> +
> +	if (is_devsec_tsm(tsm_dev) && has_tee(pdev)) {
> +		guard(device)(&pdev->dev);
> +		pci_tsm_unlock(pdev);
> +	}
>  }
>  
>  void pci_tsm_destroy(struct pci_dev *pdev)
> diff --git a/drivers/virt/coco/tsm-core.c b/drivers/virt/coco/tsm-core.c
> index f5bab1a9c617..488df6d396a0 100644
> --- a/drivers/virt/coco/tsm-core.c
> +++ b/drivers/virt/coco/tsm-core.c
> @@ -66,6 +66,45 @@ static struct tsm_dev *alloc_tsm_dev(struct device *parent)
>  	return no_free_ptr(tsm_dev);
>  }
>  
> +static ssize_t pci_mode_show(struct device *dev, struct device_attribute *attr,
> +			     char *buf)
> +{
> +	struct tsm_dev *tsm_dev = container_of(dev, struct tsm_dev, dev);
> +	const struct pci_tsm_ops *ops = tsm_dev->pci_ops;
> +
> +	if (ops->connect)
> +		return sysfs_emit(buf, "link\n");
> +	if (ops->lock)
> +		return sysfs_emit(buf, "devsec\n");
> +	return sysfs_emit(buf, "none\n");
> +}
> +static DEVICE_ATTR_RO(pci_mode);
> +
> +static umode_t tsm_pci_visible(struct kobject *kobj, struct attribute *attr, int n)
> +{
> +	struct device *dev = container_of(kobj, struct device, kobj);
> +	struct tsm_dev *tsm_dev = container_of(dev, struct tsm_dev, dev);
> +
> +	if (tsm_dev->pci_ops)
> +		return attr->mode;
> +	return 0;
> +}
> +
> +static struct attribute *tsm_pci_attrs[] = {
> +	&dev_attr_pci_mode.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group tsm_pci_group = {
> +	.attrs = tsm_pci_attrs,
> +	.is_visible = tsm_pci_visible,
> +};
> +
> +static const struct attribute_group *tsm_pci_groups[] = {
> +	&tsm_pci_group,
> +	NULL
> +};
> +
>  static struct tsm_dev *tsm_register_pci_or_reset(struct tsm_dev *tsm_dev,
>  						 struct pci_tsm_ops *pci_ops)
>  {
> @@ -83,6 +122,7 @@ static struct tsm_dev *tsm_register_pci_or_reset(struct tsm_dev *tsm_dev,
>  		device_unregister(&tsm_dev->dev);
>  		return ERR_PTR(rc);
>  	}
> +	sysfs_update_group(&tsm_dev->dev.kobj, &tsm_pci_group);
>  
>  	/* Notify TSM userspace that PCI/TSM operations are now possible */
>  	kobject_uevent(&tsm_dev->dev.kobj, KOBJ_CHANGE);
> @@ -168,6 +208,7 @@ static int __init tsm_init(void)
>  	if (IS_ERR(tsm_class))
>  		return PTR_ERR(tsm_class);
>  
> +	tsm_class->dev_groups = tsm_pci_groups;
>  	tsm_class->dev_release = tsm_release;
>  	return 0;
>  }
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 43d072866949..764461e9effb 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -927,6 +927,7 @@ static inline void device_unlock(struct device *dev)
>  }
>  
>  DEFINE_GUARD(device, struct device *, device_lock(_T), device_unlock(_T))
> +DEFINE_GUARD_COND(device, _intr, device_lock_interruptible(_T), _RET == 0)
>  
>  static inline void device_lock_assert(struct device *dev)
>  {
> diff --git a/include/linux/pci-tsm.h b/include/linux/pci-tsm.h
> index 5b61aac2e9f7..37fafbfce386 100644
> --- a/include/linux/pci-tsm.h
> +++ b/include/linux/pci-tsm.h
> @@ -60,13 +60,17 @@ struct pci_tsm_ops {
>  	 * struct pci_tsm_security_ops - Manage the security state of the function
>  	 * @lock: probe and initialize the device in the LOCKED state
>  	 * @unlock: destroy TSM context and return device to UNLOCKED state
> +	 * @accept: accept a locked TDI for use, move it to RUN state
>  	 *
>  	 * Context: @lock and @unlock run under pci_tsm_rwsem held for write to
> -	 * sync with TSM unregistration and each other
> +	 * sync with TSM unregistration and each other. @accept runs under
> +	 * pci_tsm_rwsem held for read. All operations run under the device lock
> +	 * for mutual exclusion with driver attach and detach.
>  	 */
>  	struct_group_tagged(pci_tsm_security_ops, devsec_ops,
>  		struct pci_tsm *(*lock)(struct pci_dev *pdev);
>  		void (*unlock)(struct pci_dev *pdev);
> +		int (*accept)(struct pci_dev *pdev);
>  	);
>  	struct tsm_dev *owner;
>  };
> @@ -97,6 +101,13 @@ struct pci_tdi {
>   * sub-function (SR-IOV virtual function, or non-function0
>   * multifunction-device), or a downstream endpoint (PCIe upstream switch-port as
>   * DSM).
> + *
> + * For devsec operations it serves to indicate that the function / TDI has been
> + * locked to a given TSM.
> + *
> + * The common expectation is that there is only ever one TSM, but this is not
> + * enforced. The implementation only enforces that a device can be "connected"
> + * to a TSM instance or "locked" to a different TSM.
>   */
>  struct pci_tsm {
>  	struct pci_dev *pdev;
> @@ -117,6 +128,16 @@ struct pci_tsm_pf0 {
>  	struct pci_doe_mb *doe_mb;
>  };
>  
> +/**
> + * struct pci_tsm_devsec - context for tracking private/accepted PCI resources
> + * @base: generic core "tsm" context
> + * @resource: encrypted MMIO resources for this assigned device
> + */
> +struct pci_tsm_devsec {
> +	struct pci_tsm base;
> +	struct resource *resource[PCI_NUM_RESOURCES];
> +};
> +
>  /* physical function0 and capable of 'connect' */
>  static inline bool is_pci_tsm_pf0(struct pci_dev *pdev)
>  {
> @@ -193,6 +214,8 @@ int pci_tsm_link_constructor(struct pci_dev *pdev, struct pci_tsm *tsm,
>  			     const struct pci_tsm_ops *ops);
>  int pci_tsm_pf0_constructor(struct pci_dev *pdev, struct pci_tsm_pf0 *tsm,
>  			    const struct pci_tsm_ops *ops);
> +int pci_tsm_devsec_constructor(struct pci_dev *pdev, struct pci_tsm_devsec *tsm,
> +			       const struct pci_tsm_ops *ops);
>  void pci_tsm_pf0_destructor(struct pci_tsm_pf0 *tsm);
>  int pci_tsm_bind(struct pci_dev *pdev, struct kvm *kvm, u32 tdi_id);
>  void pci_tsm_unbind(struct pci_dev *pdev);
> -- 
> 2.50.1

