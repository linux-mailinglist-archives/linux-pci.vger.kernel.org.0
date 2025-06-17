Return-Path: <linux-pci+bounces-29922-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D193FADCC03
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jun 2025 14:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71E3D188DB67
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jun 2025 12:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8F62E06C8;
	Tue, 17 Jun 2025 12:51:56 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99882E06D5
	for <linux-pci@vger.kernel.org>; Tue, 17 Jun 2025 12:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750164716; cv=none; b=hndvA0tENrdudPlM0kAPXjaB6BkVx+rH8p5gdUxCFVHEAvoieX6XKRSSm17JoAqerzF4iimr7qEeHGaUoI5MkORxrUznHJHV5w8vPEwa4Nbfow4O/HpHTdo7lHeiwNhH9VhWcV70I9SN9/aTUYxP+QZ/zSAxh+OPqTK54EZ9AW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750164716; c=relaxed/simple;
	bh=QtwWmK+p4McsZdRD3E4M9iqX49HsHThBHNIB1qYJ2lo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OygzVrF/B+/vwOTD1C2gJztUKVQLJfpeNj083qHBXeHYf/czA+v4D+0wUAiDGrWOv5AvvAgnSdUQoJ9LxdBHlagvzP1q4aJWOt38r/zDWLcOkxFKbLdbv5F50UUn4OwhhasK3jGOJIamqG5Sm1fT37EpeLR1/dF7WhSqjyFPdSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bM6F04zD5z6M4p5;
	Tue, 17 Jun 2025 20:51:16 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 594C0140119;
	Tue, 17 Jun 2025 20:51:50 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 17 Jun
 2025 14:51:49 +0200
Date: Tue, 17 Jun 2025 13:51:45 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<gregkh@linuxfoundation.org>, <lukas@wunner.de>, <aneesh.kumar@kernel.org>,
	<suzuki.poulose@arm.com>, <sameo@rivosinc.com>, <aik@amd.com>,
	<jgg@nvidia.com>, <zhiw@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>, Xu
 Yilun <yilun.xu@linux.intel.com>
Subject: Re: [PATCH v3 03/13] PCI/TSM: Authenticate devices via platform TSM
Message-ID: <20250617135145.0000376b@huawei.com>
In-Reply-To: <20250516054732.2055093-4-dan.j.williams@intel.com>
References: <20250516054732.2055093-1-dan.j.williams@intel.com>
	<20250516054732.2055093-4-dan.j.williams@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 15 May 2025 22:47:22 -0700
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
> Userspace can watch for the arrival of the "TSM" core device,
> /sys/class/tsm/tsm0/uevent, to know when the PCI core has initialized
> TSM services.
> 
> The common verbs that the low-level TSM drivers implement are defined by
> 'struct pci_tsm_ops'. For now only 'connect' and 'disconnect' are
> defined for secure session and IDE establishment. The 'probe' and
> 'remove' operations setup per-device context objects starting with
> 'struct pci_tsm_pf0', the device Physical Function 0 that mediates
> communication to the device's Security Manager (DSM).
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
Trivial stuff on this one. See inline.

Jonathan

> ---
>  Documentation/ABI/testing/sysfs-bus-pci |  45 +++
>  MAINTAINERS                             |   2 +
>  drivers/pci/Kconfig                     |  14 +
>  drivers/pci/Makefile                    |   1 +
>  drivers/pci/pci-sysfs.c                 |   4 +
>  drivers/pci/pci.h                       |  10 +
>  drivers/pci/probe.c                     |   1 +
>  drivers/pci/remove.c                    |   3 +
>  drivers/pci/tsm.c                       | 437 ++++++++++++++++++++++++
>  drivers/virt/coco/host/tsm-core.c       |  19 +-
>  include/linux/pci-tsm.h                 | 138 ++++++++
>  include/linux/pci.h                     |   3 +
>  include/linux/tsm.h                     |   4 +-
>  include/uapi/linux/pci_regs.h           |   1 +
>  14 files changed, 679 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/pci/tsm.c
>  create mode 100644 include/linux/pci-tsm.h
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
> index 69f952fffec7..1d38e0d3a6be 100644
> --- a/Documentation/ABI/testing/sysfs-bus-pci
> +++ b/Documentation/ABI/testing/sysfs-bus-pci
> @@ -612,3 +612,48 @@ Description:
>  
>  		  # ls doe_features
>  		  0001:01        0001:02        doe_discovery
> +
> +What:		/sys/bus/pci/devices/.../tsm/
> +Date:		July 2024

