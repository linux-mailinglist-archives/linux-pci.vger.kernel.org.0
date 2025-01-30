Return-Path: <linux-pci+bounces-20573-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FDF5A22CAD
	for <lists+linux-pci@lfdr.de>; Thu, 30 Jan 2025 12:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D55451887C57
	for <lists+linux-pci@lfdr.de>; Thu, 30 Jan 2025 11:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8F71DF96B;
	Thu, 30 Jan 2025 11:46:10 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788C4194C86
	for <linux-pci@vger.kernel.org>; Thu, 30 Jan 2025 11:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738237570; cv=none; b=m1RVW+8NIxY1t1xZi3GJCz8uE+A1weDn3Bz68AwI7rvY2XICgPraZM764wMt01cC74sQFxEWleM+P3+qQeEGskBPam/A4xYmJnl2w2x6Sc7NyiokA48ht1xCi7mXvfuOXWE0Z9Vhc8J5MMlSFO94ehHAOqAg8BPv/Rw4xzWB82A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738237570; c=relaxed/simple;
	bh=E4ey9MlBkr+C1nxQtk7EELAA6wc1n/ZWHfLpmiUkwR0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gOvgWYAYvJ11cgycJNcF+ylGvdaC+cKk6kvaZzxz2/1E3F0BxDRRGaFKRTEm1qnQDJudrCEzwKzDYu7pA2X8YAx0ILKpww8HrjaAib1278YKy7Pm7NwzynkbhJYxE5ysA9ngSYaHev4ir7Jv/Lrh+sKnluRpRmtw9c4lriFR5D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YkHGv0DFMz6M4Wx;
	Thu, 30 Jan 2025 19:43:51 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id D720714011B;
	Thu, 30 Jan 2025 19:45:57 +0800 (CST)
Received: from localhost (10.47.30.69) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 30 Jan
 2025 12:45:57 +0100
Date: Thu, 30 Jan 2025 11:45:54 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, Lukas Wunner <lukas@wunner.de>, Samuel Ortiz
	<sameo@rivosinc.com>, Alexey Kardashevskiy <aik@amd.com>, Bjorn Helgaas
	<bhelgaas@google.com>, Xu Yilun <yilun.xu@linux.intel.com>,
	<linux-pci@vger.kernel.org>, <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 05/11] PCI/TSM: Authenticate devices via platform TSM
Message-ID: <20250130114554.0000033d@huawei.com>
In-Reply-To: <173343742510.1074769.16552514658771224955.stgit@dwillia2-xfh.jf.intel.com>
References: <173343739517.1074769.13134786548545925484.stgit@dwillia2-xfh.jf.intel.com>
	<173343742510.1074769.16552514658771224955.stgit@dwillia2-xfh.jf.intel.com>
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

On Thu, 05 Dec 2024 14:23:45 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> The PCIe 6.1 specification, section 11, introduces the Trusted Execution
> Environment (TEE) Device Interface Security Protocol (TDISP).  This
> interface definition builds upon Component Measurement and
> Authentication (CMA), and link Integrity and Data Encryption (IDE). It
> adds support for assigning devices (PCI physical or virtual function) to
> a confidential VM such that the assigned device is enabled to access
> guest private memory protected by technologies like Intel TDX, AMD
> SEV-SNP, RISCV COVE, or ARM CCA.
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
> to pci-sysfs. The work in progress CONFIG_PCI_CMA (software
> kernel-native PCI authentication) that can depend on a local to the PCI
> core implementation, CONFIG_PCI_TSM needs to be prepared for late
> loading of the platform TSM driver. 

I don't follow the previous sentence. Perhaps consider a rewrite?

> Consider that the TSM driver may
> itself be a PCI driver. Userspace can watch /sys/class/tsm/tsm0/uevent
> to know when the PCI core has TSM services enabled.
> 
> The common verbs that the low-level TSM drivers implement are defined by
> 'struct pci_tsm_ops'. For now only 'connect' and 'disconnect' are
> defined for secure session and IDE establishment. The 'probe' and
> 'remove' operations setup per-device context representing the device's
> security manager (DSM). Note that there is only one DSM expected per
> physical PCI function, and that coordinates a variable number of
> assignable interfaces to CVMs.
> 
> The locking allows for multiple devices to be executing commands
> simultaneously, one outstanding command per-device and an rwsem flushes
> all in-flight commands when a TSM low-level driver/device is removed.
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
A few minor things inline.

Jonathan

