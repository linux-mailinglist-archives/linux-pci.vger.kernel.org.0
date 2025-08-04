Return-Path: <linux-pci+bounces-33341-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A98B19AB0
	for <lists+linux-pci@lfdr.de>; Mon,  4 Aug 2025 06:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93D037AB03C
	for <lists+linux-pci@lfdr.de>; Mon,  4 Aug 2025 04:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ADAB22576E;
	Mon,  4 Aug 2025 04:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q0uYI2MN"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DC02248B5;
	Mon,  4 Aug 2025 04:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754281043; cv=none; b=lHsDiy3nS5TCmwdMqE7JKT2GQmnpQy+5aTvPkdK0vzau5hecKnd/zJqAmXB5YGI7OcuYtio7vy7sjU6lpzTfpOYWLaoXhAB52sJ6Z7Kza32M23mJUy79GqCeDTFl311I7Gn6vzkcGWO+Mpna6IT9RFKUfVMcfhzYXaCFcWLv1vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754281043; c=relaxed/simple;
	bh=o4IjvNMM7tJSWXRpMT61RxOAfr06yTVYXSmWzPGeq5E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pvLG8H6mz+Om75BNQpRU49i617HMLoCLUFlx4w+m/mpfimY9lTdyDRXxMde8PqSe88XyTh38UYJKdS0IxofTjtRGGgyLt02oYWrK9YhB7Mw97B2FhINvbgevmotDoseuPZXKObEkA5DAoC4HmxiH1uLMxtOz4DzqU/4cYOE0PV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q0uYI2MN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E545FC4CEE7;
	Mon,  4 Aug 2025 04:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754281043;
	bh=o4IjvNMM7tJSWXRpMT61RxOAfr06yTVYXSmWzPGeq5E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Q0uYI2MNm064dZdIdBMbbnWunRdGqSmvx7Q9JYfxNPxLRPxmM3TpUYlUpsn8lCx62
	 sqzTNicDXez5JXf+0uRyfZ5nConaxuWF0dLNJeYhT7XZaY8tthh1iOLcfT/Ku7kVg0
	 HACQ5Glf5g825toQ5JR4TzvJEok5fWnFn254Owcw048/OyGAIimwlHiS5xOR6pGlwM
	 Lw3Fqx0uD6A6yYDAFBWDWDx6rcLihug2K5IJla8lSQo8yNOWUgfS5FtxeQWfYnEfV2
	 6hMY8NVkzGgv+Z78sBGwDAgDV5Aw7KcOFecAbxz9177DGhaZbFdWpEB3EWQWv1D5X9
	 pfyn1YQk9iVUA==
X-Mailer: emacs 30.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-coco@lists.linux.dev, kvmarm@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, aik@amd.com,
	lukas@wunner.de, Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [RFC PATCH v1 14/38] coco: host: arm64: Device communication
 support
In-Reply-To: <20250730145248.000043be@huawei.com>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
 <20250728135216.48084-15-aneesh.kumar@kernel.org>
 <20250730145248.000043be@huawei.com>
Date: Mon, 04 Aug 2025 09:47:16 +0530
Message-ID: <yq5a5xf3afg3.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:

