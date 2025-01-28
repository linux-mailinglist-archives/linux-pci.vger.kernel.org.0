Return-Path: <linux-pci+bounces-20465-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3BEA20A78
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2025 13:17:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 303171885BF7
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2025 12:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B910419D070;
	Tue, 28 Jan 2025 12:17:51 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45F2198E91
	for <linux-pci@vger.kernel.org>; Tue, 28 Jan 2025 12:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738066671; cv=none; b=h9sIaDK0UKFNhKthCB4L69Ow1M5FdZJ1VDNNyeJb56gxIP9lkuK901aNmOoD7P5paeaLbkykL8Q4sdPJxM1uG6jmltdfhyKLL3YnG2gDnH4RerCgNKupBl458lN+QaJ9mwuvAIU3Ke/5zDaQ83XDnt4Fbv3J3tVm0yJk/rsTZGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738066671; c=relaxed/simple;
	bh=gwJt95vNJCqzrkdYQJcU71cNTn+0azjl3k3Hf4t0UB8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lsTQsYYoPqz3ZucEU0sSc10Zfdd3SSBJoPeBO3cwRuvUulu/BT3GbGY+rxe6JRmhd46XdrpoHK0+PwHkinkzsDBrFGM2pNGLTHMES0ETjjEf5jgvEkreXG1aS0QGC/W2mQCQCZo8717astpEJhz9scxeeenShBTQmxZHUsMmIU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Yj46K59tsz6K92N;
	Tue, 28 Jan 2025 20:17:13 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id B664D140A35;
	Tue, 28 Jan 2025 20:17:46 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 28 Jan
 2025 13:17:46 +0100
Date: Tue, 28 Jan 2025 12:17:44 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, Xiaoyao Li <xiaoyao.li@intel.com>, "Isaku
 Yamahata" <isaku.yamahata@intel.com>, Alexey Kardashevskiy <aik@amd.com>,
	Yilun Xu <yilun.xu@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, "John
 Allen" <john.allen@amd.com>, <linux-pci@vger.kernel.org>,
	<gregkh@linuxfoundation.org>
Subject: Re: [PATCH 03/11] coco/tsm: Introduce a class device for TEE
 Security Managers
Message-ID: <20250128121744.00003188@huawei.com>
In-Reply-To: <173343741358.1074769.14824760616956254302.stgit@dwillia2-xfh.jf.intel.com>
References: <173343739517.1074769.13134786548545925484.stgit@dwillia2-xfh.jf.intel.com>
	<173343741358.1074769.14824760616956254302.stgit@dwillia2-xfh.jf.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 05 Dec 2024 14:23:33 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> A "TSM" is a platform component that provides an API for securely
> provisioning resources for a confidential guest (TVM) to consume. The
> name originates from the PCI specification for platform agent that
> carries out operations for PCIe TDISP (TEE Device Interface Security
> Protocol).
> 
> Instances of this class device are parented by a device representing the
> platform security capability like CONFIG_CRYPTO_DEV_CCP or
> CONFIG_INTEL_TDX_HOST.
> 
> This class device interface is a frontend to the aspects of a TSM and
> TEE I/O that are cross-architecture common. This includes mechanisms
> like enumerating available platform TEE I/O capabilities and
> provisioning connections between the platform TSM and device DSMs
> (Device Security Manager (TDISP)).
> 
> For now this is just the scaffolding for registering a TSM device sysfs
> interface.
> 
> Cc: Xiaoyao Li <xiaoyao.li@intel.com>
> Cc: Isaku Yamahata <isaku.yamahata@intel.com>
> Cc: Alexey Kardashevskiy <aik@amd.com>
> Cc: Yilun Xu <yilun.xu@intel.com>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: John Allen <john.allen@amd.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

A couple of generic comments inline.

> diff --git a/drivers/virt/coco/Kconfig b/drivers/virt/coco/Kconfig
> index 819a97e8ba99..14e7cf145d85 100644
> --- a/drivers/virt/coco/Kconfig
> +++ b/drivers/virt/coco/Kconfig
> @@ -14,3 +14,5 @@ source "drivers/virt/coco/tdx-guest/Kconfig"
>  source "drivers/virt/coco/arm-cca-guest/Kconfig"
>  
>  source "drivers/virt/coco/guest/Kconfig"
> +
> +source "drivers/virt/coco/host/Kconfig"
> diff --git a/drivers/virt/coco/Makefile b/drivers/virt/coco/Makefile
> index 885c9ef4e9fc..73f1b7bc5b11 100644
> --- a/drivers/virt/coco/Makefile
> +++ b/drivers/virt/coco/Makefile
> @@ -8,3 +8,4 @@ obj-$(CONFIG_SEV_GUEST)		+= sev-guest/
>  obj-$(CONFIG_INTEL_TDX_GUEST)	+= tdx-guest/
>  obj-$(CONFIG_ARM_CCA_GUEST)	+= arm-cca-guest/
>  obj-$(CONFIG_TSM_REPORTS)	+= guest/
> +obj-y				+= host/
> diff --git a/drivers/virt/coco/host/Kconfig b/drivers/virt/coco/host/Kconfig
> new file mode 100644
> index 000000000000..4fbc6ef34f12
> --- /dev/null
> +++ b/drivers/virt/coco/host/Kconfig
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# TSM (TEE Security Manager) Common infrastructure and host drivers
> +#
> +config TSM
> +	tristate
> diff --git a/drivers/virt/coco/host/Makefile b/drivers/virt/coco/host/Makefile
> new file mode 100644
> index 000000000000..be0aba6007cd
> --- /dev/null
> +++ b/drivers/virt/coco/host/Makefile
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# TSM (TEE Security Manager) Common infrastructure and host drivers
> +
> +obj-$(CONFIG_TSM) += tsm.o
> +tsm-y := tsm-core.o
> diff --git a/drivers/virt/coco/host/tsm-core.c b/drivers/virt/coco/host/tsm-core.c
> new file mode 100644
> index 000000000000..0ee738fc40ed
> --- /dev/null
> +++ b/drivers/virt/coco/host/tsm-core.c
> @@ -0,0 +1,113 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright(c) 2024 Intel Corporation. All rights reserved. */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/tsm.h>
> +#include <linux/rwsem.h>
> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/cleanup.h>
> +
> +static DECLARE_RWSEM(tsm_core_rwsem);
> +static struct class *tsm_class;
> +static struct tsm_subsys {
> +	struct device dev;
> +} *tsm_subsys;

