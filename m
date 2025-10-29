Return-Path: <linux-pci+bounces-39693-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D25A1C1C850
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 18:41:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDAB2583324
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 17:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A38A3115AF;
	Wed, 29 Oct 2025 17:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="qt5ly6lR"
X-Original-To: linux-pci@vger.kernel.org
Received: from sinmsgout01.his.huawei.com (sinmsgout01.his.huawei.com [119.8.177.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7257F2D9ECB;
	Wed, 29 Oct 2025 17:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=119.8.177.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761758293; cv=none; b=OFg/cX2SLcVrDeSkKHrZtCrbNSQHs7DpdGHSaPQtvn93Jp98xeve31i4naRWGVCprlyoIUs6svzlMKon4gTgg73T5aDVSXgFUv/XNGBMwHuYVaDaJtXpcy0pm8dHm6shElJVAkH/mS2MB8a3T1d2cvIfTXgZVmacbJ8azWfuoqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761758293; c=relaxed/simple;
	bh=l2c/vDBsG7K5TJewweXBMQRy7NKiKxNhEUsAr3NwYb8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OK8Zsc/C8lnWES7EJj5YgbossTN3xU3Tk6uVMnwykx+NjkcqK1yRpbtnU29Vz4zPT+1K09I+HSMmq5PQ65HqGW9v+OGz64mgG3ZmnOD0kl9ogmk80UkQWZJIRX0eIG6hw+Uq9+SGxLLDKhpB+Rv7KgH4p4FkRn4HWYebuD7st/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=qt5ly6lR; arc=none smtp.client-ip=119.8.177.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=etNzivr8SvV+X6gAGuBQlMeUCTE9dixbeFJI6Lx0ikE=;
	b=qt5ly6lR1cPZKVCjmHc2Sdf5ORiXrp0WssJ4oNEyMNjC6flDKGCD+Lv3V8APtzynoRCNWhTgO
	29gugGJVmB3ILo+B0nR0CQEEZp6Ff99zyItuLc7lLhKmlqz/roabuIGKSBdnqsFz7GbwoMAy/A1
	Z/OAuvyn/LN6EpgN5Jf3SjU=
Received: from frasgout.his.huawei.com (unknown [172.18.146.37])
	by sinmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4cxYps69f2z1P7Js;
	Thu, 30 Oct 2025 01:17:57 +0800 (CST)
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cxYks4MX7z6GD6J;
	Thu, 30 Oct 2025 01:14:29 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id BFEBD140427;
	Thu, 30 Oct 2025 01:18:02 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 29 Oct
 2025 17:18:01 +0000
Date: Wed, 29 Oct 2025 17:18:00 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
CC: <linux-coco@lists.linux.dev>, <kvmarm@lists.linux.dev>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<dan.j.williams@intel.com>, <aik@amd.com>, <lukas@wunner.de>, Samuel Ortiz
	<sameo@rivosinc.com>, Xu Yilun <yilun.xu@linux.intel.com>, Jason Gunthorpe
	<jgg@ziepe.ca>, Suzuki K Poulose <Suzuki.Poulose@arm.com>, Steven Price
	<steven.price@arm.com>, Bjorn Helgaas <helgaas@kernel.org>, Catalin Marinas
	<catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>, Will Deacon
	<will@kernel.org>, Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [PATCH RESEND v2 04/12] coco: host: arm64: Add host TSM
 callback and IDE stream allocation support
Message-ID: <20251029171800.0000688b@huawei.com>
In-Reply-To: <20251027095602.1154418-5-aneesh.kumar@kernel.org>
References: <20251027095602.1154418-1-aneesh.kumar@kernel.org>
	<20251027095602.1154418-5-aneesh.kumar@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Mon, 27 Oct 2025 15:25:54 +0530
"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> wrote:

> Register the TSM callback when the DA feature is supported by KVM.
> 
> This driver handles IDE stream setup for both the root port and PCIe
> endpoints. Root port IDE stream enablement itself is managed by RMM.
> 
> In addition, the driver registers `pci_tsm_ops` with the TSM subsystem.
> 
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
Minor stuff inline.

> diff --git a/drivers/firmware/smccc/smccc.c b/drivers/firmware/smccc/smccc.c
> index 3dbf0d067cc5..9cabe750533c 100644
> --- a/drivers/firmware/smccc/smccc.c
> +++ b/drivers/firmware/smccc/smccc.c
> @@ -15,6 +15,7 @@
>  #include <asm/archrandom.h>
>  #ifdef CONFIG_ARM64
>  #include <asm/rsi_cmds.h>
> +#include <asm/rmi_smc.h>
>  #endif
>  
>  static u32 smccc_version = ARM_SMCCC_VERSION_1_0;
> @@ -99,10 +100,27 @@ static void __init register_rsi_device(struct platform_device *pdev)
>  					"arm_cca_guest", RSI_DEV_NAME, NULL, 0);
>  
>  }
> +
> +static void __init register_rmi_device(struct platform_device *pdev)
> +{
> +	struct arm_smccc_res res;
> +	unsigned long host_version = RMI_ABI_VERSION(RMI_ABI_MAJOR_VERSION,
> +						     RMI_ABI_MINOR_VERSION);
> +
> +	arm_smccc_1_1_invoke(SMC_RMI_VERSION, host_version, &res);
> +	if (res.a0 == RMI_SUCCESS)
> +		__devm_auxiliary_device_create(&pdev->dev,
> +					"arm_cca_host", RMI_DEV_NAME, NULL, 0);
> +}
>  #else
>  static void __init register_rsi_device(struct platform_device *pdev)
>  {
>  
> +}
> +
> +static void __init register_rmi_device(struct platform_device *pdev)
> +{
> +
>  }
>  #endif

