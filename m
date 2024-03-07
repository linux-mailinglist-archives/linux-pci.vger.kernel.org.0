Return-Path: <linux-pci+bounces-4607-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D3787545B
	for <lists+linux-pci@lfdr.de>; Thu,  7 Mar 2024 17:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D08661F222CD
	for <lists+linux-pci@lfdr.de>; Thu,  7 Mar 2024 16:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD4F12FF73;
	Thu,  7 Mar 2024 16:41:46 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AFB12FF74
	for <linux-pci@vger.kernel.org>; Thu,  7 Mar 2024 16:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709829706; cv=none; b=KlfBLmqK0dO0aSkYuG3f8bewzdY0GGxwTB6k2mes+9XQomL7GOUEZirAabaAIE1cuWo2xe/3su8zazBvaoekPexSXgzX5jd8C14L997q+EjI4MqwxN4hQ6K3vOhngS7S8M3dYxZ1yaK000JIxjjTG8EEBtM4XE2yajn2r1tQ2P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709829706; c=relaxed/simple;
	bh=P3wkd5RFNRjH7Vt6TkrFqc1anD2XYqsHKX9EBPrmLa0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hESWiMWycpQCxZAvAV6qmAYNY4TfE3LmHFBhDkr5S97ik2lE/yMzn2jQvKtiZIjqqLKUCcGmdrtP6Rcfh3+QXH9grM5OAqTeMMmROQtexQ1CJr9PeGBTFyDYAvUqg/Y+MEw2CTwHh9oauJ2FJr1WRaWAkAgpL+TQXNkY15kteno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TrFSK2dL6z6JB6l;
	Fri,  8 Mar 2024 00:41:37 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id CC4A4140DB0;
	Fri,  8 Mar 2024 00:41:40 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 7 Mar
 2024 16:41:40 +0000
Date: Thu, 7 Mar 2024 16:41:39 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, Xiaoyao Li <xiaoyao.li@intel.com>, "Isaku
 Yamahata" <isaku.yamahata@intel.com>, Alexey Kardashevskiy <aik@amd.com>, "Wu
 Hao" <hao.wu@intel.com>, Yilun Xu <yilun.xu@intel.com>, Tom Lendacky
	<thomas.lendacky@amd.com>, John Allen <john.allen@amd.com>,
	<linux-pci@vger.kernel.org>, <gregkh@linuxfoundation.org>
Subject: Re: [RFC PATCH 3/5] coco/tsm: Introduce a shared class device for
 TSMs
Message-ID: <20240307164139.000049aa@Huawei.com>
In-Reply-To: <170660664287.224441.947018257307932138.stgit@dwillia2-xfh.jf.intel.com>
References: <170660662589.224441.11503798303914595072.stgit@dwillia2-xfh.jf.intel.com>
	<170660664287.224441.947018257307932138.stgit@dwillia2-xfh.jf.intel.com>
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
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 30 Jan 2024 01:24:02 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> A "tsm" is a platform component that provides an API for securely
> provisioning resources for a confidential guest (TVM) to consume. "TSM"
> also happens to be the acronym the PCI specification uses to define the
> platform agent that carries out device-security operations. That
> platform capability is commonly called TEE I/O. It is this arrival of
> TEE I/O platforms that requires the "tsm" concept to grow from a
> low-level arch-specific detail of TVM instantiation, to a frontend
> interface to mediate device setup and interact with general purpose
> kernel subsystems outside of arch/ like the PCI core.
> 
> Provide a virtual (as in /sys/devices/virtual) class device interface to
> front all of the aspects of a TSM and TEE I/O that are
> cross-architecture common. This includes mechanisms like enumerating
> available platform TEE I/O capabilities and provisioning connections
> between the platform TSM and device DSMs.
> 
> It is expected to handle hardware TSMs, like AMD SEV-SNP and ARM CCA
> where there is a physical TEE coprocessor device running firmware, as
> well as software TSMs like Intel TDX and RISC-V COVE, where there is a
> privileged software module loaded at runtime.
> 
> For now this is just the scaffolding for registering a TSM device and/or
> TSM-specific attribute groups.
> 
> Cc: Xiaoyao Li <xiaoyao.li@intel.com>
> Cc: Isaku Yamahata <isaku.yamahata@intel.com>
> Cc: Alexey Kardashevskiy <aik@amd.com>
> Cc: Wu Hao <hao.wu@intel.com>
> Cc: Yilun Xu <yilun.xu@intel.com>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: John Allen <john.allen@amd.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

