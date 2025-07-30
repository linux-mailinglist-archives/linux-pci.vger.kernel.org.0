Return-Path: <linux-pci+bounces-33185-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4900FB16279
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 16:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30E5218C079D
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 14:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183F92D9EEC;
	Wed, 30 Jul 2025 14:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="B86QY11L"
X-Original-To: linux-pci@vger.kernel.org
Received: from sinmsgout03.his.huawei.com (sinmsgout03.his.huawei.com [119.8.177.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906CB8BF8;
	Wed, 30 Jul 2025 14:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=119.8.177.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753884969; cv=none; b=TqGR1Ud0FnyiaKomtpXsgJsZlk6y5gXG4TARnePoW+chKAvuuFvr+k4fKQOBL77f/ziRpCoq/nyXKjWQz+3PSIfThanG8bmE6hUiV1XbVfll9+Dr8U9wlzhGTiSWnk5u1hBON/5FYemCxyXSmrx+n9J1/HcHmOtsD6LVyO1v2AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753884969; c=relaxed/simple;
	bh=K43qhxaAdtNeV1ZP+j6U+AZtBVqJFukvQhALAL0IjCc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oi4hhfn6le1UtKw0WueOOwmRX6kJ1cBUQ8cdE5dEb9yqq1jNTfcpkE4sO3Fzrg18NSQm04vC0MKsa8sqXX/vRxhBbQhPJr+ElOeng/dLw9aaZonsIHFX+mCQJZrZ85/rPljuPenOciJB6v66nAxYs9roM4TMcI42KQ/v5OA+34Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=B86QY11L; arc=none smtp.client-ip=119.8.177.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=GF2CxYi5yb3a70XI+8fst4Jr9PexGPUW9uwcHIZeyKs=;
	b=B86QY11Ll0CWDjh37ScdG2D4bBhCesFlrFL4ZGu/OPYTIIALeXJyB8sx22pXS2r2DmZoTXEAs
	ITO1if+D+ZbiC8WP50wImt1B4uMLMGb/zMs5OylkTxTTESPM4xdIuNGUSYbOeQzVISLAThKUGRh
	ZKlwZVd5bW5tB6Cas3KNCLg=
Received: from frasgout.his.huawei.com (unknown [172.18.146.36])
	by sinmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4bsZ395X6gzN04T;
	Wed, 30 Jul 2025 22:14:29 +0800 (CST)
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bsZ2g2dRYz6L5QL;
	Wed, 30 Jul 2025 22:14:03 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 492F51402F4;
	Wed, 30 Jul 2025 22:15:59 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 30 Jul
 2025 16:15:58 +0200
Date: Wed, 30 Jul 2025 15:15:56 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
CC: <linux-coco@lists.linux.dev>, <kvmarm@lists.linux.dev>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <aik@amd.com>,
	<lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>, Xu Yilun
	<yilun.xu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, "Suzuki K
 Poulose" <Suzuki.Poulose@arm.com>, Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>,
	Will Deacon <will@kernel.org>, Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [RFC PATCH v1 22/38] coco: host: arm64: Stop and destroy
 virtual device
Message-ID: <20250730151556.00006855@huawei.com>
In-Reply-To: <20250728135216.48084-23-aneesh.kumar@kernel.org>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
	<20250728135216.48084-23-aneesh.kumar@kernel.org>
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

On Mon, 28 Jul 2025 19:21:59 +0530
"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> wrote:

> Add support for vdev_stop and vdev_destroy.
> 
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
Really trivial comments.

> ---
>  arch/arm64/include/asm/rmi_cmds.h        | 21 ++++++++
>  arch/arm64/include/asm/rmi_smc.h         |  3 +-
>  drivers/virt/coco/arm-cca-host/arm-cca.c | 10 ++++
>  drivers/virt/coco/arm-cca-host/rmm-da.c  | 61 +++++++++++++++++++++++-
>  drivers/virt/coco/arm-cca-host/rmm-da.h  |  2 +
>  5 files changed, 95 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/rmi_cmds.h b/arch/arm64/include/asm/rmi_cmds.h
> index 25197f47a0a9..eb4f67eb6b01 100644
> --- a/arch/arm64/include/asm/rmi_cmds.h
> +++ b/arch/arm64/include/asm/rmi_cmds.h
> @@ -609,4 +609,25 @@ static inline unsigned long rmi_vdev_get_state(unsigned long vdev_phys, unsigned
>  	return res.a0;
>  }
>  
> +static inline unsigned long rmi_vdev_stop(unsigned long vdev_phys)
> +{
> +	struct arm_smccc_res res;
> +
> +	arm_smccc_1_1_invoke(SMC_RMI_VDEV_STOP, vdev_phys, &res);
> +
> +	return res.a0;
> +}
> +
> +static inline unsigned long rmi_vdev_destroy(unsigned long rd,
> +					     unsigned long pdev_phys,
> +					     unsigned long vdev_phys)
> +{
> +	struct arm_smccc_res res;
> +
> +	arm_smccc_1_1_invoke(SMC_RMI_VDEV_DESTROY, rd, pdev_phys, vdev_phys, &res);
> +
> +	return res.a0;
> +}
> +
One is enough.

> +
>  #endif /* __ASM_RMI_CMDS_H */
> diff --git a/arch/arm64/include/asm/rmi_smc.h b/arch/arm64/include/asm/rmi_smc.h
> index 127dd0938604..c6e16ab608e1 100644
> --- a/arch/arm64/include/asm/rmi_smc.h
> +++ b/arch/arm64/include/asm/rmi_smc.h
> @@ -55,8 +55,9 @@
>  #define SMC_RMI_PDEV_STOP		SMC_RMI_CALL(0x017c)
>  #define SMC_RMI_VDEV_COMMUNICATE	SMC_RMI_CALL(0x0186)
>  #define SMC_RMI_VDEV_CREATE		SMC_RMI_CALL(0x0187)
> +#define SMC_RMI_VDEV_DESTROY		SMC_RMI_CALL(0x0188)
>  #define SMC_RMI_VDEV_GET_STATE		SMC_RMI_CALL(0x0189)
> -

There have been a few of these. Check v2 carefully to make sure
no more sneak in.

> +#define SMC_RMI_VDEV_STOP		SMC_RMI_CALL(0x018A)
>  
>  #define RMI_ABI_MAJOR_VERSION	1
>  #define RMI_ABI_MINOR_VERSION	0

>  static void cca_tsm_remove(void *tsm_core)
> diff --git a/drivers/virt/coco/arm-cca-host/rmm-da.c b/drivers/virt/coco/arm-cca-host/rmm-da.c
> index 8635f361bbe8..53072610fa67 100644
> --- a/drivers/virt/coco/arm-cca-host/rmm-da.c
> +++ b/drivers/virt/coco/arm-cca-host/rmm-da.c

> +void rme_unbind_vdev(struct realm *realm, struct pci_dev *pdev, struct pci_dev *pf0_dev)
> +{
> +	int ret;
> +	phys_addr_t rmm_pdev_phys;
> +	phys_addr_t rmm_vdev_phys;
> +	struct cca_host_dsc_pf0 *dsc_pf0;
> +	struct cca_host_tdi *host_tdi;
> +	phys_addr_t rd_phys = virt_to_phys(realm->rd);
> +
> +	host_tdi = container_of(pdev->tsm->tdi, struct cca_host_tdi, tdi);
> +	rmm_vdev_phys = virt_to_phys(host_tdi->rmm_vdev);
> +
> +	dsc_pf0 = to_cca_dsc_pf0(pf0_dev);
> +	rmm_pdev_phys = virt_to_phys(dsc_pf0->rmm_pdev);
> +	/* Request stopping the VDEV */
> +	ret = rmi_vdev_stop(rmm_vdev_phys);
> +	if (ret) {
> +		pr_err("failed to stop vdev (%d)\n", ret);
> +		return;
> +	}
> +
> +	schedule_vdev_unbind(pdev);
> +	ret = rmi_vdev_destroy(rd_phys, rmm_pdev_phys, rmm_vdev_phys);
> +	if (ret) {
> +		pr_err("failed to destroy vdev (%d)\n", ret);
> +		return;

No point in returning here.  Maybe fine to keep this if more code
is coming after this in future patches.

> +	}
> +}