This naming seems a bit confusing. To me tsm_sybsys could be:
a) The subsystem itself.  So something we'd expect to remove only alongside
class destroy.
b) A subsystem of a tsm (confusing here in a subsystem for tsms). Expectation
   being that a given tsm would register more than one of these.
c) What I think it is which is, which is the device added to register with
   the tsm subsystem.  

Mind you I'm not immediately sure what a better naming is.
tsm_class_dev maybe?  Though that sounds like it should be a struct device.


> +
> +static struct tsm_subsys *
> +alloc_tsm_subsys(struct device *parent, const struct attribute_group **groups)
> +{
> +	struct tsm_subsys *subsys = kzalloc(sizeof(*subsys), GFP_KERNEL);
> +	struct device *dev;
> +
> +	if (!subsys)
> +		return ERR_PTR(-ENOMEM);
> +	dev = &subsys->dev;
> +	dev->parent = parent;
> +	dev->groups = groups;
> +	dev->class = tsm_class;
> +	device_initialize(dev);
> +	return subsys;
> +}
> +
> +static void put_tsm_subsys(struct tsm_subsys *subsys)
> +{
> +	if (!IS_ERR_OR_NULL(subsys))

If you are calling this with it as an error or null then
that smells like a bad bug we shouldn't paper over.
The only case I can think of is the define free you have
below which correctly has the same check.

> +		put_device(&subsys->dev);
> +}
> +
> +DEFINE_FREE(put_tsm_subsys, struct tsm_subsys *,
> +	    if (!IS_ERR_OR_NULL(_T)) put_tsm_subsys(_T))
> +struct tsm_subsys *tsm_register(struct device *parent,
> +				const struct attribute_group **groups)
> +{
> +	struct device *dev;
> +	int rc;
> +
> +	guard(rwsem_write)(&tsm_core_rwsem);
> +	if (tsm_subsys) {
> +		dev_warn(parent, "failed to register: %s already registered\n",
> +			 dev_name(tsm_subsys->dev.parent));
> +		return ERR_PTR(-EBUSY);
> +	}
> +
> +	struct tsm_subsys *subsys __free(put_tsm_subsys) =
> +		alloc_tsm_subsys(parent, groups);
> +	if (IS_ERR(subsys))
> +		return subsys;
> +
> +	dev = &subsys->dev;
> +	rc = dev_set_name(dev, "tsm0");
> +	if (rc)
> +		return ERR_PTR(rc);
> +
> +	rc = device_add(dev);
> +	if (rc)
> +		return ERR_PTR(rc);
> +
> +	tsm_subsys = no_free_ptr(subsys);
> +
> +	return tsm_subsys;
> +}
> +EXPORT_SYMBOL_GPL(tsm_register);
> +
> +void tsm_unregister(struct tsm_subsys *subsys)
> +{
> +	guard(rwsem_write)(&tsm_core_rwsem);
> +	if (!tsm_subsys || subsys != tsm_subsys) {
> +		pr_warn("failed to unregister, not currently registered\n");
> +		return;
> +	}
> +
> +	device_unregister(&subsys->dev);
> +	tsm_subsys = NULL;
> +}
> +EXPORT_SYMBOL_GPL(tsm_unregister);
> +
> +static void tsm_release(struct device *dev)
> +{
> +	struct tsm_subsys *subsys = container_of(dev, typeof(*subsys), dev);
> +
> +	kfree(subsys);
> +}
> +
> +static int __init tsm_init(void)
> +{
> +	tsm_class = class_create("tsm");
> +	if (IS_ERR(tsm_class))
> +		return PTR_ERR(tsm_class);
> +
> +	tsm_class->dev_release = tsm_release;
> +	return 0;
> +}
> +module_init(tsm_init)
> +
> +static void __exit tsm_exit(void)
> +{
> +	class_destroy(tsm_class);
> +}
> +module_exit(tsm_exit)
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("TEE Security Manager core");



