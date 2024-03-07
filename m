Return-Path: <linux-pci+bounces-4608-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB65875502
	for <lists+linux-pci@lfdr.de>; Thu,  7 Mar 2024 18:18:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D42D0284B37
	for <lists+linux-pci@lfdr.de>; Thu,  7 Mar 2024 17:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E51C1EB41;
	Thu,  7 Mar 2024 17:18:18 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D88130AD1
	for <linux-pci@vger.kernel.org>; Thu,  7 Mar 2024 17:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709831898; cv=none; b=BAYAWkTvOMjc6LsgD6YBvtVRJnwLM7/9rKHz85rwXJOv7vGSrqMW7T2mif787v+4g//LsnqCX8LcOPeXf6DwJ4a/mt7K6Qa2eTFAkP4ATUmbr9FdLU7a4RkUDHhW3JsDeN4kIrOjYjMXHLOrCvJgDocPb8Ai1MhBVt35BUttDkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709831898; c=relaxed/simple;
	bh=a3+cJo0Fq4XYdGiDA3lt5G21MCjkGoSCbTNRKlZD5+8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CFSwbiEpT2t/F6fGuFYzCBJ2U10pP5exZLh68HoNbIf5vdESqdUHHHi2KJOBruQlhcFceNXKQrs3y+cpMKbvFFEHQ/mirIg/D7J67pJPjGviixRegS5WJHLjHvECASyelmTuDuV6pXUb5PonMJhb5uH5vIpFynOVSPH0zEkrIoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TrG9w6qmmz6K7F9;
	Fri,  8 Mar 2024 01:14:12 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 9342D140FB1;
	Fri,  8 Mar 2024 01:18:11 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 7 Mar
 2024 17:18:11 +0000
Date: Thu, 7 Mar 2024 17:18:10 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, Wu Hao <hao.wu@intel.com>, Yilun Xu
	<yilun.xu@intel.com>, Lukas Wunner <lukas@wunner.de>, Samuel Ortiz
	<sameo@rivosinc.com>, Alexey Kardashevskiy <aik@amd.com>, Bjorn Helgaas
	<bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<gregkh@linuxfoundation.org>
Subject: Re: [RFC PATCH 5/5] PCI/TSM: Authenticate devices via platform TSM
Message-ID: <20240307171810.0000396c@Huawei.com>
In-Reply-To: <170660665391.224441.13963835575448844460.stgit@dwillia2-xfh.jf.intel.com>
References: <170660662589.224441.11503798303914595072.stgit@dwillia2-xfh.jf.intel.com>
	<170660665391.224441.13963835575448844460.stgit@dwillia2-xfh.jf.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 30 Jan 2024 01:24:14 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> The PCIe 6.1 specification, section 11, introduces the Trusted
> Execution Environment (TEE) Device Interface Security Protocol (TDISP).
> This interface definition builds upon CMA, component measurement and
> authentication, and IDE, link integrity and data encryption. It adds
> support for establishing virtual functions within a device that can be
> assigned to a confidential VM such that the assigned device is enabled
> to access guest private memory protected by technologies like Intel TDX,
> AMD SEV-SNP, RISCV COVE, or ARM CCA.
> 
> The "TSM" (TEE Security Manager) is a concept in the TDISP specification
> of an agent that mediates between a device security manager (DSM) and
> system software in both a VMM and a VM. From a Linux perspective the TSM
> abstracts many of the details of TDISP, IDE, and CMA. Some of those
> details leak through at times, but for the most part TDISP is an
> internal implementation detail of the TSM.
> 
> Similar to the PCI core extensions to support CONFIG_PCI_CMA,
> CONFIG_PCI_TSM builds upon that to reuse the "authenticated" sysfs
> attribute, and add more properties + controls in a tsm/ subdirectory of
> the PCI device sysfs interface. Unlike CMA that can depend on a local to
> the PCI core implementation, PCI_TSM needs to be prepared for late
> loading of the platform TSM driver. Consider that the TSM driver may
> itself be a PCI driver. Userspace can depend on the common TSM device
> uevent to know when the PCI core has TSM services enabled. The PCI
> device tsm/ subdirectory is supplemented by the TSM device pci/
> directory for platform global TSM properties + controls.
> 
> All vendor TSM implementations share the property of asking the VMM to
> perform DOE mailbox operations on behalf of the TSM. That common
> capability is centralized in PCI core code that invokes an ->exec()
> operation callback potentially multiple times to service a given request
> (struct pci_tsm_req). Future operations / verbs will be handled
> similarly with the "request + exec" model. For now, only "connect" and
> "disconnect" are implemented which at a minimum is expected to establish
> IDE for the link.
> 
> In addition to requests the low-level TSM implementation is notified of
> device arrival and departure events so that it can filter devices that
> the TSM is not prepared to support, or otherwise setup and teardown
> per-device context.
> 
> Cc: Wu Hao <hao.wu@intel.com>
> Cc: Yilun Xu <yilun.xu@intel.com>
> Cc: Lukas Wunner <lukas@wunner.de>
> Cc: Samuel Ortiz <sameo@rivosinc.com>
> Cc: Alexey Kardashevskiy <aik@amd.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Superficial comments inline - noticed whilst getting my head
around the basic structure.




> diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
> new file mode 100644
> index 000000000000..f74de0ee49a0
> --- /dev/null
> +++ b/drivers/pci/tsm.c
> @@ -0,0 +1,346 @@

> +
> +DEFINE_FREE(req_free, struct pci_tsm_req *, if (_T) tsm_ops->req_free(_T))
> +
> +static int pci_tsm_disconnect(struct pci_dev *pdev)
> +{
> +	struct pci_tsm_req *req __free(req_free) = NULL;

As below. I'll stop commenting on these.

> +
> +	/* opportunistic state checks to skip allocating a request */
> +	if (pdev->tsm->state < PCI_TSM_CONNECT)
> +		return 0;
> +
> +	req = tsm_ops->req_alloc(pdev, PCI_TSM_OP_DISCONNECT);
> +	if (!req)
> +		return -ENOMEM;
> +
> +	scoped_cond_guard(mutex_intr, return -EINTR, tsm_ops->lock) {
> +		enum pci_tsm_op_status status;
> +
> +		/* revalidate state */
> +		if (pdev->tsm->state < PCI_TSM_CONNECT)
> +			return 0;
> +		if (pdev->tsm->state < PCI_TSM_INIT)
> +			return -ENXIO;
> +
> +		do {
> +			status = tsm_ops->exec(pdev, req);
> +			req->seq++;
> +			/* TODO: marshal SPDM request */
> +		} while (status == PCI_TSM_SPDM_REQ);
> +
> +		if (status == PCI_TSM_FAIL)
> +			return -EIO;
> +		pdev->tsm->state = PCI_TSM_INIT;
> +	}
> +	return 0;
> +}
> +
> +static int pci_tsm_connect(struct pci_dev *pdev)
> +{
> +	struct pci_tsm_req *req __free(req_free) = NULL;

Push down a few lines to put it where the allocation happens.

> +
> +	/* opportunistic state checks to skip allocating a request */
> +	if (pdev->tsm->state >= PCI_TSM_CONNECT)
> +		return 0;
> +
> +	req = tsm_ops->req_alloc(pdev, PCI_TSM_OP_CONNECT);
> +	if (!req)
> +		return -ENOMEM;
> +
> +	scoped_cond_guard(mutex_intr, return -EINTR, tsm_ops->lock) {

What could possibly go wrong? Everyone loves scoped_cond_guard ;)

> +		enum pci_tsm_op_status status;
> +
> +		/* revalidate state */
> +		if (pdev->tsm->state >= PCI_TSM_CONNECT)
> +			return 0;
> +		if (pdev->tsm->state < PCI_TSM_INIT)
> +			return -ENXIO;
> +
> +		do {
> +			status = tsm_ops->exec(pdev, req);
> +			req->seq++;
> +		} while (status == PCI_TSM_SPDM_REQ);
> +
> +		if (status == PCI_TSM_FAIL)
> +			return -EIO;
> +		pdev->tsm->state = PCI_TSM_CONNECT;
> +	}
> +	return 0;
> +}