Guess the date for merge?

> +Contact:	linux-coco@lists.linux.dev
> +Description:

> diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
> new file mode 100644
> index 000000000000..d00a8e471340
> --- /dev/null
> +++ b/drivers/pci/tsm.c
> @@ -0,0 +1,437 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * TEE Security Manager for the TEE Device Interface Security Protocol
> + * (TDISP, PCIe r6.1 sec 11)
> + *
> + * Copyright(c) 2024 Intel Corporation. All rights reserved.
> + */
> +
> +#define dev_fmt(fmt) "TSM: " fmt
> +
> +#include <linux/bitfield.h>
> +#include <linux/xarray.h>

Not seeing an xa stuff yet.
Check the others are all needed or push them forwards to appropriate patch.

> +#include <linux/sysfs.h>
> +
> +#include <linux/pci.h>
> +#include <linux/pci-doe.h>
> +#include <linux/pci-tsm.h>
> +#include "pci.h"


> +static bool pci_tsm_pf0_group_visible(struct kobject *kobj)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +
> +	if (pdev->tsm && is_pci_tsm_pf0(pdev))
> +		return true;
> +	return false;

Unless this is going to get more complex later

	return pdev->tsm && is_pci_tsm_pf0(pdev);

> +}
> +DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE(pci_tsm_pf0);

> +
> +const struct attribute_group pci_tsm_auth_attr_group = {
> +	.attrs = pci_tsm_auth_attrs,
> +	.is_visible = SYSFS_GROUP_VISIBLE(pci_tsm_pf0),
> +};


> +static void pci_tsm_pf0_init(struct pci_dev *pdev)
> +{
> +	bool tee_cap;
> +
> +	tee_cap = pdev->devcap & PCI_EXP_DEVCAP_TEE;

Might as well put that on first line.

> +
> +	if (!(pdev->ide_cap || tee_cap))
> +		return;




> diff --git a/drivers/virt/coco/host/tsm-core.c b/drivers/virt/coco/host/tsm-core.c
> index 4f64af1a8967..51146f226a64 100644
> --- a/drivers/virt/coco/host/tsm-core.c
> +++ b/drivers/virt/coco/host/tsm-core.c
> @@ -8,11 +8,13 @@
>  #include <linux/device.h>
>  #include <linux/module.h>
>  #include <linux/cleanup.h>
> +#include <linux/pci-tsm.h>
>  
>  static DECLARE_RWSEM(tsm_core_rwsem);
>  static struct class *tsm_class;
>  static struct tsm_core_dev {
>  	struct device dev;
> +	const struct pci_tsm_ops *pci_ops;
>  } *tsm_core;
>  
>  static struct tsm_core_dev *
> @@ -39,7 +41,8 @@ static void put_tsm_core(struct tsm_core_dev *core)
>  DEFINE_FREE(put_tsm_core, struct tsm_core_dev *,
>  	    if (!IS_ERR_OR_NULL(_T)) put_tsm_core(_T))
>  struct tsm_core_dev *tsm_register(struct device *parent,
> -				  const struct attribute_group **groups)
> +				  const struct attribute_group **groups,
> +				  const struct pci_tsm_ops *pci_ops)
>  {
>  	struct device *dev;
>  	int rc;
> @@ -61,10 +64,20 @@ struct tsm_core_dev *tsm_register(struct device *parent,
>  	if (rc)
>  		return ERR_PTR(rc);
>  
> +	rc = pci_tsm_core_register(pci_ops, NULL);
> +	if (rc) {
> +		dev_err(parent, "PCI initialization failure: %pe\n",
> +			ERR_PTR(rc));
> +		return ERR_PTR(rc);
> +	}
> +
>  	rc = device_add(dev);
> -	if (rc)
> +	if (rc) {
> +		pci_tsm_core_unregister(pci_ops);
>  		return ERR_PTR(rc);
> +	}
>  
> +	core->pci_ops = pci_ops;
>  	tsm_core = no_free_ptr(core);
>  
>  	return tsm_core;
> @@ -79,7 +92,9 @@ void tsm_unregister(struct tsm_core_dev *core)
>  		return;
>  	}
>  
> +	pci_tsm_core_unregister(core->pci_ops);
>  	device_unregister(&core->dev);

Using device_initialize() and device_add() in probe but device_unregister()
in remove results in trivial ordering mess like this.  I'd split the
remove() path so we can take down in the reverse of setup with pci_tsm_core_unregister()
between device_del() and put_device()

This ordering thing is common enough though that maybe we can just 
not worry about it.

> +

Push whitespace change back to earlier patch.

>  	tsm_core = NULL;
>  }
>  EXPORT_SYMBOL_GPL(tsm_unregister);
> diff --git a/include/linux/pci-tsm.h b/include/linux/pci-tsm.h
> new file mode 100644
> index 000000000000..00fdae087069
> --- /dev/null
> +++ b/include/linux/pci-tsm.h
> @@ -0,0 +1,138 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __PCI_TSM_H
> +#define __PCI_TSM_H
> +#include <linux/mutex.h>
> +#include <linux/pci.h>
> +
> +struct pci_dev;