> ---
>  Documentation/ABI/testing/sysfs-bus-pci |   42 ++++
>  MAINTAINERS                             |    2 
>  drivers/pci/Kconfig                     |   13 +
>  drivers/pci/Makefile                    |    1 
>  drivers/pci/pci-sysfs.c                 |    4 
>  drivers/pci/pci.h                       |   10 +
>  drivers/pci/probe.c                     |    1 
>  drivers/pci/remove.c                    |    3 
>  drivers/pci/tsm.c                       |  293 +++++++++++++++++++++++++++++++
>  drivers/virt/coco/host/tsm-core.c       |   19 ++
>  include/linux/pci-tsm.h                 |   83 +++++++++
>  include/linux/pci.h                     |    3 
>  include/linux/tsm.h                     |    4 
>  include/uapi/linux/pci_regs.h           |    1 
>  14 files changed, 476 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/pci/tsm.c
>  create mode 100644 include/linux/pci-tsm.h



> diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
> new file mode 100644
> index 000000000000..04e9257a6e41
> --- /dev/null
> +++ b/drivers/pci/tsm.c
> @@ -0,0 +1,293 @@
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
> +#include <linux/pci.h>
> +#include <linux/pci-doe.h>
> +#include <linux/sysfs.h>
> +#include <linux/xarray.h>
> +#include <linux/pci-tsm.h>
> +#include <linux/bitfield.h>

Odd header ordering.  Anything consistent is fine by me but
this just feels random.


> +#include "pci.h"
> +
> +/*
> + * Provide a read/write lock against the init / exit of pdev tsm
> + * capabilities and arrival/departure of a tsm instance
> + */
> +static DECLARE_RWSEM(pci_tsm_rwsem);
> +static const struct pci_tsm_ops *tsm_ops;
> +
> +/* supplemental attributes to surface when pci_tsm_attr_group is active */
> +static const struct attribute_group *pci_tsm_owner_attr_group;
> +
> +static int pci_tsm_disconnect(struct pci_dev *pdev)
> +{
> +	struct pci_tsm *pci_tsm = pdev->tsm;
> +
> +	lockdep_assert_held(&pci_tsm_rwsem)
> +	if_not_guard(mutex_intr, &pci_tsm->lock)

Sadly that got dropped.

> +		return -EINTR;
> +
> +	if (pci_tsm->state < PCI_TSM_CONNECT)
> +		return 0;
> +	if (pci_tsm->state < PCI_TSM_INIT)
> +		return -ENXIO;
> +
> +	tsm_ops->disconnect(pdev);
> +	pci_tsm->state = PCI_TSM_INIT;
> +
> +	return 0;
> +}
> +

> +static struct attribute *pci_tsm_attrs[] = {
> +	&dev_attr_connect.attr,
> +	NULL,

Trivia but no comma given it's a terminator and nothing will
ever come after it.


> +};
> +
> +const struct attribute_group pci_tsm_attr_group = {
> +	.name = "tsm",
> +	.attrs = pci_tsm_attrs,
> +	.is_visible = SYSFS_GROUP_VISIBLE(pci_tsm),
> +};
> +
> +static ssize_t authenticated_show(struct device *dev,
> +				  struct device_attribute *attr, char *buf)
> +{
> +	/*
> +	 * When device authentication is TSM owned, 'authenticated' is
> +	 * identical to the connect state.
> +	 */
> +	return connect_show(dev, attr, buf);
> +}
> +static DEVICE_ATTR_RO(authenticated);
> +
> +static struct attribute *pci_tsm_auth_attrs[] = {
> +	&dev_attr_authenticated.attr,
> +	NULL,
no comma

> +};


> +void pci_tsm_destroy(struct pci_dev *pdev)
> +{
> +	guard(rwsem_write)(&pci_tsm_rwsem);
> +	__pci_tsm_destroy(pdev);
> +}
> +
> +void pci_tsm_unregister(const struct pci_tsm_ops *ops)

I'd try to name things so it is clearer when a function
is about the TSM coming and going vs a particular PCI
device coming and going after the TSM is loaded.

At least that's what I'm assuming is the difference between
pci_tsm_unregister() tsm going vs
pci_tsm_destroy() particular PCI device driver being unbound
(which I don't think gets called, so maybe drop for now?)

> +{
> +	struct pci_dev *pdev = NULL;
> +
> +	if (!ops)
> +		return;
> +	guard(rwsem_write)(&pci_tsm_rwsem);
> +	if (ops != tsm_ops)
> +		return;
> +	for_each_pci_dev(pdev)
> +		__pci_tsm_destroy(pdev);
> +	tsm_ops = NULL;
> +}
> +EXPORT_SYMBOL_GPL(pci_tsm_unregister);

> 


