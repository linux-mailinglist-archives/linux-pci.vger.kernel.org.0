Return-Path: <linux-pci+bounces-39668-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E55CCC1C52A
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 18:02:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F182805093
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 15:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6B1345CAF;
	Wed, 29 Oct 2025 15:53:12 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19593348882
	for <linux-pci@vger.kernel.org>; Wed, 29 Oct 2025 15:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761753192; cv=none; b=fzYkRy65+PQ+7Swkxwi4rQyxU6PuOWTvs7/QoLZp443sxs+Z5eIvCHxjDvK+pU4+pUh6uiFhL8ZSdGxWYtdBriKF1tBK82nPmIiJy/yMZkXLCA027SI7x2AaVMvP30d4oNLeJHEV2t+D2gPyMvw22jRgD1o8/nV1rb0MZPNefKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761753192; c=relaxed/simple;
	bh=GXyHcijDIwhDfbtb13z2Z7TFAHIg9SK0o+juXHHhxQ8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uBGk0SZTXKk30hx5msf3WGCf9fNCkBv/7d13YxgAcZuuadrB5YRq4wmWwxU24+6dg0f+U6qVccBZNQMCmbzqAlxm1rXjLGTFfx0p9b6zBHc4xfSoX35Pp6NbOm5h9r/Yp5UkLGx1YVcEGHrUdnf1eg+lHIQmlQOVWJIBvT1Kmcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4cxWvx2DXBzHnGfT;
	Wed, 29 Oct 2025 15:52:13 +0000 (UTC)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 1B7D6140370;
	Wed, 29 Oct 2025 23:53:06 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 29 Oct
 2025 15:53:05 +0000
Date: Wed, 29 Oct 2025 15:53:03 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>, <aik@amd.com>,
	<yilun.xu@linux.intel.com>, <aneesh.kumar@kernel.org>, <bhelgaas@google.com>,
	<gregkh@linuxfoundation.org>, Lukas Wunner <lukas@wunner.de>, Samuel Ortiz
	<sameo@rivosinc.com>
Subject: Re: [PATCH v7 4/9] PCI/TSM: Establish Secure Sessions and Link
 Encryption
Message-ID: <20251029155303.00001e88@huawei.com>
In-Reply-To: <20251024020418.1366664-5-dan.j.williams@intel.com>
References: <20251024020418.1366664-1-dan.j.williams@intel.com>
	<20251024020418.1366664-5-dan.j.williams@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Thu, 23 Oct 2025 19:04:13 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> The PCIe 7.0 specification, section 11, defines the Trusted Execution
> Environment (TEE) Device Interface Security Protocol (TDISP).  This
> protocol definition builds upon Component Measurement and Authentication
> (CMA), and link Integrity and Data Encryption (IDE). It adds support for
> assigning devices (PCI physical or virtual function) to a confidential VM
> such that the assigned device is enabled to access guest private memory
> protected by technologies like Intel TDX, AMD SEV-SNP, RISCV COVE, or ARM
> CCA.
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
> two mutually exclusive operation sets, "Link" and "Security" (struct
> pci_tsm_{link,security}_ops). The "Link" operations manage physical link
> security properties and communication with the device's Device Security
> Manager firmware. These are the host side operations in TDISP. The
> "Security" operations coordinate the security state of the assigned
> virtual device (TDI). These are the guest side operations in TDISP.
> 
> Only "link", Secure Session and physical Link Encryption, operations are
> defined at this stage with placeholders for the device security, Trusted
> Computing Base entry / exit, operations.

That list probably needs an 'and'

> 
> The locking allows for multiple devices to be executing commands
> simultaneously, one outstanding command per-device and an rwsem
> synchronizes the implementation relative to TSM registration/unregistration
> events.
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

Some comments on comments/documentation inline.  With those addressed
(which should be straight forward)
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> diff --git a/include/linux/pci-tsm.h b/include/linux/pci-tsm.h
> new file mode 100644
> index 000000000000..e3107ede2a0f
> --- /dev/null
> +++ b/include/linux/pci-tsm.h
> @@ -0,0 +1,159 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __PCI_TSM_H
> +#define __PCI_TSM_H
> +#include <linux/mutex.h>
> +#include <linux/pci.h>
> +
> +struct pci_tsm;
See below for note on a duplicate of this.