Given you have linux/pci.h no need for the forwards def.


> +
> +enum pci_tsm_state {
> +	PCI_TSM_ERR = -1,
> +	PCI_TSM_INIT,
> +	PCI_TSM_CONNECT,
> +};
> +
> +/**
> + * enum pci_tsm_type - 'struct pci_tsm' object types

Kernel-doc should warn on incomplete docs.  I'd add trivial comment for
INVALID to avoid that.

> + * @PCI_TSM_PF0: function0 that hosts a DOE mailbox that comprehends an
> + *		 Interface ID per potential TDI
> + * @PCI_TSM_VIRTFN: physfn-0 of this device is "tsm_pf0"
> + * @PCI_TSM_MFD: function0 of this device is  "tsm_pf0"

Double space after "is" seems odd.

> + * @PCI_TSM_DOWNSTREAM: immediate Upstream Port of this device is "tsm_pf0"
> + */
> +enum pci_tsm_type {
> +	PCI_TSM_INVALID,
> +	PCI_TSM_PF0,
> +	PCI_TSM_VIRTFN,
> +	PCI_TSM_MFD,
> +	PCI_TSM_DOWNSTREAM,
> +};
> +
> +/**
> + * struct pci_tsm - Core TSM context for a given PCIe endpoint
> + * @pdev: indicates the type of pci_tsm object

How does a pci_dev indicate a type?  Maybe: Used to distinguish the type of pci_tsm object.
  
> + * @type: pci_tsm object type to disambiguate PCI_TSM_DOWNSTREAM and PCI_TSM_PF0
> + *
> + * This structure is wrapped by a low level TSM driver and returned by
> + * tsm_ops.probe(), it is freed by tsm_ops.remove(). Depending on
> + * whether @pdev is physical function 0, another physical function, or a
> + * virtual function determines the pci_tsm object type. E.g. see 'struct
> + * pci_tsm_pf0'.
> + */
> +struct pci_tsm {
> +	struct pci_dev *pdev;
> +	enum pci_tsm_type type;
> +};
> +
> +/**
> + * struct pci_tsm_pf0 - Physical Function 0 TDISP context

Missing tsm and kernel-doc warns if docs are complete.

> + * @state: reflect device initialized, connected, or bound
> + * @lock: protect @state vs pci_tsm_ops invocation
> + * @doe_mb: PCIe Data Object Exchange mailbox
> + */
> +struct pci_tsm_pf0 {
> +	struct pci_tsm tsm;
> +	enum pci_tsm_state state;
> +	struct mutex lock;
> +	struct pci_doe_mb *doe_mb;
> +};


