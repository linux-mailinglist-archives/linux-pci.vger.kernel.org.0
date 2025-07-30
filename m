Return-Path: <linux-pci+bounces-33190-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F9DB16300
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 16:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8056018C851D
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 14:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D2F2DAFBA;
	Wed, 30 Jul 2025 14:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="t0sO3azx"
X-Original-To: linux-pci@vger.kernel.org
Received: from sinmsgout02.his.huawei.com (sinmsgout02.his.huawei.com [119.8.177.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7484B2DAFA4;
	Wed, 30 Jul 2025 14:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=119.8.177.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753886603; cv=none; b=GPI8Y2EPRK0YMQYTn0/KlHYRbjB+cwl1ha6+tmdCAPWb/KY5+s0zhj2KcIx4yBGLzbJ1j0qGBjgaNNq8XTVQSXxfqI29iwxtkdMQcT04kD3MWtnPIuHoTN5gN2hlwzYTFRIVOlWsDrsDvUnCgS2dhl+7MQ3knYBV1vq4e0CbA3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753886603; c=relaxed/simple;
	bh=VELo7VNAXS/sb3xrgvY31EEborJY9bTvrjj5jfDKUq4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FM23aD2E77vR2ptzhLMmlWf/CorV9O9MFPvxeNeHZda8VGTiu1ExGNkIMh4m6Y3Alfttr0ERvIYiuHfD/Sx+h23N8rN64cPIm+VO2Idrb0Wj4setarkCFaD1BdHQguROxPGFgsxEbY9fR/4yXmu0WRc8Y3O2K5x5dLUuyTEdv+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=t0sO3azx; arc=none smtp.client-ip=119.8.177.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=13nxrJFzoNH9R0ItCgDej6Iay89BP9TwCN9S91Hx9KY=;
	b=t0sO3azx1nRwWmTjpCAJPEF48zVxKioQa/X35Ep+ZRwIzzthRuXfC07qHseADBj5IrXrW1fv/
	mXevKHgtKxWLjPBMDgho00EaKGJJewPcW6a8lkqJtDOPw+a6j9WnRl08m2wApw477yYKgSdD72t
	b5k6Of9M1yNRQZx01riqCvg=
Received: from frasgout.his.huawei.com (unknown [172.18.146.35])
	by sinmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4bsZfX5HG2z1vnJ5;
	Wed, 30 Jul 2025 22:41:40 +0800 (CST)
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bsZfS6MGSz6M4yg;
	Wed, 30 Jul 2025 22:41:36 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 03EDB140122;
	Wed, 30 Jul 2025 22:43:13 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 30 Jul
 2025 16:43:12 +0200
Date: Wed, 30 Jul 2025 15:43:10 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
CC: <linux-coco@lists.linux.dev>, <kvmarm@lists.linux.dev>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <aik@amd.com>,
	<lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>, Xu Yilun
	<yilun.xu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, "Suzuki K
 Poulose" <Suzuki.Poulose@arm.com>, Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>,
	Will Deacon <will@kernel.org>, Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [RFC PATCH v1 30/38] coco: host: arm64: Add support for realm
 host interface (RHI)
Message-ID: <20250730154310.00003143@huawei.com>
In-Reply-To: <20250728135216.48084-31-aneesh.kumar@kernel.org>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
	<20250728135216.48084-31-aneesh.kumar@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 28 Jul 2025 19:22:07 +0530
"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> wrote:

> Device assignment-related RHI calls result in a REC exit, which is
> handled by the tsm guest_request callback.
> 
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

Comments below.

> ---
>  arch/arm64/include/asm/rhi.h             | 32 ++++++++++
>  drivers/virt/coco/arm-cca-host/arm-cca.c | 68 ++++++++++++++++++++
>  drivers/virt/coco/arm-cca-host/rmm-da.c  | 81 ++++++++++++++++++++++++
>  drivers/virt/coco/arm-cca-host/rmm-da.h  |  4 ++
>  include/linux/tsm.h                      |  3 +
>  5 files changed, 188 insertions(+)
>  create mode 100644 arch/arm64/include/asm/rhi.h

> diff --git a/drivers/virt/coco/arm-cca-host/arm-cca.c b/drivers/virt/coco/arm-cca-host/arm-cca.c
> index be1296fb1bf2..0807fcf8d222 100644
> --- a/drivers/virt/coco/arm-cca-host/arm-cca.c
> +++ b/drivers/virt/coco/arm-cca-host/arm-cca.c

> +static int cca_tsm_guest_req(struct pci_dev *pdev, struct tsm_guest_req_info *info)
> +{
> +	int ret;
> +
> +	switch (info->type) {
> +	case ARM_CCA_DA_OBJECT_SIZE:
> +	{
> +		int object_size;
> +		struct da_object_size_req req;
> +
> +		if (sizeof(req) != info->req_len)
> +			return -EINVAL;
> +
> +		if (copy_from_user(&req, info->req, info->req_len))
> +			return -EFAULT;
> +
> +		object_size = rme_get_da_object_size(pdev, req.object_type);
> +		if (object_size > 0) {
> +			if (info->resp_len < sizeof(object_size))
> +				return -EINVAL;
> +			if (copy_to_user(info->resp, &object_size, sizeof(object_size)))
> +				return -EFAULT;
> +			info->resp_len = sizeof(object_size);
> +			ret = 0;
			return 0;
then else isn't needed.

> +		} else

#Style is {} on all legs if any need it.

> +			/* error */
> +			ret = object_size;
			return object_size;

> +		break;
> +	}
> +	case ARM_CCA_DA_OBJECT_READ:
> +	{
> +		int resp_len;
> +		struct da_object_read_req req;
> +
> +		if (sizeof(req) != info->req_len)
> +			return -EINVAL;
> +
> +		if (copy_from_user(&req, info->req, info->req_len))
> +			return -EFAULT;
> +
> +		resp_len = rme_da_object_read(pdev, req.object_type, req.offset,
> +					      info->resp_len,
> +					      info->resp);
> +		if (resp_len > 0) {
> +			info->resp_len = resp_len;
> +			ret = 0;
Similar to above.
> +		} else
> +			/* error */
> +			ret = resp_len;
> +		break;
> +	}
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
> +	return ret;
As you've probably figured out, I love an early return.  This sort
of function shows why as it reduced indent etc in lots of places.
Here you mix and match. Maybe it will make sense later in the series though!

> +}

> diff --git a/drivers/virt/coco/arm-cca-host/rmm-da.c b/drivers/virt/coco/arm-cca-host/rmm-da.c
> index bef33e618fd3..c7da9d12f258 100644
> --- a/drivers/virt/coco/arm-cca-host/rmm-da.c
> +++ b/drivers/virt/coco/arm-cca-host/rmm-da.c
> @@ -10,7 +10,9 @@
>  #include <keys/asymmetric-type.h>
>  #include <keys/x509-parser.h>
>  #include <linux/kvm_types.h>
> +#include <linux/kvm_host.h>
>  #include <asm/kvm_rme.h>
> +#include <asm/kvm_emulate.h>
>  
>  #include "rmm-da.h"
>  
> @@ -769,6 +771,85 @@ static int rme_exit_vdev_req_handler(struct realm_rec *rec)
>  	return 1;
>  }
>  
> +int rme_get_da_object_size(struct pci_dev *pdev, int type)
> +{
> +	int ret = 0;
> +	unsigned long len;
> +	struct pci_tsm *tsm = pdev->tsm;
> +	struct cca_host_dsc_pf0 *dsc_pf0;
> +
> +	if (!tsm)
> +		return -EINVAL;
> +
> +	dsc_pf0 = to_cca_dsc_pf0(tsm->dsm_dev);
> +
> +	/* Determine the buffer that should be used */
> +	if (type == RHI_DA_OBJECT_INTERFACE_REPORT) {
> +		len = dsc_pf0->interface_report.size;
> +	} else if (type == RHI_DA_OBJECT_MEASUREMENT) {
> +		len = dsc_pf0->measurements.size;
> +	} else if (type == RHI_DA_OBJECT_CERTIFICATE) {
> +		len = dsc_pf0->cert_chain.cache.size;
> +	} else if (type == RHI_DA_OBJECT_VCA) {
> +		len = dsc_pf0->vca.size;
> +	} else {
> +		ret = -EINVAL;
> +		goto err_out;
> +	}
> +
> +	return len;
> +err_out:

Similar to below. This pattern just makes things more complex.
If we need to introduce a label, do it in the patch where you add
code to do something on error.

> +	return ret;
> +}
> +
> +int rme_da_object_read(struct pci_dev *pdev, int type, unsigned long offset,
> +		       unsigned long max_len, void __user *user_buf)
> +{
> +	void *buf;
> +	int ret = 0;
> +	unsigned long len;
> +	struct cca_host_dsc_pf0 *dsc_pf0;
> +	struct pci_tsm *tsm = pdev->tsm;
> +
> +	if (!tsm)
> +		return -EINVAL;
> +
> +	dsc_pf0 = to_cca_dsc_pf0(tsm->dsm_dev);
> +
> +	/* Determine the buffer that should be used */
> +	if (type == RHI_DA_OBJECT_INTERFACE_REPORT) {
> +		len = dsc_pf0->interface_report.size;
> +		buf = dsc_pf0->interface_report.buf;
> +	} else if (type == RHI_DA_OBJECT_MEASUREMENT) {
> +		len = dsc_pf0->measurements.size;
> +		buf = dsc_pf0->measurements.buf;
> +	} else if (type == RHI_DA_OBJECT_CERTIFICATE) {
> +		len = dsc_pf0->cert_chain.cache.size;
> +		buf = dsc_pf0->cert_chain.cache.buf;
> +	} else if (type == RHI_DA_OBJECT_VCA) {
> +		len = dsc_pf0->vca.size;
> +		buf = dsc_pf0->vca.buf;
> +	} else {
> +		ret = -EINVAL;
> +		goto err_out;
> +	}
> +
> +	/* Assume that the buffer is large enough for the whole report */
> +	if ((max_len - offset) < len) {
> +		/* FIXME!! the error code */
> +		ret = -ENOMEM;
> +		goto err_out;
> +	}
> +
> +	if (copy_to_user(user_buf + offset, buf, len)) {
> +		ret = -EIO;
> +		goto err_out;
> +	}
> +	ret = len;
> +err_out:

Definitely makes sense to just return directly in the error paths above and
just return len here


> +	return ret;
> +}
> +
>  void rme_register_exit_handlers(void)
>  {
>  	realm_exit_vdev_comm_handler = rme_exit_vdev_comm_handler;
> diff --git a/drivers/virt/coco/arm-cca-host/rmm-da.h b/drivers/virt/coco/arm-cca-host/rmm-da.h
> index cebddab8464d..457660ff3b69 100644
> --- a/drivers/virt/coco/arm-cca-host/rmm-da.h
> +++ b/drivers/virt/coco/arm-cca-host/rmm-da.h
> @@ -10,6 +10,7 @@
>  #include <linux/pci-ide.h>
>  #include <linux/pci-tsm.h>
>  #include <asm/rmi_smc.h>
> +#include <asm/rhi.h>
>  
>  #define MAX_CACHE_OBJ_SIZE	4096
>  struct cache_object {
> @@ -101,4 +102,7 @@ void *rme_create_vdev(struct realm *realm, struct pci_dev *pdev,
>  void rme_unbind_vdev(struct realm *realm, struct pci_dev *pdev,
>  		     struct pci_dev *pf0_dev);
>  void rme_register_exit_handlers(void);
> +int rme_get_da_object_size(struct pci_dev *pdev, int type);
> +int rme_da_object_read(struct pci_dev *pdev, int type, unsigned long offset,
> +		       unsigned long max_len, void __user *user_buf);
>  #endif
> diff --git a/include/linux/tsm.h b/include/linux/tsm.h
> index 497a3b4df5a0..e82046b0c7fa 100644
> --- a/include/linux/tsm.h
> +++ b/include/linux/tsm.h
> @@ -145,5 +145,8 @@ struct tsm_guest_req_info {
>  	size_t resp_len;
>  };
>  
> +#define ARM_CCA_DA_OBJECT_SIZE 0x1
> +#define ARM_CCA_DA_OBJECT_READ 0x2
> +
>  int tsm_guest_req(struct device *dev, struct tsm_guest_req_info *info);
>  #endif /* __TSM_H */