A few drive by comments because I was curious.


> diff --git a/drivers/virt/coco/tsm/class.c b/drivers/virt/coco/tsm/class.c
> new file mode 100644
> index 000000000000..a569fa6b09eb
> --- /dev/null
> +++ b/drivers/virt/coco/tsm/class.c
> @@ -0,0 +1,100 @@
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
> +struct class *tsm_class;
> +struct tsm_subsys {
> +	struct device dev;
> +	const struct tsm_info *info;
> +} *tsm_subsys;
> +
> +int tsm_register(const struct tsm_info *info)
> +{
> +	struct device *dev __free(put_device) = NULL;

I think it would be appropriate to move this down to where
you set dev so it is moderately obvious where it comes from.
This only becomes valid cleanup after the call to device_register()
with it's device_initialize - which is ugly. 
Maybe we should just use split device_initialize() / device_add()
when combining with __free(put_device);

The ideal would be something like.

	struct device *dev __free(put_device) = device_initialize(&subsys->dev);

with device_initialize() returning the dev parameter.

For the really adventurous maybe even the overkill option of the following
(I know it's currently pointless complexity - given no error paths between
 the kzalloc and device_initialize())

	struct tsm_subsys *subsys __free(kfree) = kzalloc(sizeof(*subsys), GFP_KERNEL);

//Now safe to exit here.

	struct device *dev __free(put_device) = device_initialize(&no_free_ptr(subsys)->dev);

// Also good to exit here with no double free etc though subsys is now inaccessible breaking
the one place it's used later ;)

Maybe I'm over thinking things and I doubt cleanup.h discussions
was really what you wanted from this RFC :)


> +	struct tsm_subsys *subsys;
> +	int rc;
> +
> +	guard(rwsem_write)(&tsm_core_rwsem);
> +	if (tsm_subsys) {
> +		pr_warn("failed to register: \"%s\", \"%s\" already registered\n",
> +			info->name, tsm_subsys->info->name);
> +		return -EBUSY;
> +	}
> +
> +	subsys = kzalloc(sizeof(*subsys), GFP_KERNEL);
> +	if (!subsys)
> +		return -ENOMEM;
> +
> +	subsys->info = info;
> +	dev = &subsys->dev;
> +	dev->class = tsm_class;
> +	dev->groups = info->groups;
> +	dev_set_name(dev, "tsm0");
> +	rc = device_register(dev);
> +	if (rc)
> +		return rc;
> +
> +	if (info->host) {
> +		rc = sysfs_create_link(&dev->kobj, &info->host->kobj, "host");

Why not parent it from there?  If it has a logical parent, that would be
nicer than using a virtual device.

> +		if (rc)
> +			return rc;
> +	}
> +
> +	/* don't auto-free @dev */
> +	dev = NULL;
> +	tsm_subsys = subsys;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(tsm_register);

Seems appropriate to namespace these from the start.

> +
> +void tsm_unregister(const struct tsm_info *info)
> +{
> +	guard(rwsem_write)(&tsm_core_rwsem);
> +	if (!tsm_subsys || info != tsm_subsys->info) {
> +		pr_warn("failed to unregister: \"%s\", not currently registered\n",
> +			info->name);
> +		return;
> +	}
> +
> +	if (info->host)
> +		sysfs_remove_link(&tsm_subsys->dev.kobj, "host");
> +	device_unregister(&tsm_subsys->dev);
> +	tsm_subsys = NULL;
> +}
> +EXPORT_SYMBOL_GPL(tsm_unregister);




