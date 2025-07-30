Return-Path: <linux-pci+bounces-33174-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 527C6B16077
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 14:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 794B8564FAE
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 12:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 639B8292B57;
	Wed, 30 Jul 2025 12:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="vpKgVgpk"
X-Original-To: linux-pci@vger.kernel.org
Received: from sinmsgout03.his.huawei.com (sinmsgout03.his.huawei.com [119.8.177.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB58F239E70;
	Wed, 30 Jul 2025 12:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=119.8.177.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753879213; cv=none; b=E6dgxWaj68OCm8Di+a7PQZ85SaP3p2i61n3oZtmQ99kUcbuf9COfnVUhVwgwJvx/Ifs8zzSc/CIlP53LXFPPlTHym3Gd3se/cBmTg8QitlPrc5FNssBngazDA6Qt2tBkfJmfMuedxQXTNiNnko9YOBo2cznqri6eL/0mjHS8ejw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753879213; c=relaxed/simple;
	bh=cfADoiggJSqe0q31QSgaS7tbY5gbPcK0VEHjDffO8Wg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LJN69VkNNJYdqB0iPW6zrAomQPsm5jmpg24Df99igBzr8NQykDbhbHePm5zYu75xK/zfojfA/h/QsFF/m8CQtoE/pYz+XPDF5ucPEUsyY+E5nEyBTTsA3hFD5+pVM4WX2f1QrMjzyKM8Dn8g8oz4DMdIqPmIfmBuOPqduXQjkB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=vpKgVgpk; arc=none smtp.client-ip=119.8.177.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Hj0cmYPEiTq1uiBYRdE32uUyZuDFnKY2ZxNh6sfBbII=;
	b=vpKgVgpkPNsgh5s3LHjtri0Q6TrKm2It05W3PHZKVL3HYTRPE/HCeIUq2lUzEoQFKkOWkNAsO
	Qy/4ybUY+I3VKZGlCTsIt5/QTrU4SMDD5aMh9xWh/UzYJdKqQBeQfPnB2BOWxF0kW9lpShtJdw9
	ua2EVrTml5/KOVXTWR4+mYE=
Received: from frasgout.his.huawei.com (unknown [172.18.146.36])
	by sinmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4bsWwT39dPzN0fT;
	Wed, 30 Jul 2025 20:38:33 +0800 (CST)
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bsWvz0vFLz6L5Vl;
	Wed, 30 Jul 2025 20:38:07 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id D0BDA14044F;
	Wed, 30 Jul 2025 20:40:02 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 30 Jul
 2025 14:40:00 +0200
Date: Wed, 30 Jul 2025 13:39:59 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
CC: <linux-coco@lists.linux.dev>, <kvmarm@lists.linux.dev>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <aik@amd.com>,
	<lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>, Xu Yilun
	<yilun.xu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, "Suzuki K
 Poulose" <Suzuki.Poulose@arm.com>, Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>,
	Will Deacon <will@kernel.org>, Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [RFC PATCH v1 13/38] coco: host: arm64: Create a PDEV with rmm
Message-ID: <20250730133959.0000051b@huawei.com>
In-Reply-To: <20250728135216.48084-14-aneesh.kumar@kernel.org>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
	<20250728135216.48084-14-aneesh.kumar@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 28 Jul 2025 19:21:50 +0530
"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> wrote:

> Create the realm physical device with RMM.
> 
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
Hi Aneesh,

Various small things inline.

Jonathan

> ---
>  arch/arm64/include/asm/rmi_cmds.h        |  31 +++++
>  arch/arm64/include/asm/rmi_smc.h         |  72 ++++++++++-
>  drivers/virt/coco/arm-cca-host/Makefile  |   2 +-
>  drivers/virt/coco/arm-cca-host/arm-cca.c |  10 +-
>  drivers/virt/coco/arm-cca-host/rmm-da.c  | 150 +++++++++++++++++++++++
>  drivers/virt/coco/arm-cca-host/rmm-da.h  |   5 +
>  6 files changed, 267 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/virt/coco/arm-cca-host/rmm-da.c
> 
> diff --git a/arch/arm64/include/asm/rmi_cmds.h b/arch/arm64/include/asm/rmi_cmds.h
> index ef53147c1984..f0817bd3bab4 100644
> --- a/arch/arm64/include/asm/rmi_cmds.h
> +++ b/arch/arm64/include/asm/rmi_cmds.h
> @@ -505,4 +505,35 @@ static inline int rmi_rtt_unmap_unprotected(unsigned long rd,
>  	return res.a0;
>  }
>  
> +static inline unsigned long rmi_pdev_aux_count(unsigned long flags, u64 *aux_count)
> +{
> +	struct arm_smccc_res res;
> +
> +	arm_smccc_1_1_invoke(SMC_RMI_PDEV_AUX_COUNT, flags, &res);
> +
> +	*aux_count = res.a1;
> +	return res.a0;
> +}
> +
> +static inline unsigned long rmi_pdev_create(unsigned long pdev_phys,
> +					    unsigned long pdev_params_phys)
> +{
> +	struct arm_smccc_res res;
> +
> +	arm_smccc_1_1_invoke(SMC_RMI_PDEV_CREATE,
> +			     pdev_phys, pdev_params_phys, &res);
> +
> +	return res.a0;
> +}
> +
> +static inline unsigned long rmi_pdev_get_state(unsigned long pdev_phys, unsigned long *state)

I'd use the enum for the state type and range check in here.


> +{
> +	struct arm_smccc_res res;
> +
> +	arm_smccc_1_1_invoke(SMC_RMI_PDEV_GET_STATE, pdev_phys, &res);
> +
> +	*state = res.a1;
> +	return res.a0;
> +}
> +
>  #endif /* __ASM_RMI_CMDS_H */
> diff --git a/arch/arm64/include/asm/rmi_smc.h b/arch/arm64/include/asm/rmi_smc.h
> index 42708d500048..a84ed61e5001 100644
> --- a/arch/arm64/include/asm/rmi_smc.h
> +++ b/arch/arm64/include/asm/rmi_smc.h
> @@ -26,7 +26,7 @@
>  #define SMC_RMI_DATA_CREATE		SMC_RMI_CALL(0x0153)
>  #define SMC_RMI_DATA_CREATE_UNKNOWN	SMC_RMI_CALL(0x0154)
>  #define SMC_RMI_DATA_DESTROY		SMC_RMI_CALL(0x0155)
> -

Probably keep

> +#define SMC_RMI_PDEV_AUX_COUNT		SMC_RMI_CALL(0x0156)

and add one here as different groups.

>  #define SMC_RMI_REALM_ACTIVATE		SMC_RMI_CALL(0x0157)
>  #define SMC_RMI_REALM_CREATE		SMC_RMI_CALL(0x0158)
>  #define SMC_RMI_REALM_DESTROY		SMC_RMI_CALL(0x0159)
> @@ -47,6 +47,9 @@
>  #define SMC_RMI_RTT_INIT_RIPAS		SMC_RMI_CALL(0x0168)
>  #define SMC_RMI_RTT_SET_RIPAS		SMC_RMI_CALL(0x0169)
>  
> +#define SMC_RMI_PDEV_CREATE             SMC_RMI_CALL(0x0176)
> +#define SMC_RMI_PDEV_GET_STATE		SMC_RMI_CALL(0x0178)
> +
>  #define RMI_ABI_MAJOR_VERSION	1
>  #define RMI_ABI_MINOR_VERSION	0
>  
> @@ -268,4 +271,71 @@ struct rec_run {
>  	struct rec_exit exit;
>  };
>  
> +enum rmi_pdev_state {
Type never used, but I think it should be. See above.

> +	RMI_PDEV_NEW,
> +	RMI_PDEV_NEEDS_KEY,
> +	RMI_PDEV_HAS_KEY,
> +	RMI_PDEV_READY,
Seems someone put another state in here, but I guess you'll update
when the rest of the stack catches up.
	RMI_PDEV_IDE_RESETTING,

Maybe throw a comment here for now.

> +	RMI_PDEV_COMMUNICATING,
> +	RMI_PDEV_STOPPING,
> +	RMI_PDEV_STOPPED,
> +	RMI_PDEV_ERROR,
> +};
> +
> +#define MAX_PDEV_AUX_GRANULES	32
> +#define MAX_IOCOH_ADDR_RANGE	16
> +#define MAX_FCOH_ADDR_RANGE	4
> +
> +#define RMI_PDEV_SPDM_TRUE	BIT(0)
> +#define RMI_PDEV_IDE_TRUE	BIT(1)
> +#define RMI_PDEV_FOCOH		BIT(2)
> +#define RMI_PDEV_P2P_STREAM	BIT(3)

I'd stick flags in the name (assuming this is
RmiPDevFlags? I'm not sure as the spec I could
find has different usages other after BIT(!))


> +
> +#define RMI_HASH_SHA_256	0
> +#define RMI_HASH_SHA_512	1
> +
> +struct rmi_pdev_addr_range {
> +	unsigned long base;
> +	unsigned long top;

Whilst we only care about platforms where this is u64, maybe
just make that explicit so we can trivially see this
matches the spec?

> +};
> +
> +struct rmi_pdev_params {

Reference? Looks like B4.4.25 RmiPdevParams type
in alp15.  Though as there are some fields missing
I guess this chagned.

> +	union {
> +		struct {
> +			u64 flags;
> +			u64 pdev_id;
> +			u64 segment_id;
> +			u64 ecam_addr;
> +			u64 root_id;
> +			u64 cert_id;
> +			u64 rid_base;
> +			u64 rid_top;
> +			u64 hash_algo;
> +			u64 num_aux;
> +			u64 ide_sid;

Called ncoh_ide_side in the alpha 15.  Maybe match that unless
it is changing name in future version.

> +			u64 ncoh_num_addr_range;
> +			u64 coh_num_addr_range;
> +		};
> +		u8 padding1[0x100];
> +	};
> +
> +	union { /* 0x100 */
> +		u64 aux_granule[MAX_PDEV_AUX_GRANULES];
> +		u8 padding2[0x100];
> +	};
> +
> +	union { /* 0x200 */
> +		struct {
> +			struct rmi_pdev_addr_range ncoh_addr_range[MAX_IOCOH_ADDR_RANGE];
> +		};
> +		u8 padding3[0x100];
> +	};
> +	union { /* 0x300 */
> +		struct {
> +			struct rmi_pdev_addr_range coh_addr_range[MAX_FCOH_ADDR_RANGE];
> +		};
> +		u8 padding4[0x100];
> +	};

Maybe pad out the rest?  Mostly so we can see here that it is 4k.

> +};
> +
>  #endif /* __ASM_RMI_SMC_H */

> diff --git a/drivers/virt/coco/arm-cca-host/arm-cca.c b/drivers/virt/coco/arm-cca-host/arm-cca.c
> index c8b0e6db1f47..84d97dd41191 100644
> --- a/drivers/virt/coco/arm-cca-host/arm-cca.c
> +++ b/drivers/virt/coco/arm-cca-host/arm-cca.c
> @@ -124,7 +124,15 @@ static int cca_tsm_connect(struct pci_dev *pdev)
>  	rc = tsm_ide_stream_register(pdev, ide);
>  	if (rc)
>  		goto err_tsm;
> -

Tidy up.  I'd leave it.

> +	/*
> +	 * Take a module reference so that we won't call unregister
> +	 * without rme_unasign_device
> +	 */
> +	if (!try_module_get(THIS_MODULE)) {
> +		rc = -ENXIO;
> +		goto err_tsm;
> +	}
> +	rme_asign_device(pdev);
>  	/*
>  	 * Once ide is setup enable the stream at endpoint
>  	 * Root port will be done by RMM
> diff --git a/drivers/virt/coco/arm-cca-host/rmm-da.c b/drivers/virt/coco/arm-cca-host/rmm-da.c
> new file mode 100644
> index 000000000000..426e530ac182
> --- /dev/null
> +++ b/drivers/virt/coco/arm-cca-host/rmm-da.c
> @@ -0,0 +1,150 @@


> +
> +static int init_pdev_params(struct pci_dev *pdev, struct rmi_pdev_params *params)
> +{
> +	void *aux;

Probably makes sense to reduce scope of aux to within the loop.

> +	int rid, ret, i;
> +	phys_addr_t aux_phys;
> +	struct cca_host_dsc_pf0 *dsc_pf0;
> +	struct pci_dev *rp = pcie_find_root_port(pdev);
Only used in one place for now anyway.  Probably better
to move it down there.

> +	struct pci_config_window *cfg = pdev->bus->sysdata;
> +
> +	dsc_pf0 = to_cca_dsc_pf0(pdev);

I'd do that at declaration.  Seems little advantage in doing it
down here.

> +	/* assign the ep device with RMM */
> +	rid = pci_dev_id(pdev);
> +	params->pdev_id = rid;
> +	/* slot number for certificate chain */
> +	params->cert_id = 0;
> +	/* io coherent spdm/ide and non p2p */
> +	params->flags = RMI_PDEV_SPDM_TRUE | RMI_PDEV_IDE_TRUE;
> +	params->ide_sid = dsc_pf0->sel_stream->stream_id;
> +	params->hash_algo = RMI_HASH_SHA_256;
> +	/* use the rid and MMIO resources of the epdev */

Spell out epdev or associate it with the pdev here more clearly.

> +	params->rid_top = params->rid_base = rid;
> +	params->ecam_addr = cfg->res.start;
> +	params->root_id = pci_dev_id(rp);

	params->root_id = pci_dev_id(pcie_find_root_port(pdev));
to me acts as better documentation fo what is going on than using
the local variable rp.

> +
> +	params->ncoh_num_addr_range = pci_res_to_pdev_addr(params->ncoh_addr_range,
> +							    ARRAY_SIZE(params->ncoh_addr_range),
> +							    pdev->resource,
> +							    DEVICE_COUNT_RESOURCE);
> +
> +	rmi_pdev_aux_count(params->flags, &params->num_aux);
> +	pr_debug("%s using %ld pdev aux granules\n", __func__, (unsigned long)params->num_aux);
> +	dsc_pf0->num_aux = params->num_aux;
> +	for (i = 0; i < params->num_aux; i++) {

		void *aux = (void *)__get_free_page(GFP_KERNEL);

> +		aux = (void *)__get_free_page(GFP_KERNEL);
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
> +		dsc_pf0->aux[i] = aux;
> +	}
> +	return 0;
> +
> +err_free_aux:
> +	free_aux_pages(i, dsc_pf0->aux[i]);

I think you want
	free_aux_pages(i, dsc_pf0->aux);
Assuming this is supposed to unwind the loop above.

> +	return -ENOMEM;
> +}
> +
Trivial: Single line probably fine here.
> +
> +int rme_asign_device(struct pci_dev *pci_dev)
> +{
> +	int ret;
> +	void *rmm_pdev;
> +	unsigned long state;
> +	phys_addr_t rmm_pdev_phys;
> +	struct rmi_pdev_params *params;
> +	struct cca_host_dsc_pf0 *dsc_pf0;
> +
> +	dsc_pf0 = to_cca_dsc_pf0(pci_dev);

Might as well save a line with

	struct cca_host_dsc_pf0 *dsc_pf0 = to_cca_dsc_pf0(pci_dev);

> +	rmm_pdev = (void *)get_zeroed_page(GFP_KERNEL);
> +	if (!rmm_pdev) {
> +		ret = -ENOMEM;

return -ENOMEM;

> +		goto err_out;
> +	}
> +
> +	rmm_pdev_phys = virt_to_phys(rmm_pdev);
> +	if (rmi_granule_delegate(rmm_pdev_phys)) {
> +		ret = -ENXIO;
> +		goto err_free_pdev;
> +	}
> +
> +	params = (struct rmi_pdev_params *)get_zeroed_page(GFP_KERNEL);
> +	if (!params) {
> +		ret = -ENOMEM;
> +		goto err_granule_undelegate;
> +	}
> +
> +	ret = init_pdev_params(pci_dev, params);
> +	if (ret)
> +		goto err_free_params;
> +
> +	ret = rmi_pdev_create(rmm_pdev_phys, virt_to_phys(params));
> +	pr_info("rmi_pdev_create(0x%llx, 0x%llx): %d\n", rmm_pdev_phys, virt_to_phys(params), ret);

RFC, but even so I'd demote to debug and use dynamic debug stuff to enable
them for your testing.

> +	if (ret)
> +		goto err_free_aux;
> +
> +	rmi_pdev_get_state(rmm_pdev_phys, &state);
> +	if (state != RMI_PDEV_NEW)
> +		goto err_free_aux;

Nothing to unwind in rmi_pdev_create()?  We've told the
RMM about it then we blow away it's resources. Seems unwise!
Maybe this is cleaned up elsewhere but if so a comment is
probably good.

> +
> +	dsc_pf0->rmm_pdev = rmm_pdev;
> +	free_page((unsigned long)params);
> +	return 0;
> +
> +err_free_aux:
> +	free_aux_pages(dsc_pf0->num_aux, dsc_pf0->aux);
> +err_free_params:
> +	free_page((unsigned long)params);
> +err_granule_undelegate:
> +	rmi_granule_undelegate(rmm_pdev_phys);
> +err_free_pdev:
> +	free_page((unsigned long)rmm_pdev);
> +err_out:

One of my favourite nitpicks. Why not just return if nothing to do?
That tends to save a reviewer a bit of scrolling when checking
error paths do correct unwinding.

> +	return ret;
> +}
> diff --git a/drivers/virt/coco/arm-cca-host/rmm-da.h b/drivers/virt/coco/arm-cca-host/rmm-da.h
> index 840cb584acdd..179ba68f2430 100644
> --- a/drivers/virt/coco/arm-cca-host/rmm-da.h
> +++ b/drivers/virt/coco/arm-cca-host/rmm-da.h
> @@ -14,6 +14,10 @@
>  struct cca_host_dsc_pf0 {
>  	struct pci_tsm_pf0 pci;
>  	struct pci_ide *sel_stream;
> +
> +	void *rmm_pdev;
> +	int num_aux;
> +	void *aux[MAX_PDEV_AUX_GRANULES];
>  };
>  
>  static inline struct cca_host_dsc_pf0 *to_cca_dsc_pf0(struct pci_dev *pdev)
> @@ -26,4 +30,5 @@ static inline struct cca_host_dsc_pf0 *to_cca_dsc_pf0(struct pci_dev *pdev)
>  	return container_of(tsm, struct cca_host_dsc_pf0, pci.tsm);
>  }
>  
> +int rme_asign_device(struct pci_dev *pdev);
>  #endif