...

> + size_t connect_mode_store(struct device *dev,
> +				  struct device_attribute *attr,
> +				  const char *buf, size_t len)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	int i;
> +
> +	guard(mutex)(tsm_ops->lock);
> +	if (pdev->tsm->state >= PCI_TSM_CONNECT)
> +		return -EBUSY;
> +	for (i = 0; i < ARRAY_SIZE(pci_tsm_modes); i++)
> +		if (sysfs_streq(buf, pci_tsm_modes[i]))
> +			break;
> +	if (i == PCI_TSM_MODE_LINK) {
> +		if (pdev->tsm->link_capable)
> +			pdev->tsm->mode = PCI_TSM_MODE_LINK;

Error in all real paths paths?
Also, maybe a switch will be more sensible here.

> +		return -EOPNOTSUPP;
> +	} else if (i == PCI_TSM_MODE_SELECTIVE) {
> +		if (pdev->tsm->selective_capable)
> +			pdev->tsm->mode = PCI_TSM_MODE_SELECTIVE;
> +		return -EOPNOTSUPP;
> +	} else
> +		return -EINVAL;
> +	return len;
> +}


> +
> +void pci_tsm_init(struct pci_dev *pdev)
> +{
> +	u16 ide_cap;
> +	int rc;
> +
> +	if (!pdev->cma_capable)
> +		return;
> +
> +	ide_cap = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_IDE);
> +	if (!ide_cap)
> +		return;
> +
> +	struct pci_tsm *tsm __free(kfree) = kzalloc(sizeof(*tsm), GFP_KERNEL);
> +	if (!tsm)
> +		return;
> +
> +	tsm->ide_cap = ide_cap;
> +
> +	rc = xa_insert(&pci_tsm_devs, (unsigned long)pdev, pdev, GFP_KERNEL);

This is an unusual pattern with the key and the value matching.
Feels like xarray might for once not be the best choice of structure.

> +	if (rc) {
> +		pci_dbg(pdev, "failed to register tsm capable device\n");
> +		return;
> +	}
> +
> +	guard(rwsem_write)(&pci_tsm_rwsem);
> +	pdev->tsm = no_free_ptr(tsm);
> +	pci_tsm_add(pdev);
> +}
> +
> +void pci_tsm_destroy(struct pci_dev *pdev)
> +{
> +	guard(rwsem_write)(&pci_tsm_rwsem);
> +	pci_tsm_del(pdev);
> +	xa_erase(&pci_tsm_devs, (unsigned long)pdev);
> +	kfree(pdev->tsm);
> +	pdev->tsm = NULL;
> +}



> diff --git a/drivers/virt/coco/tsm/class.c b/drivers/virt/coco/tsm/class.c
> index a569fa6b09eb..a459e51c0892 100644
> --- a/drivers/virt/coco/tsm/class.c
> +++ b/drivers/virt/coco/tsm/class.c

> +static const struct attribute_group *tsm_attr_groups[] = {
> +#ifdef CONFIG_PCI_TSM
> +	&tsm_pci_attr_group,
> +#endif
> +	NULL,
Trivial but, no point in that comma as we will never chase it with anything.
> +};
> +
>  static int __init tsm_init(void)
>  {
>  	tsm_class = class_create("tsm");
> @@ -86,6 +97,7 @@ static int __init tsm_init(void)
>  		return PTR_ERR(tsm_class);
>  
>  	tsm_class->dev_release = tsm_release;
> +	tsm_class->dev_groups = tsm_attr_groups;
>  	return 0;
>  }
>  module_init(tsm_init)
> diff --git a/drivers/virt/coco/tsm/pci.c b/drivers/virt/coco/tsm/pci.c
> new file mode 100644
> index 000000000000..b3684ad7114f
> --- /dev/null
> +++ b/drivers/virt/coco/tsm/pci.c

> +
> +static bool tsm_pci_group_visible(struct kobject *kobj)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct tsm_subsys *subsys = container_of(dev, typeof(*subsys), dev);
Give this a macro probably.
 dev_to_tsm_subsys(kobj_to_dev(kobj));