Same comment as before applies. I'd split this to a separate c file and stub
in a header.

> diff --git a/drivers/virt/coco/arm-cca-host/arm-cca.c b/drivers/virt/coco/arm-cca-host/arm-cca.c
> new file mode 100644
> index 000000000000..18e5bf6adea4
> --- /dev/null
> +++ b/drivers/virt/coco/arm-cca-host/arm-cca.c
> @@ -0,0 +1,192 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2025 ARM Ltd.
> + */
> +
> +#include <linux/auxiliary_bus.h>
> +#include <linux/pci-tsm.h>
> +#include <linux/pci-ide.h>
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <linux/tsm.h>
> +#include <linux/vmalloc.h>
> +#include <linux/cleanup.h>
> +#include <linux/kvm_host.h>
> +
> +#include "rmi-da.h"
> +
> +/* Total number of stream id supported at root port level */
> +#define MAX_STREAM_ID	256
> +
> +
> +static struct pci_tsm *cca_tsm_pci_probe(struct tsm_dev *tsm_dev, struct pci_dev *pdev)
> +{
> +	int rc;
> +
> +	if (!is_pci_tsm_pf0(pdev)) {
> +		struct cca_host_fn_dsc *fn_dsc __free(kfree) =
> +			kzalloc(sizeof(*fn_dsc), GFP_KERNEL);
> +
> +		if (!fn_dsc)
> +			return NULL;
> +
> +		rc = pci_tsm_link_constructor(pdev, &fn_dsc->pci, tsm_dev);
> +		if (rc)
> +			return NULL;
> +
> +		return &no_free_ptr(fn_dsc)->pci;
> +	}
> +
> +	if (!pdev->ide_cap)
> +		return NULL;
> +
> +	struct cca_host_pf0_dsc *pf0_dsc __free(kfree) =
> +					kzalloc(sizeof(*pf0_dsc), GFP_KERNEL);

Not sure why this indent. I'd go with more consistent choice of just one tab.

	struct cca_host_pf0_dsc *pf0_dsc __free(kfree) =
		kzalloc(sizeof(*pf0_dsc), GFP_KERNEL);

> +	if (!pf0_dsc)
> +		return NULL;
> +
> +	rc = pci_tsm_pf0_constructor(pdev, &pf0_dsc->pci, tsm_dev);
> +	if (rc)
> +		return NULL;
> +
> +	pci_dbg(pdev, "tsm enabled\n");
> +	return &no_free_ptr(pf0_dsc)->pci.base_tsm;
> +}
> +
> +static void cca_tsm_pci_remove(struct pci_tsm *tsm)
> +{
> +	struct pci_dev *pdev = tsm->pdev;
> +
> +	if (is_pci_tsm_pf0(pdev)) {
> +		struct cca_host_pf0_dsc *pf0_dsc = to_cca_pf0_dsc(pdev);
> +
> +		pci_tsm_pf0_destructor(&pf0_dsc->pci);
> +		kfree(pf0_dsc);
> +	} else {
> +		struct cca_host_fn_dsc *fn_dsc = to_cca_fn_dsc(pdev);
> +
> +		kfree(fn_dsc);
> +		return;
Maybe something else come in in later patches, but for now this return
is unnecessary.
		kfree(to_cca_fn_dsc(pdev));
doesn't loose much if anything wrt to readability.

> +	}
> +}
> +
> +/* For now global for simplicity. Protected by pci_tsm_rwsem */
> +static DECLARE_BITMAP(cca_stream_ids, MAX_STREAM_ID);
> +
> +static int cca_tsm_connect(struct pci_dev *pdev)
> +{
> +	struct pci_dev *rp = pcie_find_root_port(pdev);
> +	struct cca_host_pf0_dsc *pf0_dsc;
> +	struct pci_ide *ide;
> +	int rc, stream_id;
> +
> +	/* Only function 0 supports connect in host */
> +	if (WARN_ON(!is_pci_tsm_pf0(pdev)))
> +		return -EIO;
> +
> +	pf0_dsc = to_cca_pf0_dsc(pdev);
> +	/* Allocate stream id */
> +	stream_id = find_first_zero_bit(cca_stream_ids, MAX_STREAM_ID);
> +	if (stream_id == MAX_STREAM_ID)
> +		return -EBUSY;
> +	set_bit(stream_id, cca_stream_ids);
> +
> +	ide = pci_ide_stream_alloc(pdev);
> +	if (!ide) {
> +		rc = -ENOMEM;
> +		goto err_stream_alloc;
> +	}
> +
> +	pf0_dsc->sel_stream = ide;
> +	ide->stream_id = stream_id;
> +	rc = pci_ide_stream_register(ide);
> +	if (rc)
> +		goto err_stream;
> +
> +	pci_ide_stream_setup(pdev, ide);
> +	pci_ide_stream_setup(rp, ide);
> +
> +	rc = tsm_ide_stream_register(ide);
> +	if (rc)
> +		goto err_tsm;
> +
> +	/*
> +	 * Once ide is setup, enable the stream at the endpoint
> +	 * Root port will be done by RMM
> +	 */
> +	pci_ide_stream_enable(pdev, ide);
> +	return 0;
> +
> +err_tsm:
> +	pci_ide_stream_teardown(rp, ide);
> +	pci_ide_stream_teardown(pdev, ide);
> +	pci_ide_stream_unregister(ide);
> +err_stream:
as below, I'd have
	pf0_dsc->sel_stream = NULL;
here

> +	pci_ide_stream_free(ide);
> +err_stream_alloc:
> +	clear_bit(stream_id, cca_stream_ids);
> +
> +	return rc;
> +}
> +
> +static void cca_tsm_disconnect(struct pci_dev *pdev)
> +{
> +	int stream_id;
> +	struct pci_ide *ide;
> +	struct cca_host_pf0_dsc *pf0_dsc;
> +
> +	pf0_dsc = to_cca_pf0_dsc(pdev);
> +	if (!pf0_dsc)
> +		return;
> +
> +	ide = pf0_dsc->sel_stream;
> +	stream_id = ide->stream_id;
> +	pf0_dsc->sel_stream = NULL;
You go through this dance to unset these in disconnect but
not if we get a failure in connect.  Whilst it might be fine
it looks a little odd so I'd clear pf0_dsc->sel_stream in the
error path of connect.

> +
> +	pci_ide_stream_release(ide);
This helper is a bit irritating as the clearly of pf0_dsc->sel_stream,
if it were in precise opposite of the connect path would occur mid way
through that function.  Ah well, looks safe enough to be out of order
just trickier to review.

> +	clear_bit(stream_id, cca_stream_ids);
> +}

> +static int cca_link_tsm_probe(struct auxiliary_device *adev,
> +			      const struct auxiliary_device_id *id)
> +{
> +	if (kvm_has_da_feature()) {
Unless you expect to see something else after this, I'd flip logic

	struct tsm_dev *tsm_dev;

	if (!kvm_has_da_feature())
		return -ENODEV;

	tsm_dev = tsm_register(&adev->dev, &cca_link_pci_ops);
	if (IS_ERR(tsm_dev))
		return PTR_ERR(tsm_dev);

	return devm_add_action_or_reset(&adev->dev, cca_link_tsm_remove,
					tsm_dev);

Here reduces indent and keeps that 'error path' out of line property
that really helps me at least visually parse code.

> +		struct tsm_dev *tsm_dev;
> +
> +		tsm_dev = tsm_register(&adev->dev, &cca_link_pci_ops);
> +		if (IS_ERR(tsm_dev))
> +			return PTR_ERR(tsm_dev);
> +
> +		return devm_add_action_or_reset(&adev->dev,
> +					cca_link_tsm_remove, tsm_dev);
> +	}
> +	return -ENODEV;
> +}


