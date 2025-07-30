Return-Path: <linux-pci+bounces-33191-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E403B16315
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 16:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDE9B7A2BB8
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 14:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3FF2298CA6;
	Wed, 30 Jul 2025 14:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Qm3xWw6g"
X-Original-To: linux-pci@vger.kernel.org
Received: from sinmsgout02.his.huawei.com (sinmsgout02.his.huawei.com [119.8.177.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7927E1953A1;
	Wed, 30 Jul 2025 14:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=119.8.177.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753886802; cv=none; b=taTQs9J5iD0p+EfjZkqWLp7k/JM4z7lCwBPgHH3ipAKLilwqO9suaNItpMfN3TiQQN/OIMDwt9A7paLRSJiWPgFui43062iimvY1EENOoHpF9YmKzxYwJ8e4W37YT9KPNM/imdNil7g1tEpMYG2u+EnK+onTM3KI4QDQO4lbLY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753886802; c=relaxed/simple;
	bh=fv8z732sb0X7FzfQv/LemtDxEILk4pkH79izQS4oPcc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iG7SCwL8y5kUUi6doEwEHJdtPODFKMliMO1r6IXlnre/iqYqp+D2x33gFQzVx8wiDTRfQsCJrSMRuYFH/R0scLPV9SArxWbHutoCvcU13AFlLfdB0+L0y7QyRyuYSQe8L6Mh/q8NR0GcFAAV6RT2FVK0W5vgY/nKxbD9LH8SmVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Qm3xWw6g; arc=none smtp.client-ip=119.8.177.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=gDYuSUHEA/sgI6zOOL1uogU4Aat+EC2bRnpHV0fNS/w=;
	b=Qm3xWw6g48vH8xrLWZO/dGKQFGudk8v6f/koYNcKOk+JXGBYrj+3QXLXm5CP2+RLa8v2A19QV
	6Iqvi80S9yaahqrMT1duBJAWckGaAFygmROtmETbnqjwbYoq1JjQLzxeFqYIClPsXYFIpwr9feQ
	CqkFkv9aXXjmMz0WJGyWLJ0=
Received: from frasgout.his.huawei.com (unknown [172.18.146.36])
	by sinmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4bsZkN5KDzz1vnKW;
	Wed, 30 Jul 2025 22:45:00 +0800 (CST)
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bsZjw6gwfz6L58r;
	Wed, 30 Jul 2025 22:44:36 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id E4A83140122;
	Wed, 30 Jul 2025 22:46:32 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 30 Jul
 2025 16:46:31 +0200
Date: Wed, 30 Jul 2025 15:46:30 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
CC: <linux-coco@lists.linux.dev>, <kvmarm@lists.linux.dev>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <aik@amd.com>,
	<lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>, Xu Yilun
	<yilun.xu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, "Suzuki K
 Poulose" <Suzuki.Poulose@arm.com>, Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>,
	Will Deacon <will@kernel.org>, Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [RFC PATCH v1 31/38] coco: guest: arm64: Add support for
 fetching interface report and certificate chain from host
Message-ID: <20250730154630.00004905@huawei.com>
In-Reply-To: <20250728135216.48084-32-aneesh.kumar@kernel.org>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
	<20250728135216.48084-32-aneesh.kumar@kernel.org>
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

On Mon, 28 Jul 2025 19:22:08 +0530
"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> wrote:

> Fetch interface report and certificate chain from the host using RHI calls.
> 
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

Comments inline

> diff --git a/drivers/virt/coco/arm-cca-guest/rsi-da.c b/drivers/virt/coco/arm-cca-guest/rsi-da.c
> index 28ec946df1e2..47b379318e7c 100644
> --- a/drivers/virt/coco/arm-cca-guest/rsi-da.c
> +++ b/drivers/virt/coco/arm-cca-guest/rsi-da.c
> @@ -4,6 +4,7 @@
>   */
>  
>  #include <linux/pci.h>
> +#include <linux/mem_encrypt.h>
>  #include <asm/rsi_cmds.h>
>  
>  #include "rsi-da.h"
> @@ -50,6 +51,121 @@ rsi_rdev_get_interface_report(struct pci_dev *pdev, unsigned long vdev_id,
>  	return RSI_SUCCESS;
>  }
>  
> +static long rhi_get_report(int vdev_id, int da_object_type, void **report, int *report_size)
> +{
> +	int ret, enc_ret = 0;
> +	int nr_pages;
> +	int max_data_len;
> +	void *data_buf_shared, *data_buf_private;
> +	struct rsi_host_call *rhicall;
> +
> +	rhicall = kmalloc(sizeof(struct rsi_host_call), GFP_KERNEL);
> +	if (!rhicall)
> +		return -ENOMEM;
> +
> +	rhicall->imm = 0;
> +	rhicall->gprs[0] = RHI_DA_FEATURES;
> +
> +	ret = rsi_host_call(virt_to_phys(rhicall));
> +	if (ret != RSI_SUCCESS) {
> +		ret =  -EIO;

Extra space.

> +		goto err_out;
> +	}
> +
> +	if (rhicall->gprs[0] != 0x3) {
> +		ret =  -EIO;
> +		goto err_out;
> +	}
> +
> +	rhicall->imm = 0;
> +	rhicall->gprs[0] = RHI_DA_OBJECT_SIZE;
> +	rhicall->gprs[1] = vdev_id;
> +	rhicall->gprs[2] = da_object_type;
> +
> +	ret = rsi_host_call(virt_to_phys(rhicall));
> +	if (ret != RSI_SUCCESS) {
> +		ret =  -EIO;
> +		goto err_out;
> +	}
> +	if (rhicall->gprs[0] != RHI_DA_SUCCESS) {
> +		ret =  -EIO;
> +		goto err_out;
> +	}
> +	max_data_len = rhicall->gprs[1];
> +	*report_size = max_data_len;
> +
> +	/*
> +	 * We need to share this memory with hypervisor.
> +	 * So it should be multiple of sharing unit.
> +	 */
> +	max_data_len = ALIGN(max_data_len, PAGE_SIZE);
> +	nr_pages = max_data_len >> PAGE_SHIFT;
> +
> +	if (!max_data_len || nr_pages > MAX_ORDER_NR_PAGES) {
> +		ret = -ENOMEM;
> +		goto err_out;
> +	}
> +
> +	/*
> +	 * We need to share this memory with hypervisor.
> +	 * So it should be multiple of sharing unit.
> +	 */
> +	data_buf_shared = (void *)__get_free_pages(GFP_KERNEL, get_order(max_data_len));
> +	if (!data_buf_shared) {
> +		ret =  -ENOMEM;

extra space.  All of these seem to have one.  Not seeing a reason for it
though.


> +		goto err_out;
> +	}
> +
> +	data_buf_private = kmalloc(*report_size, GFP_KERNEL);
> +	if (!data_buf_private) {
> +		ret =  -ENOMEM;
> +		goto err_private_alloc;
> +	}
> +
> +	ret = set_memory_decrypted((unsigned long)data_buf_shared, nr_pages);
> +	if (ret) {
> +		ret =  -EIO;
> +		goto err_decrypt;
> +	}
> +
> +	rhicall->imm = 0;
> +	rhicall->gprs[0] = RHI_DA_OBJECT_READ;
> +	rhicall->gprs[1] = vdev_id;
> +	rhicall->gprs[2] = da_object_type;
> +	rhicall->gprs[3] = 0; /* offset within the data buffer */
> +	rhicall->gprs[4] = max_data_len;
> +	rhicall->gprs[5] = virt_to_phys(data_buf_shared);
> +	ret = rsi_host_call(virt_to_phys(rhicall));
> +	if (ret != RSI_SUCCESS || rhicall->gprs[0] != RHI_DA_SUCCESS) {
> +		ret =  -EIO;
> +		goto err_rhi_call;
> +	}
> +
> +	memcpy(data_buf_private, data_buf_shared, *report_size);
> +	enc_ret = set_memory_encrypted((unsigned long)data_buf_shared, nr_pages);
> +	if (!enc_ret)
> +		/* If we fail to mark it encrypted don't free it back */
> +		free_pages((unsigned long)data_buf_shared, get_order(max_data_len));
> +
> +	*report = data_buf_private;
> +	kfree(rhicall);
> +	return 0;
> +
> +err_rhi_call:
> +	enc_ret = set_memory_encrypted((unsigned long)data_buf_shared, nr_pages);
> +err_decrypt:
> +	kfree(data_buf_private);
> +err_private_alloc:
> +	if (!enc_ret)
> +		/* If we fail to mark it encrypted don't free it back */
> +		free_pages((unsigned long)data_buf_shared, get_order(max_data_len));
> +err_out:
I'd expect there to be nothing to do except return under an err_out label
So rename it.

> +	*report = NULL;
> +	*report_size = 0;
> +	kfree(rhicall);
> +	return ret;
> +}
> +
>  int rsi_device_lock(struct pci_dev *pdev)
>  {
>  	unsigned long ret;
> @@ -82,5 +198,20 @@ int rsi_device_lock(struct pci_dev *pdev)
>  		return -EOPNOTSUPP;
>  	}
>  
> +	/* Now make a host call to copy the interface report to guest. */
> +	ret = rhi_get_report(vdev_id, RHI_DA_OBJECT_INTERFACE_REPORT,
> +			     &dsm->interface_report, &dsm->interface_report_size);
> +	if (ret) {
> +		pci_err(pdev, "failed to get interface report from the host (%lu)\n", ret);
> +		return -EIO;
> +	}
> +
> +	ret = rhi_get_report(vdev_id, RHI_DA_OBJECT_CERTIFICATE,
> +			     &dsm->certificate, &dsm->certificate_size);
> +	if (ret) {
> +		pci_err(pdev, "failed to get device certificate from the host (%lu)\n", ret);
> +		return -EIO;
> +	}
> +

>  	return ret;
return 0;

>  }