> +
> +	if (subsys->info->pci_ops)
> +		return true;

	return subsys->info->pci->ops;
maybe

> +	return false;
> +}
> +DEFINE_SYSFS_GROUP_VISIBLE(tsm_pci);
> +
> +static struct attribute *tsm_pci_attrs[] = {
> +	&dev_attr_link_capable.attr,
> +	&dev_attr_selective_streams.attr,
> +	NULL,
> +};
> +
> +const struct attribute_group tsm_pci_attr_group = {
> +	.name = "pci",
> +	.attrs = tsm_pci_attrs,
> +	.is_visible = SYSFS_GROUP_VISIBLE(tsm_pci),
> +};
> +
> +int tsm_pci_init(const struct tsm_info *info)
> +{
> +	if (!info->pci_ops)
> +		return 0;
> +
> +	return pci_tsm_register(info->pci_ops);
> +}
> +
> +void tsm_pci_destroy(const struct tsm_info *info)
> +{
> +	pci_tsm_unregister(info->pci_ops);
> +}
> diff --git a/drivers/virt/coco/tsm/tsm.h b/drivers/virt/coco/tsm/tsm.h
> new file mode 100644
> index 000000000000..407c388a109b
> --- /dev/null
> +++ b/drivers/virt/coco/tsm/tsm.h
> @@ -0,0 +1,28 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __TSM_CORE_H
> +#define __TSM_CORE_H
> +
> +#include <linux/device.h>
> +
> +struct tsm_info;
> +struct tsm_subsys {
> +	struct device dev;
> +	const struct tsm_info *info;
> +};

I know people like to build up patch sets, but I think defining this here
from patch 3 would just reduce noise.

> +
> +#ifdef CONFIG_PCI_TSM
> +int tsm_pci_init(const struct tsm_info *info);
> +void tsm_pci_destroy(const struct tsm_info *info);
> +extern const struct attribute_group tsm_pci_attr_group;
> +#else
> +static inline int tsm_pci_init(const struct tsm_info *info)
> +{
> +	return 0;
> +}
> +static inline void tsm_pci_destroy(const struct tsm_info *info)
> +{
> +}
> +#endif
> +
> +#endif /* TSM_CORE_H */

> diff --git a/include/linux/tsm.h b/include/linux/tsm.h
> index 8cb8a661ba41..f5dbdfa65d8d 100644
> --- a/include/linux/tsm.h
> +++ b/include/linux/tsm.h
> @@ -4,11 +4,15 @@
>  
>  #include <linux/sizes.h>
>  #include <linux/types.h>
> +#include <linux/mutex.h>

struct mutex;
instead given you only have a pointer I think.


>  
>  struct tsm_info {
>  	const char *name;
>  	struct device *host;
>  	const struct attribute_group **groups;
> +	const struct tsm_pci_ops *pci_ops;
> +	unsigned int nr_selective_streams;
> +	unsigned int link_stream_capable:1;
>  };


> +struct pci_dev;
> +/**
> + * struct tsm_pci_ops - Low-level TSM-exported interface to the PCI core
> + * @add: accept device for tsm operation, locked
> + * @del: teardown tsm context for @pdev, locked
> + * @req_alloc: setup context for given operation, unlocked
> + * @req_free: teardown context for given request, unlocked
> + * @exec: run @req, may be invoked multiple times per @req, locked
> + * @lock: tsm work is one device and one op at a time
> + */
> +struct tsm_pci_ops {
> +	int (*add)(struct pci_dev *pdev);
> +	void (*del)(struct pci_dev *pdev);
> +	struct pci_tsm_req *(*req_alloc)(struct pci_dev *pdev,
> +					 enum pci_tsm_op op);
> +	struct pci_tsm_req *(*req_free)(struct pci_tsm_req *req);
> +	enum pci_tsm_op_status (*exec)(struct pci_dev *pdev,
> +				       struct pci_tsm_req *req);
> +	struct mutex *lock;

Mixing data with what would otherwise be likely to be constant pointers
probably best avoided.  Maybe wrap the lock in another op instead?


> +};


