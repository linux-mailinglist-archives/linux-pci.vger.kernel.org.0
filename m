Return-Path: <linux-pci+bounces-39697-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB1D8C1C911
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 18:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7E2A647516
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 17:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5DD34AAE6;
	Wed, 29 Oct 2025 17:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="pyRwohml"
X-Original-To: linux-pci@vger.kernel.org
Received: from sinmsgout02.his.huawei.com (sinmsgout02.his.huawei.com [119.8.177.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF57B3557E8;
	Wed, 29 Oct 2025 17:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=119.8.177.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761759477; cv=none; b=WzEIvqxczpZHY4h+4aPG5HLlEi9+mif/qCqr67U2SdGGO/VlUa0qBYBSQ4JkJPj7srG1XzdOaLhV12qetshB4PYGrG03X/TeZNIByOb/ASue4lrI1DtMLmGaHn7fkwiDqiBzxKEiXt69XcT+ASHACO432YMQkJrznjreSlPsDm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761759477; c=relaxed/simple;
	bh=NDstYw8pmrIPwYWWztjigB9+DQjboyOOhXRFXLhKw1g=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fiGkxeb72Vz4Bo1TvLW/MEsg9EYhwqffONL/1VdKjBU/SIN+JS7GOKiNOBNj0wTgUpe8k/KjI+L+ZEffyf3CvMj9xr2VFjh/V58qjA7PQnNZC6gmG+FOnIUJ52nk73Q+Mrh3DGcE64FDRQjWhMMVc746YPGsENEqnHWWW7FZHFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=pyRwohml; arc=none smtp.client-ip=119.8.177.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=fNgZ48n/OH2NXMzx1CeBANaBiQhOc0HGHvkiCNq+ooA=;
	b=pyRwohmlcL4tyq9QovmR5tmukJHr52XlLp/nAXgnvIOg5SFn9x5WwHn8OCpr+4YJrd9hCEjUF
	HR9feaFgsTUTFMqDn0jNht/aBxtW0G2ymZDTaxR6rBJHB2u/c+Xl1E+ve1csMCknIZxKQDFYzQY
	LKspvzhTnACK/jdCRltXHeI=
Received: from frasgout.his.huawei.com (unknown [172.18.146.33])
	by sinmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4cxZDt1Fhxz1vnLJ;
	Thu, 30 Oct 2025 01:37:02 +0800 (CST)
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4cxZFX1ZSDzJ468T;
	Thu, 30 Oct 2025 01:37:36 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 545ED1402EF;
	Thu, 30 Oct 2025 01:37:46 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 29 Oct
 2025 17:37:45 +0000
Date: Wed, 29 Oct 2025 17:37:43 +0000
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
Subject: Re: [PATCH RESEND v2 05/12] coco: host: arm64: Build and register
 RMM pdev descriptors
Message-ID: <20251029173743.00006d48@huawei.com>
In-Reply-To: <20251027095602.1154418-6-aneesh.kumar@kernel.org>
References: <20251027095602.1154418-1-aneesh.kumar@kernel.org>
	<20251027095602.1154418-6-aneesh.kumar@kernel.org>
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

On Mon, 27 Oct 2025 15:25:55 +0530
"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> wrote:

> Add the SMCCC plumbing for RMI_PDEV_AUX_COUNT, RMI_PDEV_CREATE, and
> RMI_PDEV_GET_STATE, describe the pdev state enum/flags in rmi_smc.h,
> and extend the PF0 descriptor so we can hold the RMM-side pdev handle
> plus its auxiliary granules.
> 
> Implement pdev_create() to delegate backing pages, populate the pdev
> parameters from the device's RID, ECAM window, IDE stream, and
> non-coherent address ranges, and invoke RMI_PDEV_CREATE. The helper
> keeps track of the allocated/assigned granules and unwinds them on
> failure, so the host driver can reliably establish the pdev channel
> before kicking off further IDE/TSM setup.
> 
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
Hi Aneesh

A few things inline.

J
> ---
>  arch/arm64/include/asm/rmi_cmds.h       |  31 ++++++
>  arch/arm64/include/asm/rmi_smc.h        |  94 +++++++++++++++-
>  drivers/virt/coco/arm-cca-host/Makefile |   2 +-
>  drivers/virt/coco/arm-cca-host/rmi-da.c | 141 ++++++++++++++++++++++++
>  drivers/virt/coco/arm-cca-host/rmi-da.h |   5 +
>  5 files changed, 271 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/virt/coco/arm-cca-host/rmi-da.c
> 

> diff --git a/arch/arm64/include/asm/rmi_smc.h b/arch/arm64/include/asm/rmi_smc.h
> index fe1c91ffc0ab..10f87a18f09a 100644
> --- a/arch/arm64/include/asm/rmi_smc.h
> +++ b/arch/arm64/include/asm/rmi_smc.h
> @@ -26,7 +26,7 @@
>  #define SMC_RMI_DATA_CREATE		SMC_RMI_CALL(0x0153)
>  #define SMC_RMI_DATA_CREATE_UNKNOWN	SMC_RMI_CALL(0x0154)
>  #define SMC_RMI_DATA_DESTROY		SMC_RMI_CALL(0x0155)
> -

I'd avoid the white space change. If it makes sense push it to the KVM series
that I guess this was introduced in.

> +#define SMC_RMI_PDEV_AUX_COUNT		SMC_RMI_CALL(0x0156)

>  #define RMI_ABI_MAJOR_VERSION	1
>  #define RMI_ABI_MINOR_VERSION	0
>  
> @@ -269,4 +272,93 @@ struct rec_run {
>  	struct rec_exit exit;
>  };

> +
> +#define MAX_PDEV_AUX_GRANULES	32
> +#define MAX_IOCOH_ADDR_RANGE	16
> +#define MAX_FCOH_ADDR_RANGE	4
> +
> +#define RMI_PDEV_FLAGS_SPDM		BIT(0)
> +#define RMI_PDEV_FLAGS_NCOH_IDE		BIT(1)
> +#define RMI_PDEV_FLAGS_NCOH_ADDR	BIT(2)
> +#define RMI_PDEV_FLAGS_COH_IDE		BIT(3)
> +#define RMI_PDEV_FLAGS_COH_ADDR		BIT(4)
> +#define RMI_PDEV_FLAGS_P2P		BIT(5)
> +#define RMI_PDEV_FLAGS_COMP_TRUST	BIT(6)
> +#define RMI_PDEV_FLAGS_CATEGORY		GENMASK(8, 7)
> +
> +#define RMI_PDEV_CMEM_CXL_CATEGORY	BIT(7)

This smells like it's the value 1 in the RMI_PDEV_FLAGS_CATEGORY field?
If so don't use a bit definition like this. Instead a suitably named field value definition.
e.g. #define RMI_PDEV_FLAGS_CATEGORY_CXL 1


> diff --git a/drivers/virt/coco/arm-cca-host/rmi-da.c b/drivers/virt/coco/arm-cca-host/rmi-da.c
> new file mode 100644
> index 000000000000..390b8f05c7cf
> --- /dev/null
> +++ b/drivers/virt/coco/arm-cca-host/rmi-da.c

> +
> +static int init_pdev_params(struct pci_dev *pdev, struct rmi_pdev_params *params)
> +{
> +	int rid, ret, i;
> +	phys_addr_t aux_phys;
> +	struct pci_config_window *cfg = pdev->bus->sysdata;
> +	struct cca_host_pf0_dsc *pf0_dsc = to_cca_pf0_dsc(pdev);
> +	struct pci_ide *ide = pf0_dsc->sel_stream;
> +
> +	/* assign the ep device with RMM */
> +	rid = pci_dev_id(pdev);
> +	params->pdev_id = rid;
> +	/* slot number for certificate chain */
> +	params->cert_id = 0;
> +	/* io coherent spdm/ide and non p2p */
> +	params->flags = RMI_PDEV_FLAGS_SPDM | RMI_PDEV_FLAGS_NCOH_IDE |
> +			RMI_PDEV_FLAGS_NCOH_ADDR;
> +	params->ncoh_ide_sid = ide->stream_id;
> +	params->hash_algo = RMI_HASH_SHA_256;
> +	/* use the rid and MMIO resources of the end point pdev */
> +	params->rid_base = rid;
> +	params->rid_top = params->rid_base + 1;
> +	params->ecam_addr = cfg->res.start;
> +	params->root_id = pci_dev_id(pcie_find_root_port(pdev));
> +
> +	params->ncoh_num_addr_range = pci_ide_aassoc_register_to_pdev_addr(params->ncoh_addr_range,
> +								ARRAY_SIZE(params->ncoh_addr_range),
> +								&ide->partner[PCI_IDE_RP]);
I'd format as:
	params->ncoh_num_addr_range =
		pci_ide_aassoc_register_to_pdev_addr(params->ncoh_addr_range,
						     ARRAY_SIZE(params->ncoh_addr_range),
						     &ide->partner[PCI_IDE_RP]);

> +
> +	rmi_pdev_aux_count(params->flags, &params->num_aux);
> +	pf0_dsc->num_aux = params->num_aux;
> +	for (i = 0; i < params->num_aux; i++) {
> +		void *aux =  (void *)__get_free_page(GFP_KERNEL);
One space only before cast.

> +
> +		if (!aux) {
> +			ret = -ENOMEM;
> +			goto err_free_aux;
> +		}
> +
> +		aux_phys = virt_to_phys(aux);
> +		if (rmi_granule_delegate(aux_phys)) {
> +			ret = -ENXIO;
> +			free_page((unsigned long)aux);
> +			goto err_free_aux;
> +		}
> +		params->aux_granule[i] = aux_phys;
> +		pf0_dsc->aux[i] = aux;
> +	}
> +	return 0;
> +
> +err_free_aux:
> +	free_aux_pages(i, pf0_dsc->aux);
> +	return ret;
> +}

> diff --git a/drivers/virt/coco/arm-cca-host/rmi-da.h b/drivers/virt/coco/arm-cca-host/rmi-da.h
> index 01dfb42cd39e..6764bf8d98ce 100644
> --- a/drivers/virt/coco/arm-cca-host/rmi-da.h
> +++ b/drivers/virt/coco/arm-cca-host/rmi-da.h

>  struct cca_host_fn_dsc {
> @@ -38,4 +42,5 @@ static inline struct cca_host_fn_dsc *to_cca_fn_dsc(struct pci_dev *pdev)
>  	return container_of(tsm, struct cca_host_fn_dsc, pci);
>  }
>  
> +int pdev_create(struct pci_dev *pdev);
That is a very generic name to find in a header, even one buried deep in drivers.
I'd prefix it with somethin more specific rmi_pdev_create() or something like that.

>  #endif


