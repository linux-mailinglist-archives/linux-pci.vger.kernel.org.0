Return-Path: <linux-pci+bounces-33181-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1435EB1620E
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 15:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 186687B3E71
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 13:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471A32D94A1;
	Wed, 30 Jul 2025 13:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="wzSHR/bR"
X-Original-To: linux-pci@vger.kernel.org
Received: from sinmsgout02.his.huawei.com (sinmsgout02.his.huawei.com [119.8.177.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E89629DB8F;
	Wed, 30 Jul 2025 13:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=119.8.177.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753883842; cv=none; b=PK8YKlAGvAIxdjhqsvfhCHglC2YOUf690chA8JzPmf9ndhujI3qbgH73e2QOOLOA46KDnJTTA5M8/Olr5ydTEkfzNQclMnNApIIQbwi/C5OffAypWLwOaEZM9VvTY9Rh8wJmZkfihNWmaWFhv5qh0n6p7ze9z1wEgmAqiRC2BKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753883842; c=relaxed/simple;
	bh=uQ1UYrwH0/53F7ngVoDfjOFYxgyygQ8nxHBIBAc+/hg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ifq66bBY8lQ9OzJwAToL9ep6M0ZZe49Ddfb0LwP0Zqxx0J0kxJfACMDWkLHsCRpCjo3N0Z3I1oR2DtwEM+oipDL/x1EjE6UQZC9ST6qrWlSXrjC7+xYyGTN1Fz7KQltByft1CtKHghVb9aGWsLza2lnH3p7gudSA41fLttoH7C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=wzSHR/bR; arc=none smtp.client-ip=119.8.177.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=PQj4hXynEm5aScbEfuGnihzcPyYwYpjxnhAnzZkYjiY=;
	b=wzSHR/bRKg73t+PLfQ7iO6Zq73kQ7/Lfsrj6MROcP/4WS+0qD+G4leEP2nJtTb9kUVq3hodw6
	Rd9aqWATKiKSUCAOolaWxVhD/TEwnhU/mwmOegrbxCtImjY7Lnci19txNyiVdJi3bFrCSlvQ2RA
	QWg0entsBF7h6M4SPc4rTe8=
Received: from frasgout.his.huawei.com (unknown [172.18.146.35])
	by sinmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4bsYdR0VPzz1vnKc;
	Wed, 30 Jul 2025 21:55:38 +0800 (CST)
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bsYdM1TDBz6M4Z3;
	Wed, 30 Jul 2025 21:55:35 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 43F971401DC;
	Wed, 30 Jul 2025 21:57:11 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 30 Jul
 2025 15:57:10 +0200
Date: Wed, 30 Jul 2025 14:57:08 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
CC: <linux-coco@lists.linux.dev>, <kvmarm@lists.linux.dev>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <aik@amd.com>,
	<lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>, Xu Yilun
	<yilun.xu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, "Suzuki K
 Poulose" <Suzuki.Poulose@arm.com>, Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>,
	Will Deacon <will@kernel.org>, Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [RFC PATCH v1 15/38] coco: host: arm64: Stop and destroy the
 physical device
Message-ID: <20250730145708.00005181@huawei.com>
In-Reply-To: <20250728135216.48084-16-aneesh.kumar@kernel.org>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
	<20250728135216.48084-16-aneesh.kumar@kernel.org>
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

On Mon, 28 Jul 2025 19:21:52 +0530
"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> wrote:

> Add support for stopping and destroying physical devices.

I think it's an odd mix to not do create and destroy in a single patch.
Same with start and stop.
Leaves reviewers thinking perhaps you weren't cleaning up properly
an any error paths are much less obvious.

> 
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>  arch/arm64/include/asm/rmi_cmds.h        | 18 ++++++++++++++++++
>  arch/arm64/include/asm/rmi_smc.h         |  2 ++
>  drivers/virt/coco/arm-cca-host/arm-cca.c |  3 +++
>  drivers/virt/coco/arm-cca-host/rmm-da.c  | 21 +++++++++++++++++++++
>  drivers/virt/coco/arm-cca-host/rmm-da.h  |  1 +
>  5 files changed, 45 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/rmi_cmds.h b/arch/arm64/include/asm/rmi_cmds.h
> index eb0034a675bb..d4ea9f8363f5 100644
> --- a/arch/arm64/include/asm/rmi_cmds.h
> +++ b/arch/arm64/include/asm/rmi_cmds.h
> @@ -547,4 +547,22 @@ static inline unsigned long rmi_pdev_communicate(unsigned long pdev_phys,
>  	return res.a0;
>  }
>  
> +static inline unsigned long rmi_pdev_stop(unsigned long pdev_phys)
> +{
> +	struct arm_smccc_res res;
> +
> +	arm_smccc_1_1_invoke(SMC_RMI_PDEV_STOP, pdev_phys, &res);
> +
> +	return res.a0;
> +}
> +
> +static inline unsigned long rmi_pdev_destroy(unsigned long pdev_phys)
> +{
> +	struct arm_smccc_res res;
> +
> +	arm_smccc_1_1_invoke(SMC_RMI_PDEV_DESTROY, pdev_phys, &res);
> +
> +	return res.a0;
> +}
> +
>  #endif /* __ASM_RMI_CMDS_H */
> diff --git a/arch/arm64/include/asm/rmi_smc.h b/arch/arm64/include/asm/rmi_smc.h
> index 8bece465b670..9f25a876238e 100644
> --- a/arch/arm64/include/asm/rmi_smc.h
> +++ b/arch/arm64/include/asm/rmi_smc.h
> @@ -49,7 +49,9 @@
>  
>  #define SMC_RMI_PDEV_COMMUNICATE        SMC_RMI_CALL(0x0175)
>  #define SMC_RMI_PDEV_CREATE             SMC_RMI_CALL(0x0176)
> +#define SMC_RMI_PDEV_DESTROY		SMC_RMI_CALL(0x0177)
>  #define SMC_RMI_PDEV_GET_STATE		SMC_RMI_CALL(0x0178)
> +#define SMC_RMI_PDEV_STOP		SMC_RMI_CALL(0x017c)
>  
>  #define RMI_ABI_MAJOR_VERSION	1
>  #define RMI_ABI_MINOR_VERSION	0
> diff --git a/drivers/virt/coco/arm-cca-host/arm-cca.c b/drivers/virt/coco/arm-cca-host/arm-cca.c
> index 294a6ef60d5f..c65b81f0706f 100644
> --- a/drivers/virt/coco/arm-cca-host/arm-cca.c
> +++ b/drivers/virt/coco/arm-cca-host/arm-cca.c
> @@ -210,12 +210,15 @@ static void cca_tsm_disconnect(struct pci_dev *pdev)
>  	ide = dsc_pf0->sel_stream;
>  	dsc_pf0->sel_stream = NULL;
>  	pci_ide_stream_disable(pdev, ide);
> +	rme_unassign_device(pdev);
> +	module_put(THIS_MODULE);
>  	tsm_ide_stream_unregister(ide);
>  	pci_ide_stream_teardown(rp, ide);
>  	pci_ide_stream_teardown(pdev, ide);
>  	pci_ide_stream_unregister(ide);
>  	clear_bit(ide->stream_id, cca_stream_ids);
>  	pci_ide_stream_free(ide);
> +	free_dev_communication_buffers(&dsc_pf0->comm_data);
>  }
>  
>  static const struct pci_tsm_ops cca_pci_ops = {
> diff --git a/drivers/virt/coco/arm-cca-host/rmm-da.c b/drivers/virt/coco/arm-cca-host/rmm-da.c
> index d123940ce82e..ec8c5bfcee35 100644
> --- a/drivers/virt/coco/arm-cca-host/rmm-da.c
> +++ b/drivers/virt/coco/arm-cca-host/rmm-da.c
> @@ -346,3 +346,24 @@ int schedule_rme_ide_setup(struct pci_dev *pdev)
>  
>  	return 0;
>  }
> +
> +void rme_unassign_device(struct pci_dev *pdev)
> +{
> +	unsigned long ret;
> +	unsigned long state;
> +	phys_addr_t rmm_pdev_phys;
> +	struct cca_host_dsc_pf0 *dsc_pf0;
> +
> +	dsc_pf0 = to_cca_dsc_pf0(pdev);
> +	rmm_pdev_phys = virt_to_phys(dsc_pf0->rmm_pdev);

As with previous patches, I'd set as many of these are seems reasonable at the
variable declations.

> +	ret = rmi_pdev_stop(rmm_pdev_phys);
> +	if (WARN_ON(ret != RMI_SUCCESS))
> +		return;
> +
> +	state = do_pdev_communicate(pdev->tsm, RMI_PDEV_STOPPED);
> +	/* ignore the error state and destroy the device */
WARN_ON is rather heavy if you want to ignore it.

> +	WARN_ON(state != RMI_PDEV_STOPPED);
> +	ret = rmi_pdev_destroy(rmm_pdev_phys);
> +	if (WARN_ON(ret != RMI_SUCCESS))
> +		return;
> +}
> diff --git a/drivers/virt/coco/arm-cca-host/rmm-da.h b/drivers/virt/coco/arm-cca-host/rmm-da.h
> index b9ddc4d9112b..c401be55d770 100644
> --- a/drivers/virt/coco/arm-cca-host/rmm-da.h
> +++ b/drivers/virt/coco/arm-cca-host/rmm-da.h
> @@ -71,5 +71,6 @@ static inline struct cca_host_comm_data *to_cca_comm_data(struct pci_dev *pdev)
>  }
>  
>  int rme_asign_device(struct pci_dev *pdev);
> +void rme_unassign_device(struct pci_dev *pdev);
>  int schedule_rme_ide_setup(struct pci_dev *pdev);
>  #endif


