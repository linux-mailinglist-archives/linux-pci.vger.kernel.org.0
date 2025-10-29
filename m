Return-Path: <linux-pci+bounces-39714-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 953E6C1CC8B
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 19:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2381834B860
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 18:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0E83559F3;
	Wed, 29 Oct 2025 18:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="a6kVryDA"
X-Original-To: linux-pci@vger.kernel.org
Received: from sinmsgout01.his.huawei.com (sinmsgout01.his.huawei.com [119.8.177.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9F9354AE4;
	Wed, 29 Oct 2025 18:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=119.8.177.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761762801; cv=none; b=UfbVmuLdPUejGH9rZbWeGVkp22MF2ijwcYWN6q8Zz4KjMyHgQqG7hE6i94nH1nJuJF6Xaiy4/apKbXslFeGwl2gPGgn/BfUK4/OeVdu6xnppATTZMoKwlCzBzKIBClak7uXwUwTlDnYQ1YLGdwhS7Gr8kfHrbM3r5JK4EyZBu2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761762801; c=relaxed/simple;
	bh=fUaexWlB3Ksus94u95hU4ZFOJ3a7Nb/LfAuUH4Y6FsE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FIQc9N2qEmzbIgNOcn45EaE0DyTOdpWrfdOeUaDpuWS9jPfHiUDKwNH2PUTWM04Wx6oVl17ztlo9C5t6fqGK1uHC7phbd2Qoe6ojB6r2GGagE/tA/DwpX1do4kQR9Plzj8fUuO+h9K5CzlM4PSoNNEaRS5lrynqGe3FhOhn+dKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=a6kVryDA; arc=none smtp.client-ip=119.8.177.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=pmZxCHXh+OmQRNRHVZ9cZOG3zdy3xehwGzAMDhrG0IE=;
	b=a6kVryDAnrAIgupI5ZF5dW1FV4QpZOZkeYQEiESCw9N3RF0mboPy9zsEp4r/SCFPGfbwukHJf
	owFlwPsVa2rsI9TwazyNnK608Mnfo+7G032745fh0j75JlNmXHFW6kXIRSS1+dvRG0tYcteVipo
	HY8CQQ6BKvyEHU5OADrvyBs=
Received: from frasgout.his.huawei.com (unknown [172.18.146.33])
	by sinmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4cxbTX4D3yz1P7HW;
	Thu, 30 Oct 2025 02:33:04 +0800 (CST)
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4cxbTR1hrkzJ469B;
	Thu, 30 Oct 2025 02:32:59 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 67FA41402EF;
	Thu, 30 Oct 2025 02:33:09 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 29 Oct
 2025 18:33:08 +0000
Date: Wed, 29 Oct 2025 18:33:06 +0000
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
Subject: Re: [PATCH RESEND v2 06/12] coco: host: arm64: Add RMM device
 communication helpers
Message-ID: <20251029183306.0000485c@huawei.com>
In-Reply-To: <20251027095602.1154418-7-aneesh.kumar@kernel.org>
References: <20251027095602.1154418-1-aneesh.kumar@kernel.org>
	<20251027095602.1154418-7-aneesh.kumar@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Mon, 27 Oct 2025 15:25:56 +0530
"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> wrote:

> - add SMCCC IDs/wrappers for RMI_PDEV_COMMUNICATE/RMI_PDEV_ABORT
> - describe the RMM device-communication ABI (struct rmi_dev_comm_*,
>   cache flags, protocol/object IDs, busy error code)
> - track per-PF0 communication state (buffers, workqueue, cache metadata) and
>   serialize access behind object_lock
> - plumb a DOE/SPDM worker (pdev_communicate_work) plus shared helpers that
>   submit the SMCCC call, cache multi-part responses, and handle retries/abort
> - hook the new helpers into the physical function connect path so IDE
>   setup can drive the device to the expected state
> 
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

Hi Aneesh,

Comments inline.

> diff --git a/drivers/virt/coco/arm-cca-host/rmi-da.c b/drivers/virt/coco/arm-cca-host/rmi-da.c
> index 390b8f05c7cf..592abe0dd252 100644
> --- a/drivers/virt/coco/arm-cca-host/rmi-da.c
> +++ b/drivers/virt/coco/arm-cca-host/rmi-da.c

> +
> +static int doe_send_req_resp(struct pci_tsm *tsm)
> +{
> +	int ret, data_obj_type;
> +	struct cca_host_comm_data *comm_data = to_cca_comm_data(tsm->pdev);
> +	struct rmi_dev_comm_exit *io_exit = &comm_data->io_params->exit;
> +	u8 protocol = io_exit->protocol;
> +
> +	if (protocol == RMI_PROTOCOL_SPDM)
> +		data_obj_type = PCI_DOE_FEATURE_CMA;
> +	else if (protocol == RMI_PROTOCOL_SECURE_SPDM)
> +		data_obj_type = PCI_DOE_FEATURE_SSESSION;
> +	else
> +		return -EINVAL;
> +
> +	/* delay the send */
> +	if (io_exit->req_delay)
> +		fsleep(io_exit->req_delay);
> +
> +	ret = pci_tsm_doe_transfer(tsm->dsm_dev, data_obj_type,
> +				   comm_data->req_buff, io_exit->req_len,
> +				   comm_data->rsp_buff, PAGE_SIZE);
> +	return ret;

	return pci_tsm_doe_transfer()

> +}
> +
> +static inline bool pending_dev_communicate(struct rmi_dev_comm_exit *io_exit)
> +{
> +	bool pending = io_exit->flags & (RMI_DEV_COMM_EXIT_CACHE_REQ |
> +					 RMI_DEV_COMM_EXIT_CACHE_RSP |
> +					 RMI_DEV_COMM_EXIT_SEND |
> +					 RMI_DEV_COMM_EXIT_WAIT |
> +					 RMI_DEV_COMM_EXIT_MULTI);
> +	return pending;
> +}
> +
> +static int ___do_dev_communicate(enum dev_comm_type type, struct pci_tsm *tsm)
> +{
> +	int ret, nbytes, cp_len;
> +	struct cache_object **cache_objp, *cache_obj;
> +	struct cca_host_pf0_dsc *pf0_dsc = to_cca_pf0_dsc(tsm->dsm_dev);
> +	struct cca_host_comm_data *comm_data = to_cca_comm_data(tsm->pdev);
> +	struct rmi_dev_comm_enter *io_enter = &comm_data->io_params->enter;
> +	struct rmi_dev_comm_exit *io_exit = &comm_data->io_params->exit;
> +
> +redo_communicate:
> +
> +	if (type == PDEV_COMMUNICATE)
> +		ret = rmi_pdev_communicate(virt_to_phys(pf0_dsc->rmm_pdev),
> +					   virt_to_phys(comm_data->io_params));
> +	else
> +		ret = RMI_ERROR_INPUT;

Treat this separately for simpler code (assuming you don't have other code that
makes this more complex in later patches).

	if (type != PDEV_COMMUNICATE)
		return -ENXIO;

	ret = rmi_pdev_communicate(virt_to_phys(pf0_dsc->rmm_pdev),
				   virt_to_phys(comm_data->io_params));
	if (ret != RMI...

> +	if (ret != RMI_SUCCESS) {
> +		if (ret == RMI_BUSY)
> +			return -EBUSY;
> +		return -ENXIO;
> +	}
> +
> +	if (io_exit->flags & RMI_DEV_COMM_EXIT_CACHE_REQ ||
> +	    io_exit->flags & RMI_DEV_COMM_EXIT_CACHE_RSP) {
> +
> +		switch (io_exit->cache_obj_id) {
> +		case RMI_DEV_VCA:
> +			cache_objp = &pf0_dsc->vca;
> +			break;
> +		case RMI_DEV_CERTIFICATE:
> +			cache_objp = &pf0_dsc->cert_chain.cache;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +		cache_obj = *cache_objp;
> +	}
> +
> +	if (io_exit->flags & RMI_DEV_COMM_EXIT_CACHE_REQ)
> +		cp_len = io_exit->req_cache_len;
> +	else
> +		cp_len = io_exit->rsp_cache_len;
> +
> +	/* response and request len should be <= SZ_4k */
> +	if (cp_len > CACHE_CHUNK_SIZE)
> +		return -EINVAL;
> +
> +	if (io_exit->flags & RMI_DEV_COMM_EXIT_CACHE_REQ ||
> +	    io_exit->flags & RMI_DEV_COMM_EXIT_CACHE_RSP) {
> +		int cache_remaining;
> +		struct cache_object *new_obj;
> +
> +		/* new allocation */
> +		if (!cache_obj) {
> +			cache_obj = kvmalloc(struct_size(cache_obj, buf, CACHE_CHUNK_SIZE),
> +					     GFP_KERNEL);
> +			if (!cache_obj)
> +				return -ENOMEM;
> +
> +			cache_obj->size = CACHE_CHUNK_SIZE;
> +			cache_obj->offset = 0;
> +			*cache_objp = cache_obj;
> +		}
> +
> +		cache_remaining = cache_obj->size - cache_obj->offset;
> +		if (cp_len > cache_remaining) {
> +
> +			if (cache_obj->size + CACHE_CHUNK_SIZE > MAX_CACHE_OBJ_SIZE)
> +				return -EINVAL;
> +
> +			new_obj = kvmalloc(struct_size(cache_obj, buf,
> +						       cache_obj->size + CACHE_CHUNK_SIZE),
> +					   GFP_KERNEL);

Is kvrealloc()? Would avoid need for explicit memcpy / freeing of old object.

> +			if (!new_obj)
> +				return -ENOMEM;
> +			memcpy(new_obj, cache_obj, struct_size(cache_obj, buf, cache_obj->size));
> +			new_obj->size = cache_obj->size + CACHE_CHUNK_SIZE;
> +			*cache_objp = new_obj;
> +			kvfree(cache_obj);
> +		}
> +
> +		/* cache object can change above. */
> +		cache_obj = *cache_objp;
> +	}
> +
> +
> +	if (io_exit->flags & RMI_DEV_COMM_EXIT_CACHE_REQ) {
> +		memcpy(cache_obj->buf + cache_obj->offset,
> +		       (comm_data->req_buff + io_exit->req_cache_offset), io_exit->req_cache_len);
> +		cache_obj->offset += io_exit->req_cache_len;
> +	}
> +
> +	if (io_exit->flags & RMI_DEV_COMM_EXIT_CACHE_RSP) {
> +		memcpy(cache_obj->buf + cache_obj->offset,
> +		       (comm_data->rsp_buff + io_exit->rsp_cache_offset), io_exit->rsp_cache_len);
> +		cache_obj->offset += io_exit->rsp_cache_len;
> +	}
> +
> +	/*
> +	 * wait for last packet request from RMM.
> +	 * We should not find this because our device communication is synchronous
> +	 */
> +	if (io_exit->flags & RMI_DEV_COMM_EXIT_WAIT)
> +		return -ENXIO;
> +
> +	/* next packet to send */
> +	if (io_exit->flags & RMI_DEV_COMM_EXIT_SEND) {
> +		nbytes = doe_send_req_resp(tsm);
> +		if (nbytes < 0) {
> +			/* report error back to RMM */
> +			io_enter->status = RMI_DEV_COMM_ERROR;
> +		} else {
> +			/* send response back to RMM */
> +			io_enter->resp_len = nbytes;
> +			io_enter->status = RMI_DEV_COMM_RESPONSE;
> +		}
> +	} else {
> +		/* no data transmitted => no data received */
> +		io_enter->resp_len = 0;
> +		io_enter->status = RMI_DEV_COMM_NONE;
> +	}
> +
> +	if (pending_dev_communicate(io_exit))
> +		goto redo_communicate;
> +
> +	return 0;
> +}
> +
> +static int __do_dev_communicate(enum dev_comm_type type,
> +				struct pci_tsm *tsm, unsigned long error_state)
> +{
> +	int ret;
> +	int state;
> +	struct rmi_dev_comm_enter *io_enter;
> +	struct cca_host_pf0_dsc *pf0_dsc = to_cca_pf0_dsc(tsm->dsm_dev);
> +
> +	io_enter = &pf0_dsc->comm_data.io_params->enter;
> +	io_enter->resp_len = 0;
> +	io_enter->status = RMI_DEV_COMM_NONE;
> +
> +	ret = ___do_dev_communicate(type, tsm);

Think up a more meaningful name.  Counting _ doesn't make for readable code.

> +	if (ret) {
> +		if (type == PDEV_COMMUNICATE)
> +			rmi_pdev_abort(virt_to_phys(pf0_dsc->rmm_pdev));
> +
> +		state = error_state;
> +	} else {
> +		/*
> +		 * Some device communication error will transition the
> +		 * device to error state. Report that.
> +		 */
> +		if (type == PDEV_COMMUNICATE)
> +			ret = rmi_pdev_get_state(virt_to_phys(pf0_dsc->rmm_pdev),
> +						 (enum rmi_pdev_state *)&state);
> +		if (ret)
> +			state = error_state;
Whilst not strictly needed I'd do this as:

		if (type == PDEV_COMMUNICATE) {
			ret = rmi_pdev_get_state(virt_to_phys(pf0_dsc->rmm_pdev),
						 (enum rmi_pdev_state *)&state);
			if (ret)
				state = error_state;
		}

Just to make it clear that reg check is just on the output of the call above.
If we didn't make that call it is definitely zero but nice not to have
to reason about it.


> +	}
> +
> +	if (state == error_state)
> +		pci_err(tsm->pdev, "device communication error\n");
> +
> +	return state;
> +}
> +
> +static int do_dev_communicate(enum dev_comm_type type, struct pci_tsm *tsm,
> +			      unsigned long target_state,
> +			      unsigned long error_state)
> +{
> +	int state;
> +
> +	do {
> +		state = __do_dev_communicate(type, tsm, error_state);
> +
> +		if (state == target_state || state == error_state)
> +			break;

Might as well return rather than break;

> +	} while (1);
> +
> +	return state;
> +}

> +void pdev_communicate_work(struct work_struct *work)
> +{
> +	unsigned long state;
> +	struct pci_tsm *tsm;
> +	struct dev_comm_work *setup_work;
> +	struct cca_host_pf0_dsc *pf0_dsc;
> +
> +	setup_work = container_of(work, struct dev_comm_work, work);
> +	tsm = setup_work->tsm;
> +	pf0_dsc = to_cca_pf0_dsc(tsm->dsm_dev);
Could combine these 3 with declarations for shorter code without much
change to readability.

> +
> +	guard(mutex)(&pf0_dsc->object_lock);
> +	state = do_pdev_communicate(tsm, setup_work->target_state);
> +	WARN_ON(state != setup_work->target_state);
> +
> +	complete(&setup_work->complete);
> +}


> diff --git a/drivers/virt/coco/arm-cca-host/rmi-da.h b/drivers/virt/coco/arm-cca-host/rmi-da.h
> index 6764bf8d98ce..1d513e0b74d9 100644
> --- a/drivers/virt/coco/arm-cca-host/rmi-da.h
> +++ b/drivers/virt/coco/arm-cca-host/rmi-da.h

> +struct cca_host_comm_data {
> +	void *rsp_buff;
> +	void *req_buff;
> +	struct rmi_dev_comm_data *io_params;
> +	/*
> +	 * Only one device communication request can be active at

wrap comments to 80 chars. This is around 70ish

> +	 * a time. This limitation comes from using the DOE mailbox
> +	 * at the pdev level. Requests such as get_measurements may
> +	 * span multiple mailbox messages, which must not be
> +	 * interleaved with other SPDM requests.
> +	 */
> +	struct workqueue_struct *work_queue;
> +};
> +
>  /* dsc = device security context */
>  struct cca_host_pf0_dsc {
> +	struct cca_host_comm_data comm_data;
>  	struct pci_tsm_pf0 pci;
>  	struct pci_ide *sel_stream;
>  
>  	void *rmm_pdev;
>  	int num_aux;
>  	void *aux[MAX_PDEV_AUX_GRANULES];
> +
> +	struct mutex object_lock;
> +	struct {
> +		struct cache_object *cache;
> +
> +		void *public_key;
> +		size_t public_key_size;
> +
> +		bool valid;
> +	} cert_chain;
> +	struct cache_object *vca;

There are a enough slightly non obvious things in here like
this vca that I think this structure would benefit from full kernel-doc.

>  };




