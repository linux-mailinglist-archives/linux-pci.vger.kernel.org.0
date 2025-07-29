Return-Path: <linux-pci+bounces-33121-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98ADAB14FB1
	for <lists+linux-pci@lfdr.de>; Tue, 29 Jul 2025 16:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB0123A4936
	for <lists+linux-pci@lfdr.de>; Tue, 29 Jul 2025 14:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239F81F1505;
	Tue, 29 Jul 2025 14:57:00 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E367149C4D;
	Tue, 29 Jul 2025 14:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753801020; cv=none; b=f5F+kAbd5iLfQUDGpJEzAdFRIRUHDaqO81kckqqPicloZib7/t8/hhpGV/Y5pdbqmlsCc9Q/YLbx60aKqsxu9CM22xCkxnREc4u/+SNbG9jYQQFa0kVeqa0GbHpClFpFS1idK9Oyh2pVXn6vPi1+H+zl3DI9XLM3VH8vYJP2JqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753801020; c=relaxed/simple;
	bh=jQzpdSmc/8gT5ATyfvBg5LQS2Mv/4J8m7uih6NQQ5T8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lWxRmX0ugiBt0fSO2kPk/7rTKu6PgoVWiSZ74FVoop6CwcX7pCm8WjxWkSzQNsH3UWzByeUeV1AimKfYfdGL0zRhvdlDJkpWINYyM1JPetOFxOmOCW2Mk+qJ+H3Ztgf6vLe2hdejzPI0u1jucwtXljYZTJpBYfqa4qc72YEz7NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4brz0N16vwz6L5Pd;
	Tue, 29 Jul 2025 22:55:00 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id E85C4140446;
	Tue, 29 Jul 2025 22:56:52 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 29 Jul
 2025 16:56:52 +0200
Date: Tue, 29 Jul 2025 15:56:50 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bhelgaas@google.com>, <aik@amd.com>,
	<lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>, Xu Yilun
	<yilun.xu@linux.intel.com>
Subject: Re: [PATCH v4 04/10] PCI/TSM: Authenticate devices via platform TSM
Message-ID: <20250729155650.000017b3@huawei.com>
In-Reply-To: <20250717183358.1332417-5-dan.j.williams@intel.com>
References: <20250717183358.1332417-1-dan.j.williams@intel.com>
	<20250717183358.1332417-5-dan.j.williams@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 17 Jul 2025 11:33:52 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> The PCIe 6.1 specification, section 11, introduces the Trusted Execution
> Environment (TEE) Device Interface Security Protocol (TDISP).  This
> protocol definition builds upon Component Measurement and Authentication
> (CMA), and link Integrity and Data Encryption (IDE). It adds support for
> assigning devices (PCI physical or virtual function) to a confidential
> VM such that the assigned device is enabled to access guest private
> memory protected by technologies like Intel TDX, AMD SEV-SNP, RISCV
> COVE, or ARM CCA.
> 
> The "TSM" (TEE Security Manager) is a concept in the TDISP specification
> of an agent that mediates between a "DSM" (Device Security Manager) and
> system software in both a VMM and a confidential VM. A VMM uses TSM ABIs
> to setup link security and assign devices. A confidential VM uses TSM
> ABIs to transition an assigned device into the TDISP "RUN" state and
> validate its configuration. From a Linux perspective the TSM abstracts
> many of the details of TDISP, IDE, and CMA. Some of those details leak
> through at times, but for the most part TDISP is an internal
> implementation detail of the TSM.
> 
> CONFIG_PCI_TSM adds an "authenticated" attribute and "tsm/" subdirectory
> to pci-sysfs. Consider that the TSM driver may itself be a PCI driver.
> Userspace can watch for the arrival of a "TSM" device,
> /sys/class/tsm/tsm0/uevent KOBJ_CHANGE, to know when the PCI core has
> initialized TSM services.
> 
> The operations that can be executed against a PCI device are split into
> 2 mutually exclusive operation sets, "Link" and "Security" (struct
> pci_tsm_{link,security}_ops). The "Link" operations manage physical link
> security properties and communication with the device's Device Security
> Manager firmware. These are the host side operations in TDISP. The
> "Security" operations coordinate the security state of the assigned
> virtual device (TDI). These are the guest side operations in TDISP. Only
> link management operations are defined at this stage and placeholders
> provided for the security operations.
> 
> The locking allows for multiple devices to be executing commands
> simultaneously, one outstanding command per-device and an rwsem
> synchronizes the implementation relative to TSM
> registration/unregistration events.
> 
> Thanks to Wu Hao for his work on an early draft of this support.
> 
> Cc: Lukas Wunner <lukas@wunner.de>
> Cc: Samuel Ortiz <sameo@rivosinc.com>
> Cc: Alexey Kardashevskiy <aik@amd.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Co-developed-by: Xu Yilun <yilun.xu@linux.intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Various things inline.

> diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
> new file mode 100644
> index 000000000000..0784cc436dd3
> --- /dev/null
> +++ b/drivers/pci/tsm.c
> @@ -0,0 +1,554 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * TEE Security Manager for the TEE Device Interface Security Protocol
> + * (TDISP, PCIe r6.1 sec 11)
> + *
> + * Copyright(c) 2024 Intel Corporation. All rights reserved.
> + */

> +static void tsm_remove(struct pci_tsm *tsm)
> +{
> +	struct pci_dev *pdev;
> +
> +	if (!tsm)

You protect against this in the DEFINE_FREE() so probably safe
to assume it is always set if we get here.

> +		return;
> +
> +	pdev = tsm->pdev;
> +	tsm->ops->remove(tsm);
> +	pdev->tsm = NULL;
> +}
> +DEFINE_FREE(tsm_remove, struct pci_tsm *, if (_T) tsm_remove(_T))
> +
> +static int call_cb_put(struct pci_dev *pdev, void *data,

Is this combination worth while?  I don't like the 'and' aspect of it
and it only saves a few lines...

vs
	if (pdev) {
		rc = cb(pdev, data);
		pci_dev_put(pdev);
		if (rc)
			return;
	}

> +		       int (*cb)(struct pci_dev *pdev, void *data))
> +{
> +	int rc;
> +
> +	if (!pdev)
> +		return 0;
> +	rc = cb(pdev, data);
> +	pci_dev_put(pdev);
> +	return rc;
> +}
> +
> +static void pci_tsm_walk_fns(struct pci_dev *pdev,
> +			     int (*cb)(struct pci_dev *pdev, void *data),
> +			     void *data)
> +{
> +	struct pci_dev *fn;
> +	int i;
> +
> +	/* walk virtual functions */
> +        for (i = 0; i < pci_num_vf(pdev); i++) {
> +		fn = pci_get_domain_bus_and_slot(pci_domain_nr(pdev->bus),
> +						 pci_iov_virtfn_bus(pdev, i),
> +						 pci_iov_virtfn_devfn(pdev, i));
> +		if (call_cb_put(fn, data, cb))
> +			return;
> +        }
> +
> +	/* walk subordinate physical functions */
> +	for (i = 1; i < 8; i++) {
> +		fn = pci_get_slot(pdev->bus,
> +				  PCI_DEVFN(PCI_SLOT(pdev->devfn), i));
> +		if (call_cb_put(fn, data, cb))
> +			return;
> +	}
> +
> +	/* walk downstream devices */
> +        if (pci_pcie_type(pdev) != PCI_EXP_TYPE_UPSTREAM)

spaces rather than tabs...


> +                return;
> +
> +        if (!is_dsm(pdev))
> +                return;
> +
> +        pci_walk_bus(pdev->subordinate, cb, data);
> +}
> +
> +static void pci_tsm_walk_fns_reverse(struct pci_dev *pdev,
> +				     int (*cb)(struct pci_dev *pdev,
> +					       void *data),
> +				     void *data)
> +{
> +	struct pci_dev *fn;
> +	int i;
> +
> +	/* reverse walk virtual functions */
> +	for (i = pci_num_vf(pdev) - 1; i >= 0; i--) {
> +		fn = pci_get_domain_bus_and_slot(pci_domain_nr(pdev->bus),
> +						 pci_iov_virtfn_bus(pdev, i),
> +						 pci_iov_virtfn_devfn(pdev, i));
> +		if (call_cb_put(fn, data, cb))
> +			return;
> +	}
> +
While it probably doesn't matter can we make this strict reverse by doing
the physical functions first?  I prefer not to think about whether it matters.


> +	/* reverse walk subordinate physical functions */
> +	for (i = 7; i >= 1; i--) {
> +		fn = pci_get_slot(pdev->bus,
> +				  PCI_DEVFN(PCI_SLOT(pdev->devfn), i));
> +		if (call_cb_put(fn, data, cb))
> +			return;
> +	}
> +
> +	/* reverse walk downstream devices */
> +	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_UPSTREAM)
> +		return;
> +
> +	if (!is_dsm(pdev))
> +		return;
> +
> +	pci_walk_bus_reverse(pdev->subordinate, cb, data);

Likewise, can we do this before the rest.

> +}