> +struct tsm_dev;
> +
> +/*
> + * struct pci_tsm_ops - manage confidential links and security state
> + * @link_ops: Coordinate PCIe SPDM and IDE establishment via a platform TSM.
> + *	      Provide a secure session transport for TDISP state management
> + *	      (typically bare metal physical function operations).
> + * @sec_ops: Lock, unlock, and interrogate the security state of the

devsec_ops?

> + *	     function via the platform TSM (typically virtual function
> + *	     operations).
> + * @owner: Back reference to the TSM device that owns this instance.
Not seeing this below.

> + *
> + * This operations are mutually exclusive either a tsm_dev instance
> + * manages physical link properties or it manages function security
> + * states like TDISP lock/unlock.
> + */
> +struct pci_tsm_ops {
> +	/*
> +	 * struct pci_tsm_link_ops - Manage physical link and the TSM/DSM session
> +	 * @probe: establish context with the TSM (allocate / wrap 'struct
> +	 *	   pci_tsm') for follow-on link operations
> +	 * @remove: destroy link operations context
> +	 * @connect: establish / validate a secure connection (e.g. IDE)
> +	 *	     with the device
> +	 * @disconnect: teardown the secure link
> +	 *
> +	 * Context: @probe, @remove, @connect, and @disconnect run under
> +	 * pci_tsm_rwsem held for write to sync with TSM unregistration and
> +	 * mutual exclusion of @connect and @disconnect. @connect and
> +	 * @disconnect additionally run under the DSM lock (struct
> +	 * pci_tsm_pf0::lock) as well as @probe and @remove of the subfunctions.
> +	 */
> +	struct_group_tagged(pci_tsm_link_ops, link_ops,
> +		struct pci_tsm *(*probe)(struct tsm_dev *tsm_dev,
> +					 struct pci_dev *pdev);
> +		void (*remove)(struct pci_tsm *tsm);
> +		int (*connect)(struct pci_dev *pdev);
> +		void (*disconnect)(struct pci_dev *pdev);
> +	);
> +
> +	/*
> +	 * struct pci_tsm_devsec_ops - Manage the security state of the function
> +	 * @lock: establish context with the TSM (allocate / wrap 'struct
> +	 *	  pci_tsm') for follow-on security state transitions from the
> +	 *	  LOCKED state
> +	 * @unlock: destroy TSM context and return device to UNLOCKED state
> +	 *
> +	 * Context: @lock and @unlock run under pci_tsm_rwsem held for write to
> +	 * sync with TSM unregistration and each other
> +	 */
> +	struct_group_tagged(pci_tsm_devsec_ops, devsec_ops,
> +		struct pci_tsm *(*lock)(struct tsm_dev *tsm_dev,
> +					struct pci_dev *pdev);
> +		void (*unlock)(struct pci_tsm *tsm);
> +	);
> +};


> +#ifdef CONFIG_PCI_TSM
> +struct tsm_dev;

Seems to be declared already (not under an ifdef) above.

> +int pci_tsm_register(struct tsm_dev *tsm_dev);
...


> diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
> new file mode 100644
> index 000000000000..094650454aa7
> --- /dev/null
> +++ b/drivers/pci/tsm.c

> +static int pci_tsm_connect(struct pci_dev *pdev, struct tsm_dev *tsm_dev)
> +{
> +	int rc;
> +	struct pci_tsm_pf0 *tsm_pf0;
> +	const struct pci_tsm_ops *ops = tsm_dev->pci_ops;
> +	struct pci_tsm *pci_tsm __free(tsm_remove) = ops->probe(tsm_dev, pdev);
> +
> +	/* connect()  mutually exclusive with subfunction pci_tsm_init() */

Extra space after ()

> +	lockdep_assert_held_write(&pci_tsm_rwsem);
> +
> +	if (!pci_tsm)
> +		return -ENXIO;
> +
> +	pdev->tsm = pci_tsm;
> +	tsm_pf0 = to_pci_tsm_pf0(pdev->tsm);
> +
> +	/* mutex_intr assumes connect() is always sysfs/user driven */
> +	ACQUIRE(mutex_intr, lock)(&tsm_pf0->lock);
> +	if ((rc = ACQUIRE_ERR(mutex_intr, &lock)))
> +		return rc;
> +
> +	rc = ops->connect(pdev);
> +	if (rc)
> +		return rc;
> +
> +	pdev->tsm = no_free_ptr(pci_tsm);
> +
> +	/*
> +	 * Now that the DSM is established, probe() all the potential
> +	 * dependent functions. Failure to probe a function is not fatal
> +	 * to connect(), it just disables subsequent security operations
> +	 * for that function.
> +	 *
> +	 * Note this is done unconditionally, without regard to finding
> +	 * PCI_EXP_DEVCAP_TEE on the dependent function, for robustness. The DSM
> +	 * is the ultimate arbiter of security state relative to a given
> +	 * interface id, and if it says it can manage TDISP state of a function,
> +	 * let it.
> +	 */
> +	if (has_tee(pdev))
> +		pci_tsm_walk_fns(pdev, probe_fn, pdev);
> +	return 0;
> +}



> +/*
> + * Find the PCI Device instance that serves as the Device Security Manager (DSM)
> + * for @pdev. Note that no additional reference is held for the resulting device
> + * because @pdev always has a longer registered lifetime than its DSM by virtue
> + * of being a child of, or identical to, its DSM.

This comment has me confused.  I would normally expect parent to have the guaranteed
longer life span than the child. This seems to say the opposite.
Code itself is fine.


> + */
> +static struct pci_dev *find_dsm_dev(struct pci_dev *pdev)
> +{
> +	struct device *grandparent;
> +	struct pci_dev *uport;
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
> +
> +	/*
> +	 * For cases where a switch may be hosting TDISP services on behalf of
> +	 * downstream devices, check the first upstream port relative to this
> +	 * endpoint.
> +	 */
> +	if (!pdev->dev.parent)
> +		return NULL;
> +	grandparent = pdev->dev.parent->parent;
> +	if (!grandparent)
> +		return NULL;
> +	if (!dev_is_pci(grandparent))
> +		return NULL;
> +	uport = to_pci_dev(grandparent);
> +	if (!pci_is_pcie(uport) ||
> +	    pci_pcie_type(uport) != PCI_EXP_TYPE_UPSTREAM)
> +		return NULL;
> +
> +	if (is_dsm(uport))
> +		return uport;
> +	return NULL;
> +}



