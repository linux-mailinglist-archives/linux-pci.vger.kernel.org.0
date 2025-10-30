Return-Path: <linux-pci+bounces-39790-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C76C1F7A4
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 11:16:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54CB63A8A57
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 10:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8832E7167;
	Thu, 30 Oct 2025 10:16:26 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B959D3164D8
	for <linux-pci@vger.kernel.org>; Thu, 30 Oct 2025 10:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761819386; cv=none; b=nEpVWW2n4UPBd0kXR41Chqf++45DLiMOlLgX97vF7btaWjQq2SwMGHcB5IrMgXe+gHgZ7KS/UpQz/ub+NfmTnFvDykZxnIRz7tRQg++Mu6sy1+dlx+Xy0NeQSmJtpWpzucLhVr9xak7JldBNFKA7wqWKkyeNd7x7maw+oRkCwwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761819386; c=relaxed/simple;
	bh=MPCKsEqVZcH0ZBAWUWNKhF7483uhyE1sBQpsp+NYVmw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SEKbHcMico70XQeaX7hQcnWEYDVaGsypYzDimm7q12TeaSBW5/PNvSO2J+WKz1zmfXGLa/SsB19Qu/TfBhBH3QnBv76Njv8Uv4gS/pUCBBq4Pu6k5LJJc4ZtsxDnFDLESoR/VzjmE2JfpGkUi7VElHqH4FI/PiIOA2P3MijkUxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cy0KS278Wz6M4nP;
	Thu, 30 Oct 2025 18:12:28 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 5D8F914038F;
	Thu, 30 Oct 2025 18:16:20 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 30 Oct
 2025 10:16:19 +0000
Date: Thu, 30 Oct 2025 10:16:18 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<xin@zytor.com>, <chao.gao@intel.com>, Xu Yilun <yilun.xu@linux.intel.com>
Subject: Re: [RFC PATCH 01/27] coco/tdx-host: Introduce a "tdx_host" device
Message-ID: <20251030101618.00005011@huawei.com>
In-Reply-To: <20250919142237.418648-2-dan.j.williams@intel.com>
References: <20250919142237.418648-1-dan.j.williams@intel.com>
	<20250919142237.418648-2-dan.j.williams@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Fri, 19 Sep 2025 07:22:10 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> From: Chao Gao <chao.gao@intel.com>
> 
> TDX depends on a platform firmware module that is invoked via instructions
> similar to vmenter (i.e. enter into a new privileged "root-mode" context to
> manage private memory and private device mechanisms). It is a software
> construct that depends on the CPU vmxon state to enable invocation of
> TDX-module ABIs. Unlike other Trusted Execution Environment (TEE) platform
> implementations that employ a firmware module running on a PCI device with
> an MMIO mailbox for communication, TDX has no hardware device to point to
> as the TEE Secure Manager (TSM).
> 
> Create a virtual device not only to align with other implementations but
> also to make it easier to
> 
>  - expose metadata (e.g., TDX module version, seamldr version etc) to
>    the userspace as device attributes
> 
>  - implement firmware uploader APIs which are tied to a device. This is
>    needed to support TDX module runtime updates
> 
>  - enable TDX Connect which will share a common infrastructure with other
>    platform implementations. In the TDX Connect context, every
>    architecture has a TSM, represented by a PCIe or virtual device. The
>    new "tdx_host" device will serve the TSM role.
> 
> A faux device is used as for TDX because the TDX module is singular within
> the system and lacks associated platform resources. Using a faux device
> eliminates the need to create a stub bus.
> 
> The call to tdx_enable() makes the new module independent of kvm_intel.ko.
> For example, TDX Connect may be used to established to PCIe link encryption
> even if a TVM is never launched.  For now, just create the common loading
> infrastructure.
> 
> Co-developed-by: Xu Yilun <yilun.xu@linux.intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> Signed-off-by: Chao Gao <chao.gao@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

I'm only taking a look to see a second example of how the core
code is used as I care mostly about the ARM one.  Anyhow, a
few passing comments inline.

> diff --git a/drivers/virt/coco/tdx-host/tdx-host.c b/drivers/virt/coco/tdx-host/tdx-host.c
> new file mode 100644
> index 000000000000..49c205913ef6
> --- /dev/null
> +++ b/drivers/virt/coco/tdx-host/tdx-host.c
> @@ -0,0 +1,52 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * TDX host user interface driver
> + *
> + * Copyright (C) 2025 Intel Corporation
> + */
> +
> +#include <linux/kernel.h>

There is general rework ongoing to stop including kernel.h except
where strictly necessary.  Please check exactly what you need and
see if one or more more specific headers is appropriate.

> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/sysfs.h>

Bring headers in with the patch that first uses them. I'm not immediately
spotting anything from this one in this patch.  Doing that just makes
it easier to see if there are excess headers included at the end of
building up the driver across a series.

> +#include <linux/device/faux.h>
> +#include <asm/cpu_device_id.h>
> +#include <asm/tdx.h>
> +#include <asm/tdx_global_metadata.h>
> +
> +static const struct x86_cpu_id tdx_host_ids[] = {
> +	X86_MATCH_FEATURE(X86_FEATURE_TDX_HOST_PLATFORM, NULL),
> +	{}
> +};
> +MODULE_DEVICE_TABLE(x86cpu, tdx_host_ids);
> +
> +static struct faux_device *fdev;
> +
> +static int __init tdx_host_init(void)
> +{
> +	int r;
> +
> +	if (!x86_match_cpu(tdx_host_ids))
> +		return -ENODEV;
> +
> +	/* Enable the usage of SEAMCALLs */

What's the logic behind doing that here rather than in probe
for the faux device?  Perhaps add something to this comment.

> +	r = tdx_enable();
> +	if (r)
> +		return r;
> +
> +	fdev = faux_device_create(KBUILD_MODNAME, NULL, NULL);
> +	if (!fdev)
> +		return -ENODEV;
> +
> +	return 0;
> +}
> +module_init(tdx_host_init);
> +
> +static void __exit tdx_host_exit(void)
> +{
> +	faux_device_destroy(fdev);
> +}
> +module_exit(tdx_host_exit);
> +
> +MODULE_DESCRIPTION("TDX Host Services");
> +MODULE_LICENSE("GPL");
> 
> base-commit: 0d1fbc1f1b7a3c8b14a643303dd89bcc82d3fbd0