> +/*
> + * Find the PCI Device instance that serves as the Device Security
> + * Manger (DSM) for @pdev. Note that no additional reference is held for
> + * the resulting device because @pdev always has a longer registered
> + * lifetime than its DSM by virtue of being a child of or identical to
> + * its DSM.
> + */
> +static struct pci_dev *find_dsm_dev(struct pci_dev *pdev)
> +{
> +	struct pci_dev *uport_pf0;
> +
> +	if (is_pci_tsm_pf0(pdev))
> +		return pdev;
> +
> +	struct pci_dev *pf0 __free(pci_dev_put) = pf0_dev_get(pdev);
> +	if (!pf0)
> +		return NULL;
> +
> +	if (is_dsm(pf0))
> +		return pf0;


Unusual for a find command to not hold the device reference on the device
it returns.  Maybe just call that out in the comment.

> +
> +	/*
> +	 * For cases where a switch may be hosting TDISP services on
> +	 * behalf of downstream devices, check the first usptream port
> +	 * relative to this endpoint.
> +         */
Odd alignment. Space rather than tab.


> +	if (!pdev->dev.parent || !pdev->dev.parent->parent)
> +		return NULL;
> +
> +	uport_pf0 = to_pci_dev(pdev->dev.parent->parent);
> +	if (is_dsm(uport_pf0))
> +		return uport_pf0;
> +	return NULL;
> +}


> +/**
> + * pci_tsm_pf0_constructor() - common 'struct pci_tsm_pf0' initialization
> + * @pdev: Physical Function 0 PCI device (as indicated by is_pci_tsm_pf0())
> + * @tsm: context to initialize

ops missing.  Run kernel-doc or do W=1 build to catch these.

> + */
> +int pci_tsm_pf0_constructor(struct pci_dev *pdev, struct pci_tsm_pf0 *tsm,
> +			    const struct pci_tsm_ops *ops)
> +{
> +	struct tsm_dev *tsm_dev = ops->owner;
> +
> +	mutex_init(&tsm->lock);
Might as well do devm_mutex_init()

> +	tsm->doe_mb = pci_find_doe_mailbox(pdev, PCI_VENDOR_ID_PCI_SIG,
> +					   PCI_DOE_PROTO_CMA);
> +	if (!tsm->doe_mb) {
> +		pci_warn(pdev, "TSM init failure, no CMA mailbox\n");
> +		return -ENODEV;
> +	}
> +
> +	if (tsm_pci_group(tsm_dev))
> +		sysfs_merge_group(&pdev->dev.kobj, tsm_pci_group(tsm_dev));
> +
> +	return pci_tsm_constructor(pdev, &tsm->tsm, ops);
> +}
> +EXPORT_SYMBOL_GPL(pci_tsm_pf0_constructor);

> diff --git a/drivers/virt/coco/tsm-core.c b/drivers/virt/coco/tsm-core.c
> index 1f53b9049e2d..093824dc68dd 100644
> --- a/drivers/virt/coco/tsm-core.c
> +++ b/drivers/virt/coco/tsm-core.c

> +/*
> + * Caller responsible for ensuring it does not race tsm_dev
> + * unregistration.
Wrap is a bit early. unregistration fits on the line above.
> + */
> +struct tsm_dev *find_tsm_dev(int id)
> +{
> +	guard(rcu)();
> +	return idr_find(&tsm_idr, id);
> +}