> On Mon, 28 Jul 2025 19:21:51 +0530
> "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> wrote:
>
>> Add helpers for device communication from RMM
>> 
>> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
>> ---
>>  arch/arm64/include/asm/rmi_cmds.h        |  11 ++
>>  arch/arm64/include/asm/rmi_smc.h         |  49 ++++++
>>  drivers/virt/coco/arm-cca-host/arm-cca.c |  45 ++++++
>>  drivers/virt/coco/arm-cca-host/rmm-da.c  | 198 +++++++++++++++++++++++
>>  drivers/virt/coco/arm-cca-host/rmm-da.h  |  41 +++++
>>  5 files changed, 344 insertions(+)
>> 
>
>>  #endif /* __ASM_RMI_CMDS_H */
>> diff --git a/arch/arm64/include/asm/rmi_smc.h b/arch/arm64/include/asm/rmi_smc.h
>> index a84ed61e5001..8bece465b670 100644
>> --- a/arch/arm64/include/asm/rmi_smc.h
>> +++ b/arch/arm64/include/asm/rmi_smc.h
>> @@ -47,6 +47,7 @@
>
>>  
>> +#define RMI_DEV_COMM_EXIT_CACHE_REQ	BIT(0)
>> +#define RMI_DEV_COMM_EXIT_CACHE_RSP	BIT(1)
>> +#define RMI_DEV_COMM_EXIT_SEND		BIT(2)
>> +#define RMI_DEV_COMM_EXIT_WAIT		BIT(3)
>> +#define RMI_DEV_COMM_EXIT_MULTI		BIT(4)
>> +
>> +#define RMI_DEV_COMM_NONE	0
>> +#define RMI_DEV_COMM_RESPONSE	1
>> +#define RMI_DEV_COMM_ERROR	2
>> +
>> +#define RMI_PROTOCOL_SPDM		0
>> +#define RMI_PROTOCOL_SECURE_SPDM	1
>> +
>> +#define RMI_DEV_VCA			0
>> +#define RMI_DEV_CERTIFICATE		1
>> +#define RMI_DEV_MEASUREMENTS		2
>> +#define RMI_DEV_INTERFACE_REPORT	3
>> +
>> +struct rmi_dev_comm_enter {
>> +	u64 status;
>> +	u64 req_addr;
>> +	u64 resp_addr;
>> +	u64 resp_len;
>> +};
>> +
>> +struct rmi_dev_comm_exit {
>> +	u64 flags;
>> +	u64 cache_req_offset;
>> +	u64 cache_req_len;
>> +	u64 cache_rsp_offset;
>> +	u64 cache_rsp_len;
>> +	u64 cache_obj_id;
>> +	u64 protocol;
>> +	u64 req_len;
>> +	u64 timeout;
> In latest spec called rsp_timeout.
> Not sure we care that much but if no strong reason otherwise, should
> aim to match the spec text. (Maybe this got renamed?)
>> +};
>
>> diff --git a/drivers/virt/coco/arm-cca-host/arm-cca.c b/drivers/virt/coco/arm-cca-host/arm-cca.c
>> index 84d97dd41191..294a6ef60d5f 100644
>> --- a/drivers/virt/coco/arm-cca-host/arm-cca.c
>> +++ b/drivers/virt/coco/arm-cca-host/arm-cca.c
>> @@ -85,6 +85,45 @@ static void cca_tsm_pci_remove(struct pci_tsm *tsm)
>>  	vfree(dsc_pf0);
>>  }
>>  
>> +static int init_dev_communication_buffers(struct cca_host_comm_data *comm_data)
>> +{
>> +	int ret = -ENOMEM;
>> +
>> +	comm_data->io_params = (struct rmi_dev_comm_data *)get_zeroed_page(GFP_KERNEL);
>
> Hmm. There isn't a DEFINE_FREE() yet for free_page().  Maybe time to add one.
> If we did then we'd use local variables until all allocations succeed then
> assign with no_free_ptr()
>
>
>> +	if (!comm_data->io_params)
>> +		goto err_out;
>> +
>> +	comm_data->resp_buff = (void *)__get_free_page(GFP_KERNEL);
>> +	if (!comm_data->resp_buff)
>> +		goto err_res_buff;
>> +
>> +	comm_data->req_buff = (void *)__get_free_page(GFP_KERNEL);
>> +	if (!comm_data->req_buff)
>> +		goto err_req_buff;
>> +
>> +
>> +	comm_data->io_params->enter.status = RMI_DEV_COMM_NONE;
>> +	comm_data->io_params->enter.resp_addr = virt_to_phys(comm_data->resp_buff);
>> +	comm_data->io_params->enter.req_addr  = virt_to_phys((void *)comm_data->req_buff);
> I think it's already a a void * and even if it were some other pointer type
> no cast would be necessary.
>
>> +	comm_data->io_params->enter.resp_len = 0;
>> +
>> +	return 0;
>> +
>> +err_req_buff:
>> +	free_page((unsigned long)comm_data->resp_buff);
>> +err_res_buff:
>> +	free_page((unsigned long)comm_data->io_params);
>> +err_out:
>> +	return ret;
>> +}
>> +
>
>> +
>>  /* per root port unique with multiple restrictions. For now global */
>>  static DECLARE_BITMAP(cca_stream_ids, MAX_STREAM_ID);
>>  
>> @@ -124,6 +163,7 @@ static int cca_tsm_connect(struct pci_dev *pdev)
>>  	rc = tsm_ide_stream_register(pdev, ide);
>>  	if (rc)
>>  		goto err_tsm;
>> +	init_dev_communication_buffers(&dsc_pf0->comm_data);
>>  	/*
>>  	 * Take a module reference so that we won't call unregister
>>  	 * without rme_unasign_device
>> @@ -133,6 +173,11 @@ static int cca_tsm_connect(struct pci_dev *pdev)
>>  		goto err_tsm;
>>  	}
>>  	rme_asign_device(pdev);
> 	rme_assign_device() - I obviously missed this earlier!
>
>> +	/*
>> +	 * Schedule a work to fetch device certificate and setup IDE
> Single line comment probably fine here.  Though it perhaps doesn't add
> much over the function name.
>> +	 */
>> +	schedule_rme_ide_setup(pdev);
>> +
>>  	/*
>>  	 * Once ide is setup enable the stream at endpoint
>>  	 * Root port will be done by RMM
>> diff --git a/drivers/virt/coco/arm-cca-host/rmm-da.c b/drivers/virt/coco/arm-cca-host/rmm-da.c
>> index 426e530ac182..d123940ce82e 100644
>> --- a/drivers/virt/coco/arm-cca-host/rmm-da.c
>> +++ b/drivers/virt/coco/arm-cca-host/rmm-da.c
>> @@ -148,3 +148,201 @@ int rme_asign_device(struct pci_dev *pci_dev)
>>  err_out:
>>  	return ret;
>>  }
>> +
>> +static int doe_send_req_resp(struct pci_tsm *tsm)
>> +{
>> +	u8 protocol;
>> +	int ret, data_obj_type;
>> +	struct cca_host_comm_data *comm_data;
>> +	struct rmi_dev_comm_exit *io_exit;
>> +
>> +	comm_data = to_cca_comm_data(tsm->pdev);
>> +
>> +	io_exit = &comm_data->io_params->exit;
>> +	protocol = io_exit->protocol;
>
> For all these I'd combine with the declarations.
>
>> +
>> +	pr_debug("doe_req size:%lld doe_io_type=%d\n", io_exit->req_len, (int)protocol);
>> +
>> +	if (protocol == RMI_PROTOCOL_SPDM)
>> +		data_obj_type = PCI_DOE_PROTO_CMA;
>> +	else if (protocol == RMI_PROTOCOL_SECURE_SPDM)
>> +		data_obj_type = PCI_DOE_PROTO_SSESSION;
>> +	else
>> +		return -EINVAL;
>> +
>> +	ret = pci_tsm_doe_transfer(tsm->dsm_dev, data_obj_type,
>> +				   comm_data->req_buff, io_exit->req_len,
>> +				   comm_data->resp_buff, PAGE_SIZE);
>> +	pr_debug("doe returned:%d\n", ret);
>> +	return ret;
>> +}
>> +
>> +/* Parallel update for cca_dsc contents FIXME!! */
>> +static int __do_dev_communicate(int type, struct pci_tsm *tsm)
>> +{
>> +	int ret;
>> +	bool is_multi;
>> +	u8 *cache_buf;
>> +	int *cache_offset;
>> +	int nbytes, cache_remaining;
>> +	struct cca_host_dsc_pf0 *dsc_pf0;
>> +	struct rmi_dev_comm_exit *io_exit;
>> +	struct rmi_dev_comm_enter *io_enter;
>> +	struct cca_host_comm_data *comm_data;
>> +
>> +
>> +	comm_data = to_cca_comm_data(tsm->pdev);
>> +	io_enter = &comm_data->io_params->enter;
>> +	io_exit = &comm_data->io_params->exit;
>
> Might as well set these local variables as the declaration point
> above.  None of them will be very long lines.
>
>> +
>> +	dsc_pf0 = to_cca_dsc_pf0(tsm->dsm_dev);
>> +redo_communicate:
>> +	is_multi = false;
>> +
>> +	if (type == PDEV_COMMUNICATE)
>> +		ret = rmi_pdev_communicate(virt_to_phys(dsc_pf0->rmm_pdev),
>> +					   virt_to_phys(comm_data->io_params));
>> +	else
>> +		ret = RMI_ERROR_INPUT;
>
> I'd split this case out and return here farther than using the match below
> as it feels like the error message auto to be more specific. Something
> about type not matching.
>

This get updated in the follow up patch as below.

	if (type == PDEV_COMMUNICATE)
		ret = rmi_pdev_communicate(virt_to_phys(dsc_pf0->rmm_pdev),
					   virt_to_phys(comm_data->io_params));
	else {
		struct cca_host_tdi *host_tdi = container_of(tsm->tdi, struct cca_host_tdi, tdi);

		ret = rmi_vdev_communicate(virt_to_phys(dsc_pf0->rmm_pdev),
					   virt_to_phys(host_tdi->rmm_vdev),
					   virt_to_phys(comm_data->io_params));
	}


>
>> +	if (ret != RMI_SUCCESS) {
>> +		pr_err("pdev communicate error\n");
>> +		return ret;
>> +	}
>> +
>> +	/* caching request from RMM */
>> +	if (io_exit->flags & RMI_DEV_COMM_EXIT_CACHE_RSP) {
>> +		switch (io_exit->cache_obj_id) {
>> +		case RMI_DEV_VCA:
>> +			cache_buf = dsc_pf0->vca.buf;
>> +			cache_offset = &dsc_pf0->vca.size;
>> +			cache_remaining = sizeof(dsc_pf0->vca.buf) - *cache_offset;
>> +			break;
>> +		case RMI_DEV_CERTIFICATE:
>> +			cache_buf = dsc_pf0->cert_chain.cache.buf;
>> +			cache_offset = &dsc_pf0->cert_chain.cache.size;
>> +			cache_remaining = sizeof(dsc_pf0->cert_chain.cache.buf) - *cache_offset;
>> +			break;
>> +		default:
>> +			/* FIXME!! depending on the DevComms status,
>> +			 * it might require to ABORT the communcation.
>> +			 */
>> +			return -EINVAL;
>> +		}
>> +
>> +		if (io_exit->cache_rsp_len > cache_remaining)
>> +			return -EINVAL;
>> +
>> +		memcpy(cache_buf + *cache_offset,
>> +		       (comm_data->resp_buff + io_exit->cache_rsp_offset), io_exit->cache_rsp_len);
>> +		*cache_offset += io_exit->cache_rsp_len;
>> +	}
>> +
>> +	/*
>> +	 * wait for last packet request from RMM.
>> +	 * We should not find this because our device communication in synchronous
>> +	 */
>> +	if (io_exit->flags & RMI_DEV_COMM_EXIT_WAIT)
>> +		return -ENXIO;
>> +
>> +	is_multi = !!(io_exit->flags & RMI_DEV_COMM_EXIT_MULTI);
>
> !! doesn't add anything here that I can see over
>
> 	is_multi = io_exit->flags & RMI_DEV_COMM_EXIT_MULTI;
>
>
>> +
>> +	/* next packet to send */
>> +	if (io_exit->flags & RMI_DEV_COMM_EXIT_SEND) {
>> +		nbytes = doe_send_req_resp(tsm);
>> +		if (nbytes < 0) {
>> +			/* report error back to RMM */
>> +			io_enter->status = RMI_DEV_COMM_ERROR;
>> +		} else {
>> +			/* send response back to RMM */
>> +			io_enter->resp_len = nbytes;
>> +			io_enter->status = RMI_DEV_COMM_RESPONSE;
>> +		}
>> +	} else {
>> +		/* no data transmitted => no data received */
>> +		io_enter->resp_len = 0;
>> +	}
>> +
>> +	/* The call need to do multiple request/respnse */
>> +	if (is_multi)
>> +		goto redo_communicate;
>> +
>> +	return 0;
>> +}
>> +
>> +static int do_dev_communicate(int type, struct pci_tsm *tsm, int target_state)
>> +{
>> +	int ret;
>> +	unsigned long state;
>> +	unsigned long error_state;
>> +	struct cca_host_dsc_pf0 *dsc_pf0;
>> +	struct rmi_dev_comm_enter *io_enter;
>> +
>> +	dsc_pf0 = to_cca_dsc_pf0(tsm->dsm_dev);
>> +	io_enter = &dsc_pf0->comm_data.io_params->enter;
>> +	io_enter->resp_len = 0;
>> +	io_enter->status = RMI_DEV_COMM_NONE;
>> +
>> +	state = -1;
>> +	do {
>> +		ret = __do_dev_communicate(type, tsm);
>> +		if (ret != 0) {
> 		if (ret)
>
>> +			pr_err("dev communication error\n");
>> +			break;
>
> I'd just return in error cases.
>
>> +		}
>> +
>> +		if (type == PDEV_COMMUNICATE) {
>> +			ret = rmi_pdev_get_state(virt_to_phys(dsc_pf0->rmm_pdev),
>> +						 &state);
>> +			error_state = RMI_PDEV_ERROR;
>> +		}
>> +		if (ret != 0) {
>> +			pr_err("Get dev state error\n");
>> +			break;
>> +		}
>> +	} while (state != target_state && state != error_state);
>> +
>> +	pr_info("dev_io_complete: status: %d state:%ld\n", ret, state);
>> +
>> +	return state;
>> +}

Thanks for the review comments. I'll update the patch with the suggested changes.

-aneesh