> @@ -44,6 +76,29 @@ static struct tsm_dev *alloc_tsm_dev(struct device *parent,
>  	return no_free_ptr(tsm_dev);
>  }
>  
> +static struct tsm_dev *tsm_register_pci_or_reset(struct tsm_dev *tsm_dev,
> +						 struct pci_tsm_ops *pci_ops)
> +{
> +	int rc;
> +
> +	if (!pci_ops)
> +		return tsm_dev;
> +
> +	pci_ops->owner = tsm_dev;
> +	tsm_dev->pci_ops = pci_ops;
> +	rc = pci_tsm_register(tsm_dev);
> +	if (rc) {
> +		dev_err(tsm_dev->dev.parent,
> +			"PCI/TSM registration failure: %d\n", rc);
> +		device_unregister(&tsm_dev->dev);

As below. I'm fairly sure this device_unregister is nothing to do with
what this function is doing, so having it buried in here is less easy
to follow than pushing it up a layer.

> +		return ERR_PTR(rc);
> +	}
> +
> +	/* Notify TSM userspace that PCI/TSM operations are now possible */
> +	kobject_uevent(&tsm_dev->dev.kobj, KOBJ_CHANGE);
> +	return tsm_dev;
> +}
> +
>  static void put_tsm_dev(struct tsm_dev *tsm_dev)
>  {
>  	if (!IS_ERR_OR_NULL(tsm_dev))
> @@ -54,7 +109,8 @@ DEFINE_FREE(put_tsm_dev, struct tsm_dev *,
>  	    if (!IS_ERR_OR_NULL(_T)) put_tsm_dev(_T))
>  
>  struct tsm_dev *tsm_register(struct device *parent,
> -			     const struct attribute_group **groups)
> +			     const struct attribute_group **groups,
> +			     struct pci_tsm_ops *pci_ops)
>  {
>  	struct tsm_dev *tsm_dev __free(put_tsm_dev) =
>  		alloc_tsm_dev(parent, groups);
> @@ -73,12 +129,13 @@ struct tsm_dev *tsm_register(struct device *parent,
>  	if (rc)
>  		return ERR_PTR(rc);
>  
> -	return no_free_ptr(tsm_dev);
> +	return tsm_register_pci_or_reset(no_free_ptr(tsm_dev), pci_ops);

Having a function call that either succeeds or cleans up something it
never did on error is odd.  The or_reset hints at that oddity but
to me is not enough. If you want to use __free magic in here
maybe hand off the tsm_dev on succesful device registration.

	struct tsm_dev *registered_tsm_dev __free(unregister_tsm_dev) =
		no_free_ptr(tsm_dev);

	rc = tsm_register_pci(registered_tsm_dev, pci_ops);
	//change return type as no need for another tsm_dev
	if (rc)
		return ERR_PTR(rc);

	return no_free_ptr(registered_tsm_dev);
	

>  }
>  EXPORT_SYMBOL_GPL(tsm_register);
>  
>  void tsm_unregister(struct tsm_dev *tsm_dev)
>  {
> +	pci_tsm_unregister(tsm_dev);
>  	device_unregister(&tsm_dev->dev);
>  }
>  EXPORT_SYMBOL_GPL(tsm_unregister);
> diff --git a/include/linux/pci-tsm.h b/include/linux/pci-tsm.h
> new file mode 100644
> index 000000000000..f370c022fac4
> --- /dev/null
> +++ b/include/linux/pci-tsm.h
> @@ -0,0 +1,158 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __PCI_TSM_H
> +#define __PCI_TSM_H
> +#include <linux/mutex.h>
> +#include <linux/pci.h>
> +
> +struct pci_tsm;
> +
> +/*

/**

Or was this intentional? Feels like it should be kernel-doc. 

> + * struct pci_tsm_ops - manage confidential links and security state
> + * @link_ops: Coordinate PCIe SPDM and IDE establishment via a platform TSM.
> + * 	      Provide a secure session transport for TDISP state management
> + * 	      (typically bare metal physical function operations).
> + * @sec_ops: Lock, unlock, and interrogate the security state of the
> + *	     function via the platform TSM (typically virtual function
> + *	     operations).
> + * @owner: Back reference to the TSM device that owns this instance.
> + *
> + * This operations are mutually exclusive either a tsm_dev instance
> + * manages phyiscal link properties or it manages function security
> + * states like TDISP lock/unlock.
> + */
> +struct pci_tsm_ops {
> +	/*
Likewise though I'm not sure if kernel-doc deals with struct groups.

> +	 * struct pci_tsm_link_ops - Manage physical link and the TSM/DSM session
> +	 * @probe: probe device for tsm link operation readiness, setup
> +	 *	   DSM context
> +	 * @remove: destroy DSM context
> +	 * @connect: establish / validate a secure connection (e.g. IDE)
> +	 *	     with the device
> +	 * @disconnect: teardown the secure link
> +	 *
> +	 * @probe and @remove run in pci_tsm_rwsem held for write context. All
> +	 * other ops run under the @pdev->tsm->lock mutex and pci_tsm_rwsem held
> +	 * for read.
> +	 */
> +	struct_group_tagged(pci_tsm_link_ops, link_ops,
> +		struct pci_tsm *(*probe)(struct pci_dev *pdev);
> +		void (*remove)(struct pci_tsm *tsm);
> +		int (*connect)(struct pci_dev *pdev);
> +		void (*disconnect)(struct pci_dev *pdev);
> +	);
> +
> +	/*
> +	 * struct pci_tsm_security_ops - Manage the security state of the function
> +	 * @sec_probe: probe device for tsm security operation
> +	 *	       readiness, setup security context
> +	 * @sec_remove: destroy security context
> +	 *
> +	 * @sec_probe and @sec_remove run in pci_tsm_rwsem held for
> +	 * write context. All other ops run under the @pdev->tsm->lock
> +	 * mutex and pci_tsm_rwsem held for read.
> +	 */
> +	struct_group_tagged(pci_tsm_security_ops, ops,
> +		struct pci_tsm *(*sec_probe)(struct pci_dev *pdev);
> +		void (*sec_remove)(struct pci_tsm *tsm);
> +	);
> +	struct tsm_dev *owner;
> +};

> +
> +/**
> + * struct pci_tsm_pf0 - Physical Function 0 TDISP link context
> + * @tsm: generic core "tsm" context
> + * @lock: protect @state vs pci_tsm_ops invocation

What is @state referring to? 

> + * @doe_mb: PCIe Data Object Exchange mailbox
> + */
> +struct pci_tsm_pf0 {
> +	struct pci_tsm tsm;
> +	struct mutex lock;
> +	struct pci_doe_mb *doe_mb;
> +};



